Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99EB39B4FB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFDIjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:39:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:50572 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhFDIjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:39:46 -0400
IronPort-SDR: uLbcEjWgX2ZijfDg376+/Dz70qKitHflCob+7PWMmxr4d8efxQNISGGG5zjZ2YfgpNaAPKbf8g
 WjChheiKfjDw==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="265415523"
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="265415523"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 01:37:59 -0700
IronPort-SDR: AclLJia9BD0aIRsL+zozbyKJTa3DCdxowysJiikvTY/1MDyAvZt7qqiiQje0PVoYbvgDjdSGId
 X96xh0/Sr7KA==
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="480561157"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.5.220]) ([10.238.5.220])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 01:37:55 -0700
Subject: Re: [LKP] Re: [mm/gup] 57efa1fe59: will-it-scale.per_thread_ops -9.2%
 regression
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
References: <20210525031636.GB7744@xsang-OptiPlex-9020>
 <CAHk-=whTEC_GVYu=WfvUagNvHdoTALEDg8uqK3V6aMDwg2KMRA@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <2a1977e1-4fd1-065a-214f-51c6b40cc3d2@linux.intel.com>
Date:   Fri, 4 Jun 2021 16:37:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whTEC_GVYu=WfvUagNvHdoTALEDg8uqK3V6aMDwg2KMRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 5/25/2021 11:11 AM, Linus Torvalds wrote:
> On Mon, May 24, 2021 at 5:00 PM kernel test robot <oliver.sang@intel.com> wrote:
>> FYI, we noticed a -9.2% regression of will-it-scale.per_thread_ops due to commit:
>> commit: 57efa1fe5957694fa541c9062de0a127f0b9acb0 ("mm/gup: prevent gup_fast from racing with COW during fork")
> Hmm. This looks like one of those "random fluctuations" things.
>
> It would be good to hear if other test-cases also bisect to the same
> thing, but this report already says:
>
>> In addition to that, the commit also has significant impact on the following tests:
>>
>> +------------------+---------------------------------------------------------------------------------+
>> | testcase: change | will-it-scale: will-it-scale.per_thread_ops 3.7% improvement                    |
> which does kind of reinforce that "this benchmark gives unstable numbers".
>
> The perf data doesn't even mention any of the GUP paths, and on the
> pure fork path the biggest impact would be:
>
>   (a) maybe "struct mm_struct" changed in size or had a different cache layout
I move "write_protect_seq" to the tail of the "struct mm_struct", the 
regression reduced to -3.6%. The regression should relate to the cache 
layout.
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/cpufreq_governor/ucode:
lkp-icl-2sp1/will-it-scale/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/50%/thread/mmap1/performance/0xb000280

commit:
   c28b1fc70390df32e29991eedd52bd86e7aba080
   57efa1fe5957694fa541c9062de0a127f0b9acb0
   f6a9c27882d51ff551e15522992d3725c342372d  (the test patch)

c28b1fc70390df32 57efa1fe5957694fa541c9062de f6a9c27882d51ff551e15522992
---------------- --------------------------- ---------------------------
          %stddev     %change         %stddev     %change %stddev
              \          |                \          | \
     341938            -9.0%     311218 ±  2%      -3.6% 329513        
will-it-scale.48.threads
       7123            -9.0%       6483 ±  2%      -3.6% 6864        
will-it-scale.per_thread_ops
     341938            -9.0%     311218 ±  2%      -3.6% 329513        
will-it-scale.workload

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 915f4f100383..34bb2a01806c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -447,13 +447,6 @@ struct mm_struct {
                  */
                 atomic_t has_pinned;

-               /**
-                * @write_protect_seq: Locked when any thread is write
-                * protecting pages mapped by this mm to enforce a later 
COW,
-                * for instance during page table copying for fork().
-                */
-               seqcount_t write_protect_seq;
-
  #ifdef CONFIG_MMU
                 atomic_long_t pgtables_bytes;   /* PTE page table pages */
  #endif
@@ -564,6 +557,12 @@ struct mm_struct {
  #ifdef CONFIG_IOMMU_SUPPORT
                 u32 pasid;
  #endif
+                /**
+                 * @write_protect_seq: Locked when any thread is write
+                 * protecting pages mapped by this mm to enforce a 
later COW,
+                 * for instance during page table copying for fork().
+                 */
+                seqcount_t write_protect_seq;
         } __randomize_layout;

         /*

>
>   (b) two added (nonatomic) increment operations in the fork path due
> to the seqcount
>
> and I'm not seeing what would cause that 9% change. Obviously cache
> placement has done it before.
>
> If somebody else sees something that I'm missing, please holler. But
> I'll ignore this as "noise" otherwise.
>
>              Linus
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

-- 
Zhengjun Xing

