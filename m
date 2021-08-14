Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B449E3EC5F9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 01:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbhHNX3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 19:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233223AbhHNX3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 19:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628983727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Xpvmc3EbPpIx4Ba3zUZgWrgU9kprzptPH5U2eEMm7Q=;
        b=MOGltdk9Ws+AWE2ds7Kf5emSVFxRuBtte3zbQKY3cYUqHy4ebdmbhyhGDj1qZfxaVumzvc
        z6boIYu8zHjRezUos3G5i5668ZKjK8fG7TFAECayyX1ShaPKY1Wa3sy/SSmzHxIVbqHyxJ
        HShkxr5m+Hdfdf5dzNYRlO3GIwxdOGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-Xy9qpofGNRSm6SC-fSg_JQ-1; Sat, 14 Aug 2021 19:28:44 -0400
X-MC-Unique: Xy9qpofGNRSm6SC-fSg_JQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81D9E871803;
        Sat, 14 Aug 2021 23:28:42 +0000 (UTC)
Received: from rh (vpn2-54-123.bne.redhat.com [10.64.54.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B5645D6D5;
        Sat, 14 Aug 2021 23:28:41 +0000 (UTC)
Received: from [::1] (helo=rh)
        by rh with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <dchinner@redhat.com>)
        id 1mF34v-0004HJ-BW; Sun, 15 Aug 2021 09:28:37 +1000
Date:   Sun, 15 Aug 2021 09:28:35 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com
Subject: Re: [xfs]  6df693ed7b:  aim7.jobs-per-min -15.7% regression
Message-ID: <20210814232835.GD2959@rh>
References: <20210809064248.GB5761@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210809064248.GB5761@xsang-OptiPlex-9020>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 02:42:48PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -15.7% regression of aim7.jobs-per-min due to commit:
> 
> 
> commit: 6df693ed7ba9ec03cafc38d5064de376a11243e2 ("xfs: per-cpu deferred inode inactivation queues")
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git xfs-5.15-merge
> 
> 
> in testcase: aim7
> on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
> with following parameters:
> 
> 	disk: 4BRD_12G
> 	md: RAID1
> 	fs: xfs
> 	test: disk_wrt
> 	load: 3000
> 	cpufreq_governor: performance
> 	ucode: 0x5003006
> 
> test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/

.....

> commit: 
>   52cba078c8 ("xfs: detach dquots from inode if we don't need to inactivate it")
>   6df693ed7b ("xfs: per-cpu deferred inode inactivation queues")
> 
> 52cba078c8b4b003 6df693ed7ba9ec03cafc38d5064 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     539418           -15.7%     454630        aim7.jobs-per-min
>      33.57           +18.5%      39.79        aim7.time.elapsed_time
>      33.57           +18.5%      39.79        aim7.time.elapsed_time.max
>       2056 ±  7%    +779.6%      18087 ±  2%  aim7.time.involuntary_context_switches
>     673.92 ±  4%     +29.2%     870.54 ±  2%  aim7.time.system_time
>     912022           -34.2%     599694        aim7.time.voluntary_context_switches

OK, performance went down, system time went up massively. I'm
betting the improvement made something else fast enough to trigger
spinning lock breakdown somewhere in the kernel...

>       0.01 ±223%      +0.9        0.93 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
>       0.01 ±223%      +0.9        0.93 ±  4%  perf-profile.children.cycles-pp.kthread
>      67.40 ±  5%      +8.7       76.14 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      67.02 ±  5%      +8.8       75.81 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
>       2.02 ±  3%     +15.4       17.42 ±  2%  perf-profile.children.cycles-pp.creat64
>       1.99 ±  4%     +15.4       17.40 ±  2%  perf-profile.children.cycles-pp.do_sys_open
>       1.99 ±  3%     +15.4       17.40 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
>       1.96 ±  4%     +15.4       17.38 ±  2%  perf-profile.children.cycles-pp.path_openat
>       1.96 ±  3%     +15.4       17.38 ±  2%  perf-profile.children.cycles-pp.do_filp_open
>       2.23 ±  6%     +15.6       17.82 ±  2%  perf-profile.children.cycles-pp.unlink
>       2.18 ±  6%     +15.6       17.78 ±  2%  perf-profile.children.cycles-pp.do_unlinkat
>       0.66 ± 19%     +30.7       31.40 ±  2%  perf-profile.children.cycles-pp.osq_lock
>       2.34 ±  8%     +31.0       33.33 ±  2%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath

Well, looky there. Lots of new rwsem lock contention.

....

>       1.54 ±  3%      +0.2        1.74        perf-profile.self.cycles-pp.rwsem_spin_on_owner
>       0.66 ± 19%     +30.6       31.21 ±  2%  perf-profile.self.cycles-pp.osq_lock

Yup, we now have catastrophic spin-on-onwer breakdown of a rwsem.

IOWs, what this commit has done is put pressure on a rwsem in a
different way, and on this specific machine configuration on this
specific workload, it results in the rwsem breaking down into
catastrophic spin-on-owner contention. This looks like a rwsem bug,
not a bug in the XFS code.

Given that this is showing up in the open and unlink paths, this
is likely the parent directory inode lock being contended due to
concurrent modifications in the same directory.

That correlates with the change that the deferred inactivation
brings to unlink worklaods - the unlink() syscall does about a third
of the work it used to, so results in locking the directory inode
*much* more frequently with only very short pauses in userspace to
make the next unlink() call.

Because of the way the worker threads are CPU bound and all the XFS
objects involved in repeated directory ops will stay CPU affine, the
unlink() syscall is likely to run hot and not block until the queue
limits are hit and it is forced to throttle and let the worker run
to drain the queue.

Now, rwsems are *supposed to be sleeping locks*. In which case, we
should switch away on contention and let the CPU be used for some
other useful work until we are granted the lock. But, no, spinning
on exclusive locks makes some other benchmark go faster, so now on
this benchmark burn *30% of 88 CPUs* spinning on rwsems across this
benchmark.

So this regression is caused by an rwsem bug. XFS is, as usual, just
the messenger for iproblems arising from the misbehaviour of rwsems.

Try turning off rwsem spin-on-owner behaviour and see what
difference that makes to performance...

Cheers,

Dave.

-- 
Dave Chinner
dchinner@redhat.com

