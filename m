Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21B63FDF91
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245105AbhIAQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:17:17 -0400
Received: from mail-co1nam11on2085.outbound.protection.outlook.com ([40.107.220.85]:25488
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234245AbhIAQRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:17:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwfsD2xcO4B5qhbZtUHl6XDhFJtg1KA9nsfprCdRKNIhtpGpu4HX0B53IFO1JcKkv2UxEkC7r/x1VMNZe31KtRkb2nNfWhU0Pn8ZGRMra3rjvEILQMPpqimduXg8P9RxAk0w/cnuxX/Hof9XUW7RiuaB7tOijqlK0rTNBuwNQ6Uot7auIU4vQs5USKI15HV7HUz8h/YpVhzkVLLnaGT1Np/dymVdTLF78iRBCU3dv0QXcBQUhP1vDyqiKSrvv61X6LZCrjGUn4XThx6nDbTpUM/eGKVRTir32NNdJYntMXoaqWX69EerNubDGu1w5/uJhyzboHkcNHLA0TukpjKdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3CyVXBM7tZ94Xhbp8J6r3p+Cb7d8TIUPv9jXm5RzSY=;
 b=FwWHp09VoU8+2jz5OFyUp/HJ0m3/q1xSPGpdhcPcv+LkxHInSG9+YOQQcYInZP0/uT4fVcO6+rXG7SatuRZaU2O/vB/PeOpdUL+Rwy2MExQOOMvihuG/CleHnCjxbU0/1SC1LeiGjjK1RJzS2Fgp1kPbYVYhhTK967dxi2MmvZb8eHqTwnmT2djIUuARrl6PixilXfPEJMNVw6uCJ7w0LcUvebowxDDl4vzH9wjgbytYY7DGFdiZkJzNHThhgFOazyTN3sm0Xj3APhqXm1vwZqkcEb9kIFpCXK21nNGQXV+qexkG8+G7IrtGrxHxYQAX4YIECAAQ2Jk6NWZicoUNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3CyVXBM7tZ94Xhbp8J6r3p+Cb7d8TIUPv9jXm5RzSY=;
 b=eSH4ZMpYeLGI2IIkp2ZSP7GhQdWZmd7wM+0W+5+B5bRZcwQZfdCXgyjiTm2sY1qChlcqkF1b9V+K0jdXGJfUcok5NmRx4ty7OVy3aGy6vSvDWdh6qVSolRaVADavh+LxT4RKVAD6HxhTmgbK1Rytumx2aFDFU53oc68c0sjWDCOXJjt6NLRlU3gWaqY7ZHNrXejj+yOz120P99Mli9lZydYkSQq6vv5Km1dyIATl8Mmoi0MRGfmHcRm2h7leGd7WVnnasKTffZPRh8j7B7MRHNSJFqhgoIDZiQ/gmekZs501JNX0wuZ0anJIj/y3CkxO/xfj4pId5HgScjaDqTfOjw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 1 Sep
 2021 16:16:14 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 16:16:14 +0000
Date:   Wed, 1 Sep 2021 13:16:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 6/9] mm: free user PTE page table pages
Message-ID: <20210901161613.GN1721383@nvidia.com>
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-7-zhengqi.arch@bytedance.com>
 <20210901135314.GA1859446@nvidia.com>
 <0c9766c9-6e8b-5445-83dc-9f2b71a76b4f@redhat.com>
 <20210901153247.GJ1721383@nvidia.com>
 <7789261d-6a64-c47b-be6c-c9be680e5d33@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7789261d-6a64-c47b-be6c-c9be680e5d33@redhat.com>
