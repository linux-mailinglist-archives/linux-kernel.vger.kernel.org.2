Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC46C315358
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhBIQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:03:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232277AbhBIQDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:03:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20AEA64EBA;
        Tue,  9 Feb 2021 16:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612886591;
        bh=31fwe8tyXvKWTQevWbPBBTwlhtYmuyUtZ+dct39LYEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P0r43uVrvy8K/w8L1+t7fMG40NdszoK+vuOzvjFYS9Y564y3R+G35zSjjZjFerG1K
         PcTjjj0PIkqm0y9zdiStHR7ylrPbkDbJqmhNjRb8rd3Q90rvwoNRTzgaEfHKQf+/G9
         HDKi/jHGn+mJVl+3e2RooLlSWZaY4lC6jJVuUAIZ/d4R0vf6Pa4g733IJFa+/lF5zz
         9V7xNtyHrLFuUPolZuxEHHgd4CX6QWUC5VoXqE/lDrwdrgpURZErxNOLCurP6VVfWu
         L43sioV2QdY0TYj1Lz7idjZRtJOXskFAzqiF9nSuXJus3LOgX56RDBiHOPypFs2MTu
         TzrHIrlVVCSdA==
Received: by mail-lj1-f172.google.com with SMTP id e18so22968103lja.12;
        Tue, 09 Feb 2021 08:03:11 -0800 (PST)
X-Gm-Message-State: AOAM5331LJjEtPsmsb6V+veF93grdL7cLf2DKivr8uh68Lu+OnqBsZSC
        PeksFjDMr8D9HUmf+RVTzR6ClhPdZKoPeaII6OI=
X-Google-Smtp-Source: ABdhPJytc/86AMR/fdDr1On8RltlG5wAzB8/vX6xCa78ty0TEiYZag6gbGshXU/MoziFO8DGdVEhT92RxJ0Fa3VZyEA=
X-Received: by 2002:a2e:531d:: with SMTP id h29mr14780670ljb.115.1612886589220;
 Tue, 09 Feb 2021 08:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20210204074609.3553018-1-guoren@kernel.org> <20210204074609.3553018-2-guoren@kernel.org>
 <c36b816b-6d80-9542-45fc-507c5cc302fb@linaro.org> <CAJF2gTSe7GUzPRvk6bK8AfQFp2uxae1Oo0w-ZtrtmcJmMWCqPw@mail.gmail.com>
 <973602b9-83d1-8e22-60bf-cd77d606a126@linaro.org>
In-Reply-To: <973602b9-83d1-8e22-60bf-cd77d606a126@linaro.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 10 Feb 2021 00:02:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQG-o5MRtdwc8ogJhGLGsj5AWR1ja26wiGU=wrLL8X2Zw@mail.gmail.com>
Message-ID: <CAJF2gTQG-o5MRtdwc8ogJhGLGsj5AWR1ja26wiGU=wrLL8X2Zw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drivers/clocksource: Fixup csky,mptimer compile
 error with CPU_CK610
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sun, Feb 7, 2021 at 5:29 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 07/02/2021 04:31, Guo Ren wrote:
> > Hi Daniel,
> >
> > On Thu, Feb 4, 2021 at 4:48 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 04/02/2021 08:46, guoren@kernel.org wrote:
> >>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>
> >>> The timer-mp-csky.c only could support CPU_CK860 and it will
> >>> compile error with CPU_CK610.
> >>>
> >>> It has been selected in arch/csky/Kconfig.
> >>
> >> It would be better if you fix the root cause of the compilation error.
> > The timer-mp-csky.c has used specific instructions which only
> > supported by CK860 and timer-mp-csky.c is only design for CK860.
>
> I guess you are referring to mfcr() ?
>
> > In arch/csky/Konfig we only select it with CK860.
> >         select CSKY_MPINTC if CPU_CK860
> >         select CSKY_MP_TIMER if CPU_CK860
> >
> > So here let's select timer-mp-csky.c in arch/csky/Kconfig, not in
> > drivers/clocksource/Kconfig.
>
> The COMPILE_TEST option is there to let other architecture to compile
> drivers and increase the compilation test coverage.
>
> The proposed change just removes the driver from this coverage.
When we compile the csky arch with C860, it will be selected.

>
> Ideally, it would be better to keep it with the COMPILE_TEST option, so
> changes impacting all the drivers can be caught before submitting the
> patches.
>
> By just adding
>
> #ifndef mfcr
> #define mfcr(a) 0
> #endif

610 couldn't support CSKY_MP_TIMER and it's only for 860. So it's not
a coding skill issue.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
