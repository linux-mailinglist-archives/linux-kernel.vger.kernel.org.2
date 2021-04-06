Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B1835584C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244180AbhDFPlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbhDFPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:41:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB91C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:41:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dd20so9924846edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jdSXgDFnEhFp1GgWfxi+0AUKeEGMkg1AM1HZd0zVMr0=;
        b=vV4v3Hdqx3j89pE9YeXti23kSKF0V308DmpUYyHicItE4bI6Cmm58T8RbbLF7H+Dfn
         BV42yaCtpbvBoaBrCi/B2pHIX8WIzCmhAVLc19eFU4E6c2hLvytX9Ni5RpLy7IF35zHf
         A/iuk6aKVQrGK5yyF/Yc11gUIhsHuitDoJHjq83sub7MTKINNGHgNfFlm9KjTpPbeyC5
         +Lu8QueRG7Jsu/H6KCXG9j+ZhAHwrbZz1OOhdJwPIeHKOnRWY5+FIcy/YWqwk3cDMEax
         iJ8yr80JKZDtgW4NiNMCU1eSXm7bbo2/qSeii4f3A5+5D7kifeUHSUuGCN7tXEQHXqFt
         WYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jdSXgDFnEhFp1GgWfxi+0AUKeEGMkg1AM1HZd0zVMr0=;
        b=PqfATkNMCZcM9+pD33ki9hq0Nq44JDqD14Fp05spIb7V5dw91GeBlh+SWpxB8jrG21
         fSHbJxbQiHR2ecomdJvYoqGE0Xuhw8kAd4qabDTmplByU9ICYt+IWP2BCIUFSlUGLmsX
         CgXRY24s+SKovKxC78SJ5zfU+3hmPwSdZnImDgtU1XG5G+oa9p+YiTcD7RYLJYAbTilD
         jdJA7ovNU9l5bKjQBdWonKUtoFDPcdccIU/ycSX6IzlkrZLuMa2OJXVGOyLrtqMWJVEC
         vWs/Dsv/NBgyVWAdMt+tShkzLyRn/Plh+299GLmRZJX5f32Y/tk2u5q6KXg8GKRFYsPa
         3FkA==
X-Gm-Message-State: AOAM531HYxm8xneKzfnSYSb7Mzhg40ikJ60ZzMg4iVEw8GtnmpQKgGUm
        fT6Bzs++7w3y0AxD1EN4BfP9nk4Un15QQ3eD
X-Google-Smtp-Source: ABdhPJzTvV+CkENJn02Mi2f82o05WdPtMaVhazS4bj/gy03Y8sxkely8Q8OwU/CcrbqnLIuydy0IbQ==
X-Received: by 2002:a05:6402:57:: with SMTP id f23mr37974237edu.323.1617723700259;
        Tue, 06 Apr 2021 08:41:40 -0700 (PDT)
Received: from dell ([91.110.221.193])
        by smtp.gmail.com with ESMTPSA id w13sm1541566edx.15.2021.04.06.08.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 08:41:39 -0700 (PDT)
Date:   Tue, 6 Apr 2021 16:41:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: core: Use acpi_find_child_device() for child
 devices lookup
Message-ID: <20210406154138.GX2916463@dell>
References: <20210406123220.71075-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210406123220.71075-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Apr 2021, Andy Shevchenko wrote:

> Use acpi_find_child_device() for child devices lookup in mfd_acpi_add_device()
> instead of open coded approach. No functional change intended.
> 
> While at it, amend a note comment, since usage of _ADR is found on other
> platforms and tables than Intel Galileo Gen 2, in particular USB wired devices
> are using it, according to Microsoft specifications for embedded platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> Validated on Intel Galileo Gen 2.
>  drivers/mfd/mfd-core.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
