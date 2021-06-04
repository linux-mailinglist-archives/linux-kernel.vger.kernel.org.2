Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B63F39BF2C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhFDSAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:00:06 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:55648
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229791AbhFDSAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:00:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij0xzHFVp2DQfhhFK4qebfvIWiGwzzmBHFVRg5kUCUpyzHiIPuBjTddyhlrPQ4rpR04f/N0v+BlMJGO74uSecYFxW5kHLmrW5X4N9EmYn/p5UmcJMeNb8g7KTDuAQaXC/2Gult1fJjwrAPp79CLUEhKhj4Rv9GlyHF9t3ENS7T3zj9bxMJmw0C6fIy5tsf/2eJfMJ+N4LxxLugqi+LSoVYPhFm0fYB9KVYfxR8NcxJoXWwt07eLhddLQPo0PTrMMd4IykMshw3c+39cq5TNm3cYmLq/SVoN6wAJpbQlU7fX2XjlbIPIKH+09AjQIINTFEiIhgq5HEuiobW/G87/TQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+G1Zd40daWIOF4qA0cJFEtUtslU2FXZDvlW+O2tHoA=;
 b=ZC3lBnzgKmYibERCQkmFYm7OA43M79esKn6dU1rK40htKYf6/3Lto0ZQihcxXBzWSn2iClZzuG1bs2kme6RUdPZj83Rofh+8W2B8fPqbrVtI20L6sMVnGw+QKw0YW6lVtyx4rpC/Tr6hUNqUXtHV6DkIm98wXASP1WWMXXMN0FN3Rxeh+eXPYjZ07HfejrOXUdHw7/VkKk6tkKPh2jJOL7wbooRHh3jE54/RiIG2fLijcvcOd9m60mqYttt09zHaVZEF2I7OSYeCgKDIqNq4lD2SY/VsgxnWBAJE0k7iL8pH5HE3LHTOEkFo6qbjSQpEDKYg71lYTeKCFqpiy7MAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+G1Zd40daWIOF4qA0cJFEtUtslU2FXZDvlW+O2tHoA=;
 b=nttIgvJMnFzq0W++QU6KnC4YiiCUOm4JzxXejiIZQ0z9gV7t5Q+N6UosYS9Le53KXtpTeTXk8MAg/00WreZeXt7dJP2dB6YqBqxi1xkwySQEjILKiuV3bi+0GaZwVDt/NP9t3y52ICxFlDh1YzYs3+0EUnT58gbcXkSjSu20dUXRvIuXqm3oVhL/6WUr+YhzHpjHHDtWKjC7q9SGji36OsW3yWB2i9ps7OuNovz+nlFFPcHr3iPYvF9jats49dLAMF+/T+yGs2UBWzoTPndkgSRz0IEVePQwv/ie873X6D92J9FO+Mqd23cR6wrtXPwtHsoZi+cE0zoRyspZ7HrFsw==
