Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2D8312130
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 04:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBGDfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 22:35:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbhBGDfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 22:35:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E63D764E7D;
        Sun,  7 Feb 2021 03:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612668906;
        bh=9bozjFasYFNBnvuHUezc3sMHX+mbAWvUqvbfrelUpbg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kaWlG8C0iqFUbvSBKNJ1HaQuDQgDGkvGDPLWmk0uvivTCgqFyH+vNpe8UwH8IxPeM
         bZLnaxmwUTOOzGxOLN5PrLYDutyLjsJq0yINzGJ8qw+PCkEmfvTlRC1MwPIu/M1uk+
         BMBAo5yElQoATgpvvgYwjVDzC4EtHRi0C2knajEnz/bswIX1xvgaAS+h7IbeY1wqCl
         OLC9N3acEqqdo3hDSMQ4gi4MNHHmD0+w2I7CeskzK1mwztVAjOWJeOtI+8SFXpWS+V
         pHE01xuZr8zNWBHqpP5nSJ3k71Mk1d8BHQtX9kycDoEk1by5SYEdpTWZeJsjdqZvYd
         xge1hnHLrGkXw==
Received: by mail-lf1-f48.google.com with SMTP id d3so16873504lfg.10;
        Sat, 06 Feb 2021 19:35:05 -0800 (PST)
X-Gm-Message-State: AOAM5330hp6hJ/ReLPrS2aT6UyH+LmFdAbKUhLgkAjUiD2s3dzi4ZclA
        mcskk0yujnbtivJBSToOei3MY592BqhoLbzWHxc=
X-Google-Smtp-Source: ABdhPJzjm0X9/WNl5dP1IHd4dZvYAWylL1yDcxs3WKloYBrYNgSZSW5emHmai2qbV1uJfra9HFMk0ZYwArEucRBRXYk=
X-Received: by 2002:a05:6512:33cb:: with SMTP id d11mr6538893lfg.24.1612668904286;
 Sat, 06 Feb 2021 19:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20210204074609.3553018-1-guoren@kernel.org> <20210204074609.3553018-2-guoren@kernel.org>
 <c36b816b-6d80-9542-45fc-507c5cc302fb@linaro.org> <CAJF2gTSe7GUzPRvk6bK8AfQFp2uxae1Oo0w-ZtrtmcJmMWCqPw@mail.gmail.com>
In-Reply-To: <CAJF2gTSe7GUzPRvk6bK8AfQFp2uxae1Oo0w-ZtrtmcJmMWCqPw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 7 Feb 2021 11:34:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRru-5aT_R=AoCWC6e08oF_isBfL_ALUvdqCSmxBuEgtg@mail.gmail.com>
Message-ID: <CAJF2gTRru-5aT_R=AoCWC6e08oF_isBfL_ALUvdqCSmxBuEgtg@mail.gmail.com>
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

The same way in IRQ chip:

Link: https://lore.kernel.org/lkml/161245410060.1472442.13488057609914274236.b4-ty@kernel.org/

On Sun, Feb 7, 2021 at 11:31 AM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Daniel,
>
> On Thu, Feb 4, 2021 at 4:48 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> > On 04/02/2021 08:46, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > The timer-mp-csky.c only could support CPU_CK860 and it will
> > > compile error with CPU_CK610.
> > >
> > > It has been selected in arch/csky/Kconfig.
> >
> > It would be better if you fix the root cause of the compilation error.
> The timer-mp-csky.c has used specific instructions which only
> supported by CK860 and timer-mp-csky.c is only design for CK860.
>
> In arch/csky/Konfig we only select it with CK860.
>         select CSKY_MPINTC if CPU_CK860
>         select CSKY_MP_TIMER if CPU_CK860
>
> So here let's select timer-mp-csky.c in arch/csky/Kconfig, not in
> drivers/clocksource/Kconfig.
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
