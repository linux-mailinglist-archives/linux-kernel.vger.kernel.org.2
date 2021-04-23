Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33359369266
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 14:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbhDWMtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhDWMtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:49:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE17CC061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=d+62syAUKVHnyCs4R/YinMObJcTHmOL48njuvbToqKc=; b=PNSVmEfj7RyCKZh7Y3aZCJE4f0
        p9goePTU8TUPrpIQw6H9YWzoyY22zAPPVxvoack2lFNzLLdXF4wgzlrx8xXh1rbBOXt2vzfZNf04T
        ntmvGddFCQbtBqtq+nBk7C+MQV+RBhZN4YHgao7TjbzAAvbreQgJSyA3YbinZmECk3KWRLTOIjQwd
        2D45w7LkgKFdoYfMDHxQXyj4DpeFUHixO/N+/HDdnpGt6Ngze0lPriX+ZKQ9UOUSBLTu6wltpOw+6
        GdZJU5OWMN2S691nkL2waPvUfk15tXmp7asEc9lIwFW7wldC8qIgUt8U7LzaWKmPGCwlrxb4pDLV/
        GxpXvJwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZvDt-001r9N-1h; Fri, 23 Apr 2021 12:48:11 +0000
Date:   Fri, 23 Apr 2021 13:47:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     lkp <oliver.sang@intel.com>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [mm/writeback]  e5dbd33218:  will-it-scale.per_process_ops -3.8%
 regression
Message-ID: <20210423124753.GA235567@casper.infradead.org>
References: <20210423054601.GC13944@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210423054601.GC13944@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 01:46:01PM +0800, kernel test robot wrote:
> FYI, we noticed a -3.8% regression of will-it-scale.per_process_ops due to commit:
> commit: e5dbd33218bd8d87ab69f730ab90aed5fab7eb26 ("mm/writeback: Add wait_on_page_writeback_killable")

That commit just adds a function.  It doesn't add any callers.  It must
just be moving something around ...

> 39f985c8f667c80a e5dbd33218bd8d87ab69f730ab9 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>    9359770            -3.8%    9001769        will-it-scale.16.processes
>     584985            -3.8%     562610        will-it-scale.per_process_ops
>    9359770            -3.8%    9001769        will-it-scale.workload
>      15996            -1.2%      15811        proc-vmstat.nr_kernel_stack
>      23577 ± 10%     +18.5%      27937 ±  7%  softirqs.CPU48.SCHED
>       5183 ± 41%     +47.2%       7630 ±  7%  interrupts.CPU1.NMI:Non-maskable_interrupts
>       5183 ± 41%     +47.2%       7630 ±  7%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
>      54.33 ± 12%     +18.4%      64.33 ±  7%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
>     153.34 ± 24%     -45.9%      83.00 ± 25%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
>     153.33 ± 24%     -45.9%      82.99 ± 25%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
>  2.424e+10            -3.8%  2.332e+10        perf-stat.i.branch-instructions
>       0.47            +3.7%       0.48        perf-stat.i.cpi
>  2.529e+10            -4.0%  2.428e+10        perf-stat.i.dTLB-loads
>   1.15e+10            -3.8%  1.106e+10        perf-stat.i.dTLB-stores
>   54249733            -4.8%   51627939        perf-stat.i.iTLB-load-misses
>  1.004e+11            -3.8%  9.661e+10        perf-stat.i.instructions
>       2.15            -3.6%       2.07        perf-stat.i.ipc
>     693.66            -3.9%     666.70        perf-stat.i.metric.M/sec
>       0.46            +3.7%       0.48        perf-stat.overall.cpi
>       2.15            -3.6%       2.08        perf-stat.overall.ipc
>  2.416e+10            -3.8%  2.324e+10        perf-stat.ps.branch-instructions
>   2.52e+10            -4.0%  2.419e+10        perf-stat.ps.dTLB-loads
>  1.146e+10            -3.8%  1.102e+10        perf-stat.ps.dTLB-stores
>   54065825            -4.8%   51454019        perf-stat.ps.iTLB-load-misses
>  1.001e+11            -3.8%  9.628e+10        perf-stat.ps.instructions
>  3.025e+13            -3.9%  2.908e+13        perf-stat.total.instructions
>       0.89 ± 14%      -0.1        0.77 ± 11%  perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.shmem_mmap.mmap_region.do_mmap
>       0.14 ± 13%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.common_mmap
>       0.61 ± 12%      -0.1        0.52 ± 12%  perf-profile.children.cycles-pp.common_file_perm
>       0.21 ±  8%      -0.0        0.17 ± 11%  perf-profile.children.cycles-pp.vma_set_page_prot
>       0.12 ±  8%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.blocking_notifier_call_chain
>       0.12 ± 14%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp.get_mmap_base
>       0.09 ±  8%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.vm_pgprot_modify
>       0.13 ± 15%      +0.1        0.19 ±  8%  perf-profile.children.cycles-pp.cap_capable
>       0.03 ±102%      +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.munmap@plt
>       0.14 ± 13%      +0.1        0.24 ±  6%  perf-profile.children.cycles-pp.testcase
>       0.33 ± 10%      -0.1        0.23 ± 10%  perf-profile.self.cycles-pp.cap_vm_enough_memory
>       0.13 ± 11%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.common_mmap
>       0.48 ± 12%      -0.1        0.41 ± 12%  perf-profile.self.cycles-pp.common_file_perm
>       0.49 ± 12%      -0.1        0.43 ± 13%  perf-profile.self.cycles-pp.vm_area_alloc
>       0.12 ±  8%      -0.0        0.09 ± 12%  perf-profile.self.cycles-pp.blocking_notifier_call_chain
>       0.12 ± 13%      -0.0        0.09 ± 14%  perf-profile.self.cycles-pp.get_mmap_base
>       0.11 ±  8%      +0.0        0.16 ± 10%  perf-profile.self.cycles-pp.__x64_sys_munmap
>       0.11 ± 14%      +0.1        0.18 ±  8%  perf-profile.self.cycles-pp.cap_capable
>       0.12 ± 11%      +0.1        0.20 ±  6%  perf-profile.self.cycles-pp.testcase
>       0.01 ±223%      +0.1        0.11 ± 13%  perf-profile.self.cycles-pp.munmap@plt

I'm struggling to see anything in that that says anything other than
"we did 3-4% less work".  Maybe someone else has something useful to
say about it?
