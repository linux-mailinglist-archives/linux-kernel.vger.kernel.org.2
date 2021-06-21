Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0823AE934
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFUMjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:39:10 -0400
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:44704
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229663AbhFUMjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:39:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8TYcsd4SOMIy3W6FQrTxq0FFt5IWVhlfNskFNkMMQYLBlIpBiJ27rYDtuTzI7QTnD0lYMIc0GcZBO4dyMNh1y2kMxQEVEvWgtg7BLaqOLJA2iTWFCNhuDHKnMzt7Sp9yQ5oLS8ac8qF7Drmk7EXFLnv0rLsgs3rIr0w8aVEBSm0+YZugiTtrue+WbHIQCakxyY8FIhK+3zs/09Plxzrdz0fBDnYzU6nJNhRYvYETBFPgfhwMgac6eZWe+1fQ2hWTGHsFET49Q+mzs6dP4Tx1Lgf14VD2Ozurkld9kZOZLjkXTBaV7RwlduyJzIhJPXsD9fvP0XhGaSbS0lz67QiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGHjn6DJfVksNLGhELaQJDzMBraU0DlSe7uv2IVJ8qQ=;
 b=NzP4tyzlqGeXva/8NyIPdvXl0TV1tGkoLdkO3K1Y+ynYdbCXPgEVX3bKLYtVfUh11Oe1OdM9Qc9wpXsyned7w+SCDbFmHib0EsCYzoh5iMLhMKf6lU2N4Q3jKqfkABx8LE7WUriRUfWJDj65fltkOJhDFA2pxLVXxJnz1UU7FUH+zerw4QtC3t2oYD7A1sqC3LHNWn48FtClDmroz6OZr7AeQpEcLvkPIbluXQ2RoKtgKjoPtzo6LAiOBAIrL09SQkjsPnFnB/guCW5bfa0siRCmLgmusr/V79SY0uHt7WZq4m1h+4mOWAca84NJvff/nLBm6msqDyv7bPp8InV1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGHjn6DJfVksNLGhELaQJDzMBraU0DlSe7uv2IVJ8qQ=;
 b=gEqCYSuqCC0InxeRKr/2SEUDVGOf1GhfN3ZcViODvFba9EHzEIUEtDV+++rsx++YxD25d2a04jtAkqYaPjcG3SeiKyjU6EABwq9Q+No5S9+rvYVB3T7FOT2vTkh3LaNjZJQeY42GBPwHx7VBYzQho6hLGKFMW+nwE4E9zphZH5LAt+oxDKo+20KEoy3aFAFlfUgV8ifq78Ojnh2MimnLavvsVQ004PjC6CUqKxaSVjjtTQI6Ezb9X56CITMLlaFz+9iyPpyPktCgErkeZAVYuPD5E03ZnWqRcapGukIJXiTFxhADicRQ9pgUYeEtlwnSM9KZfq7oqRNZLoaUA0hGuA==
