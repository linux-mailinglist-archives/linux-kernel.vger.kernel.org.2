Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2273AFAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhFVCKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:10:17 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:52833
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229663AbhFVCKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:10:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=it7RQIJq0Mi4ImHGJBXRgYBn217GS7fToskr1khuqj98ztX4jk49M9M48rPffKr2CirE3Gf1pd9rj5dQBJBhTNvyVYuT6aYwkXFWoNSRQHcirKjkHJGhu4INiBEHHXqLVn6dG/DPd0CyZzm1xdCT0x1ro8x1V5hctnNs9NyGIL8JDFyAkXN31mFvkjaAv7X/BKuf+JIPyYVMXuPnjjbImfT2UKt5pvEFWDQnJh1RqSuUveO8W5M52hKN2gtTVLKDMLygzLJk1hHXCG5s0akCkPf7VJpZLfnfcds8ZxGu1NmZ9rE7Cz/bBKFocGMr7QJMWXa3GYJlWsxgzF2yNvIRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTVdrMfYtMmkif1pUn6H4Fav9a4BKMA6Yp71rYlsw00=;
 b=fO5GoDzShYgt4KIwFGAEjicJaMEyLGO1Y50s2kwSIJEioPpTKt4kA7XaSBeGf4nI6hGHH/wd5MDihfGHA0m4KTVLz6XTL4aWm27xII1VPGw1kzadkwVdCLinkKxvLDWMb9liRD8j8rKjcMyZzo9aUXhRS8RZnCa7wrL8uFGYtlMoxO1FTRvLKK25RIRRTA0v/YeDQh3V0LptB4maCmIrf+P5svFOu96aYZYFTps86MX8W29/oPIzwnxp8vLH9halkkRiBlc8PmpGXjtiREo4O0jqg+qTPhSqOYS7T/xAER+TYysuFVwG6e/aqoqTkHamDT2Ddn5/F8/UiplBZuBJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTVdrMfYtMmkif1pUn6H4Fav9a4BKMA6Yp71rYlsw00=;
 b=o1OwdwLvZSiZJ2pBi8eWBqYROc5xWSuUhxpzuUXuqlGzLrDsRcBLXfDVaPEk5E9JECHTyrDxhMfd4nWBEQ+xN1MmjVAx4uRBnsCCQisWDjbSWDwiugD3nRJwlVr8QU4j9NmGHn+nz2Xzw+5TAIkefwsEtNzsXTfCuNw4kOjaoPdg0FCGh/ggtM7zgZV9gzUyHFuDbL3LdAifLCWCfkUS6Zjc1ijaKbKqYCYsQiYWgec7Jg3lYEIXjxHRgCab9sEgJRJLs3GAdn5eLwkTa3ZmJ+y2uWGpLqIovWyiNMdasrw9c9/S1YvMCpkENGK11F4hSxJWLvNKz74rPGhQXYc+gA==
