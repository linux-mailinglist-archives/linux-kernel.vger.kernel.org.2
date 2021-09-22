Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741EF414C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhIVOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhIVOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:35:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26316C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:33:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q11so7407252wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=opllyLt1DsNDxWpcLBlZnpo8Z6sAmoNdsENcPyHTzkA=;
        b=yHF4k9WVv9ZGMahRDkO1TktUc7oOz1FD900V1TmAWw7ofc5AR2JjP51PYqSRHkrZ2V
         Niq0LQYCqG5w88J1AmVyXDNgBqDF1+0TV8QIav4H/EgoCbJIJGIsyGGpqHPq49wfA4C1
         95doEamy4O72xxpxINu5N+ydNgJgywFOqaP2Lud1lS4kRdIGI2mvIG5jJk2fP4DZXXXn
         xg6QlsBdl3j41olZ7/BfH4lfQz9lgw0WMm7d/WTMhAbtZAxAfKt4y23UdMMiGlpF8WJ0
         RoXR/MdmH2/Ye/QZCM7H8goJKFufsBf8kCZ1jsA58Nu8aqNEM5MXZiargYgSD2yeB3Kh
         7JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=opllyLt1DsNDxWpcLBlZnpo8Z6sAmoNdsENcPyHTzkA=;
        b=IJ89LJBptWtKEtuvipCLDRksR5i7K9K4tHnbNgntWtuGBjA/7joxAaW6OWd/eDdK3N
         lZckRVMKJ5gQfO4FZdhEOVp1T3DqjUTmjZRTi423QGEqNkJ4igT9S9V6nSHOkDZyBP3C
         8G4d5K2p3nlurBaysYVzZgsrnlnuUu9u6ysw87Ia64lu9D3BFWonqmkefVJdxTya/3Yp
         b3bo+p/1Qr2Hg3PrnGFoTdBh0UyP/5tM1RucSOlScinupDC0u8b80Z53wKDC1CqKtic1
         0MMwdzm1wMskVLZi/3ObsAmPwQxlHFPxWwhhaCzOz9bq5LwrWRet7A4jVy4QSvtGyNff
         dFkA==
X-Gm-Message-State: AOAM5311gEMjGVXPOn3EPiGGRg8k1Gw5u6aga2Brjc+968t7G0N4UszV
        XonNyY16Xc5UCXaJ3sOub3f7KTXxFd9fIQ==
X-Google-Smtp-Source: ABdhPJybLroGWJi7+dD0SMDaWcpDCZfF3MDjRkjzaZxW8f5yM5o17axBP46QDzhLaOP2uEVwHTDgmg==
X-Received: by 2002:a5d:4cc6:: with SMTP id c6mr41954042wrt.108.1632321230741;
        Wed, 22 Sep 2021 07:33:50 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id c15sm2531572wrc.83.2021.09.22.07.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 07:33:50 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:33:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: sprd: Add support for SC2730 PMIC
Message-ID: <YUs+zOR5AtbtgL9F@google.com>
References: <20210915091726.251031-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210915091726.251031-1-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021, Chunyan Zhang wrote:

> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> SC2730 is a PMIC SoC integrated in UMS512.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
