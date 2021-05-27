Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57952393812
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 23:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhE0VnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 17:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhE0Vm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 17:42:59 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62BBC061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:41:24 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id k19so1376966qta.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zVv1GjmK07EWaIPDoxGxKRBfboRr4vWM9HdAWgd8h8=;
        b=gFbhrH/lrOqgsguvnI/seGtIdQLXd0j1mB0K0q/fZNVu9/dKg42cRWlvGWBMdLcmsm
         GR0LhjRyfauN/Us2dCVxfMDz0prbbMtTpZJJjo+6Ee/old3HeprB1ckBgqS2/neIatq6
         DXeRV+iVk5XYHVkdu0Vcf+TzEWtQYMSmh4Myk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zVv1GjmK07EWaIPDoxGxKRBfboRr4vWM9HdAWgd8h8=;
        b=NFDvFgETR2famwnxzv5O3X+/bV7zfPbGVsdJz5qXvfbVbNU9KkegzdEVkj+HAVjxcX
         b2a4qwK3aZW5mA7oYeSC2NTExXPvpC7MobgiCHziopAh1fRD3BnvQ8X6ajpZazvy6PjW
         yRcM/lBVVsDcinRyv+Yzt20dprun8jIPc5EVU6QTAi+MyU/kH5f/UyLUiSCTKYi5yfyT
         prN3vbV1N5QhpLlJul+iITU8/LI/w9tT4kakbwL8lXCJP1qOGEjVu7ZB585UVj5icseC
         p0BCzvADpXe5voV/3BFK6puWDwbJZCKMlBpb8lnTVxB9Lpu4YDVORFBINRk04MjOJh9+
         4fJA==
X-Gm-Message-State: AOAM533Tujlhy+cMXOmzZ+X22LaNgxIAtVlKprbZeA3ItjziaCefHoNr
        NsB5WSU04hnrtWYo2Xvb24MrsWfMbnCjhA==
X-Google-Smtp-Source: ABdhPJz5BydGSKzbZqRFDqYEyyquo+GHvx5rxbClTd6ZlFeMeJOKmk34i2MVtHHcqVt5Rrwinra7rw==
X-Received: by 2002:a05:622a:507:: with SMTP id l7mr624834qtx.276.1622151682553;
        Thu, 27 May 2021 14:41:22 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id v25sm2249731qtf.68.2021.05.27.14.41.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 14:41:20 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id b13so2726871ybk.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:41:20 -0700 (PDT)
X-Received: by 2002:a25:8191:: with SMTP id p17mr7998436ybk.405.1622151679762;
 Thu, 27 May 2021 14:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <1621927831-29471-1-git-send-email-rajeevny@codeaurora.org>
 <1621927831-29471-2-git-send-email-rajeevny@codeaurora.org>
 <CAD=FV=WzQ0Oc=e3kmNeBZUA+P1soKhBk8zt7bG1gqJ-Do-Tq_w@mail.gmail.com> <42db3a26684a5329287d57e1e78d0475@codeaurora.org>
In-Reply-To: <42db3a26684a5329287d57e1e78d0475@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 27 May 2021 14:41:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UuWuKibpT15McweuZ24qxsSAsSvJ3Q2MbZqgw5oggBVQ@mail.gmail.com>
Message-ID: <CAD=FV=UuWuKibpT15McweuZ24qxsSAsSvJ3Q2MbZqgw5oggBVQ@mail.gmail.com>
Subject: Re: [v4 1/4] drm/panel-simple: Add basic DPCD backlight support
To:     Rajeev Nandan <rajeevny@codeaurora.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        mkrishn@codeaurora.org, Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 27, 2021 at 5:21 AM <rajeevny@codeaurora.org> wrote:
>
> >> @@ -171,6 +172,19 @@ struct panel_desc {
> >>
> >>         /** @connector_type: LVDS, eDP, DSI, DPI, etc. */
> >>         int connector_type;
> >> +
> >> +       /**
> >> +        * @uses_dpcd_backlight: Panel supports eDP dpcd backlight
> >> control.
> >> +        *
> >> +        * Set true, if the panel supports backlight control over eDP
> >> AUX channel
> >> +        * using DPCD registers as per VESA's standard.
> >> +        */
> >> +       bool uses_dpcd_backlight;
> >> +};
> >> +
> >> +struct edp_backlight {
> >> +       struct backlight_device *dev;
> >
> > Can you pick a name other than "dev". In my mind "dev" means you've
> > got a "struct device" or a "struct device *".
>
> In the backlight.h "bd" is used for "struct backlight_device". I can use
> "bd"?

That would be OK w/ me since it's not "dev". In theory you could also
call it "base" like panel-simple does with the base class drm_panel,
but I'll leave that up to you. It's mostly that in my brain "dev" is
reserved for "struct device" but otherwise I'm pretty flexible.


> >> +       struct drm_edp_backlight_info info;
> >>  };
> >>
> >>  struct panel_simple {
> >> @@ -194,6 +208,8 @@ struct panel_simple {
> >>
> >>         struct edid *edid;
> >>
> >> +       struct edp_backlight *edp_bl;
> >> +
> >
> > I don't think you need to add this pointer. See below for details, but
> > basically the backlight device should be in base.backlight. Any code
> > that needs the containing structure can use the standard
> > "container_of" syntax.
> >
>
> The documentation of the "struct drm_panel -> backlight" mentions
> "backlight is set by drm_panel_of_backlight() and drivers shall not
> assign it."
> That's why I was not sure if I should touch that part. Because of this,
> I added
> backlight enable/disable calls inside panel_simple_disable/enable().

Fair enough. In my opinion (subject to being overridden by the adults
in the room), if you move your backlight code into drm_panel.c and
call it drm_panel_dp_aux_backlight() then it's fair game to use. This
basically means that it's no longer a "driver" assigning it since it's
being done in drm_panel.c. ;-) Obviously you'd want to update the
comment, too...


> >> +               err = drm_panel_of_backlight(&panel->base);
> >> +               if (err)
> >> +                       goto disable_pm_runtime;
> >> +       }
> >
> > See above where I'm suggesting some different logic. Specifically:
> > always try the drm_panel_of_backlight() call and then fallback to the
> > AUX backlight if "panel->base.backlight" is NULL and "panel->aux" is
> > not NULL.
>
> What I understood:
> 1. Create a new API drm_panel_dp_aux_backlight() in drm_panel.c
> 1.1. Register DP AUX backlight if "struct drm_dp_aux" is given and
>      drm_edp_backlight_supported()
> 2. Create a call back function for backlight ".update_status()" inside
> drm_panel.c ?
>    This function should also handle the backlight enable/disable
> operations.
> 3. Use the suggested rules to call drm_panel_dp_aux_backlight() as a
> fallback, if
>     no backlight is specified in the DT.
> 4. Remove the @uses_dpcd_backlight flag from panel_desc as this should
> be auto-detected.

This sounds about right to me.

As per all of my reviews in the DRM subsystem, this is all just my
opinion and if someone more senior in DRM contradicts me then, of
course, you might have to change directions. Hopefully that doesn't
happen but it's always good to give warning...

-Doug
