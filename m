Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE3F3AE8C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhFUMLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:11:22 -0400
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com ([40.107.223.65]:40640
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229621AbhFUMLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:11:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASTFKdpetamtZnEPg9c3ahR032x8+UkO6v58hWD44X0+bCqraIoSGOdPO1CC7gXJkJ8NI3SSGegvdtd4CWXRrAJrvAXml/NNjJiKP95vdsBJ+K10FaA8HBpOk0XvXHl1QZqqe5BHvb012484pePtnb6ieGmLPpqpC5jCSFA1V5etB/uXkwC8eduZx+HfZsqxHPGqQiW4FNAcS7XNPDLcg2RX/4gP101ZFBk7c5lVI289f3039Z5e0aT4GDIm5X090WGAGbC0ThSTiLQ4xMLQAcrgAE9qb6lvYu7y75RCvfwZdMZhqJWsuZFBxG3Rp3/mTk1VZMyy7xLvV505LQTGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VrKjqTh3HRRcLbB56wzobmBb2329QMVsabBJRg74ek=;
 b=UCZAprHtEgU70X+9zMns/pgyp9SJ5re3LM8+Gy2WD8LxC7W22oHhEHvDiZAK0vs3nw2oJTrSsFtieeSaXrwbEIKZL2fsOhJadO8FpFoOpdIVbf8pwDvp9o/xFK5gRPofN0P7DK7VtdtDq61ZRQlvxu70Xpbw8shJRoyFnjRWeumBvNKj4c4OGvx0In92sYKw4VRv3UByoSjokLRTjnW1LgXyDJXG1KYY2IHC6vAWb35emIXv8Rf5pCA9Wni2O+eWKBJnfSWtLEpAan8csi5IohQcB7Ub1ZU29WigUps4zUd/BpD7kfUevSqTVEYraRlmMAYCfeW5+dO/h9XBJeRHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VrKjqTh3HRRcLbB56wzobmBb2329QMVsabBJRg74ek=;
 b=X2dg22AyyDRfmjCuknmc9THGknzjBYZngveL2uNtCoHP1EozHvQyMNbZJEEEmAgOBetPMyo8qpCp1q5HXyBPMfTgWFxxnRaFuhCBfieKw6O+O4SvxCEncHWaiDrYd6pGmcTNUBPCYnjF3yATMbafizGrw30xOc4TX3XZGACQD4tf3BwC4kneMpAb6LW8mXnS3AnxrFvS9iGPrsfCBjmnrjd+5VJA0AoqRaNtfUZrxgmJj8yF7sO7Nll7G2Yf9KFRhTqkwkBnHuUdQzPROkXQGb+0FJHvlycVk+HnXcusD8hPGEZ5v3Qr/HstDvyVLmrvqU/j+fQHySulDhKjg077IQ==
Received: from DS7PR03CA0139.namprd03.prod.outlook.com (2603:10b6:5:3b4::24)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 12:09:06 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::5c) by DS7PR03CA0139.outlook.office365.com
 (2603:10b6:5:3b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Mon, 21 Jun 2021 12:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 12:09:05 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Jun
 2021 12:09:02 +0000
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
Date:   Mon, 21 Jun 2021 22:09:00 +1000
Message-ID: <5845701.Ud2vPSPtVx@nvdebian>
In-Reply-To: <20210527202130.30840-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com> <20210527202130.30840-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9dcc787-3c37-4538-3177-08d934ad5e03
X-MS-TrafficTypeDiagnostic: SN6PR12MB2637:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2637C6A0CDCCA6F9BEF9BF3FDF0A9@SN6PR12MB2637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHQanbFUQvFVXUTTMgbpqcgPtlJB4jNkNeVHm5JVx7UNScgYkMWfgYtUaREaYg79FKpQZTbWIzOfslKYRq4XfPMMn6gZ3JAJlNCAda1fSVoFJKTQLEi/bkvN6LVIRpCktUrnCe/6bUgeweDhr4LE6yGF07guipXDdo4tJ/Wgzra4LsI+yAFKCKlpHrGHN5AmGXxcMvLO/R+cL+wHIvivYutSVm6sghk8q3HNpS5IjhyljOvalgLiCGKdLDwwCLl9Obd/bJmKiuiOzTPIv3Kqfs9wLdO/sBRHF4Y2ev0xRalMxrX3HQfoMKdY/ftbHhGcfcyb9Zg4ZxXm0mNImbCf2rEKrP9feRX8R4KLfs5S8GppLcct5kFH2Aa2/ey6CmJgp+E7ZZekQgoM9dKujvrfm2wR+WCxVj825za1AcDrVzAeQJo8qk6WTz5LRtmp8C4p/K7pVxDL/s7PU7U9/iB94vXSxIjn12wBgM6LiUBqvsHJZTpC4lM0n02IB7jiBbkq45Um90aDwvWa+bfBNUzVMrO0lJrsy99OyvfNHzlEV1dgjlDl5E7osZAAC1RDuKrP/1ilSX8l9K4EKix2AmvTMUxtIe10bMIgETLLYRJUycNoDlzhx3UlfEnsd9PYYqyFONZIolX629wU7sohPwZgBePfcWA51zu4+a/2CqXLYCNGoBhZv7XErHVwQeZ4NXfW
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(36840700001)(36906005)(83380400001)(316002)(426003)(54906003)(336012)(478600001)(2906002)(70586007)(33716001)(9686003)(4326008)(9576002)(7416002)(70206006)(82310400003)(86362001)(5660300002)(7636003)(8676002)(356005)(8936002)(26005)(36860700001)(47076005)(16526019)(186003)(82740400003)(6916009)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 12:09:05.9730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dcc787-3c37-4538-3177-08d934ad5e03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 28 May 2021 6:21:30 AM AEST Peter Xu wrote:
> Instead of trying to introduce one variable for every new zap_details fields,
> let's introduce a flag so that it can start to encode true/false informations.
> 
> Let's start to use this flag first to clean up the only check_mapping variable.
> Firstly, the name "check_mapping" implies this is a "boolean", but actually it
> stores the mapping inside, just in a way that it won't be set if we don't want
> to check the mapping.
> 
> To make things clearer, introduce the 1st zap flag ZAP_FLAG_CHECK_MAPPING, so
> that we only check against the mapping if this bit set.  At the same time, we
> can rename check_mapping into zap_mapping and set it always.
> 
> Since at it, introduce another helper zap_check_mapping_skip() and use it in
> zap_pte_range() properly.
> 
> Some old comments have been removed in zap_pte_range() because they're
> duplicated, and since now we're with ZAP_FLAG_CHECK_MAPPING flag, it'll be very
> easy to grep this information by simply grepping the flag.
> 
> It'll also make life easier when we want to e.g. pass in zap_flags into the
> callers like unmap_mapping_pages() (instead of adding new booleans besides the
> even_cows parameter).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm.h | 19 ++++++++++++++++++-
>  mm/memory.c        | 31 ++++++++-----------------------
>  2 files changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index db155be8e66c..52d3ef2ed753 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1721,13 +1721,30 @@ static inline bool can_do_mlock(void) { return false; }
>  extern int user_shm_lock(size_t, struct user_struct *);
>  extern void user_shm_unlock(size_t, struct user_struct *);
>  
> +/* Whether to check page->mapping when zapping */
> +#define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
> +
>  /*
>   * Parameter block passed down to zap_pte_range in exceptional cases.
>   */
>  struct zap_details {
> -	struct address_space *check_mapping;	/* Check page->mapping if set */
> +	struct address_space *zap_mapping;
> +	unsigned long zap_flags;
>  };
>  
> +/* Return true if skip zapping this page, false otherwise */
> +static inline bool
> +zap_check_mapping_skip(struct zap_details *details, struct page *page)
> +{
> +	if (!details || !page)
> +		return false;
> +
> +	if (!(details->zap_flags & ZAP_FLAG_CHECK_MAPPING))
> +		return false;
> +
> +	return details->zap_mapping != page_rmapping(page);

I doubt this matters in practice, but there is a slight behaviour change
here that might be worth checking. Previously this check was equivalent
to:

details->zap_mapping && details->zap_mapping != page_rmapping(page)

Otherwise I think this looks good.

> +}
> +
>  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t pte);
>  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/mm/memory.c b/mm/memory.c
> index 27cf8a6375c6..c9dc4e9e05b5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1330,16 +1330,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			struct page *page;
>  
>  			page = vm_normal_page(vma, addr, ptent);
> -			if (unlikely(details) && page) {
> -				/*
> -				 * unmap_shared_mapping_pages() wants to
> -				 * invalidate cache without truncating:
> -				 * unmap shared but keep private pages.
> -				 */
> -				if (details->check_mapping &&
> -				    details->check_mapping != page_rmapping(page))
> -					continue;
> -			}
> +			if (unlikely(zap_check_mapping_skip(details, page)))
> +				continue;
>  			ptent = ptep_get_and_clear_full(mm, addr, pte,
>  							tlb->fullmm);
>  			tlb_remove_tlb_entry(tlb, pte, addr);
> @@ -1372,17 +1364,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  		    is_device_exclusive_entry(entry)) {
>  			struct page *page = pfn_swap_entry_to_page(entry);
>  
> -			if (unlikely(details && details->check_mapping)) {
> -				/*
> -				 * unmap_shared_mapping_pages() wants to
> -				 * invalidate cache without truncating:
> -				 * unmap shared but keep private pages.
> -				 */
> -				if (details->check_mapping !=
> -				    page_rmapping(page))
> -					continue;
> -			}
> -
> +			if (unlikely(zap_check_mapping_skip(details, page)))
> +				continue;
>  			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>  			rss[mm_counter(page)]--;
>  
> @@ -3345,9 +3328,11 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>  		pgoff_t nr, bool even_cows)
>  {
>  	pgoff_t	first_index = start, last_index = start + nr - 1;
> -	struct zap_details details = { };
> +	struct zap_details details = { .zap_mapping = mapping };
> +
> +	if (!even_cows)
> +		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
>  
> -	details.check_mapping = even_cows ? NULL : mapping;
>  	if (last_index < first_index)
>  		last_index = ULONG_MAX;
>  
> 




