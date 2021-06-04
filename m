Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BB039B272
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 08:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFDGSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 02:18:23 -0400
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:21397
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229835AbhFDGSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 02:18:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjyzuULwnnzsHx6px5PGjqWxvf6tsawOF3i400oSSb2mI7SMXWVOkomPmyGf927u/exc6wfrHO9ANgPaLFYW04oX1vYnFVkJHy4AUbslunQDElTs6cknrjY4nxBe9dyypdPakrXEgpcpMBBGocVAvRsAwweF/Arvog0M5JEEAh4AIaZ2KZ3MKhzPekmIXJj5MSIKWpBBxjgmUhuTH4hgrJSh6QcRcrdh1xRxOQ2lBJezNvEnGm41gBhsnpjOqJEc/UB+HqksOr/QJ8kvYIm9oyi1a762iMLey8TnqCv0Q/X2q5Q6we2uejEwAF4GXoJZVC7OXfk3NdZ0avCRRuxYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p3rMlL1F1dsWpF0ml47OU88ZUQVN6Aems29lMFPPaQ=;
 b=a+Of3+y1gMVbHUhiLfarvlTW2hUUJWwKKzUfH49S/UVjBoRnWHB3q5dtgWsu9ulJ+krX2L48z3XmrVj9ACB5CniLTGbNIvhHeK7Vk6feYeXcP04nVh1880CMBMG/ceN+uZFdePDvwJHk7Qw3YP8RtP71b3jxvilFqbBiRiCJuhKGYh7oYiQLlXnIM/70FnK4cZ+azxs1VuS/taSCSvkHif/JqkkhL11vYS/SUvAYED/n7mXbwgr8OvZcnDK/PGKKkdRKbP2mArF++7DGif8AeFKD3fL1v0C77E/odAjU+AxfTWaCOdaAig6VTfXyu6SjtzO+x4iDN1TijuMoh9Imow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p3rMlL1F1dsWpF0ml47OU88ZUQVN6Aems29lMFPPaQ=;
 b=nvL6NUTlZFyr5XI8jKP98LG3PLTZHhR1naHW2rvxbdB2T4gz3YirNilbOq6ZtMeOhF40qXTlsdR813F8DDPkqggxZ8vkhc/kGrKkQgXZjHY9JWtpjhLaropxQbTf9KYf8xVFnh2Hu+uHS+/oj2fyZsg/8jYEfKJK0mmkrzTjUXH6sLCkBW9XJbVJiD9IUI93bsIyUpMGxAoExR4y+2wmR0jdH4tSgL0HWPl2iTFhbiGjocf5pHD5CjBMoRk731eoBWJhVADnmYp/544h2fmjLDtlk2bk1keyh19jKV8S99nE2WGsCOLKQ3wafsiu4c1t+8U0oIPT6pcPsi1iWictWg==
