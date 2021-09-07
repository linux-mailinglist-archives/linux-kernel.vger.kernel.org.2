Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CEB4026DB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbhIGKKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:10:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42082 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbhIGKKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:10:52 -0400
Date:   Tue, 7 Sep 2021 12:09:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631009385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X3xJ/K7ARPNqBxdO8tT0g+C+acJPJwzV8bOkDpm+oyQ=;
        b=FLDf7uYem4BNLITiPtbA16SSkuWsoinmL9MpySvquEfdrBBY2KYKdOia2qOKC/7elctkZI
        F7eXNApMwQqvKCqxOSUGPiK7QXnFCqddX3AlIyS5ZVQHsYMjq0+ABQoAhCWm5gIqx43fTY
        qH50dCAALi6NCMVNozfk3KCXBq9YUTnF2A6VV46laF9CqU6Ol/KDr8p3Dq7l+TpMSaWVzb
        OQEvvKuxGp1mdT8qdIoKwEzRfsTonk/6OyUzTVm7al1k38sPS6gxIFh1YcC6zDCisDG6W/
        TPCuINZ4VUEQSH4GVaA2mPdigSVPRHIUC0Ut5JvayIkUdWsYdcgflME2XZC0Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631009385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X3xJ/K7ARPNqBxdO8tT0g+C+acJPJwzV8bOkDpm+oyQ=;
        b=rYMDOepFGO55liBymJy/qYdAYxgwFzmoL9v76wgGaoROOMDr8L9a3JuYQ8m+vUippdUDYQ
        nNfJhNQ8X7gX3WAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] locking: Provide {rwlock|spin}_is_contended on
 PREEMPT_RT
Message-ID: <20210907100944.7qu3frjuuty3oi3d@linutronix.de>
References: <20210906143004.2259141-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210906143004.2259141-1-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-06 16:30:02 [+0200], To linux-kernel@vger.kernel.org wrote:
> The lkp bot reported that rt_rwlock_is_contended() is not used so I
> looked closer.
> 
> #1 wires up rwlock_is_contended() with rt_rwlock_is_contended() as it
> was probably intended. As noted in the patch description, a writer
> will always see true based on the current implementation. This could be
> solved by looking at the waiters of the rtmutex underneath as done in #2
> for spin_lock (which is missing). The helper is not exported and would
> be also needed for rwsem_is_contended() because it is using the same
> rw_base_is_contended() implementation.
> 
> Maybe it is not worth the trouble given that on PREEMPT_RT the rwlock/
> spinlock is preemptible so it might be just best to return false and
> wait for the scheduler to do its magic.

I looked at callers and would argue that we could simply return false
here for all is_conded checks (as we do). We don't spin on RT but
schedule out on contention and even if there are waiters, as long as we
are the task with the highest priority, then the lock won't be handed
over to the next task in line. Therefore I suggest to remove the unused
rt_rwlock_is_contended().

The rwsem_is_contended() makes sense since it is only used by readers.
Also it is a sleep-able lock so it has the same semantic as !RT.
However. shrink_slab() will drop the lock _and_ could move on which is
good. The two mmap_lock_is_contended() user will drop the read lock and
acquire it again which will always succeed as long as there is another
reader.
Unlike the !RT implementation of rwsem which would not allow that.

Sebastian
