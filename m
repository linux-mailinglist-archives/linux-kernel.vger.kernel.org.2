Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0543B3B3FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhFYIxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:53:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39664 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYIxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:53:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2FE401FE59;
        Fri, 25 Jun 2021 08:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624611069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tr5TstT9gALcB8nt56L0M+TVC53ROBIO51M+JE8/czA=;
        b=m7NFVlfOyOp5BFZuyYAhnAfqiVsmlw1/uyQnxELiXomD/nbj8SW8AavYvK0+SNYBawni+i
        bsQIuN0iFPRx+xALfgjP9BBHQmdgLyvjpGkLam6NT/IBCTpSdT1rqEAbf3+3bGTRxSJgW2
        SSuZYS6bezInnesZa/WI0d/TLb7BTYo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0147AA3BF4;
        Fri, 25 Jun 2021 08:51:08 +0000 (UTC)
Date:   Fri, 25 Jun 2021 10:51:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmalloc: add cond_resched() in __vunmap()
Message-ID: <YNWY/IY+ftszkjM5@dhcp22.suse.cz>
References: <20210622225030.478384-1-aquini@redhat.com>
 <YNR4ZkwF+Bh11XMC@dhcp22.suse.cz>
 <20210624142339.GA2267@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624142339.GA2267@pc638.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-06-21 16:23:39, Uladzislau Rezki wrote:
> On Thu, Jun 24, 2021 at 02:21:21PM +0200, Michal Hocko wrote:
> > On Tue 22-06-21 18:50:30, Rafael Aquini wrote:
> > > On non-preemptible kernel builds the watchdog can complain
> > > about soft lockups when vfree() is called against large
> > > vmalloc areas:
> > > 
> > > [  210.851798] kvmalloc-test: vmalloc(2199023255552) succeeded
> > > [  238.654842] watchdog: BUG: soft lockup - CPU#181 stuck for 26s! [rmmod:5203]
> > > [  238.662716] Modules linked in: kvmalloc_test(OE-) ...
> > > [  238.772671] CPU: 181 PID: 5203 Comm: rmmod Tainted: G S         OE     5.13.0-rc7+ #1
> > > [  238.781413] Hardware name: Intel Corporation PURLEY/PURLEY, BIOS PLYXCRB1.86B.0553.D01.1809190614 09/19/2018
> > > [  238.792383] RIP: 0010:free_unref_page+0x52/0x60
> > > [  238.797447] Code: 48 c1 fd 06 48 89 ee e8 9c d0 ff ff 84 c0 74 19 9c 41 5c fa 48 89 ee 48 89 df e8 b9 ea ff ff 41 f7 c4 00 02 00 00 74 01 fb 5b <5d> 41 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f0 29 77
> > > [  238.818406] RSP: 0018:ffffb4d87868fe98 EFLAGS: 00000206
> > > [  238.824236] RAX: 0000000000000000 RBX: 000000001da0c945 RCX: ffffb4d87868fe40
> > > [  238.832200] RDX: ffffd79d3beed108 RSI: ffffd7998501dc08 RDI: ffff9c6fbffd7010
> > > [  238.840166] RBP: 000000000d518cbd R08: ffffd7998501dc08 R09: 0000000000000001
> > > [  238.848131] R10: 0000000000000000 R11: ffffd79d3beee088 R12: 0000000000000202
> > > [  238.856095] R13: ffff9e5be3eceec0 R14: 0000000000000000 R15: 0000000000000000
> > > [  238.864059] FS:  00007fe082c2d740(0000) GS:ffff9f4c69b40000(0000) knlGS:0000000000000000
> > > [  238.873089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  238.879503] CR2: 000055a000611128 CR3: 000000f6094f6006 CR4: 00000000007706e0
> > > [  238.887467] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [  238.895433] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [  238.903397] PKRU: 55555554
> > > [  238.906417] Call Trace:
> > > [  238.909149]  __vunmap+0x17c/0x220
> > > [  238.912851]  __x64_sys_delete_module+0x13a/0x250
> > > [  238.918008]  ? syscall_trace_enter.isra.20+0x13c/0x1b0
> > > [  238.923746]  do_syscall_64+0x39/0x80
> > > [  238.927740]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > 
> > > Like in other range zapping routines that iterate over
> > > a large list, lets just add cond_resched() within __vunmap()'s
> > > page-releasing loop in order to avoid the watchdog splats.
> > 
> > cond_resched makes a lot of sense. We do not want vmalloc to be visible
> > the userspace (e.g. by stalling it) so all time consuming operations
> > should yield regularly whenever possible. I would expect that any
> > susbsystem which needs huge vmalloc areas would have it for the whole
> > boot life time so such large vfrees should be really rare.
> > 
> There is at least one more place with potentially similar issue. I see that
> the bulk allocator disables irqs during obtaining pages and filling an array.
> 
> So i suspect if we request a huge size to allocate over vmalloc same soft
> lockup should occur. For example 10G alloactions simultaneously on different
> CPUs.

I haven't payed a close attention to the changes regarding the bulk
allocator but my high level understanding is that it only allocates from
from pcp lists so the amount of allocatable pages is quite limited.
-- 
Michal Hocko
SUSE Labs