Received: from MWHPR03CA0010.namprd03.prod.outlook.com (2603:10b6:300:117::20)
 by CY4PR12MB1239.namprd12.prod.outlook.com (2603:10b6:903:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 02:07:59 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::f3) by MWHPR03CA0010.outlook.office365.com
 (2603:10b6:300:117::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Tue, 22 Jun 2021 02:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 02:07:58 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 22 Jun
 2021 02:07:55 +0000
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
Subject: Re: [PATCH v3 08/27] mm: Introduce zap_details.zap_flags
Date:   Tue, 22 Jun 2021 12:07:53 +1000
Message-ID: <12693036.q1u8oJ8qPt@nvdebian>
In-Reply-To: <YNC7csnnSWXz6xvJ@t490s>
References: <20210527201927.29586-1-peterx@redhat.com> <5845701.Ud2vPSPtVx@nvdebian> <YNC7csnnSWXz6xvJ@t490s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adddf743-22c6-4efd-b8fa-08d935228ebf
X-MS-TrafficTypeDiagnostic: CY4PR12MB1239:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12397E187F23AC4E92889DD3DF099@CY4PR12MB1239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nadqfhB9xRel/MLtASejArylkICgpA/Tjoh1L0KGf7m6g3ziw1a0p6NrLT32HbdkiAaTEsI4alP6mr67hABUefh381fqg/2bJ5P7sxlaxIMXmHMRESR8Q3nQWnMhIiUtBY/CvF2KdeXrHH3WB168wsbRXis6Y9R/NNZvXb7hBP1NehNcXiNfLWlU54WukLayVJ3GEmraO3ZIvh2Lu8o2UmYcRUxBx6b0knYwDsdbEP0ASBEcst4xQoERmOUDjhb9S4+vU+qlOK4IOH72jo1+g9ybDlcIvxk6dJm+6McPhjew0IMSYXl+dHE+dzFQTxmYAWdjph3frqV6hKahVYhkeCwjqlEVnJRd0KQFZ9uxpsU+iyMjRSdyoFuaVRXAaSwl5hbjO9hsnUJUpKrxllwmF0ZNmKI4k8qJd90R72HwmZxiHnE9DB0tLe8DLnovJk8RSsglZ5iEB3Ndfb31M5WkNYCnL4T7r+sU4WbV2OBCtiu+zt0p1NYhSlAg0JeuBc98KxyKq1jeGDLzo2vJWdpVtVGW75sVi5x3bdUQl+FdcN+8XML3oRWFIA38i+cep6VMjF5/E1wNZdvbNQRST0hEsij6adqs+Uwex2spypb79ReIC36vFjxzaYuRIoUbVsl3it6bMIxymncHjQ7Q85xF3xTFWg5eW7W2ykr1zte8CHQwNQMWMgLjV9I4eD0mpGYQ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(36906005)(316002)(6916009)(82310400003)(478600001)(9686003)(83380400001)(7636003)(5660300002)(7416002)(356005)(47076005)(426003)(36860700001)(33716001)(16526019)(2906002)(9576002)(4326008)(70206006)(82740400003)(186003)(26005)(8676002)(8936002)(86362001)(336012)(54906003)(70586007)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 02:07:58.7836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adddf743-22c6-4efd-b8fa-08d935228ebf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1239
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 22 June 2021 2:16:50 AM AEST Peter Xu wrote:
> On Mon, Jun 21, 2021 at 10:09:00PM +1000, Alistair Popple wrote:
> > On Friday, 28 May 2021 6:21:30 AM AEST Peter Xu wrote:
> > > Instead of trying to introduce one variable for every new zap_details fields,
> > > let's introduce a flag so that it can start to encode true/false informations.
> > > 
> > > Let's start to use this flag first to clean up the only check_mapping variable.
> > > Firstly, the name "check_mapping" implies this is a "boolean", but actually it
> > > stores the mapping inside, just in a way that it won't be set if we don't want
> > > to check the mapping.
> > > 
> > > To make things clearer, introduce the 1st zap flag ZAP_FLAG_CHECK_MAPPING, so
> > > that we only check against the mapping if this bit set.  At the same time, we
> > > can rename check_mapping into zap_mapping and set it always.
> > > 
> > > Since at it, introduce another helper zap_check_mapping_skip() and use it in
> > > zap_pte_range() properly.
> > > 
> > > Some old comments have been removed in zap_pte_range() because they're
> > > duplicated, and since now we're with ZAP_FLAG_CHECK_MAPPING flag, it'll be very
> > > easy to grep this information by simply grepping the flag.
> > > 
> > > It'll also make life easier when we want to e.g. pass in zap_flags into the
> > > callers like unmap_mapping_pages() (instead of adding new booleans besides the
> > > even_cows parameter).
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  include/linux/mm.h | 19 ++++++++++++++++++-
> > >  mm/memory.c        | 31 ++++++++-----------------------
> > >  2 files changed, 26 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index db155be8e66c..52d3ef2ed753 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -1721,13 +1721,30 @@ static inline bool can_do_mlock(void) { return false; }
> > >  extern int user_shm_lock(size_t, struct user_struct *);
> > >  extern void user_shm_unlock(size_t, struct user_struct *);
> > >  
> > > +/* Whether to check page->mapping when zapping */
> > > +#define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
> > > +
> > >  /*
> > >   * Parameter block passed down to zap_pte_range in exceptional cases.
> > >   */
> > >  struct zap_details {
> > > -	struct address_space *check_mapping;	/* Check page->mapping if set */
> > > +	struct address_space *zap_mapping;
> > > +	unsigned long zap_flags;
> > >  };
> > >  
> > > +/* Return true if skip zapping this page, false otherwise */
> > > +static inline bool
> > > +zap_check_mapping_skip(struct zap_details *details, struct page *page)
> > > +{
> > > +	if (!details || !page)
> > > +		return false;
> > > +
> > > +	if (!(details->zap_flags & ZAP_FLAG_CHECK_MAPPING))
> > > +		return false;
> 
> [1]
> 
> > > +
> > > +	return details->zap_mapping != page_rmapping(page);
> > 
> > I doubt this matters in practice, but there is a slight behaviour change
> > here that might be worth checking. Previously this check was equivalent
> > to:
> > 
> > details->zap_mapping && details->zap_mapping != page_rmapping(page)
> 
> Yes; IMHO "details->zap_mapping" is just replaced by the check at [1].

Yes, but what I meant is that this check is slightly different in behaviour
from the old code which would never skip if check/zap_mapping == NULL where as
the new code will skip if
details->zap_mapping == NULL && page_rmapping(page) != NULL because the check
has effectively become:

				if ((details->zap_flags & ZAP_FLAG_CHECK_MAPPING) &&
				    details->zap_mapping != page_rmapping(page))
					continue;

instead of:

				if (details->zap_mapping &&
				    details->zap_mapping != page_rmapping(page))
					continue;

As I said though I only looked at this superficially from the perspective of
whether this patch changes existing code behaviour. I doubt this is a real
problem because I assume
details->check_mapping == NULL && page_rmapping(page) != NULL can never
actually happen in practice.

> For example, there's only one real user of this mapping check, which is
> unmap_mapping_pages() below [2].
> 
> With the old code, we have:
> 
>     details.check_mapping = even_cows ? NULL : mapping;
> 
> So "details->zap_mapping" is only true if "!even_cows".
> 
> With the new code, we'll have:
> 
>     if (!even_cows)
>         details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
> 
> So ZAP_FLAG_CHECK_MAPPING is only set if "!even_cows", while that's what we
> check exactly at [1].
> > 
> > Otherwise I think this looks good.
> > 
> > > +}
> > > +
> > >  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> > >  			     pte_t pte);
> > >  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 27cf8a6375c6..c9dc4e9e05b5 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -1330,16 +1330,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > >  			struct page *page;
> > >  
> > >  			page = vm_normal_page(vma, addr, ptent);
> > > -			if (unlikely(details) && page) {
> > > -				/*
> > > -				 * unmap_shared_mapping_pages() wants to
> > > -				 * invalidate cache without truncating:
> > > -				 * unmap shared but keep private pages.
> > > -				 */
> > > -				if (details->check_mapping &&
> > > -				    details->check_mapping != page_rmapping(page))
> > > -					continue;
> > > -			}
> > > +			if (unlikely(zap_check_mapping_skip(details, page)))
> > > +				continue;
> > >  			ptent = ptep_get_and_clear_full(mm, addr, pte,
> > >  							tlb->fullmm);
> > >  			tlb_remove_tlb_entry(tlb, pte, addr);
> > > @@ -1372,17 +1364,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > >  		    is_device_exclusive_entry(entry)) {
> > >  			struct page *page = pfn_swap_entry_to_page(entry);
> > >  
> > > -			if (unlikely(details && details->check_mapping)) {
> > > -				/*
> > > -				 * unmap_shared_mapping_pages() wants to
> > > -				 * invalidate cache without truncating:
> > > -				 * unmap shared but keep private pages.
> > > -				 */
> > > -				if (details->check_mapping !=
> > > -				    page_rmapping(page))
> > > -					continue;
> > > -			}
> > > -
> > > +			if (unlikely(zap_check_mapping_skip(details, page)))
> > > +				continue;
> > >  			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> > >  			rss[mm_counter(page)]--;
> > >  
> > > @@ -3345,9 +3328,11 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
> > >  		pgoff_t nr, bool even_cows)
> > >  {
> > >  	pgoff_t	first_index = start, last_index = start + nr - 1;
> > > -	struct zap_details details = { };
> > > +	struct zap_details details = { .zap_mapping = mapping };
> > > +
> > > +	if (!even_cows)
> > > +		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
> > >  
> > > -	details.check_mapping = even_cows ? NULL : mapping;
> 
> [2]
> 
> > >  	if (last_index < first_index)
> > >  		last_index = ULONG_MAX;
> 
> Thanks,
> 
> 




