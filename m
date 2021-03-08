Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839F2331774
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 20:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhCHTj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhCHTi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:38:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3880C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 11:38:57 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t9so216810pjl.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 11:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oGgvzxSEVzGMv9hJsuMbZZPA81UiDu2S98SM5UXuHSY=;
        b=oGwASirtb25XQKLKhUlJMiHEmcgHOUnJa19bZvTXG4obYrQ9mmKeDxIrSm7l9KqjwP
         M71UBOTJQl4OUUXHtNSqsXpv6FgfIFgvDZ3E9qqw0LECNwKBJZ5OlY/1EXShCwjkN+HG
         k1G+Fg3nTG0dtPkjBVY3oo5uVuJ1+SjkCDdsqRnbALGfEciAxebqfpz9y76nFUz0PyKf
         sPKxvcjc60bHWxBgaaDvWeph1dZVlx/n0OT30a6qq6cwCkjn5ZS4oU9MmX/aOFccBh4w
         mzXkDeslBsRtqZrW7S6nBbdCeEUE3D3qzyg39r83PcUucVIrCOkStIhw2qJ+FBiKcZ3z
         uY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oGgvzxSEVzGMv9hJsuMbZZPA81UiDu2S98SM5UXuHSY=;
        b=BC0/hkUsnbtxS0yyYY9SeEXS8+28XYeBgFSf/ptX8PmL2uKdhdUetZaWNZOEmQoklx
         kwjmaqDlWfYFKhfc/ji6z328mEwYNlITSHcNpwx2Obmh/F3tFlVuyXBwmhcqjdExLWzB
         vZMs+LJaW7IFEQlQ3ro6hvsA2dJcKJUKmRdHWXhp9jgKwQTfzjKrH8OBu2ljD9W5tifp
         88qb0yHcvEVfXYYAMViYH5HEgRbIuKEhwq7ujqRMMcv8d6W7ra22gaOIOWvk0NCjLCg6
         XoV+NYcResf028NtgNUoRaojiFXbNQ42zbuZ/d5NvhMvKP2qGpTAHqI+euiAIBkQ48Qd
         zurA==
X-Gm-Message-State: AOAM532AYl8XwcgSA5eSfBNL4joz1avK4Rbpspfx34BzGruSqNp5NYee
        lItsXdFgQ+ZxXWG2k1EpPW8=
X-Google-Smtp-Source: ABdhPJyh47gJVq1rLi+44C+x5oieiZvgxQBVfQiQ4UYAeb1UXcYim2HtT/1gYdQmwn8uTu6AVw02Cg==
X-Received: by 2002:a17:90a:fb47:: with SMTP id iq7mr473483pjb.159.1615232337090;
        Mon, 08 Mar 2021 11:38:57 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4ccc:acdd:25da:14d1])
        by smtp.gmail.com with ESMTPSA id 64sm11044083pfd.174.2021.03.08.11.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 11:38:56 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 8 Mar 2021 11:38:53 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     0day robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, surenb@google.com,
        joaodias@google.com, willy@infradead.org
Subject: Re: [mm]  9ddc8abf03:
 BUG:KASAN:null-ptr-deref_in_lockdep_init_map_type
Message-ID: <YEZ9Tb4oJng85mH9@google.com>
References: <20210304161704.3056806-1-minchan@kernel.org>
 <20210308152620.GE4324@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308152620.GE4324@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 11:26:20PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 9ddc8abf031750362cda61a9fb8a28be8871eaae ("[PATCH v4] mm: cma: support sysfs")
