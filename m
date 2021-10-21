Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3BF436C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 23:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhJUVJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 17:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJUVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 17:09:25 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91196C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 14:07:09 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id l201so2247425ybl.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yYwJb9ifQ9bmoE69QsAf8gqXf8CKWrMVHpOE+bbaoY=;
        b=hF6934KLm3FVSB1ofYwcdSTKcvZU3Z7gKkb+XbGqWMW34B48+xHPUmf9KYJtSBUNp3
         tyT14Egp0c3eT5G2DandkyurtPePopEutOv3Nvkx7l0RRmj0qJrh3gqrDIR8F+ca5ehJ
         8otBqYbXOIr+t6yaCAxdvp5QvvMruLCeVNq/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yYwJb9ifQ9bmoE69QsAf8gqXf8CKWrMVHpOE+bbaoY=;
        b=jXKp6T5vKag5D0vlqQtnFIEaDDqS6lNAloEWMNkd7kzo08uDjZKml3bv/6FYpQRHrM
         v6S0v6waUMZ/TpPB9b5ONiH9m3T7oB/xsrGnVcsQoHLonsDTWEeUfFKbz/QdD244LHWk
         Hqm2AGUGIKDGW9IZIzO63/BK2ZNy3LXhi3Tclm9cwQgtuVG3e4qIZ9w9t3V7qzg3/SAQ
         nNgUSlOtCKFxIrGGzgIvrAp8DmjvqNtg0ZLu/CkNuKVQly9FkFES5IGDwUpLqeh1+PVK
         FOBiMr9KtXyjoEC3bE4lR4yPic6NO/wVs+l3aCSIWQMVkXXNVRqTLh87RR1zr5sbVQww
         9pSA==
X-Gm-Message-State: AOAM5307umodcd1XhSDwr9xp+Hmq2Kv2QEPAA0seG/xsBuE+DWwRSbLo
        grw+T6zO4CVkZx7LoibHHutGEnoecK+YBVrNXuymWg==
X-Google-Smtp-Source: ABdhPJxC1SA3pDCdYRqLN2A2ZixcYc5cdrrDDFqm8aVnl+KEFD3kuZJ1czAXMskWv6WpHsQ7T6cZKb5q3RwyhVIx47I=
X-Received: by 2002:a25:c046:: with SMTP id c67mr758091ybf.388.1634850428382;
 Thu, 21 Oct 2021 14:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211016095644.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
 <CAD=FV=V7+MzyjsLKE87c=8bkFiRbQkGoM4Jfm8jcsJBG0aYAWw@mail.gmail.com>
In-Reply-To: <CAD=FV=V7+MzyjsLKE87c=8bkFiRbQkGoM4Jfm8jcsJBG0aYAWw@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Thu, 21 Oct 2021 14:06:57 -0700
Message-ID: <CA+cxXh=jeT-t4o48Uv0xojsEP2erL6Aqw2XfYpnUa-SWdcVnfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: parade-ps8640: Enable runtime power management
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Mon, Oct 18, 2021 at 1:43 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sat, Oct 16, 2021 at 9:57 AM Philip Chen <philipchen@chromium.org> wrote:
> >
> > @@ -319,81 +345,70 @@ static void ps8640_bridge_poweron(struct ps8640 *ps_bridge)
> >          */
> >         msleep(200);
> >
> > -       ret = regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
> > -                                      status & PS_GPIO9, 20 * 1000, 200 * 1000);
> > -
> > -       if (ret < 0) {
> > -               DRM_ERROR("failed read PAGE2_GPIO_H: %d\n", ret);
> > -               goto err_regulators_disable;
> > -       }
>
> Above the "msleep(200)" I see a comment that says "and then check the
> MCU ready flag every 20ms". That probably refers to the code that
> you're moving here. Maybe change the comment above the "msleep(200);"
> to something like this if you like it:
>
> /*
>  * Mystery 200 ms delay for the "MCU to be ready". It's unclear if
>  * this is truly necessary since the MCU will already signal that
>  * things are "good to go" by signaling HPD on "gpio 9". See
>  * ps8640_ensure_hpd(). For now we'll keep this mystery delay just in
>  * case.
>  */
>
Thanks for the review.
Added the comment in v2.
PTAL.

> Other than that this looks good to me, which isn't really a surprise
> since I was involved in helping with / reviewing early versions of
> this change. In any case, I'm happy with:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
