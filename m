Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A98C315DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 04:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhBJDFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 22:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233561AbhBJDE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 22:04:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CA3E64E4E;
        Wed, 10 Feb 2021 03:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612926235;
        bh=B9W2ijWUGdA9x4gTDEc2lDSped2NoF8LVJewm3gkuw8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h0cDfyjgMlWyrUEfWBIbxOpTvLfTFGSCBnJ9VTUCfwHzUNcJDYjNM20rgVv2wnpsh
         /wPCZ5RHFwgUHS8vmCS9FNbbj7BTMXH4nVj2cRKNhmS3VaYdWNFTAdZQTictbXE2+0
         P5Pk9df3jA9osE1P7GQe6C4SAmYUQxiOlMrCp9SX+clMrZmG9wpnigVd0Xw+kpah+d
         ROvh+rNuFcjSQXdFAwBl7wyBveTAkW2PwUHiVEK/e7o+oODE2hA5t/RMjD/2VoSwVM
         gxU5HCLBRdw4fZwM7ZYZBAYLok0NtZFHg7UmlmdYJ4az3uYBHXqtnydyQcofrvSzto
         xvl84uT0lQZ/w==
Received: by mail-lf1-f45.google.com with SMTP id u25so709015lfc.2;
        Tue, 09 Feb 2021 19:03:55 -0800 (PST)
X-Gm-Message-State: AOAM530nZe5F4+WSVTlghkp/hfHEbaObFYDQzb3PVhYLmEb/ERstbhkL
        UeJzcipox5QDBaHqvQLibBDkENX+ZF8n5T3nix0=
X-Google-Smtp-Source: ABdhPJyO1ta6nqIVD3eMTqK+GqKkHPxTe/NlzJejyy2zt13giWb8Y2q82ODJhHVNmHA2pEMZeUtIYoNgUH/M6Opmkg4=
X-Received: by 2002:a19:f00a:: with SMTP id p10mr551180lfc.355.1612926233485;
 Tue, 09 Feb 2021 19:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20210204074609.3553018-1-guoren@kernel.org> <20210204074609.3553018-2-guoren@kernel.org>
 <c36b816b-6d80-9542-45fc-507c5cc302fb@linaro.org> <CAJF2gTSe7GUzPRvk6bK8AfQFp2uxae1Oo0w-ZtrtmcJmMWCqPw@mail.gmail.com>
 <973602b9-83d1-8e22-60bf-cd77d606a126@linaro.org> <CAJF2gTQG-o5MRtdwc8ogJhGLGsj5AWR1ja26wiGU=wrLL8X2Zw@mail.gmail.com>
 <a2f43b21-2e56-040f-b658-ccafa3b5fdc4@linaro.org>
In-Reply-To: <a2f43b21-2e56-040f-b658-ccafa3b5fdc4@linaro.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 10 Feb 2021 11:03:42 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTP47MZaX4eh5RV-GRABtDpyxjd3C3kH8kyvafjBNGoig@mail.gmail.com>
Message-ID: <CAJF2gTTP47MZaX4eh5RV-GRABtDpyxjd3C3kH8kyvafjBNGoig@mail.gmail.com>
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

On Wed, Feb 10, 2021 at 4:26 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 09/02/2021 17:02, Guo Ren wrote:
> > Hi Daniel,
> >
> > On Sun, Feb 7, 2021 at 5:29 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 07/02/2021 04:31, Guo Ren wrote:
> >>> Hi Daniel,
> >>>
> >>> On Thu, Feb 4, 2021 at 4:48 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> On 04/02/2021 08:46, guoren@kernel.org wrote:
> >>>>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>>>
> >>>>> The timer-mp-csky.c only could support CPU_CK860 and it will
> >>>>> compile error with CPU_CK610.
> >>>>>
> >>>>> It has been selected in arch/csky/Kconfig.
> >>>>
> >>>> It would be better if you fix the root cause of the compilation error.
> >>> The timer-mp-csky.c has used specific instructions which only
> >>> supported by CK860 and timer-mp-csky.c is only design for CK860.
> >>
> >> I guess you are referring to mfcr() ?
> >>
> >>> In arch/csky/Konfig we only select it with CK860.
> >>>         select CSKY_MPINTC if CPU_CK860
> >>>         select CSKY_MP_TIMER if CPU_CK860
> >>>
> >>> So here let's select timer-mp-csky.c in arch/csky/Kconfig, not in
> >>> drivers/clocksource/Kconfig.
> >>
> >> The COMPILE_TEST option is there to let other architecture to compile
> >> drivers and increase the compilation test coverage.
> >>
> >> The proposed change just removes the driver from this coverage.
> > When we compile the csky arch with C860, it will be selected.
> >
> >>
> >> Ideally, it would be better to keep it with the COMPILE_TEST option, so
> >> changes impacting all the drivers can be caught before submitting the
> >> patches.
> >>
> >> By just adding
> >>
> >> #ifndef mfcr
> >> #define mfcr(a) 0
> >> #endif
> >
> > 610 couldn't support CSKY_MP_TIMER and it's only for 860. So it's not
> > a coding skill issue.
>
> I think there is a misunderstanding.
>
> When I want to compile on x64 all the timer drivers, I do enable
> COMPILE_TEST, then the strings appear and the drivers can be selected.
>
> If the COMPILE_TEST is not enabled, the string does not appear, it is
> not possible to enable/disable it and the platform must enable it from
> the aforementioned arch/csky/Konfig.
>
> Actually, the timer drivers policy is : drivers can not be enabled from
> the drivers/clocksource/Kconfig, it is up to the platform Kconfig to
> select them. The exception is when the COMPILE_TEST option is set for
> testing purpose.
>
> The timer must compile on any other archs and the stubs for the platform
> specific calls must be provided.
>
> Did I miss something with your changes ?
I think our biggest difference is:
 - You think that CSKY_MPTIMER should not be related to the
architecture, but can be compiled with any architecture.
 - But I think CSKY_MPTIMER only could to be compiled with CSKY C860.

But from the perspective of easy maintenance, I agree with your
suggestion. I will adopt in next patch:
> >> #ifndef mfcr
> >> #define mfcr(a) 0
> >> #endif

Thx




--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
