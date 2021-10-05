Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D266F42233F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhJEKZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhJEKZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:25:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6B0A61371;
        Tue,  5 Oct 2021 10:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633429406;
        bh=UHHKxgZhMV92vmOVWIzkFjwvSbLOsAhv9dRJtUUkrOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wIuf2BPZkhR69dHWBglmKT+ZwKR39OcLTpcxyvPsm6t+jLCdLLciiSbBFpJ3GSRlW
         ydWP9NVlYdGMveuzzD74tX3K5z/IFyKF+9xWvznOhV4yjZFLp/Rcwk8d2gTM/NUUFM
         rmsVzZCuXLt3ZmYiqy0Vtja1i8h1uq3bl+d9qgr8=
Date:   Tue, 5 Oct 2021 12:23:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: print rf69 debug message more detail
Message-ID: <YVwnm+io6ZiX/Ovl@kroah.com>
References: <20210929152611.17998-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929152611.17998-1-realwakka@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 04:26:11PM +0100, Sidong Yang wrote:
> When pi433 failed for rf69 configuration, Debug message should help for
> finding which value is incorrect. But it's hard to know because it just
> prints "illegal value". This patch make print message more detail.
> ---
>  drivers/staging/pi433/rf69.c | 38 ++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
> index 7d86bb8be245..dc047bcdf44b 100644
> --- a/drivers/staging/pi433/rf69.c
> +++ b/drivers/staging/pi433/rf69.c
> @@ -113,7 +113,7 @@ int rf69_set_mode(struct spi_device *spi, enum mode mode)
>  	};
>  
>  	if (unlikely(mode >= ARRAY_SIZE(mode_map))) {
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal mode %u", mode);
>  		return -EINVAL;
>  	}
>  
> @@ -143,7 +143,7 @@ int rf69_set_modulation(struct spi_device *spi, enum modulation modulation)
>  	};
>  
>  	if (unlikely(modulation >= ARRAY_SIZE(modulation_map))) {
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal modulation %u", modulation);
>  		return -EINVAL;
>  	}
>  
> @@ -191,7 +191,7 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
>  						   MASK_DATAMODUL_MODULATION_SHAPE,
>  						   DATAMODUL_MODULATION_SHAPE_0_3);
>  		default:
> -			dev_dbg(&spi->dev, "set: illegal input param");
> +			dev_dbg(&spi->dev, "set: illegal mod shaping for FSK %u", mod_shaping);
>  			return -EINVAL;
>  		}
>  	case OOK:
> @@ -209,7 +209,7 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
>  						   MASK_DATAMODUL_MODULATION_SHAPE,
>  						   DATAMODUL_MODULATION_SHAPE_2BR);
>  		default:
> -			dev_dbg(&spi->dev, "set: illegal input param");
> +			dev_dbg(&spi->dev, "set: illegal mod shaping for OOK %u", mod_shaping);
>  			return -EINVAL;
>  		}
>  	default:
> @@ -392,7 +392,7 @@ int rf69_set_output_power_level(struct spi_device *spi, u8 power_level)
>  	return rf69_read_mod_write(spi, REG_PALEVEL, MASK_PALEVEL_OUTPUT_POWER,
>  				   power_level);
>  failed:
> -	dev_dbg(&spi->dev, "set: illegal input param");
> +	dev_dbg(&spi->dev, "set: illegal power level %u", power_level);
>  	return -EINVAL;
>  }
>  
> @@ -417,7 +417,7 @@ int rf69_set_pa_ramp(struct spi_device *spi, enum pa_ramp pa_ramp)
>  	};
>  
>  	if (unlikely(pa_ramp >= ARRAY_SIZE(pa_ramp_map))) {
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal pa_ramp %u", pa_ramp);
>  		return -EINVAL;
>  	}
>  
> @@ -433,7 +433,7 @@ int rf69_set_antenna_impedance(struct spi_device *spi,
>  	case two_hundred_ohm:
>  		return rf69_set_bit(spi, REG_LNA, MASK_LNA_ZIN);
>  	default:
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal antenna impedance %u", antenna_impedance);
>  		return -EINVAL;
>  	}
>  }
> @@ -451,7 +451,7 @@ int rf69_set_lna_gain(struct spi_device *spi, enum lna_gain lna_gain)
>  	};
>  
>  	if (unlikely(lna_gain >= ARRAY_SIZE(lna_gain_map))) {
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal lna gain %u", lna_gain);
>  		return -EINVAL;
>  	}
>  
> @@ -466,14 +466,14 @@ static int rf69_set_bandwidth_intern(struct spi_device *spi, u8 reg,
>  
>  	// check value for mantisse and exponent
>  	if (exponent > 7) {
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal bandwidth exponent %u", exponent);
>  		return -EINVAL;
>  	}
>  
>  	if ((mantisse != mantisse16) &&
>  	    (mantisse != mantisse20) &&
>  	    (mantisse != mantisse24)) {
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal bandwidth mantisse %u", mantisse);
>  		return -EINVAL;
>  	}
>  
> @@ -531,7 +531,7 @@ int rf69_set_ook_threshold_dec(struct spi_device *spi,
>  	};
>  
>  	if (unlikely(threshold_decrement >= ARRAY_SIZE(td_map))) {
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal OOK threshold decrement %u", threshold_decrement);
>  		return -EINVAL;
>  	}
>  
> @@ -578,7 +578,7 @@ int rf69_set_dio_mapping(struct spi_device *spi, u8 dio_number, u8 value)
>  		dio_addr = REG_DIOMAPPING2;
>  		break;
>  	default:
> -	dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal dio number %u", dio_number);
>  		return -EINVAL;
>  	}
>  
> @@ -681,7 +681,7 @@ int rf69_set_fifo_fill_condition(struct spi_device *spi,
>  		return rf69_clear_bit(spi, REG_SYNC_CONFIG,
>  				      MASK_SYNC_CONFIG_FIFO_FILL_CONDITION);
>  	default:
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal fifo fill condition %u", fifo_fill_condition);
>  		return -EINVAL;
>  	}
>  }
> @@ -690,7 +690,7 @@ int rf69_set_sync_size(struct spi_device *spi, u8 sync_size)
>  {
>  	// check input value
>  	if (sync_size > 0x07) {
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal sync size %u", sync_size);
>  		return -EINVAL;
>  	}
>  
> @@ -727,7 +727,7 @@ int rf69_set_packet_format(struct spi_device *spi,
>  		return rf69_clear_bit(spi, REG_PACKETCONFIG1,
>  				      MASK_PACKETCONFIG1_PACKET_FORMAT_VARIABLE);
>  	default:
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal packet format %u", packet_format);
>  		return -EINVAL;
>  	}
>  }
> @@ -753,7 +753,7 @@ int rf69_set_address_filtering(struct spi_device *spi,
>  	};
>  
>  	if (unlikely(address_filtering >= ARRAY_SIZE(af_map))) {
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal address filtering %u", address_filtering);
>  		return -EINVAL;
>  	}
>  
> @@ -788,7 +788,7 @@ int rf69_set_tx_start_condition(struct spi_device *spi,
>  		return rf69_set_bit(spi, REG_FIFO_THRESH,
>  				    MASK_FIFO_THRESH_TXSTART);
>  	default:
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal tx start condition %u", tx_start_condition);
>  		return -EINVAL;
>  	}
>  }
> @@ -799,7 +799,7 @@ int rf69_set_fifo_threshold(struct spi_device *spi, u8 threshold)
>  
>  	/* check input value */
>  	if (threshold & 0x80) {
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal fifo threshold %u", threshold);
>  		return -EINVAL;
>  	}
>  
> @@ -826,7 +826,7 @@ int rf69_set_dagc(struct spi_device *spi, enum dagc dagc)
>  	};
>  
>  	if (unlikely(dagc >= ARRAY_SIZE(dagc_map))) {
> -		dev_dbg(&spi->dev, "set: illegal input param");
> +		dev_dbg(&spi->dev, "set: illegal dagc %u", dagc);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.20.1
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
