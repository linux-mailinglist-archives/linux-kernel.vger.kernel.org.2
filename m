Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399213FDD7F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244562AbhIANyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:54:17 -0400
Received: from mail-dm6nam08on2047.outbound.protection.outlook.com ([40.107.102.47]:31104
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244846AbhIANyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:54:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCjFnXm+0V0VwDKjr5yTyG4wCNNWr6MJqeR/OXM0QzRJ2REHThoMB8t5Wo+6UMIJHt89Nmc6pikTuQfhtiMJ+kopX8OiX7WVCg1BenV3z4oslk1V53/7lka+72UDFInRLAP912T1V1iiJ/VDZZ725Bta3A0nggPG8AH3Zt4IU/DuA45tEHF/EFuS+Fgu4qow9k0w1GVghDGaUdV3IJyjgiTTwEOImMMRiW+Quf9HMwIzBUBX5/DogXnZiuAiCGtZGL7liy1ewPCI6kxFcxJ+StDOBgt6mdSLSQIxUyezj2wsw5ToL8t7GtqqIjCqU6YfuyQr6CLUN6uz+T7EoM+g5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRzi4WPfDQkmKfbJMy/tmtGoOu1mAqKmKiiIRNGP804=;
 b=ICqeAs4T7vLMjTyia327vaeR8c1T7R+I1nLUkkH1fRHeNKxlPZmGgUmUPcMOYXiJuUOYtU1nDchR0T2zuPROCYKOvPK1HZTDinhUITyPKIg8dI901ihoTlq2qi7gumAIAykwKGKVcRPFQiEOB7FaqwogN4OZxab5nnqNrzRkzM1r2Hvp6t50J5OAKpefTLmMadQUMZnLwEep7dX7WGvSxlJBITHe1GJYKQG5fX6ABjS670ABPt024Nrxoc4OV/gG+pQchxIGv6Dw3vP3s9RRhlq71E5xtderjQzViWCxW22VGdYCeqVfZsfidZrekzTHOSMRwsv5+YIm3MKUOUUErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRzi4WPfDQkmKfbJMy/tmtGoOu1mAqKmKiiIRNGP804=;
 b=QhTiL3FSxM+Eap7yG08zuCNhbuSkFg4aO1ICVXojJsuO/woAt4xQk/9CL0w2KdiiYLGholCNFtteLch72AFxfwHGO67RaL1arlN8mN01KtIK+qmyngv2rK93vu5V/YIwLd07+s3D1QAi7ySRkEtjKcUOdojhiPLa9rPyzXFgX9TxcVgbp5MpLiDSo0/XkzJCNuduNyZa31HFbEvJf0gqYTjb0ZL0xWhy7tnoMTZqRcsgnUdT9wxOu7Maeb+J/BFlewGkmCpoeryPwGyeLqs7wpCacV5E4quTFz4AhvTlcgA5tvXlvHr7w9eEwN7rmd00om7GM1FaR2mLijTkPZFNNg==
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Wed, 1 Sep
 2021 13:53:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 13:53:15 +0000
Date:   Wed, 1 Sep 2021 10:53:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 6/9] mm: free user PTE page table pages
Message-ID: <20210901135314.GA1859446@nvidia.com>
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-7-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819031858.98043-7-zhengqi.arch@bytedance.com>
X-ClientProxiedBy: MN2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:208:23c::9) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:208:23c::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 13:53:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLQfy-007pbH-5W; Wed, 01 Sep 2021 10:53:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbd00787-d1e4-41d9-5762-08d96d4fd883
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5286AA93D0DBBEBEFC6E12F6C2CD9@BL1PR12MB5286.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nhfqv8viZp6jYigElODiyvJ12lBmOa4z9s+RndLYmkRmQvXt3G/MUyn6VJYERP1wwDrmtuwzj0WkfP9P3G1STYzrXGXSm2ds0sz4nmxt4lKWb3wezXwRJapaxUbDrtN29RgoX5ocYrVXv9C/5CItWVrEvUEoP9HYAOjKNBZ8+thpDiNwhO+OfizrJ6xosTtGA3mZ9+mf+6go1ibLZT6B+ypID0RZcdz9IdEn5S3oZwlScbstT2y11/o2vt+JbNqSdvf+5PAsIf8xFx6MRRBPzUdTKhNphRRDVamq+gl0iHhPV0BzAAbvRhasZYKrN/aI86chO7GhzF2awBZk/EtxMvJe6koO3AKVS3mhWgHrIVJHAA5zpBzRm8+Q7v1+pQEOo+5BW9ITO3+5awo+bjHQ8y0SD38RjMqA7ZSnRiwxBQ0fxynsP0xwapeWMcP/CIN93uMpVKHGjOC4UXikwDy/qV+IGwMXpTc7tFSxHMZhmfmYz09mxXNn+qjAD7r0613n0Qiz2fQSAYzk46mchRPoOd6xEssSK924GJAyGbZH6E/Xp0KLv1DT8p31Nqv/KRh9Oe6hyZPNk5E7wvhP7IhanwUHaIjw+/8Y0OITqkpOJSPcex4uSCWFnUMOrUyXi3PD473J1yzFhzk8wGSi2vINQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(478600001)(5660300002)(38100700002)(1076003)(7416002)(33656002)(2616005)(83380400001)(8936002)(6916009)(9786002)(9746002)(8676002)(2906002)(316002)(86362001)(26005)(426003)(66946007)(36756003)(186003)(4326008)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iYgy8aU8TYIsPy6hex9g7Jk+J7EGdgoavXkrC1mEvLBMHchVco2V2z1DgkEZ?=
 =?us-ascii?Q?NhvGG6T+sQybN/Q9QAlVp59aCJIsKBfjiPfm2R2u24c3FamwTGM2Vfl9UVLu?=
 =?us-ascii?Q?s72V8+re8KTrm1XhzUNN23QNmZBcMUai5M2qj+SvxB9fwruyRKecoDJXU4Et?=
 =?us-ascii?Q?8weyGwJEeiKEAJwQ8G1NpOV+2FURHfjlmrsGa0QZKYCbdPCPhkhS4nbfR8Tg?=
 =?us-ascii?Q?LzNSt4QxGLJJOADZa9sM3xKEGuU/p0YZSJf4VB0lYry1soEAwKLeJYZHYNlA?=
 =?us-ascii?Q?x6ofjycv1VHLJ2yvL80F6aDtV9Ab6I9NNBJzGenzOws3skW6znsRDzamvmYO?=
 =?us-ascii?Q?T2q8JfjlwwSBrhshaJ8k7rsr60wfEwnmrOOkWMoLG0wWb+CnZPGo3H4N0MGd?=
 =?us-ascii?Q?/7oOdV94+TW8Dcqp7l91+zOad4o4GHxm4TVnBBQBnrQyjIYH3J82i7ddcteB?=
 =?us-ascii?Q?VBn4DGSn0N7/rk3nLd/NBpUqQbgpeuhf9GqWmwKADjEC5NBQviv+wJRD8kTp?=
 =?us-ascii?Q?tYH4fwh1BIAChsldIJfgxP18g/Td8uZ0UbQG3AaeQK+l09hAxXbWvarNcoxs?=
 =?us-ascii?Q?5zJtzIGIs+xSY8nYpCwQIwrk+9IyIwtat/8uqi9zrBNa1DT5ig8YnLURqX5f?=
 =?us-ascii?Q?a2J5IBehO6ChxZQLaJFhPeGq33eWNuixmWdJt40UptC0D3b+YnmvaCa46GaT?=
 =?us-ascii?Q?Wr3V25ok22tHogNbuGiKyd/TjGXboCgjNnzZHWD5ATbjVvZFz6z+i5VHZbXq?=
 =?us-ascii?Q?TWncdwiGDqgVEbE03ug6iBLWf9LIMYp7DC27G1UacCzqq+5osZkHx9imqFUz?=
 =?us-ascii?Q?kB2g4EurMTlixjiu0hbEN5w2xSGCba6AzUbTiwEAIaoe8bfQUMirvWk79VhJ?=
 =?us-ascii?Q?OOHaxljHbklcRaMg7v2LscYrdiGGw2/AK0XRzDPOja+h3HS3vfSQZBoFfi5L?=
 =?us-ascii?Q?u+4m+VJ1UIL+uQ5d/e80vIKxXOnMyqgF2irchH7S66IbUSBABosplaazLEB0?=
 =?us-ascii?Q?OSpP2baDdwke3M1qsJTHd1CeKw8SH7FV/Cw+NfaURWkihD3p8aRZx0yp+0ah?=
 =?us-ascii?Q?EC7jvflLpcNTxsZ6Uec3exfoG9FNe6b+ZJdINguuy5YCAjm26qKXy0AUpRC4?=
 =?us-ascii?Q?31yC6nPYJlfat0/SHSWuRHlSAqfJD1JEH9xHdqYLZIAsWvZM2D2PDZhXVeoX?=
 =?us-ascii?Q?TngBdQJkrWDSdoo0S/QaYGuU4XhRrrZdsAXXWjUfmFdx5GGT9g4iRIBQKsgi?=
 =?us-ascii?Q?ZkYCB8g1pNxvuZL52v8XOZVRbObfYvkEOKS3pIZe5dL4Rs5f7R3y67NTIhd3?=
 =?us-ascii?Q?wBGB2UbmMBIlnS7V9Kx+nw2M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd00787-d1e4-41d9-5762-08d96d4fd883
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 13:53:15.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XGF31JXLi7W32QtTdMEEPYeP/bMjRvuVmWLGXsATBLWRM6c0g28qFN/7Io4K0xg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 11:18:55AM +0800, Qi Zheng wrote:

