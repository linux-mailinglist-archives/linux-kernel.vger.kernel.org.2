Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8103A2655
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhFJIOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:14:45 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:8940
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229895AbhFJIOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:14:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhmS+y0485Mh+ddjYKgA3ujhZbcCd7Khrom94OtYpgaSritjJhw/GyFl53llVTZIE+1WEEQlNG08vOJlKw7aITAzUIIcinEIBaCp5RXOoTlLBmG/gfaAkTPWCT47MmJvdtO0isoaazFcFjLv9YPUBkIQFMecUvH6XGG3bmSMgLwuaF1xWc7Rke8mQznJnrbmpK0YBm3claKW1OD+KQUwSJX/zDFIGEdFzrQV2JV50ly6rQqyDtZsNV3blXbvAEAFOjvkbWI/q1WFR2LVcRlcDqV8GD/fg890JVHswhllVTIOVWey8qlYRXmSA33cn3m5RuKWBoE04NJpa6V4fYKj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28UGJ5KvwjYbBiZLU17iy86U/FpyLCp+C9IYYGw/QbY=;
 b=QI1mFo3mI5WtuhVR7NqMhHviMNSdFeh0yxIDnLV13YydkmeJXsz84lkt/D1/BKlxl2dRp49WyIqH95SqyQKoGFxNwxcw5ONHUlANJm4uKFYGeym2qq9gclF00tMqFemRHZE3zHrknq0EwEbpvraLPT+sXgJZUxPrrmt5ZGGDagPisHC5kP0JlGckIU9TYUyTVcJq91VpzeZuXe+r93gM49pTyJCJhWvqLg0RekinWBOG0lQf452w9XpHrC/Mzr9KW8WUIamp6BowLY1+bRnAuMOgXkWnJdD2i5QSNImV/qzomPVrZamFXFrHrRLEWfjjfVGAL9PxJ2/X6OYo5PSqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28UGJ5KvwjYbBiZLU17iy86U/FpyLCp+C9IYYGw/QbY=;
 b=Er1nz9focDkf8Xzn6AQVCJ72QoV4Qpu5nGFyKrj4R+AYplluSMMZEkhdTbsPTqtawiwt4Id96MATgATVhKSCGDR4+MteBigWDgwn0aiEogk1ZX+XNxUzA605x73Izb7WoRLRYoo8DRN88dEipSDXgafKJkuv/LJ/MrFc7PTkcdelTfIeJjZXE/NqwdULbTyXoLp0XneqeiCUr+EipKCy6qFjat1E+TIJv0ZgiIQTvGDuoWUXPNTWwcKM4Rmz2JEqsxuWtPI5aHpCYmRf36KUtMi0TaePyAiTgkN7EyraOF33i3IZ3cpczXxgQvpq0iUJleIaqK768+LC+9JLccug0Q==
Received: from DM6PR03CA0100.namprd03.prod.outlook.com (2603:10b6:5:333::33)
 by BN8PR12MB3172.namprd12.prod.outlook.com (2603:10b6:408:68::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 10 Jun
 2021 08:12:46 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::a2) by DM6PR03CA0100.outlook.office365.com
 (2603:10b6:5:333::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 08:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 08:12:46 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 08:12:43 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/11] mm: page_vma_mapped_walk(): use page for pvmw->page
