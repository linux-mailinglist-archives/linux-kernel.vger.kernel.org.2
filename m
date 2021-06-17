Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361EB3AAF36
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhFQJB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:01:26 -0400
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:53600
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231319AbhFQJBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx1ekC1eXXd1eYBjBQREKiW39XN0WAkmsP6tIVBfPIJIWh05I+nq03mapTqcfd0jW+dRd3EA+3ARr+/O33JAiGjK8kOGSineA5QlTYPSVC3TmH8JH/S0Zdok27SQc70n3gONHI3vVTS9EjkRodDimuqN39w75+/I2yi6uL2m9OoS7L938nSU4Vpe7oDEUmrJw/IxLEONcxJNTC+XUgharn80DWPRVZOxrKs9F5Xv7UdTsCyL5HvRqmQp4ilzQX+rU9jceEFbU0aglK46S9/PUN3M3xFtJkaAztLay80v0gF0FnRDq7wNGkBSWa+u6/GTXgq7+EpuELNZD3XibpMEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DeZzsNJhzFezhe8zlcoSyeSF/V7Ip3lz/cfpMuWGxY=;
 b=UXI6ML2RoAq7dh8zHmuSWOgVNfChq+Fah4rnzn2k2hcRvhV0kOJ1C9g9ktfHnxZSxS+V6yxVurWtPjTQhRXhId+WRXHdOKoURxzzr8kB8b0W/77hHYFprZaRrmokaEYQVw2j5NMJkpDbwtGbkUilX+WCpyZP5BQhUgAFP10QUI48YamUc0+cw6Gzi4h0yZXHMAZpVXJGBOwi6N0PjiBnGUaaF8lUMpkapUX6iQ8WgQb6lADhfWLa3WOGLa0R9kTD6pZEgsxWwdOX1RFnzTH6swmtwRolVFK/eCEUxNAaNyD0QvY5H/0Zgwii7SCD8F0tl/ef/1kqN5yqdbFSYhHkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DeZzsNJhzFezhe8zlcoSyeSF/V7Ip3lz/cfpMuWGxY=;
 b=bC9KPGlaREa1DeJNxxVlGKnVRGYGAcEMtRevdh0Ocp82kLUz5/FNgU7e7R25l/zS7OGjjYol3tfOo6/ORqbwNB57Y35CDOPidPRu52g1+m6Z3dWiHNtxhWHxku9w8CF9VxTQor2urdG6kJhiRtpy7NoioWjE7cvbVHTfBgh3Kj+CPODG8MguleIYtqPON8p7jp5PgTb/5OsqV01SZzM1X3q1WqEk95wmVDQ6kmIPtjKHYDIoj2168/SpWpu6c1nvb2x6us0uExgkxD1yTX62X7wNRjNrYQSelHKF/OqzWTEGHF68nmtutb47BKoJM9C43OYu7ikzRYPIu6XZeGwhGw==
Received: from MWHPR1701CA0009.namprd17.prod.outlook.com
 (2603:10b6:301:14::19) by DM6PR12MB3770.namprd12.prod.outlook.com
 (2603:10b6:5:1c4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 08:59:15 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::c7) by MWHPR1701CA0009.outlook.office365.com
 (2603:10b6:301:14::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Thu, 17 Jun 2021 08:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 08:59:15 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Jun
 2021 08:59:12 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 06/27] shmem/userfaultfd: Handle uffd-wp special pte in page fault handler
