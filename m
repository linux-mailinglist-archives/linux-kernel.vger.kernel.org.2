Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B8B321BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhBVPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhBVPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:46:59 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DDFC061574;
        Mon, 22 Feb 2021 07:46:17 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id f26so3055983oog.5;
        Mon, 22 Feb 2021 07:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vHkq8WDTCU+eTW+Y+ogXk/LjXUPfvpkd05kCTtdlmLw=;
        b=KOO32uLaiXzFh0O2LFZ9bBgNrS6MwjmBM0YFq+L6jlki8ag/VzPUdSNECSrbAKH0JB
         mz8wg9sJNZ4GzG9Yi62+1CkS8ZG0obC+xiQh5PzjZnlFHEmvnGf+q9Yqh8uY3gdQCivP
         iwkahzfXOiyj1vU3+1AWSHAdqlW3aamaOnodqMcnp0Rf982swQyJOGCfRbxVEpNyL2B4
         kFpE6doy47DwJHpfvoxXoi76tPL9djiTImEXQBO7Y5uG/80POF5PcjsJSrHcHlJckDkC
         U02k1p59IRmdBesZx4P+R/l95TcuOlQObI1YGR/lt2OfsabrLZ+kPU0uIYDLKD9l3KCB
         3QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vHkq8WDTCU+eTW+Y+ogXk/LjXUPfvpkd05kCTtdlmLw=;
        b=q6O6aQ5yOAarzlDM4FlaIrGnoHcIEmr+TTr2YpTqF/jbPg7MV2QjleiGCQHUl2RkOe
         shXIVO03SCJx3pvbOPwBiSNnMnruP8SKZWRXSUXtIUK/xwN2mRp2iKD/e41AtcX6euBj
         qh2ktD3NCjv01QaHmM7Qo65Ti+kG35G1kqa7Gdx5fGI/G8efJ7lfYMbjnpTPVZ7KpmoH
         s3ph/1qdy/r5J1U8awGN7pc0qHoH6ZKuoC/gnq/Sdde3ApF0XJFEfIAdvB7Zkx88/vYc
         DGueVoTZDxbrSCU76EViL9DQ1c6N6H1roqUVigTj0QXuPSzUVpwjWnEEwAXwkhSpLXWW
         ps9A==
X-Gm-Message-State: AOAM532S8GNd9cFQonp4AFEApPvV1i9xMiYXtvdXIG7urdK7siXxLqkD
        cHYHwfI12u32TwZIrjxnSLUjLMMq3MY=
X-Google-Smtp-Source: ABdhPJzGDRnpcu79XSRPB9s+HHOD9MqU/9UDnsuQzlpngq4xlKIz6lGVkTWhGS375SrH8+UBWcVxbw==
X-Received: by 2002:a4a:ab08:: with SMTP id i8mr16739312oon.40.1614008776621;
        Mon, 22 Feb 2021 07:46:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 88sm3701594oto.3.2021.02.22.07.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 07:46:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 11/20] hwmon: Manual replacement of the deprecated
 strlcpy() with return values
To:     Romain Perier <romain.perier@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210222151231.22572-1-romain.perier@gmail.com>
 <20210222151231.22572-12-romain.perier@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <3b8dd556-8c09-9686-dec6-9d523a9762a8@roeck-us.net>
Date:   Mon, 22 Feb 2021 07:46:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222151231.22572-12-romain.perier@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/21 7:12 AM, Romain Perier wrote:
> The strlcpy() reads the entire source buffer first, it is dangerous if
> the source buffer lenght is unbounded or possibility non NULL-terminated.

length

> It can lead to linear read overflows, crashes, etc...
> 
Not here. This description is misleading.

> As recommended in the deprecated interfaces [1], it should be replaced
> by strscpy.
> 
> This commit replaces all calls to strlcpy that handle the return values
> by the corresponding strscpy calls with new handling of the return
> values (as it is quite different between the two functions).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>

This patch just adds pain to injury, as the source 'buffers' are all fixed
strings and their length will never exceed the maximum buffer length.
I really don't see the point of using strscpy() in this situation.

> ---
>  drivers/hwmon/pmbus/max20730.c |   66 +++++++++++++++++++++--------------------

This patch only modifies a single driver and should be tagged as such.

