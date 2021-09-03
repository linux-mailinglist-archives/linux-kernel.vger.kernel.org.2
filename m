Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4673FF88B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 02:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbhICBAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 21:00:00 -0400
Received: from mail-dm6nam11on2043.outbound.protection.outlook.com ([40.107.223.43]:38048
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236198AbhICA77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 20:59:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXpPRT9ac3TDZtd9Q++cKs7g/JCtLWQdlpqLSH7XJIn4NTrMrQL0slh6oDQowBVqCAX/QdpZ7NS2vf1d7yf0/QxOMQALifVWFqEvKJ8fCSyHB8SfCtYioXDtbLRHRaZCy2HQU+poIXKmgYSTLu4PK3hJDkn0o46+rVLRIT7U2naxeMonzhH5ZjkQfzOqAZJMwneYPb+21DWf8YPFKZ+YUzh5vkK5bZWaopZ5qqaKGUQwyimSu/6f7BtgDncDoLFzS/5CDjmN2cR884Brct7VlBVUIKjVgp3JFJmM1lXkEWCz0qLQ+M9Ek/BDrYiyIKx3TuwQNJ/MTPPBDea0lXKtww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q859ypsA4Ty3+AenRtdihNYgi/baFcsoV8vlhriHhJs=;
 b=f5kCG3NJ2VADA6RQr6x8e4TVxh9dtaC9z98+nZluP67Z1U2ptE65KE4bq+8W5Yjr5VCUv7sEbJbzXWoVdankQG/3ktTIh5N9tzsvrnzwQZ5k3jksIeVRfDgyMNmwVmVqsf6yRME6Dmb916D/NCn9q4x7WnoiqZo0BQjGVmyTKZ8hWpa0Npv+hR6QjPx6mfSp7hxVeJRZFWyPcDHMr5qQCvCZcjVL/zNfw0uFnBBWU/hn1mTUzrN5VlsuAJQdHoJYU8YM+yAuIvgHBZI8SRwBXY846mCvUG4Lb6OJZWk6A1D5oWl1B7oMy2dynWDgQJ4fXb9N1iSfv6vye8jUtGttmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q859ypsA4Ty3+AenRtdihNYgi/baFcsoV8vlhriHhJs=;
 b=ML/8wEdaQoGHc3EstKyQutPgoF2XgI93ZRWDZ8PeK7pAasXRJvuzKfqzZ49w18yNVjBIIfKvyH50LjCD8vsNLBPfysTKAwxSr9afENqRKmn16i+WVZAEugAWUHNTGwq7V1drkqfK1xZ+Lp1zjfb0wKFlXUarXage7rqIr6wytqxw5HkAftsUajByM3yO8hlhxr8kD5tUOe9i9BRKtKFwL2a1iLf+SczavSPEbjsKEMtA45J8NIF7PmdXgYn9QGmUhYuMEnjXw8g76cwxMyzMfLp4fINHC73Z8YzMiW1gDUgnRCYw0LSY+dbgLhW3W/aHhBl7pI0Ntzho1ED+m7OYMA==
Received: from BN6PR13CA0008.namprd13.prod.outlook.com (2603:10b6:404:10a::18)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Fri, 3 Sep
 2021 00:58:59 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::1e) by BN6PR13CA0008.outlook.office365.com
 (2603:10b6:404:10a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend
 Transport; Fri, 3 Sep 2021 00:58:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 00:58:59 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 3 Sep
 2021 00:58:58 +0000
Received: from nvdebian.localnet (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 3 Sep 2021
 00:58:55 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>
CC:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>, <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 4/5] mm: Add zap_skip_check_mapping() helper
Date:   Fri, 3 Sep 2021 10:58:53 +1000
Message-ID: <1771631.QAr93JHi05@nvdebian>
In-Reply-To: <20210902201819.53343-1-peterx@redhat.com>
References: <20210902201721.52796-1-peterx@redhat.com> <20210902201819.53343-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81b042be-0ef9-425d-f588-08d96e760366
X-MS-TrafficTypeDiagnostic: DM6PR12MB4862:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4862F8D66D11A4D406F4E885DFCF9@DM6PR12MB4862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6Eu8kxrrz82sC/23F5IccSgeNa7iR9qq2lP9ydI0UwWs5DqG9ulJ0pg0ovnEdr62MWTKv2Fia3CD2IAl+Ps/DH9eqNihIq+HnbEKk8NUdZyvI94lbnyGlFMq5orDa7exmj0kXK7RnrgHf2mHCArcLCayN+OD40dm4sMM1ZJc4bAvDTQ5ms6rk2oT6zn7D4rFrOQiuGgI0IKJ6P40WRTaLrrkjI6q0x2IsbopajEdodVHYHRGLdT5GpIohA9aPmT+kgmvLuPcV/ZDSAB31sCAgugXAvIpc1jy04e8lSHN3VnUp6hXBKV+pVfuCSTTr5VYmdZCjinWA3sAcScqDrs36Y2ssPVGfFODCIFkIRGzCihP7Q1lyLTHHOHU2qnvokbRx7cUF0V2U9Z6SqwLVjbn+a8Duo3CUw+xg7f/lLZEkCrpZP3FiM5/zJ28411VJCn3uYAIDrroJjU4cO+0RSOJfgkUGAoaqEv+3doigCQ+VaGHhbcvrE3C5qznITvY9KLZbVZpdgwHdaN9jiwTN1hQd1zxycVa9EyagXbfwA3HqvVmpn3N8DXfgDqNkpU1r3liPXvqXFCl7WS6xZz8C3A31dyG00JVMf9jD8TJCOdGG37Q31Q5JKfPSuVxuNckH4dEdraOls1f/EimVJgc2d6H5/eI2H/mflg+CTRg5HJADzFkXMf/mFcX445oQ8H4I2fTfzMcFTQy9kPk92NL/VAM+QwUA8U0xFo6X3jiyjSfchG/nB8BEv/3+xdpn7FINa9
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(36840700001)(2906002)(316002)(33716001)(36860700001)(8676002)(9686003)(86362001)(336012)(5660300002)(356005)(47076005)(83380400001)(70586007)(70206006)(82310400003)(7416002)(9576002)(36906005)(16526019)(478600001)(8936002)(7636003)(26005)(110136005)(186003)(426003)(4326008)(82740400003)(54906003)(39026012)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 00:58:59.0274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b042be-0ef9-425d-f588-08d96e760366
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 3 September 2021 6:18:19 AM AEST Peter Xu wrote:
> Use the helper for the checks.  Rename "check_mapping" into "zap_mapping"
> because "check_mapping" looks like a bool but in fact it stores the mapping
> itself.  When it's set, we check the mapping (it must be non-NULL).  When it's
> cleared we skip the check, which works like the old way.
>
> Move the duplicated comments to the helper too.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm.h | 15 ++++++++++++++-
>  mm/memory.c        | 29 ++++++-----------------------
>  2 files changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 69259229f090..81e402a5fbc9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1720,10 +1720,23 @@ extern void user_shm_unlock(size_t, struct ucounts *);
>   * Parameter block passed down to zap_pte_range in exceptional cases.
>   */
>  struct zap_details {
> -	struct address_space *check_mapping;	/* Check page->mapping if set */
> +	struct address_space *zap_mapping;	/* Check page->mapping if set */
>  	struct page *single_page;		/* Locked page to be unmapped */
>  };
>  
> +/*
> + * We set details->zap_mappings when we want to unmap shared but keep private
> + * pages. Return true if skip zapping this page, false otherwise.
> + */
> +static inline bool
> +zap_skip_check_mapping(struct zap_details *details, struct page *page)
> +{
> +	if (!details || !page)
> +		return false;
> +
> +	return details->zap_mapping != page_rmapping(page);

Shouldn't this check still be
details->zap_mapping && details->zap_mapping != page_rmapping(page)?

Previously we wouldn't skip zapping pages if even_cows == true (ie.
details->check_mapping == NULL). With this change the check when
even_cows == true becomes NULL != page_rmapping(page). Doesn't this mean we
will now skip zapping any pages with a mapping when even_cows == true?

> +}
> +
>  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t pte);
>  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/mm/memory.c b/mm/memory.c
> index 6bba3b9fef7c..e5ee8399d270 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1333,16 +1333,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
> +			if (unlikely(zap_skip_check_mapping(details, page)))
> +				continue;
>
>  			ptent = ptep_get_and_clear_full(mm, addr, pte,
>  							tlb->fullmm);
>  			tlb_remove_tlb_entry(tlb, pte, addr);
> @@ -1375,17 +1367,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
> +			if (unlikely(zap_skip_check_mapping(details, page)))
> +				continue;
>  			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>  			rss[mm_counter(page)]--;
>  
> @@ -3368,7 +3351,7 @@ void unmap_mapping_page(struct page *page)
>  	first_index = page->index;
>  	last_index = page->index + thp_nr_pages(page) - 1;
>  
> -	details.check_mapping = mapping;
> +	details.zap_mapping = mapping;
>  	details.single_page = page;
>  
>  	i_mmap_lock_write(mapping);
> @@ -3396,7 +3379,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>  	pgoff_t	first_index = start, last_index = start + nr - 1;
>  	struct zap_details details = { };
>  
> -	details.check_mapping = even_cows ? NULL : mapping;
> +	details.zap_mapping = even_cows ? NULL : mapping;
>  	if (last_index < first_index)
>  		last_index = ULONG_MAX;
>  
> 




