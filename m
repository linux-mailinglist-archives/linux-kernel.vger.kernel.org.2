Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5847A44C1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhKJNCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:02:30 -0500
Received: from mail-mw2nam12on2071.outbound.protection.outlook.com ([40.107.244.71]:27201
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231162AbhKJNC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:02:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8b4c9NBmoQ5MAiZY1f9RwHU2KVu3VSLCbJ/lBVEyperFSoQSWb4KsCNl/lhbmX8atC+nRl9/sNlIXm+eAj/FfU8YP6ZOh6D2Nz5GSgsCuidzGDMCdop63OWwJj4sc1IHDODdPcEknDRlv2Th4YZHUDCtLWvvvqsX1cLpulOldXsrcq4OrEXWXqImGVeVvXOdJT566TRs0IDtUjq/dbFPff4Dn3ONkwgsndeUbBDZoJwFrd05zjqEIX6VfJAmJJPKBXaiT14vgzKynW5qOS578UC9cmLF58emSKmM2gjHNRLelVQfEmhaeviSP2LH64woSAeuR8TJsIBmCLv8uO3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M17zUeHPwpyhoWqJ1SEG95Vc5EVUR2/fWkH+3X7yaJY=;
 b=nimLbskuM4mVRtjxxGAX1UzCnLEKBquI+OV9ur/mhZUEWkWFr5YT0fnnrIdjtquebdw6rcOJT8ngMzG9i2L6/gFa6w1WiRE8WqMNLqysXGnBMTO1sJShihwNt5cOl2mpIl2YSqf2eQsNXpKKxiipZDzNZ0yQ9ZJeeZdGR5SvUzbZmyNFONDPlDGPCONFiNwjz7Nr9Tx9Q9ZBJYQE/QDRZ1iCUBpgV8tP4h8nM+RzYb4GY58kbh99VHJR34c7JzCQAJ9hkJqcRoXpX0BqW6gK8oxHQhZucG4+VeTp75wyie9WN+vCZLX54Cy8xUuK1DjEFLg1c+IJGNGSOIHw9cYYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M17zUeHPwpyhoWqJ1SEG95Vc5EVUR2/fWkH+3X7yaJY=;
 b=kyCaUQjF4+4S4ygV72T6tfWjfeqMp2ttaPiwnPudLj1VvaSfFLiQPqrWfRZZvnt/X5zwQGCgUUeE/QbZbSMQssK9u6znQLRpVwN/DJmdmIO5skiAW4DBs4E3fhUo/DZarPAF2770clC1+JCFEOxvXDYoq+By5vlfh53StYLtbhtR29jD4eq2l7W0D/dOzk2ochn6MkOIH6KChm3VLZI/3l/n8C9Mu22KifN1nYQvixIahkXd04hFKnDu8xnqZlD6Yjm6o5pzxK2ldmcQYQGZFkzJqPpuA0KJMspSHoQB8JROdOQIu6id89XaFziDlovvPVYN3pE/pvevIxSVJSbCKw==
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 12:59:39 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 12:59:37 +0000
Date:   Wed, 10 Nov 2021 08:59:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com
Subject: Re: [PATCH v3 02/15] mm: introduce is_huge_pmd() helper
Message-ID: <20211110125936.GR1740502@nvidia.com>
References: <20211110084057.27676-1-zhengqi.arch@bytedance.com>
 <20211110084057.27676-3-zhengqi.arch@bytedance.com>
 <20211110122945.GO1740502@nvidia.com>
 <18fa08bf-847b-1c47-10ee-01c92caeb0cc@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18fa08bf-847b-1c47-10ee-01c92caeb0cc@bytedance.com>
X-ClientProxiedBy: YT2PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT2PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 12:59:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mknCS-007xvG-HV; Wed, 10 Nov 2021 08:59:36 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d8e16f-af4b-44e8-ef38-08d9a449f3be
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5192D73EA60DB75C7905AEA3C2939@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HQZ+DZKb0uyjZBIlPGdp1TrDePd4/mDnjRBwdhURBokU7TAtYD5GeCZHpYnyh17kn8hvsarvXDqzgaxY+Mbfxd+KgVX8DDs/QCZw5vpZ7JLzgFC/hhAbi9xixLu4P2EqL9FBiNi5ehCuic/ApBsJ2t4iqgWk09H0fTX3jmXs+uCgV6Zgm1sVPc/u/hFXZuL5eVgTzF3apU2T47pdWIUtSbNs8Et4ozQ4ruJUTGzZjfPBpynAcNRkTHzstl3bZRjkgpemgz2ahckKP2R7Rzpy3QQpcy6Oi7xRK3ElPM/hGbW9Tz42RZapgZJiwoHCVSxrZKTtujHEVU6YbN+l3vXeWcm2CZuZjZAt7kPJn6ujLaKV5qnjLv2O6DW3WK0zJoB6aRBtcuAtIfJnKEzb17pdEJWLa73/R4m8dlZkOjnEUCQTroN3qJpaL0sW5lY98yCSvA6Hq8OTHbzr1lE4/zRd4kY+yuI18hHElCGZoMMQxj/Ov9Grg7uREu5TJrYk9A5MeZ7JaKRIyssIakADu8Llkpx8DBgQFj9UCd0aNoxIghCB6/N+Rc7UxMVuz10T7HOI8q+U1X7uIQjA6yOtCVJyAGDkx/cqMCgyli7xvzIXeWcQDRuKJPYnZ5aIoVfI066fNLAfVtWRUC7NwoS6NpRwESZCw+ko/4p4l16MeVLT2bWKPtxU8fgIdBK+hO2sqGBrzEELPQ3L488O+DngC1R6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9746002)(316002)(26005)(33656002)(8676002)(5660300002)(36756003)(4744005)(53546011)(1076003)(8936002)(4326008)(2616005)(186003)(6916009)(426003)(66946007)(7416002)(86362001)(66556008)(66476007)(38100700002)(2906002)(9786002)(508600001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IL6Q/9Xxzu6xvXktHLkJRuCfPDlARdK72x5D/yx0HgLc09ZkcOFo5GA7AgFd?=
 =?us-ascii?Q?52AnPFR93jDDEYMnAJru3cJ2dsxrDcEKg36GUspf97EmJLVHduT2KA/gryuP?=
 =?us-ascii?Q?uFtHaQHI8MOs5OnuZqS0m+AvFzFfTJkbeuvs1lZWDfsJlTbXItWxme4jFgKg?=
 =?us-ascii?Q?WE0CLj5F60sWvPosoZti3zTrWoXJkwhop3UM/KE0nLdw33oZ5mCL41XRgPRi?=
 =?us-ascii?Q?8DQMnG/pWnJDBdpn1RzX4PDjCwxSPph1hkPQe1tNj4siRMNaRqHMo3ZrylWs?=
 =?us-ascii?Q?4NUGHuwHSRlJ+mEmKrIuJVxYTqVX1HhxvTojaOuqdhucLlFlPTo6j3gwnmo1?=
 =?us-ascii?Q?kPPUCsVxCdaEZdMOhaGSubG0qbi+CSCDBpEKuHVfJ/mAk4OP82DK138H8mNO?=
 =?us-ascii?Q?MorWsc/vJdZ9Hfyu1pOHnw+45HVRXDuXOOBJYgrDrDczaKDB5Yu6jFVY6cvZ?=
 =?us-ascii?Q?TQFmw77c38/9t1z3sLl3vvWu3R5zPjHeDsij/tabvf4c/qj9QYl38Icyd6Kj?=
 =?us-ascii?Q?VRgS23LcPtT9zXz1PBRvQIq4Lq/cDinE+yfTTN4IYiz+K3pVFoP9LVQpRXNJ?=
 =?us-ascii?Q?K7KfoIhI9nyVI6UAcymxRbD9lLWrtSrnGf3UzSD3vaBkfsGw4AOc7ebG4FRK?=
 =?us-ascii?Q?NTfKwTPSzuAE0bUhooYPnRvnlKwxsUGeIGiI7JhiVocQprwOH3AKyPGP9aRR?=
 =?us-ascii?Q?B8EJOA8xqL5clB86WKTREZXIf/QZD/gNx7N7vpDpDEM04UHdSpb290/voHrZ?=
 =?us-ascii?Q?CR0RBCL2rs9WGQa5OxEbyc3phF+CJTQYw05nEayiTyAKu+kCf3wUuX74R4gl?=
 =?us-ascii?Q?Ds9ngXbLrkk8zxbZBe6vgIcRoj15bsWgCKsti8mxXTpTV2TROKOzbQJDAs/Y?=
 =?us-ascii?Q?IcmGO1khhXVVYiVWV8ygzDsBux/0gT4qvqLtrG0voBIp4lN2tlWGt/wyWX3p?=
 =?us-ascii?Q?R7wsdCaDkBHMZTUXV3N4frf9nyDbg+A2t8qEqpV7lKLksk1H4W1zpmIQdBcu?=
 =?us-ascii?Q?K+M0IjjjWtG51sq/t3mwPoSPjXPR5/HXyxY3DcFnA1sXzVwvgoSI1k96eKWf?=
 =?us-ascii?Q?63/g1tBr0YbLFgRG3ozWNC8cbrECwQQHmdUSxk0UOqChF8eD/cOkp0KIPTrT?=
 =?us-ascii?Q?UsjdHuRsksf7i4+zRdyM5OhUWeyqkHQCsjxZ8FIZnkiTbXZr3f6/zp3KKb//?=
 =?us-ascii?Q?zaSmCuO7DRCQ83lLbYiSBR5DQ3NcSSRcvALXO7IFAxIkHt714qGytc4kv8ZX?=
 =?us-ascii?Q?T+I5zA880xwUQ5tofhxVFoXiObztOWWdZhuyTvPSgTfjojJxB+HsX0bvo1X7?=
 =?us-ascii?Q?9ePgeVXSmZDZVx2BkyokPCyrgq/OeZw7ocDoDqm7zIw52FcbDcLXgqyTtTC+?=
 =?us-ascii?Q?AOXohBYy6fkNZpLYvYMdSI8i8Y9yzjR5cujLC2znCoNMOSZfVg+iSQQqDH8D?=
 =?us-ascii?Q?VkSF4+/Qjc0s/hoZYVdx7Qf7CJzYdQqEl5Z3D6AgtLiQ2SkXfkJbXO3xfn/2?=
 =?us-ascii?Q?Ou83GU7T2jww1mX3mw12KLMab6bK5lJXf+LTdVJGTUF3/1JvjH+cGJhOI+JR?=
 =?us-ascii?Q?A3ru7/rNIEs4scTS1io=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d8e16f-af4b-44e8-ef38-08d9a449f3be
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 12:59:37.9386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rj50IIDm23VhCp73G8MVsYkSRQZHCHvdjfPRofC6Wkn0tLI8yjwDAilIWedzjEWD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 08:58:35PM +0800, Qi Zheng wrote:
> 
> On 11/10/21 8:29 PM, Jason Gunthorpe wrote:
> > On Wed, Nov 10, 2021 at 04:40:44PM +0800, Qi Zheng wrote:
> > > Currently we have some times the following judgments repeated in the
> > > code:
> > > 
> > > 	is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)
> > > 
> > > which is to determine whether the *pmd is a huge pmd, so introduce
> > > is_huge_pmd() helper to deduplicate them.
> > 
> > Isn't this pmd_leaf() ?
> 
> Currently, the implementation of pmd_leaf() does not include
> pmd_devmap() checks. 

Are you sure? I thought x86 did via the tricky bit checks?

> But considering the semantics of pmd_leaf(), the "devmap" pmd should
> also belong to "leaf" pmd. Maybe we should modify pmd_leaf() to make
> it more semantically consistent?

I would prefer that..

Jason
