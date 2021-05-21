Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEAF38D073
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 00:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhEUWDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 18:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhEUWDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 18:03:50 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2628CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:02:27 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u11so21030859oiv.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=BDWzJy96GRZhQjoib8vzzXu2wXMhgadWs9pgCSJ6fsU=;
        b=ZL1P3RcabmCpSMTBuX3Ap/4eI2kv9YvrUkO90pGNBu364b+TOSAymdUKfVrGf2ExT0
         OQamP4ycPJARM/qhO9HKpksIjM9e4rsAEgAseJOvcGiK6n0DzHYpXEsnAa9II2QZAYRQ
         ofOyLBiRQhZLVQUj+hO7yuT6j5jJlnaEPr4XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=BDWzJy96GRZhQjoib8vzzXu2wXMhgadWs9pgCSJ6fsU=;
        b=DNri7Sl4/ty9xdZc3p341gI/TO5FvATQt/M6zVSBzC0rNFMTrDV5zwuoAucRH/+0wO
         8ai1JgyRCQdCl12zvkzr/cOebJ2Jzz4yVa1H8NqLvHSjIrGxmV+5ZItyrpzadXwwsesJ
         BUkvBcEXEInKDBtD6tcxy2mwP9mfiMBZypC2uwrgBXRs8QVImjdPLA1ojgQdGESiuf99
         /cMdiZsxJ6BsZv0irKkjHfI21pQgbVhB1jRAT+XT+TK1+7IyjnxAGGVVamQlJ1GKfCRK
         BI0P7pBVbDiB9AiYUmajae3O1+mnvnCauWIaq42u5U110F28rlIIrNtimgIE6H0zcpGQ
         jT+g==
X-Gm-Message-State: AOAM531qDz7S3DCkxtcE9Lx4+VytenfmXnRE8wt23FpIPEtMxUMEFCr+
        ZHsLTvIwDffiBBuS/3sSJKX0bmDQF22v3UQmcqSWsA==
X-Google-Smtp-Source: ABdhPJxh0vu/e6eESsibJjJILbZzCRD/2LOT2bhTh71e3wvyG25ltZwaMoeOeDpKLlXreBvUibMN9KsYVsL5734xZFA=
X-Received: by 2002:a54:4501:: with SMTP id l1mr3714709oil.19.1621634546583;
 Fri, 21 May 2021 15:02:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 May 2021 15:02:26 -0700
MIME-Version: 1.0
In-Reply-To: <20210521134516.v2.1.Id496c6fea0cb92ff6ea8ef1faf5d468eb09465e3@changeid>
References: <20210521134516.v2.1.Id496c6fea0cb92ff6ea8ef1faf5d468eb09465e3@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 21 May 2021 15:02:26 -0700
Message-ID: <CAE-0n52xEDak4-vuJQ6SQz83F54-oTm+TjeVJ_0GoezG8O_M5Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm: Use nvmem_cell_read_variable_le_u32() to read
 speed bin
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-05-21 13:45:50)
> Let's use the newly-added nvmem_cell_read_variable_le_u32() to future
> proof ourselves a little bit.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> The patch that this depends on is now in mainline so it can be merged
> at will. I'm just sending this as a singleton patch to make it obvious
> that there are no dependencies now.
>
> Changes in v2:
> - Rebased
>
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index b4d8e1b01ee4..a07214157ad3 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1403,10 +1403,10 @@ static int a6xx_set_supported_hw(struct device *dev, struct a6xx_gpu *a6xx_gpu,
>  {
>         struct opp_table *opp_table;
>         u32 supp_hw = UINT_MAX;
> -       u16 speedbin;
> +       u32 speedbin;
>         int ret;
>
> -       ret = nvmem_cell_read_u16(dev, "speed_bin", &speedbin);
> +       ret = nvmem_cell_read_variable_le_u32(dev, "speed_bin", &speedbin);

I missed the review of this API, sorry. I wonder why it doesn't return
the value into an __le32 pointer. Then the caller could use
le32_to_cpu() like other places in the kernel and we know that code is
properly converting the little endian value to CPU native order. Right
now the API doesn't express the endianess of the bits in the return
value because it uses u32, so from a static checker perspective (sparse)
those bits are CPU native order, not little endian.

>         /*
>          * -ENOENT means that the platform doesn't support speedbin which is
>          * fine
