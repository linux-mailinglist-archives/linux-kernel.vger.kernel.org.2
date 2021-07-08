Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B673BF40F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 04:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhGHCwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 22:52:12 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:36320
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230195AbhGHCwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 22:52:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM90xBvEoghCaQi++cdfXxRr9ZTjhfXN6x5I+wmg/Boi0pr4tSwFvzYdTmWwd3aOdLdh1kW8fJEbAcvCV0GL3DkqfKbJ8A3R0viBl8bJQfXnxgtlugUOesd4Z9y52Z5kGaeRdblSuYYC2luyTrj4hCpxJY9UuY1ouy12y4JiAaQ0wLAqbsCUOLwfwBQ1rtkQSIyKugCeNO4OsGleH3FgLtyxBy3lFschwymMPMUv3vwxySQdN8LSF1h2TuVq5G8StUl9KI5LmI0vikr7HwL1CcjpwCSOylo6LFRESicYUZn4gfNwUf1zQdgQVzJ79xXv57e6yva4oel4TqqvcytMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMiLuojZ/Q42QKlTmtcOo1VSLso7gQwo/E6JRmxIg/Q=;
 b=hcM7XHVzfu/4x8Ml/BjXT2soFWxZgpgxhJkvXB1CWS+8mVpDOQZ8D7hgfj9WuvcNxCp2JGqJS3BBO9IEpIucjaPVe5gNfgnPEt/Zi0jZQZ8hR8JqVEHVs0c321cOOz4RLr9Z3kGEyDEpNZxNeNc4xjQaTneagLqdVCF6KFYP6/E/CJ/4Pyt+BujoHb3JreyzFHeLhkCR0kJf4kVHKCYaqQsotFyY6ikxOKxLA6zVyhrYElfSmDlQJRO57lWlc5YWcg0uyIy5BxksZAYiOhlSJKmVVPlXrS0eIBmvx5FjFuJe7Ya5Q0ObcrIXXdD8A08jWTx8qx4udMXSAJaBKtKvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMiLuojZ/Q42QKlTmtcOo1VSLso7gQwo/E6JRmxIg/Q=;
 b=JJFCUcqSRf7GK8M20ALAe/qQ8iwD2LNpaGIRdoBv53UtTS9G08SKD4uQbELNanlve31DoTQ2b7TGJDY8HuLQGeGR2h6Ccp7Tlw8lba6mium7eelEOo4T3cvdetyRfGzZ4GFqAKIdh/5eXKLawqv7dTnXgEtm43WPQgD/xMPZODyNyuAlJuJzMsJZV4ApPuGk7aOUpB/A6rBoFJ2hF7Zgrb9kLGuKam96qSqKYKdeGBKZvBWMKy1XQS/1uQozanlifc4fqmosePf9PPwBWNtzEcI9vLpONbLDbr1tV8sPbzg1CDubJ+SgwnjauhSOLhA+B3fY6mFJRdGGBBFvtc5JAw==