X-ClientProxiedBy: MN2PR20CA0037.namprd20.prod.outlook.com
 (2603:10b6:208:235::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR20CA0037.namprd20.prod.outlook.com (2603:10b6:208:235::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend Transport; Wed, 1 Sep 2021 16:16:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLSuL-007sLn-8G; Wed, 01 Sep 2021 13:16:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f40dc5f-c715-4460-4124-08d96d63d1f6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5352:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53520F4250E9877AC71CF8CBC2CD9@BL1PR12MB5352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSg8pWPp4Dy1PkTpVFTqxzdK4JVrz1UhSxWfKlvwlnQ1W70gugC1w/UjnXnF8Urau/jVHRUfNWnT+dOeJJmCSMRckJvJj6eRMkj91YwCaNfA8c4oBjBhIXFAPc4tjT+dgHSVrfRmmHwno05NNpT02c4aQBD+z2PwCW9RpOyAEa8EW2w6FsYYDjon7M5O2ocYy4bGEtdHC8qFQtRTPZcB3zUsnsotOBQapgYw4Q1MHqmGINQaBzaEYT4BwYtygR2+R+nZCfrnSm+427KohZsJs5twxDHI69j9INoxE4qX9QEPNRW2yZ7oPzI1m4hAWOzPE6pwbdk91C3hGy8tJOZv65P6VgU/QFDocYLpR/se7jJs60OTtquQ1aDcY1sFdgpkdsSRc2UcMHaw+pzJSf3RjWXt2gc+mLnEAE5d4TthD8hbm9guToDpohsvc0ZFhsKL28kf1RA1vhQYaDX9aZed7YlknLgXeRdwNq+EX3O4wrrY8SGo6HVJeeAH4Cea+ZUgYHIZq/JhrZuGo4jLycmAnrHTTkxdXd2POikA1oxTYHPCnpi/lO6nCHHbXrD4AyVyB1TGWlgfgDcIRaKP94z390B1lH5R6DyaVe72atEGhi82O4coD4nvicGeVwVZwmL/Cd3TQSjOSs1nvuX74NQO1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(5660300002)(186003)(1076003)(66946007)(66476007)(26005)(426003)(316002)(86362001)(66556008)(53546011)(36756003)(83380400001)(9746002)(4326008)(7416002)(9786002)(33656002)(478600001)(38100700002)(8936002)(8676002)(2616005)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGJNIS76YpNdAeyORJYa6MYth6x3U8pD9ISJuCXxcCElwp/098GRQ5BLarNa?=
 =?us-ascii?Q?P8qkYudMz676xAmwnaZMOmM/ebJPog0hunm/JK+4MYbYogLPa1lJ+1PkylPa?=
 =?us-ascii?Q?4nMSl1wE0bCJPFu0ZPny0a7oYMSWH8fZxqonVxXIXJkgl/J7yF5OIQgeZG7Q?=
 =?us-ascii?Q?EXMSbo6f7VJKXxHYmGXcSUbVHBULQONWPhYk5dFPQvztW5FlC5ArEg53uT1A?=
 =?us-ascii?Q?58qAE5FyyYD3/fhwZJGRhOcaH5T5IBRdGMqa6C3Icg1g0POKnvKWtscvQLMw?=
 =?us-ascii?Q?PDLPydz8WE/vXcjYKkktWaaJeLsAbpPAzb5iuy3nRjeiPoqvBNp5bsvA567Z?=
 =?us-ascii?Q?211VcmSPwN0yH3rC8zo2hI6WZ6YGdVHnkDQYHMbKSvwyFnw0+FLXyQpf9cmO?=
 =?us-ascii?Q?TPxslIMPs8KghOQ66Sfob0KDOzA5JkQ2qcnSh+cBHJ/cD1Srfay6R74A2FEv?=
 =?us-ascii?Q?W48a9Qjj3hn9cvvT6xWauqSX07fwP71n2CRr3u2vXjL/56WUcsuvtcXLAqkd?=
 =?us-ascii?Q?sZwmAM1wZngcWZ1EOPm/zWdimqP0mGJCQaaezojO6zxwWwxnvoBa5DRcj0xZ?=
 =?us-ascii?Q?UpuWs/BfLCqdIbEjI8g/gimI7wfkaCiObGFUdCXx5x8d+G3/SaHkt/FSSA9f?=
 =?us-ascii?Q?a9TaoIWizIjGk3c562MSygjYPGHKCjUPwbt6mV/IQeT9biwfzje+jCeYykDD?=
 =?us-ascii?Q?29KKUu++/iXWoJB2w2gL20/UQtDGYN0fF2Mj1frQaaJi38+tOYU/cUpvu66n?=
 =?us-ascii?Q?Dvn/BLPAi9GsLsm9Y93gyBRfSb/5DvS1k1HdQgIDvfEgUey7bqY0sh8Fu+L3?=
 =?us-ascii?Q?eIIpWuUXRU/kHoxZj239JvAGDtHD9vmgBa/uQjdqH6Y6Ng9bWZBj+n1cmez2?=
 =?us-ascii?Q?Diq7ONjdL/mKOb8gu/vcXsI1mfo2/WJSMf2MRdpuZlb65gR7uljLbUh8xo0J?=
 =?us-ascii?Q?ETKPl8e0+L5bcUfoBI5IFLbXvfC+/YNQzQonpocX2MpiMJ4JYc/XeOeH9va7?=
 =?us-ascii?Q?U19LD6QpdCfM6UycMjZ2+eET94EVyXodH9XKbraTJuhyX7VIuqi8x9GCEhoR?=
 =?us-ascii?Q?gZRTRP4OJMOko/dZRlJc/QBUTtIuXU4wyD/T6gLF4YuEDpFZ5sy2fQlKeaQn?=
 =?us-ascii?Q?V8OEkGm2fBla7LK84iSHj01AYFH4xtYe2KBHNX0OQk9PLL4lyeOIDa4zNaoA?=
 =?us-ascii?Q?ZNxO39v85v3KqGbXj1yoFYNK82gDD5a9MuoKjN3pvYMCbkSzHvusJJip4C1/?=
 =?us-ascii?Q?LL0CJM6GXpTMAEvCrSGiJhMEg6zyc3GZo9i5wAj6ncyg8O5cuH4nLrDiyehc?=
 =?us-ascii?Q?MUHak0hLc4z8xFMdZGgQC/s2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f40dc5f-c715-4460-4124-08d96d63d1f6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 16:16:14.3204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKulUH2w9iOZlTQecMoNswxCEWaKJCIwXe8bMjglPXW6FWLHtavBcjFGYpids0ok
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 06:13:07PM +0200, David Hildenbrand wrote:
> On 01.09.21 17:32, Jason Gunthorpe wrote:
> > On Wed, Sep 01, 2021 at 03:57:09PM +0200, David Hildenbrand wrote:
> > > On 01.09.21 15:53, Jason Gunthorpe wrote:
> > > > On Thu, Aug 19, 2021 at 11:18:55AM +0800, Qi Zheng wrote:
> > > > 
> > > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > > index 2630ed1bb4f4..30757f3b176c 100644
> > > > > +++ b/mm/gup.c
> > > > > @@ -500,6 +500,9 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
> > > > >    	if (unlikely(pmd_bad(*pmd)))
> > > > >    		return no_page_table(vma, flags);
> > > > > +	if (!pte_try_get(mm, pmd))
> > > > > +		return no_page_table(vma, flags);
> > > > > +
> > > > >    	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
> > > > 
> > > > This is not good on a performance path, the pte_try_get() is
> > > > locking/locking the same lock that pte_offset_map_lock() is getting.
> > > 
> > > Yes, and we really need patch #8, anything else is just confusing reviewers.
> > 
> > It is a bit better with patch 8, but it is still not optimal, we don't
> > need to do the atomic work at all if the entire ptep is accessed while
> > locked. So the above is stil not what I would expect here, even with
> > RCU.
> > 
> > eg I would expect that this kind of change would work first with the
> > existing paired acessors, ie
> > 
> > 	pte = pte_offset_map(pmd, address);
> > 	pte_unmap(pte);
> > 
> > Should handle the refcount under the covers, and same kind of idea for
> > the _locked/_unlocked varient.
> 
> See my other mail.

Do you have a reference?

> > Only places that don't already use that pairing should get modified.
> > 
> > To do this we have to extend the API so that pte_offset_map() can
> > fail, or very cleverly return some kind of global non-present pte page
> > (I wonder if the zero page would work?)
> 
> I explored both ideas (returning NULL, return a specially prepared page) and
> it didn't work in some cases where we unmap+remap etc.

I wouldn't think it works everywhere, bit it works in a lot of places,
and it is a heck of a lot better than what is proposed here. I'd
rather see the places that can use it be moved, and the few places
that can't be opencoded.

Jason
