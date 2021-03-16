Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F137633D8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbhCPQRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbhCPQRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:17:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFEEC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:17:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b9so7747403wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=egtFw+F15fKKmH2YRQH2CrqY4Mc/N2k166aWKfPwG1Y=;
        b=FltGq8lrYkYkwYM+V2XPu45T4mcNIee4aKIpDwThXFmCkXHv1NSsUQj3fzwnlsU+uA
         X0gMwrvn2QFAcbmO82awWTVDyQl5xZQrfdNr25wK+xTvDPjigvZNNLPU+4s4+2OQ3rnx
         Htv9mtvNFRsGwp+qubVL5CwOaSjxTzFTG+GG0dAF8dN0t6biM0n+Esv+omzTBFgxbkBw
         dgAJ2HnEo5rRlW5nPMGEzXV/dh/bIEXgl7hB0w0pnkfBzstIFbWHfJ8nD16mWvSsNpUd
         VtTeYe4+dTCMVY5wnl5Ykh1zT5BttMLuB3tDUz4WpgUG+NYjbYtu/T1nMCaAr3xcUjgl
         Oxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=egtFw+F15fKKmH2YRQH2CrqY4Mc/N2k166aWKfPwG1Y=;
        b=JoYfwRZil5ajdpxLzmT/harToZgfm09djRBsk9E+jIyy4ptJJU+aFFVMaYbx4AIG0Z
         x+iBpi0xs/ilR85GRDSBE1kNwkT83raXdIjQw97GRypQ9PIOEOTOQxi4QK/5I0J8R/2Q
         bTIo7t7DqXCvrMnolmFUfWc5zztJadnZ+boopgluaZSxAMZ0RXNgrn77SaZyRLFQaEwb
         m2unwlMRSua4oZdWiPzQYuz3wY3HsNeqaPbCyLZmSIwsSO/RBl5eqOon4yNWF+8lltw0
         9QF9n7LCVdwcefcqNGDP9but6l5zimCzED5CntX2aOeHlyNmJ9UH7Oy0n8MD3bkhPpvF
         TXEQ==
X-Gm-Message-State: AOAM532pfjkByx+Wh1ptp0ck2KqKxQiif9PZ3kYR6yVgR1gKkKMGmCV7
        nzllYmmaLgN4JSC1iPjY4Ki92w==
X-Google-Smtp-Source: ABdhPJzdCwPvuP9H3AT1EWrpwUAoVmiRl3HgwOZ/HTxhQHBLImPATzGBqV+i1LiJHRy52kQ1t/vysQ==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr5588156wrq.136.1615911425935;
        Tue, 16 Mar 2021 09:17:05 -0700 (PDT)
Received: from dell ([91.110.221.243])
        by smtp.gmail.com with ESMTPSA id q19sm23646208wrg.80.2021.03.16.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:17:05 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:17:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RESEND PATCH] mfd: sec: initialize driver via
 module_platform_driver
Message-ID: <20210316161703.GE701493@dell>
References: <20210316132515.50588-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316132515.50588-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021, Krzysztof Kozlowski wrote:

> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> The driver was using subsys_initcall() because in old times deferred
> probe was not supported everywhere and specific ordering was needed.
> Since probe deferral works fine and specific ordering is discouraged
> (hides dependencies between drivers and couples their boot order), the
> driver can be converted to regular module_platform_driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/mfd/sec-core.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
