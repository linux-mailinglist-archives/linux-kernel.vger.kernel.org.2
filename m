Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5672344C530
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 17:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhKJQmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 11:42:20 -0500
Received: from mail-bn8nam12on2050.outbound.protection.outlook.com ([40.107.237.50]:25396
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229582AbhKJQmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 11:42:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0ATDHLu3cnNVBOAbKO0FH2GEvXi0FvTlwYYVUlbXWMedczJBEH7AxxLq2i5NuwuJgi2zvoA/uZLE7iUPkq2kBoOoGObB0MXm5UPmRXaScaNqoXP7O9z0j76/3bKyUZOVi7PtRdgCfkx/lEgAAOAsKXTm4a9JELVOjuaOBEQA8fEMOWbBV22EwSUzoAtd5CSCOQdIv5Qf+aU07Q7iitgIImhpVbuVuQyDXn6aj7ek1c3GIApPYqoNnSyFfp7uOiZdx14+TnCJIFKOS5gj++OB5pI3xTfA6cDMQEPuUyAFx9uwnxdAgW4/nXYgDGDVGG5rvUy6xbGxIDUg4WVJu2c+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d94PLF34RFZ5Sf1t/9wu68ClnWZMJfrqwLIRg8HaTk0=;
 b=FZvTNycNy+L25YDG3ick2aEs1fwUtcFdgktufGvh9PPb/+MM2g4tCi0IX95fbJ1FVTNbEMn10/e3TCf5+OmGHMxqWr2Lzf/btnIgJhzO0zkSx4506Js+yGauUXDQWMHIcf8JOIGEAZyg62qY/PsW01qh4XPR2wqNFR1bH9DwEHdRN2UPwPoQgZYMTh0jfqqRIzlUOnxp2lA4T7Kj1jY7OyHzrOcm0w6rLTi3U0BgBd+0vGz/hH68LXPlO5s0kKeR/D0Bi4C38jfbIwPYv8WCdZNrl+cKL6ZflOtCvonR6w5IGSqWtTfqHGD17r+DCb8rknWDZqfbjiaGMMjzpb2oOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d94PLF34RFZ5Sf1t/9wu68ClnWZMJfrqwLIRg8HaTk0=;
 b=ANwSts+fuHX7mLa0YjHOPkvJDhSBg9RIkBoc/LyYVpLoIyV2MMGB+BfuHGmm+/PQ1xuMXQqByLn4JsagEnJB7rRU/jXVTZhMf2cL2SwiM1PEtFvTABU2KLkLv2b37UyfsbSCmXGsVnh5vF22uqRIk93MpZfa/OD4jkd8BCyxpXTe0sNmwHlo6z3Pg2Nha9vYMzuHOIobhl+U3Hj4hz66XrM++JHw5VpTjWOyfRjYLZR076y0yrfvz9mHl7pv641lmrIdQgebibdoEPLC58GTv7fcZ1bTlaFdKmUnXqPS8zL/MaBC6KiHCZKLCzLxQgg5lSG9STYsNK9UzlKKAOcguA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 10 Nov
 2021 16:39:28 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 16:39:28 +0000
Date:   Wed, 10 Nov 2021 12:39:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com
Subject: Re: [PATCH v3 00/15] Free user PTE page table pages
Message-ID: <20211110163925.GX1740502@nvidia.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
 <20211110125601.GQ1740502@nvidia.com>
 <8d0bc258-58ba-52c5-2e0d-a588489f2572@redhat.com>
 <20211110143859.GS1740502@nvidia.com>
 <6ac9cc0d-7dea-0e19-51b3-625ec6561ac7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac9cc0d-7dea-0e19-51b3-625ec6561ac7@redhat.com>
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 10 Nov 2021 16:39:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mkqdB-00866e-2Z; Wed, 10 Nov 2021 12:39:25 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e650456d-80d1-4705-f006-08d9a468a953
X-MS-TrafficTypeDiagnostic: BL1PR12MB5143:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51435C2FCDF3D840241A4990C2939@BL1PR12MB5143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h68YA8ngaNnXAtLNpdso4gvzMdva1Eh92BoRJqgs31YnBksuTLlB6oNR6D4HPZkSD072wtY0lRbQKogh273i3M7M8Ip7wTuliF6ZQHAMU9w+H0PLU3L53ylruHPy0X9A3zZPCqNu80CA1zk8/Aj28cDlsfOBCaf6Oz/C3CzGcbKLJgFRG5O9c3MlljbtsRuGJ/kFcYAPLgmW4rREWlul7QAUnCnqNdd8Fy/Klfq74zA6OUCA5o92TJKH0PC+cnxfUIxyAJrtYxkSic6EFKsU+NSXsw9f2XPqn4CGA8S9NEYWNfmNLiWdLveoguaFpzZR12uFbzdSAECLrcq0v4lo5Oxi1zmtGJn2GQFjxgxBZ2sI2lP2OB8p8WvBIIu3TuAad+0+r97U6xvSWLx1egShzwDr8fhX1bTyGORIoIgZpv0rjnCSW0NwShCLMxc49nVv5M6lZC7MHdz/CYWf2+R3tgtjC99uLSBmXH6e3SopFcw1F7+XmHnLHxwLT0eoVcOKuIVnrdyorbGsT01mVY8bDC+a9EJY5eIDZcpwddvS3nSdXqSlZJffME2sbKzJxDZ9oDYTcJcLLsWAh+BHQk82BvQtaHLMEdPRpVStmrtipeDZ6s5evdSPI5sx2GI7jpQsRon8P/bNBUBfyy6N08WF1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(508600001)(36756003)(38100700002)(186003)(66476007)(1076003)(4326008)(66556008)(86362001)(33656002)(9786002)(26005)(2906002)(7416002)(8936002)(83380400001)(2616005)(9746002)(8676002)(66946007)(5660300002)(426003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0aH2ZOEXcFJYQsSEDE4Ghj+AkAkTgbEtXjjuImihVpqeZcJAQZDtSynoSB/Y?=
 =?us-ascii?Q?42RgT1gfMexm5z9Eq6kwQ2pO058p5T3u3FCJ/afDhbTD75uXIL+1+Svx4YKO?=
 =?us-ascii?Q?BMnWwPfWEpMw6nK7XN+8Mhr1iftUE0BztVZ3EJltI/j2kAFQp6Q4VaBHUsvk?=
 =?us-ascii?Q?G4lFf+6ilrOtHejEcLrYzGkZ0jND1r8Shj4rsVxU0I343BaE5D2Z1HUVRAad?=
 =?us-ascii?Q?z7klMxn9o9vbaJjcqL9PZFvW27wqlTmLOvGlKcI+/Ug/NrrTBU/rtKUYg6D7?=
 =?us-ascii?Q?N6DedNWv+TGAZZUTuV7lavWD9qGfc2FxNQ/zDEL/F8c6i5QCu14mIvA2ypQq?=
 =?us-ascii?Q?fBfC9ALfQDihG9IjGHJ7WvABOfHeqRal9wrZSHn2b+XqAMUumXJajVjVbU4T?=
 =?us-ascii?Q?Mbt3vBZ60BO6Txg1LkhDMqWOY8oJ94ZrRDjBedjHr/yV9ysBMyu+DwNQEeiB?=
 =?us-ascii?Q?Pz9L8dC+gtDY+rNMT8zxuMp66qa7PrigGLEMq2dY2ju31o4c5rLU6qfTz74d?=
 =?us-ascii?Q?ICZb9fZ0VCcv4kbL8h8ZCaH6RlY90l5CbJcStpjHvytXc8rZHap8LLdS9e7N?=
 =?us-ascii?Q?BitPnRdJTOfuQktP8Lw8L4ZtA89E8RwB3qQA8WNlXeyI0+nkDWffraoFKy2B?=
 =?us-ascii?Q?N9aZ+h/nkNbyDLerOLueNZQ97pta1dDFw2izPbZcYzFDkQeAemWJsj21/p4W?=
 =?us-ascii?Q?IZZX1/5ynyFnIGbuEn0/Z9sSuoUk6yjylO3u01DJUbpDInHniKhf7JOUJN+T?=
 =?us-ascii?Q?7tXCG8rrvT2FapajRhaMdIB3/IbhyHj8CCOqgxVv1jo/VuqBe5I3p0ZIrw3x?=
 =?us-ascii?Q?0sAgJTWtIEJ/9uaNexPZ5vQD+o0P+mG6+kFuqR0JtCBkvf6OLu7apw6L1N1O?=
 =?us-ascii?Q?fVvJxIFAixAofifFgk8iZXxeUoDM4+unX0dqTM7zRUwlDtUMsJmyRb1jcZsS?=
 =?us-ascii?Q?QBJoWbHzxN8jVNbqPeDpItLW8+MxMTBKM9rKIkUBAD7h4al9jrMqQfylOi16?=
 =?us-ascii?Q?8bB2nknZrXbbx7HPXyioE8z54vIYSuhdL/knImGIa3eqqjVqgASjWRpTSX1b?=
 =?us-ascii?Q?A0xet1rpcFONXKKDga0uc4Ahnwkuepx1z/NU9lvHAeRQVgKOL0u0hmU27NGU?=
 =?us-ascii?Q?rIN2oj6PFpbvjJuvH8w31KLQgmX8H6In0o3WupRXaS/mkgbPZVnwCFbqXdLg?=
 =?us-ascii?Q?MM+AofqSrPStSOkLy9QEIVTN7UYkrq96JQPZV375adq25yBTmVQtjUaHuVJz?=
 =?us-ascii?Q?QznR33v2YOPAzxZTvo0WsPVNg4ZSAk1mA9LiYPAp2qML4CZuogaKSboEJKOa?=
 =?us-ascii?Q?lxssCPBcjjp3dTuLfqgoV3qHHTcfW4OB3cBGu7zbzNc1WZ99TmT6gb97iUFZ?=
 =?us-ascii?Q?6WWij2J4O/ccv30yA6j9jYpbF6XWkCvovPz6+t0xGMq2p2E2PvihjGz4Q4N9?=
 =?us-ascii?Q?5QLnpBa9gtGY5ObtzM0ORtPKInq1vPKg6O5kCxUMKupcMxr3Gva3oUyJFqmB?=
 =?us-ascii?Q?BXgkMcx7tQ0/wwsGODKw/EKL127+O90fBHssCuP3Uy5PyVZmLjPfnMCvXx6t?=
 =?us-ascii?Q?/+JoGVpvtc3CwZepIIU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e650456d-80d1-4705-f006-08d9a468a953
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 16:39:27.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpWltfINOHwC3WjTk0gdHQ4uzqWtT76xTGiGPTfPA9T9T1xfYWdIVo9gaOKmfXWA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 04:37:14PM +0100, David Hildenbrand wrote:

> >  - Fully locked. Under the PTLs (gup slow is an example)
> >  - Semi-locked. Under the read mmap lock and no PTLs (hmm is an example)
> >  - hw-locked. Barriered with TLB flush (gup fast is an example)
> 
> Three additions as far as I can tell:
> 
> 1. Fully locked currently needs the read mmap lock OR the rmap lock in
>    read. PTLs on their own are not sufficient AFAIKT.

I think the reality is we don't have any fully locked walkers.. Even
gup slow is semi-lockless until it reaches lower levels, then it takes
the PTLs. (I forgot about that detail!)

The mmap lock is being used to protect the higher levels of the page
table. It is part of its complicated dual purpose.

> 2. #1 and #2 can currently only walk within VMA ranges.

AFICT this is an artifact of re-using the mmap lock to protect the
page table and not being able to obtain the mmap lock in all the
places the page table structure is manipulated.

> 3. We can theoretically walk page tables outside VMA ranges with the
> write mmap lock, because page tables get removed with the mmap lock in
> read mode and heavy-weight operations (VMA layout, khugepaged) are
> performed under the write mmap lock.

Yes, again, an artifact of the current locking.
 
> The rmap locks protect from modifications where we want to exclude rmap
> walkers similarly to how we grab the mmap lock in write, where the PTLs
> are not sufficient.

It is a similar dual purpose locking as the mmap sem :(

> > #1 should be completely safe as the PTLs will protect eveything
> > #2 is safe so long as the write side is held during any layout changes
> > #3 interacts with the TLB flush, and is also safe with zap
> > 
> > rmap itself is a #1 page table walker, ie it gets the PTLs under
> > page_vma_mapped_walk().
> 
> When you talk about PTLs, do you mean only PTE-PTLs or also PMD-PTLs?

Ah, here I was thinking about a lock that can protect all the
levels. Today we are abusing the mmap lock to act as the pud_lock, for
instance.

> Because the PMD-PTLs re usually not taken in case we know there is a
> page table (nothing would currently change it without heavy
> locking).

This only works with the lockless walkers, and relies on the read mmap
sem/etc to also mean 'a PTE table cannot become a leaf PMD'

> For example, walk_page_range() requires the mmap lock in read and grabs
> the PTE-PTLs.

Yes, that is a semi-locked reader.

> It would still be a fairly coarse-grained locking, I am not sure if that
> is a step into the right direction. If you want to modify *some* page
> table in your process you have exclude each and every page table walker.
> Or did I mis-interpret what you were saying?

That is one possible design, it favours fast walking and penalizes
mutation. We could also stick a lock in the PMD (instead of a
refcount) and still logically be using a lock instead of a refcount
scheme. Remember modify here is "want to change a table pointer into a
leaf pointer" so it isn't an every day activity..

There is some advantage with this thinking because it harmonizes well
with the other stuff that wants to convert tables into leafs, but has
to deal with complicated locking.

On the other hand, refcounts are a degenerate kind of rwsem and only
help with freeing pages. It also puts more atomics in normal fast
paths since we are refcounting each PTE, not read locking the PMD.

Perhaps the ideal thing would be to stick a rwsem in the PMD. read
means a table cannot be come a leaf. I don't know if there is space
for another atomic in the PMD level, and we'd have to use a hitching
post/hashed waitq scheme too since there surely isn't room for a waitq
too..

I wouldn't be so quick to say one is better than the other, but at
least let's have thought about a locking solution before merging
refcounts :)

Jason
