Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67B39A04A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFCLzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:55:38 -0400
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:45017
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229804AbhFCLzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:55:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A17yWOHGybCQ3iW+Hd9dYTgS/JX26W8SlwlRaA/o/0sEHFkl0oMmqr25MU/GMD++xtV4FOh3D8hjUWzjNzuEf2V1hWd9G1EEYqgq91IxMpNBNCR5ANYr16QN0KgO451AH5v4eE04w1Q/awVdjfXgsoDEnNz7jOnYgI31CnnBMfKVqChCvQXcQD6FtjIAI4RZG+Tf0LESKLb6tq9C6leig1+yp7VeYW/t64+8lPACSv1iPtwagbud7cW+wya/DpPFpUN524LQsiE9jiFdpUfSiR+OGzdc84iOW6aSd35rYWUdF4U9q9lOmGlEkA8yLxq1qhMa7RUyAp4DCPh78MtHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4WUDyJj7gTOYbYEemLtapHbT97B1ctIxxNNdqaJGr4=;
 b=hXyCd5ShIao1M8gTadT9aVanfRnaHAiaqrHNRuVSzIGzNiCQkOeYWBD2omZN6lMsmxgiEeiDn67JD1cQL6VTU9uA1GjCBK0xy7t7VwDkuyshOWOYiuP5NQjBgKnyOh/epXxgJPoRQDYZeMEpaTuZduopxKJ0taUn26X5hhqRRyZZz12U3h+WLiXfmf9BAtKjjdsJWP24VBzV3c8jvUztmDnSHmAuMpNzkhLJuO43ExkmVZo3YxVC7GCbP7okWMWcjAFJ77Qb8VuYt+yKJ7965SlK2QI3fz5TyKiCG4evHtDJmtGRgYWnTyxP3GcLWMJnbGEORfm8w7Or0aduxC6DyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4WUDyJj7gTOYbYEemLtapHbT97B1ctIxxNNdqaJGr4=;
 b=g19UjXyYLkZCeBlR7Oio7HcYQUS8kNMi4H2/o9coTzI7MxygtLe4RNdAZqqwV0CduGdXRQIlHEl7VKCT1i0yr+ZaL/ValTmKeSH/XDTWXu6Ov87AZU9GArOxoOOxKVNaLVcMvEmqxfff6m+atlcpOCay16yM4r8qdDDLnohJJQihflKx2fLKIJQkgGj/eg7zpsR4rx6wxIyjrD0YZmCpTfk0JFy1FN8rQzGUelZgi9ESefHrUD6ZUu3UGDdGpN89p1WXXcIeal1kNbMUnKcedsQhzlzXCX3Jbf5NHan4FEZN6WU8DX+FwDkOOV2xugzGJjxPeisNPzCZekgHKwJksA==
