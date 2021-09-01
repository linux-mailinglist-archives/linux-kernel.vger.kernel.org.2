Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A823FE193
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbhIAR4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:56:47 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:10081
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236746AbhIAR4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:56:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqN2a7Htcn9TYX+ru6jhXnGLNSXX9FJVPhKoH+vKVoJSlLvxio//zU8a81ntahyazIzF2Hl3TaGa6z67S9jYPD0R+uqmZ4+VZNHYxwDgrfwjG1h8KW6nMLeH8woMtvPS8N78/w90WK5AHj+DkQfTqMZk6ieGSeOzlbyGI6v03IKskFmt1nQxBh9MpkUDFBwlxu4ceWciAY2OPkexntlFP0gUcA0Jq/OccaQnzIf75M/qcTmHCvMFVLgDY9agSUqfULZ/Ha84oA+A1YhjJ6p70bhdgJ2esLxtPEkGuYfth9PVwzWm6UjQPQ3gcrGSWgH3+oKKtfJ0rbKwvgKKtUSNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=l7JObF8q/RSpHKS86IH6ykyhDHcqenCKP8pjm438bXs=;
 b=NINFKhexB1PwwGl3TAeky3zgNfsm05K6DxTt6CvKJCyv07v4QaD5mD9bNLc1VpFCT7k2SewtkE7ud8yxM2L6vHs/5JKLDviuYP+LchrEOWq8izvmg+KAfiIBfiO4CkmpAoEZ8sPY3yZALxL1EHqtQ9Pe3vIWonmFaqfCbrU/DnA52rIa9z/l+uO2vo9jAg9mymlXqCpwwM7NlCmjA1Jaew9DFsa3YuU3G11W1gBldngcu8dR6DHssFBDTMXGoy7eWmm0dE7h9UyaJKYCHv3YalIZwflB9FdZAs70FZWZ/sYl80RacdZuLh/TdPzR62fUbGGTHGVeWouJyf4iISUU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7JObF8q/RSpHKS86IH6ykyhDHcqenCKP8pjm438bXs=;
 b=RzOzdCEEQ2PVT5s3r3TARfE5YDa/dw8Pz99yNFAnHa+6TdQteP8CQa04lXF2Z7tnI5ZIlJB3FdAVFWy3jY/TFEKcXGG9ZcLKYJLogbaptTF670PCzx1RWRVRCYeevGlGscEU1M0+nvWf/XVBHvxuXzItJF1AFyY5kE+ykRW21Rzf1r8di690NYBrU9i3Zje/YvCpI4YhhWSINyzwlt/+bLWfN/Tzrr9cXax2V01isTu8o/JdLYlPSW7H3DUbtEk26bwOdziMWeS/5xIGauSBo/Xa1G9+AkKg8/bwO+l0L5MoptRksp2He9w8oWp15nVUH2uUsK10l6qObbzWeGSaVw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 1 Sep
 2021 17:55:48 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 17:55:48 +0000
Date:   Wed, 1 Sep 2021 14:55:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 6/9] mm: free user PTE page table pages
Message-ID: <20210901175547.GP1721383@nvidia.com>
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-7-zhengqi.arch@bytedance.com>
 <20210901135314.GA1859446@nvidia.com>
 <0c9766c9-6e8b-5445-83dc-9f2b71a76b4f@redhat.com>
 <20210901153247.GJ1721383@nvidia.com>
 <7789261d-6a64-c47b-be6c-c9be680e5d33@redhat.com>
 <20210901161613.GN1721383@nvidia.com>
 <e8ebb0bb-b268-c43b-6fc1-e5240dc085c9@redhat.com>
 <20210901171039.GO1721383@nvidia.com>
 <ef7a722d-0bc0-1c68-b11b-9ede073516e0@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7a722d-0bc0-1c68-b11b-9ede073516e0@redhat.com>
