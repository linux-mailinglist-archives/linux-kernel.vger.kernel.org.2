Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D9331A802
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 23:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhBLWrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 17:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232235AbhBLWfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:35:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 407A964EA0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 22:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613169278;
        bh=WDyM20Jkx5Lw2bXDBhtM/Wh7714B42NhueKvph+Nmws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sGNJ1FzwLlsK9G9bklHujIthTsFGFY/yIAcdMaLkUTYUHn4Y+F3epfaRcd2ld94+w
         7ub8pmFQERVj0RUZ1n10vEfBhPFGzTBG3VfX1tnqFijvhG+HiUMgyQDtMhFbbiJVTt
         KpdlMALtH7f/zCeoAjlR75nryl/MSpTaFohmPuhXogJk+ZFNg+cdLlytfMATL0sQF3
         DZgaRs9NEVnnvhynihRM2njK6ZFQu9dJikBwLErLfH3zCAo2uwhy5uQLyBTnz1XySE
         Y624LG46WeKxU2s4fdYsIlwOPEYox2lbjKw30gz8M0Q0qZiwgOYhsqLZdF4YTxjD5s
         PiUQRdppEV+pA==
Received: by mail-oi1-f172.google.com with SMTP id k204so1371769oih.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 14:34:38 -0800 (PST)
X-Gm-Message-State: AOAM530rBKdDJFREpXqJ3jkNvbF9+fXMRZi1LOplR5G7DlDHiq4a+XOB
        60YyvdhT1mo+ybWxF4Vf4D5dKEp8j4AdFjiuB5E=
X-Google-Smtp-Source: ABdhPJx/7gkwqMIiK2PlMZhZJc/b8vIR/e3YxMMVOnzfXH0frnKMagH9dJRnXtgSUbndHhDPoZAkoN8idKp9hOuxVM8=
X-Received: by 2002:aca:e103:: with SMTP id y3mr1198690oig.11.1613169277530;
 Fri, 12 Feb 2021 14:34:37 -0800 (PST)
MIME-Version: 1.0
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
In-Reply-To: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 12 Feb 2021 23:34:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com>
Message-ID: <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com>
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

On Fri, Feb 12, 2021 at 2:18 AM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:

> So I am requesting comments on:
> 1. are we expecting all interrupts except NMI to be disabled in irq handler,
> or do we actually allow some high-priority interrupts between low and NMI to
> come in some platforms?

I tried to come to an answer but this does not seem particularly well-defined.
There are a few things I noticed:

- going through the local_irq_save()/restore() implementations on all
  architectures, I did not find any other ones besides m68k that leave
  high-priority interrupts enabled. I did see that at least alpha and openrisc
  are designed to support that in hardware, but the code just leaves the
  interrupts disabled.

- The generic code is clearly prepared to handle nested hardirqs, and
   the irq_enter()/irq_exit() functions have a counter in preempt_count
   for the nesting level, using a 4-bit number for hardirq, plus another
   4-bit number for NMI.

- There are a couple of (ancient) drivers that enable interrupts in their
   interrupt handlers, see the four callers of local_irq_enable_in_hardirq()
   (all in the old drivers/ide stack) and arch/ia64/kernel/time.c, which
   enables interupts in its timer function (I recently tried removing this
   and my patch broke ia64 timers, but I'm not sure if the cause was
   the local_irq_enable() or something else).

- The local_irq_enable_in_hardirq() function itself turns into a nop
  when lockdep is enabled, since d7e9629de051 ("[PATCH] lockdep:
  add local_irq_enable_in_hardirq() API"). According to the comment
  in there, lockdep already enforces the behavior you suggest. Note that
  lockdep support is missing on m68k (and also alpha, h8300, ia64, nios2,
  and parisc).

> 2. If either side is true, I think we need to document it somewhere as there
> is always confusion about this.
>
> Personally, I would expect all interrupts to be disabled and I like the way
> of ARM64 to only use high-priority interrupt as pseudo NMI:
> https://lwn.net/Articles/755906/
> Though Finn argued that this will contribute to lose hardware feature of m68k.

Regardless of what is documented, I would argue that any platform
that relies on this is at the minimum doing something risky because at
the minimum this runs into hard to debug code paths that are not
exercised on any of the common architectures.

        Arnd
