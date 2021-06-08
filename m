Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3202E39F799
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhFHNUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:20:39 -0400
Received: from mail-dm3nam07on2061.outbound.protection.outlook.com ([40.107.95.61]:26144
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232950AbhFHNU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:20:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD5KWIIkijt5CeZFdlDbPNJctEH4VBlchOB1oPvqhFaF2mJfhn3duWO6BAyjIwwkDQJ274PnHXJZmNE8L1Nxz4H7A7CUWtxXn4wCwLU9ikS5kvcLW/IU07i//OFQOxAC8wWFjAXbfkff/4X9cDsPnIaYvkdiFL6OrS7bW5mDGsZ9bvRCcFDoljXzkWy9WQ2SQAOgV5KGcfRCRBiQ4vtbsVDQIDKEEBxghrUJqC0oJBkzSqekt5jwAw0TTtrnV6zcdmbphgWvW52PhTDi5tY0Wn9SQWbF4QN2M5pD+7kvHEZ9FvUAi0qh4MJMtiJUAXvSa6YsuRA0SW9iYwEjVf2Vug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNOP/zINPd7lKP7sX4lv9iGIusBtcz4d8X6MnMEBnUg=;
 b=E8nbqNkC6uUrdNksDb94zFcocrzk2wf2hHVjTdjwopnppKB7NwDPILv/HikPZAaRRUDPIBTHYybqgMDFENzfd9NU9tUAspZDuhrUZ3fevgIJ6pRewF8YF7jXwlYazQJftVPwMdIm3IhciUK6ueljhYvG2BffqbSpJO/Af7qm1TSQSZ+W82f4Cs5JIyEM6e/dtAE5kv8/vHwhpkomJtT+5vIHP0MdiQLHK1zuelut3obVFCLl2yT+EKs+WZ+TB3tqsPVCYrD4ofZxKsjlFI8/3/qDJ5Jk50yetfKMw8IcqeG0k06WNmjmZEdRUqAbU5a1Wf3eY2d1JRy2T9Tyboo3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNOP/zINPd7lKP7sX4lv9iGIusBtcz4d8X6MnMEBnUg=;
 b=UtVXFQr2oqdV1OQrEoJxjCvPngPK2tzqY+bnK2yt14tM8TeI+DF80TEG4MsjgNCWXK7feHWj3NUx2zjs40JW2ukMG5lyGb/XqaS91wLd5gXDgRr7ZkOx0hqvaKGN9V2BzJW4RZqXb1cg9QyDn5c1CtNH9Ipoe64e4XKpXJuzuk26ZCXMjdaPfovVRx3IZzASQY63iQtM6R1FBFEGJWIrGR2kf5xM3AOMD1YI1BAj7Cka9OpQPiz6T0NpDeNvmsrY1PSbUzaXaIumJc7IRKtv+/vY8ZWQusIKQt57Cl9wZ3mlusLBDqhXtP/b1N6l1tDM2M2wGnCdOhKlM2xOOO6CcQ==
Received: from DS7PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:3bb::28)
 by BN6PR12MB1281.namprd12.prod.outlook.com (2603:10b6:404:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Tue, 8 Jun
 2021 13:18:32 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::ca) by DS7PR03CA0083.outlook.office365.com
 (2603:10b6:5:3bb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 8 Jun 2021 13:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 13:18:32 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 13:18:28 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Hugh Dickins <hughd@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
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
Date:   Tue, 8 Jun 2021 23:18:25 +1000
Message-ID: <3035789.C3dLqLxEWu@nvdebian>
In-Reply-To: <YLpOdxWnRbWx9CL+@t490s>
References: <20210527201927.29586-1-peterx@redhat.com> <2408831.NcqaVN92ti@nvdebian> <YLpOdxWnRbWx9CL+@t490s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52ff4874-7e42-4511-43a2-08d92a7fe9fc
X-MS-TrafficTypeDiagnostic: BN6PR12MB1281:
X-Microsoft-Antispam-PRVS: <BN6PR12MB12818B7C9454D538C97DA6C1DF379@BN6PR12MB1281.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bNod8kNH1GXcUXpQS1oVi8djSWadSWHtGCzXhunNdYEXrymnGei5TXwqoZuF1ucCd2v/j13kGVR0JvyNxkM2N8SqYv3xC5vb8TQoY9Uc0iMDSB4VHbE2a+1P3Tam6ZEZW9HqIgPZJJDGw9+wdX98jDSAff+9PyjnOtmRSV6pe7mmXqHjaY6kcq2At+w7ODD6qSj0PegQgEovyAxw/FHYBUFGtHILSDmMTDLq4XDEESXQ202LtGtVRE9FLvOvKNS5vixKlY7v1wcAN7GGfPqIMYyttQxHAH8EMeYD6Fy2feqaG0FAlbf288z2JR3T02hhIxb9VThtrPiULeXI9VXc4bImRAKJNooPE1Y/rTyxBO426hg8cQkBXlUgnL7yppggEVGa9NgZbH3z24sCbMvPxWFmZ3MsMMdSEcvswevLcIinAaQtug2C63q2zOZ9awVrSfiOzgU/3k1aTiel9XqqK/lUddII261QKu5D0C3u1r1D9DaUwrJHpPEDaU8thEJQEAo0JyExa7BFBHCTNQtz4yLwwM35MOtEtl7aqrC30MYUZgp5LW2SmiAdtiwYBlpSlrNILQF70DtrRYRKGgG9DPKSHbSLyvp5z7slZelDhb5rJxqM3k5MC+fohGOfjW6Wz2jzsA/KzNu9yzmyzQlRysyghtbK/21b+oKc/MqY7NIblvlFbJbPicoQlCQC/Cf
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(36840700001)(6916009)(82740400003)(8676002)(54906003)(356005)(7636003)(47076005)(7416002)(70206006)(4326008)(478600001)(70586007)(6666004)(33716001)(426003)(26005)(2906002)(16526019)(5660300002)(186003)(36906005)(82310400003)(86362001)(36860700001)(9576002)(8936002)(83380400001)(316002)(9686003)(336012)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 13:18:32.3469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ff4874-7e42-4511-43a2-08d92a7fe9fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1281
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 5 June 2021 2:01:59 AM AEST Peter Xu wrote:
> On Fri, Jun 04, 2021 at 04:16:30PM +1000, Alistair Popple wrote:
> > > My understanding is that it does *not* use an additional arch-dependent
> > > bit, but puts the _PAGE_UFFD_WP bit (already set aside by any architecture
> > > implementing UFFD WP) to an additional use.  That's why I called this
> > > design (from Andrea) more elegant than mine (swap type business).
> >
> > Oh my bad, I had somehow missed this was reusing an *existing* arch-dependent
> > swap bit (_PAGE_SWP_UFFD_WP, although the same argument could apply) even
> > though it's in the commit message. Obviously I should have read that more
> > carefully, apologies for the noise but thanks for the clarification.
> 
> Right, as Hugh mentioned what this series wanted to use is one explicit pte
> that no one should ever be using, so ideally that should be the most saving way
> per address-space pov.
> 
> Meanwhile I think that pte can actually be not related to _PAGE_UFFD_WP at all,
> as long as it's a specific pte value then it will service the same goal (even
> if to reuse a new swp type, I'll probably only use one pte for it and leave the
> rest for other use; but who knows who will start to use the rest!).
> 
> I kept using it because that's suggested by Andrea (it actually has
> type==off==0 as Hugh suggested too - so it keeps a suggestion of both!) and
> it's a good idea to use it since (1) it's never used by anyone before, and (2)
> it is _somehow_ related to uffd-wp itself already by having that specific bit
> set in the special pte, while that's also the only bit set for the u64 field.
> 
> It looks very nice too when debug, because when I dump the ptes it reads 0x4 on
> x86.. so the pte value is even easy to read as a number. :)
> 
> However I can see that it is less easy to follow than the swap type solution.
> In all cases it's still something worth thinking about before using up the swap
> types - it's not so rich there, and we keep shrinking MAX_SWAPFILES.. so let's
> see whether uffd-wp could be the 1st one to open a new field for unused
> "invalid/swap pte" address space.