> diff --git a/mm/gup.c b/mm/gup.c
> index 2630ed1bb4f4..30757f3b176c 100644
> +++ b/mm/gup.c
> @@ -500,6 +500,9 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  	if (unlikely(pmd_bad(*pmd)))
>  		return no_page_table(vma, flags);
>  
> +	if (!pte_try_get(mm, pmd))
> +		return no_page_table(vma, flags);
> +
>  	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);

This is not good on a performance path, the pte_try_get() is
locking/locking the same lock that pte_offset_map_lock() is getting.

This would be much better if the map_lock infra could manage the
refcount itself.

I'm also not really keen on adding ptl level locking to all the
currently no-lock paths. If we are doing that then the no-lock paths
should rely on the ptl for alot more of their operations and avoid the
complicatred no-lock data access we have. eg 'pte_try_get()' should
also copy the pte_t under the lock.

Also, I don't really understand how this scheme works with
get_user_pages_fast.

Currently the zap triggers a TLB invalidation which synchronizes with
GUP fast, however this only makes the ptes non-present. The purpose is
to synchronize with the struct page refcount, not a pte refcount.

With this series the non-present PTEs are freed but how does this
synchronize with gup fast to avoid a use-after-free on the pte struct
page?

I agree with David, this series needs significant splitting to be
readable and a lot more explanation in the commit messages how all the
locking is working. Eg introducing the freeing should be a single
short patch at at end with a full explanation of the locking in all
the major scenarios.

Jason
