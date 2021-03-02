Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F83632A396
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837872AbhCBJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382126AbhCBI4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:56:04 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDFCC06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:29:33 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u4so22868668ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 00:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utqGY5cHJGpeykyhF1N+7GUgps/CrUwDpi2Q9PzRkfg=;
        b=CQyvI8BDuYTfYo/6YxOrw0FOl8KlVwbEEsSP05Ogpw5qST3Hp22oQi/5MYFh31wT4A
         xamvX6HPG1tTBNu6VaM61q2f94IrAW4DrnJ0BudiccRa4fBeHON+7VKccyclSHq0JAYm
         kvJm2AnJH4ueoHK6OthhSVTWD7m0Mg5s8hot+lt8mJWvpP/8CxOilFzhsXll2j5Sfzix
         1uY6a0cO9VkjaiwKk7dbUrQfhUkL3LnU1dCyP1O9wI3Uu0zPBMQ5nzwnPdnqhpoJqSvh
         A7/o3oDGJ9Nd9wJ9obus4sTIw0K3AEKdFUib1MBYLG3CtvaegtIiU0LLSH1jZRYzE9BU
         Q95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utqGY5cHJGpeykyhF1N+7GUgps/CrUwDpi2Q9PzRkfg=;
        b=NAvOYdAIrQQznCEcJIUPRyCnFu9WaLaKLHphlG9fKG2+JNSsqOI3X1THs06Taj6ml4
         367BpmXIGBRDVuJAX4WwUNt5qndcZ16BJso3Ed4q3Jwkug+Gz8Pdaf+wFqXtvGO+dmxS
         /6Ie2QutmsE669w6X8ZxvHkus7GAzOoBDJrjuDeWuyDEL2hxCvAIWAdGyUPhPiFRmfgQ
         uyQbJSCefIFawCoujgIrKCZDBD2rAici59Y/m0czi5TV1ENG7lOJX49ZYP7w/BbBeKwD
         ju9CK5JcdH54YeqjR6AslezwT2jOGBdKMX1QdwLZfFhZ4G9o2FCgf2tkTh11gIAuvfZt
         7R/g==
X-Gm-Message-State: AOAM530uSuH5voyeI4nG2rJZ/b8EO4SSROwu2nz7C4l0WPucCoR+K4Bw
        CmloXCmWE+MRDCObpOGqIp1rlmMwMW+34X64dPyf4A==
X-Google-Smtp-Source: ABdhPJxR72vTTfxUt4l4sNiq9X5PcO9iZfADvDB1zavjfZN7GGmifNa8Y3+YQzvTc7x3UKFqlKr4bEM4MmxO1Vwizxk=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr11032296ljj.467.1614673771930;
 Tue, 02 Mar 2021 00:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
 <a5c1e655-cdbc-18d5-55fd-c1690c31acbe@gmail.com> <CAMj1kXGEP3BNW6aLDaHFq2FCer-e8VXPU3c8xiojNXSqgzdw_g@mail.gmail.com>
In-Reply-To: <CAMj1kXGEP3BNW6aLDaHFq2FCer-e8VXPU3c8xiojNXSqgzdw_g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 09:29:21 +0100
Message-ID: <CACRpkdZby96WZtO7FEHc1YJ0RfyCi2u_q1PsfJQP6yLGX1Nmrg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] ARM: Implement MODULE_PLT support in FTRACE
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Alexander A Sverdlin <alexander.sverdlin@nokia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 7:32 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (+ Linus)
>
> On Wed, 3 Feb 2021 at 19:24, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > On 1/27/21 3:09 AM, Alexander A Sverdlin wrote:
> > > From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> > >
> > > FTRACE's function tracer currently doesn't always work on ARM with
> > > MODULE_PLT option enabled. If the module is loaded too far, FTRACE's
> > > code modifier cannot cope with introduced veneers and turns the
> > > function tracer off globally.
> > >
> > > ARM64 already has a solution for the problem, refer to the following
> > > patches:
> > >
> > > arm64: ftrace: emit ftrace-mod.o contents through code
> > > arm64: module-plts: factor out PLT generation code for ftrace
> > > arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels
> > > arm64: ftrace: fix building without CONFIG_MODULES
> > > arm64: ftrace: add support for far branches to dynamic ftrace
> > > arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()
> > >
> > > But the presented ARM variant has just a half of the footprint in terms of
> > > the changed LoCs. It also retains the code validation-before-modification
> > > instead of switching it off.
> >
> > Ard, Russell should this be sent to the patch tracker?
>
> Apologies for the delay. Unfortunately, I don't have time to review this.
>
> Linus?

I can look at them, I just need some starting strip because I honestly
almost never use tracing, so I need to figure out how to provoke the
error before the patches and then how to test that it is gone after.

Any suggestions on a quick use case that illustrates how the problem
manifest and how to test it is gone? The errors in patch 2, what do
I need to configure in to get them? Does it manifest at modprobe?

Yours,
Linus Walleij
