Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8155A376E07
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 03:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEHBNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 21:13:45 -0400
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:22710
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229663AbhEHBNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 21:13:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US6+0a1Mcqn43CpKJXm4PZ8hxM0FaP/MLQHuwPNv7NXJjotVi1SLpKLPPvbtvbvo0SqSH5A8jRfflQX+PWwyNxm/TXn6AcGSzuvDzjglZ74YkZdb1qggLc1lnZlCZx9OVxgtPHfIbXgmQjO0v53P0lVgRvjSd4ivK26dYz6YhnIGopwRrjso53jvzxR69n8BbU6KJSO3loh+NaOsFvP5a3D3cG7ruQhXJ/Y0FZPuFYm3MEGIyuX4IQMh8olFu2C8LnkaLFnn55NqbLpcMu3cDZNCMbxDaaMANkNX01c5w5of5Nmvg/6rHrKXJq07G5k0eUoMAzM5yEj/OMjs0/GbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqNJrWiXEbunbn8KZ/ZHYDF7Um8p9aj8FaiMZBa+p3U=;
 b=M7gUMteTOuybESriym3k7+e9rgBZ8wEqvUdOrugGp58Cm6BEDdqCc3r/TqB7vDh3ojk5boW4gWnq536Z1YLiFobir3OBo8OA/zJEplLp2I0kdwveQctRJvaF5Phfu5wPhJoQL3ahCc9AEhfjw5mxMHcE08x/0mBDuirbV+I+pkCLMSiV7DhdqaAIAs7WMFrct+Z9J4q0vSAWQZiKnd1yHH4ouUJeUbKvwXNKgQci0nrM4PE2Hzx0dnOpTnNFzUwQspBah2MMjFw1ed7qJEeZpxm2UoydGQUFHraJKwn9ApK/E7wtrZweGH+SzneDnKKkZvO5IgntKWvPzRVvr+lDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqNJrWiXEbunbn8KZ/ZHYDF7Um8p9aj8FaiMZBa+p3U=;
 b=hGD0MpHIvA111eD2nR/Av4R8l55hFWfZE4YmOZMFgvtNSUFf7/431XvqSH/VS1sjPZDmyKIT/IKk2D7GaX6hdBFQflBf1GDJDPiYEKrPLpguqCApRIRBrWg9L3HAdykv39HUS9B5yEASl/+gA+9CB45dPIHo9lkzEWVs6o7AZCPV5K6ovip4cx8HiGjbDtJgwFtPCX2+znzR7xqa9Xm+OMMeIPnCuSgu26ouG0G/rAdpgXx5Dtt6BHatg4q7O9lKHTZ/xwZLkR777AtOzvNZ3zaWxagp46rTjLXtOcL03MSaWQ7XjoNsplfLGlMOHMGTBSgOBWceKLX4tV/NKgy0hA==
