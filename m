Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E13C9BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbhGOJd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbhGOJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:33:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00F1C061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 02:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DRcIyxFcl6MKVSp1vGQOZm+0rU30xHMbGqCZfHDqkWU=; b=Iajpz4wDEfai2rqc90gZaq46e+
        lebuvdF40UhnLcY4Z8Px6oGJ8Sj1DqR+hPLo1fUys6P0DzQo4qGPB7+y+Chw21mWGsoceCgft3cn4
        SzZoZznCWSdwyU2j/qIeb8/MYwGd3txTeWmOmQegh2VfWHIbsRUYkVFFwen92Is8BLAJvxl7xJcJU
        2Pe119Gk/9+N3cHkYKdyCB/tT8H0UAFBYsEykcRSAJ/s4lkiPmTVKTBgrh6h41DiGdG1bEIveHQ9t
        JKw1kVQPd8NHVrb4TqZrVr/GgMlZ0Y2CUHClBiRxAGaKjts2G5iV7ifnMbrPQ52kjMWrLwbSadRhw
        /Q7V5xIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3xe4-003Bxp-BC; Thu, 15 Jul 2021 09:27:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B8309867B3; Thu, 15 Jul 2021 11:27:03 +0200 (CEST)
Date:   Thu, 15 Jul 2021 11:27:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 03/50] sched: Prepare for RT sleeping spin/rwlocks
Message-ID: <20210715092703.GI2725@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160746.207208684@linutronix.de>
 <87r1g0mqir.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1g0mqir.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 12:20:28AM +0100, Valentin Schneider wrote:
> Hi,
> 
> On 13/07/21 17:10, Thomas Gleixner wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> >
> > Waiting for spinlocks and rwlocks on non RT enabled kernels is task::state
> > preserving. Any wakeup which matches the state is valid.
> >
> > RT enabled kernels substitutes them with 'sleeping' spinlocks. This creates
> > an issue vs. task::state.
> >
> > In order to block on the lock the task has to overwrite task::state and a
> > consecutive wakeup issued by the unlocker sets the state back to
> > TASK_RUNNING. As a consequence the task loses the state which was set
> > before the lock acquire and also any regular wakeup targeted at the task
> > while it is blocked on the lock.
> >
> 
> I'm not sure I get this for spinlocks - p->__state != TASK_RUNNING means
> task is stopped (or about to be), IMO that doesn't go with spinning. I was
> thinking perhaps ptrace could be an issue, but I don't have a clear picture
> on that either. What am I missing?

spinlocks will become rtmutex. They're going to clobber __state by
virtue of a nested block.
