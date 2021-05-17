Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2E386C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 23:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245229AbhEQVhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 17:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhEQVhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 17:37:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E282C061573;
        Mon, 17 May 2021 14:36:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z12so9899134ejw.0;
        Mon, 17 May 2021 14:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7tUbgzjgwHZu3SY+jH6AtxQ7COMJjm9OWbgWwWkkbA=;
        b=iuKW9D3nu1bsFV7gAZoDs/vdHxghnjyauPhfKPaE6Vs5yh895qoawtGtEUmX5/dd6W
         lI5hkE6TjbE48JCTMQxx56uZ10QYGpDtKkehca+h4kLHgWl9TpTxI1JRDT42QZiRUsTQ
         MEAbNO9I9Q8s+gRT6uJIlLUF+gP6WSrJw0Mc5XSp537fIr/a+wv105yQDj26wer42hhH
         h0tht+wJVqaYzJCUxc0Lznm5saHMELGdC7rOFgjgmlo+Xv7PlPpPgPNMvww4m8+8KcK3
         OLU8vS8RgxOGOyAQS6bwZILVyO/Z2e/QWnqIej0cc1Gd0TMTP0Kti5W80OetScXVo6zk
         n7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7tUbgzjgwHZu3SY+jH6AtxQ7COMJjm9OWbgWwWkkbA=;
        b=IIGfv1Dcz8c1+2KTI4SMRgW7o+ectynjBDsDRlkvNXuntxbamxAmYAVtDtaHScspem
         Yty91Wsejyvcl/ioSS1Nj97csSQWmxzT9HcTBmzn99Mar5Vo6yGKHxN2iE0eYuTSh1/T
         faKOKumnnKLbFitK5HSVo38O24OrQ/hyRkD4VS3pRxKdpihzJE73VfCxsQGLnbhonO3N
         oZJui3pobPeSFIPW86VFHJgAVjoii47g5M7syaOzpeNrHMGvnpeakevBwrBDbHIR6qrt
         usvhMND3WPjbA4G+P/SD3vWhZlndnwunIZvZMZeWW7GzilQTV0kcIX3CQql2dANna3N5
         OSnw==
X-Gm-Message-State: AOAM530VqVywPyzHPgOW68/2vs4M/gT3p4n0BE5P5HEmHkbk+2k5iADy
        LYO+4s2PUUtWG8uEqwBhRCsMEXKI/JuPYaX+XK0=
X-Google-Smtp-Source: ABdhPJzOom8/ce1HZErfkpCTLprK4xpBI1A/rCKW/sYjn9T5ApBOWS8EJDDS/dN3VuUHXZi51XNHNGNc19Rp1Fhcc+c=
X-Received: by 2002:a17:906:6b96:: with SMTP id l22mr2001804ejr.456.1621287375273;
 Mon, 17 May 2021 14:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
 <YJ42MEgwDZrAEQLl@kroah.com> <CAK8P3a0pcBHfrwu9fHHRWim5WgQuCqpROpMM83yCCpjjwu1FJQ@mail.gmail.com>
 <YKIeBdwFb9Ng275X@phenom.ffwll.local> <503d101d-7273-757a-2809-e272db93c45d@suse.de>
 <CAPj87rMqYNdHMT5v9fiMuDzcB8462nJuthB9To70JOsORgxk=w@mail.gmail.com> <6e26562f-5ccf-9014-c0c4-00241659a95b@suse.de>
In-Reply-To: <6e26562f-5ccf-9014-c0c4-00241659a95b@suse.de>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 18 May 2021 07:36:03 +1000
Message-ID: <CAPM=9ty3EWs8eUzyrFM_29nXZMCGJ5CO=H=gY+HVdBAR2Wg-Yw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Driver of Intel(R) Gaussian & Neural Accelerator
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Stone <daniel@fooishbar.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 at 06:10, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 17.05.21 um 21:32 schrieb Daniel Stone:
> > Hi,
> >
> > On Mon, 17 May 2021 at 20:12, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Am 17.05.21 um 09:40 schrieb Daniel Vetter:
> >>> We have, it's called drivers/gpu. Feel free to rename to drivers/xpu or
> >>> think G as in General, not Graphisc.
> >>
> >> I hope this was a joke.
> >>
> >> Just some thoughts:
> >>
> >> AFAICT AI first came as an application of GPUs, but has now
> >> evolved/specialized into something of its own. I can imagine sharing
> >> some code among the various subsystems, say GEM/TTM internals for memory
> >> management. Besides that there's probably little that can be shared in
> >> the userspace interfaces. A GPU is device that puts an image onto the
> >> screen and an AI accelerator isn't.
> >
> > But it isn't. A GPU is a device that has a kernel-arbitrated MMU
> > hosting kernel-managed buffers, executes user-supplied compiled
> > programs with reference to those buffers and other jobs, and informs
> > the kernel about progress.
> >
> > KMS lies under the same third-level directory, but even when GPU and
> > display are on the same die, they're totally different IP blocks
> > developed on different schedules which are just periodically glued
> > together.
>
> I mentioned this elsewhere: it's not about the chip architecture, it's
> about the UAPI. In the end, the GPU is about displaying things on a
> screen. Even if the rendering and the scanout engines are on different
> IP blocks. (Or different devices.)
>
> The fact that one can do general purpose computing on a GPU is a
> byproduct of the evolution of graphics hardware. It never was the goal.

But then we would have a subsystem for AI accelerators excluding GPUs,
do we then start to layer that subsystem onto drivers/gpu? at which
point why bother.

The thing is UAPI and stack architecture are important, but what is
more important than any of that is that there is a place where the
people invested in the area can come together outside of company
boundaries and discuss ideas and bounce designs around each other to
come to an agreement without the overheads of company interactions.
dri-devel + mesa have managed this for graphics but it's taken years
and we are still fighting that battle within major companies who even
when they know it produces good results can't drag themselves to give
up control over anything unless given no other choice.

I expect the accel teams in these companies need to step outside their
productization timelines and powerpoints and start discussing uAPI
designs with the other companies in the area. Until that happens I
expect upstreaming any of these should be a default no.

Dave.
