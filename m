Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80345397E50
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhFBCBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:01:05 -0400
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com ([40.107.223.63]:14528
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229635AbhFBCBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:01:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7L0p30xfy3a/CesindZajSRTYAZYspUyr03oMzbcGSWyEpx3wCjXDpol/wBQEQANDVU8rKOa9OWadcDzEFf/ItphiShfu7hjIg3prtXu1rDAGOF1PsFZ+D9fToEAtHo/drMpyMxsXQMxx4Xt9LHsW/s39DP1UHvjghN1KSGSvd6nXLDOYibgt7cZOn7drgqq9dvKv6qfb0BrADtuwBzCLjmydU32K1HllYw3LYnSQqMcGuHjuLHBgiIaxoYgvvt7Qm0A+UQb0IF5PBOuxjfHCT4LUo0+8f30Dup0Bb361/AMXHfb+S+NJQwFMlr/uY1Pkh1C/UOZdHeZShbgt1Llg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHI4+Qucd0Hu1dlyb5yYiDuNnX/F0omoptxftED+YC4=;
 b=Y8jYADFVUNxggGv3RfGwdT6fcNfhtOFgSCkA5UKkNHnOxbZOz9GIKKWZmapiNR+NR6rsT+i6YJTEs2YkzKcEjPuffjStuKUpeYyHS0N1AYoAdzsSynFas+bO5wGgiSwuk4BsFRQFkh116wNhce7kd5ak8IYWmpitgTDsp00eZkiMcvxaNDVAtGZD4384Cz3HeMbBpaYdgqmJIzb5F7pZ7s6qvap5iJzrvcZ26vtYnC2ikVhm8x6MziyEFU4TktkzEseGfsmMafDd6egQFOjfOAJDhY5+3J1YdjbvONQfDAbkx1Adp46DmviI9+RL9CF1NLDZ2x87fHAAliXJHNPmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHI4+Qucd0Hu1dlyb5yYiDuNnX/F0omoptxftED+YC4=;
 b=jGoC4QhAV/exxC2/urTOwmeYf6ZDavaIz8Lf1SNaWsTC13SkrhTya5sCPFX9fq7P4vwRJZRyVsd0ecz/xPW/rO9n6R+Cyo+fEgwAGmy0lGcU/y0d1joc+rgRAOVldHQtM9vlXenyUh9W76whl86QjV28lhwO/9hYnl6lOBeMuXj9PIEpbUnSDcS/fho13o4UIOL7P4EEAn6hghuQ6Luuqt6mQaFJUgh4fUDiXCJG060rNGzaCLnpJj/KS62Y1IawsIMJAsyyn4KFnArg+c6eDq4xGi3BE34usNy/H9U3pB2Isgpk78yph5fY5riTYUgeB1XJMI7GN2ZWhpx8BHYYTw==
Received: from DM6PR12CA0021.namprd12.prod.outlook.com (2603:10b6:5:1c0::34)
 by DM5PR12MB1579.namprd12.prod.outlook.com (2603:10b6:4:c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.26; Wed, 2 Jun 2021 01:59:19 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::14) by DM6PR12CA0021.outlook.office365.com
 (2603:10b6:5:1c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 2 Jun 2021 01:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 01:59:19 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 01:59:16 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Naoya Horiguchi" <naoya.horiguchi@nec.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] mm/thp: try_to_unmap() use TTU_SYNC for safe DEBUG_VM splitting
Date:   Wed, 2 Jun 2021 11:59:13 +1000
Message-ID: <5096506.aDjlqC2hHN@nvdebian>
In-Reply-To: <alpine.LSU.2.11.2106011405510.2148@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011405510.2148@eggly.anvils>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb162bcf-3d79-43dd-4880-08d9256a08ed
X-MS-TrafficTypeDiagnostic: DM5PR12MB1579:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15791A4E941BC9C4AE668B67DF3D9@DM5PR12MB1579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ieA9MD/HO0znhspe3KaAJhFYsj0ScUbSbw3uSHtZ9kxcSKEMPCMw1EduEf/69PvnVI0U8wzia7onHhtFEhhiW1bA2P2sn5gjpHp0s6meXURMgJZBAOl3N/Bsn9bwO3Ozzx/MATznzlQgNQOTHMT8j95I289sMLf4wtW7QXyD4NBkKCynJt6RNAkrj7O4WD+BKi/KVzIZNzZ5X/9SryrTZNOTP6DQo0ZNedpWrXQMZLRNCsNZJz0mv0CxyrQc6taxtgMGC/x/waEEotm1hrFSNKHtzV3ZGcw/G+TKRqLzS/KINc8q7yfplU/nz6LT+wdbyfTDRErTb7ai3zQpuky09vXc7eCCURt2WkOc4Rxj6giVXvhzIXzriG0QfCYKlMcAcqYcMMopLet+DSguK/NRPJIHrEMsZcBRbRgxA3RSe293mJfk0egxYoEZ0A2PgGYR/q9RelSf2LurWUurwiGVFYTLlydh46Y4NIVD9RJ3RUq3N04Sou8H310gonCLg+Jnk0iwtO/o3UUnta+C++t5AoQEQEsuav4ySML5opZu0xwdAfrrRagqn3+udKziuPCZdboWs4U1xLE1JcSXveRZBKvN3oGbqzTIKZQlOs+uhjIHV5f7aqhA73Rcu00g3SHQkDg39QFwLoOiO7J44CycP3nRIH4bS7HtvuEX82ceZxY=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(36840700001)(33716001)(26005)(6666004)(82310400003)(70206006)(36906005)(47076005)(54906003)(16526019)(478600001)(316002)(36860700001)(82740400003)(356005)(426003)(83380400001)(9576002)(86362001)(2906002)(7636003)(8936002)(9686003)(4326008)(336012)(6916009)(8676002)(5660300002)(7416002)(70586007)(186003)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 01:59:19.5125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb162bcf-3d79-43dd-4880-08d9256a08ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1579
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 2 June 2021 7:07:53 AM AEST Hugh Dickins wrote:
> External email: Use caution opening links or attachments
> 
> 
> Stressing huge tmpfs often crashed on unmap_page()'s VM_BUG_ON_PAGE
> (!unmap_success): with dump_page() showing mapcount:1, but then its
> raw struct page output showing _mapcount ffffffff i.e. mapcount 0.
> 
> And even if that particular VM_BUG_ON_PAGE(!unmap_success) is removed,
> it is immediately followed by a VM_BUG_ON_PAGE(compound_mapcount(head)),
> and further down an IS_ENABLED(CONFIG_DEBUG_VM) total_mapcount BUG():
> all indicative of some mapcount difficulty in development here perhaps.
> But the !CONFIG_DEBUG_VM path handles the failures correctly and silently.
> 
> I believe the problem is that once a racing unmap has cleared pte or pmd,
> try_to_unmap_one() may skip taking the page table lock, and emerge from
> try_to_unmap() before the racing task has reached decrementing mapcount.
> 
> Instead of abandoning the unsafe VM_BUG_ON_PAGE(), and the ones that
> follow, use PVMW_SYNC in try_to_unmap_one() in this case: adding TTU_SYNC
> to the options, and passing that from unmap_page() when CONFIG_DEBUG_VM=y.
> It could be passed in the non-debug case too, but that would sometimes add
> a little overhead, whereas it's rare for this race to result in failure.
> 
> mm/memory-failure.c:hwpoison_user_mappings() should probably use the new
> TTU_SYNC option too, just in case this race coincides with its attempts to
> unmap a failing page (THP or not); but this commit does not add that.
> 
> Fixes: fec89c109f3a ("thp: rewrite freeze_page()/unfreeze_page() with
> generic rmap walkers") Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  include/linux/rmap.h |  3 ++-
>  mm/huge_memory.c     |  4 ++++
>  mm/page_vma_mapped.c |  8 ++++++++
>  mm/rmap.c            | 17 ++++++++++++++++-
>  4 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index def5c62c93b3..891599a4cb8d 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -97,7 +97,8 @@ enum ttu_flags {
>                                          * do a final flush if necessary */
>         TTU_RMAP_LOCKED         = 0x80, /* do not grab rmap lock:
>                                          * caller holds it */
> -       TTU_SPLIT_FREEZE        = 0x100,                /* freeze pte under
> splitting thp */ +       TTU_SPLIT_FREEZE        = 0x100, /* freeze pte
> under splitting thp */ +       TTU_SYNC                = 0x200, /* avoid
> racy checks with PVMW_SYNC */ };
> 
>  #ifdef CONFIG_MMU
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9fb7b47da87e..305f709a7aca 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2357,6 +2357,10 @@ static void unmap_page(struct page *page)
>         if (PageAnon(page))
>                 ttu_flags |= TTU_SPLIT_FREEZE;
> 
> +       /* Make sure that the BUGs will not bite */
> +       if (IS_ENABLED(CONFIG_DEBUG_VM))
> +               ttu_flags |= TTU_SYNC;
> +
>         unmap_success = try_to_unmap(page, ttu_flags);
>         VM_BUG_ON_PAGE(!unmap_success, page);
>  }
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 2cf01d933f13..b45d22738b45 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -212,6 +212,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk
> *pvmw) pvmw->ptl = NULL;
>                 }
>         } else if (!pmd_present(pmde)) {
> +               /*
> +                * If PVMW_SYNC, take and drop THP pmd lock so that we
> +                * cannot return prematurely, while zap_huge_pmd() has
> +                * cleared *pmd but not decremented compound_mapcount().
> +                */
> +               if ((pvmw->flags & PVMW_SYNC) &&
> +                   PageTransCompound(pvmw->page))
> +                       spin_unlock(pmd_lock(mm, pvmw->pmd));
>                 return false;
>         }
>         if (!map_pte(pvmw))
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 693a610e181d..07811b4ae793 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1405,6 +1405,15 @@ static bool try_to_unmap_one(struct page *page,
> struct vm_area_struct *vma, struct mmu_notifier_range range;
>         enum ttu_flags flags = (enum ttu_flags)(long)arg;
> 
> +       /*
> +        * When racing against e.g. zap_pte_range() on another cpu,
> +        * in between its ptep_get_and_clear_full() and page_remove_rmap(),
> +        * try_to_unmap() may return false when it is about to become true,
> +        * if page table locking is skipped: use TTU_SYNC to wait for that.
> +        */
> +       if (flags & TTU_SYNC)
> +               pvmw.flags = PVMW_SYNC;
> +

If this gets applied on top of my series then I think we would also need to 
add this to the start of try_to_migrate_one() as I assume you can hit this bug 
regardless of whether unmapping vs. installing swap migration entries.

We would also need to update the flag check at the start of try_to_migrate() 
to allow passing TTU_SYNC.

>         /* munlock has nothing to gain from examining un-locked vmas */
>         if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
>                 return true;
> @@ -1777,7 +1786,13 @@ bool try_to_unmap(struct page *page, enum ttu_flags
> flags) else
>                 rmap_walk(page, &rwc);
> 
> -       return !page_mapcount(page) ? true : false;
> +       /*
> +        * When racing against e.g. zap_pte_range() on another cpu,
> +        * in between its ptep_get_and_clear_full() and page_remove_rmap(),
> +        * try_to_unmap() may return false when it is about to become true,
> +        * if page table locking is skipped: use TTU_SYNC to wait for that.
> +        */
> +       return !page_mapcount(page);
>  }
> 
>  /**
> --
> 2.32.0.rc0.204.g9fa02ecfa5-goog