Agreed, that matches with what I was thinking as well. If we do end up having
more swap types such as this which don't need to store much information in
the swap pte itself we could define a special swap type (eg. this bit) for
that.

> Meanwhile, I did have a look at ARM on supporting uffd-wp in general, starting
> from anonymous pages.  I doubt whether it can be done for old arms (uffd-wp not
> even supported on 32bit x86 after all), but for ARM64 I see it has:
> 
> For normal ptes:
> 
> /*
>  * Level 3 descriptor (PTE).
>  */
> #define PTE_VALID               (_AT(pteval_t, 1) << 0)
> #define PTE_TYPE_MASK           (_AT(pteval_t, 3) << 0)
> #define PTE_TYPE_PAGE           (_AT(pteval_t, 3) << 0)
> #define PTE_TABLE_BIT           (_AT(pteval_t, 1) << 1)
> #define PTE_USER                (_AT(pteval_t, 1) << 6)         /* AP[1] */
> #define PTE_RDONLY              (_AT(pteval_t, 1) << 7)         /* AP[2] */
> #define PTE_SHARED              (_AT(pteval_t, 3) << 8)         /* SH[1:0], inner shareable */
> #define PTE_AF                  (_AT(pteval_t, 1) << 10)        /* Access Flag */
> #define PTE_NG                  (_AT(pteval_t, 1) << 11)        /* nG */
> #define PTE_GP                  (_AT(pteval_t, 1) << 50)        /* BTI guarded */
> #define PTE_DBM                 (_AT(pteval_t, 1) << 51)        /* Dirty Bit Management */
> #define PTE_CONT                (_AT(pteval_t, 1) << 52)        /* Contiguous range */
> #define PTE_PXN                 (_AT(pteval_t, 1) << 53)        /* Privileged XN */
> #define PTE_UXN                 (_AT(pteval_t, 1) << 54)        /* User XN */
> 
> For swap ptes:
> 
> /*
>  * Encode and decode a swap entry:
>  *      bits 0-1:       present (must be zero)
>  *      bits 2-7:       swap type
>  *      bits 8-57:      swap offset
>  *      bit  58:        PTE_PROT_NONE (must be zero)
>  */
> 
> So I feel like we still have chance there at least for 64bit ARM? As both
> normal/swap ptes have some bits free (bits 2-5,9 for normal ptes; bits 59-63
> for swap ptes).  But as I know little on ARM64, I hope I looked at the right
> things..

I don't claim to be an expert there either. Given there's already a bit
defined for x86 anyway (which is what I missed) I now think the special
swap idea is ok, although I still need to look at the rest of the series.

> Thanks,
> 
> --
> Peter Xu
> 




