module output_mod
    use io_routines, only : io_write
    use data_structures
    use string, only : str
    
    implicit none
contains
    subroutine write_output(output, options)
        implicit none
        type(config),  intent(in)   :: options
        type(results), intent(in)   :: output
        character(len=MAXFILELENGTH):: filename
        integer :: nvars, i
        
        nvars = size(output%variables)
        
        do i=1,nvars
            
            filename = trim(output%variables(i)%name)//"_"//trim(options%output_file)
            call io_write(filename, "data", output%variables(i)%data)
            
            filename = trim(output%variables(i)%name)//"_errors_"//trim(options%output_file)
            call io_write(filename, "data", output%variables(i)%errors)

            if (options%logistic_threshold/=kFILL_VALUE) then
                filename = trim(output%variables(i)%name)//"_logistic_"//trim(options%output_file)
                call io_write(filename, "data", output%variables(i)%logistic)
            endif

            if (options%debug) then
                filename = trim(output%variables(i)%name)//"_predictors_"//trim(options%output_file)
                call io_write(filename, "data", output%variables(i)%predictors)

                filename = trim(output%variables(i)%name)//"_obs_"//trim(options%output_file)
                call io_write(filename, "data", output%variables(i)%obs)

                filename = trim(output%variables(i)%name)//"_training_"//trim(options%output_file)
                call io_write(filename, "data", output%variables(i)%training)
                
                filename = trim(output%variables(i)%name)//"_coef_"//trim(options%output_file)
                call io_write(filename, "data", output%variables(i)%coefficients)
            endif
        enddo
        
    end subroutine write_output

end module output_mod