> url: https://github.com/0day-ci/linux/commits/Minchan-Kim/mm-cma-support-sysfs/20210305-002050
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git f69d02e37a85645aa90d18cacfff36dba370f797
> 
> in testcase: trinity
> version: trinity-i386-4d2343bd-1_20200320
> with following parameters:
> 
> 	group: group-01
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-------------------------------------------------------------------------+------------+------------+
> |                                                                         | f69d02e37a | 9ddc8abf03 |
> +-------------------------------------------------------------------------+------------+------------+
> | BUG:KASAN:null-ptr-deref_in_lockdep_init_map_type                       | 0          | 12         |
> | BUG:kernel_NULL_pointer_dereference,address                             | 0          | 12         |
> | Oops:#[##]                                                              | 0          | 12         |
> | RIP:lockdep_init_map_type                                               | 0          | 12         |
> +-------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   16.842917] BUG: KASAN: null-ptr-deref in lockdep_init_map_type (kbuild/src/consumer/kernel/locking/lockdep.c:4654) 
> [   16.844311] Write of size 8 at addr 0000000000000030 by task swapper/0/1
> [   16.844311]
> [   16.844311] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc1-00023-g9ddc8abf0317 #1
> [   16.844311] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   16.844311] Call Trace:
> [   16.844311] dump_stack (kbuild/src/consumer/lib/dump_stack.c:122) 
> [   16.844311] ? lockdep_init_map_type (kbuild/src/consumer/kernel/locking/lockdep.c:4654) 
> [   16.844311] kasan_report.cold (kbuild/src/consumer/mm/kasan/report.c:403 kbuild/src/consumer/mm/kasan/report.c:416) 
> [   16.844311] ? lockdep_init_map_type (kbuild/src/consumer/kernel/locking/lockdep.c:4654) 
> [   16.844311] lockdep_init_map_type (kbuild/src/consumer/kernel/locking/lockdep.c:4654) 
> [   16.844311] __raw_spin_lock_init (kbuild/src/consumer/kernel/locking/spinlock_debug.c:26) 
> [   16.844311] cma_sysfs_init (kbuild/src/consumer/mm/cma_sysfs.c:91) 
> [   16.844311] ? cma_debugfs_init (kbuild/src/consumer/mm/cma_sysfs.c:74) 
> [   16.844311] do_one_initcall (kbuild/src/consumer/init/main.c:1226) 
> [   16.844311] ? perf_trace_initcall_level (kbuild/src/consumer/init/main.c:1217) 
> [   16.844311] ? rcu_read_lock_sched_held (kbuild/src/consumer/kernel/rcu/update.c:125) 
> [   16.844311] ? trace_event_raw_event_rcu_torture_read (kbuild/src/consumer/kernel/rcu/update.c:120) 
> [   16.844311] ? write_comp_data (kbuild/src/consumer/kernel/kcov.c:218) 
> [   16.844311] ? __sanitizer_cov_trace_pc (kbuild/src/consumer/kernel/kcov.c:197) 
> [   16.844311] kernel_init_freeable (kbuild/src/consumer/init/main.c:1298 kbuild/src/consumer/init/main.c:1315 kbuild/src/consumer/init/main.c:1335 kbuild/src/consumer/init/main.c:1537) 
> [   16.844311] ? console_on_rootfs (kbuild/src/consumer/init/main.c:1503) 
> [   16.844311] ? tracer_hardirqs_on (kbuild/src/consumer/kernel/trace/trace_irqsoff.c:57 kbuild/src/consumer/kernel/trace/trace_irqsoff.c:610) 
> [   16.844311] ? mark_held_locks (kbuild/src/consumer/kernel/locking/lockdep.c:4067) 
> [   16.844311] ? rest_init (kbuild/src/consumer/init/main.c:1421) 
> [   16.844311] kernel_init (kbuild/src/consumer/init/main.c:1426) 
> [   16.844311] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_64.S:300) 
> [   16.844311] ==================================================================
> [   16.844311] Disabling lock debugging due to kernel taint
> [   16.844425] BUG: kernel NULL pointer dereference, address: 0000000000000030
> [   16.845925] #PF: supervisor write access in kernel mode
> [   16.847149] #PF: error_code(0x0002) - not-present page
> [   16.848311] PGD 0 P4D 0
> [   16.848311] Oops: 0002 [#1] SMP KASAN PTI
> [   16.848311] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.12.0-rc1-00023-g9ddc8abf0317 #1


From 758182a763fbc0fbd6b5e143ca64a4eb31d22a1a Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Mon, 8 Mar 2021 11:33:47 -0800
Subject: [PATCH] mm: cma: fix ZERO_SIZE_PTR check

If there is no cma instance, cma_area_count will be zero and
kmalloc_arrary will return ZERO_SITE_PTR instead of NULL.

Use ZERO_OR_NULL_PTR to check both cases.

Link: https://lore.kernel.org/linux-mm/20210308152620.GE4324@xsang-OptiPlex-9020/
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/cma_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
index 67b63167eaf5..fdcb952ff13f 100644
--- a/mm/cma_sysfs.c
+++ b/mm/cma_sysfs.c
@@ -81,7 +81,7 @@ static int __init cma_sysfs_init(void)
 
 	cma_stats = kmalloc_array(cma_area_count, sizeof(struct cma_stat),
 				GFP_KERNEL|__GFP_ZERO);
-	if (!cma_stats)
+	if (ZERO_OR_NULL_PTR(cma_stats))
 		goto out;
 
 	do {
-- 
2.30.1.766.gb4fecdf3b7-goog