Received: from BN9PR03CA0766.namprd03.prod.outlook.com (2603:10b6:408:13a::21)
 by MN2PR12MB4655.namprd12.prod.outlook.com (2603:10b6:208:1b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 12:36:53 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::47) by BN9PR03CA0766.outlook.office365.com
 (2603:10b6:408:13a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Mon, 21 Jun 2021 12:36:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 12:36:52 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Jun
 2021 12:36:48 +0000
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
Subject: Re: [PATCH v3 09/27] mm: Introduce ZAP_FLAG_SKIP_SWAP
Date:   Mon, 21 Jun 2021 22:36:46 +1000
Message-ID: <5565576.ugXqPVlkE4@nvdebian>
In-Reply-To: <20210527202135.30890-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com> <20210527202135.30890-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfc79bb5-b41c-4d7f-0d3e-08d934b13f91
X-MS-TrafficTypeDiagnostic: MN2PR12MB4655:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4655590C56B79F5BB629A41DDF0A9@MN2PR12MB4655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4aOWR5eWesfJo1YE2oTVpftv7S2HMKOhuq1Ilh5tynBwKYJJTySm/xAbvjNLe9YllQzjqBCz1xkZxJHpxqJZzws/I5gFJ2j04+TjnC0E0ygbFkjmUN/3SZzhcG6D0LGxe2lHYicfqC5mSAR9coMhHJEGBEH4BiI8G5OScH61M7L2r/+ZUBLE7huXdUhHEYhlVjxVH4oa4kH2ZQBUuAOCB08cbRowz0dPfDNmUjXQYaCvQFCyp+Padnzilciqff104VVNjWkfsRpEHPzOMlSHBfqthIBVvGbUMlrPljobIKS3woAfUdprFX1OyaJQxLBwVLLXB01X0/r4z0GUbue64XFyugvrBvMWG0oQr8r8SV6ZUV34lxis5sMczrPihq9awHQZmypunlxwBD0uqoEirADJdAuLwElhBgsyEDu2PzXWbQVJJhbHZT4UOkuDTEZA0lGPbxAUgsZhYhTLmhGhY5Z6yjrmvGhgKU6hXel+WVKEmzwL1zxXChVxZck4LKbz+sdzoRWtzjYggG1NELx99CDwwJdoWuHAuRcsH9ZFeom2WTHU6FKuOiEqb3OvRkh7ZrY3iVAkq//iAzVOfRIsJfm09cTlDMkCvQ+R/m22zz3ZzbJy0lloe4FOJFRUbnsQ3aMOA9VhgPmzfv6kZMVzzRhQRjqIeG7JgHyXbd9QAWZbEOKsutKIiaJwUMqQ2EGT
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(316002)(36906005)(356005)(82310400003)(36860700001)(5660300002)(426003)(478600001)(7636003)(6916009)(9576002)(7416002)(54906003)(9686003)(186003)(8936002)(83380400001)(82740400003)(16526019)(86362001)(8676002)(33716001)(47076005)(2906002)(70206006)(26005)(70586007)(4326008)(336012)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 12:36:52.8203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc79bb5-b41c-4d7f-0d3e-08d934b13f91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4655
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 28 May 2021 6:21:35 AM AEST Peter Xu wrote:
> Firstly, the comment in zap_pte_range() is misleading because it checks against
> details rather than check_mappings, so it's against what the code did.
> 
> Meanwhile, it's confusing too on not explaining why passing in the details
> pointer would mean to skip all swap entries.  New user of zap_details could
> very possibly miss this fact if they don't read deep until zap_pte_range()
> because there's no comment at zap_details talking about it at all, so swap
> entries could be errornously skipped without being noticed.
> 
> This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
> but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
> "details" parameter: the caller should explicitly set this to skip swap
> entries, otherwise swap entries will always be considered (which is still the
> major case here).
> 
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm.h | 12 ++++++++++++
>  mm/memory.c        |  8 +++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 52d3ef2ed753..1adf313a01fe 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1723,6 +1723,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
>  
>  /* Whether to check page->mapping when zapping */
>  #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
> +/* Whether to skip zapping swap entries */
> +#define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
>  
>  /*
>   * Parameter block passed down to zap_pte_range in exceptional cases.
> @@ -1745,6 +1747,16 @@ zap_check_mapping_skip(struct zap_details *details, struct page *page)
>  	return details->zap_mapping != page_rmapping(page);
>  }
>  
> +/* Return true if skip swap entries, false otherwise */
> +static inline bool
> +zap_skip_swap(struct zap_details *details)

Minor nit-pick but imho it would be nice if the naming was consistent between
this and check mapping. Ie. zap_skip_swap()/zap_skip_check_mapping() or
zap_swap_skip()/zap_check_mapping_skip().

> +{
> +	if (!details)
> +		return false;
> +
> +	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
> +}
> +
>  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t pte);
>  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/mm/memory.c b/mm/memory.c
> index c9dc4e9e05b5..8a3751be87ba 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1376,8 +1376,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			continue;
>  		}
>  
> -		/* If details->check_mapping, we leave swap entries. */
> -		if (unlikely(details))
> +		if (unlikely(zap_skip_swap(details)))
>  			continue;
>  
>  		if (!non_swap_entry(entry))
> @@ -3328,7 +3327,10 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>  		pgoff_t nr, bool even_cows)
>  {
>  	pgoff_t	first_index = start, last_index = start + nr - 1;
> -	struct zap_details details = { .zap_mapping = mapping };
> +	struct zap_details details = {
> +		.zap_mapping = mapping,

I meant to comment on this in the previous patch, but it might be nice to set
.zap_mapping in the !even_cows case below to make it very obvious it only
applies to ZAP_FLAG_CHECK_MAPPING.

Otherwise I think this is a good clean up which makes things clearer. I double
checked that unmap_mapping_pages() was the only place in the existing code that
needs ZAP_FLAG_SKIP_SWAP and that appears to be the case so there shouldn't be
any behaviour changes from this.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> +		.zap_flags = ZAP_FLAG_SKIP_SWAP,
> +	};
>  
>  	if (!even_cows)
>  		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
> 




