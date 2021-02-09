Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311F4314ED8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBIMVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhBIMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:21:53 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD52C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 04:21:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u15so9672313plf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 04:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wn6ML4D9ib7Umq62f8jkbYVxDjFrwWSjEsDdw0l1TAM=;
        b=xxa0yUnVDStd9dUIvPcRbgNC5b++rEY30NrYLc9K4cm3QlvOF9blbl5iZ4/ecIBfI/
         W9ayAPhmgVJ5SlaCtf0aBvZpASzEI1bBjXKNGbnplpo9wL/iNr0ZADB7oQXNUre08txH
         08CUMh7kIO7fgRUhbLLiMKig5l6QJ5ZlzbDai6xIu/zWmNwTy2IRllC8XOVwPgnI1gAs
         MTwTG8LvoRQxzZi7iOURE9snpPVTQ3ZTPBtisv7j5iLg+1peMmphrNPql8+gLCXEExH9
         bXSG5GNItFUWsSEpTyknawY5V4n0+eXcaaVQ4AbcZ+0dqJJ/Nsdib16559s6C0HBwoKR
         u4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wn6ML4D9ib7Umq62f8jkbYVxDjFrwWSjEsDdw0l1TAM=;
        b=Q30iVKBVDJ0f4Hzhn/UKYpx2rARCTvOb55WFWAlnE6PBjp7SwQeP132b+ScJtokZkO
         f77sB4jCVB+9pF5rhh0+tL8F5vi92lR4IWKsn47pL1NswMWysSrZ86yl1K2RFdBl/Qdz
         0qgaV9hoCq2PwJccL5thPyXT6CfONWJBxXLooWmb9jG7feHJSPkSVP+siiZPOLT9Tc+J
         Y7JO83gqtxdUhSb0MPqNMndwRMc4XQkD/FPI5XC3ThPeRHOfzpp0tc58wbVCwfycld4C
         xp4kBiujz6A7oID5tuUFh04/96Cg5K3a1e+CPh6vAtnupbsLpT29MRGV9VaueIAf+0SH
         9NPA==
X-Gm-Message-State: AOAM532Pl+8cBDQN0xXeyzvV2NaQaIuRdgrpgoy5yVtcnZkrVZ6LErgq
        PkqNKR/Zts0K4KqGGYPC3R86/oJvyWtFNin3ZzrNgQ==
X-Google-Smtp-Source: ABdhPJwzzNDNJEgOlgJVcYCVdF2ByMK6jjjEdff7bFHVPwbTnSfTiWygGhjH8SNMNZqfZ+ol82iHmE83ASxdrz+QSZo=
X-Received: by 2002:a17:90a:9a4:: with SMTP id 33mr3806342pjo.147.1612873272144;
 Tue, 09 Feb 2021 04:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20210206054124.6743-1-songmuchun@bytedance.com> <YCJTrrirMlH7M5i7@alley>
In-Reply-To: <YCJTrrirMlH7M5i7@alley>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 9 Feb 2021 20:20:35 +0800
Message-ID: <CAMZfGtVNDhmJxHyScXo6pS7tHnTaGTrOVhwW23iZqrtBB7wVSg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] printk: fix deadlock when kernel panic
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        john.ogness@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 5:19 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Sat 2021-02-06 13:41:24, Muchun Song wrote:
> > We found a deadlock bug on our server when the kernel panic. It can be
> > described in the following diagram.
> >
> > CPU0:                                         CPU1:
> > panic                                         rcu_dump_cpu_stacks
> >   kdump_nmi_shootdown_cpus                      nmi_trigger_cpumask_backtrace
> >     register_nmi_handler(crash_nmi_callback)      printk_safe_flush
> >                                                     __printk_safe_flush
> >                                                       raw_spin_lock_irqsave(&read_lock)
> >     // send NMI to other processors
> >     apic_send_IPI_allbutself(NMI_VECTOR)
> >                                                         // NMI interrupt, dead loop
> >                                                         crash_nmi_callback
> >   printk_safe_flush_on_panic
> >     printk_safe_flush
> >       __printk_safe_flush
> >         // deadlock
> >         raw_spin_lock_irqsave(&read_lock)
> >
> > The register_nmi_handler() can be called in the __crash_kexec() or the
> > crash_smp_send_stop() on the x86-64. Because CPU1 is interrupted by the
> > NMI with holding the read_lock and crash_nmi_callback() never returns,
> > CPU0 can deadlock when printk_safe_flush_on_panic() is called.
> >
> > When we hold the read_lock and then interrupted by the NMI, if the NMI
> > handler call nmi_panic(), it is also can lead to deadlock.
> >
> > In order to fix it, we make read_lock global and rename it to
> > safe_read_lock. And we handle safe_read_lock the same way in
> > printk_safe_flush_on_panic() as we handle logbuf_lock there.
>
> What about the following commit message? It uses imperative language
> and explains that the patch just prevents the deadlock. It removes
> some details. The diagram is better than many words.
>
> <commit message>
> printk_safe_flush_on_panic() caused the following deadlock on our server:
>
> CPU0:                                         CPU1:
> panic                                         rcu_dump_cpu_stacks
>   kdump_nmi_shootdown_cpus                      nmi_trigger_cpumask_backtrace
>     register_nmi_handler(crash_nmi_callback)      printk_safe_flush
>                                                     __printk_safe_flush
>                                                       raw_spin_lock_irqsave(&read_lock)
>     // send NMI to other processors
>     apic_send_IPI_allbutself(NMI_VECTOR)
>                                                         // NMI interrupt, dead loop
>                                                         crash_nmi_callback
>   printk_safe_flush_on_panic
>     printk_safe_flush
>       __printk_safe_flush
>         // deadlock
>         raw_spin_lock_irqsave(&read_lock)
>
> DEADLOCK: read_lock is taken on CPU1 and will never get released.
>
> It happens when panic() stops a CPU by NMI while it has been in
> the middle of printk_safe_flush().
>
> Handle the lock the same way as logbuf_lock. The printk_safe buffers
> are flushed only when both locks can be safely taken.
>
> Note: It would actually be safe to re-init the locks when all CPUs were
>       stopped by NMI. But it would require passing this information
>       from arch-specific code. It is not worth the complexity.
>       Especially because logbuf_lock and printk_safe buffers have been
>       obsoleted by the lockless ring buffer.
> </commit message>

Many thanks. It is clear.

>
> > Fixes: cf9b1106c81c ("printk/nmi: flush NMI messages on the system panic")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> With an updated commit message:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks. I will update the commit message.

>
> Best Regards,
> Petr
