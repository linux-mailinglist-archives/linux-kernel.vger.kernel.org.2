Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370623E9780
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhHKSTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhHKSTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:19:12 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7FEC061765;
        Wed, 11 Aug 2021 11:18:48 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id a19so3408689qkg.2;
        Wed, 11 Aug 2021 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rZYFM6BHngnFsPGNhAbnKTFOUCE/Asghmc63IAp/FP0=;
        b=Uuuhy3BIg0gDS15tG6DfBn0P3pwgvaAk4KEqvxuVHEIuFsbJdyciqYXOK1Z/5qdGAi
         1sKKc7uEfmjOliGsRJxQXKjRRQ6n0Ty+tUybRjFkLdbJMpp+SreYh3klDZQDwAVBw/Hr
         cnWBpSoSWjjx53l2UqpX6eLh5u4nw1ZoCPO+cw7opSXZJ9fwX0RgjdPebRFs53b2SgEh
         DMf6fZGvmUpyf9PMO46Lu4IIeCJ/Yfccx76eDfzV4CUs9W/p97IImft0jnfZlzvLDl3Z
         TD6ZArnvsKBqlLaOflavgQObvUcJkQ1Aly3gIHTRXUeefe6iTHZONEQn+x+lDLB4wp2B
         tmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rZYFM6BHngnFsPGNhAbnKTFOUCE/Asghmc63IAp/FP0=;
        b=MqXhapUhDy1M+a6nN7x59KaCkBl46NSWXhiMGMkv8tbpaC3UmS78mfizRXHH5JF4P6
         BRLem5Gb7JE4duRhcPlSvoz6YpZP1Voqc4Yg/7WFvFC/yt26ByJr0e1+7tdHldmdwJqH
         cd7YEyYEgnHaE1i0pHj1GGW413pskb810FiS2jN0gANiwwengdkMbbK3zr0JWyZVgLcd
         rdOfkNwm5PyGEmXASikUp4rwBdQcn/3p8cym7wBuioz1hV20PRPIR4rI1ivm9QmXWMVR
         U4Sl60bZxhlBg5pLsxU5LMbdPLBuQ3hcXADeOLXyOJ+Yap3ih2GMUsZ1RsTx/XMOdI8g
         o8tQ==
X-Gm-Message-State: AOAM5322GUKI5crMYLQ8WEfWRJoEj3uXjN6mGHs8RHCTDb1tbJAEQ3OI
        6es9ro/flf8GGGU/HXLvRSI=
X-Google-Smtp-Source: ABdhPJw/24GiKcD/GrBitbjjOD70/EuhMEinHuuyE/rslqrTEQFeX6LcpvvcqCDb5lILjZuv1K37Mw==
X-Received: by 2002:a37:a053:: with SMTP id j80mr310671qke.422.1628705927231;
        Wed, 11 Aug 2021 11:18:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o63sm13052385qkf.4.2021.08.11.11.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:18:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Aug 2021 11:18:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nadezda Lutovinova <lutovinova@ispras.ru>
Cc:     Marc Hulsman <m.hulsman@tudelft.nl>,
        Jean Delvare <jdelvare@suse.com>,
        Rudolf Marek <r.marek@assembler.cz>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] hwmon: Correct the error handling in w83793.c,
 w83791d.c, w83792d.c
Message-ID: <20210811181844.GB3138792@roeck-us.net>
References: <20210811161515.17842-1-lutovinova@ispras.ru>
 <20210811161515.17842-2-lutovinova@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811161515.17842-2-lutovinova@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 07:15:15PM +0300, Nadezda Lutovinova wrote:
> If driver read tmp (or val) value sufficient for 
> (tmp & 0x08) && (!(tmp & 0x80)) && ((tmp & 0x7) == ((tmp >> 4) & 0x7))
> from device then Null pointer dereference occurs. 
> (It is possible if tmp = 0b0xyz1xyz, where same literals mean same numbers)
> 
> The patch adds checking if data->lm75[0] is NULL.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 

One patch per driver, please.

> Signed-off-by: Nadezda Lutovinova <lutovinova@ispras.ru>
> ---
>  drivers/hwmon/w83791d.c | 2 +-
>  drivers/hwmon/w83792d.c | 2 +-
>  drivers/hwmon/w83793.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
> index 37b25a1474c4..8b30bbfafaa7 100644
> --- a/drivers/hwmon/w83791d.c
> +++ b/drivers/hwmon/w83791d.c
> @@ -1284,7 +1284,7 @@ static int w83791d_detect_subclients(struct i2c_client *client)
>  		data->lm75[0] = devm_i2c_new_dummy_device(&client->dev, adapter,
>  							  0x48 + (val & 0x7));
>  	if (!(val & 0x80)) {
> -		if (!IS_ERR(data->lm75[0]) &&
> +		if (!IS_ERR_OR_NULL(data->lm75[0]) &&
>  				((val & 0x7) == ((val >> 4) & 0x7))) {
>  			dev_err(&client->dev,
>  				"duplicate addresses 0x%x, "

As you pointed out in te other e-mail, lm75[] does not really serve 
a purpose anymore. It might be much better to replace this code with
something like

	if (!(val & 0x88) && (val & 0x7) == ((val >> 4) & 0x7)) {
		dev_err(&new_client->dev,
		        "duplicate addresses 0x%x, use force_subclient\n",
                        0x48 + (val & 0x7));
		return -ENODEV;
	}

Same for the other chips.

Guenter

> diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
> index abd5c3a722b9..85ae12d950e1 100644
> --- a/drivers/hwmon/w83792d.c
> +++ b/drivers/hwmon/w83792d.c
> @@ -950,7 +950,7 @@ w83792d_detect_subclients(struct i2c_client *new_client)
>  		data->lm75[0] = devm_i2c_new_dummy_device(&new_client->dev, adapter,
>  							  0x48 + (val & 0x7));
>  	if (!(val & 0x80)) {
> -		if (!IS_ERR(data->lm75[0]) &&
> +		if (!IS_ERR_OR_NULL(data->lm75[0]) &&
>  			((val & 0x7) == ((val >> 4) & 0x7))) {
>  			dev_err(&new_client->dev,
>  				"duplicate addresses 0x%x, use force_subclient\n",
> diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
> index e7d0484eabe4..9d8c44e2fa6e 100644
> --- a/drivers/hwmon/w83793.c
> +++ b/drivers/hwmon/w83793.c
> @@ -1590,7 +1590,7 @@ w83793_detect_subclients(struct i2c_client *client)
>  		data->lm75[0] = devm_i2c_new_dummy_device(&client->dev, adapter,
>  							  0x48 + (tmp & 0x7));
>  	if (!(tmp & 0x80)) {
> -		if (!IS_ERR(data->lm75[0])
> +		if (!IS_ERR_OR_NULL(data->lm75[0])
>  		    && ((tmp & 0x7) == ((tmp >> 4) & 0x7))) {
>  			dev_err(&client->dev,
>  				"duplicate addresses 0x%x, "
> -- 
> 2.17.1
> 
