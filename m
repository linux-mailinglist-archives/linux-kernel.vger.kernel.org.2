Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0617D3B8824
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhF3SHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhF3SHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:07:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA034C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VE0q9DtRkjzggaaOScdLZfxUKJH7PVc8WW0c2VORJjw=; b=Q3Cn3XxrA/5nM7Hz1HDG32Ck5W
        K2m+4JUgMzi50dyWMhjvbsS7qwrvI1To3xY3HPFbLtYCnca1VC6Wp4gD0XV481M+tVS3Un2mQrDrT
        ynpl0WHfEL8mK0E6/S12XSKCA66HKPbC50xoKTBAqpOuVSK5wyt68MHb7lhut7z7+br8zhes5gx7i
        VMKMUFYUE7K8B6O3PHTf9pdQ1Rw3ApovquxT+XkjQ+3aoxRAcTt03DPoHi9Va8tZQ44ato9TqmeWK
        0q5keJQjLIqY8i0UPxTeI+AQjD6mitU0CajKFQ68HLaN48U/p45CECnHdVWc1YjWih2QWk8xktbb5
        kPZZU5lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyeZg-005dO7-UQ; Wed, 30 Jun 2021 18:04:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11808300242;
        Wed, 30 Jun 2021 20:04:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3A3D2C3ACFF8; Wed, 30 Jun 2021 20:04:34 +0200 (CEST)
Date:   Wed, 30 Jun 2021 20:04:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <llong@redhat.com>
Cc:     mingo@redhat.com, boqun.feng@gmail.com, will@kernel.org,
        linux-kernel@vger.kernel.org, yanfei.xu@windriver.com
Subject: Re: [RFC][PATCH 3/4] locking/mutex: Introduce
 __mutex_trylock_or_handoff()
Message-ID: <YNyyMvPYBmyexlmC@hirez.programming.kicks-ass.net>
References: <20210630153516.832731403@infradead.org>
 <20210630154114.958507900@infradead.org>
 <9c47a47c-0c95-4f8f-8b62-a1aff10be748@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c47a47c-0c95-4f8f-8b62-a1aff10be748@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 12:30:43PM -0400, Waiman Long wrote:
> On 6/30/21 11:35 AM, Peter Zijlstra wrote:
> > Yanfei reported that it is possible to loose HANDOFF when we race with
> > mutex_unlock() and end up setting HANDOFF on an unlocked mutex. At
> > that point anybody can steal it, loosing HANDOFF in the process.
> > 
> > If this happens often enough, we can in fact starve the top waiter.
> > 
> > Solve this by folding the 'set HANDOFF' operation into the trylock
> > operation, such that either we acquire the lock, or it gets HANDOFF
> > set. This avoids having HANDOFF set on an unlocked mutex.
> > 
> > Reported-by: Yanfei Xu <yanfei.xu@windriver.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >   kernel/locking/mutex.c |   58 +++++++++++++++++++++++++++++--------------------
> >   1 file changed, 35 insertions(+), 23 deletions(-)
> > 
> > --- a/kernel/locking/mutex.c
> > +++ b/kernel/locking/mutex.c
> > @@ -91,10 +91,7 @@ static inline unsigned long __owner_flag
> >   	return owner & MUTEX_FLAGS;
> >   }
> > -/*
> > - * Trylock variant that returns the owning task on failure.
> > - */
> > -static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
> > +static inline struct task_struct *__mutex_trylock_common(struct mutex *lock, bool handoff)
> >   {
> >   	unsigned long owner, curr = (unsigned long)current;
> > @@ -104,39 +101,56 @@ static inline struct task_struct *__mute
> >   		unsigned long task = owner & ~MUTEX_FLAGS;
> >   		if (task) {
> > -			if (likely(task != curr))
> > +			if (flags & MUTEX_FLAG_PICKUP) {
> > +				if (task != curr)
> > +					break;
> > +				flags &= ~MUTEX_FLAG_HANDOFF;
> 
> I think you mean "flags &= ~MUTEX_FLAG_PICKUP". Right:-)

Duh, yes. That's what you get trying to write patches with a kid in your
lap.. :-)
