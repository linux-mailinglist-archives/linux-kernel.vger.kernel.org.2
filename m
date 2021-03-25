Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC35B348A37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCYHej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:34:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:13263 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhCYHe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:34:27 -0400
IronPort-SDR: jWR6Qe97Lm2zPWS1Qi4omsDyzhWe7JmIg6xGRuiyKApzdRx2vcggOE7VjS3mQK0FQhGZpa8VLv
 bXDEZFl9ZhCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="177987446"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="177987446"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 00:34:26 -0700
IronPort-SDR: edfStUN950AdU8RXblwKMq+03FxyqiZHp95NkbiJ7JEEJoCi3mDxBbIiuMRDhTxQa221YJliDW
 SMz/qFxWcC/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="415874185"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga008.jf.intel.com with ESMTP; 25 Mar 2021 00:34:13 -0700
Date:   Thu, 25 Mar 2021 15:34:13 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, zhengjun.xing@intel.com
Subject: Re: [mm] f3344adf38: fxmark.hdd_btrfs_DWAL_63_bufferedio.works/sec
 -52.4% regression
Message-ID: <20210325073413.GB10158@shbuild999.sh.intel.com>
References: <20210315062808.GA837@xsang-OptiPlex-9020>
 <CAHk-=wi1KcOZo4JeRDgJCU0gB5v16q6GJsFtF365MSfM8hH3zA@mail.gmail.com>
 <20210319032144.GA69344@shbuild999.sh.intel.com>
 <20210325065142.GA10158@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325065142.GA10158@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 02:51:42PM +0800, Feng Tang wrote:
> > > Honestly, normally if I were to get a report about "52% regression"
> > > for a commit that is supposed to optimize something, I'd just revert
> > > the commit as a case of "ok, that optimization clearly didn't work".
> > > 
> > > But there is absolutely no sign that this commit is actually the
> > > culprit, or explanation for why that should be, and what could be
> > > going on.
> > > 
> > > So I'm going to treat this as a "bisection failure, possibly due to
> > > random code or data layout changes". Particularly since this seems to
> > > be a 4-socket Xeon Phi machine, which I think is likely a very very
> > > fragile system if there is some odd cache layout issue.
> > 
> > Oliver retested it and made it run 12 times in total, and the data
> > is consistent. We tried some other test:
> > * run other sub cases of this 'fxmark' which sees no regression
> > * change 'btrfs' to 'ext4' of this case, and no regression
> > * test  on Cascadelake platform, no regression
> > 
> > So the bitsection seems to be stable, though can't be explained yet. 
> > 
> > We checked the System map of the 2 kernels, and didn't find obvious
> > code/data alignment change, which is expected, as the commit changes
> > data structure which is usually dynamically allocated. 
> 
> We found with the commit some percpu related ops do have some change,
> as shown in perf
> 
> old kernel
> ----------
>   1.06%     0.69%  [kernel.kallsyms]         [k] __percpu_counter_sum                                -      -
>   1.06% __percpu_counter_sum;need_preemptive_reclaim.part.0;__reserve_bytes;btrfs_reserve_metadata_bytes;btrfs_delalloc_reserve_metadata;btrfs_buffered_write;btrfs_file_write_iter;new_sync_write;vfs_write;ksys_write;do_syscall_64;entry_SYSCALL_64_after_hwframe;write
> 
>   89.85%    88.17%  [kernel.kallsyms]         [k] native_queued_spin_lock_slowpath                    -      -
>   45.27% native_queued_spin_lock_slowpath;_raw_spin_lock;btrfs_block_rsv_release;btrfs_inode_rsv_release;btrfs_buffered_write;btrfs_file_write_iter;new_sync_write;vfs_write;ksys_write;do_syscall_64;entry_SYSCALL_64_after_hwframe;write
>   44.51% native_queued_spin_lock_slowpath;_raw_spin_lock;__reserve_bytes;btrfs_reserve_metadata_bytes;btrfs_delalloc_reserve_metadata;btrfs_buffered_write;btrfs_file_write_iter;new_sync_write;vfs_write;ksys_write;do_syscall_64;entry_SYSCALL_64_after_hwframe;write
> 
> 
> new kernel
> ----------
>   1.33%     1.14%  [kernel.kallsyms]         [k] __percpu_counter_sum                                    -      -
>   1.33% __percpu_counter_sum;need_preemptive_reclaim.part.0;__reserve_bytes;btrfs_reserve_metadata_bytes;btrfs_delalloc_reserve_metadata;btrfs_buffered_write;btrfs_file_write_iter;new_sync_write;vfs_write;ksys_write;do_syscall_64;entry_SYSCALL_64_after_hwframe
> 
>   95.95%    95.31%  [kernel.kallsyms]         [k] native_queued_spin_lock_slowpath                        -      -
>   48.56% native_queued_spin_lock_slowpath;_raw_spin_lock;btrfs_block_rsv_release;btrfs_inode_rsv_release;btrfs_buffered_write;btrfs_file_write_iter;new_sync_write;vfs_write;ksys_write;do_syscall_64;entry_SYSCALL_64_after_hwframe
>   47.33% native_queued_spin_lock_slowpath;_raw_spin_lock;__reserve_bytes;btrfs_reserve_metadata_bytes;btrfs_delalloc_reserve_metadata;btrfs_buffered_write;btrfs_file_write_iter;new_sync_write;vfs_write;ksys_write;do_syscall_64;entry_SYSCALL_64_after_hwframe
> 
> __percpu_counter_sum is usually costy for platform with many CPUs and
> it does rise much. It is called in fs/btrfs/space-info.c
> 	need_preemptive_reclaim
> 		ordered = percpu_counter_sum_positive(&fs_info->ordered_bytes);
> 	        delalloc = percpu_counter_sum_positive(&fs_info->delalloc_bytes);
> 
> And we did 2 experiments:
> 1. Change the percpu_counter_sum_positive() to percpu_counter_read_positive()
>    which skips looping online CPUs to get the sum, inside need_preemptive_reclaim(),
>    the regression is gone, and even better

Interestingly, We just got mail from Oliver about btrfs perf's 81.3%
improvement:
https://lore.kernel.org/lkml/20210325055609.GA13061@xsang-OptiPlex-9020/

which is from Josef's patch which does the same conversion of functions
of getting percpu counter.

I guess with the patch, this regression will be gone, and several other
old regressions will be gone too (Thanks Josef):
https://lore.kernel.org/lkml/20201104061657.GB15746@xsang-OptiPlex-9020/
https://lore.kernel.org/lkml/20210305083757.GF31481@xsang-OptiPlex-9020/

Thanks,
Feng

