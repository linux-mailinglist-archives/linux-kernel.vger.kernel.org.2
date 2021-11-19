Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8FC456F77
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 14:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhKSNXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 08:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKSNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:23:01 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053EDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 05:20:00 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 206so3587214pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 05:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIx8aAtrNrpHm8OWpCkJNADibB+h5hdt9mPSxfe3frQ=;
        b=NBOPOh1UgyA0xwXBnfw/SMnAlqEUiz5NamwbuQAdR86j+M49xfYPj6hPk90eVAqXkg
         Wm7TljjkNACGgV/VE28cM1mKpEeoY22sfNhxzZEHC6FToVOVJukRr2YSBwm4w/Lw7ymn
         HyUV4bCPvRTy50/2wdbJ+/zdZaC+G84XFtAg9G7yYrnBUd3Ev+URz3r23urTPghrAjq6
         Hi3VDMvO7h91SaMAANXvV8NaJW7DoI+BDb64wiODq2re9SnrpmoVpwCkZSFuq4Ad4x1M
         WGIM85JKRvRevR3APYHonPgDNAPm03EUOSfX36z4MxvBZGUZm1aJ7j1DUZhR/wuVcCH2
         3sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIx8aAtrNrpHm8OWpCkJNADibB+h5hdt9mPSxfe3frQ=;
        b=MaBHe50+x1SMb/TLq/pfTjehuBVnym81NTU4nLebY0GvxP7HGc7ITKwup4CWXA7kda
         to8hUJlatNU70xMR8G6+euyXBepSWaNtkOx81aniLi0sMRbILzGfBvZM7qTeVJ0PnnOt
         XexqGWkhF4wxqDstPFyJY3NmkSxojk1enwBPJWlbvrci3XnYAZBKMFMGFY6e968Di3a/
         BPlstMJUYA6YJNf9kItbLWqDv21xjkkTBvsVS36Hspzu+DKGMDgCZle7UbFqaC7TBMWj
         dlULbTDK66T7jhp5pBbi2kjWKL0tM73kdnnkGbgveESkCNQwHRBsAROue2JoXJzKdKu8
         LvEg==
X-Gm-Message-State: AOAM533yStZMrgTpX4bTVCk2W1eM5K5rc95Q6i3doLrvReYtU8MpcGWw
        szxZG1KcEMO6c3dlDHzRaSYv7MsWqT0OVvr044oUyQ==
X-Google-Smtp-Source: ABdhPJzIJUQL/YO5ivPl8HQZn3UZcAgecn/QrTLCZHfeWyXnPXA+Zl+OFAICaMhmDozxatXYDSFCYS1upGv0jdxNJnY=
X-Received: by 2002:a63:555e:: with SMTP id f30mr17240737pgm.110.1637327999454;
 Fri, 19 Nov 2021 05:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20211102093618.114928-1-angelogioacchino.delregno@collabora.com>
 <20211102093618.114928-2-angelogioacchino.delregno@collabora.com>
 <d2fe91c8-ab29-7706-80f4-fe6619f07327@collabora.com> <286beb55-00db-ba76-0a51-900d59e2ab34@collabora.com>
In-Reply-To: <286beb55-00db-ba76-0a51-900d59e2ab34@collabora.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 19 Nov 2021 14:19:48 +0100
Message-ID: <CAG3jFyvF7JAm8X42+f2u+ycqdsHLfNH2YebxYSjJJSBdAbc1aw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/bridge: parade-ps8640: Move real poweroff
 action to new function
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Angelo,

On Wed, 10 Nov 2021 at 13:46, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 10/11/21 13:44, Dafna Hirschfeld ha scritto:
> >
> >
> > On 02.11.21 11:36, AngeloGioacchino Del Regno wrote:
> >> In preparation for varying the poweron error handling in function
> >> ps8640_bridge_poweron(), move function ps8640_bridge_poweroff() up
> >> and also move the actual logic to power off the chip to a new
> >> __ps8640_bridge_poweroff() function.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> ---
> >>   drivers/gpu/drm/bridge/parade-ps8640.c | 37 ++++++++++++++------------
> >>   1 file changed, 20 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c
> >> b/drivers/gpu/drm/bridge/parade-ps8640.c
> >> index 8c5402947b3c..41f5d511d516 100644
> >> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> >> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> >> @@ -293,6 +293,26 @@ static int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge,
> >>       return 0;
> >>   }
> >> +static void __ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
> >> +{
> >> +    gpiod_set_value(ps_bridge->gpio_reset, 1);
> >> +    gpiod_set_value(ps_bridge->gpio_powerdown, 1);
> >> +    if (regulator_bulk_disable(ARRAY_SIZE(ps_bridge->supplies),
> >> +                   ps_bridge->supplies)) {
> >> +        DRM_ERROR("cannot disable regulators\n");
> >> +    }
> >
> > That '{' is redundant
> >
> > Thanks,
> > Danfa
> >
>
> Hi Dafna,
> the braces were added as a way to increase human readability.

Not to bikeshed this, but the kernel style guide is clear about this.
No unneeded braces should be used where a single statement will do.
