Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29712344628
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCVNrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhCVNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:47:32 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BA3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:47:30 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id o19so8673215qvu.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9VzB33A/qaAdmxHnpZHVKVPdRq7vi/Iw6BzSGCxEs9w=;
        b=aLPjUleXbGXSWPE9zu1IstIW+LHjQfdJtOHbo6kWTscwGIuBP4bMD/yvQ5A+be+KY/
         66RkMHjzn87WukFC8b0DLxoZQyelJwWXs6uAT8deuUH7CZzKnjCMbJT0MLtrHk2GGD8Y
         BCW2XjTgzkHwigTQ4hLKA1q6L1i39q9Wk95wBcyDl3jGYfXkvxQwpKIrdLs+vZV/1Drc
         U8t3xHmFcNc77wrfhmtNENI0lmP/KRVmfPRaPZWesSlASHgqwHfETeSUd5b3S/sPOQIR
         P6rfhKWTJCmU4Va+v7gx5gAGp6wq+jX2h+C/lkGHGDeFg40+iic8aXvqGHxJ7dGVvkd8
         9qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9VzB33A/qaAdmxHnpZHVKVPdRq7vi/Iw6BzSGCxEs9w=;
        b=byt0Rf4HnaUfQ8E2j9XaZlbq84v6h00XNSCZfBkWZdJ2z5gKer6EA0JXoHWU9EZhCl
         R/a0z4OV5l1EphCJUFM7ggiDXffGbHoq/8igwldSde3mR+KaBn0uDqZ6i8tOPpVjal2C
         DJHH/eUdNjhqxH8CpKaFatNciXRjHOdR54G5mxiBJrbH97kqvfNgY88aXEQvH9tkvnck
         UH+/1YaciTqN7gCSw5Ym8ixy9UW6DsM1Bv/nfj2i5i7DPO9PUB/RNDfz0dTnf0Y7B6lN
         id4erigyJkLv0jbH+t6ZbhVSyjYfKhdQy7he1g6qMxN5cWfc70KtKx8TUNSa6/GX+dBR
         lq5A==
X-Gm-Message-State: AOAM5306XUmriQfugfQ5CWhm9g0KcO3MgP50+Ar89CbmWO8R17RYXB69
        nIKGuydVF6ZuHXUL8uL27iE=
X-Google-Smtp-Source: ABdhPJyeoqPMTe4RPez5sv4bwOcIqERV21anSob/I4Pzza58wOlUG17lbF8WsSA9XIrMonoPGFkf0A==
X-Received: by 2002:a0c:a1c2:: with SMTP id e60mr21193528qva.41.1616420849383;
        Mon, 22 Mar 2021 06:47:29 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:9127])
        by smtp.gmail.com with ESMTPSA id w5sm11012320qkc.85.2021.03.22.06.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 06:47:28 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:47:25 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [loop]  eaba742710:
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
Message-ID: <YFif7fEDAt6eaHDC@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20210316153655.500806-2-schatzberg.dan@gmail.com>
 <20210322060334.GD32426@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322060334.GD32426@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:03:34PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: eaba7427107045752f7454f94a40839c0880cf02 ("[PATCH 1/3] loop: Use worker per cgroup instead of kworker")
> url: https://github.com/0day-ci/linux/commits/Dan-Schatzberg/Charge-loop-device-i-o-to-issuing-cgroup/20210316-233842
> base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
> 
> in testcase: xfstests
> version: xfstests-x86_64-73c0871-1_20210318
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: xfs
> 	test: generic-group-18
> 	ucode: 0xe2
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> ... 
> [   50.428387] WARNING: CPU: 0 PID: 35 at kernel/workqueue.c:2613 check_flush_dependency (kbuild/src/consumer/kernel/workqueue.c:2613 (discriminator 9)) 
> [   50.450013] Modules linked in: loop xfs dm_mod btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c sd_mod t10_pi sg ipmi_devintf ipmi_msghandler intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal i915 intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul hp_wmi sparse_keymap intel_gtt crc32c_intel ghash_clmulni_intel mei_wdt rfkill wmi_bmof rapl drm_kms_helper ahci intel_cstate syscopyarea mei_me libahci sysfillrect sysimgblt fb_sys_fops intel_uncore serio_raw mei drm libata intel_pch_thermal ie31200_edac wmi video tpm_infineon intel_pmc_core acpi_pad ip_tables
> [   50.500731] CPU: 0 PID: 35 Comm: kworker/u8:3 Not tainted 5.12.0-rc2-00093-geaba74271070 #1
> [   50.509081] Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
> [   50.517963] Workqueue: loop0 loop_rootcg_workfn [loop]
> [   50.523109] RIP: 0010:check_flush_dependency (kbuild/src/consumer/kernel/workqueue.c:2613 (discriminator 9))
> ...
> [   50.625837] __flush_work (kbuild/src/consumer/kernel/workqueue.c:2669 kbuild/src/consumer/kernel/workqueue.c:3011 kbuild/src/consumer/kernel/workqueue.c:3051) 
> [   50.629418] ? __queue_work (kbuild/src/consumer/arch/x86/include/asm/paravirt.h:559 kbuild/src/consumer/arch/x86/include/asm/qspinlock.h:56 kbuild/src/consumer/include/linux/spinlock.h:212 kbuild/src/consumer/include/linux/spinlock_api_smp.h:151 kbuild/src/consumer/kernel/workqueue.c:1500) 
> [   50.633261] xfs_file_buffered_write (kbuild/src/consumer/fs/xfs/xfs_file.c:761) xfs
> [   50.638468] do_iter_readv_writev (kbuild/src/consumer/fs/read_write.c:741) 
> [   50.642833] do_iter_write (kbuild/src/consumer/fs/read_write.c:866 kbuild/src/consumer/fs/read_write.c:847) 
> [   50.646513] lo_write_bvec (kbuild/src/consumer/include/linux/fs.h:2903 kbuild/src/consumer/drivers/block/loop.c:286) loop
> [   50.650804] loop_process_work (kbuild/src/consumer/drivers/block/loop.c:307 kbuild/src/consumer/drivers/block/loop.c:630 kbuild/src/consumer/drivers/block/loop.c:2129 kbuild/src/consumer/drivers/block/loop.c:2161) loop
> [   50.655543] ? newidle_balance (kbuild/src/consumer/kernel/sched/fair.c:10635) 
> [   50.659647] process_one_work (kbuild/src/consumer/arch/x86/include/asm/jump_label.h:25 kbuild/src/consumer/include/linux/jump_label.h:200 kbuild/src/consumer/include/trace/events/workqueue.h:108 kbuild/src/consumer/kernel/workqueue.c:2280) 
> [   50.663696] worker_thread (kbuild/src/consumer/include/linux/list.h:282 kbuild/src/consumer/kernel/workqueue.c:2422) 
> [   50.667365] ? process_one_work (kbuild/src/consumer/kernel/workqueue.c:2364) 
> [   50.671568] kthread (kbuild/src/consumer/kernel/kthread.c:292) 
> [   50.674813] ? kthread_park (kbuild/src/consumer/kernel/kthread.c:245) 
> [   50.678476] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_64.S:300) 

My understanding is that this warning is firing because the loop
workqueue sets WQ_MEM_RECLAIM but the XFS workqueue (m_sync_workqueue)
does not. I believe that the WQ_MEM_RECLAIM on the loop device is
sensible because reclaim may flush dirty writes through the loop
device. I'm not familiar with xfs and its not clear why
m_sync_workqueue (flushed from xfs_flush_inodes) wouldn't have the
same reclaim dependency. I'll keep digging, but if anyone has
insights, please let me know.