Received: from DM5PR2001CA0008.namprd20.prod.outlook.com (2603:10b6:4:16::18)
 by BN8PR12MB2996.namprd12.prod.outlook.com (2603:10b6:408:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 3 Jun
 2021 11:53:51 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::34) by DM5PR2001CA0008.outlook.office365.com
 (2603:10b6:4:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Thu, 3 Jun 2021 11:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 11:53:50 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Jun
 2021 11:53:47 +0000
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
Date:   Thu, 3 Jun 2021 21:53:45 +1000
Message-ID: <4688876.HeLTNyGTSD@nvdebian>
In-Reply-To: <YLDoYusJ9wAeahdZ@t490s>
References: <20210527201927.29586-1-peterx@redhat.com> <4422901.rTkcW5k3cD@nvdebian> <YLDoYusJ9wAeahdZ@t490s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc3faefa-9572-4f11-f897-08d926864111
X-MS-TrafficTypeDiagnostic: BN8PR12MB2996:
X-Microsoft-Antispam-PRVS: <BN8PR12MB299651DCD2BB5792EA0FD8C1DF3C9@BN8PR12MB2996.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YeMRRErlO8GK95ZIsdoODn012hjE2xK5Cyy6RNpuAX7SJTlRgJUDkvNTEMyFf3UZm48ZRpjJk2wLiPa38FoXat2tVCfxA7aUswpRb88LhqSX2/iWGeQl1UecAcHXRffiiPyfTeaKCTn9ue+/qMF6rRqQMNPZyWM+fzBrqiAn3B94Y8l9QwRMPU/MOExvaict7/YdXbIs2yhZ2MxnCG/2bZGdOUjWV+5lx0PMSWF6eZUciOZVC8ob82zKG9t/ke6LvYpFFHNyJaDNqX/XbFx3fsRhsHeb1a2IIzY5HVPVAV2SwYB2mvN1XJRc5j0wP6wOU2aovJScRgCSPXiw++Gj63+NM59OUDe35lgJ8dYKVa8ZxHIZXBVLPjw5+SEZ6IP9TzAMdgdxq22I/zIH6AQeb431Yrw8zQ8O0+HA/6GpFz1xaaUs0fD1JaUgwFamwwLtwKpsilhPHydG/ocJPihjCk2OB9xFB17DcvuZRKQVy3QpVNU2u46VW10rY1KsjMC+4ZjpSMDjINqusXI+AfZlPRBEK9Ulnouyj1hM/m2aeuWlT0Jwx0dzGexzL/AIcbj6EZgQ96wl6q0drbWr2+t7UFLUlzfI9or6r5MVE5tlHqs7Ssixa8KzlbZJ6i6tbMhhoUFUmGvIv0B0ZGs1YhFBPRAKfJIQtmNPTTTis9n7qw=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(86362001)(478600001)(9576002)(70206006)(54906003)(82310400003)(82740400003)(426003)(6916009)(316002)(83380400001)(26005)(7636003)(356005)(4326008)(70586007)(2906002)(7416002)(16526019)(47076005)(186003)(36860700001)(336012)(8936002)(5660300002)(9686003)(36906005)(33716001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 11:53:50.7737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3faefa-9572-4f11-f897-08d926864111
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2996
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 28 May 2021 10:56:02 PM AEST Peter Xu wrote:
> On Fri, May 28, 2021 at 06:32:52PM +1000, Alistair Popple wrote:
> > On Friday, 28 May 2021 6:19:04 AM AEST Peter Xu wrote:
> > > This patch introduces a very special swap-like pte for file-backed
> > > memories.
> > > 
> > > Currently it's only defined for x86_64 only, but as long as any arch
> > > that
> > > can properly define the UFFD_WP_SWP_PTE_SPECIAL value as requested, it
> > > should conceptually work too.
> > > 
> > > We will use this special pte to arm the ptes that got either unmapped or
> > > swapped out for a file-backed region that was previously wr-protected. 
> > > This special pte could trigger a page fault just like swap entries, and
> > > as long as the page fault will satisfy pte_none()==false &&
> > > pte_present()==false.
> > > 
> > > Then we can revive the special pte into a normal pte backed by the page
> > > cache.
> > > 
> > > This idea is greatly inspired by Hugh and Andrea in the discussion,
> > > which is referenced in the links below.
> > > 
> > > The other idea (from Hugh) is that we use swp_type==1 and swp_offset=0
> > > as
> > > the special pte.  The current solution (as pointed out by Andrea) is
> > > slightly preferred in that we don't even need swp_entry_t knowledge at
> > > all
> > > in trapping these accesses.  Meanwhile, we also reuse _PAGE_SWP_UFFD_WP
> > > from the anonymous swp entries.
> > 
> > So to confirm my understanding the reason you use this special swap pte
> > instead of a new swp_type is that you only need the fault and have no
> > extra
> > information that needs storing in the pte?
> 
> Yes.
> 
> > Personally I think it might be better to define a new swp_type for this
> > rather than introducing a new arch-specific concept.
> 
> The concept should not be arch-specific, it's the pte that's arch-specific.

Right, agree this is a minor detail.
 
> > swp_type entries are portable so wouldn't need extra arch-specific bits
> > defined. And as I understand things not all architectures (eg. ARM) have
> > spare bits in their swap entry encoding anyway so would have to reserve a
> > bit specifically for this which would be less efficient than using a
> > swp_type.
> It looks a trade-off to me: I think it's fine to use swap type in my series,
> as you said it's portable, but it will also waste the swap address space
> for the arch when the arch enables it.
> 
> The format of the special pte to trigger the fault in this series should be
> only a small portion of the code change.  The main logic should still be the
> same - we just replace this pte with that one.  IMHO it also means the
> format can be changed in the future, it's just that I don't know whether
> it's wise to take over a new swap type from start.
>
> > Anyway it seems I missed the initial discussion so don't have a strong
> > opinion here, mainly just wanted to check my understanding of what's
> > required and how these special entries work.
> 
> Thanks for mentioning this and join the discussion. I don't know ARM enough
> so good to know we may have issue on finding the bits.  Actually before
> finding this bit for file-backed uffd-wp specifically, we need to firstly
> find a bit in the normal pte for ARM too anyways (see _PAGE_UFFD_WP).  If
> there's no strong reason to switch to a new swap type, I'd tend to leave
> all these to the future when we enable them on ARM.

Yeah, makes sense to me. As you say it should be easy to change and other 
architectures need to find another bit anyway. Not sure how useful it will be 
but I'll try and take a look over the rest of the series as well.

> --
> Peter Xu




