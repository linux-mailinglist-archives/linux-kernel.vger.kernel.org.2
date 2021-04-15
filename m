Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB535FF3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 03:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhDOBXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 21:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhDOBXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 21:23:37 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A51C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 18:23:12 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id h15so1126863qvu.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=or2E+Xrz/yrj3CbSRghlqeF1cBqT6BkZhveQdh84YTM=;
        b=dr3mDQfITiSC1Xe8vhYBkB/3AZe6OSEASYIUILrz/7HZvYfnBmMT/gH8v92ltFTKIu
         AgdL3RA1GZEtAA8Hzgt98fThu/Qn1Q8wEKSPjgueKRNz+hJ/JHSgQ5LFlIvVEEAQEf/S
         aKevGJb+16n4efb/8Bk+p1IrucLytBbNXsIgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=or2E+Xrz/yrj3CbSRghlqeF1cBqT6BkZhveQdh84YTM=;
        b=KeNQtP3CX3X6Bdr9MMlm2IcvPqDwW1O+36Vb9CbD1sZejvPGTHSq0lxAWIdIM3nox2
         hbjmsuCHIH3eCLTL75f3Ey5ca7kd008YBVhUqejdh2or2GlTcSkb6vI0NW0OgGKIi+jd
         762u8Y67wEoCql5kIDAcAF1S+ImgkOac326JOQXqDJPLBMGKeHC6eQdxX4NDYRFK86hz
         fMODsPSuywrcS5PZFwLQ/jlUwBW+WHQnsZjycTStVUjG/UNaML8finboVe9orqJcnXrD
         twUPyJMRysAR1UMAvoGBEJncgP2QXvnerQOm9mHzJVrgVoLqf4YTPIiDv5lglR26afA0
         Am0w==
X-Gm-Message-State: AOAM530LfdElQJCk8dtZg/2nPhbN4eCgSmIjtLWPWTD5cnLk+6UIiiGE
        KPsLyb/Dgv62HiZQL+wMFrU7K3xi01zS4Q==
X-Google-Smtp-Source: ABdhPJzrTtgkb6gvQOE6NSqMP9Zsv7/c2vdg1MofPbVJusk9EJ9QnG8rD1BEfvya3DBC8fn6kloA9g==
X-Received: by 2002:a05:6214:1906:: with SMTP id er6mr909912qvb.38.1618449791187;
        Wed, 14 Apr 2021 18:23:11 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id f12sm745711qti.63.2021.04.14.18.23.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 18:23:09 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id x76so14284217ybe.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 18:23:09 -0700 (PDT)
X-Received: by 2002:a25:d847:: with SMTP id p68mr1088600ybg.345.1618449788793;
 Wed, 14 Apr 2021 18:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210402222846.2461042-1-dianders@chromium.org>
 <20210402152701.v3.12.I9e8bd33b49c496745bfac58ea9ab418bd3b6f5ce@changeid> <YHePsQgqOau1V5lD@pendragon.ideasonboard.com>
In-Reply-To: <YHePsQgqOau1V5lD@pendragon.ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Apr 2021 18:22:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=XixXONS9D4CRxku4VuKa2pYniSjzSoX_NXkDW-J15g@mail.gmail.com>
Message-ID: <CAD=FV=X=XixXONS9D4CRxku4VuKa2pYniSjzSoX_NXkDW-J15g@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] drm/panel: panel-simple: Use runtime pm to avoid
 excessive unprepare / prepare
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus W <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 14, 2021 at 5:58 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Doug,
>
> Thank you for the patch.
>
> On Fri, Apr 02, 2021 at 03:28:46PM -0700, Douglas Anderson wrote:
> > Unpreparing and re-preparing a panel can be a really heavy
> > operation. Panels datasheets often specify something on the order of
> > 500ms as the delay you should insert after turning off the panel
> > before turning it on again. In addition, turning on a panel can have
> > delays on the order of 100ms - 200ms before the panel will assert HPD
> > (AKA "panel ready"). The above means that we should avoid turning a
> > panel off if we're going to turn it on again shortly.
> >
> > The above becomes a problem when we want to read the EDID of a
> > panel. The way that ordering works is that userspace wants to read the
> > EDID of the panel _before_ fully enabling it so that it can set the
> > initial mode correctly. However, we can't read the EDID until we power
> > it up. This leads to code that does this dance (like
> > ps8640_bridge_get_edid()):
> >
> > 1. When userspace requests EDID / the panel modes (through an ioctl),
> >    we power on the panel just enough to read the EDID and then power
> >    it off.
> > 2. Userspace then turns the panel on.
> >
> > There's likely not much time between step #1 and #2 and so we want to
> > avoid powering the panel off and on again between those two steps.
> >
> > Let's use Runtime PM to help us. We'll move the existing prepare() and
> > unprepare() to be runtime resume() and runtime suspend(). Now when we
> > want to prepare() or unprepare() we just increment or decrement the
> > refcount. We'll default to a 1 second autosuspend delay which seems
> > sane given the typical delays we see for panels.
> >
> > A few notes:
> > - It seems the existing unprepare() and prepare() are defined to be
> >   no-ops if called extra times. We'll preserve that behavior.
>
> The prepare and unprepare calls are supposed to be balanced, which
> should allow us to drop this check. Do you have a reason to suspect that
> it may not be the case ?

No, it was just code inspection. The old code definitely made an
effort to make enable of an already enabled panel a no-op and disable
of an already disabled panel a no-op. This is even before my
(somewhat) recent patch to make things timing based, though I did
touch the code.

Can I maybe suggest that getting rid of the extra check should be a
separate patch after this one? Then if it breaks someone it's easy to
just revert that one and we can still keep the runtime pm?


> > - This is a slight change in the ABI of simple panel. If something was
> >   absolutely relying on the unprepare() to happen instantly that
> >   simply won't be the case anymore. I'm not aware of anyone relying on
> >   that behavior, but if there is someone then we'll need to figure out
> >   how to enable (or disable) this new delayed behavior selectively.
> > - In order for this to work we now have a hard dependency on
> >   "PM". From memory this is a legit thing to assume these days and we
> >   don't have to find some fallback to keep working if someone wants to
> >   build their system without "PM".
>
> Sounds fine to me.
>
> The code looks good to me. Possibly with the prepared check removed,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!
