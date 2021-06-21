Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30433AE51E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFUInj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:43:39 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:53824
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229908AbhFUInh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:43:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNjxxp5GGzUkpguOgJu0KuJJTzlbBYZ/XzemQ8x+AykvM93N2H7KRTaGXa5HjimeGIjq7kmr0vh49rfnYXe4PjUZFSDssTwUnG7s8qQYU9Yffpc+FxytFMI9UQMABGKScRTo/T16DqyNJGA94V9PIS1Q8yRfyEvcBZCpRVX3acGFqDqNidjCrdatT15gJ+blMRuao7iscPqlDo64wJqE+yZ8VmTVhzNXOJoyhy031K+M9g/Ums8bKVXLSpGJG2UJC5vkvsjCMnbDhsUxlozAuEEUGRLhxBQiW1m/p+qfUTfG8Y6qsxM7cYgKCtd2jDJ8AEqHibIm32nokJnt8HnZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw3DO51m3L+BnD+dgYopiG33rc8kn7rNenstdKoGa6s=;
 b=VFAT1R5TiF1okD+8sNMGcfAYgLd+byAkpRB9QHFvJwi7bjaxy3lR8d1xM6knIKxFKvzUu4OUCdLPGgX8Zr74UgGlX+U7J0/Qm4X0JIKr+/IyJf9wStowhJAJ86BMLivlumQpVZsypWlWl21fl5blCWoF4RCXoXLvVCVDOb+eJseqnWmBTxRbGQMkaz9OALqdvNvYjf/sjkWVoxraRbnsw2r78N0JvpxnV9RMaZ4jth69SrkTNUjSw/u7/TzIGMUFUKaZW+JX2aCN8G4O63KxqktFD2yu4SRyjB3qM806nN83rwq9gYezAfJNEhD0zABVmMciugfwbF+2ZwsUbVWvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw3DO51m3L+BnD+dgYopiG33rc8kn7rNenstdKoGa6s=;
 b=IJFb3g4nZ1XLD1oX/QVESifNs2Wr17eOEBCPPlLCfMm5iLq/dQxfvlmcW1ul4f3LLF2GmBkMtDF3WXrvfuEymYUptHUSd7Lf4PWYPfvnc3/IfCKy/6wG5CcQVAgHpG8POwOoriPuARjUeR2s31mrfmCCUL+Cj35upv2zkB8wZA+YuVZxhvoe6y6Iu99UIAQF/KUNPy6U7kh87G2NVxam99VyT10joUkxyZyQEUN+rCaROwN///ywjhAW/x9nAIjrMMhfKNqxVBMusGdgOKVxbSUpuMu0/gr3RWHjoPSmNULc3xJk3yN5WrTJiRETwCZmSzhk+XTW9k3a2YeHY+qiqg==
Received: from DM5PR04CA0071.namprd04.prod.outlook.com (2603:10b6:3:ef::33) by
 DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18; Mon, 21 Jun 2021 08:41:22 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::f8) by DM5PR04CA0071.outlook.office365.com
 (2603:10b6:3:ef::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Mon, 21 Jun 2021 08:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 08:41:22 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Jun
 2021 08:41:19 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 11/27] shmem/userfaultfd: Persist uffd-wp bit across zapping for file-backed
