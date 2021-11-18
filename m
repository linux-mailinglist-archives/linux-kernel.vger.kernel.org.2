Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F73C455E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhKROx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhKROx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:53:26 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D803C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 06:50:26 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id n8so5444447plf.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 06:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ny0uL9iKW5aWaMIzk2WLew51qerbE8sN22vaskeI4V8=;
        b=CVplG+fdNbG2kS4vvPdidKwwzJfLSXrSBRzZyc2c5aUsJqBAJfZ0BxY28Kac68yLQR
         zVF4DoR/6LnJBjJv0OWWcFRNmUuuMuEDH5kd/M08w6GDHLhjVKubbEQlHSaEcp41PJOV
         BvkulN5vl+6OoRglwO0AwTBG5RoVcOSfG+/wfwG4TArDNHOO+jc9LKf2LRbavZ1XDnLt
         wOBo+WPL3pxjdqAjVFJ1jNPy01sc3UgXSJwCMHqGJrK9p6UZbJXjb6ia9RqZG5huoE2G
         RCvK3Fq5Rfx3avvORmG+cORE3AXTx+ppPl0zojQQNsziz5xjayaw27EzSebvW0GnofUg
         waug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ny0uL9iKW5aWaMIzk2WLew51qerbE8sN22vaskeI4V8=;
        b=yKhtF15Ac+uj/3VMANXYSxiL+oair42+aK5hwZz06XNQq2K5Ul0DM3UlqXGxBe6EHu
         8a4bpdT/iSFExBfvdRSuQDgFlIg+q886dEYfnHe/ZN5LNsXsTkEE5RMddH4AJpPHFaVW
         z+RN4zoC2x2wkR19/vjbkE058b1uxj+tDPc05X7LYk1to/cfLkKjQ2x5tvoD6fICoZN7
         aKKWUMC6Ek5XFV79jN4iaiYWINz0MAot5WizsP/ywN+k5fbyTR9rXmniGxvk+4oGw5DA
         3aPmTVuCl8+/7+msTVf9w8l8emT692ly72WdQlObVS/SNSw3Br1V5P0+X18j6CUK2gVy
         g+5Q==
X-Gm-Message-State: AOAM531ei6DJaTV6PyWgVxXAvZDPESNJ95qWimMAvFsS4HNOqgvdl8lV
        b8hPKw0+eMiWW+ff/MJSVfm/STu1I/eFIWl1/YVjZ1sLtAU=
X-Google-Smtp-Source: ABdhPJzRsb5q5FxQnLpMJkOXR2yOgtMl+AskZu+DENNDEPdXtzjxW+yvTcKo+AeNsTJuCPBsF5iCtLEFJLiZeUIk1dc=
X-Received: by 2002:a17:903:2443:b0:142:1e92:1d19 with SMTP id
 l3-20020a170903244300b001421e921d19mr66795185pls.24.1637247026000; Thu, 18
 Nov 2021 06:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20211110220050.2854-1-jirivanek1@gmail.com>
In-Reply-To: <20211110220050.2854-1-jirivanek1@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 18 Nov 2021 15:50:15 +0100
Message-ID: <CAG3jFyvB-Dzd9YDJ7FrAC5avobL7Wfk-91E-DVeYWwfNcQLiLg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge/tc358775: Fix for dual-link LVDS
To:     Jiri Vanek <jirivanek1@gmail.com>,
        Zheng Bin <zhengbin13@huawei.com>,
        Vinay Simha BN <simhavcs@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Zhen & Vinay

This patch looks good in itself, but I would like to see a tested by
tag. At the very least testing for regression in single-link LVDS but
ideally some third party verification of this patch.

On Wed, 10 Nov 2021 at 23:01, Jiri Vanek <jirivanek1@gmail.com> wrote:
>
> Fixed wrong register shift for single/dual link LVDS output.
>
> Signed-off-by: Jiri Vanek <jirivanek1@gmail.com>
> ---
>  drivers/gpu/drm/bridge/tc358775.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
> index 2272adcc5b4a..1d6ec1baeff2 100644
> --- a/drivers/gpu/drm/bridge/tc358775.c
> +++ b/drivers/gpu/drm/bridge/tc358775.c
> @@ -241,7 +241,7 @@ static inline u32 TC358775_LVCFG_PCLKDIV(uint32_t val)
>  }
>
>  #define TC358775_LVCFG_LVDLINK__MASK                         0x00000002
> -#define TC358775_LVCFG_LVDLINK__SHIFT                        0
> +#define TC358775_LVCFG_LVDLINK__SHIFT                        1
>  static inline u32 TC358775_LVCFG_LVDLINK(uint32_t val)
>  {
>         return ((val) << TC358775_LVCFG_LVDLINK__SHIFT) &
> --
> 2.30.2
>
