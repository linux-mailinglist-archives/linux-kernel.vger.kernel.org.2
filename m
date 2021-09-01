Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1383FE13A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344515AbhIARjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:39:05 -0400
Received: from mail-bn1nam07on2050.outbound.protection.outlook.com ([40.107.212.50]:8503
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236428AbhIARjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:39:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZegPdCe9Tmk80SpN95d86cTzno8+VFHRNEaZw5QB+fWIOT+xye9A6oZkYm9Zs3Td4L/wOdIyBK8vKfODwJdZMR5OI+lHDqSFJNNap8/BewzMfj1v83N9BMTAZGBZMOCpVIs17X/GeMbti4jBCeyO2mJMEfbbr+RjqQjOK8riea+cizj3KUn66WIYWivRuGpsCoA/8nwr4JZH9Sg76Ibbp0tCNJlrEQrrEq56B3mODVnVpERDfNQnRYJdsHhWFnXpXyXrpqLVxvhQ8p2bPC9CVy7ZjSkMUZ8XDouKPvTGPSYAwt4JTMXL1Jxk0bFcJddPYLqSr5QSLyWzJuHr7FweOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=O0VotvFPcWfC/1NnMfVZgsj3SfXF36tJ/ordOWnnC1w=;
 b=cJrci5J4xgD13Z50ptGcEzORMaBLTCKaHZNTzCVTuYrkAU/FuvKMMx1dUXdbDTerMI1E2TJyX0wBfq4IT1ecSGoApHFNxIFmTovlhL2JqkZsY8fc8//iXLwdJ7rRBud4t/0Dryz+p1Hph4DBH55bMxgWReleUIh8/8+481mkr/uw2hkIDtY2vr6QsZGEWg/DjusawByCJGw8cPPmrr3/gZqyUzJYIa7XwOYzX1ia5K6k5jtvHtPnASPNftZETpc14pk8q7oxO1tVRMiSdJbg8ZDYq3QNotp2qTw5OXmQkTPCNfL/Lg1p5IlZCtRHWkWE5IpQBGQeOQV5pEOH980p7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0VotvFPcWfC/1NnMfVZgsj3SfXF36tJ/ordOWnnC1w=;
 b=jv1H+y1o0FGMe9fezkg+Vcr8Lf6YWOymH+TqQHMIXW+lzC6zNUNCnWAjZWKCgSimazmWZ4A+1hBuLxfvMuAUojV7KDp5Gr9rFUTYAp8tzZ2kiUZoSt9pXJucacoNVM0MMRbh2YkzbkD7ln2j1/+Da4OmHNdLTdZ01WdsvCgKdCORn5oUIYM8U3ZC5UyGHrAGX6Owm6ZrRw6xDyK1+CTNRrcB7pDYNDcR/ViBRkejzXAgirM4AU9mcBml0GvTEIbp9MmzTbsrXYoGy84ZgBvdF2zCYfJedYy1Z6Hyr8Kho1JWlkwnFvMEfUXnYnqfLrYPiRrjwNfVnj+MrKf+X7K6qg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Wed, 1 Sep
 2021 17:38:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 17:38:03 +0000
Date:   Wed, 1 Sep 2021 14:10:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 6/9] mm: free user PTE page table pages
Message-ID: <20210901171039.GO1721383@nvidia.com>
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-7-zhengqi.arch@bytedance.com>
 <20210901135314.GA1859446@nvidia.com>
 <0c9766c9-6e8b-5445-83dc-9f2b71a76b4f@redhat.com>
 <20210901153247.GJ1721383@nvidia.com>
 <7789261d-6a64-c47b-be6c-c9be680e5d33@redhat.com>
 <20210901161613.GN1721383@nvidia.com>
 <e8ebb0bb-b268-c43b-6fc1-e5240dc085c9@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8ebb0bb-b268-c43b-6fc1-e5240dc085c9@redhat.com>
