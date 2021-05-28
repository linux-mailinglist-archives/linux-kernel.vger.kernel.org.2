Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B9393ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhE1Iee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:34:34 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:38176
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229774AbhE1Ied (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:34:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqcv9MtdV4Nh7ytTBptJMFZOtBWeOdXfebYqjcRNT31XW7omD3gS/ZIANl7xRKuze7tdL9YqU04mS+XK2vb8+rpd+4AM1hCQ/jUhlCknyZkRF7yga6VRQ17Qo7pSg2WJ45cFECgcYYLIARwTFexk1gVFWoTs+hBwQQC7car7X8qskH5oeHfx/yd6DGVq0xLyvIq5VI+gvIp9O/qdVRs7a4/pzB1TtwDfceYUQ/DDOi2qekhgO0050U7nkVkZbPreA98Nehfb53mmMTsI9t4eR/YCQvhRPDI/lf3SlhkqwwIjomacFCHTBJxVng/yB+XYD0blSKJiDRkYZ+6ZxcsJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ju74Hh17stW8MPFxHCajoMG6u1aBuqidXGEFX0Au98k=;
 b=Qket3ITizWEFB/61JimJBktFqjzK/gpxuPvFVjTw+Ep4xxMB7RkC7Wj5JUjJcPmAIUvPUxU/jVJweVzbWQb7Be7DPgAfB+lLXiUG+au5Y97r/L8W4iAAPvMAAN7gMGYmHROZah/322GvQ3D1Btqk29zfB9oiulplHHrWCOZqP4aE/de5xyS8OaHdVKRMzTziZm3hzQeETGqP+7UVhS3YboaIUeWjKBVZ01tLdMTCClVQ3DiE5O55jbzQOEORDCipgU3XHgEN/tJBz06RJv05lXgmoqIJaUVe2Q0UrmGtKwL7Elaihe0Kya/11pHdZ7BjaabR9OdOl7tBnYivRT7EdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ju74Hh17stW8MPFxHCajoMG6u1aBuqidXGEFX0Au98k=;
 b=PDaRu3zyRwLM3r11gCk9V0rufQirBs4VG/zZr8JhGs5NzNYYKAfsFJZ/BvZiD7tjz8pUnyqbOkAKDHrjlduMgk0r8Bx4bmnoHtZMf5qonqyh/ivNQlCEgy6tg8eMtpLOEx6F6MXXzeeMi9sLDUaMI9pJyCjSFINSjBFOtvAS20ejwmrQ+qIp1fSDbGz2v+/DhziSmbu9XCm7DQYMsMWYI3kg3IK2wbXn97TSkqX/E99zWTYOrwENjVHznZPR5HJTg1K1QTWfOxCqVmMj+yrYfMMdLJsFILv5Tp3JAMdzed4Mc7/0EdTwemGwQwNNcebnzhNwgn9HWiTmnILd/jAKnw==
Received: from DM5PR20CA0014.namprd20.prod.outlook.com (2603:10b6:3:93::24) by
 DM6PR12MB3643.namprd12.prod.outlook.com (2603:10b6:5:3d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.26; Fri, 28 May 2021 08:32:58 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::e) by DM5PR20CA0014.outlook.office365.com
 (2603:10b6:3:93::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 08:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 08:32:58 +0000
Received: from nvdebian.localnet (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 May
 2021 08:32:55 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 04/27] mm/userfaultfd: Introduce special pte for unmapped file-backed mem
Date:   Fri, 28 May 2021 18:32:52 +1000
Message-ID: <4422901.rTkcW5k3cD@nvdebian>
In-Reply-To: <20210527201927.29586-5-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com> <20210527201927.29586-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4eae00d-2c53-4278-a845-08d921b332bc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3643:
X-Microsoft-Antispam-PRVS: <DM6PR12MB364330EED0704FA19A161BCFDF229@DM6PR12MB3643.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsHn5jP44xXQWpLbG6wYJvi/9bTIgRUHnzWlob/BAlfJJ0LSN/BssBwuY4VFNJyashTIbPghBU2nOO7bkqvxa3kSLtMtPZbkj9kzPs1swYxE9TfcujajThv2Hf87i5e2+2jeV0nZu25uRvp6AnBUa9TpjxVvMRnkmLct9viIgjTZw4Zmypzs+s0SZhIWiv4D9JO3tbA459J+80ww/uMNOKFJPFR75l6FcxEroB97u1F65RcT4mxiGFDsAejm8ewd/XPsGlo5VaLHJ286OoIQL+psgt6d7SebNcqFy1WyLRby5xdj61Tt0nTz8Nkyld7WXTxsQbsu5ZtOplNt9TN715wuj1yzfnmckZDO77yC2RxBeSNyzGMO/FIDK8RJyh9N79GOjD6xl9LXJY9qPtHBWPA5JM2OlDHkbOJj9Uu2wjeMzraOq0/fXT3P6aty9R83Oco34oIPn/hniPj/bhrTVNB4rKAcSqn0wRhDJRnmWPH4uK2g1Zz5j7n9qKEC3NYst6Ygg+X/gJCjS27mmcTBXQLx2T4EacuQPQMsXqHIjhUkEB4INLaI+y+4Py45CCkF0XL0zUmZAB7UzyCausSpQEKhzIAn6d8Pyh5QINf80FpiH9anW8BRkS+asB6+tsltsDyiGyBEbRUb0Oj/XQJSsVCO7pKaas90xzXTYMUNv4iW3pab9lUcV6DJaD+U8SFCKsvYSWKJrPSnOayVlJmtbNHPlCEm2948aF2MCKV6pjlYOvN9dssHq/+bC8wjDxvvLrte4UJrjIX80UwO0gBAq1emMDoGe2qxddlSpvouT9PHhcd7N7jU8G7qhVudTrawF3TVrcvBnGtqDjtyfDU0JA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(33716001)(316002)(7416002)(83380400001)(36906005)(9686003)(70206006)(7636003)(2906002)(70586007)(356005)(82310400003)(5660300002)(82740400003)(16526019)(186003)(4326008)(9576002)(6666004)(6916009)(54906003)(86362001)(26005)(8936002)(478600001)(426003)(966005)(47076005)(336012)(36860700001)(8676002)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 08:32:58.2713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4eae00d-2c53-4278-a845-08d921b332bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3643
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 28 May 2021 6:19:04 AM AEST Peter Xu wrote:
> This patch introduces a very special swap-like pte for file-backed memories.
> 
> Currently it's only defined for x86_64 only, but as long as any arch that
> can properly define the UFFD_WP_SWP_PTE_SPECIAL value as requested, it
> should conceptually work too.
> 
> We will use this special pte to arm the ptes that got either unmapped or
> swapped out for a file-backed region that was previously wr-protected.  This
> special pte could trigger a page fault just like swap entries, and as long
> as the page fault will satisfy pte_none()==false && pte_present()==false.
> 
> Then we can revive the special pte into a normal pte backed by the page
> cache.
> 
> This idea is greatly inspired by Hugh and Andrea in the discussion, which is
> referenced in the links below.
> 
> The other idea (from Hugh) is that we use swp_type==1 and swp_offset=0 as
> the special pte.  The current solution (as pointed out by Andrea) is
> slightly preferred in that we don't even need swp_entry_t knowledge at all
> in trapping these accesses.  Meanwhile, we also reuse _PAGE_SWP_UFFD_WP
> from the anonymous swp entries.

So to confirm my understanding the reason you use this special swap pte 
instead of a new swp_type is that you only need the fault and have no extra 
information that needs storing in the pte?

Personally I think it might be better to define a new swp_type for this rather 
than introducing a new arch-specific concept. swp_type entries are portable so 
wouldn't need extra arch-specific bits defined. And as I understand things not 
all architectures (eg. ARM) have spare bits in their swap entry encoding 
anyway so would have to reserve a bit specifically for this which would be 
less efficient than using a swp_type.

Anyway it seems I missed the initial discussion so don't have a strong opinion 
here, mainly just wanted to check my understanding of what's required and how 
these special entries work.

> This patch only introduces the special pte and its operators.  It's not yet
> applied to have any functional difference.
> 
> Link: https://lore.kernel.org/lkml/20201126222359.8120-1-peterx@redhat.com/
> Link: https://lore.kernel.org/lkml/20201130230603.46187-1-peterx@redhat.com/
> Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/include/asm/pgtable.h     | 28 ++++++++++++++++++++++++++++
>  include/asm-generic/pgtable_uffd.h |  3 +++
>  include/linux/userfaultfd_k.h      | 21 +++++++++++++++++++++
>  3 files changed, 52 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index b1099f2d9800..9781ba2da049 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1329,6 +1329,34 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t
> pmd) #endif
> 
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> +
> +/*
> + * This is a very special swap-like pte that marks this pte as
> "wr-protected" + * by userfaultfd-wp.  It should only exist for file-backed
> memory where the + * page (previously got wr-protected) has been unmapped
> or swapped out. + *
> + * For anonymous memories, the userfaultfd-wp _PAGE_SWP_UFFD_WP bit is kept
> + * along with a real swp entry instead.
> + *
> + * Let's make some rules for this special pte:
> + *
> + * (1) pte_none()==false, so that it'll not trigger a missing page fault.
> + *
> + * (2) pte_present()==false, so that it's recognized as swap (is_swap_pte).
> + *
> + * (3) pte_swp_uffd_wp()==true, so it can be tested just like a swap pte
> that + *     contains a valid swap entry, so that we can check a swap pte
> always + *     using "is_swap_pte() && pte_swp_uffd_wp()" without caring
> about whether + *     there's one swap entry inside of the pte.
> + *
> + * (4) It should not be a valid swap pte anywhere, so that when we see this
> pte + *     we know it does not contain a swap entry.
> + *
> + * For x86, the simplest special pte which satisfies all of above should be
> the + * pte with only _PAGE_SWP_UFFD_WP bit set (where
> swp_type==swp_offset==0). + */
> +#define  UFFD_WP_SWP_PTE_SPECIAL  __pte(_PAGE_SWP_UFFD_WP)
> +
>  static inline pte_t pte_swp_mkuffd_wp(pte_t pte)
>  {
>  	return pte_set_flags(pte, _PAGE_SWP_UFFD_WP);
> diff --git a/include/asm-generic/pgtable_uffd.h
> b/include/asm-generic/pgtable_uffd.h index 828966d4c281..95e9811ce9d1
> 100644
> --- a/include/asm-generic/pgtable_uffd.h
> +++ b/include/asm-generic/pgtable_uffd.h
> @@ -2,6 +2,9 @@
>  #define _ASM_GENERIC_PGTABLE_UFFD_H
> 
>  #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> +
> +#define  UFFD_WP_SWP_PTE_SPECIAL  __pte(0)
> +
>  static __always_inline int pte_uffd_wp(pte_t pte)
>  {
>  	return 0;
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 331d2ccf0bcc..93f932b53a71 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -145,6 +145,17 @@ extern int userfaultfd_unmap_prep(struct vm_area_struct
> *vma, extern void userfaultfd_unmap_complete(struct mm_struct *mm,
>  				       struct list_head *uf);
> 
> +static inline pte_t pte_swp_mkuffd_wp_special(struct vm_area_struct *vma)
> +{
> +	WARN_ON_ONCE(vma_is_anonymous(vma));
> +	return UFFD_WP_SWP_PTE_SPECIAL;
> +}
> +
> +static inline bool pte_swp_uffd_wp_special(pte_t pte)
> +{
> +	return pte_same(pte, UFFD_WP_SWP_PTE_SPECIAL);
> +}
> +
>  #else /* CONFIG_USERFAULTFD */
> 
>  /* mm helpers */
> @@ -234,6 +245,16 @@ static inline void userfaultfd_unmap_complete(struct
> mm_struct *mm, {
>  }
> 
> +static inline pte_t pte_swp_mkuffd_wp_special(struct vm_area_struct *vma)
> +{
> +	return __pte(0);
> +}
> +
> +static inline bool pte_swp_uffd_wp_special(pte_t pte)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_USERFAULTFD */
> 
>  #endif /* _LINUX_USERFAULTFD_K_H */




