Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDCA30E438
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhBCUtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhBCUqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:46:17 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB89C061573;
        Wed,  3 Feb 2021 12:44:07 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id d3so208518ool.7;
        Wed, 03 Feb 2021 12:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F00Pr4eI96W+kjuNb1lq/HlQiDzd19IAAA28dQujcBw=;
        b=d2JTLTHYNtnhKARJzADsZERVVmS05IW84ZJFeuRlIEvRV+KVVXcN4I/kEBK+O5agX0
         2mqQFqPsKkKJ2q+GG4lHcoes76PYK0kcE87uhB9G7SI4z7ddOahNFJ/W3qiPHhRBif4f
         v9SPeF5bw3ow17Fc/t38OKhHKc2VaaYV5UyyDOGxqmSPqrcjt2ltsACMXLsGIIZ7RELD
         xUrZVCnUq70AF2HhLHW0AnYWFBO79/ei5+t4jHgCv0SMmtJYZzAfIg9VJmfsRJybPdly
         j3an8MgU7JJtnZ4sd+Yq1Vt7mBlT0bfCNBcdP0b7XUWfbCs2JxLoi6gTUwk6oFIUOHa1
         IADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=F00Pr4eI96W+kjuNb1lq/HlQiDzd19IAAA28dQujcBw=;
        b=bWgUfYTxVXYFMdyHnpnhpb3Hzwt/5fvutZm31axKxTC+Sp+uX0jZyzj1Jp6Tdz2s3a
         +FxYj1GcsTU9mfxzDV7YUjdPvzE8PivM2mVndgF43efefNVPHyh1OmuQqqKlJ0C/mzjX
         Umhgca7dmoPyJXn6S7zKb7NaVajYYH7mzk7k6NcrKRHxvr2TBIICgyYe+qJJAimXaiXg
         HWVmkBo5/TT+BgC+br/hx3Vyoq8tAnX9tRXYzCh+8e3lQhGNqYJ6WzjzE9KCBqZMTzev
         I1Jjo9Ios99yQ94q6K8tsAprkpfRPUeiLMJealvmOXHrZ68ncZQ+u+NKYusAV1IeWCkD
         5j4w==
X-Gm-Message-State: AOAM531NLiIMtTNUcKTvuqIX5JdT5d56fhJtoNBeHHkjJxC5fQpn+Imb
        czhvTlC362dwdPMsAtoQh+HBCwToDkQ=
X-Google-Smtp-Source: ABdhPJykcpC8jNC5GAbu1nFy8AX4LJFCsBY/um+VwD7tZPewed3y6748/CmrGwmaiiz7fXkJ2jcxSg==
X-Received: by 2002:a4a:e6d2:: with SMTP id v18mr3299928oot.40.1612385047146;
        Wed, 03 Feb 2021 12:44:07 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n27sm699690oij.36.2021.02.03.12.44.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Feb 2021 12:44:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 3 Feb 2021 12:44:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (pmbus) convert sysfs sprintf/snprintf family
 to sysfs_emit
Message-ID: <20210203204405.GG106766@roeck-us.net>
References: <1612255743-52579-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612255743-52579-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 04:49:03PM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/hwmon/pmbus/inspur-ipsps.c:73:8-16: WARNING: use scnprintf or
> sprintf.
> 
> ./drivers/hwmon/pmbus/inspur-ipsps.c:114:9-17: WARNING: use scnprintf or
> sprintf.
> 
> ./drivers/hwmon/pmbus/inspur-ipsps.c:94:8-16: WARNING: use scnprintf or
> sprintf.
> 
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Please refrain from such changes. I'll accept them only if other changes
are made to the driver at the same time.

Guenter

> ---
> Changes in v2:
>   -Modified code space.
> 
>  drivers/hwmon/pmbus/inspur-ipsps.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/inspur-ipsps.c b/drivers/hwmon/pmbus/inspur-ipsps.c
> index 88c5865..bf593fd 100644
> --- a/drivers/hwmon/pmbus/inspur-ipsps.c
> +++ b/drivers/hwmon/pmbus/inspur-ipsps.c
> @@ -70,7 +70,7 @@ static ssize_t ipsps_string_show(struct device *dev,
>  	p = memscan(data, '#', rc);
>  	*p = '\0';
>  
> -	return snprintf(buf, PAGE_SIZE, "%s\n", data);
> +	return sysfs_emit(buf, "%s\n", data);
>  }
>  
>  static ssize_t ipsps_fw_version_show(struct device *dev,
> @@ -91,9 +91,9 @@ static ssize_t ipsps_fw_version_show(struct device *dev,
>  	if (rc != 6)
>  		return -EPROTO;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u.%02u%u-%u.%02u\n",
> -			data[1], data[2]/* < 100 */, data[3]/*< 10*/,
> -			data[4], data[5]/* < 100 */);
> +	return sysfs_emit(buf, "%u.%02u%u-%u.%02u\n",
> +			  data[1], data[2]/* < 100 */, data[3]/*< 10*/,
> +			  data[4], data[5]/* < 100 */);
>  }
>  
>  static ssize_t ipsps_mode_show(struct device *dev,
> @@ -111,19 +111,19 @@ static ssize_t ipsps_mode_show(struct device *dev,
>  
>  	switch (rc) {
>  	case MODE_ACTIVE:
> -		return snprintf(buf, PAGE_SIZE, "[%s] %s %s\n",
> -				MODE_ACTIVE_STRING,
> -				MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
> +		return sysfs_emit(buf, "[%s] %s %s\n",
> +				  MODE_ACTIVE_STRING,
> +				  MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
>  	case MODE_STANDBY:
> -		return snprintf(buf, PAGE_SIZE, "%s [%s] %s\n",
> -				MODE_ACTIVE_STRING,
> -				MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
> +		return sysfs_emit(buf, "%s [%s] %s\n",
> +				  MODE_ACTIVE_STRING,
> +				  MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
>  	case MODE_REDUNDANCY:
> -		return snprintf(buf, PAGE_SIZE, "%s %s [%s]\n",
> -				MODE_ACTIVE_STRING,
> -				MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
> +		return sysfs_emit(buf, "%s %s [%s]\n",
> +				  MODE_ACTIVE_STRING,
> +				  MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
>  	default:
> -		return snprintf(buf, PAGE_SIZE, "unspecified\n");
> +		return sysfs_emit(buf, "unspecified\n");
>  	}
>  }
>  
> -- 
> 1.8.3.1
> 
