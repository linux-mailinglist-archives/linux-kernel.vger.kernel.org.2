Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB93A2F80
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhFJPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhFJPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:41:20 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97187C061574;
        Thu, 10 Jun 2021 08:39:24 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id m137so2557708oig.6;
        Thu, 10 Jun 2021 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ILxhXAMqUZH3RrsKOKuIXVx1gcDUtk6YKsr0+FSu9+c=;
        b=nNv3dNmWdCYcSNKvifk4zv/Q8JdJtnsVZE5Im2MsHOVASwUxHRqb5GKj30BSvcE5qh
         Qnpp6RLD9Q/1yrpzGQqkxkt+gGXWxsR0otDuW63W/d4K7kLhtJ9D+2+7VVTc/2DI+c5T
         iqNFTiIbTMmJkoiIqM4RW7T0VPLScD7sO7E69rJNPMC42DKTJp2qpjQPu4jG7q6FCdwN
         lOGyG99I1a3Vx/Eu2IcJ2xcC0KyxgeVPw+LrOqQK+nnDeKsRHAYw+JN/1kDuLVixr4LE
         Hg8e0cv1GXjXnlndtk666L+igx5NwEV3Su9QFTq5drh3NyFjs6HUkLJsKkj68qT3AF0J
         herQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ILxhXAMqUZH3RrsKOKuIXVx1gcDUtk6YKsr0+FSu9+c=;
        b=Nuy4I80wXoXnFwTw2CrAXjS2UkbM1okR62vZb6Gxld2sFKekDpricRiyhF1lsK/CKp
         i7CbvdwD/eMVY//MTZgjL9vvzhEgZY6Rjzl0VD4iq9t2+Iu/EbXwDkJ2OO31zzPF5j+q
         C+/Oc6vPeZP8yYevWA/ZovSLAyBgkjB1wghFWFKGWQCx+5tItNTrtIOJDThFhG44x4so
         +tUU/pTaB5U4iSxYmPO9D+Cz4PQkPyKMCJGGc8uOT5FXHbAQqF3CViNddILLs4CcWo4C
         ClhUC8vgGntZFDGnlTWQNrSUM/3BpVkVmDH9eCfsaj3xYoZwT6rYEZvOUWu2pw3m/amQ
         bcbg==
X-Gm-Message-State: AOAM531GrLUO+3hKmGAXrGJegrf9+9GrBPEFTAtdKxiIgyJBO1ZUupte
        UVfWAb+kPz6n57fbsjZ6yrA=
X-Google-Smtp-Source: ABdhPJxuRxPbXLh5NG+IQk+gOlpJz5UnWegy/9u83oV7qVEZ3COtdGlmfb8dhI4XnyltSET0BpXuyQ==
X-Received: by 2002:a05:6808:55c:: with SMTP id i28mr3913334oig.66.1623339564066;
        Thu, 10 Jun 2021 08:39:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q15sm592488oon.28.2021.06.10.08.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 08:39:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Jun 2021 08:39:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Subject: Re: [PATCH 2/3] hwmon: (tps23861) set current shunt value
Message-ID: <20210610153922.GA3859014@roeck-us.net>
References: <20210609220728.499879-1-robert.marko@sartura.hr>
 <20210609220728.499879-2-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609220728.499879-2-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 12:07:27AM +0200, Robert Marko wrote:
> TPS23861 has a configuration bit for setting of the
> current shunt value used on the board.
> Its bit 0 of the General Mask 1 register.
> 
> According to the datasheet bit values are:
> 0 for 255 mOhm (Default)
> 1 for 250 mOhm
> 
> So, configure the bit before registering the hwmon
> device according to the value passed in the DTS or
> default one if none is passed.
> 
> This caused potentially reading slightly skewed values
> due to max current value being 1.02A when 250mOhm shunt
> is used instead of 1.0A when 255mOhm is used.
> 
> Fixes: fff7b8ab2255 ("hwmon: add Texas Instruments TPS23861 driver")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/tps23861.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
> index fd0be8883829..c3685b7e9e82 100644
> --- a/drivers/hwmon/tps23861.c
> +++ b/drivers/hwmon/tps23861.c
> @@ -99,6 +99,9 @@
>  #define POWER_ENABLE			0x19
>  #define TPS23861_NUM_PORTS		4
>  
> +#define TPS23861_GENERAL_MASK_1		0x17
> +#define TPS23861_CURRENT_SHUNT_MASK	BIT(0)
> +
>  #define TEMPERATURE_LSB			652 /* 0.652 degrees Celsius */
>  #define VOLTAGE_LSB			3662 /* 3.662 mV */
>  #define SHUNT_RESISTOR_DEFAULT		255000 /* 255 mOhm */
> @@ -561,6 +564,15 @@ static int tps23861_probe(struct i2c_client *client)
>  	else
>  		data->shunt_resistor = SHUNT_RESISTOR_DEFAULT;
>  
> +	if (data->shunt_resistor == SHUNT_RESISTOR_DEFAULT)
> +		regmap_clear_bits(data->regmap,
> +				  TPS23861_GENERAL_MASK_1,
> +				  TPS23861_CURRENT_SHUNT_MASK);
> +	else
> +		regmap_set_bits(data->regmap,
> +				TPS23861_GENERAL_MASK_1,
> +				TPS23861_CURRENT_SHUNT_MASK);
> +
>  	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
>  							 data, &tps23861_chip_info,
>  							 NULL);
