Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4935C3E8CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhHKJBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 05:01:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48982 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhHKJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:00:59 -0400
Date:   Wed, 11 Aug 2021 11:00:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628672434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6NUQ3TyOknPB3iraV2OgTTMR9Er1TbuGJXWQNUYkDqU=;
        b=u6BMEXBN2yeUctjIs2HApfcf8dYyn07sY99LQ8uM7znA/yEGZJ3w5pbH1Ihhe4qMzSo7ac
        qPk2YuOa0X83kkOF7savnE+eF4l2NRb2CzvsLr+K/hRm01IcO0USiHbd3WfyQzVWOQ2bMY
        ZWkBvoACEIwqtnDfHIcew7aEvDIIUlibFZStW+vF95v3VQdkPjWJI9EpSoIm8qjOV0ONjd
        FiM19UMKXxhPoM/GLl+4ins5GJ6DylaIYMPNLrg4OBQfjleTkpWVmZxVff9xQFSgCIt9DW
        7+WnFnvuZW4gBzd8FMUbO3DsQKLWNjNz2WS0gRme/jsd4tEK+A3289WpZv4taw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628672434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6NUQ3TyOknPB3iraV2OgTTMR9Er1TbuGJXWQNUYkDqU=;
        b=ZIrd3wXtGnh9Qa9T0DZIudsTeT22ZUnv/O7EwgJ6VjkxgYCf8DcfKdk+++agUZEVnUVbPz
        slaKnDd/5GHqLpAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH PREEMPT_RT] kcov:  fix locking splat from
 kcov_remote_start()
Message-ID: <20210811090033.wijh4v37wlnny3ox@linutronix.de>
References: <20210809155909.333073de@theseus.lan>
 <20210810095032.epdhivjifjlmbhp5@linutronix.de>
 <87sfzhox15.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87sfzhox15.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-10 22:38:30 [+0200], Thomas Gleixner wrote:
> On Tue, Aug 10 2021 at 11:50, Sebastian Andrzej Siewior wrote:
> > On 2021-08-09 15:59:09 [-0500], Clark Williams wrote:
> >> Saw the following splat on 5.14-rc4-rt5 with:
> > =E2=80=A6
> >> Change kcov_remote_lock from regular spinlock_t to raw_spinlock_t so t=
hat
> >> we don't get "sleeping function called from invalid context" on PREEMP=
T_RT kernel.
> >
> > I'm not entirely happy with that:
> > - kcov_remote_start() decouples spin_lock_irq() and does local_irq_save=
()
> >   + spin_lock() which shouldn't be done as per
> >       Documentation/locking/locktypes.rst
> >   I would prefer to see the local_irq_save() replaced by
> >   local_lock_irqsave() so we get a context on what is going on.
>=20
> Which does not make it raw unless we create a raw_local_lock.

But why raw? I was thinking about local_lock_irqsave() instead of
local_irq_save() and keeping the spinlock_t.

> > - kcov_remote_reset() has a kfree() with that irq-off lock acquired.
>=20
> That free needs to move out obviously
>=20
> > - kcov_remote_add() has a kmalloc() and is invoked with that irq-off
> >   lock acquired.
>=20
> So does the kmalloc.
>=20
> > - kcov_remote_area_put() uses INIT_LIST_HEAD() for no reason (just
> >   happen to notice).
> >
> > - kcov_remote_stop() does local_irq_save() + spin_lock(&kcov->lock);.
> >   This should also create a splat.
> >
> > - With lock kcov_remote_lock acquired there is a possible
> >   hash_for_each_safe() and list_for_each() iteration. I don't know what
> >   the limits are here but with a raw_spinlock_t it will contribute to
> >   the maximal latency.=20
>=20
> And that matters because? kcov has a massive overhead and with that
> enabled you care as much about latencies as you do when running with
> lockdep enabled.

I wasn't aware of that. However, with that local_irq_save() ->
local_lock_irqsave() swap and that first C code from
Documentation/dev-tools/kcov.rst I don't see any spike in cyclictest's
results. Maybe I'm not using it right=E2=80=A6

> Thanks,
>=20
>         tglx

Sebastian
