Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD213B0520
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhFVMto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:49:44 -0400
Received: from mail-dm3nam07on2043.outbound.protection.outlook.com ([40.107.95.43]:44904
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231847AbhFVMtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:49:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBtWNIP96w0XQhN9Ywo6X6SmwZwVv0bB9neY9vEOEmlaK6mjuNvvtxE0TIZ24vJViEAeQR63yzU80fhLOZBJAxRCVPmk+yvVyXiyg5OMkIQuYdRTgIxIjsHBgps900TshHA+t8MEMEUESMIktz4hFJsL3QrybJDXffDmXbbJK4MbRsEEVojFxZNGXWQqwd00d0fcgCt+5eg0hE4o0ZBG+O447U8fzzRDoOnz1Mh059R6giSICYVxTBMI9UhQ1hy+YMvUNna6A5YPS7yoW3IwEvyj1gUaEqVDCvsZD8gWOPImnklNy9Dg22MzBVNeF7hwR4ZNLHdaIPcya024arEBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cutKznOz2VEbaI05jwuiyOSsQPHhunsT0KG0XdaRRRg=;
 b=AUD1cFWoMfFp5SDTjFFsrXaOfp9fe/6t3ZUWGlskTC6B0q3AMT7jev14bC8J/UTOI00LM8fXzdM8flWQ3EsNEt9PgAK0VqWOghcmztYaPcPzUONJvhHtR/SfnT/7O0PlP6MjehnG/mpGOGQH7dhXrIpRMaiodBL2QHm9oZUCfW8jwn+MCsMWXci2GxA6S3Pk1gjps6pBQf3mR9Rf5y4Q8A3RfTaOzLAMWq3op/ftZFjW+il9Yai7T7yOko7J1yXpHhMVxxM2SOFLgDNq7IGzzZBy1yqeUWv5agT5lyPR/hkjYQ9aQuEFHbcCVIVP2PSc2FyZUK9pJjr2Wn8Fpb4dLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cutKznOz2VEbaI05jwuiyOSsQPHhunsT0KG0XdaRRRg=;
 b=cyjk19q+9+73al5aQI6s71I94VBC/6IBUVd701nUWWzx2Km4nFogMYDUB03GxPtUPtHeReN6kRcFF/3iMnoEERfVXKZUpDG+crkzzzU0M8QbC1ahVm3K46uXc33ouUIgvgx4uFYAS2ijMp+EUhEW40JmtV9SAx9d7U37A0Nwk24dIkuryUHi+F/XhuMpQWoBzKzkemFQyk0Yo49PPwERR5sWRlEz3YWF3bu71tPGyMOi10Qy2PtHDR8N38B7HVVoYgeRl4RwugBv1H1BB5ly7g0Rx6nxYlKCmZX98m7zdlWUoDFE/OdDKN0OkPbkaz+zoIJXGH1P3w27RvHoaefXng==
Received: from MWHPR2201CA0054.namprd22.prod.outlook.com
 (2603:10b6:301:16::28) by BN6PR1201MB0243.namprd12.prod.outlook.com
 (2603:10b6:405:50::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 12:47:17 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::1b) by MWHPR2201CA0054.outlook.office365.com
 (2603:10b6:301:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Tue, 22 Jun 2021 12:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 12:47:16 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 22 Jun
 2021 12:47:13 +0000
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
Date:   Tue, 22 Jun 2021 22:47:11 +1000
Message-ID: <14377897.UNNPvh25YO@nvdebian>
In-Reply-To: <YNExhdKPfIb9QlDe@t490s>
References: <20210527201927.29586-1-peterx@redhat.com> <2098802.ffhGrX9TH4@nvdebian> <YNExhdKPfIb9QlDe@t490s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9c61d3f-45e3-4b0c-b614-08d9357bdddb
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0243:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0243EC4EE8A2FEE67BBBD6F3DF099@BN6PR1201MB0243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoH2KKG49fLPbr3fUDO/8DtyjpOAZ2SVui/dys8/y6zz39+06nM3v4nDoTdODB6gXpoDbSMS0hBAGiq9ww0L45Jpjz+q5mTAbT78JKKHtUGK6ulwlNLE+5jNsKIeB88MKDx55SjKGfGrSSM8dUFcaBfcAjl4XQ10fN3twZhkwg95Mi/KRwyBPoylYLi6TfuXUt/Nn0IxWXksOCgk3BP6fLEsM3kn0PwKq12fSdVKBcWUiifoa/0GNyJR4Nlk8Mo44nqDfmeyWB5Rl3izE4A3OiL526D66QH+MLvtOYO8r7p5ZD/G9X8omwAYJ1qkK9XyKbcyD7ZpfkWpabC/cPwze9istI6hX60hlIdAd42wRAudGnxIb2JixiwIrrhGe0Xs9JDl1LmgtM9Vi66qeaG+9+vucM/qPMQMXCmpv4c6/1MY1Ki6tFT9njn3iv+S7HvviTKjFwFNDbF2ao7NR3VeP3lTDMYr5C5Yn3mreQRUo6k4v39OBwPmoaeNt0nt0Ca1wKL4QX1LzQlRo8MNf4MQzSvpw0sOviv29pBYTI+8ixWbqsAgVhJqQtHNIM2GTQ1Nqt/eetk03EKtK2yDhIp9Vhd+7DQuMvgmI3ePGmxfP8rsi/4Zloc6rynmqtvV6dVqE0pyVXsvJPAUs2xKBxIgmJPVhN0yzGerVwZG91pOQGnvahMFYY640dYIGE2Db9h8
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(46966006)(8676002)(86362001)(36906005)(316002)(8936002)(6916009)(4326008)(54906003)(7416002)(336012)(426003)(33716001)(9576002)(82740400003)(30864003)(5660300002)(36860700001)(2906002)(70586007)(83380400001)(70206006)(7636003)(356005)(47076005)(478600001)(26005)(9686003)(82310400003)(16526019)(186003)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 12:47:16.7959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c61d3f-45e3-4b0c-b614-08d9357bdddb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0243
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 22 June 2021 10:40:37 AM AEST Peter Xu wrote:
> On Mon, Jun 21, 2021 at 06:41:17PM +1000, Alistair Popple wrote:
> > On Friday, 28 May 2021 6:22:14 AM AEST Peter Xu wrote:
> > > File-backed memory is prone to being unmapped at any time.  It means all
> > > information in the pte will be dropped, including the uffd-wp flag.
> > > 
> > > Since the uffd-wp info cannot be stored in page cache or swap cache, persist
> > > this wr-protect information by installing the special uffd-wp marker pte when
> > > we're going to unmap a uffd wr-protected pte.  When the pte is accessed again,
> > > we will know it's previously wr-protected by recognizing the special pte.
> > > 
> > > Meanwhile add a new flag ZAP_FLAG_DROP_FILE_UFFD_WP when we don't want to
> > > persist such an information.  For example, when destroying the whole vma, or
> > > punching a hole in a shmem file.  For the latter, we can only drop the uffd-wp
> > > bit when holding the page lock.  It means the unmap_mapping_range() in
> > > shmem_fallocate() still reuqires to zap without ZAP_FLAG_DROP_FILE_UFFD_WP
> > > because that's still racy with the page faults.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  include/linux/mm.h        | 11 ++++++++++
> > >  include/linux/mm_inline.h | 43 +++++++++++++++++++++++++++++++++++++++
> > >  mm/memory.c               | 42 +++++++++++++++++++++++++++++++++++++-
> > >  mm/rmap.c                 |  8 ++++++++
> > >  mm/truncate.c             |  8 +++++++-
> > >  5 files changed, 110 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index b1fb2826e29c..5989fc7ed00d 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -1725,6 +1725,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
> > >  #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
> > >  /* Whether to skip zapping swap entries */
> > >  #define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
> > > +/* Whether to completely drop uffd-wp entries for file-backed memory */
> > > +#define  ZAP_FLAG_DROP_FILE_UFFD_WP         BIT(2)
> > >  
> > >  /*
> > >   * Parameter block passed down to zap_pte_range in exceptional cases.
> > > @@ -1757,6 +1759,15 @@ zap_skip_swap(struct zap_details *details)
> > >  	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
> > >  }
> > >  
> > > +static inline bool
> > > +zap_drop_file_uffd_wp(struct zap_details *details)
> > > +{
> > > +	if (!details)
> > > +		return false;
> > > +
> > > +	return details->zap_flags & ZAP_FLAG_DROP_FILE_UFFD_WP;
> > > +}
> > 
> > Is this a good default having to explicitly specify that you don't want
> > special pte's left in place?
> 
> I made it explicitly the default so we won't accidentally drop that bit without
> being aware of it; because missing of the uffd-wp bit anywhere can directly
> cause data corruption in the userspace.

Ok, I think that makes sense. I was just a little concerned about leaving
special pte's behind everywhere by accident and whether there would be any
unforeseen side effects from that. As you point out below though we do expect
that to happen occasionally and to clean them up when found.

> > For example the OOM killer seems to call unmap_page_range() with details ==
> > NULL (although in practice only for anonymous vmas so it wont actually cause
> > an issue). Similarly in madvise for MADV_DONTNEED, although arguably I
> > suppose that is the correct thing to do there?
> 
> So I must confess I'm not familiar with the oom code, it looks to me it's a
> fast path to recycle pages that can have a better chance to be reclaimed.  Even
> in exit_mmap() we'll do this first before unmap_vmas().  Then it still looks
> the right thing to do if it's only a fast path, not to mention if we only runs
> with anonymous then it's ignored.

Don't confuse my ability to grep with understanding of the OOM killer :-)

I was just reviewing cases where we might leave behind unwanted special ptes.
I don't think I really found any but wanted to ask about them anyway to learn
more about the rules for them (which you have answered below, thanks!).

> Basically I followed this rule: the bit should never be cleared if (1) user
> manually clear it using UFFDIO_WRITEPROTECT, (2) unmapping the whole region.
> There can be special cases e.g. when unregister the vma with VM_UFFD_WP, but
> that's a rare case, and we also have code to take care of those lazily (e.g.,
> we'll restore such a uffd-wp special pte into none pte if we found we've got a
> fault and the vma is not registered with uffd-wp at all, in do_swap_pte).
> Otherwise I never clear the bit.
> 
> > 
> > >  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> > >  			     pte_t pte);
> > >  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > > index 355ea1ee32bd..c29a6ef3a642 100644
> > > --- a/include/linux/mm_inline.h
> > > +++ b/include/linux/mm_inline.h
> > > @@ -4,6 +4,8 @@
> > >  
> > >  #include <linux/huge_mm.h>
> > >  #include <linux/swap.h>
> > > +#include <linux/userfaultfd_k.h>
> > > +#include <linux/swapops.h>
> > >  
> > >  /**
> > >   * page_is_file_lru - should the page be on a file LRU or anon LRU?
> > > @@ -104,4 +106,45 @@ static __always_inline void del_page_from_lru_list(struct page *page,
> > >  	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
> > >  			-thp_nr_pages(page));
> > >  }
> > > +
> > > +/*
> > > + * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
> > > + * replace a none pte.  NOTE!  This should only be called when *pte is already
> > > + * cleared so we will never accidentally replace something valuable.  Meanwhile
> > > + * none pte also means we are not demoting the pte so if tlb flushed then we
> > > + * don't need to do it again; otherwise if tlb flush is postponed then it's
> > > + * even better.
> > > + *
> > > + * Must be called with pgtable lock held.
> > > + */
> > > +static inline void
> > > +pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
> > > +			      pte_t *pte, pte_t pteval)
> > > +{
> > > +#ifdef CONFIG_USERFAULTFD
> > > +	bool arm_uffd_pte = false;
> > > +
> > > +	/* The current status of the pte should be "cleared" before calling */
> > > +	WARN_ON_ONCE(!pte_none(*pte));
> > > +
> > > +	if (vma_is_anonymous(vma))
> > > +		return;
> > > +
> > > +	/* A uffd-wp wr-protected normal pte */
> > > +	if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
> > > +		arm_uffd_pte = true;
> > > +
> > > +	/*
> > > +	 * A uffd-wp wr-protected swap pte.  Note: this should even work for
> > > +	 * pte_swp_uffd_wp_special() too.
> > > +	 */
> > 
> > I'm probably missing something but when can we actually have this case and why
> > would we want to leave a special pte behind? From what I can tell this is
> > called from try_to_unmap_one() where this won't be true or from zap_pte_range()
> > when not skipping swap pages.
> 
> Yes this is a good question..
> 
> Initially I made this function make sure I cover all forms of uffd-wp bit, that
> contains both swap and present ptes; imho that's pretty safe.  However for
> !anonymous cases we don't keep swap entry inside pte even if swapped out, as
> they should reside in shmem page cache indeed.  The only missing piece seems to
> be the device private entries as you also spotted below.

Yes, I think it's *probably* safe although I don't yet have a strong opinion
here ...

> > > +	if (unlikely(is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)))

... however if this can never happen would a WARN_ON() be better? It would also
mean you could remove arm_uffd_pte.

> > > +		arm_uffd_pte = true;
> > > +
> > > +	if (unlikely(arm_uffd_pte))
> > > +		set_pte_at(vma->vm_mm, addr, pte,
> > > +			   pte_swp_mkuffd_wp_special(vma));
> > > +#endif
> > > +}
> > > +
> > >  #endif
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 319552efc782..3453b8ae5f4f 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -73,6 +73,7 @@
> > >  #include <linux/perf_event.h>
> > >  #include <linux/ptrace.h>
> > >  #include <linux/vmalloc.h>
> > > +#include <linux/mm_inline.h>
> > >  
> > >  #include <trace/events/kmem.h>
> > >  
> > > @@ -1298,6 +1299,21 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> > >  	return ret;
> > >  }
> > >  
> > > +/*
> > > + * This function makes sure that we'll replace the none pte with an uffd-wp
> > > + * swap special pte marker when necessary. Must be with the pgtable lock held.
> > > + */
> > > +static inline void
> > > +zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
> > > +			      unsigned long addr, pte_t *pte,
> > > +			      struct zap_details *details, pte_t pteval)
> > > +{
> > > +	if (zap_drop_file_uffd_wp(details))
> > > +		return;
> > > +
> > > +	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
> > > +}
> > > +
> > >  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > >  				struct vm_area_struct *vma, pmd_t *pmd,
> > >  				unsigned long addr, unsigned long end,
> > > @@ -1335,6 +1351,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > >  			ptent = ptep_get_and_clear_full(mm, addr, pte,
> > >  							tlb->fullmm);
> > >  			tlb_remove_tlb_entry(tlb, pte, addr);
> > > +			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> > > +						      ptent);
> > >  			if (unlikely(!page))
> > >  				continue;
> > >  
> > > @@ -1359,6 +1377,22 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > >  			continue;
> > >  		}
> > >  
> > > +		/*
> > > +		 * If this is a special uffd-wp marker pte... Drop it only if
> > > +		 * enforced to do so.
> > > +		 */
> > > +		if (unlikely(is_swap_special_pte(ptent))) {
> > > +			WARN_ON_ONCE(!pte_swp_uffd_wp_special(ptent));
> > 
> > Why the WARN_ON and not just test pte_swp_uffd_wp_special() directly?
> > 
> > > +			/*
> > > +			 * If this is a common unmap of ptes, keep this as is.
> > > +			 * Drop it only if this is a whole-vma destruction.
> > > +			 */
> > > +			if (zap_drop_file_uffd_wp(details))
> > > +				ptep_get_and_clear_full(mm, addr, pte,
> > > +							tlb->fullmm);
> > > +			continue;
> > > +		}
> > > +
> > >  		entry = pte_to_swp_entry(ptent);
> > >  		if (is_device_private_entry(entry) ||
> > >  		    is_device_exclusive_entry(entry)) {
> > > @@ -1373,6 +1407,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > >  				page_remove_rmap(page, false);
> > >  
> > >  			put_page(page);
> > > +			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> > > +						      ptent);
> > 
> > Device entries only support anonymous vmas at present so should we drop this?
> > I guess I'm also a little confused by this because I'm not sure in what
> > scenarios you would want to zap swap entries but leave special swap ptes behind
> > (see also my earlier question above as well).
> 
> If that's the case, maybe indeed this is not needed, and I can use a
> WARN_ON_ONCE here instead, just in case some facts changes. E.g., would it be
> possible one day to have !anonymous support for device private entries?
> Frankly I have no solid idea on how device private is used, so some more
> context would be nice too; since I think you should know much better than me,
> so maybe it's a good chance to learn more about it. :)

