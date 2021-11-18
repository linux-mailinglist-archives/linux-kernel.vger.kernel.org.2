Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A41F455E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhKROwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhKROwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:52:13 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D962C061757
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 06:49:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so4993803wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 06:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VuOtZj1m3NqtUSDiVvaNjq8rQKL58o4UVr0KiPSv+ow=;
        b=pOAwpeJJsx2n6i5fKfb/weJFJcvwZYmObefqBi4CViSzx9prSSfQ6CJtTJguQjQiZb
         ocAQIhcbYUUzOMoZMy6OnFzrwKDsnk/o9KNkFsqTY+If6gY/Ih4LFwo0/Dr3nj/Lrywq
         Ry69w76Er6l4hI+vZe4civ8DV8j8ZFhwjwp/D189s1De7NbYAYCdC0hCe292wFslC9oC
         plT4n82ZY+qnmfgbB0qIRpKDIl7IbQx6vigqm02WjClgBHVM7P/qm26fIrXjxARo5tbe
         iB8gXw4pROXtbGzKm3RdItoRsXhncti4kE9l45OwrYq9WTicFag+VXlbk78la5LY99Xd
         KpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VuOtZj1m3NqtUSDiVvaNjq8rQKL58o4UVr0KiPSv+ow=;
        b=7f7Qc/gVwY+yaR4S1od8ChpgI74DV03dv1oLS0vhwRiB8RIX3poO7Diaxe8pxHo/dV
         A5rBajpwEcFunwMl/OS+CC57P1bzlRgs5vtXO8ClF3dXEUysI5A47WyUWSvmNSwp57aB
         EQDhE33rPAEUjUEJJ3V2KLc/7+7pZ7307Ew9cfjSJ84X9GwCagJeHJ1pqhEp8bNViDHg
         m7d5Dim1izhOH0Q3khM0e4B7dZMc64dwQ8VqZsOyyrFktEvwFOxLsvcNa1vmTah0xTdL
         S2DFXC5mytQAr2nRgWR5dsdEUVRxdL3kTeErTmbiiULrlHnPui5Ih8ubt3DrlsrGTMIr
         630g==
X-Gm-Message-State: AOAM532KFlgLX6kWcgWsE/7+ak+Bbywvlflc03yeMeorMfmhonJVfX7G
        czePyzJi/AIvwAxsgqmFl7/33g==
X-Google-Smtp-Source: ABdhPJyE1rHHqOD7OITAD7pyFmEvvDVrE24kHreuaQsoXK5beGv13sULZx95I4BrD62Z32+XJl12KA==
X-Received: by 2002:a05:600c:4153:: with SMTP id h19mr10976270wmm.142.1637246950979;
        Thu, 18 Nov 2021 06:49:10 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:7155:1b7:fca5:3926])
        by smtp.gmail.com with ESMTPSA id 9sm124976wry.0.2021.11.18.06.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:49:10 -0800 (PST)
Date:   Thu, 18 Nov 2021 15:49:04 +0100
From:   Marco Elver <elver@google.com>
To:     syzbot <syzbot+aa5bebed695edaccf0df@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [syzbot] KCSAN: data-race in flush_tlb_batched_pending /
 try_to_unmap_one
Message-ID: <YZZn4CPEK7pP4ohN@elver.google.com>
References: <00000000000020805d05d110dc77@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000020805d05d110dc77@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 06:20AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    42eb8fdac2fc Merge tag 'gfs2-v5.16-rc2-fixes' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13160026b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a70237460d215073
> dashboard link: https://syzkaller.appspot.com/bug?extid=aa5bebed695edaccf0df
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+aa5bebed695edaccf0df@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in flush_tlb_batched_pending / try_to_unmap_one
> 
> write to 0xffff8881072cfbbc of 1 bytes by task 17406 on cpu 1:
>  flush_tlb_batched_pending+0x5f/0x80 mm/rmap.c:691
>  madvise_free_pte_range+0xee/0x7d0 mm/madvise.c:594
>  walk_pmd_range mm/pagewalk.c:128 [inline]
>  walk_pud_range mm/pagewalk.c:205 [inline]
>  walk_p4d_range mm/pagewalk.c:240 [inline]
>  walk_pgd_range mm/pagewalk.c:277 [inline]
>  __walk_page_range+0x981/0x1160 mm/pagewalk.c:379
>  walk_page_range+0x131/0x300 mm/pagewalk.c:475
>  madvise_free_single_vma mm/madvise.c:734 [inline]
>  madvise_dontneed_free mm/madvise.c:822 [inline]
>  madvise_vma mm/madvise.c:996 [inline]
>  do_madvise+0xe4a/0x1140 mm/madvise.c:1202
>  __do_sys_madvise mm/madvise.c:1228 [inline]
>  __se_sys_madvise mm/madvise.c:1226 [inline]
>  __x64_sys_madvise+0x5d/0x70 mm/madvise.c:1226
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> write to 0xffff8881072cfbbc of 1 bytes by task 71 on cpu 0:
>  set_tlb_ubc_flush_pending mm/rmap.c:636 [inline]
>  try_to_unmap_one+0x60e/0x1220 mm/rmap.c:1515
>  rmap_walk_anon+0x2fb/0x470 mm/rmap.c:2301
>  try_to_unmap+0xec/0x110
>  shrink_page_list+0xe91/0x2620 mm/vmscan.c:1719
>  shrink_inactive_list+0x3fb/0x730 mm/vmscan.c:2394
>  shrink_list mm/vmscan.c:2621 [inline]
>  shrink_lruvec+0x3c9/0x710 mm/vmscan.c:2940
>  shrink_node_memcgs+0x23e/0x410 mm/vmscan.c:3129
>  shrink_node+0x8f6/0x1190 mm/vmscan.c:3252
>  kswapd_shrink_node mm/vmscan.c:4022 [inline]
>  balance_pgdat+0x702/0xd30 mm/vmscan.c:4213
>  kswapd+0x200/0x340 mm/vmscan.c:4473
>  kthread+0x2c7/0x2e0 kernel/kthread.c:327
>  ret_from_fork+0x1f/0x30
> 
> value changed: 0x01 -> 0x00
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 71 Comm: kswapd0 Not tainted 5.16.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> ==================================================================

Reading 3ea277194daae, I can't quite determine if this is safe and
expected.

Per this observed write/write race, depending on interleaving
tlb_flush_batched can randomly be true or false after
set_tlb_ubc_flush_pending().

Is this safe?

Thanks,
-- Marco
