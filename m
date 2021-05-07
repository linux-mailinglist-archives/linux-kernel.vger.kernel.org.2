Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018003760A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhEGGoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:44:03 -0400
Received: from mail-dm6nam08on2050.outbound.protection.outlook.com ([40.107.102.50]:11521
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233539AbhEGGoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:44:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7CQ/kPbF11YBorxpTvB63KHK/muLxeBw5QIVlzyRQKPvqEUQEH4VTdSHKthyBwYPNJgyawiQI+r+XTml8wWYr9OPRN6akn96dEUDuWLb2RfPcdMOeEgk3LfjTKlsYTFLFf9e3gt3kkFjREu1iUbH+wbzOh/+7WO2iGOhUvncdMHadrfeQ57pJllkZb87cNUZQRyZkNadAZDZ2f2Oc/7eeZrGSi090Os2Zq7DPYInC/MTpEM5kfNpM/rjiqmZX0bPaA1i2m+4S6o/ntbtAAOEF5NDAkXrL1KR67BCVB5He7J8DSBKki3JDJGXSSL7G9CKp3n8lwrsmYQgRnulZO1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrcOtjUBpWM9l2W+L6+7HPCix28Tpo67n+QkzHHaS2E=;
 b=RarInrux5mS02dAZ3rq2PFriVcHGRznAVtgSMHfngF77525ZJWoXY4cgEe5up4yb5IWHN6piF4NKcB/WBcZfWlNwZH56WobEcaAAxFIhbWksO2vpniMzntrpM7zqL4Js+7Ha8PefNiBbYm9K/bg5kTNuQdd9RNl9Z+h/D/P2MXc22kEHgSiboC3yz2KLoOSwdap7bGRIFj2EdpjnnCMcE39QAy07cR7mikv6tmHTtcB79Zr1x15MnnVdcfmuPDGiNY+Dew4q+3vih8Vki2oX/qys653PLN0wmvteJ2WfLDBiFRKdHPZFGa7UxaQRwR6jAV6kCZYvliG6A7EfMspH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrcOtjUBpWM9l2W+L6+7HPCix28Tpo67n+QkzHHaS2E=;
 b=RQua3OKy3Ipep1vtKaw50/ssxAoSqk7XWyyxSUQW33L5/xSSAZ32dy1hPjeRU540SruYMoNbYJRwy6O4j9QwcPdaEiPLKriMGoT9R+C7yvYkzQroDEqZZXVBYuYASHTtF8jpeQm9D4zdusDGgE7c02IyZ5Qac+hgLCjZRJyYLH8iYx8AJdWYUyfmMXJUNYm2PMUxljas98oBiHXMNUUNIXRGocV0q+gr3gtdvKoHEa/71pP/oZX14lNstBRMP7I0BVbzMIe3qoYNmW7BaqDYnIceUwJF8g5++wtf7lDx23jMoayI9o3cbcYnA+ruLFH8z63LcJdeQ7q3/r1M32OZtA==
Received: from MWHPR10CA0007.namprd10.prod.outlook.com (2603:10b6:301::17) by
 PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24; Fri, 7 May 2021 06:43:01 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::36) by MWHPR10CA0007.outlook.office365.com
 (2603:10b6:301::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 7 May 2021 06:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 06:43:00 +0000
Received: from [10.2.61.66] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 May
 2021 06:42:59 +0000
Subject: Re: [PATCH 3/3] mm: gup: pack has_pinned in MMF_HAS_PINNED
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Michal Hocko" <mhocko@suse.com>, Oleg Nesterov <oleg@redhat.com>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20210506232537.165788-1-peterx@redhat.com>
 <20210506232537.165788-4-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <69055843-185d-20ea-213b-10494a2f7246@nvidia.com>
Date:   Thu, 6 May 2021 23:42:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210506232537.165788-4-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13ff09c6-227b-49a3-edaf-08d911235b32
X-MS-TrafficTypeDiagnostic: PH0PR12MB5451:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5451C8D60B795D7A52AAB02EA8579@PH0PR12MB5451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/Xy1n8xgpk+9UD+8NQw06zpgosGCSx7COrPMJea49iWoH6sworWClD+A9RWIYZR37FFx0l98ofOrklDZyrzNnH5GbQOjumIxSf04qjkw2GNRJaCGqZMa6paJ4uNxmajitRaSGSsPsqfPr11smW8h3ByiXpznOuNG0wQCtjlgXnx+lZcjt/m3WENnFuTedis8QmDSBR4ZwFRd3LPujiCDPMlk9yVgpy88wxlk5BD/QYgHfY92RE9btozu9+IVD8QoaoFQZcUQIk+qR8Nf6zMMds/omRN6wgcEV5CD1jhKJLIx+gSUimby9pXcPIfGwuBHgGn8Arynt/5Bg5b+J7BWs46XB1y61OFbJETcz5FkrrvGZMLWcfJNrxPnxAyOVTDgEuvEtzh1AgVq39IZ/MgwHVPCf8+dsvonuDsjayefTQVS6D5iAvz5duP98oZvmGw/qoKbsaR8D7Y59zhcamTzKZe6VnaZ8LMEqiuWUpCzAR2DzaWvksN3PgPBZNOhNJ4SyA3dUcbD6phsMKRYXqwVUrJw4xopotB9D8oE69vxxcsgL0LD+40bh66pCoZzhja6r0X5Jp5+m7h/4xGEQVRyckiK6nWBT0fxj8u47ghEaxLRGp9PlWk7Pu8+FhsKKzWB6NFm8/h/pANMcbzZoYqVMH+phj28wogJV7tNgaXgIw4yigI3AfKu1hxduHwspLkla+c5712cx6XrqtYwtUScA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(46966006)(336012)(16526019)(426003)(4326008)(36860700001)(186003)(7416002)(82310400003)(2906002)(5660300002)(8936002)(36756003)(26005)(83380400001)(47076005)(316002)(36906005)(82740400003)(70206006)(54906003)(110136005)(16576012)(31696002)(86362001)(70586007)(7636003)(8676002)(478600001)(2616005)(31686004)(356005)(53546011)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 06:43:00.0088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ff09c6-227b-49a3-edaf-08d911235b32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/21 4:25 PM, Peter Xu wrote:
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

It's nice that you spelled that out. I don't see any technical problems
with the diffs. There are a couple of tiny suggestions, below.

> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> [peterx: Fix build for task_mmu.c]
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   fs/proc/task_mmu.c             |  2 +-
>   include/linux/mm.h             |  2 +-
>   include/linux/mm_types.h       | 10 ----------
>   include/linux/sched/coredump.h |  1 +
>   kernel/fork.c                  |  1 -
>   mm/gup.c                       |  9 +++++----
>   6 files changed, 8 insertions(+), 17 deletions(-)
> 
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
> index dfd82eab29025..bf45badd63e6d 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -73,6 +73,7 @@ static inline int get_dumpable(struct mm_struct *mm)
>   #define MMF_OOM_VICTIM		25	/* mm is the oom victim */
>   #define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
>   #define MMF_MULTIPROCESS	27	/* mm is shared between processes */
> +#define MMF_HAS_PINNED		28	/* FOLL_PIN has run, never cleared */

How about this instead, so that we effectively retain the comment block
that is otherwise being deleted from mm.h:

/*
  * MMF_HAS_PINNED: Whether this mm has pinned any pages.  This can be either
  * replaced in the future by mm.pinned_vm when it becomes stable, or grow into a
  * counter on its own. We're aggresive on this bit for now: even if the pinned
  * pages were unpinned later on, we'll still keep this bit set for the lifecycle
  * of this mm, just for simplicity.
  */
#define MMF_HAS_PINNED		28	/* FOLL_PIN ran. Never cleared. */


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
> index 8b513e1723b45..78416b0909873 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1292,8 +1292,8 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>   		BUG_ON(*locked != 1);
>   	}
>   
> -	if (flags & FOLL_PIN && !atomic_read(&mm->has_pinned))
> -		atomic_set(&mm->has_pinned, 1);
> +	if (flags & FOLL_PIN && !test_bit(MMF_HAS_PINNED, &mm->flags))
> +		set_bit(MMF_HAS_PINNED, &mm->flags);

