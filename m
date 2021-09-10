Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5CC406CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhIJNUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhIJNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 09:20:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD53C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 06:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ninElOyv81dMVidL5ufjaZyKTFmzPaIwU+OoWpq1OOg=; b=FO+tHfueTJF3RSFawxG4/G5rGB
        Wq8V1O12TjM6OEKiEwWqxOlR73xTN8p986jwFfYGSmODuFFNg5lk8CFxD8oq7LMN9Z2Y94m/Gn7Ns
        rnlGrqUDGzELw+AOpSz+rZCWDOyC3Pr30RP5FToYPEGx7yTZwibSf12PNbAV7cOfWAL+sZgJVfx2I
        G5vKJxeVsyN2YZlX/dC+kxXGJ89TqQFH6y+qfMqJ/fJHN3ChTcOfmp0u8kng558gZl6ufoKAP3OV7
        T56vK/vfnyKtezZ6uoHFtYYP9pa9WEcGCW2GmqlrrIDNRFET0cxy5j8Q9SN90ZgPafB4L0qZCeH5v
        obEhWm0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOgOw-00B2DC-Fa; Fri, 10 Sep 2021 13:17:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5AAB300047;
        Fri, 10 Sep 2021 15:17:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A75042C1B51C5; Fri, 10 Sep 2021 15:17:04 +0200 (CEST)
Date:   Fri, 10 Sep 2021 15:17:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/4] sched/wakeup: Strengthen
 current_save_and_set_rtlock_wait_state()
Message-ID: <YTta0Kkz4OeFzUvJ@hirez.programming.kicks-ass.net>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.767330253@infradead.org>
 <20210909134524.GB9722@willie-the-truck>
 <YToZ4h/nfsrD3JfY@hirez.programming.kicks-ass.net>
 <20210910125658.GA1454@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910125658.GA1454@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 01:57:26PM +0100, Will Deacon wrote:
> On Thu, Sep 09, 2021 at 04:27:46PM +0200, Peter Zijlstra wrote:
> > Moo yes, so the earlier changelog I wrote was something like:
> > 
> > 	current_save_and_set_rtlock_wait_state();
> > 	for (;;) {
> > 		if (try_lock())
> > 			break;
> > 
> > 		raw_spin_unlock_irq(&lock->wait_lock);
> > 		if (!cond)
> > 			schedule();
> > 		raw_spin_lock_irq(&lock->wait_lock);
> > 
> > 		set_current_state(TASK_RTLOCK_WAIT);
> > 	}
> > 	current_restore_rtlock_saved_state();
> > 
> > which is more what the code looks like before these patches, and in that
> > case the @cond load can be lifted before __state.
> 
> Ah, so that makes more sense, thanks. I can't see how the try_lock() could
> be reordered though, as it's going to have to do an atomic rmw.

OK, lemme go update the Changelog and make it __flags for bigeasy :-)
