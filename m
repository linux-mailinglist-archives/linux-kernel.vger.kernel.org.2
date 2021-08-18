Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B463F08D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhHRQQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhHRQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:16:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30872C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 09:15:27 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id x4so2761589pgh.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fou5W5VkNbeojY0yT6dY7k2y4ndU7zMQiVWUILWOmhw=;
        b=NrjlawxUIhVfs1YgkMgTNaXijzUTHfc/+2IlHL5a4sQFv3OYE5/x6tDcmJCLxkReRA
         1VvWT0fXdyd9ZwuoOkcLJYgzIUVSg4m8gNfkOCvRLH1BByGXepKRZuLV0W8rho220hZT
         Lcek/Yoer9DeC2s4LX+bZhfj568ShUsIiR7P62bTyMI/9rQZIkX6CyEZGUD9w0JTrSmj
         7PrcJILjEL7kIMLB4Sd0znQSSA+SGZmyvpLT4GKZTwxmH/8i37LuDghlIMklWu6BKcnY
         wGeeyMXBsoT2OKpldWCHaizkohBK0uGmh3OmXjSB/IPUsE42smvqu1hCvTTqYmd/jFLg
         fEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fou5W5VkNbeojY0yT6dY7k2y4ndU7zMQiVWUILWOmhw=;
        b=DR66/KGhV2foBkWBTBgFRQ3lLxSC6J6wuA668r+TsEJMPLFtyg7/Ddh6+qcAp0M8O1
         7yotYK0Om5Nuc/ASKAW6JLxvStZe1bJ08dCC7bc1h+iK0AKsH2J//yy/Wnqzw6MbI2SE
         fwWsN+nGF85hBxROpzBsqI7sgsZ8MDXscWt22AW++fU9NH0TRaCfV9bkaibcl4Iv9zCV
         39GInVRBaeLk67hZieCFh1mqM/IGPO258kAe3XQwADmn68GmYM6sEUz9WGx2opuIi3vx
         wJomc5OCa8oz85dKWsVHmRGHv3KIFVLXuIq6cNxu8X6B2DKvx+FZYMFQSI+bDGL/Q1zM
         QyUA==
X-Gm-Message-State: AOAM530XeVVuY2cqeFAPSCpaoUIA20x7lgPjp9Zkz8BMQL6Xqf5fz7nt
        X2BjoaaAbycf0xuKvbt0XxgSwgNlCP+DXCD2fRzuLQ==
X-Google-Smtp-Source: ABdhPJxQOkgSduv2w4asHeJEz2hvMWg61KbgWeOVpPnbQEzpqYnUiAjZcsKLoiwKiGQDyONVlICJCr7vo6mMQMN3ZPU=
X-Received: by 2002:a65:5ac8:: with SMTP id d8mr9525008pgt.34.1629303326679;
 Wed, 18 Aug 2021 09:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210816111451.1180895-1-robert.foss@linaro.org> <YRqKRu6UVNy8OZh1@ravnborg.org>
In-Reply-To: <YRqKRu6UVNy8OZh1@ravnborg.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 18 Aug 2021 18:15:15 +0200
Message-ID: <CAG3jFyudSGJ3+HqgEF6i2XpcfZGVwy3V8GuepUY2+0pc7VSZOQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/bridge: anx7625: Don't store unread return value
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sam,

> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 14d73fb1dd15b..3471785915c45 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -771,7 +771,7 @@ static int segments_edid_read(struct anx7625_data *ctx,
> >               ret = sp_tx_aux_rd(ctx, 0xf1);
> >
> >               if (ret) {
> > -                     ret = sp_tx_rst_aux(ctx);
> > +                     sp_tx_rst_aux(ctx);
> >                       DRM_DEV_ERROR(dev, "segment read fail, reset!\n");
> >               } else {
> >                       ret = anx7625_reg_block_read(ctx, ctx->i2c.rx_p0_client,
>
> From a quick look this seems to be the wrong fix.
> Replace return 0; with return ret; as the last line in this function
> looks like the correct fix to me.
> With a careful audit that the error handling is OK in said function.

Thanks for the suggestion, let me have a second look at it.

>
>         Sam
