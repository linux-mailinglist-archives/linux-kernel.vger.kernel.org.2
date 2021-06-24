Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A713B2ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhFXMXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:23:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50658 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXMXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:23:41 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id B347F1FD35;
        Thu, 24 Jun 2021 12:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624537281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A+EM5gft6K/R+65jn4x7tx8x83/eDVDB5MncRIzQQJM=;
        b=PpsuGmZr6SCKHXt6In4AEC9BURx0Pv4b/VsojZqHaFeP5f2dmvt92b/skP1bW0JFLskLMC
        sY9Dqx8g5SREtCapOuGiLwkFwWhi3BhcPtp1JQsG1o0RBUwI23goJJcnTrYOkAvzwyV6uI
        V+Rd/hh87VnPwhlSzc0uqXVff6AuqdM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id 82F8625CCD;
        Thu, 24 Jun 2021 12:21:21 +0000 (UTC)
Date:   Thu, 24 Jun 2021 14:21:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmalloc: add cond_resched() in __vunmap()
Message-ID: <YNR4ZkwF+Bh11XMC@dhcp22.suse.cz>
References: <20210622225030.478384-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622225030.478384-1-aquini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-06-21 18:50:30, Rafael Aquini wrote:
> On non-preemptible kernel builds the watchdog can complain
> about soft lockups when vfree() is called against large
> vmalloc areas:
> 
> [  210.851798] kvmalloc-test: vmalloc(2199023255552) succeeded
> [  238.654842] watchdog: BUG: soft lockup - CPU#181 stuck for 26s! [rmmod:5203]
> [  238.662716] Modules linked in: kvmalloc_test(OE-) ...
> [  238.772671] CPU: 181 PID: 5203 Comm: rmmod Tainted: G S         OE     5.13.0-rc7+ #1
> [  238.781413] Hardware name: Intel Corporation PURLEY/PURLEY, BIOS PLYXCRB1.86B.0553.D01.1809190614 09/19/2018
> [  238.792383] RIP: 0010:free_unref_page+0x52/0x60
> [  238.797447] Code: 48 c1 fd 06 48 89 ee e8 9c d0 ff ff 84 c0 74 19 9c 41 5c fa 48 89 ee 48 89 df e8 b9 ea ff ff 41 f7 c4 00 02 00 00 74 01 fb 5b <5d> 41 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f0 29 77
> [  238.818406] RSP: 0018:ffffb4d87868fe98 EFLAGS: 00000206
> [  238.824236] RAX: 0000000000000000 RBX: 000000001da0c945 RCX: ffffb4d87868fe40
> [  238.832200] RDX: ffffd79d3beed108 RSI: ffffd7998501dc08 RDI: ffff9c6fbffd7010
> [  238.840166] RBP: 000000000d518cbd R08: ffffd7998501dc08 R09: 0000000000000001
> [  238.848131] R10: 0000000000000000 R11: ffffd79d3beee088 R12: 0000000000000202
> [  238.856095] R13: ffff9e5be3eceec0 R14: 0000000000000000 R15: 0000000000000000
> [  238.864059] FS:  00007fe082c2d740(0000) GS:ffff9f4c69b40000(0000) knlGS:0000000000000000
> [  238.873089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  238.879503] CR2: 000055a000611128 CR3: 000000f6094f6006 CR4: 00000000007706e0
> [  238.887467] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  238.895433] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  238.903397] PKRU: 55555554
> [  238.906417] Call Trace:
> [  238.909149]  __vunmap+0x17c/0x220
> [  238.912851]  __x64_sys_delete_module+0x13a/0x250
> [  238.918008]  ? syscall_trace_enter.isra.20+0x13c/0x1b0
> [  238.923746]  do_syscall_64+0x39/0x80
> [  238.927740]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Like in other range zapping routines that iterate over
> a large list, lets just add cond_resched() within __vunmap()'s
> page-releasing loop in order to avoid the watchdog splats.

cond_resched makes a lot of sense. We do not want vmalloc to be visible
the userspace (e.g. by stalling it) so all time consuming operations
should yield regularly whenever possible. I would expect that any
susbsystem which needs huge vmalloc areas would have it for the whole
boot life time so such large vfrees should be really rare.

> Signed-off-by: Rafael Aquini <aquini@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmalloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a13ac524f6ff..cd4b23d65748 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2564,6 +2564,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  
>  			BUG_ON(!page);
>  			__free_pages(page, page_order);
> +			cond_resched();
>  		}
>  		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
>  
> -- 
> 2.26.3

-- 
Michal Hocko
SUSE Labs
