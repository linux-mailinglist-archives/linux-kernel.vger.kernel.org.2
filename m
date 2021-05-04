Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B1C3729CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 14:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhEDMCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 08:02:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:45168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhEDMCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 08:02:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D21CB29A;
        Tue,  4 May 2021 12:01:46 +0000 (UTC)
Subject: Re: [PATCH 5.13] mm, slub: move slub_debug static key enabling
 outside slab_mutex
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20210504120019.26791-1-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e168acc1-7c01-71c6-1ff9-95cbb9211342@suse.cz>
Date:   Tue, 4 May 2021 14:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210504120019.26791-1-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/21 2:00 PM, Vlastimil Babka wrote:
> Paul E. McKenney reported [1] that commit 1f0723a4c0df ("mm, slub: enable
> slub_debug static key when creating cache with explicit debug flags") results
> in the lockdep complaint:
> 
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  5.12.0+ #15 Not tainted
>  ------------------------------------------------------
>  rcu_torture_sta/109 is trying to acquire lock:
>  ffffffff96063cd0 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0x9/0x20
> 
>  but task is already holding lock:
>  ffffffff96173c28 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_create_usercopy+0x2d/0x250
> 
>  which lock already depends on the new lock.
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #1 (slab_mutex){+.+.}-{3:3}:
>         lock_acquire+0xb9/0x3a0
>         __mutex_lock+0x8d/0x920
>         slub_cpu_dead+0x15/0xf0
>         cpuhp_invoke_callback+0x17a/0x7c0
>         cpuhp_invoke_callback_range+0x3b/0x80
>         _cpu_down+0xdf/0x2a0
>         cpu_down+0x2c/0x50
>         device_offline+0x82/0xb0
>         remove_cpu+0x1a/0x30
>         torture_offline+0x80/0x140
>         torture_onoff+0x147/0x260
>         kthread+0x10a/0x140
>         ret_from_fork+0x22/0x30
> 
>  -> #0 (cpu_hotplug_lock){++++}-{0:0}:
>         check_prev_add+0x8f/0xbf0
>         __lock_acquire+0x13f0/0x1d80
>         lock_acquire+0xb9/0x3a0
>         cpus_read_lock+0x21/0xa0
>         static_key_enable+0x9/0x20
>         __kmem_cache_create+0x38d/0x430
>         kmem_cache_create_usercopy+0x146/0x250
>         kmem_cache_create+0xd/0x10
>         rcu_torture_stats+0x79/0x280
>         kthread+0x10a/0x140
>         ret_from_fork+0x22/0x30
> 
>  other info that might help us debug this:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(slab_mutex);
>                                 lock(cpu_hotplug_lock);
>                                 lock(slab_mutex);
>    lock(cpu_hotplug_lock);
> 
>   *** DEADLOCK ***
> 
>  1 lock held by rcu_torture_sta/109:
>   #0: ffffffff96173c28 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_create_usercopy+0x2d/0x250
> 
>  stack backtrace:
>  CPU: 3 PID: 109 Comm: rcu_torture_sta Not tainted 5.12.0+ #15
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>  Call Trace:
>   dump_stack+0x6d/0x89
>   check_noncircular+0xfe/0x110
>   ? lock_is_held_type+0x98/0x110
>   check_prev_add+0x8f/0xbf0
>   __lock_acquire+0x13f0/0x1d80
>   lock_acquire+0xb9/0x3a0
>   ? static_key_enable+0x9/0x20
>   ? mark_held_locks+0x49/0x70
>   cpus_read_lock+0x21/0xa0
>   ? static_key_enable+0x9/0x20
>   static_key_enable+0x9/0x20
>   __kmem_cache_create+0x38d/0x430
>   kmem_cache_create_usercopy+0x146/0x250
>   ? rcu_torture_stats_print+0xd0/0xd0
>   kmem_cache_create+0xd/0x10
>   rcu_torture_stats+0x79/0x280
>   ? rcu_torture_stats_print+0xd0/0xd0
>   kthread+0x10a/0x140
>   ? kthread_park+0x80/0x80
>   ret_from_fork+0x22/0x30
> 
> This is because there's one order of locking from the hotplug callbacks:
> 
> lock(cpu_hotplug_lock); // from hotplug machinery itself
> lock(slab_mutex); // in e.g. slab_mem_going_offline_callback()
> 
> And commit 1f0723a4c0df made the reverse sequence possible:
> lock(slab_mutex); // in kmem_cache_create_usercopy()
> lock(cpu_hotplug_lock); // kmem_cache_open() -> static_key_enable()
> 
> The simplest fix is to move static_key_enable() to a place before slab_mutex is
> taken. That means kmem_cache_create_usercopy() in mm/slab_common.c which is not
> ideal for SLUB-specific code, but the #ifdef CONFIG_SLUB_DEBUG makes it
> at least self-contained and obvious.
> 
> [1] https://lore.kernel.org/lkml/20210502171827.GA3670492@paulmck-ThinkPad-P17-Gen-1/
> 
> Reported-and-tested-by: Paul E. McKenney <paulmck@kernel.org>

Forgot:
Fixes: 1f0723a4c0df ("mm, slub: enable slub_debug static key when creating cache
with explicit debug flags")

