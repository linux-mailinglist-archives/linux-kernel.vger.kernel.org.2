Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58493B8576
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbhF3OyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbhF3OyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:54:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B427C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JgdlP3cFU+vqIL3Uh6fKL6vJvakGNcLFSQqStMEuC/4=; b=qqmHBWd7keTTspxBpDdFabaB7i
        kSnOxGTQp1v2ABJPDbQOjNcBMe74rTXoiAGRgSo4k3Iv9BeoEQCarBLfdKx2ko185yPiZInTOZkRH
        P1tkEoqg59o+YI3ZowyE8jUufVHk3Ps8jkLyQlydW/7HXtXFQuKiagVugpsbIcHA8iiohnxHcasNA
        fpXSfp9+/myT8a3T2qQbhjBjDB1fBEzt87Bzof+8cmO/ldvdlw8AN0WQnq0KCWaUqBITuw75lhkrm
        efuPQD0HDMONPj6nwuGorDPhRoJb8QFoU/QSQ1CErHlZoM90fxghGng0tLvsqsWbvg9LUrlD/Hr4Q
        FfsUEfGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lybXc-005SgJ-MW; Wed, 30 Jun 2021 14:50:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47E353002D3;
        Wed, 30 Jun 2021 16:50:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AF242C635D2C; Wed, 30 Jun 2021 16:50:15 +0200 (CEST)
Date:   Wed, 30 Jun 2021 16:50:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/mutex: Reduce chance of setting HANDOFF bit on
 unlocked mutex
Message-ID: <YNyEpy+IUtJbWOZS@hirez.programming.kicks-ass.net>
References: <20210629201138.31507-1-longman@redhat.com>
 <YNxFkD8qzex9MvQp@hirez.programming.kicks-ass.net>
 <dbd002b9-d266-0f69-1c55-eb4e5d4d6a57@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd002b9-d266-0f69-1c55-eb4e5d4d6a57@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 10:43:37PM +0800, Xu, Yanfei wrote:
> > +static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock, bool handoff)
> >   {
> >          unsigned long owner, curr = (unsigned long)current;
> > 
> >          owner = atomic_long_read(&lock->owner);
> >          for (;;) { /* must loop, can race against a flag */
> > +               unsigned long flags = __owner_flags(owner);
> >                  unsigned long task = owner & ~MUTEX_FLAGS;
> > 
> >                  if (task) {
> > +                       if (flags & MUTEX_FLAG_PICKUP) {
> > 
> > +                               if (task != curr)
> > +                                       break;
> > +
> > +                               flags &= ~MUTEX_FLAG_PICKUP;
> > +
> 
> Hmm.. Should we also clear HANDOFF bit here? I don't find where it is
> cleared.

Should already be gone; see __mutex_handoff().
