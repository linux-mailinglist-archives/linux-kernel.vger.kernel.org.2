Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BCC3BC624
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 07:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhGFFna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 01:43:30 -0400
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com ([40.107.236.55]:46688
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230004AbhGFFn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 01:43:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGB6Pvz3Kim6wDwqH5g9vEdnIQWMkqRd4a2oXl2mLBzz0tNV2qsTw/DtWdgUwaIt6P3uAsJaxdo7hOcQzzDzh413jPTf7NELWPLAqSVGJ3fvY/uz5El1SjThOcxzAGYJMm9NcGRvWCWxTrczSJ/YdLLWsr3yvwuMKiu3eV+cG8eQiuUgkLZTMn9wJ2SE5RCqD6eWBiluI+g5HBDX3tPnZqdX9B9liV6DEv4GyzI5Y/Ce1u3fOWSbiyfbLmOf4dTzbzi7d8BQedPyVkK3bqIUmIK0oDt+zHl710SH7UPgnOLnb8urFL2UV1rhsd9bBb8BwIiILDbbbNqq16F+/SJcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUFiTPsNXlX35c9H2DWeyaNqM/TSKSbfi7kcgR/RRNI=;
 b=PfN1dcGmC5bbzMxga7tUmCnbYZ8djAWj7Mprk8K5v+GO+KXPxVvrNng6QjCVfNdQKv5FZSD3E9/TLwe1xt+sCvdBMI/xGaF7zxLDc4SPKZbim7kH1GLNVqoATmghRHmV85KltDoc+6gf51IAkht5ejnVgNOjKRid8WKW4apPG+P54OFopuE48yGWA0NjyUR3q6zOclejuQTlZmg+23F4GsltMoQmtaKFiTqVknpudxH0cAZWgeABc+L0By3MomfJbURENDouaFdItZboFN+UJu+nvHvLFCu5nYp7xqJvaUxK3sTMn3uNvhX4YnW8nyHtx50JEbPbVLyMQJpeqbZ5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUFiTPsNXlX35c9H2DWeyaNqM/TSKSbfi7kcgR/RRNI=;
 b=FXSiariL3pjWy9t8RwxMoZMNyIZ60CTOjyj2lXQdud2TlcSpKfPGwGaHYE7POpUQWzrKl2j/PuzM2RK/LOxTawMR7ugLKwvPCH/biNpsxApf0B6SJb/kryLT1pI3u5V/rx2uko4nDm+5fRUnmV2I5dtgUDhqRhGfGWmUZPYS4tPaHUKN1ttB7ModSwMItzmYT12Vn9LMTg03FiNiUG9/KJ6LlUL7DluYUDx7K/SRAYNOAW0DIlXnRHnDqvQc5fUm3CvbAmU/p4nzjgRYZ2rP4sNE0LxTQRFfQ0BCwLIfXWj/tJJOaH+6E+Inxq0xeD9Ul5uxnGv0hZatiTbtSB8z9g==
Received: from BN8PR16CA0035.namprd16.prod.outlook.com (2603:10b6:408:4c::48)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Tue, 6 Jul
 2021 05:40:48 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::d2) by BN8PR16CA0035.outlook.office365.com
 (2603:10b6:408:4c::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Tue, 6 Jul 2021 05:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 05:40:48 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Jul
 2021 05:40:44 +0000
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
Date:   Tue, 6 Jul 2021 15:40:42 +1000
Message-ID: <3895609.yFXQBJUcoq@nvdebian>
In-Reply-To: <YNNTzau6cjx6UGDk@t490s>
References: <20210527201927.29586-1-peterx@redhat.com> <1857347.At2d1zFpmm@nvdebian> <YNNTzau6cjx6UGDk@t490s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccaee1d0-6745-406a-37c1-08d940409bd1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4317:
X-Microsoft-Antispam-PRVS: <MN2PR12MB43175E12B4F63F097C2CC400DF1B9@MN2PR12MB4317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VN7qlJauMU+v9mNN2a0tg5r/gPI6bG4ShLyBtcRzLYjlrdZ6gaMycV5xzL2PDvZBhnz+pIrLza8epfvyq4FehWhXTksIqo2ETa2MIdzw6vSDYTBqu9ysHp327aBPR3cAuwnK8pPXy5UnjerJnqGul9KoGxBR4oJBkOJghIWAqPhpySkBzQ9S2kF+wyLrsVq1eCBWwiYwTh+bVfDlYZZCceOLX6LcwDG2veL2rTmUG/FA6m8SLYdIulGQve/EQWndghYhzYwei7GLrpse1U1KBCu3DgVbpXcv89GXSmHcoG/5tniut3e4fAlRkWKQeidbm7ZjlXV50p/dDoyOLKxS9ygtqk1ncgcC2nKqMnibRUR9SMNmOsYE7T0/GWV3lFM9bjoJUWvLpJBqtnSbAzyjVLmq4lDz3FvHF5OxKwTnLlMAzSRWJjHi5OOSoW2WsJDyCFwX4u/ZcEKOMiWyZX5J0GBank7MkfVjmamqa70SWd4MEpOr1NxZzUQOa8DfmGoD0jRy16dTld4ZO+ZndELWetBgezwwFUtHqu5aeE6bQ5LOUif3n1xz1xZFwZl14OCYdWch5kH4K+bjUM4iAeyALAqganHcqxRc9sMXABM3gx2xOwp1IQcdAbytBbuS/P7REg/HEphOhnlUMTObJdjFTn/mRa0lVgPeOml4Kag9NrF5e/du7/6BEU/RYKvE7RdXY34MJaY3R5fmwuVCxBmJ3A==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(82740400003)(9686003)(336012)(33716001)(426003)(8936002)(86362001)(186003)(356005)(6916009)(30864003)(16526019)(4326008)(8676002)(5660300002)(83380400001)(9576002)(54906003)(478600001)(36906005)(36860700001)(7636003)(82310400003)(47076005)(2906002)(7416002)(70586007)(316002)(26005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 05:40:48.3441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccaee1d0-6745-406a-37c1-08d940409bd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > > >  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> > > > > > >  			     pte_t pte);
> > > > > > >  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > > > > > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > > > > > > index 355ea1ee32bd..c29a6ef3a642 100644
> > > > > > > --- a/include/linux/mm_inline.h
> > > > > > > +++ b/include/linux/mm_inline.h
> > > > > > > @@ -4,6 +4,8 @@
> > > > > > >  
> > > > > > >  #include <linux/huge_mm.h>
> > > > > > >  #include <linux/swap.h>
> > > > > > > +#include <linux/userfaultfd_k.h>
> > > > > > > +#include <linux/swapops.h>
> > > > > > >  
> > > > > > >  /**
> > > > > > >   * page_is_file_lru - should the page be on a file LRU or anon LRU?
> > > > > > > @@ -104,4 +106,45 @@ static __always_inline void del_page_from_lru_list(struct page *page,
> > > > > > >  	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
> > > > > > >  			-thp_nr_pages(page));
> > > > > > >  }
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
> > > > > > > + * replace a none pte.  NOTE!  This should only be called when *pte is already
> > > > > > > + * cleared so we will never accidentally replace something valuable.  Meanwhile
> > > > > > > + * none pte also means we are not demoting the pte so if tlb flushed then we
> > > > > > > + * don't need to do it again; otherwise if tlb flush is postponed then it's
> > > > > > > + * even better.
> > > > > > > + *
> > > > > > > + * Must be called with pgtable lock held.
> > > > > > > + */
> > > > > > > +static inline void
> > > > > > > +pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
> > > > > > > +			      pte_t *pte, pte_t pteval)
> > > > > > > +{
> > > > > > > +#ifdef CONFIG_USERFAULTFD
> > > > > > > +	bool arm_uffd_pte = false;
> > > > > > > +
> > > > > > > +	/* The current status of the pte should be "cleared" before calling */
> > > > > > > +	WARN_ON_ONCE(!pte_none(*pte));
> > > > > > > +
> > > > > > > +	if (vma_is_anonymous(vma))
> > > > > > > +		return;
> > > > > > > +
> > > > > > > +	/* A uffd-wp wr-protected normal pte */
> > > > > > > +	if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
> > > > > > > +		arm_uffd_pte = true;
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * A uffd-wp wr-protected swap pte.  Note: this should even work for
> > > > > > > +	 * pte_swp_uffd_wp_special() too.
> > > > > > > +	 */
> > > > > > 
> > > > > > I'm probably missing something but when can we actually have this case and why
> > > > > > would we want to leave a special pte behind? From what I can tell this is
> > > > > > called from try_to_unmap_one() where this won't be true or from zap_pte_range()
> > > > > > when not skipping swap pages.
> > > > > 
> > > > > Yes this is a good question..
> > > > > 
> > > > > Initially I made this function make sure I cover all forms of uffd-wp bit, that
> > > > > contains both swap and present ptes; imho that's pretty safe.  However for
> > > > > !anonymous cases we don't keep swap entry inside pte even if swapped out, as
> > > > > they should reside in shmem page cache indeed.  The only missing piece seems to
> > > > > be the device private entries as you also spotted below.
> > > > 
> > > > Yes, I think it's *probably* safe although I don't yet have a strong opinion
> > > > here ...
> > > > 
> > > > > > > +	if (unlikely(is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)))
> > > > 
> > > > ... however if this can never happen would a WARN_ON() be better? It would also
> > > > mean you could remove arm_uffd_pte.
> > > 
> > > Hmm, after a second thought I think we can't make it a WARN_ON_ONCE().. this
> > > can still be useful for private mapping of shmem files: in that case we'll have
> > > swap entry stored in pte not page cache, so after page reclaim it will contain
> > > a valid swap entry, while it's still "!anonymous".
> > 
> > There's something (probably obvious) I must still be missing here. During
> > reclaim won't a private shmem mapping still have a present pteval here?
> > Therefore it won't trigger this case - the uffd wp bit is set when the swap
> > entry is established further down in try_to_unmap_one() right?
> 
> I agree if it's at the point when it get reclaimed, however what if we zap a
> pte of a page already got reclaimed?  It should have the swap pte installed,
> imho, which will have "is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)"==true.

