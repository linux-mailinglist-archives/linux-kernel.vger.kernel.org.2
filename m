Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878003DA4B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbhG2Ntz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbhG2Ntt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:49:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99762C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:49:43 -0700 (PDT)
Date:   Thu, 29 Jul 2021 15:49:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627566581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AcuTxtCWc7dvChHENJ1cxe+npo6DxDyUWmFZfqMazOc=;
        b=EubKtSzTkMXTloViqbb5RTFmlqzcZ9YlwwqBbwOOp7z6MuYpQIFffDvoDAz68c9RYwZ6Cx
        d18BZIpfWCwkCWBM0WUFQXNsa1+kYIQ0SkVpMqxkOqhgRWAx/3cAqeiJHHOnl4pzUZ2oNr
        NLTa/AFrjZW9CGrTSYzGtgB0o1CJleHotA0LOCxih0ktfIMCAnG3YPmso7q377/iDIkmjJ
        YQoe+sWkZomAJlVtn+RaYbChnpXGjT31GKFcxigyUnV4xqFpW13fSWWD5lm39y5Oedpaht
        +2jypXqSueUIEGnV0fAvTMomqnZ5ygJhUQD1JnGQwdyR4YtlaT1NsJTHb4qjSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627566581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AcuTxtCWc7dvChHENJ1cxe+npo6DxDyUWmFZfqMazOc=;
        b=opBTzDuxAxGTAW1GzLWMCe3xK98EaOZ4oRjNsvQvPkkLRvVitJTQEEyuZMyr8KQ8Y8nkGW
        uMLT+7e36KsilyAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
Message-ID: <20210729134939.iulryxjarhjmpugz@linutronix.de>
References: <20210609113903.1421-1-vbabka@suse.cz>
 <20210702182944.lqa7o2a25to6czju@linutronix.de>
 <35b26e48-a96a-41b0-826e-43e43660c9d6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <35b26e48-a96a-41b0-826e-43e43660c9d6@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

now that I'm slowly catching up=E2=80=A6

On 2021-07-02 22:25:05 [+0200], Vlastimil Babka wrote:
> > - perf_5.10 stat -r 10 hackbench -g200 -s 4096 -l500
> > Old:
> > |         464.967,20 msec task-clock                #   27,220 CPUs uti=
lized            ( +-  0,16% )
> > New:
> > |         422.865,71 msec task-clock                #    4,782 CPUs uti=
lized            ( +-  0,34% )
>=20
> The series shouldn't significantly change the memory allocator
> interaction, though.
> Seems there's less cycles, but more time elapsed, thus more sleeping -
> is it locks becoming mutexes on RT?

yes, most likely since the !RT parts are mostly unchanged.

> My second guess - list_lock remains spinlock with my series, thus RT
> mutex, but the current RT tree converts it to raw_spinlock. I'd hope
> leaving that one as non-raw spinlock would still be much better for RT
> goals, even if hackbench (which is AFAIK very slab intensive) throughput
> regresses - hopefully not that much.

Yes, the list_lock seems to be the case. I picked your
slub-local-lock-v3r0 and changed the list_lock (+slab_lock()) to use
raw_spinlock_t and disable interrupts and CPUs utilisation went to
~23CPUs (plus a bunch of warnings which probably made it a little slower
again).
The difference between a sleeping lock (spinlock_t) and a mutex is
that we attempt not to preempt a task that acquired a spinlock_t even if
it is running for some time and the scheduler would preempt it (like it
would do if the task had a mutex acquired. These are the "lazy preempt"
bits in the RT patch).

By making the list_lock a raw_spinlock_t a lot of IRQ-flags dancing
needs to be done as the page-allocator must be entered with enabled
interrupts. And then there is the possibility that you may need to free
some memory even if you allocate memory which requires some extra steps
on RT due to the IRQ-off part. All this vanishes by keeping list_lock a
spinlock_t.
The kernel-build test on /dev/shm remained unchanged so that is good.
Unless there is a real-world use-case, that gets worse, I don't mind
keeping the spinlock_t here. I haven't seen tglx complaining so far.

Sebastian
