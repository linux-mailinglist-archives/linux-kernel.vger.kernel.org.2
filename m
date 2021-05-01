Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8E7370544
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 06:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhEAESF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 00:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhEAESD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 00:18:03 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB84C06174A;
        Fri, 30 Apr 2021 21:17:05 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c36-20020a05683034a4b02902a5b84b1d12so17787otu.8;
        Fri, 30 Apr 2021 21:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TioPQGknrE8mOW5JK4a866RtUyCeNLERCGZbj3eKG4M=;
        b=S0NLPsH9fKpNUBl2/OSFwb2Q75VZM9HVOGfsx+q5/yyKAmKw+3P1AmjuCh8teYVYqz
         V45JRSgL3xCvUoG27GUhLND143K97I+skZ9RuVHII4tJ+D96QmjwvLMOTYQAfVWZqJwg
         67ddJy2QWGbsQGgOfCi90obZVNMgGW0nFHHPYJnBxqVWSU9WihlnHrNLcPsGIqaMjYIH
         dPk086R0gnoa9u992KOGi41xzhy7rAutkdGpK39MNsyHEBhjh+doauDBvE644yjR7pox
         iuiNt41Xbhdm1jlXX1x3YQfmiO05iSdK0YJqcLtembHZW2AePaLewNL+ZlHsUCE5HVcK
         QLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TioPQGknrE8mOW5JK4a866RtUyCeNLERCGZbj3eKG4M=;
        b=bTap9EL1xokaVI87ihnUPp3iMGF5HhY772OAXHSJ8+56WO6zaYZ6nJybY30Chobpo/
         HMS9jAA0bvk5LSwhKXozvsSQQbJVvtx8WW0BmC/zYIYDEpU8GEnpv4G9dmIfftI+BEd2
         fFgUnI5rp/1rvm10ROPfDqNpN0mKniyW4YLj8E1wOtNX5vOs0ws13/qfUOi3pYc8Uguv
         Erwcl2t6rmzj9pT1TFxjV7ztnUeTxB3CAqDX8d/BxxWAZ4dlJJbsfGhrfhnGi5fT8icx
         FSCBmQoT1AGEbReAn78tuEqPcNGjOuGrMR+VS/m3Dx1WBduYkseiuVDmB3MZ+N/CWUtM
         0d3g==
X-Gm-Message-State: AOAM531Y8qspNTFFa2UEShaKZfU77J56kdTGWG4DwXBLhEkxHF9k/Uv0
        kqu+kRYkRRiTZ69aJnsuZ4yqoAdi9vk=
X-Google-Smtp-Source: ABdhPJy41iykhChNUIwJKR3C89x8q8oKwXMKxZG6PsgD6qPQN85YVOsKh6ua2BXNfk0vVPdomqRsjw==
X-Received: by 2002:a05:6830:30af:: with SMTP id g15mr740082ots.202.1619842624393;
        Fri, 30 Apr 2021 21:17:04 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f21sm1194091otp.52.2021.04.30.21.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 21:17:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Apr 2021 21:17:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (pmbus/zl6100) Add support for ZLS1003,
 ZLS4009 and ZL8802
Message-ID: <20210501041701.GA3201929@roeck-us.net>
References: <20210423153329.33457-1-erik.rosen@metormote.com>
 <20210423153329.33457-2-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423153329.33457-2-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 05:33:28PM +0200, Erik Rosen wrote:
> Add support for Renesas ZL8802 Dual Channel/Dual Phase PMBus DC/DC
> Digital Controller as well as ZLS1003 and ZLS4009 custom DC/DC
> controller chips.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/zl6100.c | 94 ++++++++++++++++++++++++++++++------
>  1 file changed, 80 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
> index 69120ca7aaa8..757039bb8a62 100644
> --- a/drivers/hwmon/pmbus/zl6100.c
> +++ b/drivers/hwmon/pmbus/zl6100.c
> @@ -18,7 +18,7 @@
>  #include "pmbus.h"
>  
>  enum chips { zl2004, zl2005, zl2006, zl2008, zl2105, zl2106, zl6100, zl6105,
> -	     zl9101, zl9117 };
> +	     zl8802, zl9101, zl9117, zls1003, zls4009 };
>  
>  struct zl6100_data {
>  	int id;
> @@ -34,6 +34,13 @@ struct zl6100_data {
>  
>  #define ZL6100_MFR_XTEMP_ENABLE		BIT(7)
>  
> +#define ZL8802_MFR_USER_GLOBAL_CONFIG	0xe9
> +#define ZL8802_MFR_TMON_ENABLE		BIT(12)
> +#define ZL8802_MFR_USER_CONFIG		0xd1
> +#define ZL8802_MFR_XTEMP_ENABLE_2	BIT(1)
> +#define ZL8802_MFR_DDC_CONFIG		0xd3
> +#define ZL8802_MFR_PHASES_MASK		0x0007
> +
>  #define MFR_VMON_OV_FAULT_LIMIT		0xf5
>  #define MFR_VMON_UV_FAULT_LIMIT		0xf6
>  #define MFR_READ_VMON			0xf7
> @@ -132,7 +139,7 @@ static int zl6100_read_word_data(struct i2c_client *client, int page,
>  	struct zl6100_data *data = to_zl6100_data(info);
>  	int ret, vreg;
>  
> -	if (page > 0)
> +	if (page >= info->pages)
>  		return -ENXIO;
>  
>  	if (data->id == zl2005) {
> @@ -191,7 +198,7 @@ static int zl6100_read_byte_data(struct i2c_client *client, int page, int reg)
>  	struct zl6100_data *data = to_zl6100_data(info);
>  	int ret, status;
>  
> -	if (page > 0)
> +	if (page >= info->pages)
>  		return -ENXIO;
>  
>  	zl6100_wait(data);
> @@ -230,7 +237,7 @@ static int zl6100_write_word_data(struct i2c_client *client, int page, int reg,
>  	struct zl6100_data *data = to_zl6100_data(info);
>  	int ret, vreg;
>  
> -	if (page > 0)
> +	if (page >= info->pages)
>  		return -ENXIO;
>  
>  	switch (reg) {
> @@ -271,7 +278,7 @@ static int zl6100_write_byte(struct i2c_client *client, int page, u8 value)
>  	struct zl6100_data *data = to_zl6100_data(info);
>  	int ret;
>  
> -	if (page > 0)
> +	if (page >= info->pages)
>  		return -ENXIO;
>  
>  	zl6100_wait(data);
> @@ -287,6 +294,10 @@ static const struct i2c_device_id zl6100_id[] = {
>  	{"bmr462", zl2008},
>  	{"bmr463", zl2008},
>  	{"bmr464", zl2008},
> +	{"bmr465", zls4009},
> +	{"bmr466", zls1003},
> +	{"bmr467", zls4009},
> +	{"bmr469", zl8802},
>  	{"zl2004", zl2004},
>  	{"zl2005", zl2005},
>  	{"zl2006", zl2006},
> @@ -295,15 +306,18 @@ static const struct i2c_device_id zl6100_id[] = {
>  	{"zl2106", zl2106},
>  	{"zl6100", zl6100},
>  	{"zl6105", zl6105},
> +	{"zl8802", zl8802},
>  	{"zl9101", zl9101},
>  	{"zl9117", zl9117},
> +	{"zls1003", zls1003},
> +	{"zls4009", zls4009},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, zl6100_id);
>  
>  static int zl6100_probe(struct i2c_client *client)
>  {
> -	int ret;
> +	int ret, i;
>  	struct zl6100_data *data;
>  	struct pmbus_driver_info *info;
>  	u8 device_id[I2C_SMBUS_BLOCK_MAX + 1];
> @@ -367,18 +381,70 @@ static int zl6100_probe(struct i2c_client *client)
>  	  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  
>  	/*
> -	 * ZL2004, ZL9101M, and ZL9117M support monitoring an extra voltage
> -	 * (VMON for ZL2004, VDRV for ZL9101M and ZL9117M). Report it as vmon.
> +	 * ZL2004, ZL8802, ZL9101M, ZL9117M and ZLS4009 support monitoring
> +	 * an extra voltage (VMON for ZL2004, ZL8802 and ZLS4009,
> +	 * VDRV for ZL9101M and ZL9117M). Report it as vmon.
>  	 */
> -	if (data->id == zl2004 || data->id == zl9101 || data->id == zl9117)
> +	if (data->id == zl2004 || data->id == zl8802 || data->id == zl9101 ||
> +	    data->id == zl9117 || data->id == zls4009)
>  		info->func[0] |= PMBUS_HAVE_VMON | PMBUS_HAVE_STATUS_VMON;
>  
> -	ret = i2c_smbus_read_word_data(client, ZL6100_MFR_CONFIG);
> -	if (ret < 0)
> -		return ret;
> +	/*
> +	 * ZL8802 has two outputs that can be used either independently or in
> +	 * a current sharing configuration. The driver uses the DDC_CONFIG
> +	 * register to check if the module is running with independent or
> +	 * shared outputs. If the module is in shared output mode, only one
> +	 * output voltage will be reported.
> +	 */
> +	if (data->id == zl8802) {
> +		info->pages = 2;
> +		info->func[0] |= PMBUS_HAVE_IIN;
> +
> +		ret = i2c_smbus_read_word_data(client, ZL8802_MFR_DDC_CONFIG);
> +		if (ret < 0)
> +			return ret;
> +
> +		data->access = ktime_get();
> +		zl6100_wait(data);
> +
> +		if (ret & ZL8802_MFR_PHASES_MASK)
> +			info->func[1] |= PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
> +		else
> +			info->func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +				| PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
>  
> -	if (ret & ZL6100_MFR_XTEMP_ENABLE)
> -		info->func[0] |= PMBUS_HAVE_TEMP2;
> +		for (i = 0; i < 2; i++) {
> +			ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, i);
> +			if (ret < 0)
> +				return ret;
> +
> +			data->access = ktime_get();
> +			zl6100_wait(data);
> +
> +			ret = i2c_smbus_read_word_data(client, ZL8802_MFR_USER_CONFIG);
> +			if (ret < 0)
> +				return ret;
> +
> +			if (ret & ZL8802_MFR_XTEMP_ENABLE_2)
> +				info->func[i] |= PMBUS_HAVE_TEMP2;
> +
> +			data->access = ktime_get();
> +			zl6100_wait(data);
> +		}
> +		ret = i2c_smbus_read_word_data(client, ZL8802_MFR_USER_GLOBAL_CONFIG);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret & ZL8802_MFR_TMON_ENABLE)
> +			info->func[0] |= PMBUS_HAVE_TEMP3;
> +	} else {
> +		ret = i2c_smbus_read_word_data(client, ZL6100_MFR_CONFIG);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret & ZL6100_MFR_XTEMP_ENABLE)
> +			info->func[0] |= PMBUS_HAVE_TEMP2;
> +	}
>  
>  	data->access = ktime_get();
>  	zl6100_wait(data);