Date:   Mon, 21 Jun 2021 18:41:17 +1000
Message-ID: <2098802.ffhGrX9TH4@nvdebian>
In-Reply-To: <20210527202214.31319-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com> <20210527202214.31319-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3edc119c-65f2-44a6-620f-08d93490590b
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5400508B273974EAD15961A5DF0A9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWEM1P1fuhIVUzMLPqlW6P/r2O1pl/NHS/g4fOvCOZ1v6HjbRCo6JRvGXTGxbdok1uvqC7ns6jjQyi/sfCotTV5WoAL3TEOplrSEi6vvo2humFvgzaMZlZNgmvP19TzRU6I0b46XZ7ZweALRh7WTMKdho3cyI65xvtr8TtdSUBU839p7FT6tT4ECMKAK2yYMBYoI834+a2HHU1r0h4WFrJJzVcuYuci7FkYK+aosSHqnDrBLrE5hUePvyTdHH9DzmLZS0GVS5EttMqN+krCffUS9Z0ofF5mieLo4sge5xonShu8SQCyKZC4fLfskn6odMIlYpikhPiYG/DYjEI0ukN53vgcWSFoVg+j15Iud93bzei5AxFoAgDiTs7cI5UzKvO1WlOXHnrXppbMXQxGk9qpRuW09gHg293Sma5I6TEvJGymjzPIKmtfhq86QLmCjfc1M14pbLAIzN7xob/ONqfDCC74lfvD62rMaOc3E6iFCtzQv4pJXXjrQQO+UACTHj9M6gM/ED/SgpDhoB8NUi7/bfGCYRJD8vgHtCLZhNAtIzoEppdViS5W8oLOah8ZMDHb3hqncZ2CloZYl9EPstld+r02aYqz05oSQvwM0FxXnHtsGdsIzv/gGfL4lFds95ZQk6yeTvGilzRGL44Pa5/jNg18DgvOM16/KlqQK+fvTuVCqHVZ+rlKWvQ3LlojQ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(36840700001)(16526019)(82310400003)(356005)(6916009)(186003)(7416002)(2906002)(26005)(5660300002)(7636003)(426003)(9686003)(70206006)(36906005)(33716001)(8936002)(30864003)(478600001)(8676002)(36860700001)(4326008)(336012)(316002)(54906003)(82740400003)(70586007)(83380400001)(47076005)(9576002)(86362001)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 08:41:22.2449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edc119c-65f2-44a6-620f-08d93490590b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5400
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 28 May 2021 6:22:14 AM AEST Peter Xu wrote:
> File-backed memory is prone to being unmapped at any time.  It means all
> information in the pte will be dropped, including the uffd-wp flag.
> 
> Since the uffd-wp info cannot be stored in page cache or swap cache, persist
> this wr-protect information by installing the special uffd-wp marker pte when
> we're going to unmap a uffd wr-protected pte.  When the pte is accessed again,
> we will know it's previously wr-protected by recognizing the special pte.
> 
> Meanwhile add a new flag ZAP_FLAG_DROP_FILE_UFFD_WP when we don't want to
> persist such an information.  For example, when destroying the whole vma, or
> punching a hole in a shmem file.  For the latter, we can only drop the uffd-wp
> bit when holding the page lock.  It means the unmap_mapping_range() in
> shmem_fallocate() still reuqires to zap without ZAP_FLAG_DROP_FILE_UFFD_WP
> because that's still racy with the page faults.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm.h        | 11 ++++++++++
>  include/linux/mm_inline.h | 43 +++++++++++++++++++++++++++++++++++++++
>  mm/memory.c               | 42 +++++++++++++++++++++++++++++++++++++-
>  mm/rmap.c                 |  8 ++++++++
>  mm/truncate.c             |  8 +++++++-
>  5 files changed, 110 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b1fb2826e29c..5989fc7ed00d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1725,6 +1725,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
>  #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
>  /* Whether to skip zapping swap entries */
>  #define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
> +/* Whether to completely drop uffd-wp entries for file-backed memory */
> +#define  ZAP_FLAG_DROP_FILE_UFFD_WP         BIT(2)
>  
>  /*
>   * Parameter block passed down to zap_pte_range in exceptional cases.
> @@ -1757,6 +1759,15 @@ zap_skip_swap(struct zap_details *details)
>  	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
>  }
>  
> +static inline bool
> +zap_drop_file_uffd_wp(struct zap_details *details)
> +{
> +	if (!details)
> +		return false;
> +
> +	return details->zap_flags & ZAP_FLAG_DROP_FILE_UFFD_WP;
> +}

Is this a good default having to explicitly specify that you don't want
special pte's left in place? For example the OOM killer seems to call
unmap_page_range() with details == NULL (although in practice only for
anonymous vmas so it wont actually cause an issue). Similarly in madvise
for MADV_DONTNEED, although arguably I suppose that is the correct thing to
do there?

>  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t pte);
>  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 355ea1ee32bd..c29a6ef3a642 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -4,6 +4,8 @@
>  
>  #include <linux/huge_mm.h>
>  #include <linux/swap.h>
> +#include <linux/userfaultfd_k.h>
> +#include <linux/swapops.h>
>  
>  /**
>   * page_is_file_lru - should the page be on a file LRU or anon LRU?
> @@ -104,4 +106,45 @@ static __always_inline void del_page_from_lru_list(struct page *page,
>  	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
>  			-thp_nr_pages(page));
>  }
> +
> +/*
> + * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
> + * replace a none pte.  NOTE!  This should only be called when *pte is already
> + * cleared so we will never accidentally replace something valuable.  Meanwhile
> + * none pte also means we are not demoting the pte so if tlb flushed then we
> + * don't need to do it again; otherwise if tlb flush is postponed then it's
> + * even better.
> + *
> + * Must be called with pgtable lock held.
> + */
> +static inline void
> +pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
> +			      pte_t *pte, pte_t pteval)
> +{
> +#ifdef CONFIG_USERFAULTFD
> +	bool arm_uffd_pte = false;
> +
> +	/* The current status of the pte should be "cleared" before calling */
> +	WARN_ON_ONCE(!pte_none(*pte));
> +
> +	if (vma_is_anonymous(vma))
> +		return;
> +
> +	/* A uffd-wp wr-protected normal pte */
> +	if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
> +		arm_uffd_pte = true;
> +
> +	/*
> +	 * A uffd-wp wr-protected swap pte.  Note: this should even work for
> +	 * pte_swp_uffd_wp_special() too.
> +	 */

I'm probably missing something but when can we actually have this case and why
would we want to leave a special pte behind? From what I can tell this is
called from try_to_unmap_one() where this won't be true or from zap_pte_range()
when not skipping swap pages.

> +	if (unlikely(is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)))
> +		arm_uffd_pte = true;
> +
> +	if (unlikely(arm_uffd_pte))
> +		set_pte_at(vma->vm_mm, addr, pte,
> +			   pte_swp_mkuffd_wp_special(vma));
> +#endif
> +}
> +
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index 319552efc782..3453b8ae5f4f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -73,6 +73,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/ptrace.h>
>  #include <linux/vmalloc.h>
> +#include <linux/mm_inline.h>
>  
>  #include <trace/events/kmem.h>
>  
> @@ -1298,6 +1299,21 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>  	return ret;
>  }
>  
> +/*
> + * This function makes sure that we'll replace the none pte with an uffd-wp
> + * swap special pte marker when necessary. Must be with the pgtable lock held.
> + */
> +static inline void
> +zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
> +			      unsigned long addr, pte_t *pte,
> +			      struct zap_details *details, pte_t pteval)
> +{
> +	if (zap_drop_file_uffd_wp(details))
> +		return;
> +
> +	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
> +}
> +
>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  				struct vm_area_struct *vma, pmd_t *pmd,
>  				unsigned long addr, unsigned long end,
> @@ -1335,6 +1351,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			ptent = ptep_get_and_clear_full(mm, addr, pte,
>  							tlb->fullmm);
>  			tlb_remove_tlb_entry(tlb, pte, addr);
> +			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> +						      ptent);
>  			if (unlikely(!page))
>  				continue;
>  
> @@ -1359,6 +1377,22 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			continue;
>  		}
>  
> +		/*
> +		 * If this is a special uffd-wp marker pte... Drop it only if
> +		 * enforced to do so.
> +		 */
> +		if (unlikely(is_swap_special_pte(ptent))) {
> +			WARN_ON_ONCE(!pte_swp_uffd_wp_special(ptent));

Why the WARN_ON and not just test pte_swp_uffd_wp_special() directly?

> +			/*
> +			 * If this is a common unmap of ptes, keep this as is.
> +			 * Drop it only if this is a whole-vma destruction.
> +			 */
> +			if (zap_drop_file_uffd_wp(details))
> +				ptep_get_and_clear_full(mm, addr, pte,
> +							tlb->fullmm);
> +			continue;
> +		}
> +
>  		entry = pte_to_swp_entry(ptent);
>  		if (is_device_private_entry(entry) ||
>  		    is_device_exclusive_entry(entry)) {
> @@ -1373,6 +1407,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  				page_remove_rmap(page, false);
>  
>  			put_page(page);
> +			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> +						      ptent);

