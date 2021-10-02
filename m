Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7968641FBB9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 14:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhJBMRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 08:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhJBMRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 08:17:02 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB5AC061570;
        Sat,  2 Oct 2021 05:15:16 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id z11so15065185oih.1;
        Sat, 02 Oct 2021 05:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fUGzltKaGfLnAnvFVGwwxfMV6cAFgLrAUoAbXm8XDK8=;
        b=ZcYX1/QRsc0Md/K24zFizDiht/9wj9R/h7TpIgFQLGnsAhT79GNiAgIKcbZ9GTf/+J
         4OQVyjMhNSi5G1jclpYt/EUNXeilG8CBMRE3JkPX30zv/OSL9f8XWTwLlRJqOvt7eomg
         9OfY3V5mHaOzFgAsBwmhfxhI+z6tnDUJ5XrEAKo1jEaMnE0haBjNbpnOcfT+0hn56gog
         G9APcouJsYuCrvPLey6xyg8G9y7TRp/vg/h2U6HLo4wZ/JQ/wzuOLzc8E8BtbnUcTZ39
         2WIPRJQRtqJud2K7FgTOtYRRxZqKVmcEaV7XBKALCS7YKm17tSdHZDQjjLUcSaHQLuT+
         KRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fUGzltKaGfLnAnvFVGwwxfMV6cAFgLrAUoAbXm8XDK8=;
        b=y7h/jX9jXkwnWO3oXZq8FF6VpBin9JaPHSTn3pM9fUYlnWu9MJ0pCCVw+q4YkADKVq
         JiITouyDZ4RBSuIDqhv10GqcJWcUH+xfgUy1xyyunoUwenPOj5IskBo/iyIFzRtkFhf6
         YhgXCmmEyvA0J8cCeBmfyVoLa9iPiOrmE3kIYDW7VdvOOh0MIX6J/DXX7AbcdSAIej6z
         XZl7robLsvPmT7ChuPSSTtHzEO0Z15TPqOkVc5GhBAZEbBsDDGSwGu2co53mRaA02qTd
         bZm79h7eLU7ckJXxVI78/Tq9PxAe+G7+yrpg8qjZvGcYfI6P9o3u3GzXTp4Bz8/lYicM
         +foQ==
X-Gm-Message-State: AOAM532cSNmBgdFaMcSDa71+gYLMbxyjlnwaSNcCRpR8qcFfgVbpzzxP
        ACi7+HKOR8PBgjkUOASbv9M=
X-Google-Smtp-Source: ABdhPJxjko1ZAjJoLwtNhn0N+zFMA3miGPMkjbtGEiHdjHFwVvGqz8lChrR4kt2CNRM9zYw4/ho3sA==
X-Received: by 2002:aca:ea82:: with SMTP id i124mr7711954oih.152.1633176916214;
        Sat, 02 Oct 2021 05:15:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u26sm1652712oic.51.2021.10.02.05.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 05:15:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 2 Oct 2021 05:15:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nadezda Lutovinova <lutovinova@ispras.ru>
Cc:     Marc Hulsman <m.hulsman@tudelft.nl>,
        Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH v2 3/3] hwmon: (w83793) Fix NULL pointer dereference by
 removing unnecessary structure field
Message-ID: <20211002121514.GA2263467@roeck-us.net>
References: <20210921155153.28098-1-lutovinova@ispras.ru>
 <20210921155153.28098-3-lutovinova@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921155153.28098-3-lutovinova@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 06:51:53PM +0300, Nadezda Lutovinova wrote:
> If driver read tmp value sufficient for 
> (tmp & 0x08) && (!(tmp & 0x80)) && ((tmp & 0x7) == ((tmp >> 4) & 0x7))
> from device then Null pointer dereference occurs. 
> (It is possible if tmp = 0b0xyz1xyz, where same literals mean same numbers)
> Also lm75[] does not serve a purpose anymore after switching to
> devm_i2c_new_dummy_device() in w83791d_detect_subclients().
> 
> The patch fixes possible NULL pointer dereference by removing lm75[].
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Nadezda Lutovinova <lutovinova@ispras.ru>

Applied, after fixing multi-line alignments

Thanks,
Guenter

> ---
> v2: 
>  - split one file per patch 
>  - remove lm75[] instead of adding checking  
> ---
>  drivers/hwmon/w83793.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
> index e7d0484eabe4..4ee96756ed49 100644
> --- a/drivers/hwmon/w83793.c
> +++ b/drivers/hwmon/w83793.c
> @@ -202,7 +202,6 @@ static inline s8 TEMP_TO_REG(long val, s8 min, s8 max)
>  }
>  
>  struct w83793_data {
> -	struct i2c_client *lm75[2];
>  	struct device *hwmon_dev;
>  	struct mutex update_lock;
>  	char valid;			/* !=0 if following fields are valid */
> @@ -1566,7 +1565,6 @@ w83793_detect_subclients(struct i2c_client *client)
>  	int address = client->addr;
>  	u8 tmp;
>  	struct i2c_adapter *adapter = client->adapter;
> -	struct w83793_data *data = i2c_get_clientdata(client);
>  
>  	id = i2c_adapter_id(adapter);
>  	if (force_subclients[0] == id && force_subclients[1] == address) {
> @@ -1586,20 +1584,21 @@ w83793_detect_subclients(struct i2c_client *client)
>  	}
>  
>  	tmp = w83793_read_value(client, W83793_REG_I2C_SUBADDR);
> +
> +	if (!(tmp & 0x88) && (tmp & 0x7) == ((tmp >> 4) & 0x7)) {
> +		dev_err(&client->dev,
> +			"duplicate addresses 0x%x, use force_subclient\n",
> +				0x48 + (tmp & 0x7));
> +		return -ENODEV;
> +	}
> +
>  	if (!(tmp & 0x08))
> -		data->lm75[0] = devm_i2c_new_dummy_device(&client->dev, adapter,
> -							  0x48 + (tmp & 0x7));
> -	if (!(tmp & 0x80)) {
> -		if (!IS_ERR(data->lm75[0])
> -		    && ((tmp & 0x7) == ((tmp >> 4) & 0x7))) {
> -			dev_err(&client->dev,
> -				"duplicate addresses 0x%x, "
> -				"use force_subclients\n", data->lm75[0]->addr);
> -			return -ENODEV;
> -		}
> -		data->lm75[1] = devm_i2c_new_dummy_device(&client->dev, adapter,
> -							  0x48 + ((tmp >> 4) & 0x7));
> -	}
> +		devm_i2c_new_dummy_device(&client->dev, adapter,
> +						0x48 + (tmp & 0x7));
> +
> +	if (!(tmp & 0x80))
> +		devm_i2c_new_dummy_device(&client->dev, adapter,
> +						0x48 + ((tmp >> 4) & 0x7));
>  
>  	return 0;
>  }