Date:   Thu, 10 Jun 2021 18:12:40 +1000
Message-ID: <3489192.qTgHbfadoh@nvdebian>
In-Reply-To: <88e67645-f467-c279-bf5e-af4b5c6b13eb@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com> <88e67645-f467-c279-bf5e-af4b5c6b13eb@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1ab939c-7a3f-4e77-200b-08d92be787c4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3172:
X-Microsoft-Antispam-PRVS: <BN8PR12MB317295DF64CFCD527711426CDF359@BN8PR12MB3172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBL5FDiyRaMDifvHzK8xwuuGfyuC2cM04hw359hds7TMj79GX/3qNHu0+gRFAteTZgWoCpMHrNTzoVwUG28w7MYwEeTQH5xedRg1lOwntKB62hWZbiHsC0pNK67/Ytmx2aqdeTkSu+skBfb0KLJXOGKRxyatVXcZSOC1S/usb0atx4iNxkEnhG5ZXeCOwDXVehrgkxeeSS11guSXM5KMM1VQWD9nBDqtdTWJt7JujrsJW+G1UWgxve0QQWUBoL7KI/EWUFvHHrbiFquFp8zuL1Z9U6eNimTzMDu6MCvQUMIMy1Vh6Bq7mJvv09jnHnmFviE/opCOltRvRmn/YSAzgm3krK0QXJAkO9Ht8vf88rji01KxoWXmnKRWfcegiLY2yWI7B49WWXxV2R+WZ/O3C7+EyVV7VdTj+xw0ofXa+sSd03ZAxzTqno+lO3lny5oLaYowjzBp5xxHMGbpDysw+Yr0MVV1g79PxkM6AqhZB4m9XlFUgn6sJodX0cuMJPl68q/MPunIWImQxCf26yrrtxemN6jH6ha3rvAciMfFlD1LOn92nMiuDPlQRglPoKeC+xGHY6kxtzWBlBmzohi3pgx+xMDBqprlO8FhpsTRcnB8YxXx6JSZMkzM3sdhJkoC6TWEw+DtrQu6lxcN1H32fynpl3vPsPkNqk16ieiOnB0=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(426003)(8676002)(8936002)(36860700001)(7636003)(54906003)(316002)(36906005)(336012)(4326008)(478600001)(26005)(186003)(9576002)(82310400003)(7416002)(16526019)(33716001)(86362001)(82740400003)(6916009)(70586007)(9686003)(5660300002)(70206006)(47076005)(356005)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 08:12:46.3793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ab939c-7a3f-4e77-200b-08d92be787c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3172
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for this, I've read through page_vma_mapped_walk() a few too many times
recently and it annoyed me enough to start writing some patches to clean it up,
but happy to see this instead.

I confirmed pvmw->page isn't modified here or in map/check_pte(pvmw), so the
patch looks good to me:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

On Thursday, 10 June 2021 4:34:40 PM AEST Hugh Dickins wrote:
> page_vma_mapped_walk() cleanup: sometimes the local copy of pvwm->page was
> used, sometimes pvmw->page itself: use the local copy "page" throughout.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/page_vma_mapped.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index e37bd43904af..a6dbf714ca15 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -156,7 +156,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>         if (pvmw->pte)
>                 goto next_pte;
> 
> -       if (unlikely(PageHuge(pvmw->page))) {
> +       if (unlikely(PageHuge(page))) {
>                 /* when pud is not present, pte will be NULL */
>                 pvmw->pte = huge_pte_offset(mm, pvmw->address, page_size(page));
>                 if (!pvmw->pte)
> @@ -217,8 +217,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>                  * cannot return prematurely, while zap_huge_pmd() has
>                  * cleared *pmd but not decremented compound_mapcount().
>                  */
> -               if ((pvmw->flags & PVMW_SYNC) &&
> -                   PageTransCompound(pvmw->page)) {
> +               if ((pvmw->flags & PVMW_SYNC) && PageTransCompound(page)) {
>                         spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
> 
>                         spin_unlock(ptl);
> @@ -234,9 +233,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>                         return true;
>  next_pte:
>                 /* Seek to next pte only makes sense for THP */
> -               if (!PageTransHuge(pvmw->page) || PageHuge(pvmw->page))
> +               if (!PageTransHuge(page) || PageHuge(page))
>                         return not_found(pvmw);
> -               end = vma_address_end(pvmw->page, pvmw->vma);
> +               end = vma_address_end(page, pvmw->vma);
>                 do {
>                         pvmw->address += PAGE_SIZE;
>                         if (pvmw->address >= end)
> --
> 2.26.2
> 