I expect this suggestion to be controversial, but I'm going to float it
anyway. The above is a little less clear than it used to be, *and* it is
in two places so far, so how about factoring out a tiny subroutine, like this:

diff --git a/mm/gup.c b/mm/gup.c
index 036ab0de9457..2dc001a7c850 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1270,6 +1270,16 @@ int fixup_user_fault(struct mm_struct *mm,
}
EXPORT_SYMBOL_GPL(fixup_user_fault);

+static void set_mm_has_pinned_flag(unsigned long *mm_flags)
+{
+       /*
+        * Avoid setting the bit unless necessary. This matters a lot with
+        * large SMP machines.
+        */
+       if (!test_bit(MMF_HAS_PINNED, mm_flags))
+               set_bit(MMF_HAS_PINNED, mm_flags);
+}
+
/*
* Please note that this function, unlike __get_user_pages will not
* return 0 for nr_pages > 0 without FOLL_NOWAIT
@@ -1292,8 +1302,8 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
BUG_ON(*locked != 1);
}

-       if (flags & FOLL_PIN && !test_bit(MMF_HAS_PINNED, &mm->flags))
-               set_bit(MMF_HAS_PINNED, &mm->flags);
+       if (flags & FOLL_PIN)
+               set_mm_has_pinned_flag(&mm->flags);

...which is now very readable, once again.

>   
>   	/*
>   	 * FOLL_PIN and FOLL_GET are mutually exclusive. Traditional behavior
> @@ -2617,8 +2617,9 @@ static int internal_get_user_pages_fast(unsigned long start,
>   				       FOLL_FAST_ONLY)))
>   		return -EINVAL;
>   
> -	if (gup_flags & FOLL_PIN && !atomic_read(&current->mm->has_pinned))
> -		atomic_set(&current->mm->has_pinned, 1);
> +	if (gup_flags & FOLL_PIN &&
> +	    !test_bit(MMF_HAS_PINNED, &current->mm->flags))
> +		set_bit(MMF_HAS_PINNED, &current->mm->flags);
>   
>   	if (!(gup_flags & FOLL_FAST_ONLY))
>   		might_lock_read(&current->mm->mmap_lock);
> 

thanks,
-- 
John Hubbard
NVIDIA
