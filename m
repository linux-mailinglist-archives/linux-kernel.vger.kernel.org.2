Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF553080F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhA1WNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhA1WNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:13:34 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC024C061573;
        Thu, 28 Jan 2021 14:12:53 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id k25so7741768oik.13;
        Thu, 28 Jan 2021 14:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uTpvmANJurzs3Y+BGYBG0ZD+17C2czZ8T5Yg8UgNt9o=;
        b=CgtiUzmodoqHSvez9UZ1UcDNuefxqpT+JU8KJHELZ7n9iiiOfk7qclDU44xB/W82So
         xv651x7LNUq43qYhV+OFQwGWhKrRI4NxfUif56C26J5DnxWBOTURgMIVH1CKeph05xIZ
         MYVjYCVkxbKSOry+G7wXp2x3fXvOB/lpbuA4YHDKTk+18cYmYL6F9c3WGaLP1YRm5kX0
         ZIf5bRv2d0xiy9zGst47RRSmUIUAjfk0WklcB2qNx0qM+OvzvRWw9nDev4u2m3GD9/X+
         iL3gQ/zL0CtdxT3KRDenkJJ6ysTS39yj6zwWCDRU4El8oeguSpGMWNXhv8Sn6kiDcZw+
         /5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uTpvmANJurzs3Y+BGYBG0ZD+17C2czZ8T5Yg8UgNt9o=;
        b=HMXW/CaiL9BCfyZmHUPCMGgdRtesUumkZQ1eCGNBdTYMbLCsIIMMh2FaM4xg5+TFV3
         k1Jq+8qFGTcsU17emKm7NlBbecNXsP/gWWyqWaBDGb7vr1NITd+4+Iqf4ZromN7avD/K
         +hHsb3bp3kNui72gqFgmyMT2f89NkphlEj7RGW/4gYC5fJZPQLTEzBejbDyBBtuuwM4O
         NDgwglAzhgtwdcHYb6qSveixgzEYX+j7vRoUmZQPRBKtcrLz79zM36unyNlz2MHNal+J
         AOvxWvhSTAc4VTIQzjRYARsr8II4QH1vFzZ5789ZKb1EvYtSUc+IIRAzcVFBByRoFfky
         URLg==
X-Gm-Message-State: AOAM532YTiueBUfC1kWt0CBWC51uiTWU+UvVaQXK+YbUPAWIfEE+unN7
        Jxw3CKFX2hDbybF7ghaaMNM=
X-Google-Smtp-Source: ABdhPJxlzAmEpnJ/6LgYHeMSt9Vn2NANrCb/K6roCDZOySR07QSFJHIY3OiCpeLKu8jJGO5qKiBR6g==
X-Received: by 2002:aca:4e12:: with SMTP id c18mr941522oib.68.1611871972975;
        Thu, 28 Jan 2021 14:12:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m15sm1323177otl.11.2021.01.28.14.12.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jan 2021 14:12:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Jan 2021 14:12:50 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v3] hwmon: (lm70) Use device_get_match_data()
Message-ID: <20210128221250.GA165038@roeck-us.net>
References: <20210128215742.983036-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128215742.983036-1-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 03:57:42PM -0600, Rob Herring wrote:
> From: Stephen Boyd <swboyd@chromium.org>
> 
> Use the more modern API to get the match data out of the of match table.
> This saves some code, lines, and nicely avoids referencing the match
> table when it is undefined with configurations where CONFIG_OF=n.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: <linux-hwmon@vger.kernel.org>
> [robh: rework to use device_get_match_data()]
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v3:
> - Reworked to use device_get_match_data(). Lifted Stephen's commit 
>   message from another patch. :)
> 
> Please ack and I'll add to the rest of the series.
> 
>  drivers/hwmon/lm70.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
> index ae2b84263a44..40eab3349904 100644
> --- a/drivers/hwmon/lm70.c
> +++ b/drivers/hwmon/lm70.c
> @@ -22,9 +22,9 @@
>  #include <linux/hwmon.h>
>  #include <linux/mutex.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/property.h>
>  #include <linux/spi/spi.h>
>  #include <linux/slab.h>
> -#include <linux/of_device.h>
>  #include <linux/acpi.h>
>  
>  #define DRVNAME		"lm70"
> @@ -173,25 +173,15 @@ MODULE_DEVICE_TABLE(acpi, lm70_acpi_ids);
>  
>  static int lm70_probe(struct spi_device *spi)
>  {
> -	const struct of_device_id *of_match;
>  	struct device *hwmon_dev;
>  	struct lm70 *p_lm70;
>  	int chip;
>  
> -	of_match = of_match_device(lm70_of_ids, &spi->dev);
> -	if (of_match)
> -		chip = (int)(uintptr_t)of_match->data;
> -	else {
> -#ifdef CONFIG_ACPI
> -		const struct acpi_device_id *acpi_match;
> +	if (dev_fwnode(&spi->dev))
> +		chip = (int)(uintptr_t)device_get_match_data(&spi->dev);
> +	else
> +		chip = spi_get_device_id(spi)->driver_data;
>  
> -		acpi_match = acpi_match_device(lm70_acpi_ids, &spi->dev);
> -		if (acpi_match)
> -			chip = (int)(uintptr_t)acpi_match->driver_data;
> -		else
> -#endif
> -			chip = spi_get_device_id(spi)->driver_data;
> -	}
>  
>  	/* signaling is SPI_MODE_0 */
>  	if (spi->mode & (SPI_CPOL | SPI_CPHA))
> -- 
> 2.27.0
> 
