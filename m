Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD033A3817
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhFJXuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:50:19 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:41555 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFJXuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:50:17 -0400
Received: by mail-pl1-f170.google.com with SMTP id e1so1880248plh.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ia+WgiNmBrNumpflq7GIz/CPCMUnXFCFOdywGiG0Z6g=;
        b=LB9NbAJa9+YDkT5dKngoApflItXhdfhiCA6IIT2fBeCtva6xq3OpXIF6c/i8HfKJHD
         NJQF6K4g/34x4e4uyNTZ5U2nFSt2zczf0SwVthuvLKO5wHl4Z/pugbQqh4hH5R3ONRm5
         7HPj9ZUua+mGmtuKnMCyR6lyrAp2HMCEFzkVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ia+WgiNmBrNumpflq7GIz/CPCMUnXFCFOdywGiG0Z6g=;
        b=UEmVd4LSkOsX2X8KGZSuiVvQuWlSW8Bcsj+6j1w9BlPVRLNHQmblVtlkRaiNj/ZsJf
         5dMeqkzL07JSscp1eEtj67v0RTuQ+G7Tzg/Vgo0hbwbrWdJbU99s2ZeKYqiV5mkNaJcI
         MTX7eniJy+QY3MXTfjcjwZOf5WiPih+U4/cdvoHvVx1CpURzzGRKqEvlbybhbkOl0JsO
         rNfh+IJF/ereYp8p6EBk7p0Ki9+zDnImpHKK1R4inAnYKq+xFjuviOSdkPikYsvu/cnW
         giaILm3ycMAgUrF6ejFUA+VfH/r80BxHAufyZI+hppcZQiGdZHwA34Gkz21TItQda+G2
         BvyQ==
X-Gm-Message-State: AOAM532pGhLZb1oLnVGc5ZrcYAT3NXW3VEDAoEFruPaawL7HQoCUZpY1
        N/6cxXw8NzNqPn6n5ctbwMKJ6g==
X-Google-Smtp-Source: ABdhPJyJqYy98SDqVON6jO6f78txZcsjVBBHVxB1wqgPsOBDpy2NP+iufKAz3VC03I0OmqXD4WPuYw==
X-Received: by 2002:a17:90a:4298:: with SMTP id p24mr5929509pjg.144.1623368829802;
        Thu, 10 Jun 2021 16:47:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ev11sm8637545pjb.36.2021.06.10.16.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 16:47:09 -0700 (PDT)
Date:   Thu, 10 Jun 2021 16:47:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Tor Vic <torvic9@mailbox.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2 1/1] x86/Makefile: make -stack-alignment conditional
 on LLD < 13.0.0
Message-ID: <202106101601.248F797@keescook>
References: <f2c018ee-5999-741e-58d4-e482d5246067@mailbox.org>
 <162336538453.1311648.12615336165738957417.b4-ty@chromium.org>
 <CAKwvOdmYVH-YpEVqdoBfvgNfcbzx71jU_27cuhuzTJ6_Emzi-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmYVH-YpEVqdoBfvgNfcbzx71jU_27cuhuzTJ6_Emzi-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 03:58:57PM -0700, Nick Desaulniers wrote:
> On Thu, Jun 10, 2021 at 3:50 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, 10 Jun 2021 20:58:06 +0000, Tor Vic wrote:
> > > Since LLVM commit 3787ee4, the '-stack-alignment' flag has been dropped
> > > [1], leading to the following error message when building a LTO kernel
> > > with Clang-13 and LLD-13:
> > >
> > >     ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument
> > >     '-stack-alignment=8'.  Try 'ld.lld --help'
> > >     ld.lld: Did you mean '--stackrealign=8'?
> > >
> > > [...]
> >
> > Applied to for-next/clang/features, thanks!
> >
> > [1/1] x86/Makefile: make -stack-alignment conditional on LLD < 13.0.0
> >       https://git.kernel.org/kees/c/e6c00f0b33ad
> 
> Can we get this into 5.13?

What's the ETA on LLVM 13.0? I was going to put this in -next, marked
for stable, but we're about 3 weeks from 5.14 merge window.

-- 
Kees Cook