Yes, a WARN_ON_ONCE() would be good if you remove it. We are planning to add
support for !anonymous device private entries at some point.

There's nothing too special about device private entries. They exist to store
some state and look up a device driver callback that gets called when the CPU
tries to access the page. For example see how do_swap_page() handles them:

                } else if (is_device_private_entry(entry)) {
                        vmf->page = pfn_swap_entry_to_page(entry);
                        ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);

Normally a device driver provides the implementation of migrate_to_ram() which
will copy the page back to CPU addressable memory and restore the PTE to a
normal functioning PTE using the migrate_vma_*() interfaces. Typically this is
used to allow migration of a page to memory that is not directly CPU addressable
(eg. GPU memory). Hopefully that goes some way to explaining what they are, but
if you have more questions let me know!

As far as I know there should already be support for userfaultfd-wp on device
private pages, and given they can only currently exist in anon vmas I think we
should be safe to not install a special pte when unmapping. On the other hand
I suppose it doesn't mater if we do install one right?

> > 
> > >  			continue;
> > >  		}
> > >  
> > > @@ -1390,6 +1426,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > >  		if (unlikely(!free_swap_and_cache(entry)))
> > >  			print_bad_pte(vma, addr, ptent, NULL);
> > >  		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> > > +		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
> > >  	} while (pte++, addr += PAGE_SIZE, addr != end);
> > >  
> > >  	add_mm_rss_vec(mm, rss);
> > > @@ -1589,12 +1626,15 @@ void unmap_vmas(struct mmu_gather *tlb,
> > >  		unsigned long end_addr)
> > >  {
> > >  	struct mmu_notifier_range range;
> > > +	struct zap_details details = {
> > > +		.zap_flags = ZAP_FLAG_DROP_FILE_UFFD_WP,
> > > +	};
> > >  
> > >  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
> > >  				start_addr, end_addr);
> > >  	mmu_notifier_invalidate_range_start(&range);
> > >  	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
> > > -		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
> > > +		unmap_single_vma(tlb, vma, start_addr, end_addr, &details);
> > >  	mmu_notifier_invalidate_range_end(&range);
> > >  }
> > >  
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index 0419c9a1a280..a94d9aed9d95 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -72,6 +72,7 @@
> > >  #include <linux/page_idle.h>
> > >  #include <linux/memremap.h>
> > >  #include <linux/userfaultfd_k.h>
> > > +#include <linux/mm_inline.h>
> > >  
> > >  #include <asm/tlbflush.h>
> > >  
> > > @@ -1509,6 +1510,13 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > >  			pteval = ptep_clear_flush(vma, address, pvmw.pte);
> > >  		}
> > >  
> > > +		/*
> > > +		 * Now the pte is cleared.  If this is uffd-wp armed pte, we
> > > +		 * may want to replace a none pte with a marker pte if it's
> > > +		 * file-backed, so we don't lose the tracking information.
> > > +		 */
> > > +		pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
> > 
> > From what I can tell we don't need to do this in try_to_migrate_one() (assuming
> > that goes in) as well because the existing uffd wp code already deals with
> > copying the pte bits over to the migration entries. Is that correct?
> 
> I agree try_to_migrate_one() shouldn't need it.  But I'm not sure about
> try_to_unmap_one(), as e.g. I think we should rely on this to make shmem work
> with when page got swapped out.

Oh for sure I agree you need it in try_to_unmap_one(), my code didn't change
the unmap path. It just split the migration cases (ie. replacing mappings with
migration entries instaed of unmapping) into a different function so I just
wanted to make sure we didn't need it in try_to_migrate_one() (and I think we
agree it isn't needed there).

 - Alistair

> Thanks,
> 
> 




