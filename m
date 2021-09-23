Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A025415B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbhIWJuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240268AbhIWJuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:50:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0824C061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 02:48:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w29so15366922wra.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6+eKVp8taoHSdR1ibPn1ZGg0knOd1Pb0ImjfZkR19aI=;
        b=GTnuaG2v8n/EfVqZaGG/LrTewIRWMm7WeWMV3j9m4TQfzK6B0a4MoXuq7vYMKR5sRe
         OhoSOfgq+MGSmZTFC4dvGYouByjVRmagaBS3cEfzpPL+bxGgJi88cjdg6u/Q8NdSHlnr
         TpmTZ8f9YvBm66pwkXvPEHOTo1NB6sQLvtvYiAGLUfBVIxL8WW+ScDnGVm6p0pMIKP9r
         IjZoQkoj9ZzeOJzbf75qrDRdryulrO0JYGBlK59x+4zuwE2eYvEVvBFRwLgVuVscci48
         Jto3AO2FZ9nqFAOzVOhfpYEIAnXDM00By37MSsbuC3c/36E4Y5BPxSno7NjlJkfb7C8+
         KtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6+eKVp8taoHSdR1ibPn1ZGg0knOd1Pb0ImjfZkR19aI=;
        b=zGtC//Ye3GRNox4kt63aJAiO/XGWU48nRpaailbzZDGS7G1QGpuka8D4Rp32CCn6X3
         rSJDsJ7YUG3cMC52RkqU1fjc5JYmkhUh5C+y1ePAtYj+Hs3SjWiA8tGKw6C+AcgE81Ik
         xQklI78Ct84iouKcZkEcmBCygDLv746tzlTsu571j9mF0A4CPGRLb5my1xj+Vk+eKT/u
         F/byGkGyFW21kdPq/Ah7uw/U6zssnBRD1I0/AUKnv6sSxsjhEBvPZRwGnjG0gMVvYu0u
         gY244jjC23Hi+LqyJSxsITBV0vThR6hWYd2ac9DnQLVQvgmHp4gM10qSRezVZlkyFqeS
         Lu+g==
X-Gm-Message-State: AOAM532tO2ZwURgvqRhX3sOsM8+aJj/5SHkwPJ+s+4e4CIqHGeLsuK13
        VzLBZTujo99JKxXLdqQVUyDl0A==
X-Google-Smtp-Source: ABdhPJyibbde3vB1FCGt9d/JYvsj6NAS6zqNEXkWGRfCVwpJ0z2rvlY7kgpkBqqwzYJkFqg5Tz1gKg==
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr3402523wmi.138.1632390517246;
        Thu, 23 Sep 2021 02:48:37 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id g22sm7965648wmp.39.2021.09.23.02.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 02:48:36 -0700 (PDT)
Date:   Thu, 23 Sep 2021 10:48:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: propagate errors from get_brightness()
Message-ID: <YUxNczBccLQeQGA5@google.com>
References: <20210907124751.6404-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210907124751.6404-1-linux@weissschuh.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Sep 2021, Thomas Weißschuh wrote:

> backlight.h documents "struct backlight_ops->get_brightness()" to return
> a negative errno on failure.
> So far these errors have not been handled in the backlight core.
> This leads to negative values being exposed through sysfs although only
> positive values are documented to be reported.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> 
> v1: https://lore.kernel.org/dri-devel/20210906215525.15418-1-linux@weissschuh.net/
> 
> v1 -> v2:
> * use dev_err() instead of dev_warn() (Daniel Thompson)
> * Finish logging format string with newline (Daniel Thompson)
> * Log errno via dedicated error pointer format (Daniel Thompson)
> 
>  drivers/video/backlight/backlight.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