X-ClientProxiedBy: MN2PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:208:23d::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR06CA0014.namprd06.prod.outlook.com (2603:10b6:208:23d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Wed, 1 Sep 2021 17:38:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLTl1-007tmP-5r; Wed, 01 Sep 2021 14:10:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff0e80f3-367d-4100-1977-08d96d6f3fc5
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-Microsoft-Antispam-PRVS: <BL0PR12MB553888FDF449F899F237052DC2CD9@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4cXr4erfmKo+Y1NERY3lpBU5RyrysIIVpNO+9iDtuddS/pKHYc1ISQiwG1N63eFGwaoK8ZS1+G5wiAfuYOKP87ZCN7NsG/iyLHNJkUX9Z+LqCW556tLrl5SVoDBwDxPTPuN8AFUkkcpLaby5usg6kaygQblBmlAFIhL1hqxEGGQFN/v766kmZt2VYTb2HEtsll/VRxCIknL4x1dw0kB2l7BN9aQ4PNC20O7MrpseRR90X8etKbqLeohlzIpPoLjQuNAypodqFQ3p86cx1Y2qydsl8wepZcYbLXDaTn0MoKVh5uXWziu9XkiBDo/LYsYLnij9V9w/ZYRRtMvRljxiS0NzkDE4X+1o5TMkOUDrFP996jxVJgPl13VDtnn7lYJu00DR4qOc+/yOawvyDdAeBiONxIz27dENsm/cY8Xg/JPn/PmRfU/UX62lHT3mHF+/iwEUP5v3nNykh2FOKh03f+tOzO5eCyXmdSiHCs1va8HNzjRBErxCRDWx0volR7BvrpOMXs5gqrVuV+oUxTB/ngcAJ8Lsh+jc0U4Cvl7cjY6xC6iiT5HX91mctZnii5UyLVsY3VfVtM+4CKl9XvTJX+zmozFWJEk53u+n6+E6SxSICCrGxLfWaesv+w0Sx8U0K83KauZVe3+gWhSABm1Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(9746002)(83380400001)(9786002)(478600001)(5660300002)(2906002)(2616005)(6916009)(1076003)(316002)(8936002)(66946007)(86362001)(66556008)(66476007)(33656002)(4326008)(26005)(8676002)(36756003)(186003)(426003)(38100700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BEanolIKe1FvI4ca+Sqsq7x3WkJUYzKyVPzxNNZa+1hq7GBr3TCku2wWsBhX?=
 =?us-ascii?Q?cW0Hm9ZanDU8vPtvAQYFBkhEfnzQP62NvSPmRZm+UL7qOOLnwYeV2Sdp6aZr?=
 =?us-ascii?Q?elr0AJ7FPULW41uxyshMUKTWvN5LwmjSAjUfH5bHkXqacwNffGQi9LdaDr/A?=
 =?us-ascii?Q?G7fthSbQtFrkY9ijDeYOg1Ozx0yafrPhvC4B2jwCiXw64riNQ/zeq5zo6KWD?=
 =?us-ascii?Q?XAIHyLeHC2tsXAHd4s7mbg0pOQa8vvHG4hYMiTusFhmXVnoxkqt3xyT7NfZs?=
 =?us-ascii?Q?VeMyVel37jbZrjqEFhcZf1D4+8e7CWWNo8fyAwZiESk2hbnEquMnYlfFycJf?=
 =?us-ascii?Q?qzw6Ggp7zil+SGm66k4RH8145NbNCqPsr2//Eqn6LbxWFba+MzmfUCv0k5qJ?=
 =?us-ascii?Q?54mVj8e/MhIo0IypOcnFGSvrvKuNXLk4uypbjeZkgk1hgNVqHoyGLEM8xPJl?=
 =?us-ascii?Q?AgmnQp8ExICcgZnMmlolIB8DcYIhLKvAPY1U7BC+wqM7yW7vNo4wHsGOkCT8?=
 =?us-ascii?Q?cRGnhi/OfbKI/Ed3dQ0kY9Davlqu/1ofpB+LcqVy7hfphPm1ehX7XjieX4fA?=
 =?us-ascii?Q?IwueW14YCsYbXe3Hdb7YIbnGlciPP1/0HonTjahTQ0c51t/CtfVggzt04Bz3?=
 =?us-ascii?Q?z6YVosVyKOSwQzWdwL+bu3EaIWP440XEC8CZTekVMmuCDX6AUnZJhGu2IyFb?=
 =?us-ascii?Q?EGj0VMJftnSC0nnetuxFzJhLXuRd/DipzM+XE9/uT3ju/UwwZWD3vZdKyTDz?=
 =?us-ascii?Q?pQlvd+uZzTJvGdChlZB1CLurqMzpI28XlRCtzgxHH+wQEtJfyQs9dmb91LJG?=
 =?us-ascii?Q?sySVy//ue+ZtHxrOZljLxFvPS0F8lFQ23XbWQ3V6+auu6uLP6mXWCMCs8VN1?=
 =?us-ascii?Q?5VGIomYCbu5HwuUZ+blukOtfbtiPbgObi47kM10NCgsTP4J5EH5gurh9xBhR?=
 =?us-ascii?Q?qnlYb1f60sj8WJmrVeYzUdIx5hdw+O8tW+c6QFf+4YprI4jiwwG20o+IrUoM?=
 =?us-ascii?Q?RyqwgFbEqM54YYGzOrWf7wx6+YUurTfOufruzQEnD50FqzqBnu4+DBStW2j3?=
 =?us-ascii?Q?FbNYWX8WiDVPXxLKpgqQhpZITGhz7jAJ/odYzgIqTJqwEHtB+wZctRWKqGKj?=
 =?us-ascii?Q?qU6Xpe8ISgLeBGC5ZAr2xbNbwvwRSazLjDbQxdGioSRdi2djHgoAxxuHruyl?=
 =?us-ascii?Q?nWIY9RlM5pkIDsMhK2rWpTDIKBqlEHYhKKksfAxRmIIOMy0JSe0sd6/AHvVE?=
 =?us-ascii?Q?qvLp8Xq/0ygsw4NJoixpWISOdidF6aER953foYzHtDicEGqt+5duubx+NAAD?=
 =?us-ascii?Q?A4H79b5PK9uTGrdOZpTYc7ds?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0e80f3-367d-4100-1977-08d96d6f3fc5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 17:38:03.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKoN6tqjDdsQqSZ+JoTYEkPs0YtXzFdEPRuG0O2ZDouEIJ1P9pGdFOnY3dvoPK9R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 06:19:03PM +0200, David Hildenbrand wrote:

> > I wouldn't think it works everywhere, bit it works in a lot of places,
> > and it is a heck of a lot better than what is proposed here. I'd
> > rather see the places that can use it be moved, and the few places
> > that can't be opencoded.
> 
> Well, I used ptep_get_map_lock() and friends. But hacking directly into
> ptep_map_lock() and friends wasn't possible due to all the corner cases.

Sure, I'm not surprised you can't get every single case, but that just
suggest we need two API families, today's to support the special cases
and a different one for the other regular simple cases. 

A new function family pte_try_map/_locked() and paired unmap that can
internally do the recounting and THP trickery and convert the easy
callsites.

Very rough counting suggest at least half of the pte_offset_map_lock()
call sites can trivially use the simpler API.

The other cases can stay as is and get open coded refcounts, or maybe
someone will have a better idea once they are more clearly identified.

But I don't think we should take a performance hit of additional
atomics in cases like GUP where this is trivially delt with by using a
better API.

I'd start with a series to pull pmd_trans_unstable() into some
pte_try_map() and it looks like about 25 call sites can be trivially
converted.

Several more can be converted but need a bit of work.

Jason
