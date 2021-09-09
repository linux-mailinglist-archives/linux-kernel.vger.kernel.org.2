Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A26B4042B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 03:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349038AbhIIBRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 21:17:32 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:61760
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232144AbhIIBRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:17:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ztf/ZQ5jE/WCT62qJ2UJF6zVMSbV3qORJBj1uoUOaHsc14/o10RgFYIv1jjpdNJreBu++MlkXHxpUmZdWxPVBWR4o1rDVbL03PcEEJySkDx5gxd2CjaQrimNIPUnBnEmpzNprLSBubIG4975EKkUcpS+FuUwRFfSmmSxDXWWF3rs8++EGOwEcP3+iLFhuWqTquSbGid2oHZB3HFwmZ3U2jIH1vZ8FVF3qa1haUMJlAy/saPvejGc7B+GX1FdVReXRiU7AgrtY5dkfJQdr2BHJj9otK9m1u/TSWOlnXm8+1D3Ae2dKoTBU5gHGhro1Px43rlMTKjVoEDXQ8Yi/J4hhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wHqGfAbC5Qe2KznNPCXHPA2XLGTi8fJb0U3+OkhdMGQ=;
 b=nrlXJxbzyDh32mgt4W88A10Wk6SkSjygMyeWBSf/qau0vxfVDiD1uyZHhNdWXYy8kNjk02LJQhQh5h6zfMNUinJmdF/2eAsBJZ5YWoIB12njZcuYygZxH36QIdIArgiIa0Z4BtCtWzvykwKx+p5hyVE2bPqF7p+/OuvZQbXCmLd8gUEnut+YEY+Drb7V1II/uLqasLyPn0n1THzD+RWF2uiBjVgNRrg1UkBESjOlajzOc1MWktr+ZDK/n8EJb/0O0CPYcjJtVGLV5lhp8LWdp2Dn+ClaRYUfdktj6Y4gBxOnxHGFMBNSc41r52HE9e/T/tsBcLER9DBCaZOMqPF2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHqGfAbC5Qe2KznNPCXHPA2XLGTi8fJb0U3+OkhdMGQ=;
 b=mEJbJK9y4YdVpKYLHAYBwIrKhrURwciA9CO3L5Il2hVvMqglNMq2DE6Fp3cgV+R0f4JccCFqmiZz4UmHdpNwVATm921pNNja/J6oftHw035n//yQKLH3IJuCIJ0UNfxJCehUTrbBd7z+IuIaqz4rB19+/YCyJ3gK9Dr15ENMC4/oUDtntFP3D2EvbFlNqll3/HDjBbHaHKz+HAQnWIzDXld2JaK6W8ZmUc1KprNShX4zl7Ykthh7rNLYuMFN3I9NVmCHH66w+GJDRtNWqeoRHi5OlpH9IbCNGYeg0mIwIIYcd11Cr60Lmsm65qaovivaDGmr5bOe6CEUSXpL2u9xWQ==
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by DM6PR12MB3289.namprd12.prod.outlook.com (2603:10b6:5:15d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 01:16:21 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::dd) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 01:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 01:16:21 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Sep
 2021 01:16:20 +0000
Received: from nvdebian.localnet (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Sep
 2021 01:16:17 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>, <peterx@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 4/5] mm: Add zap_skip_check_mapping() helper
Date:   Thu, 9 Sep 2021 11:16:14 +1000
Message-ID: <2638099.KXsLntLlZo@nvdebian>
In-Reply-To: <20210908163625.215001-1-peterx@redhat.com>
References: <20210908163516.214441-1-peterx@redhat.com> <20210908163625.215001-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21d3b3b2-03aa-40ec-f959-08d9732f6f20
X-MS-TrafficTypeDiagnostic: DM6PR12MB3289:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3289F0E0FBAF14D38A878419DFD59@DM6PR12MB3289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ogw3elQTdxxVTWnyKSilIx6LN52VtummdgPkMNj3gItwV+/bXQ5M2uuN18yiAQdmt/Vt0cOKS6+pdhAX/gnueg55+DAO8basgS3aPDpRrfM/rcBDeRRJrjIoI7XZci6ABiubU4FdYx2VxbBpbUtujQ4nR/fxXs6FU+/8z0fbvUbfJiDLO4UPkBmiAobni8uLribwm3NxKe6reDlgFtkJnLEihBt3+yR0Q9rpm9jRRPG8qejeJk+anE3yjffARU4RCFYvqGUYUuGvj2pQrWXau5Z50A9uWv8246ZOjnDmjE+9mARHlCwyhAsRkzPpCZzmj+qbspW6Zx77z5QRKcpzXMiqGmYeup2sX6bgnnoCtrUALS+gtv7/4V8LiMIxZ4TJ9m8aBMNlj1lC41YERNqF9fUl72gbTLVzG0FCYxXRG8PkLPk0bT5TtFSB4IoqfW0K+0kCLX3KB3m7OQo5Tv8ZYKFCubM635bmBavPL/h3yW0GvjH/8gwUzlTQ1gq4ptLM6mfSP6svzLxbM4GXbBQ8qzVqOvpS7FZ8udkVopne7SUfIMe0mBShlqi1SUDzJRZar/KNX0gV6M28+ULAAnls912c3RyUy8A7bpLXRn1uxosgy8eRCe6tu35pHu4v6NluDVtp+1y1Fuqdwt0irYkwWrTcQp11AV3kC/a2GXOUN4CTnpCjxBvwmi9E3ndjatJ5MVChwSe3WLnal4REH+3gTg==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(36840700001)(36906005)(16526019)(86362001)(316002)(186003)(7416002)(47076005)(36860700001)(8936002)(5660300002)(70586007)(110136005)(4326008)(478600001)(6666004)(426003)(336012)(33716001)(9576002)(82740400003)(2906002)(8676002)(9686003)(26005)(7636003)(82310400003)(70206006)(83380400001)(356005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 01:16:21.3755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d3b3b2-03aa-40ec-f959-08d9732f6f20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3289
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alistair Popple <apopple@nvidia.com>

On Thursday, 9 September 2021 2:36:25 AM AEST Peter Xu wrote:
> Use the helper for the checks.  Rename "check_mapping" into "zap_mapping"
> because "check_mapping" looks like a bool but in fact it stores the mapping
> itself.  When it's set, we check the mapping (it must be non-NULL).  When it's
> cleared we skip the check, which works like the old way.
> 
> Move the duplicated comments to the helper too.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm.h | 16 +++++++++++++++-
>  mm/memory.c        | 29 ++++++-----------------------
>  2 files changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d1126f731221..ed44f31615d9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1721,10 +1721,24 @@ extern void user_shm_unlock(size_t, struct ucounts *);
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
> +	return details->zap_mapping &&
> +	    (details->zap_mapping != page_rmapping(page));
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