X-ClientProxiedBy: BL1PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0120.namprd13.prod.outlook.com (2603:10b6:208:2b9::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.10 via Frontend Transport; Wed, 1 Sep 2021 17:55:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLUSh-007vlb-5K; Wed, 01 Sep 2021 14:55:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b510e26-6c83-42c8-4a0e-08d96d71ba7e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5238:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5238971CE10CD808B577CCC9C2CD9@BL1PR12MB5238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aW8ghjSEghqVr87bXWq9DQVynJBmWGccy8BHvJAvG57PzMAMMj/2ZcAwKOueJgY0BLcyWJjSgH0qHysyAfXuT4fiXbo4kkS/5BuhhcPS4dDCvEoiv7VjrJsY6Uu/IwgTyF9xKuQCzy7ot5jmn8ssywDEmqEFhK7gV9rT06bU8282pC5vQ4oKzvdQeIoTZ//KdGrYx2pP7CBs/HpvcaTrB7IqsXSVjZyaHzmz2PuZ0LkLSwH01OxDxIBac49Lk2XRLb/kGeLfqB8b+ud82Nz8wgBtjwfQiC0JeOG77tWMFJThADpolBbSLwuQplQdVwri4iQO4atJxd+04NS2bHh2rw+jYXkWdA3UGKfO4wzANmTQ2urAviZxPQ9l32XHxsDHtUUjqpuGyTUUOmhkiip8AVxsJRcyoCXeSGCJ5frxHMp+londWbB2z9idPRubKGtBG9g8baYk553mrrrnNpYvCv854BSg8yWJD4OklLM6K7dh/4ajNrB4oNem9SxXzihvAQx+40Jniqo5NdGkiQ6ej66aIUi3SPA4+EAcus9MWxYnxHHMaYr/zjYU3xyBa2X6FLg53inOqsPOqzIXIhg3OwoQCY1g1ejHclloFwtsRFfSPdGUGaaA2wqdVO2Nyqxic+T8EsERCT4EA8LZjbf/8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(53546011)(66946007)(6916009)(36756003)(66476007)(66556008)(83380400001)(4326008)(1076003)(26005)(8936002)(426003)(38100700002)(33656002)(7416002)(2616005)(86362001)(9746002)(8676002)(508600001)(316002)(9786002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?goSZ4bVgcP/qif56Xwniq5nthqj0KpQRzXhTpSyqv3peEQrLW9gtIauqWEIs?=
 =?us-ascii?Q?h2xPsC3NpheJoAf0BvJfzgJFZ0zjWDTgl+jb7KB2vthU3fsAosFCcVHZceK7?=
 =?us-ascii?Q?Ivoj9ZLdSz5UB9Uu4rA8yEpoBcgv8/svYxwnKE5ho+Dizag7A8qW00ElVvzf?=
 =?us-ascii?Q?YD/3oQYu+EfjTCEwyCnTzk7g7wNInOoUpV8Pwnbq6F4ymHj++tbUw9ZEFJDB?=
 =?us-ascii?Q?EkzFCXSA8CdfqMA8ndksJ7A2JhiDehNnKij/fVnYH2ojxiJuJlFeDxyVPTlz?=
 =?us-ascii?Q?lVcq+wFNfG0ddSvFUPuUdDVbc3nCjzcjOyY7uZ50ehm12XQTimcm2QmOaw5f?=
 =?us-ascii?Q?XWs/Ht4keFVrbXM+ikoiIEsq8VaRjQ7lkp6KldKOEsIcvkSxPEyOs7S0+Vqi?=
 =?us-ascii?Q?ZI8OYBGJBmHLRq6bc/gFa0Vbe8tlulEVBn3sSGvzU9BoLhAx5ZLMqtdku7SS?=
 =?us-ascii?Q?2Us13PtL3PpINadqls6zMoU27up0DXVHAM5gxW/e8I0EEy0FoKesbGBoyBUK?=
 =?us-ascii?Q?sC4UNWV08UhZIMiX9rqLAxhEXxDbsse+rYj1Sa1AVC9i1N6rza7h35KmR98p?=
 =?us-ascii?Q?o9HWuyftHbQ7ItBSaKg2GDvkN/W1RYjKse7wt0jM6Q1a8yg0/LRCY67U6IkM?=
 =?us-ascii?Q?r680PDisr77ersrKmAOAtJSasv8dOqTnMRmEHORsbjqO6aIZCggqkZB1ESRA?=
 =?us-ascii?Q?ytJbTQw29EKUgYml/bKmy3a4Om10zMI8WTLLgVVPbkqV8ezskY3h5eLW1WUT?=
 =?us-ascii?Q?GKxxCD7s7Jt+6e+e4cahcMazZjCnes6zb/d/AQefSdo0lsLKtjYtV+z8MuHz?=
 =?us-ascii?Q?U32+evoIGvDZ4y4Nu+OW7HWbV29dZ/jyfPbn/hzlMS2kvD2MtJJh4rcfoXDm?=
 =?us-ascii?Q?GFnZ15jM+431VfV0lWI5J/MbTyYTeFUr8sx9g91RQ3D155PxZgaGO8Dc7XqB?=
 =?us-ascii?Q?cED6ZoLa8EUV2dQ1yR1r9F5wBeOKOKpMJ0wyVtPOw6cwmBNeok1aVb5Ux51w?=
 =?us-ascii?Q?aAyF47ZMlI36QaEh0iagAlD3GXIGck+eLH4KjvQPBS4h2wRFNnhyelluWL7n?=
 =?us-ascii?Q?11exIC6mqWdtSzdGxk08ZgbFR1L+EFIN0xzbLJeiZsFk7gwU8gZp65EgnOQj?=
 =?us-ascii?Q?CPhMaXUkSz+MVBM2toufmIO9Q1dbVWBkDPejBJdFCBU57gcZyn2/0cMkKDY2?=
 =?us-ascii?Q?GbXNS0vIlm+q0RSc9ObVXNXrcpsvoRdeYgts53swpwfCaWejGgklVoV3kTyG?=
 =?us-ascii?Q?VPoKu4hkjB+uw3MefsGCHZOzvRi06rNWQNMFJimOgSicTqkp17SXr4IbcDdh?=
 =?us-ascii?Q?O8PJDEs/GVPJUkjCD8UVB6xr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b510e26-6c83-42c8-4a0e-08d96d71ba7e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 17:55:47.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33cm9+02uRm807fewe3NhgW3tcHsuOTGZES7xTwryDpaYM5AyAoiH7pierP32ZUo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 07:49:23PM +0200, David Hildenbrand wrote:
> On 01.09.21 19:10, Jason Gunthorpe wrote:
> > On Wed, Sep 01, 2021 at 06:19:03PM +0200, David Hildenbrand wrote:
> > 
> > > > I wouldn't think it works everywhere, bit it works in a lot of places,
> > > > and it is a heck of a lot better than what is proposed here. I'd
> > > > rather see the places that can use it be moved, and the few places
> > > > that can't be opencoded.
> > > 
> > > Well, I used ptep_get_map_lock() and friends. But hacking directly into
> > > ptep_map_lock() and friends wasn't possible due to all the corner cases.
> > 
> > Sure, I'm not surprised you can't get every single case, but that just
> > suggest we need two API families, today's to support the special cases
> > and a different one for the other regular simple cases.
> > 
> > A new function family pte_try_map/_locked() and paired unmap that can
> > internally do the recounting and THP trickery and convert the easy
> > callsites.
> > 
> > Very rough counting suggest at least half of the pte_offset_map_lock()
> > call sites can trivially use the simpler API.
> > 
> > The other cases can stay as is and get open coded refcounts, or maybe
> > someone will have a better idea once they are more clearly identified.
> > 
> > But I don't think we should take a performance hit of additional
> > atomics in cases like GUP where this is trivially delt with by using a
> > better API.
> 
> Right, but as I said in the cover letter, we can happily optimize once we
> have the basic infrastructure in place and properly reviewed. Getting rid of
> some unnecessary atomics by introducing additional fancy helpers falls under
> that category.

I'm not sure I agree given how big and wide this patch series is. It
would be easier to review if it was touching less places. The helpers
are not fancy, it is a logical re-arrangement of existing code that
shrinks the LOC of this series and makes it more reviewable.

Or stated another way, a niche feature like this try much harder not
to add more complexity everywhere.

Jason