Received: from BN7PR06CA0072.namprd06.prod.outlook.com (2603:10b6:408:34::49)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Sat, 8 May
 2021 01:12:42 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::35) by BN7PR06CA0072.outlook.office365.com
 (2603:10b6:408:34::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Sat, 8 May 2021 01:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 01:12:41 +0000
Received: from [10.2.61.66] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 8 May
 2021 01:12:40 +0000
Subject: Re: [PATCH v2 3/3] mm: gup: pack has_pinned in MMF_HAS_PINNED
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Kirill Shutemov" <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
References: <20210507150553.208763-1-peterx@redhat.com>
 <20210507150553.208763-4-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <79686de9-d8f9-f4ce-d43d-ac1ef8a09665@nvidia.com>
Date:   Fri, 7 May 2021 18:12:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210507150553.208763-4-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e1ee26f-3b18-48c1-96cb-08d911be6115
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-Microsoft-Antispam-PRVS: <SN6PR12MB284676B1DA47552D77BDCE39A8569@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3uAUSFXy9NiL01WQZ8lYWl7Z85u8M6TcIRbFFg4t5dmhVvLoc5C+0GH5STvM9bkR/XjWovx+bWYQnwARMNwPtt3Fh5FGSPpAsp0eXYbiDD4vsovQtsGKZI4J3FP2/7D/nch1Cwned5JyPgxHZNxp387aHZjl28C6TSZS4wwd3CP5S3iHDqB1RUf9fsBybw0OiYcknEkQJEokThsoHGbjI8CKG59rnQd0rNPxroGQGDmG8ASR7dYdGroB0E7KhSPz0OaubajMWDQoa2epHaIq7gtEaJMRTpIDfz1Cx0S9C9y6SkOaV4pC+Qx48icB5S/Q7sXasJjlNRhMy6ShJ7koJ4xIZPOKK1DEayTDQfAmnzRluxNfiBCXxHsdx8V9OiQyoqjkOUJR8UgZoUyXxpbVTNsN08CJTHWXAp51jLzXQkdydpOIOfdmiidc/d9iN78RXNKcCnRZJTOzWs6nZzbTJYse0GG7MH3A08CMeMQ6ohgtZnRqlVC7tq5q+s5mMbrTY8Fz40iFe1ceyNNE53e/4+/j2qJPjIJFFUy7g4iUBNAXswy3HHqIxD9sOWMhNq0Yco9vXYplWHdObuSit3Z0oT5z/lA0NCi5OwAb5L0eSyaKcDRPMcuHLQ73lQFqnB+9taNKYw4lLCimm5c8pMbE57UADpNuIpJ2VVlKXmOMJpR5S2MAzfHQae1qaqMn4Gg6IVXHKerhHi2ubNjAVaHvQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(36840700001)(46966006)(83380400001)(36906005)(356005)(316002)(36756003)(5660300002)(2616005)(53546011)(82310400003)(7636003)(82740400003)(47076005)(16576012)(31686004)(70206006)(70586007)(86362001)(4326008)(2906002)(31696002)(36860700001)(26005)(7416002)(8936002)(186003)(426003)(16526019)(478600001)(336012)(8676002)(54906003)(110136005)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 01:12:41.8100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1ee26f-3b18-48c1-96cb-08d911be6115
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/21 8:05 AM, Peter Xu wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> has_pinned 32bit can be packed in the MMF_HAS_PINNED bit as a noop
> cleanup.
> 
> Any atomic_inc/dec to the mm cacheline shared by all threads in
> pin-fast would reintroduce a loss of SMP scalability to pin-fast, so
> there's no future potential usefulness to keep an atomic in the mm for
> this.
> 
> set_bit(MMF_HAS_PINNED) will be theoretically a bit slower than
> WRITE_ONCE (atomic_set is equivalent to WRITE_ONCE), but the set_bit
> (just like atomic_set after this commit) has to be still issued only
> once per "mm", so the difference between the two will be lost in the
> noise.
> 
> will-it-scale "mmap2" shows no change in performance with enterprise
> config as expected.
> 
> will-it-scale "pin_fast" retains the > 4000% SMP scalability
> performance improvement against upstream as expected.
> 
> This is a noop as far as overall performance and SMP scalability are
> concerned.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> [peterx: Fix build for task_mmu.c, introduce mm_set_has_pinned_flag, fix
>   comment here and there]
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   fs/proc/task_mmu.c             |  2 +-
>   include/linux/mm.h             |  2 +-
>   include/linux/mm_types.h       | 10 ----------
>   include/linux/sched/coredump.h |  8 ++++++++
>   kernel/fork.c                  |  1 -
>   mm/gup.c                       | 19 +++++++++++++++----
>   6 files changed, 25 insertions(+), 17 deletions(-)
> 

Looks good.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 4c95cc57a66a8..6144571942db9 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1049,7 +1049,7 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
>   		return false;
>   	if (!is_cow_mapping(vma->vm_flags))
>   		return false;
> -	if (likely(!atomic_read(&vma->vm_mm->has_pinned)))
> +	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
>   		return false;
>   	page = vm_normal_page(vma, addr, pte);
>   	if (!page)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d6790ab0cf575..94dc84f6d8658 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1331,7 +1331,7 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>   	if (!is_cow_mapping(vma->vm_flags))
>   		return false;
>   
> -	if (!atomic_read(&vma->vm_mm->has_pinned))
> +	if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
>   		return false;
>   
>   	return page_maybe_dma_pinned(page);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6613b26a88946..15d79858fadbd 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -435,16 +435,6 @@ struct mm_struct {
>   		 */
>   		atomic_t mm_count;
>   
> -		/**
> -		 * @has_pinned: Whether this mm has pinned any pages.  This can
> -		 * be either replaced in the future by @pinned_vm when it
> -		 * becomes stable, or grow into a counter on its own. We're
> -		 * aggresive on this bit now - even if the pinned pages were
> -		 * unpinned later on, we'll still keep this bit set for the
> -		 * lifecycle of this mm just for simplicity.
> -		 */
> -		atomic_t has_pinned;
> -
>   		/**
>   		 * @write_protect_seq: Locked when any thread is write
>   		 * protecting pages mapped by this mm to enforce a later COW,
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index dfd82eab29025..4d9e3a6568758 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -73,6 +73,14 @@ static inline int get_dumpable(struct mm_struct *mm)
>   #define MMF_OOM_VICTIM		25	/* mm is the oom victim */
>   #define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
>   #define MMF_MULTIPROCESS	27	/* mm is shared between processes */
> +/*
> + * MMF_HAS_PINNED: Whether this mm has pinned any pages.  This can be either
> + * replaced in the future by mm.pinned_vm when it becomes stable, or grow into
> + * a counter on its own. We're aggresive on this bit for now: even if the
> + * pinned pages were unpinned later on, we'll still keep this bit set for the
> + * lifecycle of this mm, just for simplicity.
> + */
> +#define MMF_HAS_PINNED		28	/* FOLL_PIN has run, never cleared */
>   #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
>   
>   #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 502dc046fbc62..a71e73707ef59 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1026,7 +1026,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>   	mm_pgtables_bytes_init(mm);
>   	mm->map_count = 0;
>   	mm->locked_vm = 0;
> -	atomic_set(&mm->has_pinned, 0);
>   	atomic64_set(&mm->pinned_vm, 0);
>   	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
>   	spin_lock_init(&mm->page_table_lock);
> diff --git a/mm/gup.c b/mm/gup.c
> index 9933bc5c2eff2..bb130723a6717 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1270,6 +1270,17 @@ int fixup_user_fault(struct mm_struct *mm,
>   }
>   EXPORT_SYMBOL_GPL(fixup_user_fault);
>   
> +/*
> + * Set the MMF_HAS_PINNED if not set yet; after set it'll be there for the mm's
> + * lifecycle.  Avoid setting the bit unless necessary, or it might cause write
> + * cache bouncing on large SMP machines for concurrent pinned gups.
> + */
> +static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
> +{
> +       if (!test_bit(MMF_HAS_PINNED, mm_flags))
> +               set_bit(MMF_HAS_PINNED, mm_flags);
> +}
> +
>   /*
>    * Please note that this function, unlike __get_user_pages will not
>    * return 0 for nr_pages > 0 without FOLL_NOWAIT
> @@ -1292,8 +1303,8 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>   		BUG_ON(*locked != 1);
>   	}
>   
> -	if ((flags & FOLL_PIN) && !atomic_read(&mm->has_pinned))
> -		atomic_set(&mm->has_pinned, 1);
> +	if (flags & FOLL_PIN)
> +		mm_set_has_pinned_flag(&mm->flags);
>   
>   	/*
>   	 * FOLL_PIN and FOLL_GET are mutually exclusive. Traditional behavior
> @@ -2617,8 +2628,8 @@ static int internal_get_user_pages_fast(unsigned long start,
>   				       FOLL_FAST_ONLY)))
>   		return -EINVAL;
>   
> -	if ((gup_flags & FOLL_PIN) && !atomic_read(&current->mm->has_pinned))
> -		atomic_set(&current->mm->has_pinned, 1);
> +	if (gup_flags & FOLL_PIN)
> +		mm_set_has_pinned_flag(&current->mm->flags);
>   
>   	if (!(gup_flags & FOLL_FAST_ONLY))
>   		might_lock_read(&current->mm->mmap_lock);
> 
