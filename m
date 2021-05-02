Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3726370E29
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 19:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhEBRTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 13:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEBRTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 13:19:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B62F6120E;
        Sun,  2 May 2021 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619975907;
        bh=2YpVyX32Fc3yV4W8zRMMq7kdSQrfkuyNbn0zF+bZkHo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=IJ48vvy+LZCwopLTbYmPCGypKRshZE3uANCqqiRDF30Elnrmmu7fARcgRqutJhH0A
         3RTRFEYYRWhdBsjVXfHwcdtpfENh2shKiXmV2o4pbFqwnr4dP+myVKXIluuSjij4GQ
         ym5JdvWvNWkLtPDcYuOZ363QnIeJ7B97svOY+LJOmpz2Nus411LgtAC7o8kYsoYpv7
         YxXUrUIzvRwzF7V92O/PCEOZEMdB4dBVobL4v8TkFmNoA5akJ5SW2Pc1xVGxsAGjvP
         0UHIQfi/snNsA4WXBbCk4TSTHyQvfxUVKJlByAevJ0AsN7SoQNkH+XPHPMVPr2fpkO
         uo2wPUuJoIPsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0CAD55C015B; Sun,  2 May 2021 10:18:27 -0700 (PDT)
Date:   Sun, 2 May 2021 10:18:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org
Subject: Deadlock between CPU offline and kmem_cache_create
Message-ID: <20210502171827.GA3670492@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Commit 1f0723a4c0df ("mm, slub: enable slub_debug static key when creating
cache with explicit debug flags") results in the lockdep complaint (see
below) in the presence of CPU-hotplug offline operations.  I triggered
and bisected this using the following command:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10 --configs TREE05 --trust-make

This triggers when rcutorture's kmem_cache_create() for its testing of
mem_dump_obj().  When I reverted commit 1f0723a4c0df, the splat went away.

I tried moving rcutorture's mem_dump_obj() testing to rcutorture's
module-init function, but that did not help.  In retrospect, this is no
surprise because the deadlock is caused by the call to kmem_cache_create()
and the slab CPU-hotplug notifiers.  There is no lock in this deadlock
cycle that is under rcutorture's control.

I could imagine moving the static_branch_enable() out into a clean
environment, but this would of course require some mechanism to make
sure that the slab was still in existence at that time.  One way to do
this would be to have a timer that is set at the site of the current
static_branch_enable() and deleted at slab-deletion time.  Plus there
would be a short period of time when debugging would not yet be enabled
for this slab (would that be a problem?).

This time could be minimized using (say) an hrtimer timeout of 1
microsecond or some such.  It could be eliminated by having the timer
handler do a wakeup that kmem_cache_create() waits for at some point
after it releases slab_mutex.

Alternatively, maybe some way can be found to avoid acquiring slab_mutex
in slab's CPU-hotplug notifiers.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

[  602.429399] ======================================================
[  602.429777] WARNING: possible circular locking dependency detected
[  602.430156] 5.12.0+ #15 Not tainted
[  602.430374] ------------------------------------------------------
[  602.430759] rcu_torture_sta/109 is trying to acquire lock:
[  602.431099] ffffffff96063cd0 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0x9/0x20
[  602.431630] 
[  602.431630] but task is already holding lock:
[  602.431992] ffffffff96173c28 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_create_usercopy+0x2d/0x250
[  602.432541] 
[  602.432541] which lock already depends on the new lock.
[  602.432541] 
[  602.433039] 
[  602.433039] the existing dependency chain (in reverse order) is:
[  602.433494] 
[  602.433494] -> #1 (slab_mutex){+.+.}-{3:3}:
[  602.433842]        lock_acquire+0xb9/0x3a0
[  602.434107]        __mutex_lock+0x8d/0x920
[  602.434366]        slub_cpu_dead+0x15/0xf0
[  602.434625]        cpuhp_invoke_callback+0x17a/0x7c0
[  602.434938]        cpuhp_invoke_callback_range+0x3b/0x80
[  602.435266]        _cpu_down+0xdf/0x2a0
[  602.435504]        cpu_down+0x2c/0x50
[  602.435734]        device_offline+0x82/0xb0
[  602.436005]        remove_cpu+0x1a/0x30
[  602.436243]        torture_offline+0x80/0x140
[  602.436514]        torture_onoff+0x147/0x260
[  602.436778]        kthread+0x10a/0x140
[  602.437013]        ret_from_fork+0x22/0x30
[  602.437274] 
[  602.437274] -> #0 (cpu_hotplug_lock){++++}-{0:0}:
[  602.437654]        check_prev_add+0x8f/0xbf0
[  602.437919]        __lock_acquire+0x13f0/0x1d80
[  602.438198]        lock_acquire+0xb9/0x3a0
[  602.438452]        cpus_read_lock+0x21/0xa0
[  602.438713]        static_key_enable+0x9/0x20
[  602.438985]        __kmem_cache_create+0x38d/0x430
[  602.439284]        kmem_cache_create_usercopy+0x146/0x250
[  602.439619]        kmem_cache_create+0xd/0x10
[  602.439895]        rcu_torture_stats+0x79/0x280
[  602.440179]        kthread+0x10a/0x140
[  602.440413]        ret_from_fork+0x22/0x30
[  602.440669] 
[  602.440669] other info that might help us debug this:
[  602.440669] 
[  602.441154]  Possible unsafe locking scenario:
[  602.441154] 
[  602.441523]        CPU0                    CPU1
[  602.441803]        ----                    ----
[  602.442085]   lock(slab_mutex);
[  602.442281]                                lock(cpu_hotplug_lock);
[  602.442662]                                lock(slab_mutex);
[  602.443009]   lock(cpu_hotplug_lock);
[  602.443239] 
[  602.443239]  *** DEADLOCK ***
[  602.443239] 
[  602.443606] 1 lock held by rcu_torture_sta/109:
[  602.443892]  #0: ffffffff96173c28 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_create_usercopy+0x2d/0x250
[  602.444472] 
[  602.444472] stack backtrace:
[  602.444743] CPU: 3 PID: 109 Comm: rcu_torture_sta Not tainted 5.12.0+ #15
[  602.445176] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  602.445728] Call Trace:
[  602.445891]  dump_stack+0x6d/0x89
[  602.446116]  check_noncircular+0xfe/0x110
[  602.446401]  ? lock_is_held_type+0x98/0x110
[  602.446664]  check_prev_add+0x8f/0xbf0
[  602.446908]  __lock_acquire+0x13f0/0x1d80
[  602.447162]  lock_acquire+0xb9/0x3a0
[  602.447385]  ? static_key_enable+0x9/0x20
[  602.447640]  ? mark_held_locks+0x49/0x70
[  602.447894]  cpus_read_lock+0x21/0xa0
[  602.448124]  ? static_key_enable+0x9/0x20
[  602.448373]  static_key_enable+0x9/0x20
[  602.448614]  __kmem_cache_create+0x38d/0x430
[  602.448882]  kmem_cache_create_usercopy+0x146/0x250
[  602.449184]  ? rcu_torture_stats_print+0xd0/0xd0
[  602.449469]  kmem_cache_create+0xd/0x10
[  602.449708]  rcu_torture_stats+0x79/0x280
[  602.449964]  ? rcu_torture_stats_print+0xd0/0xd0
[  602.450251]  kthread+0x10a/0x140
[  602.450452]  ? kthread_park+0x80/0x80
[  602.450682]  ret_from_fork+0x22/0x30
