Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC840583C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357612AbhIINsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358095AbhIINqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:46:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18BAB6120E;
        Thu,  9 Sep 2021 13:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631195130;
        bh=Pzye3sEvQsiMMe8AQ4zppyqO9pYnFlQgLwp86cyCJJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kKOuhJJUCW0KfdmlP3stdZxZge+g95zJfm++qFLvKTwZINw3q5hi3jn1rkKPbveeI
         iAsQEXgYfUrxCFJlVi+3He1LditPPNT2HoZWH8KGpFSujPPv0DbJPb9z6wY9drtw+w
         S8qz8vLnuxI99Siy1ltpfDV1J8W81duYq92ljIxgarfGu02aQh1GRH6mVgeK9qsx3X
         yPphuSlcNdPffYKPB8Jov9XJR7wsUa0GpFwHeh5rMjlGPkmZpcHGDjmugcp7JwbpDm
         8QAIKSzIToW0FWf8EPQZr2nxm6DWTSsg6Y/+E5i3xjrGDyWFBU2/0ne50bmcl98VGu
         oknCAtKD6Mk0w==
Date:   Thu, 9 Sep 2021 14:45:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20210909134524.GB9722@willie-the-truck>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.767330253@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909110203.767330253@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 12:59:16PM +0200, Peter Zijlstra wrote:
> While looking at current_save_and_set_rtlock_wait_state() I'm thinking
> it really ought to use smp_store_mb(), because something like:
> 
> 	current_save_and_set_rtlock_wait_state();
> 	for (;;) {
> 		if (try_lock())
> 			break;
> 
> 		raw_spin_unlock_irq(&lock->wait_lock);
> 		schedule();
> 		raw_spin_lock_irq(&lock->wait_lock);
> 
> 		set_current_state(TASK_RTLOCK_WAIT);
> 	}
> 	current_restore_rtlock_saved_state();
> 
> which is the advertised usage in the comment, is actually broken,
> since trylock() will only need a load-acquire in general and that
> could be re-ordered against the state store, which could lead to a
> missed wakeup -> BAD (tm).

Why doesn't the UNLOCK of pi_lock in current_save_and_set_rtlock_wait_state()
order the state change before the successful try_lock? I'm just struggling
to envisage how this actually goes wrong.

Will
