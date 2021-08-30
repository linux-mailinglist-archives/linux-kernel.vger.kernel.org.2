Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C843FBF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbhH3XNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:13:50 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:34574 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbhH3XNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:13:47 -0400
Received: by mail-pl1-f179.google.com with SMTP id j2so9484440pll.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 16:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=v3IzYk5Cz+OUtPw+/T83szt+1CdCHRLLUCDNc9RQVcs=;
        b=YcV2ddWuIrF2s1vGYe9HzAGnODRw5wnfJ5u2ELHYhdQRcHeO6542ekG0CExW5mtlHX
         UqEC5wM0qhgLCEr9b4uj5dD99SlTvuqWUYfxwg8AkyBLquBCvLDBngtRxPd+yALzuL36
         +zrvC+uQV5239SG8ObDcMp54Pfv1YtpP+I27kBAeBxrXKUneZJbmWOKBySQISnlmrZLJ
         FnCqAA3oyLquzdH4MXa8Bcmo1o7Bi0R8HhI4Fa7s6z0a680cQ+/w39Kdfh2v6xSbXbtz
         yIYalCvw9xtXpLxp6Fozb1e+HDe8Fw0csoccfsY7+NutnDNGIC0AZnrC6P+UXtVh1kMY
         pBpg==
X-Gm-Message-State: AOAM532foQkvQKJQzseJCFhCFbwWht25WKpdU8rMpVEhEU/HL3b0atPh
        pfca1bzg62u7gEdiMSvhnes=
X-Google-Smtp-Source: ABdhPJyM+xavDMy2nU5nHoZXItH9Z32dpIp3B6TEu9y18rZ8vFM4JFAMkb8gBzWR8C+1D3lMK1Vm+Q==
X-Received: by 2002:a17:90a:3cc6:: with SMTP id k6mr1630328pjd.134.1630365173468;
        Mon, 30 Aug 2021 16:12:53 -0700 (PDT)
Received: from sultan-box.localdomain (static-198-54-131-119.cust.tzulo.com. [198.54.131.119])
        by smtp.gmail.com with ESMTPSA id w11sm8448566pfj.65.2021.08.30.16.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 16:12:53 -0700 (PDT)
Date:   Mon, 30 Aug 2021 16:12:51 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     linux-mm@kvack.org
Cc:     mhocko@suse.com, mgorman@techsingularity.net,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Stuck looping on list_empty(list) in free_pcppages_bulk()
Message-ID: <YS1l83lmwEYXuQsY@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was recently given the following CPU stall splat and asked to look into it:
----------------8<----------------
 rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
 rcu:         44-...0: (1 GPs behind) idle=77e/1/0x4000000000000000 softirq=28480656/28480657 fqs=279939 
         (detected by 62, t=1140032 jiffies, g=224165577, q=8883218)
 Sending NMI from CPU 62 to CPUs 44:
 NMI backtrace for cpu 44
 CPU: 44 PID: 83957 Comm: perl Tainted: G             L    5.8.18-100.fc31.x86_64 #1
 RIP: 0010:free_pcppages_bulk+0x63/0x2a0
 RSP: 0018:ffffb3078698fb60 EFLAGS: 00000086
 RAX: ffff8b647db30390 RBX: ffffee5fcab67f48 RCX: ffffee5f30c79980
 RDX: 0000000000c31e66 RSI: 0000000000000007 RDI: 0000000000000007
 RBP: 0000000000000000 R08: ffffb3078698fb80 R09: ffffb3078698fb80
 R10: 00000000002ffa93 R11: 0000000000000000 R12: ffff8b647db30390
 R13: 0000000000000000 R14: ffff8b647db30380 R15: 000000006a340084
 FS:  0000000000000000(0000) GS:ffff8b647db00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007ff2b5200fa8 CR3: 00000034ada0a000 CR4: 0000000000340ee0
 Call Trace:
  free_unref_page_list+0x113/0x1a0
  release_pages+0x3ad/0x450
  tlb_flush_mmu+0x36/0x160
  unmap_page_range+0xab6/0xee0
  unmap_vmas+0x6a/0xd0
  exit_mmap+0x97/0x170
  mmput+0x61/0x140
  do_exit+0x306/0xb80
  ? syscall_trace_enter+0x160/0x290
  do_group_exit+0x3a/0xa0
  __x64_sys_exit_group+0x14/0x20
  do_syscall_64+0x4d/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
---------------->8----------------

I apologize in advance for reporting a bug on an EOL kernel. I don't see any
changes as of 5.14 that could address something like this, so I'm emailing in
case whatever happened here may be a bug affecting newer kernels.

With gdb, it appears that the CPU got stuck in the list_empty(list) loop inside
free_pcppages_bulk():
----------------8<----------------
	do {
		batch_free++;
		if (++migratetype == MIGRATE_PCPTYPES)
			migratetype = 0;
		list = &pcp->lists[migratetype];
	} while (list_empty(list));
---------------->8----------------

Although this code snippet is slightly different in 5.14, it's still ultimately
the same. Side note: I noticed that the way `migratetype` is incremented causes
`&pcp->lists[1]` to get looked at first rather than `&pcp->lists[0]`, since
`migratetype` will start out at 1. This quirk is still present in 5.14, though
the variable in question is now called `pindex`.

With some more gdb digging, I found that the `count` variable was stored in %ESI
at the time of the stall. According to register dump in the splat, %ESI was 7.

It looks like, for some reason, the pcp count was 7 higher than the number of
pages actually present in the pcp lists.

I tried to find some way that this could happen, but the only thing I could
think of was that maybe an allocation had both __GFP_RECLAIMABLE and
__GFP_MOVABLE set in its gfp mask, in which case the rmqueue() call in
get_page_from_freelist() would pass in a migratetype equal to MIGRATE_PCPTYPES
and then pages could be added to an out-of-bounds pcp list while still
incrementing the overall pcp count. This seems pretty unlikely though. As
another side note, it looks like there's nothing stopping this from occurring;
there's only a VM_WARN_ON() in gfp_migratetype() that checks if both bits are
set.

Any ideas on what may have happened here, or a link to a commit that may have
fixed this issue in newer kernels, would be much appreciated.

Thanks,
Sultan
