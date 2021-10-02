Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C848641FB9A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 14:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhJBMJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 08:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbhJBMJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 08:09:37 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4430DC061570;
        Sat,  2 Oct 2021 05:07:52 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 24so15076445oix.0;
        Sat, 02 Oct 2021 05:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8JCAOEDCDvSDxOuC8dv7CM9Hr45vp3pb26n1zICiHhk=;
        b=JhMj45rKQ3KHwoJbfnTKdwBWYKlRY7BJ8znyPiSoHDqPWAvenTPjRCsqryE/HwyNvg
         NpFppJRUiFDZpgMxUj/s/7ccRHNq/wZ77hgX3YBNzJ+Hya/GTfSHFoE4i32+JtsyknVN
         BtEhS8Ud6o4GY9kgvx+eEy4txh79bs31CZPqUNhZO+PTYkBIBxPiUgFj+3w+8GSZTxtN
         Ly+wwRzKfnev2vNiY43U3yhP7hn9MB6oGMwCGhvRq2PVZNBs4JGoYrVfBSznBKfwF5Lo
         XUaRFndRra5HHKQR7to2NCTfgzMI1l+V8v1m0V6G/mHc7fgA/7uBp+hHExrnbzBOkwhp
         5t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8JCAOEDCDvSDxOuC8dv7CM9Hr45vp3pb26n1zICiHhk=;
        b=mLKBsMJv8hv4uYxrYSw27K2QOnPDihM9tz1SjXcsfkezHVOQE2KuRte0tOdFH5Nh3T
         AwYLlQeQEFB5vrolK7op5LRmc8CBWzYRapNsCxeLt6VZ1LG3gLduOvzos1ZuSHlfvx8q
         NFXZlxUwKj1z2M3u7UILefNr2bA4VpXFc84V3Xj9zV7At1fGjsQAuUTd4s6EHj4WOu9/
         ht0Cl6vwBwpc/BaWdlk+yICEnXUxjMgagtS7P6IRyH4hR6WUQX20S5xkQZMBwVGhD3cV
         mO74dYyKKI+ACnw/o9E3SptTmLgvSRtJerdUHwxR7XaevnlfBj78aRPMHAOf5zW9IBHN
         s6fQ==
X-Gm-Message-State: AOAM531R6gsU8n9m5M2WXNYhcg82wB4oLJ6pez9MX3Fb6OH2eXs3Cnvg
        nh73Gcf3QmR8/6t/4NDoxlk=
X-Google-Smtp-Source: ABdhPJx9fqjMqOpD0PKrtGYvt5awtYJiPBEJhaw7v3FGekmkvut9XsrW9unDm/MJZb/yRvjTz+n8tQ==
X-Received: by 2002:a05:6808:256:: with SMTP id m22mr7492951oie.150.1633176471605;
        Sat, 02 Oct 2021 05:07:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k3sm799009otn.16.2021.10.02.05.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 05:07:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 2 Oct 2021 05:07:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nadezda Lutovinova <lutovinova@ispras.ru>
Cc:     Marc Hulsman <m.hulsman@tudelft.nl>,
        Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH v2 1/3] hwmon: (w83791d) Fix NULL pointer dereference by
 removing unnecessary structure field
Message-ID: <20211002120749.GA2021669@roeck-us.net>
References: <20210811181844.GB3138792@roeck-us.net>
 <20210921155153.28098-1-lutovinova@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921155153.28098-1-lutovinova@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 06:51:51PM +0300, Nadezda Lutovinova wrote:
> If driver read val value sufficient for 
> (val & 0x08) && (!(val & 0x80)) && ((val & 0x7) == ((val >> 4) & 0x7))
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

Applied, after fixing multi-line alignments.

Guenter

> ---
> v2: 
>  - split one file per patch 
>  - remove lm75[] instead of adding checking  
> ---
>  drivers/hwmon/w83791d.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
> index 37b25a1474c4..b4eae45859c1 100644
> --- a/drivers/hwmon/w83791d.c
> +++ b/drivers/hwmon/w83791d.c
> @@ -273,9 +273,6 @@ struct w83791d_data {
>  	char valid;			/* !=0 if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
> -	/* array of 2 pointers to subclients */
> -	struct i2c_client *lm75[2];
> -
>  	/* volts */
>  	u8 in[NUMBER_OF_VIN];		/* Register value */
>  	u8 in_max[NUMBER_OF_VIN];	/* Register value */
> @@ -1257,7 +1254,6 @@ static const struct attribute_group w83791d_group_fanpwm45 = {
>  static int w83791d_detect_subclients(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> -	struct w83791d_data *data = i2c_get_clientdata(client);
>  	int address = client->addr;
>  	int i, id;
>  	u8 val;
> @@ -1280,21 +1276,21 @@ static int w83791d_detect_subclients(struct i2c_client *client)
>  	}
>  
>  	val = w83791d_read(client, W83791D_REG_I2C_SUBADDR);
> +
> +	if (!(val & 0x88) && (val & 0x7) == ((val >> 4) & 0x7)) {
> +		dev_err(&client->dev,
> +			"duplicate addresses 0x%x, use force_subclient\n",
> +				0x48 + (val & 0x7));
> +		return -ENODEV;
> +	}
> +
>  	if (!(val & 0x08))
> -		data->lm75[0] = devm_i2c_new_dummy_device(&client->dev, adapter,
> -							  0x48 + (val & 0x7));
> -	if (!(val & 0x80)) {
> -		if (!IS_ERR(data->lm75[0]) &&
> -				((val & 0x7) == ((val >> 4) & 0x7))) {
> -			dev_err(&client->dev,
> -				"duplicate addresses 0x%x, "
> -				"use force_subclient\n",
> -				data->lm75[0]->addr);
> -			return -ENODEV;
> -		}
> -		data->lm75[1] = devm_i2c_new_dummy_device(&client->dev, adapter,
> -							  0x48 + ((val >> 4) & 0x7));
> -	}
> +		devm_i2c_new_dummy_device(&client->dev, adapter,
> +						0x48 + (val & 0x7));
> +
> +	if (!(val & 0x80))
> +		devm_i2c_new_dummy_device(&client->dev, adapter,
> +						0x48 + ((val >> 4) & 0x7));
>  
>  	return 0;
>  }
