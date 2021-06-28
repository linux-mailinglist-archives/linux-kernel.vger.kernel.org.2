Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856EC3B5E54
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhF1Msg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:48:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33590 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhF1Mse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:48:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3CE7D22394;
        Mon, 28 Jun 2021 12:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624884368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gp9Hq8iWIIvvu3xnrWcrA3AsEWWrAsk0/1I6sTXSv8M=;
        b=O8Do7vItHay3SzZ14/BAP3s5E5fqYA+8/qN90h6RhgOO7kbUCMLmL9nAobxqquS9wMJaOk
        LxOlLPcLJ6B+MKCM8bC/rSmBSsd5fukZLngdSQy6OCRNQp5aoK8Cu1gfRzBfoD5+fJl+Y4
        khqBpEBszENWbR7+IgCmbiCRw+SduUY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 094F8A3B8C;
        Mon, 28 Jun 2021 12:46:07 +0000 (UTC)
Date:   Mon, 28 Jun 2021 14:46:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmalloc: add cond_resched() in __vunmap()
Message-ID: <YNnEjp72rzT7zQ10@dhcp22.suse.cz>
References: <20210622225030.478384-1-aquini@redhat.com>
 <YNR4ZkwF+Bh11XMC@dhcp22.suse.cz>
 <20210624142339.GA2267@pc638.lan>
 <YNWY/IY+ftszkjM5@dhcp22.suse.cz>
 <20210625160011.GA50201@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625160011.GA50201@pc638.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-06-21 18:00:11, Uladzislau Rezki wrote:
