Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B185422948
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhJEN57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbhJEN5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:57:15 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B3DC06136F;
        Tue,  5 Oct 2021 06:52:08 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so25901078otj.2;
        Tue, 05 Oct 2021 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OoiLFDDmp8NkpUfW9xFGT5Y2lvp+YpCHATtTBrPwUdU=;
        b=oB6JIQ9SHf1bMAsRXE1UBQC6V7b/V9g+b9earx+1YeREVz5MpvKftL/PD0BdlMo1bE
         tkjdyL9A/0vipoNaV4vNBhKXXTmNvHgL0C1yLzDMxVdOMH1UwdF7klTZERd8Vp2CzG42
         4wQDIcawAMRjXEvfjdClqqXSXP2YMtBZznLYJ0buw0E2LMvhEcrJLeMoy7juZsyMp4Ty
         MZ8rvXceM3P6m/I2jg4Ma188QUo3l1ryflFbx5xbnykVutgFYJzWB1wgf8IiR9NTD/7R
         DARZ7GcWlsCPeF0CEsAPDpvp6p/lka6qnI5RhuS6nOQC2l5kJKv9oW7pm9E1kv3iapVf
         PLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OoiLFDDmp8NkpUfW9xFGT5Y2lvp+YpCHATtTBrPwUdU=;
        b=Re2GSyPvbjRlyd4ya7YgZU19CH2Qm6iO/v4JFx101q+DlO7AuUIKmRFCafck/060bl
         HJN8sOVACGexSYKgRZfmvau6elbwvPS6btF43NYfiXZnvbvWpQLqWzN3Yu4Bhjy1mKTc
         5Ey4pZqBYPmMONk404ur/9zeqign5Ayc4ij/Hp0h/jeEvnlKkJhKQhMFFy/0ZNSGSjTu
         89gBh3KmlEC5rs2ZSv+e3kh9epZe90unsLqU4JOsFElYQUpTBVrC1/xONLJJvDurcfSd
         hVqRYlafuFcWvzK+Cz0VCguTsrJxDdx8mGVngrGlIhim9YnaLElA747ecqKS/4+8lBIU
         spiA==
X-Gm-Message-State: AOAM533OvHK38q1dzDfgPgEZqZk5sGU6ontscMOJug7+aX3Kbs2YjGCr
        OYtMngmrd3HjkYyYx98Wa582cmCRcyM=
X-Google-Smtp-Source: ABdhPJyD0XbP8756mmqBofhtX4m/y+BHK9t1qsmxPNYVIidCcMlCDEl+nBvfzdwgA5KuyYj47RbzDQ==
X-Received: by 2002:a05:6830:204d:: with SMTP id f13mr14159279otp.123.1633441927379;
        Tue, 05 Oct 2021 06:52:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 65sm3545534otd.81.2021.10.05.06.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:52:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 5 Oct 2021 06:52:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Kamil Pietrzak <kpietrzak@disroot.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Use custom scale for ASUS
 motherboards.
Message-ID: <20211005135204.GA1924024@roeck-us.net>
References: <20211002210857.709956-1-pauk.denis@gmail.com>
 <20211002210857.709956-3-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211002210857.709956-3-pauk.denis@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 12:08:55AM +0300, Denis Pauk wrote:
> Use custom scaling factor for:
> * TUF GAMING Z490-PLUS
> * TUF GAMING Z490-PLUS (WI-FI)
> 
> Voltage scaling factors are based on Asus software on Windows.
> 

Scaling is never correct for any SuperIO chips, and is notoriously different
for each and every PC board. I don't want to add per-board scaling data to
the kernel drivers for those chips. This would just create an unsupportable
mess.

Guenter

> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Tested-by: Kamil Pietrzak <kpietrzak@disroot.org>
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/nct6775.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index 8eaf86ea2433..ba18c1cbf572 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -140,6 +140,7 @@ struct nct6775_sio_data {
>  	int ld;
>  	enum kinds kind;
>  	enum sensor_access access;
> +	bool custom_scale;
>  
>  	/* superio_() callbacks  */
>  	void (*sio_outb)(struct nct6775_sio_data *sio_data, int reg, int val);
> @@ -1159,14 +1160,19 @@ static const u16 scale_in[15] = {
>  	800, 800
>  };
>  
> -static inline long in_from_reg(u8 reg, u8 nr)
> +static const u16 scale_in_z490[15] = {
> +	888, 4000, 1600, 1600, 9600, 800, 800, 1600, 1600, 1600, 1600, 1600, 800,
> +	800, 800
> +};
> +
> +static inline long in_from_reg(u8 reg, u8 nr, const u16 *scale)
>  {
> -	return DIV_ROUND_CLOSEST(reg * scale_in[nr], 100);
> +	return DIV_ROUND_CLOSEST(reg * scale[nr], 100);
>  }
>  
> -static inline u8 in_to_reg(u32 val, u8 nr)
> +static inline u8 in_to_reg(u32 val, u8 nr, const u16 *scale)
>  {
> -	return clamp_val(DIV_ROUND_CLOSEST(val * 100, scale_in[nr]), 0, 255);
> +	return clamp_val(DIV_ROUND_CLOSEST(val * 100, scale[nr]), 0, 255);
>  }
>  
>  /*
> @@ -1323,6 +1329,9 @@ struct nct6775_data {
>  	u8 fandiv2;
>  	u8 sio_reg_enable;
>  
> +	/* voltage scaling factors */
> +	const u16 *scale;
> +
>  	/* nct6775_*() callbacks  */
>  	u16 (*read_value)(struct nct6775_data *data, u16 reg);
>  	int (*write_value)(struct nct6775_data *data, u16 reg, u16 value);
> @@ -2026,7 +2035,7 @@ show_in_reg(struct device *dev, struct device_attribute *attr, char *buf)
>  	int index = sattr->index;
>  	int nr = sattr->nr;
>  
> -	return sprintf(buf, "%ld\n", in_from_reg(data->in[nr][index], nr));
> +	return sprintf(buf, "%ld\n", in_from_reg(data->in[nr][index], nr, data->scale));
>  }
>  
>  static ssize_t
> @@ -2044,7 +2053,7 @@ store_in_reg(struct device *dev, struct device_attribute *attr, const char *buf,
>  	if (err < 0)
>  		return err;
>  	mutex_lock(&data->update_lock);
> -	data->in[nr][index] = in_to_reg(val, nr);
> +	data->in[nr][index] = in_to_reg(val, nr, data->scale);
>  	data->write_value(data, data->REG_IN_MINMAX[index - 1][nr],
>  			  data->in[nr][index]);
>  	mutex_unlock(&data->update_lock);
> @@ -3980,6 +3989,11 @@ static int nct6775_probe(struct platform_device *pdev)
>  		data->write_value = nct6775_wmi_write_value;
>  	}
>  
> +	if (sio_data->custom_scale)
> +		data->scale = scale_in_z490;
> +	else
> +		data->scale = scale_in;
> +
>  	mutex_init(&data->update_lock);
>  	data->name = nct6775_device_names[data->kind];
>  	data->bank = 0xff;		/* Force initial bank selection */
> @@ -5020,6 +5034,7 @@ static int __init sensors_nct6775_init(void)
>  	struct nct6775_sio_data sio_data;
>  	int sioaddr[2] = { 0x2e, 0x4e };
>  	enum sensor_access access = access_direct;
> +	bool custom_scale = false;
>  	const char *board_vendor, *board_name;
>  	u8 tmp;
>  
> @@ -5043,6 +5058,10 @@ static int __init sensors_nct6775_init(void)
>  				pr_err("Can't read ChipID by Asus WMI.\n");
>  			}
>  		}
> +
> +		if (strcmp(board_name, "TUF GAMING Z490-PLUS") == 0 ||
> +		    strcmp(board_name, "TUF GAMING Z490-PLUS (WI-FI)") == 0)
> +			custom_scale = true;
>  	}
>  
>  	/*
> @@ -5066,6 +5085,7 @@ static int __init sensors_nct6775_init(void)
>  		found = true;
>  
>  		sio_data.access = access;
> +		sio_data.custom_scale = custom_scale;
>  
>  		if (access == access_asuswmi) {
>  			sio_data.sio_outb = superio_wmi_outb;
> -- 
> 2.33.0
> 
