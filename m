Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DADC35F37B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350784AbhDNMV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhDNMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:21:55 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485D7C061574;
        Wed, 14 Apr 2021 05:21:33 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so19140473otn.1;
        Wed, 14 Apr 2021 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=02BMsB15iI+PWQUPoeumqyghFPOPvXSDGERlBfTrle0=;
        b=eqLzLdr9Pjk3+/8iLROe0LWoHNgDJdbtV2No1HXQDTNvqcRqUrQgDcV3hCGtuqXghv
         XLK7ZJPiR0Y1xcr69vSjt2tXkhSzFk0Tho5f6L1ztMDaN9UhrjCP0LA8+Jhc/mgpMF2r
         x4qs9jXapleWSHFcPbWx7OD0fLNiuRivrpoTLDYBtTwUXH8yYcDOA1xq8n5feqJXfqXR
         GgOBeNNjT27Sg+f418+WU5RA6mplCs7zUU5E9C6EwIyiYewhsWwGJWsRq5ixE45W6K5w
         VyDBKlU5E03+/YVpmkIeDJlxm+CzNsDSyDkH0VSeIzPHC5SyyULbZdMI7SCKi+A+Aggw
         m1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=02BMsB15iI+PWQUPoeumqyghFPOPvXSDGERlBfTrle0=;
        b=lmyAM9Jm9rgNjGbzG9BvxRsTH3D9kLtjp6IUbnTaqaMsIM1OJddsYNBMm+WgeLUq7Y
         6wwEX3Mv3uazAmFA/uM0dQL7hYZB+owFXdjesjOrijd6ChFVZyO9zYzX0KmcuNBS3Ywp
         jkkdolHCX+XlCwCmTaToe67+BJqTXD02fRK6uA1RKHB5WHNwzfQ5vWDzKWQgwlqIvvz5
         sYk/d+fSXALHnyBQmJI0M2faCWN2V2ck/+2eo83Ox9CkBnL4+1VtoXdgdqqX8WuRbFM/
         cWlekNKXtLxFYf38Qwn54/WyX+fojs+8PNhY+VcTozG/2nAC0RD++HbjNhVwG3CWgIHR
         F85A==
X-Gm-Message-State: AOAM532xb/qRtRdOAs1MvJ4555t6HpcXhYVdTFjtHmc4jJl2z8OWXYJe
        D0+bYLIzxa/bimMfQ0XOaXw=
X-Google-Smtp-Source: ABdhPJyaEkd7Bdabm6n+YdK3vbAc6GAFpNYwFaWwjPJxTyGPjj2SXBEQeNBvahJJ9wQDTSEEHyw3aQ==
X-Received: by 2002:a9d:4613:: with SMTP id y19mr4685326ote.262.1618402892746;
        Wed, 14 Apr 2021 05:21:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m127sm3495702oib.32.2021.04.14.05.21.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Apr 2021 05:21:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 14 Apr 2021 05:21:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v3 2/4] mfd: simple-mfd-i2c: Adds Ampere's Altra SMpro
 support
Message-ID: <20210414122130.GA113503@roeck-us.net>
References: <20210409031332.21919-1-quan@os.amperecomputing.com>
 <20210409031332.21919-3-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409031332.21919-3-quan@os.amperecomputing.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 10:13:30AM +0700, Quan Nguyen wrote:
> Adds an MFD driver for SMpro found on the Mt.Jade hardware reference
> platform with Ampere's Altra processor family.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/mfd/Kconfig          | 10 ++++++++++
>  drivers/mfd/simple-mfd-i2c.c |  6 ++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index d07e8cf93286..f7a6460f7aa0 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -77,6 +77,16 @@ config MFD_AS3711
>  	help
>  	  Support for the AS3711 PMIC from AMS
>  
> +config MFD_SMPRO
> +	tristate "Ampere Computing MFD SMpro core driver"
> +	select MFD_SIMPLE_MFD_I2C

This is missing "depends on I2C".

> +	help
> +	  Say yes here to enable SMpro driver support for Ampere's Altra
> +	  processor family.
> +
> +	  Ampere's Altra SMpro exposes an I2C regmap interface that can
> +	  be accessed by child devices.
> +
>  config MFD_AS3722
>  	tristate "ams AS3722 Power Management IC"
>  	select MFD_CORE
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 87f684cff9a1..9a44655f5592 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -21,6 +21,11 @@ static const struct regmap_config simple_regmap_config = {
>  	.val_bits = 8,
>  };
>  
> +static const struct regmap_config simple_word_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +};
> +
>  static int simple_mfd_i2c_probe(struct i2c_client *i2c)
>  {
>  	const struct regmap_config *config;
> @@ -39,6 +44,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
>  
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
>  	{ .compatible = "kontron,sl28cpld" },
> +	{ .compatible = "ampere,smpro", .data = &simple_word_regmap_config },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
