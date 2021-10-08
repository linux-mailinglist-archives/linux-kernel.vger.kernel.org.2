Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF7C426C51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbhJHOFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240974AbhJHOF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:05:29 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F6AC061570;
        Fri,  8 Oct 2021 07:03:34 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o4so13847306oia.10;
        Fri, 08 Oct 2021 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tj1c7r+zFI1XL5f1HV03FqFq7aJGpB1dEp7dBvj8Wnk=;
        b=okHRW+A9P+PProJWdZr8GHnJQM4kMIIor3MOJgJwlA3i21rhKUDPnVPD7MTtbdbTk6
         scKYmcGu5yQaiLaPqghaGFs7WK5YQeCRB9p/9kfwlh5ioREDQuJxiothtPX7dWr4SQt3
         CYJGuZVVQz2KBbqf1eeb4ivpnzPnLx7n4RqVnGkIuT9KKwdgcZpmH/2qiErUVUzIHWXb
         nxdp0500bd0S2WhyubDbfEmPN/47IfnBMp54VCNOxrsFY9XqYL0SthQ0tx6x8nn3YLAN
         oRVIs9VnFv07iW1WOwFYoBcF3pPMCzH0UrHO0oUf2MKmwER3aJnH1dt5whhHJAfHjWVq
         UlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Tj1c7r+zFI1XL5f1HV03FqFq7aJGpB1dEp7dBvj8Wnk=;
        b=6bcLDKmZ13sERBuCo0NVIAPxH1U4nQ7S4ILECob41s4G/V6xKzvGV1KStbW1jtcFeO
         qLzcUDwo987bOXbE4ETEMAeBLrBFdm0zUKMZHaprN234RZtEP59N/THJyGh2htMORzO7
         tXo4SjcsJRkFVfSt8BhAFxx8C5JTzk/6J9Iuw/BCh87mKcawMTpwwhnqx595NkRvtL1k
         vtf912v/5gRY3LmXWBckcf7uKho9d3pl/0oH2AM3//EtQYjgz3Qi+LR3uisdRfJE3tBn
         17Q85j9mGBBq3fV9RscraNr5PwaEavyqmm6tJkur3jVwfLW0HPmwzwRStOLE2MoitBy3
         roMQ==
X-Gm-Message-State: AOAM530Bo0rW2xy9fK+pQzyMu+n7UltowF9JFiL+BvOXSFZY1rcktTpb
        LQjqbbJ5kNL4iCdBe1rXkKZGixMGW90=
X-Google-Smtp-Source: ABdhPJxi5GqEavvQBFKbIeKfGRLMTuFrmsBc6IRwQqYHuxaUIRC3YHI6TlRJzSMWz3Jy1S+O4rXREg==
X-Received: by 2002:a05:6808:3b6:: with SMTP id n22mr7965264oie.133.1633701813525;
        Fri, 08 Oct 2021 07:03:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e16sm696023oiw.2.2021.10.08.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 07:03:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 07:03:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] hwmon: (pmbus/lm25066) Support configurable sense
 resistor values
Message-ID: <20211008140331.GA1728738@roeck-us.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
 <20210928092242.30036-8-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928092242.30036-8-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:22:41AM -0700, Zev Weiss wrote:
> The appropriate mantissa values for the lm25066 family's direct-format
> current and power readings are a function of the sense resistor
> employed between the SENSE and VIN pins of the chip.  Instead of
> assuming that resistance is always the same 1mOhm as used in the
> datasheet, allow it to be configured via a device-tree property
> ("shunt-resistor-micro-ohms").
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  Documentation/hwmon/lm25066.rst |  2 ++
>  drivers/hwmon/pmbus/lm25066.c   | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/hwmon/lm25066.rst b/Documentation/hwmon/lm25066.rst
> index 9f1d7e4d3ca1..a2098eb24090 100644
> --- a/Documentation/hwmon/lm25066.rst
> +++ b/Documentation/hwmon/lm25066.rst
> @@ -79,6 +79,8 @@ This driver does not auto-detect devices. You will have to instantiate the
>  devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
>  details.
>  
> +The shunt (sense) resistor value can be configured by a device tree property;
> +see Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml for details.
>  
>  Platform data support
>  ---------------------
> diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
> index 18d5a76f346d..29e848bcd436 100644
> --- a/drivers/hwmon/pmbus/lm25066.c
> +++ b/drivers/hwmon/pmbus/lm25066.c
> @@ -458,6 +458,7 @@ MODULE_DEVICE_TABLE(of, lm25066_of_match);
>  static int lm25066_probe(struct i2c_client *client)
>  {
>  	int config;
> +	u32 shunt;
>  	struct lm25066_data *data;
>  	struct pmbus_driver_info *info;
>  	const struct __coeff *coeff;
> @@ -535,6 +536,17 @@ static int lm25066_probe(struct i2c_client *client)
>  		info->b[PSC_POWER] = coeff[PSC_POWER].b;
>  	}
>  
> +	/*
> +	 * Values in the TI datasheets are normalized for a 1mOhm sense
> +	 * resistor; assume that unless DT specifies a value explicitly.
> +	 */
> +	if (of_property_read_u32(client->dev.of_node,
> +	                         "shunt-resistor-micro-ohms", &shunt))

Space vs. tabs again. Never mind, fixed up and applied.

Thanks,
Guenter

> +		shunt = 1000;
> +
> +	info->m[PSC_CURRENT_IN] = info->m[PSC_CURRENT_IN] * shunt / 1000;
> +	info->m[PSC_POWER] = info->m[PSC_POWER] * shunt / 1000;
> +
>  	return pmbus_do_probe(client, info);
>  }
>  
