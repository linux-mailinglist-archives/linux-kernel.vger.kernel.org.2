Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27883426BE9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhJHNtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhJHNtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:49:03 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6EFC061570;
        Fri,  8 Oct 2021 06:47:08 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso11698483otu.9;
        Fri, 08 Oct 2021 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ed3BHX+IFgP0wUYhoinI+xLf0AtTEs09Omqzbac6p5k=;
        b=GuXw3PfyGCEO3qiHDSyeJsd8cYdHCyf8qeOFFbZapV4I5g7WMzF3ffacxIuDz5QoqU
         MDoOA6zwHIurFKMrU8yOKVCgdjoTGIOS3A1U6Y8MYPGow/dh1CGdSDf094zOMrQ8MEB7
         Hs9uKa4I8+qkjalH7LWEYbgaTg7/mZpC3Y3xNoJxW2zGjG+eAXCBRq7fKz2JKFI9Z22T
         EbWb/Mn9y/IO4ZUlWUuFIhqbnGjZ1QT9oKKIaEafTEFFpYyl8+dFxezXs7zFnT05CPh0
         /OL9NxZHSwjC5BcRkJvLwpFEzHDixTSIiH3JeV5A3aNLAAYdq74SH2XpmU+cZXaSFL0h
         bkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ed3BHX+IFgP0wUYhoinI+xLf0AtTEs09Omqzbac6p5k=;
        b=TNOoLPkIAQKVF7L39jCYhGlLEELjPeMBo5beB9Qc8Xw+7UcWcgOpdAbG2wJyoS995F
         Z2S/udM2Gwl3BgZ93CQM0yGTcJR9G/BDyPgLxXqOy71UnZGyhraCNg4Hjb2XEiRQpxfl
         1C/8joxKMIxmAPG3d639Jkn7dfZEvyZUIh48PUEhCNXColqPJngytWpjzZSYt7mW12Ga
         u3y2yULvzo97hms4rheK4lQhXZxhvXTm3tKQTsojThUF847RhWwXp9dn6VTMCISMBO8y
         h0FdwargyjKuGB/HSpNaF61w7vFwv3l7wPWhIZYtoXR4tP5AdAzYyuJ53evyUWN0LcQr
         VRHw==
X-Gm-Message-State: AOAM533Xhm0K4k7UJgozoq/v/bGy7Gz6M+b1KSbVe9HWlUJ5Q0tU0qws
        MrEfMYwj3Ea18CYlfVXCl00=
X-Google-Smtp-Source: ABdhPJyyp5D6kFkGSQNJ4ud+Vu7EIJqXpGhY/Bn6VwkuPhap3pG2fhUkJP1r1V1WF+8MhB57daRJjg==
X-Received: by 2002:a9d:610e:: with SMTP id i14mr8607738otj.46.1633700827551;
        Fri, 08 Oct 2021 06:47:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f3sm617991oij.6.2021.10.08.06.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:47:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 06:47:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] hwmon: (pmbus/lm25066) Avoid forward declaration of
 lm25066_id
Message-ID: <20211008134705.GA1215575@roeck-us.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
 <20210928092242.30036-4-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928092242.30036-4-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:22:37AM -0700, Zev Weiss wrote:
> Reordering things to put the table before the probe function
> eliminates the need for it.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/lm25066.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
> index 3616705aafde..4dc003ff859e 100644
> --- a/drivers/hwmon/pmbus/lm25066.c
> +++ b/drivers/hwmon/pmbus/lm25066.c
> @@ -234,8 +234,6 @@ struct lm25066_data {
>  
>  #define to_lm25066_data(x)  container_of(x, struct lm25066_data, info)
>  
> -static const struct i2c_device_id lm25066_id[];
> -
>  static int lm25066_read_word_data(struct i2c_client *client, int page,
>  				  int phase, int reg)
>  {
> @@ -436,6 +434,16 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
>  	return ret;
>  }
>  
> +static const struct i2c_device_id lm25066_id[] = {
> +	{"lm25056", lm25056},
> +	{"lm25066", lm25066},
> +	{"lm5064", lm5064},
> +	{"lm5066", lm5066},
> +	{"lm5066i", lm5066i},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, lm25066_id);
> +
>  static int lm25066_probe(struct i2c_client *client)
>  {
>  	int config;
> @@ -509,17 +517,6 @@ static int lm25066_probe(struct i2c_client *client)
>  	return pmbus_do_probe(client, info);
>  }
>  
> -static const struct i2c_device_id lm25066_id[] = {
> -	{"lm25056", lm25056},
> -	{"lm25066", lm25066},
> -	{"lm5064", lm5064},
> -	{"lm5066", lm5066},
> -	{"lm5066i", lm5066i},
> -	{ }
> -};
> -
> -MODULE_DEVICE_TABLE(i2c, lm25066_id);
> -
>  /* This is the driver that will be inserted */
>  static struct i2c_driver lm25066_driver = {
>  	.driver = {
