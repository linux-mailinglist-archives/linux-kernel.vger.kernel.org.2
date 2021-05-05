Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327D73733C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 04:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhEECxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 22:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhEECxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 22:53:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC32CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 19:52:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id lp4so52468pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 19:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=O8nA00ni6lNsqnWOdLM7s679eOLE4MZHEuCAj6DehK4=;
        b=FzKTQSADNf9GMiSJqYlX8A+RMeHzC6trj8E7AwMr/snkhpP3QQ/LKjWO45WWdBchMT
         qyryQtqD2xVmzvsqCYXL7l25X4gxSJX3Mt4fbLQILIc8B/+NrMAyWny894RHIeg260Mh
         XJ+Iec+T0OZE5Duy5+QkmELbZOaR4Blni3FXD1scgwx4tYo1Z2ApyWo4AjcmT3zuuyJU
         uFR0oe2t45Hy6PYWdVPKzuo7sRadTihVrIoy6LDup8xpfYo1jMEgO/zbygbtqLJixzPn
         VnmUpvIOmQGkff0RNohhDw+jCCieZLnjaVYVNvF+ey+n9c0IOFttYkE4uJ4QZob53xGr
         VUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=O8nA00ni6lNsqnWOdLM7s679eOLE4MZHEuCAj6DehK4=;
        b=BuQrmoB1m4I++cx/4LCXdnMeW+pYgBZJ2/m8J2xhwPcAz9w+fng6qRt5/5BatBsnU2
         vt5jPUFci9NwH8/Y7v6DvhHkcIfaAoV797N4rS75sMhZgMjsJZ8EqvTZFrJa7QJuCnih
         z2AdoDvywAxhq+2LHyqcYmVISBqXxdsUSlhfEY3//XVZh0a4K222UDNPW9aaK32aaFcx
         W0GqaftirIXl3usMixYMdWF5ncK56cZQ/DxKpi/DJo8PZw0KxRu9eQXfRgdvmlXiK4VN
         XJ5d+EkbIDvo6iYmZNWX/D+xgV6NuIchcRUZLX3x1nhbnV0jN+YOURkBIy0fVrFV4iGY
         bkcw==
X-Gm-Message-State: AOAM532HAJnR3Z2ZIwYvETIF8xxGugoKRSBLBkbxyYn4cBFOTAkCqAHy
        oM4f772LPgy4HCaiOXLLT3DLTQ==
X-Google-Smtp-Source: ABdhPJyFzQPd7cLGQb8g3S+kCp0WN/xHrL04C7BfQ37PQGuMssiZz/SNic4AcBFq0t32jF/h72S7fg==
X-Received: by 2002:a17:90a:f2d3:: with SMTP id gt19mr8983022pjb.52.1620183132131;
        Tue, 04 May 2021 19:52:12 -0700 (PDT)
Received: from [2620:15c:17:3:34c9:704d:575a:e347] ([2620:15c:17:3:34c9:704d:575a:e347])
        by smtp.gmail.com with ESMTPSA id d63sm6130047pjk.10.2021.05.04.19.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 19:52:11 -0700 (PDT)
Date:   Tue, 4 May 2021 19:52:10 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 5.13] mm, slub: move slub_debug static key enabling
 outside slab_mutex
In-Reply-To: <e168acc1-7c01-71c6-1ff9-95cbb9211342@suse.cz>
Message-ID: <96862325-1ef1-b255-37f4-e22777a4eb78@google.com>
References: <20210504120019.26791-1-vbabka@suse.cz> <e168acc1-7c01-71c6-1ff9-95cbb9211342@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2021, Vlastimil Babka wrote:

> On 5/4/21 2:00 PM, Vlastimil Babka wrote:
> > Paul E. McKenney reported [1] that commit 1f0723a4c0df ("mm, slub: enable
> > slub_debug static key when creating cache with explicit debug flags") results
> > in the lockdep complaint:
> > 
> >  ======================================================
> >  WARNING: possible circular locking dependency detected
> >  5.12.0+ #15 Not tainted
> >  ------------------------------------------------------
> >  rcu_torture_sta/109 is trying to acquire lock:
> >  ffffffff96063cd0 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0x9/0x20
> > 
> >  but task is already holding lock:
> >  ffffffff96173c28 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_create_usercopy+0x2d/0x250
> > 
> >  which lock already depends on the new lock.
> > 
> >  the existing dependency chain (in reverse order) is:
> > 
> >  -> #1 (slab_mutex){+.+.}-{3:3}:
> >         lock_acquire+0xb9/0x3a0
> >         __mutex_lock+0x8d/0x920
> >         slub_cpu_dead+0x15/0xf0
> >         cpuhp_invoke_callback+0x17a/0x7c0
> >         cpuhp_invoke_callback_range+0x3b/0x80
> >         _cpu_down+0xdf/0x2a0
> >         cpu_down+0x2c/0x50
> >         device_offline+0x82/0xb0
> >         remove_cpu+0x1a/0x30
> >         torture_offline+0x80/0x140
> >         torture_onoff+0x147/0x260
> >         kthread+0x10a/0x140
> >         ret_from_fork+0x22/0x30
> > 
> >  -> #0 (cpu_hotplug_lock){++++}-{0:0}:
> >         check_prev_add+0x8f/0xbf0
> >         __lock_acquire+0x13f0/0x1d80
> >         lock_acquire+0xb9/0x3a0
> >         cpus_read_lock+0x21/0xa0
> >         static_key_enable+0x9/0x20
> >         __kmem_cache_create+0x38d/0x430
> >         kmem_cache_create_usercopy+0x146/0x250
> >         kmem_cache_create+0xd/0x10
> >         rcu_torture_stats+0x79/0x280
> >         kthread+0x10a/0x140
> >         ret_from_fork+0x22/0x30
> > 
> >  other info that might help us debug this:
> > 
> >   Possible unsafe locking scenario:
> > 
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(slab_mutex);
> >                                 lock(cpu_hotplug_lock);
> >                                 lock(slab_mutex);
> >    lock(cpu_hotplug_lock);
> > 
> >   *** DEADLOCK ***
> > 
> >  1 lock held by rcu_torture_sta/109:
> >   #0: ffffffff96173c28 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_create_usercopy+0x2d/0x250
> > 
> >  stack backtrace:
> >  CPU: 3 PID: 109 Comm: rcu_torture_sta Not tainted 5.12.0+ #15
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> >  Call Trace:
> >   dump_stack+0x6d/0x89
> >   check_noncircular+0xfe/0x110
> >   ? lock_is_held_type+0x98/0x110
> >   check_prev_add+0x8f/0xbf0
> >   __lock_acquire+0x13f0/0x1d80
> >   lock_acquire+0xb9/0x3a0
> >   ? static_key_enable+0x9/0x20
> >   ? mark_held_locks+0x49/0x70
> >   cpus_read_lock+0x21/0xa0
> >   ? static_key_enable+0x9/0x20
> >   static_key_enable+0x9/0x20
> >   __kmem_cache_create+0x38d/0x430
> >   kmem_cache_create_usercopy+0x146/0x250
> >   ? rcu_torture_stats_print+0xd0/0xd0
> >   kmem_cache_create+0xd/0x10
> >   rcu_torture_stats+0x79/0x280
> >   ? rcu_torture_stats_print+0xd0/0xd0
> >   kthread+0x10a/0x140
> >   ? kthread_park+0x80/0x80
> >   ret_from_fork+0x22/0x30
> > 
> > This is because there's one order of locking from the hotplug callbacks:
> > 
> > lock(cpu_hotplug_lock); // from hotplug machinery itself
> > lock(slab_mutex); // in e.g. slab_mem_going_offline_callback()
> > 
> > And commit 1f0723a4c0df made the reverse sequence possible:
> > lock(slab_mutex); // in kmem_cache_create_usercopy()
> > lock(cpu_hotplug_lock); // kmem_cache_open() -> static_key_enable()
> > 
> > The simplest fix is to move static_key_enable() to a place before slab_mutex is
> > taken. That means kmem_cache_create_usercopy() in mm/slab_common.c which is not
> > ideal for SLUB-specific code, but the #ifdef CONFIG_SLUB_DEBUG makes it
> > at least self-contained and obvious.
> > 
> > [1] https://lore.kernel.org/lkml/20210502171827.GA3670492@paulmck-ThinkPad-P17-Gen-1/
> > 
> > Reported-and-tested-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Forgot:
> Fixes: 1f0723a4c0df ("mm, slub: enable slub_debug static key when creating cache
> with explicit debug flags")
> 

Acked-by: David Rientjes <rientjes@google.com>

Nice concise fix!
