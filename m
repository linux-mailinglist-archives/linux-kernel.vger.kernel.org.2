Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64243E9991
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhHKUQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhHKUQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:16:03 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B95C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:15:39 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id e13-20020a9d63cd0000b02904fa42f9d275so4870842otl.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWE7VU12/NhLSBAI8reKko5Lx0IBplhjTzD3kMB00EQ=;
        b=P4atp6Byus8ywoOtAxCzKdkVerEWlZHWkngS5sUUeS1oErbXcKQDkvLycigkOwbATu
         +0GdVkWAm+ZElen6tpvEEhcTw+rjsYTf4Rz6D0jydxqjgjNQvB+VsEi4TVSTvm7aUr8y
         xq00/B3axowAqsBSJqwDUa8QTmy0cb0ID700mTdV4+fkURzTmPs/DSpCyr/4pLX+F7zD
         uenIqFqCuDZjbpGY2ZiyLRcUIP9hEGmgQ9c++rkP0kghcWDewUg3gGDHHrauUCMCNh0u
         ddfOqxV6HyBBRXR1SmAkQ5Dj/MBLYKMex7fUFpYcxTIRiQ/ulQI2LteBKmiu/ywpaA5Z
         iaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWE7VU12/NhLSBAI8reKko5Lx0IBplhjTzD3kMB00EQ=;
        b=Y2S89LH1VNwv/TasS71hF2tPmawiKPm3tmOobaiFuy2sPhJg3I+tjQIlxv1S1VcARV
         cSIPZKrnRyDsC2hczkxzLk4uQtkrCCejZU/qqaLusO8kdhJD8hBHUN9S4roL4ksCxLZh
         WQH8QlJH+63G44L32sAZ1+2DsIxDYfXTOgeD/kBe73QsT5Rt0e3cIe/8uP3ANrHkBMgF
         FVpj8wVKBIO1ZvYw8p+Ia/lq1otOOKZjrxHzFc3PQ8peksObPuEUX8kQAmfy+EcT2/Lg
         H91WHitHTIT8/U+t66goF0b/KyQFxxEebuhnEyqzuNMY1jEx+BLeqCHIdBe9VPuXHzQ8
         dhlw==
X-Gm-Message-State: AOAM5324NZCcCrgc294gxEEVHij+S/Lmu0rNWl9oqg7AGcl5LG5bWYhP
        ikaCu1SftXBul8GN32va2x6sXT3Ko0ZuwA1eQA8=
X-Google-Smtp-Source: ABdhPJwbYKEtMSc9HcmOT5BNGXm46YWUdTewMbKaIafAI/rx1XUQvEO94dA0H3phXzRueFDZViGWKSUq1IvCzn0HJFQ=
X-Received: by 2002:a05:6830:1e78:: with SMTP id m24mr555941otr.23.1628712938940;
 Wed, 11 Aug 2021 13:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210811113458.6940-1-islituo@gmail.com>
In-Reply-To: <20210811113458.6940-1-islituo@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 11 Aug 2021 16:15:27 -0400
Message-ID: <CADnq5_M5jS2LNhH1im_KSgraTF3Z858PXTxvke45-7ZAnANOMA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: amd: amdgpu: amdgpu_i2c: fix possible
 uninitialized-variable access in amdgpu_i2c_router_select_ddc_port()
To:     Tuo Li <islituo@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Tuikov, Luben" <luben.tuikov@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Aug 11, 2021 at 7:35 AM Tuo Li <islituo@gmail.com> wrote:
>
> The variable val is declared without initialization, and its address is
> passed to amdgpu_i2c_get_byte(). In this function, the value of val is
> accessed in:
>   DRM_DEBUG("i2c 0x%02x 0x%02x read failed\n",
>        addr, *val);
>
> Also, when amdgpu_i2c_get_byte() returns, val may remain uninitialized,
> but it is accessed in:
>   val &= ~amdgpu_connector->router.ddc_mux_control_pin;
>
> To fix this possible uninitialized-variable access, initialize val to 0 in
> amdgpu_i2c_router_select_ddc_port().
>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> index bca4dddd5a15..82608df43396 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> @@ -339,7 +339,7 @@ static void amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
>  void
>  amdgpu_i2c_router_select_ddc_port(const struct amdgpu_connector *amdgpu_connector)
>  {
> -       u8 val;
> +       u8 val = 0;
>
>         if (!amdgpu_connector->router.ddc_valid)
>                 return;
> --
> 2.25.1
>
