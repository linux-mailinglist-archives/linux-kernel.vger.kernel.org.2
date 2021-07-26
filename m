Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA2B3D6738
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 21:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhGZSXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 14:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbhGZSXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 14:23:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EB6C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 12:03:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u3so17311486lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14vdBBpljswALd6WKvqBt7tFyvQ5ydfoUw2eohntOGo=;
        b=qr/oz3dOYzpxblqZamgqeUQV67KgrORlntTWUQXhSAVTTuudpwKAHkt0Njz8IWdCa5
         tFmKUy6vgWUzhEWiYjj9VHpn218PYKvboIGwLPwgATII1NluyNvG3sLr8WqkOPUegSn8
         1DLx7OTUwasmBowM8A3ZxfWCr7JyjT2BetV4TBOgULIR13lkYUqVU4YgzLt5kGrzrWc4
         pbpZgQhfuQcPneenrAeRA9mjOx+sz5Xzj3nYbQaNkg9+ZpZKmfrsmVMqX8OG3YTksYjx
         0FisoIpgnLvb/c2KKdLHUdYC318jJw3FlpsnDSD0niHtYIsyHRnPCZhQJ1joZYJ2AFFu
         L52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14vdBBpljswALd6WKvqBt7tFyvQ5ydfoUw2eohntOGo=;
        b=f6WVw0VP/zsl7/iYfTysjp20aGZUcFxUdBjTsogv9k4RA/xUCIk//S6LrhaP74GlOu
         0UuMszN/MdOjD91jRpc9qmKg4i0sTMRXI7ubk06T0cpNGH5l8jjsoCvfJlQquKTWylE3
         10qm7slT6rOZe5RjEC94wXu2EfkKWNkTtzFTbAbdkI6rDTv4BvGsYdYiHNpuKDrUWl0G
         mkFGIihohNU8tySnpAq8+qkvc8R8n97G58XyVhoPloujzSkHDKzDPoqa0P6Y9VR13oWq
         8oXSu+Z5lhCRElxU80MAZfROi+FcEUlLeaULNzL+o7WtybXIMy17kz/rE3Jv7+33f4RQ
         uXZw==
X-Gm-Message-State: AOAM531VG1zircZ8p6Hdfo7N7A0BowmmEsS6LoFdXTZj15b/nA2kDHhe
        zBZyev0SrX0rTjvlja6iFYeFtnazhKnCYdFo8x2CrA==
X-Google-Smtp-Source: ABdhPJxaH39aX5F+AW541px6IFsSJ4Z9AkqxaTvrVN21I+A8CZpuVp2u0lP5Jp+e5r6g4ryqUw8a/GHNku+u6Tk+ckI=
X-Received: by 2002:ac2:4a66:: with SMTP id q6mr13551699lfp.204.1627326222269;
 Mon, 26 Jul 2021 12:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210707180113.840741-1-robdclark@gmail.com>
In-Reply-To: <20210707180113.840741-1-robdclark@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 26 Jul 2021 12:03:30 -0700
Message-ID: <CALAqxLVLV8cLVTOFPZmzKeDaG0qFoQ6H=+2a8LaAvgs+4EYMfw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix display fault handling
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 10:57 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> It turns out that when the display is enabled by the bootloader, we can
> get some transient iommu faults from the display.  Which doesn't go over
> too well when we install a fault handler that is gpu specific.  To avoid
> this, defer installing the fault handler until we get around to setting
> up per-process pgtables (which is adreno_smmu specific).  The arm-smmu
> fallback error reporting is sufficient for reporting display related
> faults (and in fact was all we had prior to f8f934c180f629bb927a04fd90d)
>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reported-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Fixes: 2a574cc05d38 ("drm/msm: Improve the a6xx page fault handler")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Tested-by: John Stultz <john.stultz@linaro.org>
> ---

Hey folks!
  Just wanted to follow up on this, as it's still missing from
5.14-rc3 and is critical for resolving a boot regression on db845c. Is
there anything keeping this from heading upstream?

thanks
-john
