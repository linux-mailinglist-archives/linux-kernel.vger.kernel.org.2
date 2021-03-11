Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847B9337FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCKVjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhCKVjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:39:36 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04535C061574;
        Thu, 11 Mar 2021 13:39:36 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id v192so17155479oia.5;
        Thu, 11 Mar 2021 13:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AG/AV4QY7bANf3wO/syK6BiICRp5Kc6FIwzeSh2HfRE=;
        b=ViwzQzsCYtfHVTOfHo8VBOj32S4Fmnhukh35qLftX6pd58LhJMkeOj1yhauYT5ZcCv
         WdQlUMXogjgfBpH0fqdHTUFokxywC/WkwPQvzV+55P+Mk57A8SWyLW4AQoltt9Km18+0
         KCKD763UlZahtq1i2dbqBtW1UpAyRifFu1EO5soU28+/i3540Lx7yAHy9cSxsTjLsGj5
         MACMeVs9obFlWfat0j4ffr7EGF1x/+yntFwLuW4EqdoLtjDjSg+coBd3gotmI3BEBr+C
         bskgOmJDffSLgE+hFilqAxBBUyUFywyj1pyUNSTcTwwUO1c09g1pWRhj5tnom5QfDXnn
         Kqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AG/AV4QY7bANf3wO/syK6BiICRp5Kc6FIwzeSh2HfRE=;
        b=tkMlQiYHQE7XPDBOxhoUgAPBsp5Y4wPVORsNO8viGvc9Cn48+K6VQln3Z4AyEHZOH1
         Ha+on8/isIB3e7f9oaSFtYQNZwiqyK2XbluVQyo8rwU6jvA5chnKec+BQbNf5iXwpsk6
         n3yPG0tcAQSwYoKHpdYc7cy5wGHTETjW3eXd97tg3PAA71VwWKyueClkK1mXjLR7DpUv
         VWwE3lKR8JPi98sb3vsq27MlYwJINVGVCoyh8CRVV6L676jeqlzKPdJQ6FW+vPD8pC7n
         m4aWMYzwGJbx5tqO1JEAOv1/lD0jbQj0DJTkNzz6iSMcJpQE7/htbUmfOupNmKf6magm
         nuiw==
X-Gm-Message-State: AOAM531EVh5gFTNgVEFrKuwGHQEkQIgLgVT7NscVmx//WNYvQ/mMVHtm
        tEz9iHARhA+R+x/SrL3DV5Q=
X-Google-Smtp-Source: ABdhPJy89ZrBTPAMniotUKGWuawVCvWRa/OWhT0CKnJcPnCnUowU4Dn5oSLfgQ9iRV3bxM2IEetSRg==
X-Received: by 2002:a05:6808:f15:: with SMTP id m21mr7842544oiw.123.1615498775451;
        Thu, 11 Mar 2021 13:39:35 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w23sm786391oow.25.2021.03.11.13.39.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Mar 2021 13:39:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Mar 2021 13:39:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: update calculation of LINEAR11 values
Message-ID: <20210311213933.GA35601@roeck-us.net>
References: <YDoSMqFbgoTXyoru@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YDoSMqFbgoTXyoru@monster.powergraphx.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 10:34:42AM +0100, Wilken Gottwalt wrote:
> Changes the way how LINEAR11 values are calculated. The new method
> increases the precision of 2-3 digits.
> 
> old method:
> 	corsairpsu-hid-3-1
> 	Adapter: HID adapter
> 	v_in:        230.00 V
> 	v_out +12v:   12.00 V
> 	v_out +5v:     5.00 V
> 	v_out +3.3v:   3.00 V
> 	psu fan:        0 RPM
> 	vrm temp:     +44.0°C
> 	case temp:    +37.0°C
> 	power total: 152.00 W
> 	power +12v:  112.00 W
> 	power +5v:    38.00 W
> 	power +3.3v:   5.00 W
> 	curr in:          N/A
> 	curr +12v:     9.00 A
> 	curr +5v:      7.00 A
> 	curr +3.3v:  1000.00 mA
> 
> new method:
> 	corsairpsu-hid-3-1
> 	Adapter: HID adapter
> 	v_in:        230.00 V
> 	v_out +12v:   12.16 V
> 	v_out +5v:     5.01 V
> 	v_out +3.3v:   3.30 V
> 	psu fan:        0 RPM
> 	vrm temp:     +44.5°C
> 	case temp:    +37.8°C
> 	power total: 148.00 W
> 	power +12v:  108.00 W
> 	power +5v:    37.00 W
> 	power +3.3v:   4.50 W
> 	curr in:          N/A
> 	curr +12v:     9.25 A
> 	curr +5v:      7.50 A
> 	curr +3.3v:    1.50 A
> 
> Co-developed-by: Jack Doan <me@jackdoan.com>
> Signed-off-by: Jack Doan <me@jackdoan.com>
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/corsair-psu.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 99494056f4bd..b0953eeeb2d3 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -119,27 +119,13 @@ struct corsairpsu_data {
>  };
>  
>  /* some values are SMBus LINEAR11 data which need a conversion */
> -static int corsairpsu_linear11_to_int(const int val)
> +static int corsairpsu_linear11_to_int(const u16 val, const int scale)
>  {
> -	int exp = (val & 0xFFFF) >> 0x0B;
> -	int mant = val & 0x7FF;
> -	int i;
> -
> -	if (exp > 0x0F)
> -		exp -= 0x20;
> -	if (mant > 0x3FF)
> -		mant -= 0x800;
> -	if ((mant & 0x01) == 1)
> -		++mant;
> -	if (exp < 0) {
> -		for (i = 0; i < -exp; ++i)
> -			mant /= 2;
> -	} else {
> -		for (i = 0; i < exp; ++i)
> -			mant *= 2;
> -	}
> +	const int exp = ((s16)val) >> 11;
> +	const int mant = (((s16)(val & 0x7ff)) << 5) >> 5;
> +	const int result = mant * scale;
>  
> -	return mant;
> +	return (exp >= 0) ? (result << exp) : (result >> -exp);
>  }
>  
>  static int corsairpsu_usb_cmd(struct corsairpsu_data *priv, u8 p0, u8 p1, u8 p2, void *data)
> @@ -249,14 +235,14 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
>  	case PSU_CMD_RAIL_AMPS:
>  	case PSU_CMD_TEMP0:
>  	case PSU_CMD_TEMP1:
> -		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF) * 1000;
> +		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1000);
>  		break;
>  	case PSU_CMD_FAN:
> -		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF);
> +		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1);
>  		break;
>  	case PSU_CMD_RAIL_WATTS:
>  	case PSU_CMD_TOTAL_WATTS:
> -		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF) * 1000000;
> +		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1000000);
>  		break;
>  	case PSU_CMD_TOTAL_UPTIME:
>  	case PSU_CMD_UPTIME:
