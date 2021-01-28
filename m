Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C48530710E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhA1IRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhA1IRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:17:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B727FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:16:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a1so4466253wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UeimYJSD/BbdilP/QsnJ5hxblqoSqeJXssbZW1GuA/E=;
        b=HLDco07WIOI0eRFrC4jndd4L8LCMXW0F+aUl9EIn2JpFOtTztYSUhXSqu9mjB1ioMJ
         2sMiLjA0fs5EjoOfH+6ae16pwEgx0Vz/GaRY03tRa59UCnqaSJGMERAVLi92/G1LPO7y
         /2q4IBj6bHwKIii0su+YEfEDRtAVYtJJorqFU7WM40gL3nxqURSOXN6123lu3p03ZkGD
         1xdATKryVyMbwSBPrLiSxu6FOXvoFfDYg1vCUW4a3wVomTQH4VUx++wSlvHf+O8dcdEG
         g11wNZZnagd45iHVfLFiJYSbAhNFWtCRwXCez7z7D1ec7q1GsbBf0aEmLgTWmnSf4rwe
         WvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UeimYJSD/BbdilP/QsnJ5hxblqoSqeJXssbZW1GuA/E=;
        b=TURlD0hHjBY+QVW5fM4sFDrv/2cRTs/PSwvKGf07GF6p1Lh2l9sogSiHLw67XGno//
         2vJQDNpT9dpte0nA5Gpk2Ao+jGSeTtZm6PNO7tQX5qIcdZuGQghayKa+qFKKkNhsQA8t
         E6sEZjLPqV+w+45c49+yBtR2cpx/Vk+icCGpfoKL6K8F9lmYmU7i0KcfVb0SfSobs4yO
         eJERBkI9iKLsVQCxeN8FV76H2NMvir7Y+4cqcRkyGVKvxCF6vgGU0qCPPuG+m+H3HjS7
         sSxkp/VmujjKnkHEAJw/4fHsZu9pYsIT4iud5Goh4mTMY+xlLWtsWvjKVaLIGRkyIhwC
         mclA==
X-Gm-Message-State: AOAM530Wg5clC6LnHiHFVuU+WrcuWKYsW9tgfVFJVot/bxc77pm1rj4q
        qNOF2h2HXMPjGLSDNHL9OnalRQ==
X-Google-Smtp-Source: ABdhPJwk4pcrmzfuCbnjS9kjUUrQd6dcq75GhqojTwB1b/FrDLAyrcZHVKoo6nED2QAu8b6oqCCoLg==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr15032680wre.344.1611821795387;
        Thu, 28 Jan 2021 00:16:35 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id f4sm5952787wrs.34.2021.01.28.00.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 00:16:34 -0800 (PST)
Date:   Thu, 28 Jan 2021 08:16:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        David Gow <davidgow@google.com>,
        Mayulong <mayulong1@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wang Hai <wanghai38@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/7] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <20210128081633.GB4774@dell>
References: <cover.1611773727.git.mchehab+huawei@kernel.org>
 <2b0e6f6cef0aaa914956792088c554c57f5ec644.1611773727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b0e6f6cef0aaa914956792088c554c57f5ec644.1611773727.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021, Mauro Carvalho Chehab wrote:

> This driver is ready for mainstream. So, move it out of staging.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../mfd}/hisilicon,hi6421-spmi-pmic.yaml        |  0
>  MAINTAINERS                                     |  7 +++++++
>  drivers/mfd/Kconfig                             | 15 +++++++++++++++
>  drivers/mfd/Makefile                            |  1 +
>  .../hikey9xx => mfd}/hi6421-spmi-pmic.c         |  0
>  drivers/staging/hikey9xx/Kconfig                | 17 -----------------
>  drivers/staging/hikey9xx/Makefile               |  1 -
>  7 files changed, 23 insertions(+), 18 deletions(-)
>  rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/mfd}/hisilicon,hi6421-spmi-pmic.yaml (100%)
>  rename drivers/{staging/hikey9xx => mfd}/hi6421-spmi-pmic.c (100%)

I've already reviewed this:

  https://lore.kernel.org/driverdev-devel/20210127110537.GI4903@dell/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
