Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB89D35C958
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbhDLPCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:02:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbhDLPCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:02:12 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618239713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ukvl3N7Zt1GUDMaWqR9cBlw29fbNim9SwpindRDnR0Y=;
        b=o//Hi/1equhXjFYn4D23i+bmbjZ6vjB5u1JRXniR9X4+9imQ1sIxhxTamkDGxeB10V0RDn
        68y/VcGQ7hJw+snjOluCRaDjThDzG8s8MJRt1VYdrYyRaKLPOatPt5R8seegeiEbnWjNuT
        LX3J4PBIGRAmLe3AjrZUc7Am3912dYTmX2wZEeyAmuQfoNBtlemplh+Xzn4aQEMOA3PPhn
        UHppNEPJWTOlgIaltdgs/8OBrH7Ur/bV2Scg7a+bXCVUMDyUNmdbb7pfI+YY/+DL6CkMf6
        QqXwMQZyJwKFot0lFxueGhB5p0tCNC78Nv6sfKtUJq5LAY4Tb+G8ehEhDch7ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618239713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ukvl3N7Zt1GUDMaWqR9cBlw29fbNim9SwpindRDnR0Y=;
        b=OD2GkfVLY61w715PXyoHwObCTRRwaLJCDdK3I72qmPGz4YW4ONO3Gz5Im9xvR2R/gRLPvo
        5WeQp12TAoh5zuCg==
To:     Matthew Wilcox <willy@infradead.org>
Cc:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] locking: Add split_lock
In-Reply-To: <20210412144525.GM2531743@casper.infradead.org>
References: <20210409025131.4114078-3-willy@infradead.org> <87blaj1sqf.ffs@nanos.tec.linutronix.de> <20210412144525.GM2531743@casper.infradead.org>
Date:   Mon, 12 Apr 2021 17:01:53 +0200
Message-ID: <877dl71r8e.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12 2021 at 15:45, Matthew Wilcox wrote:
> On Mon, Apr 12, 2021 at 04:29:28PM +0200, Thomas Gleixner wrote:
>> On Fri, Apr 09 2021 at 03:51, Matthew Wilcox wrote:
>> > Bitlocks do not currently participate in lockdep.  Conceptually, a
>> > bit_spinlock is a split lock, eg across each bucket in a hash table.
>> > The struct split_lock gives us somewhere to record the lockdep_map.
>> 
>> I like the concept, but the name is strange. The only purpose of 
>> 
>> > +struct split_lock {
>> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
>> > +	struct lockdep_map dep_map;
>> > +#endif
>> > +};
>> 
>> is to have a place to stick the lockdep map into. So it's not a lock
>> construct as the name suggests, it's just auxiliary data when lockdep is
>> enabled.
>
> That's the implementation _today_, but conceptually, it's a single lock.
> I was thinking that for non-RT, we could put a qspinlock in there for a
> thread to spin on if the bit is contended.  It'd need a bit of ingenuity
> to make sure that a thread unlocking a bitlock made sure that a thread
> spinning on the qspinlock saw the wakeup, but it should be doable.

Ah, that's what you have in mind.

> Anyway, from the point of view of the user, they should be declaring
> "this is the lock", not "this is the lock tracking structure", right?
>
>> I know you hinted that RT could make use of that data structure and the
>> fact that it's mandatory for the various lock functions, but that's not
>> really feasible if this is related to a hash with a bit spinlock per
>> bucket as the data structure is hash global.
>> 
>> Sure, we can do pointer math to find out the bucket index and do
>> something from there, but I'm not sure whether that really helps. Need
>> to stare at the remaining few places where bit spinlocks are an issue on
>> RT.
>
> I obviously don't understand exactly what the RT patchset does.  My
> thinking was that you could handle the bit locks like rw sems, and
> sacrifice the scalability of per-bucket-lock for the determinism of
> a single PI lock.

That'd suck for most bit spinlocks where the lock is just protecting
minimal hashlist operations and these preeempt disabled protections are
actually shorter than the overhead of a heavier lock.

For situations where the bit spinlock was actually an issue (long
traversals or such) in older kernel versions we just bit the bullet and
bloated the hash data structure with an actual spinlock and had some
wrappers to hide the mess from the actual code. That still preserved the
scalability while making the lock held section preemptible which we
obviously cannot have with real bit spinlocks even on RT.

But your idea of having a qspinlock for the contended case might
actually be something which might be worth to exploit RT wise -
obviously not with a qspinlock :) - but conceptually.

Need to think more about it.

Thanks,

        tglx