>  1 file changed, 35 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
> index 9dd3dd79bc18..a384b57b7327 100644
> --- a/drivers/hwmon/pmbus/max20730.c
> +++ b/drivers/hwmon/pmbus/max20730.c
> @@ -107,7 +107,8 @@ struct max20730_debugfs_data {
>  static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>  				     size_t count, loff_t *ppos)
>  {
> -	int ret, len;
> +	int ret;
> +	ssize_t len;
>  	int *idxp = file->private_data;
>  	int idx = *idxp;
>  	struct max20730_debugfs_data *psu = to_psu(idxp, idx);
> @@ -148,13 +149,13 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>  			>> MAX20730_MFR_DEVSET1_TSTAT_BIT_POS;
>  
>  		if (val == 0)
> -			len = strlcpy(tbuf, "2000\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "2000\n", DEBUG_FS_DATA_MAX);
>  		else if (val == 1)
> -			len = strlcpy(tbuf, "125\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "125\n", DEBUG_FS_DATA_MAX);
>  		else if (val == 2)
> -			len = strlcpy(tbuf, "62.5\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "62.5\n", DEBUG_FS_DATA_MAX);
>  		else
> -			len = strlcpy(tbuf, "32\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "32\n", DEBUG_FS_DATA_MAX);
>  		break;
>  	case MAX20730_DEBUGFS_INTERNAL_GAIN:
>  		val = (data->mfr_devset1 & MAX20730_MFR_DEVSET1_RGAIN_MASK)
> @@ -163,35 +164,35 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>  		if (data->id == max20734) {
>  			/* AN6209 */
>  			if (val == 0)
> -				len = strlcpy(tbuf, "0.8\n", DEBUG_FS_DATA_MAX);
> +				len = strscpy(tbuf, "0.8\n", DEBUG_FS_DATA_MAX);
>  			else if (val == 1)
> -				len = strlcpy(tbuf, "3.2\n", DEBUG_FS_DATA_MAX);
> +				len = strscpy(tbuf, "3.2\n", DEBUG_FS_DATA_MAX);
>  			else if (val == 2)
> -				len = strlcpy(tbuf, "1.6\n", DEBUG_FS_DATA_MAX);
> +				len = strscpy(tbuf, "1.6\n", DEBUG_FS_DATA_MAX);
>  			else
> -				len = strlcpy(tbuf, "6.4\n", DEBUG_FS_DATA_MAX);
> +				len = strscpy(tbuf, "6.4\n", DEBUG_FS_DATA_MAX);
>  		} else if (data->id == max20730 || data->id == max20710) {
>  			/* AN6042 or AN6140 */
>  			if (val == 0)
> -				len = strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
> +				len = strscpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
>  			else if (val == 1)
> -				len = strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
> +				len = strscpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
>  			else if (val == 2)
> -				len = strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
> +				len = strscpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
>  			else
> -				len = strlcpy(tbuf, "7.2\n", DEBUG_FS_DATA_MAX);
> +				len = strscpy(tbuf, "7.2\n", DEBUG_FS_DATA_MAX);
>  		} else if (data->id == max20743) {
>  			/* AN6042 */
>  			if (val == 0)
> -				len = strlcpy(tbuf, "0.45\n", DEBUG_FS_DATA_MAX);
> +				len = strscpy(tbuf, "0.45\n", DEBUG_FS_DATA_MAX);
>  			else if (val == 1)
> -				len = strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
> +				len = strscpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
>  			else if (val == 2)
> -				len = strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
> +				len = strscpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
>  			else
> -				len = strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
> +				len = strscpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
>  		} else {
> -			len = strlcpy(tbuf, "Not supported\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "Not supported\n", DEBUG_FS_DATA_MAX);
>  		}
>  		break;
>  	case MAX20730_DEBUGFS_BOOT_VOLTAGE:
> @@ -199,26 +200,26 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>  			>> MAX20730_MFR_DEVSET1_VBOOT_BIT_POS;
>  
>  		if (val == 0)
> -			len = strlcpy(tbuf, "0.6484\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "0.6484\n", DEBUG_FS_DATA_MAX);
>  		else if (val == 1)
> -			len = strlcpy(tbuf, "0.8984\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "0.8984\n", DEBUG_FS_DATA_MAX);
>  		else if (val == 2)
> -			len = strlcpy(tbuf, "1.0\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "1.0\n", DEBUG_FS_DATA_MAX);
>  		else
> -			len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
>  		break;
>  	case MAX20730_DEBUGFS_OUT_V_RAMP_RATE:
>  		val = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_VRATE)
>  			>> MAX20730_MFR_DEVSET2_VRATE_BIT_POS;
>  
>  		if (val == 0)
> -			len = strlcpy(tbuf, "4\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "4\n", DEBUG_FS_DATA_MAX);
>  		else if (val == 1)
> -			len = strlcpy(tbuf, "2\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "2\n", DEBUG_FS_DATA_MAX);
>  		else if (val == 2)
> -			len = strlcpy(tbuf, "1\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "1\n", DEBUG_FS_DATA_MAX);
>  		else
> -			len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
>  		break;
>  	case MAX20730_DEBUGFS_OC_PROTECT_MODE:
>  		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_OCPM_MASK)
> @@ -230,13 +231,13 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>  			>> MAX20730_MFR_DEVSET2_SS_BIT_POS;
>  
>  		if (val == 0)
> -			len = strlcpy(tbuf, "0.75\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "0.75\n", DEBUG_FS_DATA_MAX);
>  		else if (val == 1)
> -			len = strlcpy(tbuf, "1.5\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "1.5\n", DEBUG_FS_DATA_MAX);
>  		else if (val == 2)
> -			len = strlcpy(tbuf, "3\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "3\n", DEBUG_FS_DATA_MAX);
>  		else
> -			len = strlcpy(tbuf, "6\n", DEBUG_FS_DATA_MAX);
> +			len = strscpy(tbuf, "6\n", DEBUG_FS_DATA_MAX);
>  		break;
>  	case MAX20730_DEBUGFS_IMAX:
>  		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_IMAX_MASK)
> @@ -287,9 +288,12 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>  				"%d.%d\n", ret / 10000, ret % 10000);
>  		break;
>  	default:
> -		len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
> +		len = strscpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
>  	}
>  
> +	if (len == -E2BIG)
> +		return -E2BIG;
> +
>  	return simple_read_from_buffer(buf, count, ppos, tbuf, len);
>  }
>  
> 

