Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1593845034F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhKOLYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:24:48 -0500
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com ([40.107.94.83]:53344
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231236AbhKOLYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:24:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKIEYj1V+6Rp0GQiPrnbY43TsdLtujrOPJ/5LkGNhRRmbt0ryncHORb8G4TfrRYfHrVUDhu8Exy7lGtT0SkjFbRgegHtDOxrfD7vwBF0cpTY8QCJdOdOOgzzAftYD95MuwbVXwCnIw5qsKmgT5Eq9Epu5YUIbQo5yLsPNqKQcht4qKZF6YRY/UJjIne3zDsPvfWdg9KZxdXYPmFc8bj29b80g2ybPfSNHvG62ANz0EDS6Bc1WaKY5TROZii1pYPaVxDEwSI7Uj8jTldj4RqCVeyOtQ83UXGp/iPTPdXcmK6MONT4rmZWs7bwk4c2TepQAvHJmI21WkuX0belWVPKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UoSqoxUr9FXt2tcXkGIPQMb+duh/tWp45bk2x3BGtU=;
 b=CoZoJJfEs3bJfTMh8cra9Kvc6y+SreymccpSpooDRfL8xDfW0KJDHAQJWnw6a0E04KCOsuhouwDgbb8rACzHa4swWSPXieUNXjeCnbz37xTY61lzlKJ89xEJApzw/dEKXRdx06ZVNWMtNJuLoT/wCPXpbo6ixFnYfpOepxArMfW1yAOgbAJPHw5NIunrWsdQ5NZuHYqqb09ty/TcWhw8CCsZPXPxYReKeAdQf7aS7qBmrgUvY+wawRI6SZnM/r8n+C7ermwraQ0ocI0rnKp0MjnIWUjwIjpFdj75J6exVz/RjdfmExZi/LedJYcsDrBQG3GlS2E4BFMX7reS74rZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UoSqoxUr9FXt2tcXkGIPQMb+duh/tWp45bk2x3BGtU=;
 b=cAuqb2RPNnvPVUGL5U99inWNVydSfvgTgqxyDk8P4c1cVn0a6JMNsa+zn3q0JYQv1UwXz1KQXGaq79qtqDtnJVt35xCRzUQcgd/SY50xtuGwz3sGsZHF8VIc8aBs3snYkBV4K1DvZj6RSQ8N8rtw/5VnRlvOSDkU1oRsjjJjnI28ldSWLnfrGx0Ah0f5NSwntmK2Ip2DgQxfohrES6CMS+WyeymEvBfYRxFvxSu2GCNZg93e1hU864+LBQ1/jHikMy/R1f+b63CUPhCdU1+3MfKcZYAQHHxg0J6aimtd+xYmP9O8iwysMgNOpqXuLn3SB2jXXr3B3kf6DHRkk7en4Q==
Received: from MWHPR11CA0027.namprd11.prod.outlook.com (2603:10b6:300:115::13)
 by SN1PR12MB2397.namprd12.prod.outlook.com (2603:10b6:802:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Mon, 15 Nov
 2021 11:21:24 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::95) by MWHPR11CA0027.outlook.office365.com
 (2603:10b6:300:115::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Mon, 15 Nov 2021 11:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 11:21:24 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 15 Nov
 2021 11:21:20 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>
CC:     <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC 2/2] mm: Rework swap handling of zap_pte_range
Date:   Mon, 15 Nov 2021 22:21:18 +1100
Message-ID: <71100340.4M9YG836mP@nvdebian>
In-Reply-To: <20211110082952.19266-3-peterx@redhat.com>
References: <20211110082952.19266-1-peterx@redhat.com> <20211110082952.19266-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfd776ce-4083-4dd4-365a-08d9a82a0ef9
X-MS-TrafficTypeDiagnostic: SN1PR12MB2397:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23970CC90825AB84FC4F8DA8DF989@SN1PR12MB2397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W48UvNTdlJb5RFupeOsviskUIrP1DQ05KtjKyeCJ4tTAWYEbCKf5z3M4soB8YNV3Re+3xxm6nPCg9n9NqgG9WuyvcT9rrzY46bR1t235kbvH50CL/O+idqW5isBPrVgn7Rg/TumSuyZhYRnrNkTBfCqBv8SXXwe9btsLNPhkxf5qpgzvu60Aq64BKBsLExaaYaeGtIyBV2WThNaTZUKB6yUO2/+Gn9NOH1CC6/sf0WdqADjkjU7I2Hf2qmFgi225WgRIb3xnmtzcWytd/kk/JnXJYyTRc9u111DHGCKHPRK+itBScRctGPvO6/9mKO1cVD1nTfZ/inoLVAC35SjCJ6m68/QpyDuTg6s8FekwfL3Pok9Ni/5aw9ZRYJJD59JHKej3NF3acXnHlALZbfL+gSXG7TmszECdpOBad+G3nw1+ycD3WnlpZ7HDsuSqTr79osug3h/qBHhWs1NXXVqf1ZWImqLP8rVkk6fBB09yQFojUCb3Gy9KRwqUhxcbtfHSUzg6fOui66lmoiEJRSjqF66ocfbVKPTh1bDPQHjLG1YXudu8gi248nQXWDCkndcDsjs8+R7WUfYqWiQcfxP+FNOP/XQXRwsPq7N+yZ5MTXUBw1X92N9B4WX74TaDrf8ujnQC+wln5ZTD6qeYnIiWjzVTZ6kaGiOSCT8Kna7OzygemADFlFXiKJxWdoUs6tPz68eMmIIThNAsQVrHfwK9DiJBepR5HRoCN7U/OzkPa1o=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(110136005)(4326008)(36860700001)(356005)(8936002)(26005)(8676002)(316002)(86362001)(2906002)(5660300002)(54906003)(9576002)(7416002)(83380400001)(508600001)(47076005)(70586007)(7636003)(426003)(9686003)(16526019)(82310400003)(36906005)(186003)(336012)(33716001)(70206006)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 11:21:24.1872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd776ce-4083-4dd4-365a-08d9a82a0ef9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2397
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I was having trouble applying this cleanly to any of my local trees so was
wondering which sha1 should I be applying this on top of? Thanks.

 - Alistair

On Wednesday, 10 November 2021 7:29:52 PM AEDT Peter Xu wrote:
> Clean the code up by merging the device private/exclusive swap entry handling
> with the rest, then we merge the pte clear operation too.
> 
> struct* page is defined in multiple places in the function, move it upward.
> 
> free_swap_and_cache() is only useful for !non_swap_entry() case, put it into
> the condition.
> 
> No functional change intended.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memory.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e454f3c6aeb9..e5d59a6b6479 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1326,6 +1326,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  	arch_enter_lazy_mmu_mode();
>  	do {
>  		pte_t ptent = *pte;
> +		struct page *page;
> +
>  		if (pte_none(ptent))
>  			continue;
>  
> @@ -1333,8 +1335,6 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			break;
>  
>  		if (pte_present(ptent)) {
> -			struct page *page;
> -
>  			page = vm_normal_page(vma, addr, ptent);
>  			if (unlikely(zap_skip_check_mapping(details, page)))
>  				continue;
> @@ -1368,32 +1368,23 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  		entry = pte_to_swp_entry(ptent);
>  		if (is_device_private_entry(entry) ||
>  		    is_device_exclusive_entry(entry)) {
> -			struct page *page = pfn_swap_entry_to_page(entry);
> -
> +			page = pfn_swap_entry_to_page(entry);
>  			if (unlikely(zap_skip_check_mapping(details, page)))
>  				continue;
> -			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>  			rss[mm_counter(page)]--;
> -
>  			if (is_device_private_entry(entry))
>  				page_remove_rmap(page, false);
> -
>  			put_page(page);
> -			continue;
> -		}
> -
> -		if (!non_swap_entry(entry))
> -			rss[MM_SWAPENTS]--;
> -		else if (is_migration_entry(entry)) {
> -			struct page *page;
> -
> +		} else if (is_migration_entry(entry)) {
>  			page = pfn_swap_entry_to_page(entry);
>  			if (unlikely(zap_skip_check_mapping(details, page)))
>  				continue;
>  			rss[mm_counter(page)]--;
> +		} else if (!non_swap_entry(entry)) {
> +			rss[MM_SWAPENTS]--;
> +			if (unlikely(!free_swap_and_cache(entry)))
> +				print_bad_pte(vma, addr, ptent, NULL);
>  		}
> -		if (unlikely(!free_swap_and_cache(entry)))
> -			print_bad_pte(vma, addr, ptent, NULL);
>  		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>  	} while (pte++, addr += PAGE_SIZE, addr != end);
>  
> 




