Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF5B3AECAF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFUPnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhFUPnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:43:19 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00582C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:41:03 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id m15so1748920qvc.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0uexkxIgdtHcO0ywotPaMOdh8zJX+zJKl2s1rN2kxP4=;
        b=Vb0tHd5FNrMGZngLgPioQ5Lf5mzLJ1TAl80ByD4WgWO2DdFh+ZrfYmQIySSmJVozbK
         RLeGWHe7LS62+BRz59Ieu0NlqiSGStoq4hbQWMoSGCpk8oTwERzt9iHDgY+LX3n8TVZj
         +FNUtZTkqzGDUvY3Mdz6FUgSV9JQxIVcAO5G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0uexkxIgdtHcO0ywotPaMOdh8zJX+zJKl2s1rN2kxP4=;
        b=TSkWXTzQX9MfdSndjNt/KajR8LSshW1IqaB8/qQFF1vlwxzkozm9TZPSA5dtG8BbRe
         fdBb5DFjZ858c+ZmkwTz49qivvhTNNCu3wLkon2NLktk4qYLj+fG8SeBM8nHqo350FDi
         kDUqY9kw5PQ9FoaSHgHW65y+afg9PPERESuEqFPRajyN+ZceYr2Zt8rqJU+4MacMA41m
         VijmCYtm2OHWvPBzbhZPeyUPjrCzRWBrwaQy/hkz1SDfdoruL55OBmfISta7J08JG5rn
         DFZdF9aLsPro8JXQ8Be1iVvy+1BgaLdRrgVHVNzBuTyWd38wLCmmeObjKFTfAheJaj92
         l8tQ==
X-Gm-Message-State: AOAM532NbcioOBXEyym/v/axu83k6Kg5NtVv8mUH8vY8QsCpNVT5T8sc
        b1i34z3sh3MBgq3BWathh1LRYoKiiZLRBw==
X-Google-Smtp-Source: ABdhPJwGte2+I3lsd8Fc3tKJluq31V46ZNuqlG/q6eujo3VoBxgfqwCCYnMPwqOywgdYFYMgGp81IQ==
X-Received: by 2002:a05:6214:21ea:: with SMTP id p10mr20289456qvj.16.1624290062956;
        Mon, 21 Jun 2021 08:41:02 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id o10sm1814563qtv.62.2021.06.21.08.41.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:41:02 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id j184so31594668qkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:41:02 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr32287432ybp.476.1624289703701;
 Mon, 21 Jun 2021 08:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <1624099230-20899-1-git-send-email-rajeevny@codeaurora.org>
 <1624099230-20899-6-git-send-email-rajeevny@codeaurora.org> <20210620100147.GB703072@ravnborg.org>
In-Reply-To: <20210620100147.GB703072@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Jun 2021 08:34:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VP8hLHtpZ8F5KVGWoKiJBxyQVufg7V9A2CC0rwcAX-aw@mail.gmail.com>
Message-ID: <CAD=FV=VP8hLHtpZ8F5KVGWoKiJBxyQVufg7V9A2CC0rwcAX-aw@mail.gmail.com>
Subject: Re: [v7 5/5] drm/panel-simple: Add Samsung ATNA33XC20
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Rajeev Nandan <rajeevny@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 20, 2021 at 3:01 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Rajeev
> On Sat, Jun 19, 2021 at 04:10:30PM +0530, Rajeev Nandan wrote:
> > Add Samsung 13.3" FHD eDP AMOLED panel.
> >
> > Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v4:
> > - New
> >
> > Changes in v5:
> > - Remove "uses_dpcd_backlight" property, not required now. (Douglas)
> >
> > Changes in v7:
> > - Update disable_to_power_off and power_to_enable delays. (Douglas)
> >
> >  drivers/gpu/drm/panel/panel-simple.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 86e5a45..4adc44a 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -3562,6 +3562,36 @@ static const struct panel_desc rocktech_rk101ii01d_ct = {
> >       .connector_type = DRM_MODE_CONNECTOR_LVDS,
> >  };
> >
> > +static const struct drm_display_mode samsung_atna33xc20_mode = {
> > +     .clock = 138770,
> > +     .hdisplay = 1920,
> > +     .hsync_start = 1920 + 48,
> > +     .hsync_end = 1920 + 48 + 32,
> > +     .htotal = 1920 + 48 + 32 + 80,
> > +     .vdisplay = 1080,
> > +     .vsync_start = 1080 + 8,
> > +     .vsync_end = 1080 + 8 + 8,
> > +     .vtotal = 1080 + 8 + 8 + 16,
> > +     .flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,
> > +};
> > +
> > +static const struct panel_desc samsung_atna33xc20 = {
> > +     .modes = &samsung_atna33xc20_mode,
> > +     .num_modes = 1,
> > +     .bpc = 10,
> > +     .size = {
> > +             .width = 294,
> > +             .height = 165,
> > +     },
> > +     .delay = {
> > +             .disable_to_power_off = 200,
> > +             .power_to_enable = 400,
> > +             .hpd_absent_delay = 200,
> > +             .unprepare = 500,
> > +     },
> > +     .connector_type = DRM_MODE_CONNECTOR_eDP,
> > +};
>
> bus_format is missing. There should be a warning about this when you
> probe the display.

Sam: I'm curious about the requirement of hardcoding bus_format like
this for eDP panels. Most eDP panels support a variety of bits per
pixel and do so dynamically. Ones I've poked at freely support 6bpp
and 8bpp. Presumably this one supports both of those modes and also
10bpp. I haven't done detailed research on it, but it would also
surprise me if the "bus format" for a given bpp needed to be specified
for eDP. Presumably since eDP has most of the "autodetect" type
features of DP then if the format needed to be accounted for that you
could query the hardware?

Looking at the datasheet for the ti-sn65dsi86 MIPI-to-eDP bridge chip
I see that it explicitly calls out the bus formats that it supports
for the MIPI side but doesn't call out anything for eDP. That would
tend to support my belief that there isn't variance on the eDP side...

Maybe the right fix is to actually change the check not to give a
warning for eDP panels? ...or am I misunderstanding?


> The bpc of 10 in unusual, the current code warns if bpc is neither 6 nor
> 8. If 10 is correct then update the code to accept bpc=10.

I'm pretty sure it's 10 based on this panel's datasheet, though this
panel also accepts 8 bpc. Fixing the warning seems like a good idea to
me--I wasn't aware of it.

-Doug
