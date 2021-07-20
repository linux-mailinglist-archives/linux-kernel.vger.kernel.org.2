Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020643CFCF8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbhGTOYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbhGTORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:17:20 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725B0C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:53:41 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id b18-20020a0568303112b02904cf73f54f4bso8200393ots.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j09lu3sICtnVWYbFQVf04X58J7J9DzrYfN54qh1JeP8=;
        b=ImwZmUTbQ1ngxEuIoZFjF/bP/zahZJ+7NJ9/6qY4DJQB/hYLzUuloIM75qHIeXH6dV
         Q6AOIDxTD7W9bj6TOp1x4KTmlk0CDYTUrLVPn/k8bkZR9FDj0tjR9d+g/WuRjiF65llR
         nEuw6sCuWe9aKfWNnjgUEPREI/MT4WRg85yTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j09lu3sICtnVWYbFQVf04X58J7J9DzrYfN54qh1JeP8=;
        b=uC4XyopNaORkEuuZ57ZL24LSe2Ql6mTCRDK6qVFZaqJRUKrrygnVLgqP1LzxrKP4DX
         uSoBzWLMrK/IfpmoaQ/UHp7ZwSZ+kUDPPwUC7B46GZi/pfxBh79PFrVu5btR1gBpf6xf
         /PvHKzCjn0JiCXo0MxwqvrmEZ+nMvO+xZTPUZw/Q2UhyybNoVheHy7alfv7+CcClvWux
         W3B0yka9m0F4D3+RuLcH0S72dKIrBu2LvW4lIhWVRY5suDZ03ozc6/pbcBKMcayDMFzE
         E2NNk9VXjO0Rljq4icZ+hM0xXfVotZk9QD8NRBCUWMTjuHSYUBHl7g2H+/9Q+cfSyeKe
         SE5A==
X-Gm-Message-State: AOAM5320j/3SbMPGEN3ToC/t6qhRh391zPE65lRwWSbQQKL3oU9CQY7d
        UNv73mH54oU5tslBttk6x53JnME54clO/owo8jWY8k5JXeU=
X-Google-Smtp-Source: ABdhPJzl9J0lkEu4CIIjY+U4b76K2eGMh6WUo5jGAXXEoYBh2685zCiCh40ygbBUtWz6N55Q1gllGQQLiVPua84eQ6A=
X-Received: by 2002:a05:6830:2802:: with SMTP id w2mr21307426otu.303.1626792820912;
 Tue, 20 Jul 2021 07:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210714145804.2530727-1-geert@linux-m68k.org>
 <YO8CT+Hcw1wfhnH5@ravnborg.org> <CAMuHMdVjXhTE2x8mRrinmh9CCrdXQr+BYPfP-peaZ4AsLwsaaA@mail.gmail.com>
In-Reply-To: <CAMuHMdVjXhTE2x8mRrinmh9CCrdXQr+BYPfP-peaZ4AsLwsaaA@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 20 Jul 2021 16:53:29 +0200
Message-ID: <CAKMK7uGpmQ3=OB52RYFgJoH7FWwhgx1t-TcSwpwjHPMWcyRd0w@mail.gmail.com>
Subject: Re: [PATCH resend 0/5] video: fbdev: ssd1307fb: Optimizations and improvements
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 8:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Sam,
>
> On Wed, Jul 14, 2021 at 5:27 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > On Wed, Jul 14, 2021 at 04:57:59PM +0200, Geert Uytterhoeven wrote:
> > > This patch series optimizes console operations on ssd1307fb, after the
> > > customary fixes and cleanups.
> >
> > What is required to to have a drm driver that could do the same?
>
> Add monochrome support to DRM?

I think the bits that are missing for that are
- wiring up the conversion from R* formats to their fbdev counterparts
in the emulation helper (if you want to support userspace sending the
native format directly through fbdev

Everything else is there and we have drivers doing this, e.g.
drm/tiny/repaper.c.
-Daniel

>
> > Note: I will take a look at the patches a bit later.
>
> TIA!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
