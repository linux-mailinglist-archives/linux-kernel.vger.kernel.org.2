Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62F439AF40
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 02:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFDA5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 20:57:19 -0400
Received: from mail-bn1nam07on2061.outbound.protection.outlook.com ([40.107.212.61]:21573
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbhFDA5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 20:57:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlP5KvEtTK8X2lR93jpJB5TfqjXDMljGtJN0zCERaJzX2x/N//CxvT8xhcbQcSp71vUFCmM/FP2U0EM8qjdLWlWUbwrHraG6gnkyYnVRM85nwXpdZtjZxz9QPOk06VxH7dB1eJwlZEb9MNbKlN3OmhGvHotizWvQEavH1lOjIzbqzaJV6hDrQa5t4a0E87Bfqzp1TNU75ZbhPzK0ioFE5lq/dHCp0SPQ9JW19BUPXs4T6aDcVSgjgvfLU9R5R8kJFU17LFH11khK+ZyGipcFA3N5gF1SD3VjkG+jTplh6IGX5U9s2tI3LAfBA6CaFc9c0uevSckMmyeolGXzwDz7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt/T/JRlO2zBoJ0DK01j2X0QbMrY46XhSsJndnVd4tY=;
 b=AMcGy4FVLNaUw3+wCw2drahQihuD4tMIFZmzAKT0tNwXpjkCnGLzf1Qf+Amm1SPWM4bVQsLQSjZ9gD35raubHkF+kzazV9P+XxCybRiZQBbioECsO/I6hqnR3Hj9LPwgnj6XQNOm4cnuhPWd69mZl1gK2+gEwRFrOMXCr7yFLDb1xiYgLuX3Ip1mVXfcQWvi9vIua4ANsGN7/3Rf4rlzfc2gkM9ffVADAN2d9xmOUPFHfmWI65arJs+1r+tivB3LUVY2317K9xTILkaOJkYKmyZ0xO3DwG9Ax7DIjnaAi9AUrZhz5gq3W5c7HILmqsNU+mGVlzUoCBwv+JN1Jw+aHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt/T/JRlO2zBoJ0DK01j2X0QbMrY46XhSsJndnVd4tY=;
 b=CwNKBzc9uYOcwb9RpPHgHiM8aqVHMDPegZriRvfr/GPTbxW/+wH+of0K56UiJj7ftHJcCLMekuswiNeWZqQVs/NhP0X9Vymlyscb6FXGB1Ur3baIJcJh3h57rMgzh5yKZHpQKoQ+G3Ce61N4XbvR5NIf5J2ZsgE7/EVBv5T/cf3rwUGgpnYlAVSgvfieb2BH4PJCi/GijEwm+E6ZZN0dft8PunH9zJOq8BxjA9bgXNeguwVtsoKxQ1q5KfdOieBszAgDW26GUVeJctaGpBGcmSZlpXLkh42/RvAmvCrm7m7adPrFyJKbTOIkFJSwWwCXFlwBytCeYlpTykTNSyeXnA==
Received: from DM5PR16CA0045.namprd16.prod.outlook.com (2603:10b6:4:15::31) by
 BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Fri, 4 Jun 2021 00:55:30 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::3a) by DM5PR16CA0045.outlook.office365.com
 (2603:10b6:4:15::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Fri, 4 Jun 2021 00:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 00:55:30 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 4 Jun
 2021 00:55:26 +0000
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
Date:   Fri, 4 Jun 2021 10:55:24 +1000
Message-ID: <1780227.rxkhHXaqZV@nvdebian>
In-Reply-To: <YLjsZ4PVQcx0/vb8@t490s>
References: <20210527201927.29586-1-peterx@redhat.com> <4688876.HeLTNyGTSD@nvdebian> <YLjsZ4PVQcx0/vb8@t490s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b01bf9c4-9ada-4e85-6a4a-08d926f37366
X-MS-TrafficTypeDiagnostic: BY5PR12MB4242:
X-Microsoft-Antispam-PRVS: <BY5PR12MB424201C8F3D8D7B0AACBA3E4DF3B9@BY5PR12MB4242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwoOghN//OYVUT8XxT8OP6+Ayqgr5HRkURT0jCh+/aYQ1DYJjE51tBH+jJhIUfFoIP3N5qplYCl96r4ZC7Tm5CD2Gti7tv7Ltb5gdIVxjkdupEAeN9UYQKm6Xe2S+iczhn/fP+mhACboraVAjcAxfvka8ucWEqL3X68mvj+urNJNinx29+EamkNAVv/+A2f2UWDDbK00w3AfoI+PGdVD9R7G8MwbRXKhMyOb/pET93JkLzI5cYUiqX+sWLucDGHeO+evsMxFMgNXpDC5lV1JzSh+C7Pq6i8cz10FzXcI096KyzVX21T/b1ZZ4T68Gw9/JkKQFc1ItQA5wOSvkMPNQxALwIOb3lG/qEHd3nm/zmT0wEEEgoEOYkqTg6ScLHDfIIJYxfgH0+IVpXyGD08VD3tSFtKwyWZH5zl9HrxbwYuE1glU1QstCjMjoHnK/TEJNekZDu/scDB0dYqHMpFO8+YT6rzk0xn6WlRuZWgSYNN5T2EBS/700YVc79ccSfIQkUKUp7qLUfcCglwgJPf53yf3eS8Yk9Ar19BFffb6KhxxRX4+WJ/h3ooLyIS2oAgI8QU6QZRVPWedAx5mRDjSXCtWjkkiSdk7fsNBn3YLE8mGmMusTYpa+93m/dQNqiXsThGMewS5z0b6bMqgN+Lr+2Yk9oeDrAVV6eWWISIrcyY=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(36840700001)(16526019)(9576002)(26005)(186003)(5660300002)(70206006)(82740400003)(83380400001)(7636003)(356005)(47076005)(9686003)(7416002)(8936002)(36860700001)(478600001)(2906002)(4326008)(426003)(6916009)(8676002)(54906003)(86362001)(336012)(316002)(82310400003)(36906005)(33716001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 00:55:30.3468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b01bf9c4-9ada-4e85-6a4a-08d926f37366
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 4 June 2021 12:51:19 AM AEST Peter Xu wrote:
> External email: Use caution opening links or attachments
> 
> On Thu, Jun 03, 2021 at 09:53:45PM +1000, Alistair Popple wrote:
> > On Friday, 28 May 2021 10:56:02 PM AEST Peter Xu wrote:
> > > On Fri, May 28, 2021 at 06:32:52PM +1000, Alistair Popple wrote:
> > > > On Friday, 28 May 2021 6:19:04 AM AEST Peter Xu wrote:
> > > > > This patch introduces a very special swap-like pte for file-backed
> > > > > memories.
> > > > > 
> > > > > Currently it's only defined for x86_64 only, but as long as any arch
> > > > > that
> > > > > can properly define the UFFD_WP_SWP_PTE_SPECIAL value as requested,
> > > > > it
> > > > > should conceptually work too.
> > > > > 
> > > > > We will use this special pte to arm the ptes that got either
> > > > > unmapped or
> > > > > swapped out for a file-backed region that was previously
> > > > > wr-protected.
> > > > > This special pte could trigger a page fault just like swap entries,
> > > > > and
> > > > > as long as the page fault will satisfy pte_none()==false &&
> > > > > pte_present()==false.
> > > > > 
> > > > > Then we can revive the special pte into a normal pte backed by the
> > > > > page
> > > > > cache.
> > > > > 
> > > > > This idea is greatly inspired by Hugh and Andrea in the discussion,
> > > > > which is referenced in the links below.
> > > > > 
> > > > > The other idea (from Hugh) is that we use swp_type==1 and
> > > > > swp_offset=0
> > > > > as
> > > > > the special pte.  The current solution (as pointed out by Andrea) is
> > > > > slightly preferred in that we don't even need swp_entry_t knowledge
> > > > > at
> > > > > all
> > > > > in trapping these accesses.  Meanwhile, we also reuse
> > > > > _PAGE_SWP_UFFD_WP
> > > > > from the anonymous swp entries.
> > > > 
> > > > So to confirm my understanding the reason you use this special swap
> > > > pte
> > > > instead of a new swp_type is that you only need the fault and have no
> > > > extra
> > > > information that needs storing in the pte?
> > > 
> > > Yes.
> > > 
> > > > Personally I think it might be better to define a new swp_type for
> > > > this
> > > > rather than introducing a new arch-specific concept.
> > > 
> > > The concept should not be arch-specific, it's the pte that's
> > > arch-specific.
> > 
> > Right, agree this is a minor detail.
> 
> I can't say it's a minor detail, as that's still indeed one of the major
> ideas that I'd like to get comment for within the whole series.  It's
> currently an outcome from previous discussion with Andrea and Hugh, but of
> course if there's better idea with reasoning I can always consider to
> rework the series.

Sorry, I wasn't very clear there. What I meant is the high level arch-
independent concept of using a special swap pte for this is the most important 
aspect of the design and looks good to me.

The detail which is perhaps less important is whether to implement this using 
a new swap entry type or arch-specific swap bit. The argument for using a swap 
type is it will work across architectures due to the use of pte_to_swp_entry() 
and swp_entry_to_pte() to convert to and from the arch-dependent and 
independent representations.

The argument against seems to have been that it is wasting a swap type. 
However if I'm understanding correctly that's not true for all architectures, 
and needing to reserve a bit is more wasteful than using a swap type. For 
example ARM encodes swap entries like so:

 * Encode and decode a swap entry.  Swap entries are stored in the Linux
 * page tables as follows:
 *
 *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
 *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
 *   <--------------- offset ------------------------> < type -> 0 0

So the only way to get a spare bit is to reduce the width of type (or offset) 
which would halve the number of swap types. And if I understand correctly the 
same argument might apply to x86 - the spare bit being used here could instead 
be used to expand the width of type if a lack of available swap types is a 
concern.

> > > > swp_type entries are portable so wouldn't need extra arch-specific
> > > > bits
> > > > defined. And as I understand things not all architectures (eg. ARM)
> > > > have
> > > > spare bits in their swap entry encoding anyway so would have to
> > > > reserve a
> > > > bit specifically for this which would be less efficient than using a
> > > > swp_type.
> > > 
> > > It looks a trade-off to me: I think it's fine to use swap type in my
> > > series, as you said it's portable, but it will also waste the swap
> > > address space for the arch when the arch enables it.
> > > 
> > > The format of the special pte to trigger the fault in this series should
> > > be
> > > only a small portion of the code change.  The main logic should still be
> > > the same - we just replace this pte with that one.  IMHO it also means
> > > the format can be changed in the future, it's just that I don't know
> > > whether it's wise to take over a new swap type from start.
> > > 
> > > > Anyway it seems I missed the initial discussion so don't have a strong
> > > > opinion here, mainly just wanted to check my understanding of what's
> > > > required and how these special entries work.
> > > 
> > > Thanks for mentioning this and join the discussion. I don't know ARM
> > > enough
> > > so good to know we may have issue on finding the bits.  Actually before
> > > finding this bit for file-backed uffd-wp specifically, we need to
> > > firstly
> > > find a bit in the normal pte for ARM too anyways (see _PAGE_UFFD_WP). 
> > > If
> > > there's no strong reason to switch to a new swap type, I'd tend to leave
> > > all these to the future when we enable them on ARM.
> > 
> > Yeah, makes sense to me. As you say it should be easy to change and other
> > architectures need to find another bit anyway. Not sure how useful it will
> > be but I'll try and take a look over the rest of the series as well.
> 
> I'll highly appreciate that.  Thanks Alistair!
> 
> --
> Peter Xu




