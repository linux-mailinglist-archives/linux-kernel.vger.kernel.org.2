Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572FF39B7AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFDLOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:14:09 -0400
Received: from mail-qv1-f41.google.com ([209.85.219.41]:33560 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhFDLOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:14:08 -0400
Received: by mail-qv1-f41.google.com with SMTP id 5so4750543qvk.0;
        Fri, 04 Jun 2021 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B/xG+N/v7ICoipPZQIDZ5p2yVBVuZBINeWc/kBK4g+Q=;
        b=vdfsGKohglD1YFz7elJy/aa9z08Ifnip0E+YS/OvDEWE66uevtLFzil27sZitVZsBn
         cMhqSrYHGqJyJzC6rvsUiYfQ1hCDWPZB9a/vT7VzlJJUChLPhVw9MxcXzJ0x8SuwP7kB
         8GjcUdxkDkzSaZFKXg51sRtfoUGXPzY2+Cs8zjun9Q+tGQpepWfHpiRxWEIr+7KNBG0M
         77AcyDtzrr+NU8/5xPUs2WmcLlnSAUFcvzHWdP4MV90Shia83aMA2Nxe5/w19GAa8xBE
         2JaB2dXTMxgF6hgh6m7EvEeHqc/6ClnqxRcJlP8hvAbL4jMJQlMt3JN9ZZaYR2/hzX1x
         HEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=B/xG+N/v7ICoipPZQIDZ5p2yVBVuZBINeWc/kBK4g+Q=;
        b=nFzGxidKEHLIN4H0/bAhrs5/7LpL/Ma9baqP6XoV+p1ULv2cN5ijIEW+ItHlnuPTdq
         709OU3IL2a1LXFZPjhB+3Cd81PprT0rPxpfAeErWiX3bOZWkI4SP9IbTtCnaMSkOJrEN
         AIYCFacaHHCNu3kpHQ9nJJKh1j9Ks6b/c6pwd5tWOER1Z7c87hcqX5su/cMraW6bTSVy
         bYaQHxzjDL8rexwuUlL3+36EDs7oid5oGLgJTiRVTFSTajCJn7b4NAqpTGj+2RA77+Qy
         FSE6K0KqILx6IBGARBnxlSbeZrdXP5JBOqc2UCv/ZaYQsgAMXVSo2Qvy3RVbc8OOQtrc
         oGlA==
X-Gm-Message-State: AOAM533RXFKi4PrVGkAta7IY6KvORt2Z+QBDlwQUUOvs+gU97d+apJeY
        Qo1nP5KJoFY5ZjxAGv50yUw=
X-Google-Smtp-Source: ABdhPJzUazpfquzpptuo/Kh04x/CUMN5QoeglDjTPCDvgVeKcfDSgeWpuiJhgwD0wHr36HJ3ui8XWw==
X-Received: by 2002:a0c:d40a:: with SMTP id t10mr3929023qvh.19.1622805082245;
        Fri, 04 Jun 2021 04:11:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l20sm2457475qtx.53.2021.06.04.04.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 04:11:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 4 Jun 2021 04:11:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ninad Malwade <nmalwade@nvidia.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Bibek Basu <bbasu@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Rajkumar Kasirajan <rkasirajan@nvidia.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ina3221: use CVRF only for single-shot conversion
Message-ID: <20210604111120.GA1446736@roeck-us.net>
References: <1622789683-30931-1-git-send-email-nmalwade@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622789683-30931-1-git-send-email-nmalwade@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 02:54:43PM +0800, Ninad Malwade wrote:
> As per current logic the wait time per conversion is arouns 430ms
> for 512 samples and around 860ms for 1024 samples for 3 channels
> considering 140us as the bus voltage and shunt voltage sampling
> conversion time.
> 
> This waiting time is a lot for the continuous mode and even for
> the single shot mode. For continuous mode when moving average is
> considered the waiting for CVRF bit is not required and the data
> from the previous conversion is sufficuent. As mentioned in the
> datasheet the conversion ready bit is provided to help coordinate
> single-shot conversions, we can restrict the use to single-shot
> mode only.
> 
> Also, the conversion time is for the averaged samples, the wait
> time for the polling can omit the number of samples consideration.
> 
Makes sense. Applied.

Thanks,
Guenter

> Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
> ---
>  drivers/hwmon/ina3221.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index c602583..58d3828 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -196,13 +196,11 @@ static inline u32 ina3221_reg_to_interval_us(u16 config)
>  	u32 channels = hweight16(config & INA3221_CONFIG_CHs_EN_MASK);
>  	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(config);
>  	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(config);
> -	u32 samples_idx = INA3221_CONFIG_AVG(config);
> -	u32 samples = ina3221_avg_samples[samples_idx];
>  	u32 vbus_ct = ina3221_conv_time[vbus_ct_idx];
>  	u32 vsh_ct = ina3221_conv_time[vsh_ct_idx];
>  
>  	/* Calculate total conversion time */
> -	return channels * (vbus_ct + vsh_ct) * samples;
> +	return channels * (vbus_ct + vsh_ct);
>  }
>  
>  static inline int ina3221_wait_for_data(struct ina3221_data *ina)
> @@ -288,13 +286,14 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
>  			return -ENODATA;
>  
>  		/* Write CONFIG register to trigger a single-shot measurement */
> -		if (ina->single_shot)
> +		if (ina->single_shot) {
>  			regmap_write(ina->regmap, INA3221_CONFIG,
>  				     ina->reg_config);
>  
> -		ret = ina3221_wait_for_data(ina);
> -		if (ret)
> -			return ret;
> +			ret = ina3221_wait_for_data(ina);
> +			if (ret)
> +				return ret;
> +		}
>  
>  		ret = ina3221_read_value(ina, reg, &regval);
>  		if (ret)
> @@ -344,13 +343,14 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
>  			return -ENODATA;
>  
>  		/* Write CONFIG register to trigger a single-shot measurement */
> -		if (ina->single_shot)
> +		if (ina->single_shot) {
>  			regmap_write(ina->regmap, INA3221_CONFIG,
>  				     ina->reg_config);
>  
> -		ret = ina3221_wait_for_data(ina);
> -		if (ret)
> -			return ret;
> +			ret = ina3221_wait_for_data(ina);
> +			if (ret)
> +				return ret;
> +		}
>  
>  		fallthrough;
>  	case hwmon_curr_crit:
