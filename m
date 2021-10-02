Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4264441FBB1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 14:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhJBMOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 08:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbhJBMOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 08:14:22 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CE1C0613EE;
        Sat,  2 Oct 2021 05:12:36 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so15020556otj.2;
        Sat, 02 Oct 2021 05:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sFYDZod90D6bVfnwrwAESHjb0mPHYNSTdLNe5dl+FxU=;
        b=Fy79lCM4S6chB/UpyPoz/7kzQrHDMcvPmUU5pF3N6b/5pxNp9/IRDCcTNSzCUCEtWe
         r9qRP/Xx0pYLdkNQS4DZwx5mnRG4A9ydXllAnWyW8S/EQvce+MvVqZeNWqOky3lAmAPJ
         iePXYLISmK140PSRDw6/HnihtXR8mR1FrD1uboBr42nZzE6089V+WU5L020skeXdmW38
         m/OLwb4CtDlsWC5tWfY2gHc5lKgd2jrS5YpsoFXp6P/cp+N7ldb1j7xFyhw4ykyqEwJx
         2wozhfMKQnKluj+/TEUp5Aqe9LtKEPfi6BZ3XtbtKUBroCDhGh4EmyDqByK1c0PM5eiW
         Fg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sFYDZod90D6bVfnwrwAESHjb0mPHYNSTdLNe5dl+FxU=;
        b=3oL8HOkmbqlrCjeUo88vSgQregIxBlqqP7Q8ZXbmrbZFn1OoBGTyJuTBgYOFOfj9om
         pBjble4TC2im0F1ape3vC8zreoEOQ++lG4RfCNWNesDJimqJSGZ+hE9z7gNuRisZXKqq
         mN85utX5STN4YIgEY7EIsbkB+BtEUpXg3H4kiCwibsQlFf4RhcVOhcfeslFJQ2/k811c
         j+/4fRCWoNCUkXXDlJyIUtxS2bKoLLb3GMvKL6DLSIeVia67PC5afsJFpODVoivKDRYJ
         3kgSN8M866+cbMtIB05s7AbvIuZ1HbQr6caW/0lrJvcUEEzB7ek34iJeC1TWEcsgG9K3
         3PYg==
X-Gm-Message-State: AOAM5310XV/CEAkXEh7TUTiVF0SXVtyoG6gVe2bR3P5U9w8UDa4u27gE
        opNpn7G13UyaAkWxsIoZNnI=
X-Google-Smtp-Source: ABdhPJwJ5hxZgmjYGp4bUvs/uKznZ2dkgEL+zaksQvZJNMrhMjNljgOsFNh47/63wYzdPHzQ2Gr8eg==
X-Received: by 2002:a9d:a47:: with SMTP id 65mr2342289otg.133.1633176755996;
        Sat, 02 Oct 2021 05:12:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c10sm1675006ooi.11.2021.10.02.05.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 05:12:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 2 Oct 2021 05:12:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nadezda Lutovinova <lutovinova@ispras.ru>
Cc:     Marc Hulsman <m.hulsman@tudelft.nl>,
        Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH v2 2/3] hwmon: (w83792d) Fix NULL pointer dereference by
 removing unnecessary structure field
Message-ID: <20211002121234.GA2188531@roeck-us.net>
References: <20210921155153.28098-1-lutovinova@ispras.ru>
 <20210921155153.28098-2-lutovinova@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921155153.28098-2-lutovinova@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 06:51:52PM +0300, Nadezda Lutovinova wrote:
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

Applied, after fixing multi-line alignments

> ---
> v2: 
>  - split one file per patch 
>  - remove lm75[] instead of adding checking  
> ---
>  drivers/hwmon/w83792d.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
> index abd5c3a722b9..8a72be4ad74f 100644
> --- a/drivers/hwmon/w83792d.c
> +++ b/drivers/hwmon/w83792d.c
> @@ -264,9 +264,6 @@ struct w83792d_data {
>  	char valid;		/* !=0 if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
> -	/* array of 2 pointers to subclients */
> -	struct i2c_client *lm75[2];
> -
>  	u8 in[9];		/* Register value */
>  	u8 in_max[9];		/* Register value */
>  	u8 in_min[9];		/* Register value */
> @@ -927,7 +924,6 @@ w83792d_detect_subclients(struct i2c_client *new_client)
>  	int address = new_client->addr;
>  	u8 val;
>  	struct i2c_adapter *adapter = new_client->adapter;
> -	struct w83792d_data *data = i2c_get_clientdata(new_client);
>  
>  	id = i2c_adapter_id(adapter);
>  	if (force_subclients[0] == id && force_subclients[1] == address) {
> @@ -946,20 +942,21 @@ w83792d_detect_subclients(struct i2c_client *new_client)
>  	}
>  
>  	val = w83792d_read_value(new_client, W83792D_REG_I2C_SUBADDR);
> +
> +	if (!(val & 0x88) && (val & 0x7) == ((val >> 4) & 0x7)) {
> +		dev_err(&new_client->dev,
> +			"duplicate addresses 0x%x, use force_subclient\n",
> +				0x48 + (val & 0x7));
> +		return -ENODEV;
> +	}
> +
>  	if (!(val & 0x08))
> -		data->lm75[0] = devm_i2c_new_dummy_device(&new_client->dev, adapter,
> -							  0x48 + (val & 0x7));
> -	if (!(val & 0x80)) {
> -		if (!IS_ERR(data->lm75[0]) &&
> -			((val & 0x7) == ((val >> 4) & 0x7))) {
> -			dev_err(&new_client->dev,
> -				"duplicate addresses 0x%x, use force_subclient\n",
> -				data->lm75[0]->addr);
> -			return -ENODEV;
> -		}
> -		data->lm75[1] = devm_i2c_new_dummy_device(&new_client->dev, adapter,
> -							  0x48 + ((val >> 4) & 0x7));
> -	}
> +		devm_i2c_new_dummy_device(&new_client->dev, adapter,
> +						0x48 + (val & 0x7));
> +
> +	if (!(val & 0x80))
> +		devm_i2c_new_dummy_device(&new_client->dev, adapter,
> +						0x48 + ((val >> 4) & 0x7));
>  
>  	return 0;
>  }