> On Fri, Jun 25, 2021 at 10:51:08AM +0200, Michal Hocko wrote:
> > On Thu 24-06-21 16:23:39, Uladzislau Rezki wrote:
> > > On Thu, Jun 24, 2021 at 02:21:21PM +0200, Michal Hocko wrote:
> > > > On Tue 22-06-21 18:50:30, Rafael Aquini wrote:
> > > > > On non-preemptible kernel builds the watchdog can complain
> > > > > about soft lockups when vfree() is called against large
> > > > > vmalloc areas:
> > > > > 
> > > > > [  210.851798] kvmalloc-test: vmalloc(2199023255552) succeeded
> > > > > [  238.654842] watchdog: BUG: soft lockup - CPU#181 stuck for 26s! [rmmod:5203]
> > > > > [  238.662716] Modules linked in: kvmalloc_test(OE-) ...
> > > > > [  238.772671] CPU: 181 PID: 5203 Comm: rmmod Tainted: G S         OE     5.13.0-rc7+ #1
> > > > > [  238.781413] Hardware name: Intel Corporation PURLEY/PURLEY, BIOS PLYXCRB1.86B.0553.D01.1809190614 09/19/2018
> > > > > [  238.792383] RIP: 0010:free_unref_page+0x52/0x60
> > > > > [  238.797447] Code: 48 c1 fd 06 48 89 ee e8 9c d0 ff ff 84 c0 74 19 9c 41 5c fa 48 89 ee 48 89 df e8 b9 ea ff ff 41 f7 c4 00 02 00 00 74 01 fb 5b <5d> 41 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f0 29 77
> > > > > [  238.818406] RSP: 0018:ffffb4d87868fe98 EFLAGS: 00000206
> > > > > [  238.824236] RAX: 0000000000000000 RBX: 000000001da0c945 RCX: ffffb4d87868fe40
> > > > > [  238.832200] RDX: ffffd79d3beed108 RSI: ffffd7998501dc08 RDI: ffff9c6fbffd7010
> > > > > [  238.840166] RBP: 000000000d518cbd R08: ffffd7998501dc08 R09: 0000000000000001
> > > > > [  238.848131] R10: 0000000000000000 R11: ffffd79d3beee088 R12: 0000000000000202
> > > > > [  238.856095] R13: ffff9e5be3eceec0 R14: 0000000000000000 R15: 0000000000000000
> > > > > [  238.864059] FS:  00007fe082c2d740(0000) GS:ffff9f4c69b40000(0000) knlGS:0000000000000000
> > > > > [  238.873089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [  238.879503] CR2: 000055a000611128 CR3: 000000f6094f6006 CR4: 00000000007706e0
> > > > > [  238.887467] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > [  238.895433] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > [  238.903397] PKRU: 55555554
> > > > > [  238.906417] Call Trace:
> > > > > [  238.909149]  __vunmap+0x17c/0x220
> > > > > [  238.912851]  __x64_sys_delete_module+0x13a/0x250
> > > > > [  238.918008]  ? syscall_trace_enter.isra.20+0x13c/0x1b0
> > > > > [  238.923746]  do_syscall_64+0x39/0x80
> > > > > [  238.927740]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > > 
> > > > > Like in other range zapping routines that iterate over
> > > > > a large list, lets just add cond_resched() within __vunmap()'s
> > > > > page-releasing loop in order to avoid the watchdog splats.
> > > > 
> > > > cond_resched makes a lot of sense. We do not want vmalloc to be visible
> > > > the userspace (e.g. by stalling it) so all time consuming operations
> > > > should yield regularly whenever possible. I would expect that any
> > > > susbsystem which needs huge vmalloc areas would have it for the whole
> > > > boot life time so such large vfrees should be really rare.
> > > > 
> > > There is at least one more place with potentially similar issue. I see that
> > > the bulk allocator disables irqs during obtaining pages and filling an array.
> > > 
> > > So i suspect if we request a huge size to allocate over vmalloc same soft
> > > lockup should occur. For example 10G alloactions simultaneously on different
> > > CPUs.
> > 
> > I haven't payed a close attention to the changes regarding the bulk
> > allocator but my high level understanding is that it only allocates from
> > from pcp lists so the amount of allocatable pages is quite limited.
> 
> I am able to trigger it. To simulate it i run 10 threads to allocate and vfree
> ~1GB(262144 pages) of vmalloced memory at the same time: 
> 
> <snip>
> [   62.512621] RIP: 0010:__alloc_pages_bulk+0xa9f/0xbb0
> [   62.512628] Code: ff 8b 44 24 48 44 29 f8 83 f8 01 0f 84 ea fe ff ff e9 07 f6 ff ff 48 8b 44 24 60 48 89 28 e9 00 f9 ff ff fb 66 0f 1f 44 00 00 <e9> e8 fd ff ff 65 48 01 51 10 e9 3e fe ff ff 48 8b 44 24 78 4d 89
> [   62.512629] RSP: 0018:ffffa7bfc29ffd20 EFLAGS: 00000206
> [   62.512631] RAX: 0000000000000200 RBX: ffffcd5405421888 RCX: ffff8c36ffdeb928
> [   62.512632] RDX: 0000000000040000 RSI: ffffa896f06b2ff8 RDI: ffffcd5405421880
> [   62.512633] RBP: ffffcd5405421880 R08: 000000000000007d R09: ffffffffffffffff
> [   62.512634] R10: ffffffff9d63c084 R11: 00000000ffffffff R12: ffff8c373ffaeb80
> [   62.512635] R13: ffff8c36ffdf65f8 R14: ffff8c373ffaeb80 R15: 0000000000040000
> [   62.512637] FS:  0000000000000000(0000) GS:ffff8c36ffdc0000(0000) knlGS:0000000000000000
> [   62.512638] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   62.512639] CR2: 000055c8e2fe8610 CR3: 0000000c13e10000 CR4: 00000000000006e0
> [   62.512641] Call Trace:
> [   62.512646]  __vmalloc_node_range+0x11c/0x2d0
> [   62.512649]  ? full_fit_alloc_test+0x140/0x140 [test_vmalloc]
> [   62.512654]  __vmalloc_node+0x4b/0x70
> [   62.512656]  ? fix_size_alloc_test+0x44/0x60 [test_vmalloc]
> [   62.512659]  fix_size_alloc_test+0x44/0x60 [test_vmalloc]
> [   62.512662]  test_func+0xe7/0x1f0 [test_vmalloc]
> [   62.512666]  ? fix_align_alloc_test+0x50/0x50 [test_vmalloc]
> [   62.512668]  kthread+0x11a/0x140
> [   62.512671]  ? set_kthread_struct+0x40/0x40
> [   62.512672]  ret_from_fork+0x22/0x30
> <snip>
> 
> As for how much a bulk allocator can allocate, it is quite a lot. In my case i see
> that 262144 pages can be obtained per one bulk call, if pcp-list is empty it is
> refilled.

Hmm, that is surprising. I would have to take a closer look but I
thought the pcp list won't get refilled while there is a consumer on
that cpu. So it should really be just about the number of pages on pcp
lists. 1GB worth of memory there sounds way too much.

> >From the other hand allocating 1GB on 10 CPUs simultaneously is not common test
> case in real world.
> 
> Not sure if we can do something with it and if it is worth to fix. At least we can
> invoke a bulk allocator several times doing it per specific batch, for example 50
> pages.
> 
> Any thoughts about it?

On the other hand the bulk allocator is meant to be optimized for speed
and it assumes a certain level of reasonability from its callers so it
makes some sense to do reasonable sized batches at the vmalloc end.
-- 
Michal Hocko
SUSE Labs