Apologies for the delay getting back to this, I hope to find some more time
to look at this again this week.

I guess what I am missing is why we care about a swap pte for a reclaimed page
getting zapped. I thought that would imply the mapping was getting torn down,
although I suppose in that case you still want the uffd-wp to apply in case a
new mapping appears there?

> > 
> > > > 
> > > > > > > +		arm_uffd_pte = true;
> > > > > > > +
> > > > > > > +	if (unlikely(arm_uffd_pte))
> > > > > > > +		set_pte_at(vma->vm_mm, addr, pte,
> > > > > > > +			   pte_swp_mkuffd_wp_special(vma));
> > > > > > > +#endif
> > > > > > > +}
> > > > > > > +
> > > > > > >  #endif
> > > > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > > > index 319552efc782..3453b8ae5f4f 100644
> > > > > > > --- a/mm/memory.c
> > > > > > > +++ b/mm/memory.c
> > > > > > > @@ -73,6 +73,7 @@
> > > > > > >  #include <linux/perf_event.h>
> > > > > > >  #include <linux/ptrace.h>
> > > > > > >  #include <linux/vmalloc.h>
> > > > > > > +#include <linux/mm_inline.h>
> > > > > > >  
> > > > > > >  #include <trace/events/kmem.h>
> > > > > > >  
> > > > > > > @@ -1298,6 +1299,21 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> > > > > > >  	return ret;
> > > > > > >  }
> > > > > > >  
> > > > > > > +/*
> > > > > > > + * This function makes sure that we'll replace the none pte with an uffd-wp
> > > > > > > + * swap special pte marker when necessary. Must be with the pgtable lock held.
> > > > > > > + */
> > > > > > > +static inline void
> > > > > > > +zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
> > > > > > > +			      unsigned long addr, pte_t *pte,
> > > > > > > +			      struct zap_details *details, pte_t pteval)
> > > > > > > +{
> > > > > > > +	if (zap_drop_file_uffd_wp(details))
> > > > > > > +		return;
> > > > > > > +
> > > > > > > +	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > > > > >  				struct vm_area_struct *vma, pmd_t *pmd,
> > > > > > >  				unsigned long addr, unsigned long end,
> > > > > > > @@ -1335,6 +1351,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > > > > >  			ptent = ptep_get_and_clear_full(mm, addr, pte,
> > > > > > >  							tlb->fullmm);
> > > > > > >  			tlb_remove_tlb_entry(tlb, pte, addr);
> > > > > > > +			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> > > > > > > +						      ptent);
> > > > > > >  			if (unlikely(!page))
> > > > > > >  				continue;
> > > > > > >  
> > > > > > > @@ -1359,6 +1377,22 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > > > > >  			continue;
> > > > > > >  		}
> > > > > > >  
> > > > > > > +		/*
> > > > > > > +		 * If this is a special uffd-wp marker pte... Drop it only if
> > > > > > > +		 * enforced to do so.
> > > > > > > +		 */
> > > > > > > +		if (unlikely(is_swap_special_pte(ptent))) {
> > > > > > > +			WARN_ON_ONCE(!pte_swp_uffd_wp_special(ptent));
> > > > > > 
> > > > > > Why the WARN_ON and not just test pte_swp_uffd_wp_special() directly?
> > > > > > 
> > > > > > > +			/*
> > > > > > > +			 * If this is a common unmap of ptes, keep this as is.
> > > > > > > +			 * Drop it only if this is a whole-vma destruction.
> > > > > > > +			 */
> > > > > > > +			if (zap_drop_file_uffd_wp(details))
> > > > > > > +				ptep_get_and_clear_full(mm, addr, pte,
> > > > > > > +							tlb->fullmm);
> > > > > > > +			continue;
> > > > > > > +		}
> > > > > > > +
> > > > > > >  		entry = pte_to_swp_entry(ptent);
> > > > > > >  		if (is_device_private_entry(entry) ||
> > > > > > >  		    is_device_exclusive_entry(entry)) {
> > > > > > > @@ -1373,6 +1407,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > > > > >  				page_remove_rmap(page, false);
> > > > > > >  
> > > > > > >  			put_page(page);
> > > > > > > +			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> > > > > > > +						      ptent);
> > > > > > 
> > > > > > Device entries only support anonymous vmas at present so should we drop this?
> > > > > > I guess I'm also a little confused by this because I'm not sure in what
> > > > > > scenarios you would want to zap swap entries but leave special swap ptes behind
> > > > > > (see also my earlier question above as well).
> > > > > 
> > > > > If that's the case, maybe indeed this is not needed, and I can use a
> > > > > WARN_ON_ONCE here instead, just in case some facts changes. E.g., would it be
> > > > > possible one day to have !anonymous support for device private entries?
> > > > > Frankly I have no solid idea on how device private is used, so some more
> > > > > context would be nice too; since I think you should know much better than me,
> > > > > so maybe it's a good chance to learn more about it. :)
> > > > 
> > > > Yes, a WARN_ON_ONCE() would be good if you remove it. We are planning to add
> > > > support for !anonymous device private entries at some point.
> > > > 
> > > > There's nothing too special about device private entries. They exist to store
> > > > some state and look up a device driver callback that gets called when the CPU
> > > > tries to access the page. For example see how do_swap_page() handles them:
> > > > 
> > > >                 } else if (is_device_private_entry(entry)) {
> > > >                         vmf->page = pfn_swap_entry_to_page(entry);
> > > >                         ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
> > > > 
> > > > Normally a device driver provides the implementation of migrate_to_ram() which
> > > > will copy the page back to CPU addressable memory and restore the PTE to a
> > > > normal functioning PTE using the migrate_vma_*() interfaces. Typically this is
> > > > used to allow migration of a page to memory that is not directly CPU addressable
> > > > (eg. GPU memory). Hopefully that goes some way to explaining what they are, but
> > > > if you have more questions let me know!
> > > 
> > > Thanks for offering these details!  So one thing I'm still uncertain is what
> > > exact type of memory is allowed to be mapped to device private.  E.g., would
> > > "anonymous shared" allowed as "anonymous"?  I saw there seems to have one ioctl
> > > defined that's used to bind these things:
> > > 
> > > 	DRM_IOCTL_DEF_DRV(NOUVEAU_SVM_BIND, nouveau_svmm_bind, DRM_RENDER_ALLOW),
> > > 
> > > Then nouveau_dmem_migrate_chunk() will initiates the device private entries, am
> > > I right?  Then to ask my previous question in another form: if the vaddr range
> > > is coming from an userspace extention driver, would it be allowed to pass in
> > > some vaddr range mapped with MAP_ANONYMOUS|MAP_SHARED?
> > 
> > I should have been more specific - device private pages currently only support
> > non-file/shmem backed pages. In other words the migrate_vma_*() calls will fail
> > for MAP_ANONYMOUS | MAP_SHARED when the target page is a device private page.
> > 
> > For a present page this is enforced in migrate_vma_pages() when trying to
> > migrate to a device private page:
> > 
> >                 mapping = page_mapping(page);
> > 
> >                 if (is_zone_device_page(newpage)) {
> >                         if (is_device_private_page(newpage)) {
> >                                 /*
> >                                  * For now only support private anonymous when
> >                                  * migrating to un-addressable device memory.
> >                                  */
> >                                 if (mapping) {
> >                                         migrate->src[i] &= ~MIGRATE_PFN_MIGRATE;
> >                                         continue;
> >                                 }
> 
> Ah fair enough. :)
> 
> When I looked again, I did also see that there's vma_is_anonymous() check right
> at the entry of migrate_vma_insert_page() too.
> 
> I'll convert this device private call to a WARN_ON_ONCE() then, with proper
> comments explaining why.
> 
> Thanks,
> 
> 




