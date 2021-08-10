Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA19A3E8471
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhHJUi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:38:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45796 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhHJUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:38:54 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628627911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkVtjYm3BfNCg+SbthLRj+WEbFU9jkunNTtXTBea3V4=;
        b=Y/oBbb4FW3u8yktuwVCeGFD164Laq+BYDynM0nVW9KRLRPJHvV+2m60JsEMFm79ERanvev
        NuZZywbDhDV07G86qQbwXG1MTBxysxW2i1tuOOnIyqMWSmQT8r7luxCCu1H1mb+nZij9VE
        vhh4fTNg+wwXQKyWJ+P2DnERF/NxuRaBuoIO8TvpQaq/GmV+i3Oy1WLXnaJ3ZU+MGCBWMb
        tDh9tjfCDjeZ1hBdhHjBzp2dyDKJlYZGbjMPksgQOBGGNWkzrN46QNqmkoaPMHOSGmZ1ZX
        P6NEByuvsNbEJH38ly92/JvRbogZRZk/a2KxlFgcQwVzVdVmiBCMGipnKxFnfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628627911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkVtjYm3BfNCg+SbthLRj+WEbFU9jkunNTtXTBea3V4=;
        b=Yf3Ht3y3955z1yV0IKDS3aUnunEjBXY+XP4xTvfitS/jfvKJUs50PBQ7WVqbXS5KyhOEFt
        CLyWve4MQ+5GxrCw==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH PREEMPT_RT] kcov:  fix locking splat from
 kcov_remote_start()
In-Reply-To: <20210810095032.epdhivjifjlmbhp5@linutronix.de>
References: <20210809155909.333073de@theseus.lan>
 <20210810095032.epdhivjifjlmbhp5@linutronix.de>
Date:   Tue, 10 Aug 2021 22:38:30 +0200
Message-ID: <87sfzhox15.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10 2021 at 11:50, Sebastian Andrzej Siewior wrote:
> On 2021-08-09 15:59:09 [-0500], Clark Williams wrote:
>> Saw the following splat on 5.14-rc4-rt5 with:
> =E2=80=A6
>> Change kcov_remote_lock from regular spinlock_t to raw_spinlock_t so that
>> we don't get "sleeping function called from invalid context" on PREEMPT_=
RT kernel.
>
> I'm not entirely happy with that:
> - kcov_remote_start() decouples spin_lock_irq() and does local_irq_save()
>   + spin_lock() which shouldn't be done as per
>       Documentation/locking/locktypes.rst
>   I would prefer to see the local_irq_save() replaced by
>   local_lock_irqsave() so we get a context on what is going on.

Which does not make it raw unless we create a raw_local_lock.

> - kcov_remote_reset() has a kfree() with that irq-off lock acquired.

That free needs to move out obviously

> - kcov_remote_add() has a kmalloc() and is invoked with that irq-off
>   lock acquired.

So does the kmalloc.

> - kcov_remote_area_put() uses INIT_LIST_HEAD() for no reason (just
>   happen to notice).
>
> - kcov_remote_stop() does local_irq_save() + spin_lock(&kcov->lock);.
>   This should also create a splat.
>
> - With lock kcov_remote_lock acquired there is a possible
>   hash_for_each_safe() and list_for_each() iteration. I don't know what
>   the limits are here but with a raw_spinlock_t it will contribute to
>   the maximal latency.=20

And that matters because? kcov has a massive overhead and with that
enabled you care as much about latencies as you do when running with
lockdep enabled.

Thanks,

        tglx
