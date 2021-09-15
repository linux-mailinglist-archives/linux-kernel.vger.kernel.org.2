Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB3140BDC8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhIOC0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:26:33 -0400
Received: from mail-mw2nam10on2072.outbound.protection.outlook.com ([40.107.94.72]:61536
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229690AbhIOC0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:26:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlJ9Dg2HuHYnug0HJFjER4sAsMRT8ln6GfqoMtuTZ6c2SBRw8a3w0Oux86xedwR6nwrOIU2/iK/5XwmUZs7sIUzgIpsH3rfIc7qQ43OHq0tWWVuk9d7AI7oD2tbVczsezFrwFS6OH0C0GwhdCqXSB2pgA50rwxJrBwlB9KEsZw2ZBD7wOsZAvrDaruW42oxJ3t65tqkfrK3fT5WqBEpQqbKZojhWxgJA93FNRyUPP13VM/Qe7KouBV0S0hCztFePntoUcwxcXainygkeGRQQfK4duImfttsSWywNOg8o5CUsZkzWy36ezCJdKDjIeI9rv22eKP5fzsNKXoYKkgNTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=di/kiWLmaSBexQ2aBpjxUE0vLDGVii652Wl2GB0bG6A=;
 b=YUBQcwcQpcR3VGwWdDhGy+yZt9DR7hOgsTmcxau0iokUAF2MyKvOEs7qaNIjoYX/ZSFrXQqJi95sYd0fQCT4I6nsy26a3PVmju23Cg0TST01lytduyxsxgXKiRZVgUvaYt0hkS58czQK68pGd2hMIv+ema8J6bLCBfEJgOPWQGveiH6wAjXKprlaF7FP4/n02E5GffM6CLXFjaQDtxyvwhRA5wOQPUOq3A1I/dZ9dygsEN2LbrFXADvdNvxd4wraeCcQvqYzewMCn76eNp8ATIY5i5xQKfbH17W105PtSNYRfH3t7vtvRspP5cQN6NWcnu7baFt7iL3TCxd6Xy8WtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di/kiWLmaSBexQ2aBpjxUE0vLDGVii652Wl2GB0bG6A=;
 b=q99wGHKAXSz1T8z3WTAXHFXyjJ7zxy7fyAr7FfeH2iirWMHTfn1pUwN/lcqNCtGUj51PhUzU5XgcAnWYvaTQJfkuw8VDDPq4rqDlClQG2H8kROiHmG3zThdii4Q8j2zbKZqPhZyEvUQXfvTdJyruGPqnKTerpagTCagEbg1v/5XW+WWwNRMz5YywidDqNDr5OvHXrqRd2+f2sWFCkeNhK3tjlFcFtLk4ph043uhzrZkzh+61KRtziGH1FjLbICIUnjadW+r+1V4uLKLBUtTyGvGqJIRVpIvr8Pw/VUuGCIWUYVgMKjRhCb6BahL8ntneH/6zMUZyUWsU32MYEtZ6zg==
Received: from BN6PR11CA0068.namprd11.prod.outlook.com (2603:10b6:404:f7::30)
 by CY4PR12MB1829.namprd12.prod.outlook.com (2603:10b6:903:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 02:25:13 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::97) by BN6PR11CA0068.outlook.office365.com
 (2603:10b6:404:f7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Wed, 15 Sep 2021 02:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 02:25:13 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Sep
 2021 02:25:12 +0000
Received: from nvdebian.localnet (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Sep
 2021 02:25:09 +0000
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
Subject: Re: [PATCH v3 5/5] mm: Add ZAP_FLAG_SKIP_SWAP and zap_flags
Date:   Wed, 15 Sep 2021 12:25:07 +1000
Message-ID: <2576475.WBpAVSM2eX@nvdebian>
In-Reply-To: <20210908163628.215052-1-peterx@redhat.com>
References: <20210908163516.214441-1-peterx@redhat.com> <20210908163628.215052-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea10d790-cbf8-40fc-23c8-08d977f00c74
X-MS-TrafficTypeDiagnostic: CY4PR12MB1829:
X-Microsoft-Antispam-PRVS: <CY4PR12MB18291D6CA62A9C92226F4B80DFDB9@CY4PR12MB1829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECuFG2lRefUuSwKf/FBDg5vhRJfuZs03u3jO9+dZrUUVTf4XmB1uJzh0W6IoThk7BYG6VyETCjM78SKW5aTL7z99r/FkMdTrM35k9B/xmDjIJU9wdKpBvupV2lSJd3IAPOaWRaIKedaiSH/0MzSjLTnhrxHjgyQZJtq49ov9cJsi1069hYi0zKJ0Z6AB2ksBHGMeNqYhO5Q90AC3XZnYqnq5qxhb9mBwcBaSBbqAtpI7Az15/GP14DpjlD59JlB+rIPb+cj4nmS03dyFbWAyqgqVzz57B5JTfRHOvdoaqb2tTYMEQ6f5rNNpkRJuwHiP/emCsT4tWYzNkK8zNkCTvSZyoqxliVIWytEOMJ9MWh7vRUu5WZWVyIjDsp/HFQxzNPgnvrCjpuTsWeYw84foqIWR4iFCwnsbS+qfnc4mLyrPrbvwlzj5psRKlxErpSPnHZM6QK8h1foMyAw6Ns0S5EYAaBjaT0/tJsKbrBTqqKI0PcV3qmoeMr8ikjWPIw0gKce16B8aJh9ZPpTZN7VQO459hCC6pJKJox3wSG/SDtKEFoUdr62WEJcJRcbX5Xg9WnHLVZ1pV86s3Gkc4ypD+o9fa2zEjG21LgojEkXyXzWTgf7jKiXPcPrv1OzQ+XoKfsfuUvoS01axbOTg2B7nOcGuyAb37Eg7/oOv3/SEzGlmOXzbnYcwCFv3JCuyE8G5apt1RyjvG9rMYkWTYmDeEBmy9vK6k1+8NatXjmO69wM=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(36840700001)(46966006)(82740400003)(54906003)(70206006)(70586007)(7416002)(26005)(36906005)(316002)(16526019)(5660300002)(9576002)(8676002)(110136005)(186003)(8936002)(2906002)(83380400001)(9686003)(426003)(4326008)(47076005)(356005)(478600001)(86362001)(33716001)(82310400003)(36860700001)(7636003)(336012)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 02:25:13.2711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea10d790-cbf8-40fc-23c8-08d977f00c74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1829
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 9 September 2021 2:36:28 AM AEST Peter Xu wrote:
> Firstly, the comment in zap_pte_range() is misleading because it checks against
> details rather than check_mappings, so it's against what the code did.
> 
> Meanwhile, there's no explicit reason why passing in the details pointer should
> mean to skip all swap entries.  New user of zap_details could very possibly
> miss this fact if they don't read deep until zap_pte_range() because there's no
> comment at zap_details talking about it at all, so swap entries could be
> erroneously skipped without being noticed.
> 
> This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
> but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
> "details" parameter: the caller should explicitly set this to skip swap
> entries, otherwise swap entries will always be considered (which should still
> be the major case here).
> 
> We may want to look into when exactly we need ZAP_FLAG_SKIP_SWAP and we should
> have it in a synchronous manner, e.g., currently even if ZAP_FLAG_SKIP_SWAP is
> set we'll still look into swap pmds no matter what.  But that should be a
> separate effort of this patch.

I didn't really follow what you mean by "synchronous" here, although the
explanation about pmds makes sense so it's probably just terminology.
 
> The flag introduced in this patch will be a preparation for more bits defined
> in the future, e.g., for a new bit in flag to show whether to persist the
> upcoming uffd-wp bit in pgtable entries.

That's kind of the problem. The patch itself looks correct to me however as
mentioned it is mostly reverting a previous cleanup and it's hard to tell why
that's justified without the subsequent patches. Perhaps it makes the usage of
zap_details a bit clearer, but a comment also would with less code.

I know you want to try and shrink the uffd-wp series but I think this patch
might be easier to review if it was included as part of that series.

> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Hugh Dickins <hughd@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm.h | 16 ++++++++++++++++
>  mm/memory.c        |  6 +++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ed44f31615d9..beb784ce35b9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1717,12 +1717,18 @@ static inline bool can_do_mlock(void) { return false; }
>  extern int user_shm_lock(size_t, struct ucounts *);
>  extern void user_shm_unlock(size_t, struct ucounts *);
>  
> +typedef unsigned int __bitwise zap_flags_t;
> +
> +/* Whether to skip zapping swap entries */
> +#define  ZAP_FLAG_SKIP_SWAP  ((__force zap_flags_t) BIT(0))
> +
>  /*
>   * Parameter block passed down to zap_pte_range in exceptional cases.
>   */
>  struct zap_details {
>  	struct address_space *zap_mapping;	/* Check page->mapping if set */
>  	struct page *single_page;		/* Locked page to be unmapped */
> +	zap_flags_t zap_flags;			/* Extra flags for zapping */
>  };
>  
>  /*
> @@ -1739,6 +1745,16 @@ zap_skip_check_mapping(struct zap_details *details, struct page *page)
>  	    (details->zap_mapping != page_rmapping(page));
>  }
>  
> +/* Return true if skip swap entries, false otherwise */
> +static inline bool
> +zap_skip_swap(struct zap_details *details)
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
> index e5ee8399d270..26e37bef1888 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1379,8 +1379,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			continue;
>  		}
>  
> -		/* If details->check_mapping, we leave swap entries. */
> -		if (unlikely(details))
> +		if (unlikely(zap_skip_swap(details)))
>  			continue;
>  
>  		if (!non_swap_entry(entry))
> @@ -3353,6 +3352,7 @@ void unmap_mapping_page(struct page *page)
>  
>  	details.zap_mapping = mapping;
>  	details.single_page = page;
> +	details.zap_flags = ZAP_FLAG_SKIP_SWAP;
>  
>  	i_mmap_lock_write(mapping);
>  	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
> @@ -3377,7 +3377,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>  		pgoff_t nr, bool even_cows)
>  {
>  	pgoff_t	first_index = start, last_index = start + nr - 1;
> -	struct zap_details details = { };
> +	struct zap_details details = { .zap_flags = ZAP_FLAG_SKIP_SWAP };
>  
>  	details.zap_mapping = even_cows ? NULL : mapping;
>  	if (last_index < first_index)
> 




