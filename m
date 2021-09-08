Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7560F4037B5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhIHKUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348448AbhIHKUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:20:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665E9C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=oigBXejodDYXfuq+OJaPDNUsklSgzzpBU1ZQ3OJWt+w=; b=BliuBrcM6k2J/ZBEajRmfZuVX9
        8TCSWK9CvpfH2H3Dnw/uMKKD8KDLnWE13pvmJJv2uFlrtyY4Y9U4tuwKSPQLTyiOeha0azhJf79K0
        +rM5Xk2KfJX+5qVOkXGTnVnRmvdWYH2jNmp0PkwQEgN1x3HDQiVf5bGRPwFdqewbiCDiCOCQZ694f
        Zn3pH2tQS5BoZ/DnEWPj4IG5nT5R1zFrsx1YPQUeBcff9wC0ny81lgp2OcRzCURlSShSqrPrzE2kB
        12B5J4IQ5wvCbGGFMDAOaeDvUxR9dFtveZXFXAp+uF279NyHOMwOacaifqt0BrL1f3aFeCiOFCaAl
        4NeCsNwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNueS-008iah-N9; Wed, 08 Sep 2021 10:18:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33588300362;
        Wed,  8 Sep 2021 12:17:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2131D20800166; Wed,  8 Sep 2021 12:17:56 +0200 (CEST)
Date:   Wed, 8 Sep 2021 12:17:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] lockdep: Let lock_is_held_type() detect recursive
 read as read
Message-ID: <YTiN1HLeHeIhi/nT@hirez.programming.kicks-ass.net>
References: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
 <9af2b074-9fcf-5aea-f37d-9b2482146489@redhat.com>
 <20210903084001.lblecrvz4esl4mrr@linutronix.de>
 <YTgc8xXuVlpOhoUT@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YTgc8xXuVlpOhoUT@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 10:16:19AM +0800, Boqun Feng wrote:
> On Fri, Sep 03, 2021 at 10:40:01AM +0200, Sebastian Andrzej Siewior wrote:
> > lock_is_held_type(, 1) detects acquired read locks. It only recognized
> > locks acquired with lock_acquire_shared(). Read locks acquired with
> > lock_acquire_shared_recursive() are not recognized because a `2' is
> > stored as the read value.
> > 
> > Rework the check to additionally recognise lock's read value one and two
> > as a read held lock.
> > 
> > Fixes: e918188611f07 ("locking: More accurate annotations for read_lock()")
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > v1…v2:
> >   - simplify the read check to !!read as suggested by Waiman Long.
> > 
> >  kernel/locking/lockdep.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -5366,7 +5366,7 @@ int __lock_is_held(const struct lockdep_
> >  		struct held_lock *hlock = curr->held_locks + i;
> >  
> >  		if (match_held_lock(hlock, lock)) {
> > -			if (read == -1 || hlock->read == read)
> > +			if (read == -1 || hlock->read == !!read)
> 
> I think this should be:
> 
> 	!!hlock->read == read
> 
> With that,
> 
> Acked-by: Boqun Feng <boqun.feng@gmail.com>

Thanks!