Date:   Thu, 17 Jun 2021 18:59:09 +1000
Message-ID: <5906045.o7RC9TDvkT@nvdebian>
In-Reply-To: <20210527202122.30739-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com> <20210527202122.30739-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06354ccf-e083-4659-aeef-08d9316e2f00
X-MS-TrafficTypeDiagnostic: DM6PR12MB3770:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37705BDB818A5A1AF6F4103EDF0E9@DM6PR12MB3770.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jt+XbQbPawDZjsymWyvnro1rLQZ3i0c2/49DiXXi5VgbkPem4lLiuqdmnnpTkBHYIetLifzTG9Z1MRWAVD30lclo10KBb3yfk2Zfu3lmqhbfWJQ6/cT4XZPOfRg87zqNcZDYOE1ApW7Vnjxi9ujJ/TyUUzVSV1dJdxJDKLr2aJjzeCAuqMXm2q34Olfb19WMWn4LRbE5iAG4/1dA42R8LPvQBAf/ZEKpggFVjqTkxWb1Bnda7UzvDU2vmtdRpMmpURhJc18U3fU9C1pII0YOfMkywXHWgtpaDuBPv+E7168u0o52IhKynUddQGJomA5PYoSeSYMr+mzWBRt3Zp4e7RbzJ/d4q/zICIg9URDYQd1EaTSWMVmvOeiczrzbJ6O+kZ1C324gV/CreOznzOXRLP2yoTDfsDUX1Jes8lUJqKt2/WiWvEWJPLt5DvPJPpgJk5IC/c3iFfRb8xaPreBl/mDpEhqkFlRoPLBxtETe/9JvEtzArdQIRThKnKf8fKGJSbGcBvlIXi7IyIzctPxDqiByRpZpK1TcPIq9xaG7fQj9EKWKTbGkbPk6tSfpZDDvVUiGtZto6Ue+kX0t+hGh3PJC3NliN7d2obG7TGyalnWfyNKalHdbm013TQvRz+RUuFbGo7mOv2eyxBksvkXFmpI6bDxJvm7RzF6rZO1zBfh0z4DFFiYo6Ncnblt6FmsO
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39850400004)(396003)(376002)(36840700001)(46966006)(16526019)(82740400003)(7416002)(6916009)(36906005)(6666004)(186003)(70586007)(33716001)(7636003)(316002)(26005)(86362001)(356005)(2906002)(9686003)(70206006)(83380400001)(5660300002)(47076005)(54906003)(82310400003)(8676002)(9576002)(478600001)(336012)(4326008)(426003)(36860700001)(8936002)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 08:59:15.2864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06354ccf-e083-4659-aeef-08d9316e2f00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 28 May 2021 6:21:22 AM AEST Peter Xu wrote:
> File-backed memories are prone to unmap/swap so the ptes are always unstable.
> This could lead to userfaultfd-wp information got lost when unmapped or swapped
> out on such types of memory, for example, shmem.  To keep such an information
> persistent, we will start to use the newly introduced swap-like special ptes to
> replace a null pte when those ptes were removed.
> 
> Prepare this by handling such a special pte first before it is applied in the
> general page fault handler.
> 
> The handling of this special pte page fault is similar to missing fault, but it
> should happen after the pte missing logic since the special pte is designed to
> be a swap-like pte.  Meanwhile it should be handled before do_swap_page() so
> that the swap core logic won't be confused to see such an illegal swap pte.
> 
> This is a slow path of uffd-wp handling, because unmap of wr-protected shmem
> ptes should be rare.  So far it should only trigger in two conditions:
> 
>   (1) When trying to punch holes in shmem_fallocate(), there will be a
>       pre-unmap optimization before evicting the page.  That will create
>       unmapped shmem ptes with wr-protected pages covered.
> 
>   (2) Swapping out of shmem pages
> 
> Because of this, the page fault handling is simplifed too by not sending the
> wr-protect message in the 1st page fault, instead the page will be installed
> read-only, so the message will be generated until the next write, which will
> trigger the do_wp_page() path of general uffd-wp handling.
> 
> Disable fault-around for all uffd-wp registered ranges for extra safety, and
> clean the code up a bit after we introduced MINOR fault.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/userfaultfd_k.h | 12 +++++
>  mm/memory.c                   | 88 +++++++++++++++++++++++++++++++----
>  2 files changed, 90 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 93f932b53a71..ca3f794d07e9 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -94,6 +94,18 @@ static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
>  	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
>  }
>  
> +/*
> + * Don't do fault around for either WP or MINOR registered uffd range.  For
> + * MINOR registered range, fault around will be a total disaster and ptes can
> + * be installed without notifications; for WP it should mostly be fine as long
> + * as the fault around checks for pte_none() before the installation, however
> + * to be super safe we just forbid it.
> + */
> +static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
> +{
> +	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
> +}
> +
>  static inline bool userfaultfd_missing(struct vm_area_struct *vma)
>  {
>  	return vma->vm_flags & VM_UFFD_MISSING;
> diff --git a/mm/memory.c b/mm/memory.c
> index 2b24af4616df..45a2f71e447a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3917,6 +3917,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	bool uffd_wp = pte_swp_uffd_wp_special(vmf->orig_pte);
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
>  	bool prefault = vmf->address != addr;
>  	pte_t entry;
> @@ -3929,6 +3930,8 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>  
>  	if (write)
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +	if (unlikely(uffd_wp))
> +		entry = pte_mkuffd_wp(pte_wrprotect(entry));
>  	/* copy-on-write page */
>  	if (write && !(vma->vm_flags & VM_SHARED)) {
>  		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
> @@ -3996,8 +3999,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>  				      vmf->address, &vmf->ptl);
>  	ret = 0;
> -	/* Re-check under ptl */
> -	if (likely(pte_none(*vmf->pte)))
> +
> +	/*
> +	 * Re-check under ptl.  Note: this will cover both none pte and
> +	 * uffd-wp-special swap pte
> +	 */
> +	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
>  		do_set_pte(vmf, page, vmf->address);
>  	else
>  		ret = VM_FAULT_NOPAGE;
> @@ -4101,9 +4108,21 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
>  	return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
>  }
>  
> +/* Return true if we should do read fault-around, false otherwise */
> +static inline bool should_fault_around(struct vm_fault *vmf)
> +{
> +	/* No ->map_pages?  No way to fault around... */
> +	if (!vmf->vma->vm_ops->map_pages)
> +		return false;
> +
> +	if (uffd_disable_fault_around(vmf->vma))
> +		return false;
> +
> +	return fault_around_bytes >> PAGE_SHIFT > 1;
> +}
> +
>  static vm_fault_t do_read_fault(struct vm_fault *vmf)
>  {
> -	struct vm_area_struct *vma = vmf->vma;
>  	vm_fault_t ret = 0;
>  
>  	/*
> @@ -4111,12 +4130,10 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
>  	 * if page by the offset is not ready to be mapped (cold cache or
>  	 * something).
>  	 */
> -	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
> -		if (likely(!userfaultfd_minor(vmf->vma))) {
> -			ret = do_fault_around(vmf);
> -			if (ret)
> -				return ret;
> -		}
> +	if (should_fault_around(vmf)) {
> +		ret = do_fault_around(vmf);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	ret = __do_fault(vmf);
> @@ -4435,6 +4452,57 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
>  	return VM_FAULT_FALLBACK;
>  }
>  
> +static vm_fault_t uffd_wp_clear_special(struct vm_fault *vmf)
> +{
> +	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> +				       vmf->address, &vmf->ptl);
> +	/*
> +	 * Be careful so that we will only recover a special uffd-wp pte into a
> +	 * none pte.  Otherwise it means the pte could have changed, so retry.
> +	 */
> +	if (pte_swp_uffd_wp_special(*vmf->pte))
> +		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
> +	pte_unmap_unlock(vmf->pte, vmf->ptl);
> +	return 0;
> +}
> +
> +/*
> + * This is actually a page-missing access, but with uffd-wp special pte
> + * installed.  It means this pte was wr-protected before being unmapped.
> + */
> +static vm_fault_t uffd_wp_handle_special(struct vm_fault *vmf)
> +{
> +	/* Careful!  vmf->pte unmapped after return */
> +	if (!pte_unmap_same(vmf))
> +		return 0;
> +
> +	/*
> +	 * Just in case there're leftover special ptes even after the region
> +	 * got unregistered - we can simply clear them.
> +	 */
> +	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
> +		return uffd_wp_clear_special(vmf);
> +
> +	/*
> +	 * Here we share most code with do_fault(), in which we can identify
> +	 * whether this is "none pte fault" or "uffd-wp-special fault" by
> +	 * checking the vmf->orig_pte.
> +	 */
> +	return do_fault(vmf);
> +}
> +
> +static vm_fault_t do_swap_pte(struct vm_fault *vmf)
> +{
> +	/*
> +	 * We need to handle special swap ptes before handling ptes that
> +	 * contain swap entries, always.
> +	 */
> +	if (unlikely(pte_swp_uffd_wp_special(vmf->orig_pte)))
> +		return uffd_wp_handle_special(vmf);
> +
> +	return do_swap_page(vmf);

Probably pretty minor in the scheme of things but why not add this special
case directly to do_swap_page()? Your earlier "shmem/userfaultfd: Handle
uffd-wp special pte in page fault handler" adds this to do_swap_page()
anyway:

	/*
	 * We should never call do_swap_page upon a swap special pte; just be
	 * safe to bail out if it happens.
	 */
	if (WARN_ON_ONCE(is_swap_special_pte(vmf->orig_pte)))
		goto out;

So this patch could instead replace the warning with the call to
uffd_wp_handle_special(), which also means you can remove the extra
pte_unmap_same(vmf) check in uffd_wp_handle_special().

I suppose you might have to worry about other callers of do_swap_page(),
but the only other one I could see was __collapse_huge_page_swapin().
Initially I thought that might be able to trigger the warning here but I
see it checks pte_has_swap_entry() first which should skip it if it finds
the special pte.

 - Alistair

> +}
> +
>  /*
>   * These routines also need to handle stuff like marking pages dirty
>   * and/or accessed for architectures that don't do it in hardware (most
> @@ -4509,7 +4577,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  	}
>  
>  	if (!pte_present(vmf->orig_pte))
> -		return do_swap_page(vmf);
> +		return do_swap_pte(vmf);
>  
>  	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
>  		return do_numa_page(vmf);
> 




