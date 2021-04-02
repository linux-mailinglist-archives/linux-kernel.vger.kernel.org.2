Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E723524E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhDBA6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234711AbhDBA6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:58:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DB23610E9;
        Fri,  2 Apr 2021 00:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617325102;
        bh=0g1jWgcy9BSEY+FAX3puTKZwqMV3W4v9JWw5matinPg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NeXehmm2ucEztLiEDRC2eqNGy0gwWdbYXA9RtEdNQUnQKaRZb0Hb50MpBrhQ+oJtW
         U67DRpNtbNQouUbw2Z4DOhzLA2LNbhhi1F99YZuIqA21WWAZc0B3l0YBrd7OgVWNl4
         o3oNWHh9TzcMNXyYYsoN6id2Gb/LSkarm9Zjb7nxlOytSW7cmf1VcLC104UJlaD3YV
         zssgshVevZMxBIk0I+pVAreA6K9f7KvJVpIG6ekqgbs39qzq1I+UPY+pAA68jdLgje
         QKYFbu+plzG4ThrE3S6u/6iGdLd8UzMGFKl1ciugnZ1I6PelRXhOLBCZhoG1+QHyZ2
         gq2KuHUvr66dA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C99F13523A03; Thu,  1 Apr 2021 17:58:21 -0700 (PDT)
Date:   Thu, 1 Apr 2021 17:58:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/3] srcu: Remove superfluous sdp->srcu_lock_count zero
 filling
Message-ID: <20210402005821.GN2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210401234704.125498-1-frederic@kernel.org>
 <20210401234704.125498-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401234704.125498-3-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 01:47:03AM +0200, Frederic Weisbecker wrote:
> alloc_percpu() zeroes out the allocated memory. Therefore we can assume
> the whole struct srcu_data to be clear after calling it, just like after
> a static initialization. No need for a special treatment in the dynamic
> allocation case.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>

Good catch, thank you!!!  I queued the following with the usual
wordsmithing, so as usual please let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 2cfdfbfc41bcd96e7961a619e4a7f235b274f78f
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Fri Apr 2 01:47:03 2021 +0200

    srcu: Remove superfluous sdp->srcu_lock_count zero filling
    
    Because alloc_percpu() zeroes out the allocated memory, there is no need
    to zero-fill newly allocated per-CPU memory.  This commit therefore removes
    the loop zeroing the ->srcu_lock_count and ->srcu_unlock_count arrays
    from init_srcu_struct_nodes().  This is the only use of that function's
    is_static parameter, which this commit also removes.
    
    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
    Cc: Boqun Feng <boqun.feng@gmail.com>
    Cc: Lai Jiangshan <jiangshanlai@gmail.com>
    Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
    Cc: Josh Triplett <josh@joshtriplett.org>
    Cc: Joel Fernandes <joel@joelfernandes.org>
    Cc: Uladzislau Rezki <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 036ff54..7389e46 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -80,7 +80,7 @@ do {									\
  * srcu_read_unlock() running against them.  So if the is_static parameter
  * is set, don't initialize ->srcu_lock_count[] and ->srcu_unlock_count[].
  */
-static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
+static void init_srcu_struct_nodes(struct srcu_struct *ssp)
 {
 	int cpu;
 	int i;
@@ -148,14 +148,6 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
 		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
 		sdp->ssp = ssp;
 		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
-		if (is_static)
-			continue;
-
-		/* Dynamically allocated, better be no srcu_read_locks()! */
-		for (i = 0; i < ARRAY_SIZE(sdp->srcu_lock_count); i++) {
-			sdp->srcu_lock_count[i] = 0;
-			sdp->srcu_unlock_count[i] = 0;
-		}
 	}
 }
 
@@ -179,7 +171,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
 	if (!ssp->sda)
 		return -ENOMEM;
-	init_srcu_struct_nodes(ssp, is_static);
+	init_srcu_struct_nodes(ssp);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
