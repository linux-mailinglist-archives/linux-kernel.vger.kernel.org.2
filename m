Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2D44C671
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 18:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhKJRwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 12:52:18 -0500
Received: from mail-bn8nam12on2052.outbound.protection.outlook.com ([40.107.237.52]:37472
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232107AbhKJRwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:52:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoBbD5mTdQc0UXa2ZIXauXjbsIZIN7YTZlH8Ketf6/1ecu8q/VruyGyvRKxQgKQqUmWCDAWijF1wn+ck/1NkKPm/nd/nZYZR8lX1Bh4agcBQcTI/PL4XDtrDtzo+VnnhN7Mph0gkpq4S7haRJOke+YiliM3ADF1gwmH46R3dVj1X3FK0Axwbdgn7c275c4v0S/0UNDbviiRRo3ENFT59MQcpdswsFnwsxPz8zHh5zQK1+PkFmOB3Jg67jX5rU4/bahvPMPSkSkkCUC9FdI3DzgLhka/0rvzV753B6dlij8FnfVLSal4LOTENgdwrxZcsCd3H5Cxj9CbfcB4v4Cza4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiE/uAmS+brRCH08ycUwnMysjdCiIQzHBH/b/T009eY=;
 b=LpID+Mm3hKrTcnSnEV/vjR6DfMbCRDxneAdZZhPid8zODJfEgjibCvkT7HRHorlM27bxFvrVClKkd/IzlREtyQyI6eFscZV9bNALneX9LwVPZuDm/bAna0g4VCgW3lvlPaucHxTXdtHPnXBvyGcUQBQFcySZIGUNqlpiGsBRU53/YTnTJXUl6ZmlRLrXgCk6LvNejvMWIksjCEX2JCPrrqPDm71dr9yNrXP6PsyuqR6z6K4bp2OqIgPMSL+9B41T+ctwWplhvscRChlXjZ0Z5UQsinkctvDYNJoTPflbygmSIzrenXozt+pmKLUpMw/Ax/1N+2qoUgeHDkoqnWrBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiE/uAmS+brRCH08ycUwnMysjdCiIQzHBH/b/T009eY=;
 b=jlTOEkWhKpbUmFAo0fCbbfTFKDDjXr2Kpa7WUyQq7wUlBSovatW19d5giUuUVY2lA6TYsPRp9SonVnH+t6MDVn36Q8XFILuZObihmLskFY2fQHOHVgPAYQdKk/oX/HjgVS1k6FKWOQaH73JP2ouDkAlvhdNKMovm5R9ADmqBghTx/XdY+xJmHBzN5ZQ5JieQXN1K6/UojhF22vHwFbpkY+mKPyKDPFn1ktMgWRTHfxhPr3TKd8XGbNliPNwjjSmTpEBq2O89IL89VfAX1Ld+zJNaIeFHf0AvsQG3uhTY/w6nj21q0UHmr2B/ojP4lzLVN+MOoqiDHQ9TG024QlXFcA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 17:49:25 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 17:49:25 +0000
Date:   Wed, 10 Nov 2021 13:49:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com
Subject: Re: [PATCH v3 00/15] Free user PTE page table pages
Message-ID: <20211110174921.GA1740502@nvidia.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
 <20211110125601.GQ1740502@nvidia.com>
 <8d0bc258-58ba-52c5-2e0d-a588489f2572@redhat.com>
 <20211110143859.GS1740502@nvidia.com>
 <6ac9cc0d-7dea-0e19-51b3-625ec6561ac7@redhat.com>
 <20211110163925.GX1740502@nvidia.com>
 <7c97d86f-57f4-f764-3e92-1660690a0f24@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c97d86f-57f4-f764-3e92-1660690a0f24@redhat.com>
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR05CA0163.namprd05.prod.outlook.com (2603:10b6:a03:339::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.4 via Frontend Transport; Wed, 10 Nov 2021 17:49:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mkrir-0087iq-Do; Wed, 10 Nov 2021 13:49:21 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3a27c66-f0c6-4f6c-d32d-08d9a4726f7a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5112B115D2E93673D44240B2C2939@BL1PR12MB5112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eM5BquLDO4YnoYvi4c/ipRJZ561N7ChqE5XM/MddGCYRCR4vXeL2KG1y2h867gMQG9PFvBnI2W0yIcW7UtHcxXu/IFVvAMwEVrTu2z+BGKO2jJWuiR/p876C2a6KrN52CR8HIjLrFpjxAz8eFH7YCJU3rth86AQc9ydTjW3UCJvGZDMQIfyk7lTtrPVcB++54E1VCIVu8CO4V69SeavgtbZbCrhG9MpFKo5zfUit5j21280iopvMGGghPFBd+Hv9a+XAZLn6HDrwBR5SKLuvgz3euvZY5p3CflZmf1AIeDB9PnmTcCthNq9WKG9PRshQhfBvO8VVOXQWWd/4IyxeClqxMugiykO33cjUAqGbu1elCbufp219iOw0dpDdzKLWQlJBJGA4ePhQ9+55Rl0YXb7ptjspZnRy/YsySh7t7y9zF1sVuiNJwk7DQrMiJa+D47OwsuI6KQ+71BxVjqZivps3OVG2g2d6lfRKzBCxalBWCw3SmObgys3NHA2pclWE4XwGYdvqojTOa0g1f+SMm6wjUz4GSGeN7dCPTmuzW+/8n5FccDlIElU9nTzOof7MJkmb6oFpLQUPmGAX2ZxxG/beBaOhG1L1V4f3xcfY8jEkSL15HH8m1Zrzhz565B2lRWMdWZ9O2wsN6QU4oYBzjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(508600001)(6916009)(26005)(2906002)(36756003)(426003)(8676002)(9786002)(86362001)(5660300002)(2616005)(8936002)(1076003)(83380400001)(9746002)(186003)(66556008)(7416002)(316002)(4744005)(4326008)(38100700002)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/9yVqyra4jTPDPfXxsfjAlEr+IcBwBrY8zXdngsYavpFYStRpslgK/V0ZXGb?=
 =?us-ascii?Q?PDPgLHPmERf3rQmNchchMdL/wTCzyf8CHZy9nrAf4K96UJl8js6UL8U8IyU0?=
 =?us-ascii?Q?j8kkDdSLrC8Lh3pDgqZ6MUmChUgUnYuiyIl3UKfxc5an5pLJhcXNOAnzu3Ym?=
 =?us-ascii?Q?rntfVULmsA+XNeDdnBgM/Z9cz6fNd+5bfoB7L/ceYAOpsrGuu9ahMh+i4v8w?=
 =?us-ascii?Q?EFR2d2CxqOxHw3Xe3fS9lFH3vKj/tGjWGYC/+Ghf5akV90bKIYxhYsGSQk20?=
 =?us-ascii?Q?Kt7d7Ol47L7ikt7SCOtqT4ryVLkpPX9ITpSWiA9RAS366BMPa5U/kS81pVl4?=
 =?us-ascii?Q?62gy5S/tirjndpEpowTuEMlJp0gOHcjifhl/8lC/zlRKfbnIJM+xW5blbLM7?=
 =?us-ascii?Q?ZknC8jRrLDar0ku+6K394rEHahZHuF4GzNsX2cq4+rpfcSXZS9VnKLofrCY+?=
 =?us-ascii?Q?rqzmbCwE+BqzYfU1sVHnmxqIpXqu2zldNyG2aihFwon8NIF4Wj1LfdetzI3e?=
 =?us-ascii?Q?l7s3/12dLjfXD4ZBvplj8hImZRdoHTxLWiivvq9o/8lejgKN4eOmAihFtAK2?=
 =?us-ascii?Q?dfW8w5SUn0+PRaFT+0LChXxZ2J/PlYABKejj1Kiiu4AtyRkoNoNP4TleyetF?=
 =?us-ascii?Q?FF5dKWsvVW9Pi7KQyLJTSim66OfhYP4Zf7tAOj/MYHsKKP3d7L+VSv0Qa6+M?=
 =?us-ascii?Q?V8ph3row68cmpkOKhGgETMWCUEvuz4b7z8JDDKfywG17JOJN3V+P7EVzG2c1?=
 =?us-ascii?Q?nBJKK8/RovwhqRGRB3ftCuX6DqOBZT1jzF5Wc211igy5wUEnUQKM7PJjPwGZ?=
 =?us-ascii?Q?zayEYWpFmfRqvcx5Mjkf1r+Kh9YwGQtfXq7cf8W9dC2tbkNZVNt11AcyRA4S?=
 =?us-ascii?Q?IY4PowmQhpX7CRLNtvayvfr/rDJudHfsknk11ViRGJbCNVXxBRC8Z1yshxVl?=
 =?us-ascii?Q?ZSL2z2lZ4Nvwy/AGnQs2VVGGoUZl/3bA6PNgIYp5b8cbOnG0H/N1Sr6j/pVK?=
 =?us-ascii?Q?IiEP5ZJ/oH95FS7BHxYyyOsO5j3AkghDE9EfJ4ptwxYYcSBeqPgOxF26eB8i?=
 =?us-ascii?Q?xpWfIR72mH7BVGe5e7R2hXRRkJre8J2mx83nxld+AaY3tL7JPG9makBCaEcw?=
 =?us-ascii?Q?Emy+g+RH+HATQ2gpejI46p40+seF2muGWswqoBrpSl5y+gtX5nNzRf5yYDXx?=
 =?us-ascii?Q?Bj/PvKcWODeKgojKdkxqWy8gqGu2c+3zuCxi+9GopgfePpbATJwre+w5OnkF?=
 =?us-ascii?Q?TLCZgdDUE+AE/2TCJajakebc6L4NCtzjV/kHiZLEhAfuqpioUClzBJbZcLZz?=
 =?us-ascii?Q?l4u0vdxhOlgZiisMJQR8tflf3NB/12NRQiC4Jk19FIbiHxPegnxf9TYK2liy?=
 =?us-ascii?Q?WAPZbA7+GlEjhqmoaHy1xIdPpKuyuo2PvEtRncKA6vRPVltSk4m3q5FN5X6w?=
 =?us-ascii?Q?11/OTkLEDygpEV31Kb72uV09Ot5MVYFd9qglpkBiq77KyaqwzuNK+j8s9gck?=
 =?us-ascii?Q?ADpxixZABlcXHUGh1CR4ltLHJfSfHldqzNB8l/KtkZAOpxojyPWf0b11mBE4?=
 =?us-ascii?Q?LiKKy9nTOXV8SrbGjXw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a27c66-f0c6-4f6c-d32d-08d9a4726f7a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 17:49:25.4238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /C98QsPhPNjgOuqeVPZXmtJvQcoCvTxTeVjH0RQkZ2QEXviHa9SzVydW6HGN0B+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 06:37:46PM +0100, David Hildenbrand wrote:

> It will be if we somewhat frequent when reclaim an empty PTE page table
> as soon as it turns empty.

What do you think is the frequency of unlocked page table walks that
this would have to block on?

> Also, it adds complexity for something that is only a problem in some
> corner cases -- sparse memory mappings, especially relevant for some
> memory allocators after freeing a lot of memory or running VMs with
> memory ballooning after inflating the balloon. Some of these use cases
> might be good with just triggering page table reclaim manually from user
> space.

Right, this is why it would be nice if the complexity could address
more than one problem, like the existing complex locking around the
thp stuff..

Jason