Device entries only support anonymous vmas at present so should we drop this?
I guess I'm also a little confused by this because I'm not sure in what
scenarios you would want to zap swap entries but leave special swap ptes behind
(see also my earlier question above as well).

>  			continue;
>  		}
>  
> @@ -1390,6 +1426,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  		if (unlikely(!free_swap_and_cache(entry)))
>  			print_bad_pte(vma, addr, ptent, NULL);
>  		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> +		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
>  	} while (pte++, addr += PAGE_SIZE, addr != end);
>  
>  	add_mm_rss_vec(mm, rss);
> @@ -1589,12 +1626,15 @@ void unmap_vmas(struct mmu_gather *tlb,
>  		unsigned long end_addr)
>  {
>  	struct mmu_notifier_range range;
> +	struct zap_details details = {
> +		.zap_flags = ZAP_FLAG_DROP_FILE_UFFD_WP,
> +	};
>  
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
>  				start_addr, end_addr);
>  	mmu_notifier_invalidate_range_start(&range);
>  	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
> -		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
> +		unmap_single_vma(tlb, vma, start_addr, end_addr, &details);
>  	mmu_notifier_invalidate_range_end(&range);
>  }
>  
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 0419c9a1a280..a94d9aed9d95 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -72,6 +72,7 @@
>  #include <linux/page_idle.h>
>  #include <linux/memremap.h>
>  #include <linux/userfaultfd_k.h>
> +#include <linux/mm_inline.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -1509,6 +1510,13 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  			pteval = ptep_clear_flush(vma, address, pvmw.pte);
>  		}
>  
> +		/*
> +		 * Now the pte is cleared.  If this is uffd-wp armed pte, we
> +		 * may want to replace a none pte with a marker pte if it's
> +		 * file-backed, so we don't lose the tracking information.
> +		 */
> +		pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);

From what I can tell we don't need to do this in try_to_migrate_one() (assuming
that goes in) as well because the existing uffd wp code already deals with
copying the pte bits over to the migration entries. Is that correct?

> +
>  		/* Move the dirty bit to the page. Now the pte is gone. */
>  		if (pte_dirty(pteval))
>  			set_page_dirty(page);
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 85cd84486589..62f9c488b986 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -173,7 +173,13 @@ truncate_cleanup_page(struct address_space *mapping, struct page *page)
>  	if (page_mapped(page)) {
>  		unsigned int nr = thp_nr_pages(page);
>  		unmap_mapping_pages(mapping, page->index, nr,
> -				    ZAP_FLAG_CHECK_MAPPING);
> +				    ZAP_FLAG_CHECK_MAPPING |
> +				    /*
> +				     * Now it's safe to drop uffd-wp because
> +				     * we're with page lock, and the page is
> +				     * being truncated.
> +				     */
> +				    ZAP_FLAG_DROP_FILE_UFFD_WP);
>  	}
>  
>  	if (page_has_private(page))
> 