Received: from MWHPR21CA0035.namprd21.prod.outlook.com (2603:10b6:300:129::21)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Thu, 8 Jul
 2021 02:49:29 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::58) by MWHPR21CA0035.outlook.office365.com
 (2603:10b6:300:129::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.2 via Frontend
 Transport; Thu, 8 Jul 2021 02:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4308.20 via Frontend Transport; Thu, 8 Jul 2021 02:49:28 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Jul
 2021 02:49:25 +0000
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
Date:   Thu, 8 Jul 2021 12:49:23 +1000
Message-ID: <2500158.4Z4izgLEvx@nvdebian>
In-Reply-To: <YOR4NmRmk54ULkkp@t490s>
References: <20210527201927.29586-1-peterx@redhat.com> <3895609.yFXQBJUcoq@nvdebian> <YOR4NmRmk54ULkkp@t490s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5262268-bfc5-47e9-3fb6-08d941bb0171
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5505CEEA2C37ECC64A1DFB38DF199@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AlZVk2IupeXm58ZQIDts7kIjcmSDYHq+SIXMGnyurZSIaOrXWlhdO+SOfQ7diXUzrrEiDODCMj8CcRFtuWE/3oWjTl1lCDnqE1kmiOgcdYZzUXXsCzy4hZSrJiKbZmEkTVHq8e6RADwLd+yJHHyF2szDiE6oOQpY/kntCTBNuIry/8wyzOmOQIMFmAF/dZOAPvZ8MugoZ92lijubIxK1R/ENFE5muYyY3fyblh8WMquPyvA43audNI/EVMb/O4DF3ZBs0IpBe2012adApdou1VdvKz/4SfkmQd8IbFLyO48tfmSj/enrDBzAp7TP3nv9UBzB2lz6aKHTQzVFc8a9CgOGjpbppXXAyaLJXSxAtcoSOW4lGH0KOg+lsSbWsMRQEorJJhYmov/eDYDtmJgVT0I9ILd7o+z4o2BPWMLJNyQneWrzXvP5S3icx7dafq0252kHr44yFGwuQ9kUmOoY0fB4dg137tyor7R3LxRREB9dvSc/HwSejHqtd8ewK1Jkn5sGLIY7BkUg15a9TD5pYVUYq4x3M1CmdHRqXdM2VCFuaQSgZ+Q/s8N57Zw7PHBewnPv8Is6K/yGGmW+THu+jZ1qrydC/YZFy5mAL4X+UYbPYnQbIrwMJaPwQ+2A8iArak3Vv26JzCEZHd+tvx9ggMcrE52gsWI626iHeh7Yow9D8wBVqeocMovRlcxsX+ukN1gSMmdvt1AKuxpKj7I4fIBgJB3/Z2a/5Au1FMbmz4E=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(36840700001)(9686003)(82310400003)(26005)(33716001)(70206006)(2906002)(70586007)(186003)(5660300002)(4326008)(86362001)(16526019)(7416002)(36860700001)(36906005)(54906003)(47076005)(478600001)(83380400001)(8676002)(6916009)(8936002)(336012)(82740400003)(316002)(356005)(426003)(9576002)(7636003)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 02:49:28.7525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5262268-bfc5-47e9-3fb6-08d941bb0171
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 7 July 2021 1:35:18 AM AEST Peter Xu wrote:
> On Tue, Jul 06, 2021 at 03:40:42PM +1000, Alistair Popple wrote:
> > > > > > > > >  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> > > > > > > > >  			     pte_t pte);
> > > > > > > > >  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > > > > > > > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > > > > > > > > index 355ea1ee32bd..c29a6ef3a642 100644
> > > > > > > > > --- a/include/linux/mm_inline.h
> > > > > > > > > +++ b/include/linux/mm_inline.h
> > > > > > > > > @@ -4,6 +4,8 @@
> > > > > > > > >  
> > > > > > > > >  #include <linux/huge_mm.h>
> > > > > > > > >  #include <linux/swap.h>
> > > > > > > > > +#include <linux/userfaultfd_k.h>
> > > > > > > > > +#include <linux/swapops.h>
> > > > > > > > >  
> > > > > > > > >  /**
> > > > > > > > >   * page_is_file_lru - should the page be on a file LRU or anon LRU?
> > > > > > > > > @@ -104,4 +106,45 @@ static __always_inline void del_page_from_lru_list(struct page *page,
> > > > > > > > >  	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
> > > > > > > > >  			-thp_nr_pages(page));
> > > > > > > > >  }
> > > > > > > > > +
> > > > > > > > > +/*
> > > > > > > > > + * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
> > > > > > > > > + * replace a none pte.  NOTE!  This should only be called when *pte is already
> > > > > > > > > + * cleared so we will never accidentally replace something valuable.  Meanwhile
> > > > > > > > > + * none pte also means we are not demoting the pte so if tlb flushed then we
> > > > > > > > > + * don't need to do it again; otherwise if tlb flush is postponed then it's
> > > > > > > > > + * even better.
> > > > > > > > > + *
> > > > > > > > > + * Must be called with pgtable lock held.
> > > > > > > > > + */
> > > > > > > > > +static inline void
> > > > > > > > > +pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
> > > > > > > > > +			      pte_t *pte, pte_t pteval)
> > > > > > > > > +{
> > > > > > > > > +#ifdef CONFIG_USERFAULTFD
> > > > > > > > > +	bool arm_uffd_pte = false;
> > > > > > > > > +
> > > > > > > > > +	/* The current status of the pte should be "cleared" before calling */
> > > > > > > > > +	WARN_ON_ONCE(!pte_none(*pte));
> > > > > > > > > +
> > > > > > > > > +	if (vma_is_anonymous(vma))
> > > > > > > > > +		return;
> > > > > > > > > +
> > > > > > > > > +	/* A uffd-wp wr-protected normal pte */
> > > > > > > > > +	if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
> > > > > > > > > +		arm_uffd_pte = true;
> > > > > > > > > +
> > > > > > > > > +	/*
> > > > > > > > > +	 * A uffd-wp wr-protected swap pte.  Note: this should even work for
> > > > > > > > > +	 * pte_swp_uffd_wp_special() too.
> > > > > > > > > +	 */
> > > > > > > > 
> > > > > > > > I'm probably missing something but when can we actually have this case and why
> > > > > > > > would we want to leave a special pte behind? From what I can tell this is
> > > > > > > > called from try_to_unmap_one() where this won't be true or from zap_pte_range()
> > > > > > > > when not skipping swap pages.
> > > > > > > 
> > > > > > > Yes this is a good question..
> > > > > > > 
> > > > > > > Initially I made this function make sure I cover all forms of uffd-wp bit, that
> > > > > > > contains both swap and present ptes; imho that's pretty safe.  However for
> > > > > > > !anonymous cases we don't keep swap entry inside pte even if swapped out, as
> > > > > > > they should reside in shmem page cache indeed.  The only missing piece seems to
> > > > > > > be the device private entries as you also spotted below.
> > > > > > 
> > > > > > Yes, I think it's *probably* safe although I don't yet have a strong opinion
> > > > > > here ...
> > > > > > 
> > > > > > > > > +	if (unlikely(is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)))
> > > > > > 
> > > > > > ... however if this can never happen would a WARN_ON() be better? It would also
> > > > > > mean you could remove arm_uffd_pte.
> > > > > 
> > > > > Hmm, after a second thought I think we can't make it a WARN_ON_ONCE().. this
> > > > > can still be useful for private mapping of shmem files: in that case we'll have
> > > > > swap entry stored in pte not page cache, so after page reclaim it will contain
> > > > > a valid swap entry, while it's still "!anonymous".
> 
> [1]
> 
> > > > 
> > > > There's something (probably obvious) I must still be missing here. During
> > > > reclaim won't a private shmem mapping still have a present pteval here?
> > > > Therefore it won't trigger this case - the uffd wp bit is set when the swap
> > > > entry is established further down in try_to_unmap_one() right?
> > > 
> > > I agree if it's at the point when it get reclaimed, however what if we zap a
> > > pte of a page already got reclaimed?  It should have the swap pte installed,
> > > imho, which will have "is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)"==true.
> > 
> > Apologies for the delay getting back to this, I hope to find some more time
> > to look at this again this week.
> 
> No problem, please take your time on reviewing the series.
> 
> > 
> > I guess what I am missing is why we care about a swap pte for a reclaimed page
> > getting zapped. I thought that would imply the mapping was getting torn down,
> > although I suppose in that case you still want the uffd-wp to apply in case a
> > new mapping appears there?
> 
> For the torn down case it'll always have ZAP_FLAG_DROP_FILE_UFFD_WP set, so
> pte_install_uffd_wp_if_needed() won't be called, as zap_drop_file_uffd_wp()
> will return true:

Argh, thanks. I had forgotten that bit.

> static inline void
> zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
> 			      unsigned long addr, pte_t *pte,
> 			      struct zap_details *details, pte_t pteval)
> {
> 	if (zap_drop_file_uffd_wp(details))
> 		return;
> 
> 	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
> }
> 
> If you see it's non-trivial to fully digest all the caller stacks of it. What I
> wanted to do with pte_install_uffd_wp_if_needed is simply to provide a helper
> that can convert any form of uffd-wp ptes into a pte marker before being set as
> none pte.  Since uffd-wp can exist in two forms (either present, or swap), then
> cover all these two forms (and for swap form also cover the uffd-wp special pte
> itself) is very clear idea and easy to understand to me.  I don't even need to
> worry about who is calling it, and which case can be swap pte, which case must
> not - we just call it when we want to persist the uffd-wp bit (after a pte got
> cleared).  That's why in all cases I still prefer to keep it as is, as it just
> makes things straightforward to me.

Ok, that makes sense. I don't think there is an actual problem here it was
just a little surprising to me so I was trying to get a better understanding
of the caller stacks and when this might actually be required. As you say
though that is non-trivial and in any case it's still ok to install these
bits and a single function is simpler.

 - Alistair
 
> Thanks,
> 
> 




