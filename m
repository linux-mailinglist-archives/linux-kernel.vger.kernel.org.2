Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E14F31A82F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 00:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhBLXGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 18:06:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLXGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:06:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF92864DAD
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 23:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613171160;
        bh=tBxFZwoJWv3SOKBE5UTMo8+ru4YN5uJ1G3rmZ75B49s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P4dvyU/zSjY7l8uYUD1lMx2LClXtENKF/gXBIfxCZyCxTh9cn1R9vN1N7FkF2YORC
         UQLUbKkCmrGGUdO45uDrYXuhmC+8O0/sirHta4K4VSGeQ4kkLgyHyCcw/egadgm1k/
         lBXwYpWfAEg8fObDi1V5zcX+5/zFyAb+8K2D4zuesEFqrP4ZNTvMKZUGoOxQajx2yd
         iHZYAz3mHLwsWX7k7del3CxM0Zk//wCZqJaLvSppRz6IEp+Kg8Nhal+TWwdLrOOPKA
         eQdq6UEjT7m/gkP3g3klf6jm/YUiA76wFnCRy0rwhOysuDB74/8ieKILjqA/Gi2VT5
         NkYYxoDALOe/A==
Received: by mail-ot1-f46.google.com with SMTP id y11so776035otq.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 15:06:00 -0800 (PST)
X-Gm-Message-State: AOAM530UD58R3psqepT10av4AFz+Q+qdpzJHwlL5y/WSGSvJUB/Jg2EJ
        UssJOY1vkA7GQAv8V3ALyHHQ3KQa/2ZO59d2RWA=
X-Google-Smtp-Source: ABdhPJwVeTYxtTIQgieBTMy2ar3dVoYeCHfZkAe2KosK6iUF8OrSS/piswFxRl5325rtDKJ3WU/BpQECuUJIxCa8wGo=
X-Received: by 2002:a05:6830:18e6:: with SMTP id d6mr3914294otf.251.1613171159960;
 Fri, 12 Feb 2021 15:05:59 -0800 (PST)
MIME-Version: 1.0
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
 <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com> <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com>
In-Reply-To: <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 13 Feb 2021 00:05:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
Message-ID: <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
Subject: Re: [RFC] IRQ handlers run with some high-priority interrupts(not
 NMI) enabled on some platform
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "funaho@jurai.org" <funaho@jurai.org>,
        "philb@gnu.org" <philb@gnu.org>, "corbet@lwn.net" <corbet@lwn.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 12:00 AM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd@kernel.org]
> > Sent: Saturday, February 13, 2021 11:34 AM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: tglx@linutronix.de; gregkh@linuxfoundation.org; arnd@arndb.de;
> > geert@linux-m68k.org; funaho@jurai.org; philb@gnu.org; corbet@lwn.net;
> > mingo@redhat.com; linux-m68k@lists.linux-m68k.org;
> > fthain@telegraphics.com.au; linux-kernel@vger.kernel.org
> > Subject: Re: [RFC] IRQ handlers run with some high-priority interrupts(not NMI)
> > enabled on some platform
> >
> > On Fri, Feb 12, 2021 at 2:18 AM Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com> wrote:
> >
> > > So I am requesting comments on:
> > > 1. are we expecting all interrupts except NMI to be disabled in irq handler,
> > > or do we actually allow some high-priority interrupts between low and NMI
> > to
> > > come in some platforms?
> >
> > I tried to come to an answer but this does not seem particularly well-defined.
> > There are a few things I noticed:
> >
> > - going through the local_irq_save()/restore() implementations on all
> >   architectures, I did not find any other ones besides m68k that leave
> >   high-priority interrupts enabled. I did see that at least alpha and openrisc
> >   are designed to support that in hardware, but the code just leaves the
> >   interrupts disabled.
>
> The case is a little different. Explicit local_irq_save() does disable all
> high priority interrupts on m68k. The only difference is arch_irqs_disabled()
> of m68k will return true while low-priority interrupts are masked and high
> -priority are still open. M68k's hardIRQ also runs in this context with high
> priority interrupts enabled.

My point was that on most other architectures, local_irq_save()/restore()
always disables/enables all interrupts, while on m68k it restores the
specific level they were on before. On alpha, it does the same as on m68k,
but then the top-level interrupt handler just disables them all before calling
into any other code.

It's possible that I missed some other implementation doing the same
as m68k, as this code is fairly subtle on some architectures.

        Arnd