Received: from MW4PR04CA0158.namprd04.prod.outlook.com (2603:10b6:303:85::13)
 by MN2PR12MB3693.namprd12.prod.outlook.com (2603:10b6:208:159::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Fri, 4 Jun
 2021 17:58:16 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::a4) by MW4PR04CA0158.outlook.office365.com
 (2603:10b6:303:85::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Fri, 4 Jun 2021 17:58:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 17:58:15 +0000
Received: from [10.2.95.151] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 4 Jun
 2021 17:58:15 +0000
Subject: Re: [mm/gup] 57efa1fe59: will-it-scale.per_thread_ops -9.2%
 regression
To:     Feng Tang <feng.tang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>,
        "Peter Xu" <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        "Hugh Dickins" <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, <zhengjun.xing@intel.com>
References: <20210525031636.GB7744@xsang-OptiPlex-9020>
 <CAHk-=whTEC_GVYu=WfvUagNvHdoTALEDg8uqK3V6aMDwg2KMRA@mail.gmail.com>
 <20210604070411.GA8221@shbuild999.sh.intel.com>
 <20210604075220.GA40621@shbuild999.sh.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f35ae155-d73c-eca4-b950-58589a76addc@nvidia.com>
Date:   Fri, 4 Jun 2021 10:58:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210604075220.GA40621@shbuild999.sh.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7f9cdf8-72d5-4abe-27ae-08d9278253fc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3693:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3693553EFB80D646CD6774A7A83B9@MN2PR12MB3693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+GC35d6AwECzGLkgVXKWT2DS/rlnFznOTSLtWYElYNq6XkR59MAEpE/2ZZkOplBFQ1e+pnp3FpdYXV7PbuDu5jUKJG4IbF/3/rK/LIb1H1grC/x6MA8sEMJqLJKp8JzrdNBvWyTinXUisYUF6Bf904Y+/+WDSltJ1Ik7VYKuSMAo6h1FCZ2f7s5hAm70I2VgoX93062rISTBHRsKq6RYsyBk1m9Y67zBu51EtJSCjKNFUYKRuOcFHbdifLfa4iTYiAS0FTOl3ZmCrZ/4jHI4Rqh2BDs2g4YWf4TxLObeiS/AsIlbACDTVpKCEJkljExi2qjCCPHhSmbP7Jctrv7/VqL2ZQ80/qjhpDgjVdny4QIpsO5suYdaFm+sHiM87gZ2EFOEEqd7rc/JgJOhL0rcpubsXguYyak3veqmCqSm+a+Lm65O6k9jWj6Rw33GRKfEDeeo6+p5ms4kR0DoS5cPu5oBztfgiZHFXwISIFuaptGX/zWq6EdWj27Tq+Hwy68t2ALMzvCthV/BNq8PlSqRlK4IR9W0UOH5zGAmVmcogvoFWcXbh/X+gkct0JxV1jUV4RSPswQvJHLhwbyyguSNd0ZOMFSRF1kkUNT3/iMn9a3yN9GbGQkDMpIuaQ7DEApvcjLTQpGPhjJhU7r664XjdBmQh5jwLfKIWT89VRCHeac2MaOB3flGe+PKsqZhr5c92iBxCfh+M7EKqz2cmumtmG3ZOxouifP1HZ6V0RsRVrMAn51cgdEtxk/MroN40+m8SmB4Gj80BHCZDVzkrWizKcdtnb32jAWNom6b2fANLX4ABmdShHZnLvFoRvzwKHv
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(36840700001)(7636003)(83380400001)(36756003)(16526019)(8936002)(8676002)(7416002)(26005)(6636002)(2906002)(5660300002)(356005)(186003)(36860700001)(426003)(36906005)(86362001)(4326008)(16576012)(31686004)(336012)(2616005)(31696002)(82310400003)(110136005)(316002)(478600001)(53546011)(70206006)(82740400003)(70586007)(54906003)(966005)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 17:58:15.6793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f9cdf8-72d5-4abe-27ae-08d9278253fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3693
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/21 12:52 AM, Feng Tang wrote:
...
>>> The perf data doesn't even mention any of the GUP paths, and on the
>>> pure fork path the biggest impact would be:
>>>
>>>   (a) maybe "struct mm_struct" changed in size or had a different cache layout
>>
>> Yes, this seems to be the cause of the regression.
>>
>> The test case is many thread are doing map/unmap at the same time,
>> so the process's rw_semaphore 'mmap_lock' is highly contended.
>>
>> Before the patch (with 0day's kconfig), the mmap_lock is separated
>> into 2 cachelines, the 'count' is in one line, and the other members
>> sit in the next line, so it luckily avoid some cache bouncing. After

Wow! That's quite a fortunate layout to land on by accident. Almost
makes me wonder if mmap_lock should be designed to do that, but it's
probably even better to just keep working on having a less contended
mmap_lock.

I *suppose* it's worth trying to keep this fragile layout in place,
but it is a landmine for anyone who touches mm_struct. And the struct
is so large already that I'm not sure a comment warning would even
be noticed. Anyway...

>> the patch, the 'mmap_lock' is pushed into one cacheline, which may
>> cause the regression.
>>
>> Below is the pahole info:
>>
>> - before the patch
>>
>> 	spinlock_t         page_table_lock;      /*   116     4 */
>> 	struct rw_semaphore mmap_lock;           /*   120    40 */
>> 	/* --- cacheline 2 boundary (128 bytes) was 32 bytes ago --- */
>> 	struct list_head   mmlist;               /*   160    16 */
>> 	long unsigned int  hiwater_rss;          /*   176     8 */
>>
>> - after the patch
>>
>> 	spinlock_t         page_table_lock;      /*   124     4 */
>> 	/* --- cacheline 2 boundary (128 bytes) --- */
>> 	struct rw_semaphore mmap_lock;           /*   128    40 */
>> 	struct list_head   mmlist;               /*   168    16 */
>> 	long unsigned int  hiwater_rss;          /*   184     8 */
>>
>> perf c2c log can also confirm this.
>   
> We've tried some patch, which can restore the regerssion. As the
> newly added member 'write_protect_seq' is 4 bytes long, and putting
> it into an existing 4 bytes long hole can restore the regeression,
> while not affecting most of other member's alignment. Please review
> the following patch, thanks!
> 

So, this is a neat little solution, if we agree that it's worth "fixing".

I'm definitely on the fence, but leaning toward, "go for it", because
I like the "no cache effect" result of using up the hole.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> - Feng
> 
>  From 85ddc2c3d0f2bdcbad4edc5c392c7bc90bb1667e Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Fri, 4 Jun 2021 15:20:57 +0800
> Subject: [PATCH RFC] mm: relocate 'write_protect_seq' in struct mm_struct
> 
> Before commit 57efa1fe5957 ("mm/gup: prevent gup_fast from
> racing with COW during fork), on 64bits system, the hot member
> rw_semaphore 'mmap_lock' of 'mm_struct' could be separated into
> 2 cachelines, that its member 'count' sits in one cacheline while
> all other members in next cacheline, this naturally reduces some
> cache bouncing, and with the commit, the 'mmap_lock' is pushed
> into one cacheline, as shown in the pahole info:
> 
>   - before the commit
> 
> 	spinlock_t         page_table_lock;      /*   116     4 */
> 	struct rw_semaphore mmap_lock;           /*   120    40 */
> 	/* --- cacheline 2 boundary (128 bytes) was 32 bytes ago --- */
> 	struct list_head   mmlist;               /*   160    16 */
> 	long unsigned int  hiwater_rss;          /*   176     8 */
> 
>   - after the commit
> 
> 	spinlock_t         page_table_lock;      /*   124     4 */
> 	/* --- cacheline 2 boundary (128 bytes) --- */
> 	struct rw_semaphore mmap_lock;           /*   128    40 */
> 	struct list_head   mmlist;               /*   168    16 */
> 	long unsigned int  hiwater_rss;          /*   184     8 */
> 
> and it causes one 9.2% regression for 'mmap1' case of will-it-scale
> benchmark[1], as in the case 'mmap_lock' is highly contented (occupies
> 90%+ cpu cycles).
> 
> Though relayouting a structure could be a double-edged sword, as it
> helps some case, but may hurt other cases. So one solution is the
> newly added 'seqcount_t' is 4 bytes long (when CONFIG_DEBUG_LOCK_ALLOC=n),
> placing it into an existing 4 bytes hole in 'mm_struct' will not
> affect most of other members's alignment, while restoring the
> regression.
> 
> [1]. https://lore.kernel.org/lkml/20210525031636.GB7744@xsang-OptiPlex-9020/
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>   include/linux/mm_types.h | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5aacc1c..5b55f88 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -445,13 +445,6 @@ struct mm_struct {
>   		 */
>   		atomic_t has_pinned;
>   
> -		/**
> -		 * @write_protect_seq: Locked when any thread is write
> -		 * protecting pages mapped by this mm to enforce a later COW,
> -		 * for instance during page table copying for fork().
> -		 */
> -		seqcount_t write_protect_seq;
> -
>   #ifdef CONFIG_MMU
>   		atomic_long_t pgtables_bytes;	/* PTE page table pages */
>   #endif
> @@ -480,7 +473,15 @@ struct mm_struct {
>   		unsigned long stack_vm;	   /* VM_STACK */
>   		unsigned long def_flags;
>   
> +		/**
> +		 * @write_protect_seq: Locked when any thread is write
> +		 * protecting pages mapped by this mm to enforce a later COW,
> +		 * for instance during page table copying for fork().
> +		 */
> +		seqcount_t write_protect_seq;
> +
>   		spinlock_t arg_lock; /* protect the below fields */
> +
>   		unsigned long start_code, end_code, start_data, end_data;
>   		unsigned long start_brk, brk, start_stack;
>   		unsigned long arg_start, arg_end, env_start, env_end;
> 

