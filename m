Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E27362321
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245310AbhDPOr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbhDPOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:47:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A34C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:47:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id mh2so20981599ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=g0XKUS1TlHQQdNyUmvZMzlYJbLqAhGmFHXulH+uYRNc=;
        b=f2ZDTmiEuxYYa86N6C2qnat3M3pM2bVpaAu8VGRFYHaK2P0DpmovNk6o3hjJWiPUlD
         o7G+UY8ZoobPKwIv1mPIMzcC6jIIsrQnz9MmvkFQQDbJESSFCCtp4DI555jrRDVsnAFq
         lqLTXtBHIRmFIPOJr469vpYRjut7wS7s5Z2I4UdSPsC0JOoF/6nihD0rAqCQGONxFceB
         aIPTbvELdUWV3srRx4qBjZklNeztXm++7k5YcAGOiVoe72zUDwYVB2GZTRtq9cEUzK3R
         h8MDLgKeQtLVZ5EnMn6IxlNxQSD/CSrHJA7qWSnvUh/SU/CIxia85W7Vv0HRuI15Pc9q
         w9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=g0XKUS1TlHQQdNyUmvZMzlYJbLqAhGmFHXulH+uYRNc=;
        b=fUyUv+XZ0iLWUDj8ThkJiX1Tjn8cLaHwogP7KMJyK1ez/kga36NmR85OcoM7G45bHA
         ExvyJ23sq43P021UMnIFF6+2Gs/fYLCfbR0kqVOxbN6sD/WG51On0ePM5x7Le/+eAG2g
         8D+LApdipe92pi8mBigGrfQYtDo7ETtD9QFQso1VtlZWPuRAz67LL6EPCHGuW1It5HRC
         q7GKqGvkw6djLKrhHW4cNesLZc6VYR6LUL+hDXQuw+ZWl8JzYfitah3/L0G3h40AHT+K
         h+692DL0nK4Z5spmAIdesM+Jr1ifn5fNX+nPw3gIOwnKqW2cojgz2iCxsW44ABrUCaQD
         Hk+w==
X-Gm-Message-State: AOAM530yzn3lHOBoQ6rNyg3eQxRlum7QwnndV0fqcK80MqG9qu/5KWoh
        HQ4fq8abYI+uU1Qso45TxyFwvw==
X-Google-Smtp-Source: ABdhPJwK7OS5GZ6fsGB4Jf+dnVda/NwOxPrNHCrgw7AUMQ4UAFFNFcBcXSU20uxtVOc2TeiOy2SjEg==
X-Received: by 2002:a17:906:1c17:: with SMTP id k23mr8876981ejg.266.1618584448071;
        Fri, 16 Apr 2021 07:47:28 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id o6sm5646765edw.24.2021.04.16.07.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:47:27 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:47:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 34/40] drm/exynos/exynos_drm_fimd: Realign function name
 with its header
Message-ID: <20210416144721.GZ4869@dell>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
 <20210416143725.2769053-35-lee.jones@linaro.org>
 <f871839d-6b1b-84b4-19d1-860d209ef193@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f871839d-6b1b-84b4-19d1-860d209ef193@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021, Krzysztof Kozlowski wrote:

> On 16/04/2021 16:37, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/exynos/exynos_drm_fimd.c:734: warning: expecting prototype for shadow_protect_win(). Prototype was for fimd_shadow_protect_win() instead
> > 
> > Cc: Inki Dae <inki.dae@samsung.com>
> > Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> > Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-samsung-soc@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/gpu/drm/exynos/exynos_drm_fimd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi Lee,
> 
> I already sent a fix for this one on 5th of April:
> https://lore.kernel.org/lkml/20210405181524.52426-1-krzysztof.kozlowski@canonical.com/

No problem.  Thanks for letting me know.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
