Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473203804B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhENHz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhENHz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:55:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E043C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:54:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n2so29237991wrm.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ykvto01E8V8AA7Ox++/StYivD+grg6Stg6zG7v0GCoU=;
        b=mnEhlVu9W/TQZgvV49Q3sKWTebZXK3Gad5gLJzr9IAen0upHzYG5Nrxqetr5aVA+ol
         706Y4erQa/sp0OHxFvFoG3BcI1WOs4VsNzE5vtTcQkdGtxz/H/ij0vw86riVcR4DptFr
         F/Q2yIJvkHBeE9MVwxqViTHoqAqV9uwrvjbM2xF5dw++JYOeWi4u96b0pcsnav2q856Y
         QYmeOX22bfgonIhhW1RLNxuCqm//KbczBKUCHQhFaF64UnBeiySivjSgIoW9hUa5d7/r
         kzKBx73S4QHBfY5klY89JUy3Dwg2nyTEzlWhc5eqCHhjssCDvzJyNp8z7mQe76QADHEk
         YEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ykvto01E8V8AA7Ox++/StYivD+grg6Stg6zG7v0GCoU=;
        b=owN+6jDFcNs7cZCex7fkReK0Ot8VablqQwSB4HxQ40r8Kwq/fCS8NYdX6XmPxb+Mma
         3FeRRb0YZRBY98uHqsQX6wPM1n1kih2ilIweuHr2GK1deqdt00kpdkXEjBccYxcCWuUs
         31bTlUpg7iVD0CUSqypYLbLs9HxkZZpE7CM27S3t7dbCHEblYtwAOcqr5XnVpWGsotOM
         uVxvhgn6SuLmsbl9I9qyEOykG7f7fUCqEtXsdxFDxeYzy30g74BtsuO5dea6VsBxgfLR
         FUqxDvIiDzx9Osw5g6qZsjOFTpN+l/QIxfMXgx8yClhsNrFOGLZdb/QbthBJRiboNWId
         7jcw==
X-Gm-Message-State: AOAM5324Ux0Essqq7hTn98i2Jt9Ht3rwlWIWsvjkXdC0XWaC9oPgUGg+
        cMsMbyW7CM8VOweGEw5iQRI=
X-Google-Smtp-Source: ABdhPJxloWHmCkAlje3svrOKge8TiIk+d4EffPK72H82lRIrFssg7tFsWJ0p3kTAYo3Jg+jIj3pbkA==
X-Received: by 2002:adf:e510:: with SMTP id j16mr58172404wrm.28.1620978854174;
        Fri, 14 May 2021 00:54:14 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id n6sm5738895wro.23.2021.05.14.00.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 00:54:13 -0700 (PDT)
Subject: Re: [PATCH] arm64: defconfig: Do not override the MTK_PMIC_WRAP
 symbol
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        hsinyi@chromium.org, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>, Nishanth Menon <nm@ti.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Luo Longjun <luolongjun@huawei.com>
References: <20210423075201.2616023-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <cb9c85d5-3467-c235-93cd-be23fb6e0a03@gmail.com>
Date:   Fri, 14 May 2021 09:54:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210423075201.2616023-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/04/2021 09:52, Enric Balletbo i Serra wrote:
> Commit 'fbbe38309d56 ("arm64: defconfig: Allow mt8173-based boards to boot
> from usb")' added the MTK_PMIC_WRAP config built-in. It needs to be
> built-in in order to be able to boot from USB or the MMC without needing
> a ramdisk, but that symbol was already defined as a module so now we are
> getting the following warning:
> 
>   arch/arm64/configs/defconfig:996:warning: override: reassigning to symbol MTK_PMIC_WRAP
> 
> Remove the MTK_PMIC_WRAP=m from the defconfig to remove the error.
> 
> Fixes: fbbe38309d56 ("arm64: defconfig: Allow mt8173-based boards to boot from usb")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to v5.13-next/defconfig

Thanks!

> ---
> 
>  arch/arm64/configs/defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 08c6f769df9a..9907a431db0d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -491,7 +491,6 @@ CONFIG_SPI_S3C64XX=y
>  CONFIG_SPI_SH_MSIOF=m
>  CONFIG_SPI_SUN6I=y
>  CONFIG_SPI_SPIDEV=m
> -CONFIG_MTK_PMIC_WRAP=m
>  CONFIG_SPMI=y
>  CONFIG_PINCTRL_SINGLE=y
>  CONFIG_PINCTRL_MAX77620=y
> 
