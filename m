Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4018D3F0B62
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhHRTDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhHRTDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:03:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA7C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:02:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so9521446pjn.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMXez8qENPUCcqh2E+tbnIxsJfldRTnwEZLMxK7eXc8=;
        b=c8xDb3VhAM2UIAdOt9z9b/Wbob+uRx0FmaK+KR+eQy6dysj8cv+U6AjDt0EdkZ2361
         8DH+d1rDWQGumbm1weW6y+49EvJQugDSRI7FdsLoB8IhE3fOs/ypXDjAzSXstWItFQdS
         Sg+JSf7LGfFIMpKFsioTnB+5Yd9zSeFnL1wt/K5eceIQNpdkIH1EwOcrvgwzJyOXWWos
         QSlDAw8lC+neFkWd5lG+dmQHIDS+azCTkRHmEuO7o0CkxwEafJmVug5clZwaVVfvyqLN
         IEsJWXSwIhbpmD0ncTiF0WMs5m4PZRisu2xjDEptAD4ngx3oT3b+je2MjsjkUjBHQWE6
         iJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMXez8qENPUCcqh2E+tbnIxsJfldRTnwEZLMxK7eXc8=;
        b=YdXbwLlh2yjPL9GvWqUDhr8f5TAGDS93Vdaf78Qp9yS3brkXe398/80Jiimm8OG/DO
         5ZLuL/4fd1+0XrpEav/haFHmUMrec09M0F1s7ofkyy6nhro8Ke14TmR/Ftl/JiFcu77b
         4mnhYHs16F7oQD/um0xgU5LBnaBe7Tm1/hkqME+QstJs13NTHS9HGcd7i+AjzxZf5Rp1
         y5Jp6Gmsw3vYLZLaVuK99fXE4hcmXK96WhT+PDP1om4c+f7rGPdizYUPC5WkUy/N7glE
         ft4fGp8YkwLDdCWel9XsSfOLkRCSOMySHPtEtx4dAjITIZgyKauB0P982ROrktw/QSRg
         tKcg==
X-Gm-Message-State: AOAM533koXsJ9LGbLxzrN5XoV3HOiv15VjvAQhog4f6i+SszbPFlfUtm
        ctev93r1xJtUAOdeKikqWXwu7OYsNzGj+m2+CZQswQ==
X-Google-Smtp-Source: ABdhPJxSsH7+R4Vr35DJYqsUv8sBHjgia/aPY5AUcIG0AzDMU05I02y0VsRjaBMcpir9IGiJRfjyg9KfwdJpkojrIWE=
X-Received: by 2002:a17:90a:c003:: with SMTP id p3mr10623395pjt.14.1629313354417;
 Wed, 18 Aug 2021 12:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210818171318.1848272-1-robert.foss@linaro.org>
 <20210818171318.1848272-2-robert.foss@linaro.org> <YR1F+I4/JbBAgpwZ@ravnborg.org>
In-Reply-To: <YR1F+I4/JbBAgpwZ@ravnborg.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 18 Aug 2021 21:02:23 +0200
Message-ID: <CAG3jFysiY-w1wXcA=qpjbTKF=2N3tjOND+SvwcLr7b_UZhepGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7625: Propagate errors from sp_tx_edid_read()
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
        Nicolas Boichat <drinkcat@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Sam!

On Wed, 18 Aug 2021 at 19:40, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Robert,
>
> On Wed, Aug 18, 2021 at 07:13:18PM +0200, Robert Foss wrote:
> > During the sp_tx_edid_read() call the return value of sp_tx_edid_read()
> > is ignored, which could cause potential errors to go unhandled.
> >
> > All errors which are returned by sp_tx_edid_read() are handled in
> > anx7625_get_edid().
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index ea414cd349b5c..abc8db77bfd36 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -845,8 +845,11 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
> >                               if (g_edid_break == 1)
> >                                       break;
> >
> > -                             segments_edid_read(ctx, count / 2,
> > -                                                pblock_buf, offset);
> > +                             ret = segments_edid_read(ctx, count / 2,
> > +                                                      pblock_buf, offset);
> > +                             if (ret < 0)
> > +                                     return ret;
> > +
>
> This could be just "if (ret)".
> Same goes for the next case.
>
> With or without this simplification:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>
> I assume you will apply the patches.

Applied to drm-misc-next
