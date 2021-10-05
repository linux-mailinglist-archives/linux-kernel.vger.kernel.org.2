Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C466242282F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhJENrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbhJENrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:47:13 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FCFC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 06:45:23 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id y15so21838383ilu.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DgOIE96eS9LCwM8xrp/VmKNjdKCV3OUl2f/h98/P2uA=;
        b=Ik3VtettYsKq8tCKrQwpYih9V4scwM/ap7YHv9s4H1bIAmcl44e9EYxcyile1eNDjn
         BA60YaZR+yP6XLpREe7X48XFqf2HQLVL/VgOaJfgs5/OE7V9Vp2DkS5EhbtvrYQNGIaV
         XqjjaHpSRqrz7gvM4MQOiNmfkXBcFX89TDXl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DgOIE96eS9LCwM8xrp/VmKNjdKCV3OUl2f/h98/P2uA=;
        b=nQzbGWzXNYNrODS8DNQEgdoU44+Nm0Fv1IvxQZp2QT2mIq1DWkhFg0/9GiyzLJIzYM
         ltf/5aR8RFRzxGNJZ3h2HSBFah0VnFtJHhZ0qC1YSlFomIccux9o9alB4g4bCpaUVvM0
         /xZlfFgYsnJBOpt5JCz1xxsa8fbTh9P7qaWT6sSV+i7EDUO0dWdf+iHOfXrPXhdqGDOM
         55BCF6R+eSgKaYmtEoQv/hoVXbfSLqd1zBHBl+fxKmDdQWva49R1gvYE8yzKxl7tyk7M
         C2pLfmi8G5U7/vHvJopCv47cDr4U7ZhkcI0v1aGVT98dwjuZgqb0rNThIuWmxEPwWIP5
         Zvvg==
X-Gm-Message-State: AOAM5309Gvvk9znhj7aAhLh3JN5XUojlg60QzY2V57dIS28h5BMJ+gwh
        Kl5dba9CycGzod88AMmTKDUhRBFR8SVDQw==
X-Google-Smtp-Source: ABdhPJz1Y3oRSzWfUrUWKD0G8qMEm7We2vVE28AXM92nwO4bgiqP1OQ++aPTl1LqWAcY2UsLfLhxmQ==
X-Received: by 2002:a92:ca84:: with SMTP id t4mr815894ilo.124.1633441522435;
        Tue, 05 Oct 2021 06:45:22 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id v63sm10820299ioe.17.2021.10.05.06.45.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 06:45:21 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id d18so24316773iof.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 06:45:21 -0700 (PDT)
X-Received: by 2002:a02:c7d2:: with SMTP id s18mr2725618jao.68.1633441521325;
 Tue, 05 Oct 2021 06:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211004092100.1.Ic90a5ebd44c75db963112be167a03cc96f9fb249@changeid>
 <CAMuHMdUsoBO2hjd0tAecAjnwCUbp=d8i8vaUFDT6Yn3emw2s9Q@mail.gmail.com> <CAD=FV=V8MoYX2deqD_YE6ii9+VFbwqX0bre=5xaYe8ZwwExziQ@mail.gmail.com>
In-Reply-To: <CAD=FV=V8MoYX2deqD_YE6ii9+VFbwqX0bre=5xaYe8ZwwExziQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Oct 2021 06:45:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VEdnszvbRR3dPijbzvwENUnQi2Ai+Erg6e1L9fb24R9Q@mail.gmail.com>
Message-ID: <CAD=FV=VEdnszvbRR3dPijbzvwENUnQi2Ai+Erg6e1L9fb24R9Q@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: Fix crash with zero/invalid EDID
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        kernel test robot <oliver.sang@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 4, 2021 at 5:40 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Oct 4, 2021 at 10:14 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Douglas,
> >
> > On Mon, Oct 4, 2021 at 6:22 PM Douglas Anderson <dianders@chromium.org> wrote:
> > > In the commit bac9c2948224 ("drm/edid: Break out reading block 0 of
> > > the EDID") I broke out reading the base block of the EDID to its own
> > > function. Unfortunately, when I did that I messed up the handling when
> > > drm_edid_is_zero() indicated that we had an EDID that was all 0x00 or
> > > when we went through 4 loops and didn't get a valid EDID. Specifically
> > > I needed to pass the broken EDID to connector_bad_edid() but now I was
> > > passing an error-pointer.
> > >
> > > Let's re-jigger things so we can pass the bad EDID in properly.
> > >
> > > Fixes: bac9c2948224 ("drm/edid: Break out reading block 0 of the EDID")
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > The crash is was seeing is gone, so
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks for testing! I'll plan to apply tomorrow morning (California
> time) to balance between giving folks a chance to yell at me for my
> patch and the urgency of fixing the breakage.

Ah, doh! I can't push until I can get a review tag from someone. As
soon as I see one then I'll give it a push.

-Doug
