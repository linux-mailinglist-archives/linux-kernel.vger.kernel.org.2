Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F017309694
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 17:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhA3QSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 11:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhA3QRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 11:17:03 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEAEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 08:16:22 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id t63so11921579qkc.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 08:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejssOulrsTZ3ouHbrBBarxFuH2SuoMwxOAnWZQut8vY=;
        b=fmLNhBeiMEpCT64iXb708ra7uyU/Zu3j1K6JAv36RVHp01n5CleHqXKzoT74F9zaKL
         wncl6lJDD/PlSfUmmKmJdnMKUoo797O6FRVEjLRnyufjvFId6qRLeJQlRkiG6ypIC5+B
         fE5+v0pAHXXbvTEC65/I2ZAMahOFJe4XIbIutYTHZs4bANICZZw7g+HNQ5VwlgpOMUtv
         C1+rSGClaWl1qjmgmV0TJB9xn/iFlgNVbxQpxd+1m3AYeijxvhrI0sT6EDqPsgSEcUUO
         72tMlzC4kQ4hJFXavIUisZ1M3dK7Yf0icFZeWv9toAeRTyfhzKK252rM9jUJSt6+cdA7
         a77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejssOulrsTZ3ouHbrBBarxFuH2SuoMwxOAnWZQut8vY=;
        b=WFuTK0heJ8uA28+7H2Ir4h9G8lOCnTN6z2b2cY9y2c5VgF4t8PV5XR1hn2rrct1Ppn
         WUTjisyCoYp1zE18deqMtT71UEgV1SAEdJ0uAa3UY7D7dVJYXA99eVgA0E5yQHrrjVnX
         uzk4ziyHoFICUPdWVeqCySQvzDqgyG8OeLDKlNV3c751IeX9sXFaVxKbqvZyzN1mF2wT
         AD6lp0IvMlw4sCdzZ546Gk2o1ppGJIbEq3PeDsmo39NZZs5E/MnWHhq/P8taj2TBJF7k
         AQnnUtpovDrvN1g6ir/qH29xNxckqyc7kLjWSSeVRw8uHhPanwXjUft4iyy8/5MNd4uh
         6Wpw==
X-Gm-Message-State: AOAM531q8VgV36Ig7cXXKSKDkHvl5zBh0yEvENTqW7JEcUiTE2a8FZ59
        I4Zx9UeTXhCbrC2PFds3xU32N2REAJSBmxMjmzZm9WDmfLKGhg==
X-Google-Smtp-Source: ABdhPJxjFzuwpFzrLhh+nGrXrs4raiQtDHat0NUdPD5KVJSQnlTf0MuHS/yGpjPuaALH/of+u93L6laMiPrv5cVnAro=
X-Received: by 2002:a05:620a:ec2:: with SMTP id x2mr8981436qkm.138.1612023381824;
 Sat, 30 Jan 2021 08:16:21 -0800 (PST)
MIME-Version: 1.0
References: <010101750064e17e-3db0087e-fc37-494d-aac9-2c2b9b0a7c5b-000000@us-west-2.amazonses.com>
 <508ae9e2-5240-2f43-6c97-493bb7d9fbe8@linaro.org> <eda75757-5cf2-14a7-3de4-ca57eb099cfd@squareup.com>
In-Reply-To: <eda75757-5cf2-14a7-3de4-ca57eb099cfd@squareup.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 30 Jan 2021 19:16:10 +0300
Message-ID: <CAA8EJprOYwe8pSc+QzptVjxWKiTG-jGxoUh0aa5JTGq-4nnt+g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: save PLL registers across first PHY reset
To:     Benjamin Li <benl@squareup.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Harigovindan P <harigovi@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        zhengbin <zhengbin13@huawei.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Anibal Limon <anibal.limon@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jan 2021 at 05:00, Benjamin Li <benl@squareup.com> wrote:
>
>
> On 10/30/20 6:55 AM, Dmitry Baryshkov wrote:
> > Hello,
> >
> > On 07/10/2020 03:10, benl-kernelpatches@squareup.com wrote:
> >> From: Benjamin Li <benl@squareup.com>
> >>
> >> Take advantage of previously-added support for persisting PLL
> >> registers across DSI PHY disable/enable cycles (see 328e1a6
> >> 'drm/msm/dsi: Save/Restore PLL status across PHY reset') to
> >> support persisting across the very first DSI PHY enable at
> >> boot.
> >
> > Interesting enough, this breaks exactly on 8016. On DB410c with latest bootloader and w/o splash screen this patch causes boot freeze. Without this patch the board would successfully boot with display routed to HDMI.
>
> Hi Dimtry,
>
> Thanks for your fix for the DB410c breakage ("drm/msm/dsi: do not
> try reading 28nm vco rate if it's not enabled") that this patch
> causes.
>
> I re-tested my patch on top of qcom/linux for-next (3e6a8ce094759)
> which now has your fix, on a DB410c with HDMI display and no splash
> (which seems to be the default using the Linaro SD card image's LK),
> and indeed it is fixed.
>
> I assume you already also did the same & are okay with this going in.
> Appreciate the testing!

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested on RB5 and Dragonboard 845c (RB3).




-- 
With best wishes
Dmitry