Received: from DM5PR08CA0030.namprd08.prod.outlook.com (2603:10b6:4:60::19) by
 BN8PR12MB3489.namprd12.prod.outlook.com (2603:10b6:408:44::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.27; Fri, 4 Jun 2021 06:16:35 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::8e) by DM5PR08CA0030.outlook.office365.com
 (2603:10b6:4:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Fri, 4 Jun 2021 06:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 06:16:35 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 4 Jun
 2021 06:16:32 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
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
Date:   Fri, 4 Jun 2021 16:16:30 +1000
Message-ID: <2408831.NcqaVN92ti@nvdebian>
In-Reply-To: <alpine.LSU.2.11.2106031954570.12760@eggly.anvils>
References: <20210527201927.29586-1-peterx@redhat.com> <1780227.rxkhHXaqZV@nvdebian> <alpine.LSU.2.11.2106031954570.12760@eggly.anvils>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa066cab-e1ec-4398-1eb8-08d927204e4b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3489:
X-Microsoft-Antispam-PRVS: <BN8PR12MB34895135E20AA060A3992E34DF3B9@BN8PR12MB3489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1n0rFhSgSXY/T8IlTVe+Mic9P6uF67LQP2IuSCZ75yLuv2Rzh3KtMaA+coe61Z2Yk5aTIsGYRSQ0HBaBz17B5bNSqAZIfQeYwvC6J6+Hf4TN5F8NyiPwbgD3P11hOsW5hVUwIFLGJ/y7lmGdWP0t/BPgEDbNaQnnjltc8PXTLxfV50OTAT6lQDwmIAE+Qp9458iWMofL7R3bhuRzMAN6o0oVo/uiRo3BqFjtYaWOO7S0+QSVH5KeUTBd4fmEJsfyzrLpoq5UfUTRVIj/igTTGGrajd8Yja1eyvIRmgOGCfPAo3VEgshJx5Rss4j0y0r95UAqr8uz8AVbdPI52vCZoL8psgQasAjQ84Zu2H+094hE4RA3CGsw3T5DdHvEUIMUD0SfMVBzL4cTOl5ca6Hy1WTObTz2TWWUDgTFvMrGAOig4tX4eaIwHW/rdzRPByXV7hB2iv+G1zg9kLCI7eFyO1Gwlm0MZC5W/aHy5ghSFViOq9dVuLV3ssmRAz6WCeD6LBqOqx9gBh/U202feEw+yWJydsTD+38lsSOPOsYaiXU+P3KlGcMfOExbsA7Vd0BZXNBs/wOE54VKA9h5jLmbA44PD1PKr0VuU25FiDOyFwnQQM0jmujYJlO/apG+RTbMKdHfWe8++j/UuobKNefsCRPNQDFVFquUXOtP7cKpE/4D7F+ttlyZr8O0bDZ2V4mF
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(46966006)(8676002)(26005)(82740400003)(83380400001)(9686003)(47076005)(70206006)(426003)(316002)(9576002)(2906002)(6916009)(4326008)(54906003)(356005)(86362001)(7636003)(336012)(33716001)(7416002)(186003)(16526019)(36906005)(82310400003)(478600001)(5660300002)(36860700001)(70586007)(8936002)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 06:16:35.4510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa066cab-e1ec-4398-1eb8-08d927204e4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3489
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 4 June 2021 1:14:31 PM AEST Hugh Dickins wrote:
> On Fri, 4 Jun 2021, Alistair Popple wrote:
> >
> > The detail which is perhaps less important is whether to implement this 
using
> > a new swap entry type or arch-specific swap bit. The argument for using a 
swap
> > type is it will work across architectures due to the use of 
pte_to_swp_entry()
> > and swp_entry_to_pte() to convert to and from the arch-dependent and
> > independent representations.
> >
> > The argument against seems to have been that it is wasting a swap type.
> > However if I'm understanding correctly that's not true for all 
architectures,
> > and needing to reserve a bit is more wasteful than using a swap type.
> 
> I'm on the outside, not paying much attention here,
> but thought Peter would have cleared this up already.
> 
> My understanding is that it does *not* use an additional arch-dependent
> bit, but puts the _PAGE_UFFD_WP bit (already set aside by any architecture
> implementing UFFD WP) to an additional use.  That's why I called this
> design (from Andrea) more elegant than mine (swap type business).

Oh my bad, I had somehow missed this was reusing an *existing* arch-dependent 
swap bit (_PAGE_SWP_UFFD_WP, although the same argument could apply) even 
though it's in the commit message. Obviously I should have read that more 
carefully, apologies for the noise but thanks for the clarification.

> If I've got that wrong, and yet another arch-dependent bit is needed,
> then I very much agree with you: finding arch-dependent pte bits is a
> much tougher job than another play with swap type.
> 
> (And "more elegant" might not be "easier to understand": you decide.)

Agree, that's a somewhat subjective debate. Conceptually I don't think this is 
particularly difficult to understand. It just adds another slightly different 
class of special swap pte's to know about.

 - Alistair

> Hugh




