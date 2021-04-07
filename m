Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F584357671
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhDGVAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhDGVAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:00:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C66C061760;
        Wed,  7 Apr 2021 13:59:59 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x9so14822473qto.8;
        Wed, 07 Apr 2021 13:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tq48SMoACalbpJM/xYiLJwxyu4F59FADJu2xIjwNsq8=;
        b=txoOq4iQtSaOqmLDA0HPDF2h1b7v02Xv5xGrE5TW+RiUfmAn46hnf7m9LpDclY+eou
         8zOqDEglnCAekhddC9nbFVwQI1wPpWpiP4lTA80Xzdpwa8Y3zBOVusq5K14hrTM1eiFo
         p+l/w6DfalqijN8c9V2JCPB9WnTDoCvUo+9S/INa+cSzHgKk5sQT6aaIfH6R4aGDcpXU
         2Isc5VDX5lD9dXDshOpGbabQBabzwNFmK3URdHpXBmSQp7bnCc28IkssbUUL5XA6Zfwm
         B7ZxBtvmMsP+Sz/li9QpDl3y/dlKdhlkbcEYQa7lKg1uzFZT9OWBtQJ/9kG+ibaMAgDx
         MTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tq48SMoACalbpJM/xYiLJwxyu4F59FADJu2xIjwNsq8=;
        b=LMDR5Le8+FTC4t40o74/kniQkIWk7ioL+2L8Gy/j8lw0wz+PDXh2FLpZ3M3XBrbUFw
         kbnriyh/5K6CoDUR/j+2XtnZU+PYMYGtRt6UHtHXodMwPwgJDE/8ZM6vFABisv8Hck7T
         fw8fsvh1nNi697h8EEbYeHFulmOvaDViHURJLs23oPeBGj3X0vnbUoJaa/RxZM6iuR1m
         NpCwjLj8NLxX+/Cx0lJlKiZR+TRVr6hEwiw5n47eRjAyYdAqP/047cwLia7r3C2a+h97
         XKglXr2/kWgR08yh/XDfvtCkfTnklQ7ipS69rPbOU71VnL+myTNu7Q3lE++wHC2o5jWS
         jWjg==
X-Gm-Message-State: AOAM5328qnzjbMo39/f3xFcNA2E4L10rTRZIZ+R5R77Ixrxjsv6nlAvr
        vLbaIEHikVJugkQfOABGVT5jt8H+8Mc=
X-Google-Smtp-Source: ABdhPJyvy2aK5c1M+rD07tfuhOvGUZrZYNLpXJwDEhFGF0m+8EGKuKc3InMc+GPaL3zHPYq5S0MXow==
X-Received: by 2002:ac8:5f10:: with SMTP id x16mr4595459qta.6.1617829198497;
        Wed, 07 Apr 2021 13:59:58 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id d16sm19149287qka.43.2021.04.07.13.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 13:59:58 -0700 (PDT)
Subject: Re: [PATCH 1/1] of: unittest: overlay: ensure proper alignment of
 copied FDT
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
References: <20210407205110.2173976-1-frowand.list@gmail.com>
Message-ID: <0851cec1-99d1-7de0-81dc-2c82532dc6f7@gmail.com>
Date:   Wed, 7 Apr 2021 15:59:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210407205110.2173976-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 4/7/21 3:51 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The Devicetree standard specifies an 8 byte alignment of the FDT.
> Code in libfdt expects this alignment for an FDT image in memory.
> kmemdup() returns 4 byte alignment on openrisc.  Replace kmemdup()
> with kmalloc(), align pointer, memcpy() to get proper alignment.
> 
> The 4 byte alignment exposed a related bug which triggered a crash
> on openrisc with:
> commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
> as reported in:
> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/

Can you please test this patch?

The most complete coverage will be a config with:

 OF_UNITTEST=y
 OF_OVERLAY=y
 OF_DYNAMIC=y

One path will be missed if you test with:

 #OF_OVERLAY=n
 #OF_DYNAMIC=n

Thanks!

-Frank

> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/of_private.h | 2 ++
>  drivers/of/overlay.c    | 8 ++++++--
>  drivers/of/unittest.c   | 9 +++++++--
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index d9e6a324de0a..d717efbd637d 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -8,6 +8,8 @@
>   * Copyright (C) 1996-2005 Paul Mackerras.
>   */
>  
> +#define FDT_ALIGN_SIZE 8
> +
>  /**
>   * struct alias_prop - Alias property in 'aliases' node
>   * @link:	List node to link the structure in aliases_lookup list
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 50bbe0edf538..8b40711ed202 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -1014,7 +1014,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>  int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>  			 int *ovcs_id)
>  {
> -	const void *new_fdt;
> +	void *new_fdt;
>  	int ret;
>  	u32 size;
>  	struct device_node *overlay_root;
> @@ -1036,10 +1036,14 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>  	 * Must create permanent copy of FDT because of_fdt_unflatten_tree()
>  	 * will create pointers to the passed in FDT in the unflattened tree.
>  	 */
> -	new_fdt = kmemdup(overlay_fdt, size, GFP_KERNEL);
> +	size += FDT_ALIGN_SIZE;
> +	new_fdt = kmalloc(size, GFP_KERNEL);
>  	if (!new_fdt)
>  		return -ENOMEM;
>  
> +	new_fdt = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);
> +	memcpy(new_fdt, overlay_fdt, size);
> +
>  	of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);
>  	if (!overlay_root) {
>  		pr_err("unable to unflatten overlay_fdt\n");
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index eb100627c186..edd6ce807691 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
> +#include <linux/kernel.h>
>  
>  #include <linux/i2c.h>
>  #include <linux/i2c-mux.h>
> @@ -1415,7 +1416,7 @@ static int __init unittest_data_add(void)
>  	 */
>  	extern uint8_t __dtb_testcases_begin[];
>  	extern uint8_t __dtb_testcases_end[];
> -	const int size = __dtb_testcases_end - __dtb_testcases_begin;
> +	u32 size = __dtb_testcases_end - __dtb_testcases_begin;
>  	int rc;
>  
>  	if (!size) {
> @@ -1425,10 +1426,14 @@ static int __init unittest_data_add(void)
>  	}
>  
>  	/* creating copy */
> -	unittest_data = kmemdup(__dtb_testcases_begin, size, GFP_KERNEL);
> +	size += FDT_ALIGN_SIZE;
> +	unittest_data = kmalloc(size, GFP_KERNEL);
>  	if (!unittest_data)
>  		return -ENOMEM;
>  
> +	unittest_data = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
> +	memcpy(unittest_data, __dtb_testcases_begin, size);
> +
>  	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
>  	if (!unittest_data_node) {
>  		pr_warn("%s: No tree to attach; not running tests\n", __func__);
> 

