Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99D53C2B71
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 00:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhGIWla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 18:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhGIWl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 18:41:29 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BFEC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 15:38:44 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id j14so5297528qvu.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 15:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=in4kX7sLTOvzGIkTNM27VoAm2lJJuZoW6Y2T2jtB9og=;
        b=hszLVAfastfyWky57gCrlZ/WcIVeDaPB73el6QR1RDtWzS2BSVi5iqH/MQAzIHxy9k
         pHW1JsuN2pCSrLkXKRkr++6Pme3Qy33J8zG25hrOIwCdJkxlunSag78fgccRAvjjFmtz
         P3mWNoFQitYr6cojWimJYGR8YaL3h6x/XYMAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=in4kX7sLTOvzGIkTNM27VoAm2lJJuZoW6Y2T2jtB9og=;
        b=OYor4RLA+TrwNKy9qRUG0WU9/NuLh91lS58WqTB/RT0l8rpHabAv/eWVlc5b35F/tm
         qsZ8ib8GoGffu/N1yvANTUj4XGFQsiiLaGsu3qQ1Nwu/o1YGfu37DK417mv+XRY8Fbhq
         FpMSpXctBAittkgvhEM1SAi4Purtb0la7MmpwZca6kJdjm1OpmxK1kIJl+DVIS6owm29
         KoudCYp37Gq96i2dAOq8/bJcOdVY3b7W2eTRmys5ebW1Utt5VEC6C9sWg9IxE29tYjFK
         iYRIOJRgCHd0dXd3qf9za5Fr407x6J+BF+j8b64bY+OZeK8qJxws4N8fPpPJN9g3xmON
         8ECw==
X-Gm-Message-State: AOAM5331ty9MBs4lCzsnMeRHDCpzPtM1LPORKc28FNQte91IdbLw+qWT
        jytCQijeZTMqMWYqQ8g1mFLj/I2JBPoPYw==
X-Google-Smtp-Source: ABdhPJw39G2DHP9Ovno8/UF2bwWp/3qOl1OFsceRkLKNZDCFkgAe3fCC9H0h/1jA3ILdnIswY8T3Aw==
X-Received: by 2002:a0c:eb8d:: with SMTP id x13mr20413731qvo.45.1625870323860;
        Fri, 09 Jul 2021 15:38:43 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id p64sm3139395qka.114.2021.07.09.15.38.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 15:38:43 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id g5so16838492ybu.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 15:38:43 -0700 (PDT)
X-Received: by 2002:a25:60c1:: with SMTP id u184mr49707810ybb.343.1625869916303;
 Fri, 09 Jul 2021 15:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <1624726268-14869-1-git-send-email-rajeevny@codeaurora.org>
 <CAD=FV=UP9jrS=JG=TuB7+i9QcZv8GOLYdPdb3_KNhEsgapGeww@mail.gmail.com> <YOi0WbTP0crIkOGy@intel.com>
In-Reply-To: <YOi0WbTP0crIkOGy@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 9 Jul 2021 15:31:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vce_zdKMgzg+X-hK8XPEeuMEN3ViFnsb7AEsz1=EN-+A@mail.gmail.com>
Message-ID: <CAD=FV=Vce_zdKMgzg+X-hK8XPEeuMEN3ViFnsb7AEsz1=EN-+A@mail.gmail.com>
Subject: Re: [v8 0/6] drm: Support basic DPCD backlight in panel-simple and
 add a new panel ATNA33XC20
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Rajeev Nandan <rajeevny@codeaurora.org>,
        linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jani Nikula <jani.nikula@intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 9, 2021 at 1:41 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Jul 09, 2021 at 06:54:05AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Sat, Jun 26, 2021 at 9:52 AM Rajeev Nandan <rajeevny@codeaurora.org>=
 wrote:
> > >
> > > This series adds the support for the eDP panel that needs the backlig=
ht
> > > controlling over the DP AUX channel using DPCD registers of the panel
> > > as per the VESA's standard.
> > >
> > > This series also adds support for the Samsung eDP AMOLED panel that
> > > needs DP AUX to control the backlight, and introduces new delays in t=
he
> > > @panel_desc.delay to support this panel.
> > >
> > > This patch series depends on the following two series:
> > > - Doug's series [1], exposed the DP AUX channel to the panel-simple.
> > > - Lyude's series [2], introduced new drm helper functions for DPCD
> > >   backlight.
> > >
> > > This series is the logical successor to the series [3].
> > >
> > > Changes in v1:
> > > - Created dpcd backlight helper with very basic functionality, added
> > >   backlight registration in the ti-sn65dsi86 bridge driver.
> > >
> > > Changes in v2:
> > > - Created a new DisplayPort aux backlight driver and moved the code f=
rom
> > >   drm_dp_aux_backlight.c (v1) to the new driver.
> > >
> > > Changes in v3:
> > > - Fixed module compilation (kernel test bot).
> > >
> > > Changes in v4:
> > > - Added basic DPCD backlight support in panel-simple.
> > > - Added support for a new Samsung panel ATNA33XC20 that needs DPCD
> > >   backlight controlling and has a requirement of delays between enabl=
e
> > >   GPIO and regulator.
> > >
> > > Changes in v5:
> > > Addressed review suggestions from Douglas:
> > > - Created a new API drm_panel_dp_aux_backlight() in drm_panel.c
> > > - Moved DP AUX backlight functions from panel-simple.c to drm_panel.c
> > > - panel-simple probe() calls drm_panel_dp_aux_backlight() to create
> > >   backlight when the backlight phandle is not specified in panel DT
> > >   and DP AUX channel is present.
> > > - Added check for drm_edp_backlight_supported() before registering.
> > > - Removed the @uses_dpcd_backlight flag from panel_desc as this
> > >   should be auto-detected.
> > > - Updated comments/descriptions.
> > >
> > > Changes in v6:
> > > - Rebased
> > > - Updated wanrning messages, fixed word wrapping in comments.
> > > - Fixed ordering of memory allocation
> > >
> > > Changes in v7:
> > > - Updated the disable_to_power_off and power_to_enable panel delays
> > > as discovered at <https://crrev.com/c/2966167> (Douglas)
> > >
> > > Changes in v8:
> > > - Now using backlight_is_blank() to get the backlight blank status (S=
am Ravnborg)
> > > - Added a new patch #4 to fix the warnings for eDP panel description =
(Sam Ravnborg)
> > >
> > > [1] https://lore.kernel.org/dri-devel/20210525000159.3384921-1-diande=
rs@chromium.org/
> > > [2] https://lore.kernel.org/dri-devel/20210514181504.565252-1-lyude@r=
edhat.com/
> > > [3] https://lore.kernel.org/dri-devel/1619416756-3533-1-git-send-emai=
l-rajeevny@codeaurora.org/
> > >
> > > Rajeev Nandan (6):
> > >   drm/panel: add basic DP AUX backlight support
> > >   drm/panel-simple: Support DP AUX backlight
> > >   drm/panel-simple: Support for delays between GPIO & regulator
> > >   drm/panel-simple: Update validation warnings for eDP panel descript=
ion
> > >   dt-bindings: display: simple: Add Samsung ATNA33XC20
> > >   drm/panel-simple: Add Samsung ATNA33XC20
> > >
> > >  .../bindings/display/panel/panel-simple.yaml       |   2 +
> > >  drivers/gpu/drm/drm_panel.c                        | 108 +++++++++++=
++++++++++
> > >  drivers/gpu/drm/panel/panel-simple.c               |  73 +++++++++++=
++-
> > >  include/drm/drm_panel.h                            |  15 ++-
> > >  4 files changed, 190 insertions(+), 8 deletions(-)
> >
> > Pushed to drm-misc-next.
> >
> > 4bfe6c8f7c23 drm/panel-simple: Add Samsung ATNA33XC20
> > c20dec193584 dt-bindings: display: simple: Add Samsung ATNA33XC20
> > 13aceea56fd5 drm/panel-simple: Update validation warnings for eDP
> > panel description
> > 18a1488bf1e1 drm/panel-simple: Support for delays between GPIO & regula=
tor
> > bfd451403d70 drm/panel-simple: Support DP AUX backlight
> > 10f7b40e4f30 drm/panel: add basic DP AUX backlight support
>
> depmod: ERROR: Cycle detected: drm_kms_helper -> drm -> drm_kms_helper
>
> Looks to be due to drm_edp_backlight_enable().

Ugh. Thanks for the report! I've taken a schwag at a fix here:

https://lore.kernel.org/lkml/20210709152909.1.I23eb4cc5a680341e7b3e791632a6=
35566fa5806a@changeid/

-Doug
