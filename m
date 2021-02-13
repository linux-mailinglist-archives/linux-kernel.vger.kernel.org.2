Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F06731AD25
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 17:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhBMQdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 11:33:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhBMQc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 11:32:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9940964E2C
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613233937;
        bh=nfPivI676TW1Vyh+48AYclAWuVpk7t0piH1yKqAy+T4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kgnasnZBwka5FrcUtUMuzU5alzSSg7eCcCSdRhZZK/X2J0KEnAKwzVO/MdIAQKNdl
         PQcL2ouGanAk7OCCUAHXFEFw3cMrQpbs2LYKVUokZxACJrD086k21C/PXxaBPBeLO4
         Bn9v0Xv86blzlepR/Zhd5R7telTrUvyxNvYMFd2RtXVru02c2QEZ779IMhWcxqo0rl
         si7W0IIefQLaCEU347Kv+O917oiouzte9AKckt/CeRPprMkhecZsB4w4oAHIBma52k
         AbZ2p9N/ZsxmaD76q3j9f9jE0xZ0jK2+o0lvXZge0xbSJNQEUAdY45a15pdCyPJY5q
         1urhH7NZEGrKw==
Received: by mail-oi1-f180.google.com with SMTP id f3so3160649oiw.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:32:17 -0800 (PST)
X-Gm-Message-State: AOAM531GT95zz81bWLAF7IIENyzo6/Pl/HF907Y9IYlrWMf6NApURwGO
        FiuW1dkKRietgwkMel+UIZFJhmU57UrMOa3skOY=
X-Google-Smtp-Source: ABdhPJxu9CAbLoK/yoJdEoMHdvhxaDAU66vTbDCG+Q0e+t1pnRuMtUkIFbROtKSMN4VqXn/nJMFIw60amkYm558mfwc=
X-Received: by 2002:aca:d908:: with SMTP id q8mr3115221oig.67.1613233936881;
 Sat, 13 Feb 2021 08:32:16 -0800 (PST)
MIME-Version: 1.0
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
 <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com>
 <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com> <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com>
In-Reply-To: <0b766dba0b004ced94131e158cd8e67d@hisilicon.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 13 Feb 2021 17:32:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>
Message-ID: <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>
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

On Sat, Feb 13, 2021 at 12:50 AM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:

> So I was actually trying to warn this unusual case - interrupts
> get nested while both in_hardirq() and irqs_disabled() are true.
>
> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index 7c9d6a2d7e90..b8ca27555c76 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -32,6 +32,7 @@ static __always_inline void rcu_irq_enter_check_tick(void)
>   */
>  #define __irq_enter()                                  \
>         do {                                            \
> +               WARN_ONCE(in_hardirq() && irqs_disabled(), "nested
> interrupts\n"); \
>                 preempt_count_add(HARDIRQ_OFFSET);      \

That seems to be a rather heavyweight change in a critical path.

A more useful change might be to implement lockdep support for m68k
and see if that warns about any actual problems. I'm not sure
what is actually missing for that, but these are the commits that
added it for other architectures in the past:

3c4697982982 ("riscv: Enable LOCKDEP_SUPPORT & fixup TRACE_IRQFLAGS_SUPPORT")
000591f1ca33 ("csky: Enable LOCKDEP_SUPPORT")
78cdfb5cf15e ("openrisc: enable LOCKDEP_SUPPORT and irqflags tracing")
8f371c752154 ("xtensa: enable lockdep support")
bf2d80966890 ("microblaze: Lockdep support")

> And I also think it is better for m68k's arch_irqs_disabled() to
> return true only when both low and high priority interrupts are
> disabled rather than try to mute this warn in genirq by a weaker
> condition:
>              if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pS enabled interrupts\n",
>                              irq, action->handler))
>                        local_irq_disable();
> }
>
> This warn is not activated on m68k because its arch_irqs_disabled() return
> true though its high-priority interrupts are still enabled.

Then it would just end up always warning when a nested hardirq happens,
right? That seems no different to dropping support for nested hardirqs
on m68k altogether, which of course is what you suggested already.

       Arnd
