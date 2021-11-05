Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E9F446358
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 13:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhKEM2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 08:28:41 -0400
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com ([40.107.94.83]:31435
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229529AbhKEM2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 08:28:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6VZqvacFnh0z0pyeb0P6wz4aug+MeP1KCbg8mbSeLHKcLAtTp0KwkykoPLbzkaH/ULBUTItIqhzBs/ZWndlnjV/aKSWk1PG2r6c+owgrk5arWA6aRkTHUDVSG8ZrFa5asxRgMNlKrO2Kz95GrmgKFK8ZEhBgYoAJaPz7LO1vw92WArvGwmxV6BZBg+Kv+il5HomN/Y3WJ70vciwCoZqvhWU+ZduCyrpi+BAaWWd2m5V6OASe3+yB5UyRT53CwavIACgxc6Te7QUQZe6RZtOUFgf1nPBbR3QkCxGXCI/fJmR4OESJ+0Mllf/3yEeSOXdsLjFG5W8P3HIrPH6tOiq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxSh9JBm8RX07FGKohe2gOYvl1bfUB70qZZKcqVa3MY=;
 b=GarrsLFvbgMHZ2/8Q7xxfUqsBm7iAR2FsS/jtjYDGOzkVYKPfNdurMGUtJGD2B5j0LTif6zJ3RfBOXAJRSzDu0iYjuMdfEbpJWXWdI0VHBnvDcqZmXjWzqOk58pnSH7SfM7BihK6uWEU+cAP/C8ZHTL7fsqLebGj/LdXIVqr3pTLMv0oM82PEJ267Hr/qYfU9M+h1QHsmoK7HIi2/Z0pvXGwUFR9ylsS5uwkYnFm4AD4Miq5CSPTjTtco5ZTGekRV41mpVMw9MXgtzfznYdqiKFwLrZEftGVdJZq51oA8vmQqHi/cU359zbqA54IwPA+FYTQBEjpO8vpsBu8cF3aMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxSh9JBm8RX07FGKohe2gOYvl1bfUB70qZZKcqVa3MY=;
 b=H58jO3AIOJvTXJEkceDVqyHtM3AFu9CL8J8DlKtX0EKXSvrFLmK2mn9wAwfJ1HNf9e7suDMNN1kONq/vVmC0NHEEnc/2cs9CV+J8HJNSVhttHHdoXvnd9LlQhr9fL/s95F5nHqHS5I4H10NgwLTwufkfRHNYvSfdvIVUP6dA2rakIaQLlAfX1L9WhPNBjVcrnA6L402ccIWtE86MrHKNtmo/vlYsIELOpDT7klqZ1dcFmEWMN6Q5Nswxgelb63xPE3lCHhGtp+X9ehTgwX9Zr9nqFqCYr1U57SgF+3iSAP0Pk9lWx/9b5LsH6DR2xL3GGL3jHkLukpQnNivD6p/HwQ==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Fri, 5 Nov
 2021 12:25:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 12:25:58 +0000
Date:   Fri, 5 Nov 2021 09:25:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, jglisse@redhat.com, jhubbard@nvidia.com,
        ziy@nvidia.com, rcampbell@nvidia.com, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hmm.c: Allow VM_MIXEDMAP to work with hmm_range_fault
Message-ID: <20211105122557.GA2744544@nvidia.com>
References: <20211104012001.2555676-1-apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104012001.2555676-1-apopple@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:208:32a::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0099.namprd03.prod.outlook.com (2603:10b6:208:32a::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 12:25:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1miyI9-006KQv-Fh; Fri, 05 Nov 2021 09:25:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da3e302f-0de5-4987-dde1-08d9a0576bf3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51735569BDCAAEC81F588DFCC28E9@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKzJNoR6FYFGm2sUUkKR9Et8P87v3EI1SDVO1DvC3WtTHvDNy8au2Pp8JPfbT3/64ijB9PCU2JEbXMi+VErdIeHPwDRCHuLmCn90rOhF2ijrWlC+N9UO17+tPb5nTjbTvRVd0Q2pHwdKCttbrxAIldcI+v6m3SBmxhi1PYcrtfKJlybGA6jBFBGRj7aaD0HM9QE0SsoFqcbk1o3hIgdzWl6ZMeERak0/fltiQkS9CdCdZa0WvguRj5iBOOoDuyuawxFCsKkVs6e4gKRqA80CAZn7F3priblkCrDb0Z7Lv+wg9Q+CTw0ScF8QgQUCWWwTa+CImDm00VdnIT0MuVWJdA0FLtm6jBgrniPZJs7qZeKI8tvh+2xzIYFr2ooYJD1XQ2T0a5MJDc2NSV1zgFRR7bhGOit36kRqBVDYCjEFpBQtmc+0qpx4mzqerztIon/uoQ7a2xOlgInxMIhbxAtvRwW/FjIaEWHgW5qbMWw5s3KU3jDspCVHlXCToBQY6OnZixyoxEhAAxoXcC1rQSBXNGzrsWgZKfRNE+sltjs9/vMG98X8WnZeuX6hKdedvXJESPNTy/NG1lwbLUFeD5081ypt842QPB31CyBc1aFKhNRjZR+FnAhQbsxu/y04U25gRrM8j4FyztlhCQJBHVkB3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(6862004)(9786002)(508600001)(8676002)(83380400001)(26005)(33656002)(9746002)(37006003)(2616005)(38100700002)(6636002)(4326008)(1076003)(66556008)(86362001)(316002)(36756003)(8936002)(5660300002)(426003)(4744005)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a2FwYSdT/pdZmqQhRKpeOwxb3vNX5Zif2lZFUzfIEfYSsCbBNjTCAnC+CbF6?=
 =?us-ascii?Q?4POnO/0/SIdWjP1Nlti7McFF0Ov5kE1q1vbE31sxW5RCl2f4JDN9lrUgqpOD?=
 =?us-ascii?Q?JXN/JEggk3gqYET/awucLxRR3uobsWkSR5UYFtXBc8WYzXMg0xXMl/R8ZAnh?=
 =?us-ascii?Q?LfisddPrY0I4PXKrvl65tsHh9lcOetCHNTyE1RFzFInqruBLetxKiOQbCdqM?=
 =?us-ascii?Q?/8+9Y9xsQmVktptkMgncup4WM9rYUX9HGiKoT22O9SxjvQVFRLgmd4TlUo58?=
 =?us-ascii?Q?lWa5BkqSvKdnPcCwVIG3VxBXLEBpylCzrF5/PYby4epOELxuYjY0yOFN4fW8?=
 =?us-ascii?Q?Fi7yflD4Nd8YWJqXiGjGwz/aWWZ04214N/XKaceK7oYiYQE0649HP6Beclec?=
 =?us-ascii?Q?CobLhPWbj8Vh30wEHLbeI0m61Cx+JQ9twWWEn7nSfl2amkOnqx00H7TZYDum?=
 =?us-ascii?Q?4QlDDnNvvq81CI2iSFTZU4Mj/9BtYMWj0gXhiLWHp6j6CQ2XEbxnPgICqItK?=
 =?us-ascii?Q?VsdNJmdK3ytM9lvMTqdZNFnH2FWsK/gztCBDX1+BtvQ9tzL9DIz6Jlue1ghl?=
 =?us-ascii?Q?ygLuATPy93+S9BlJffjyN02Wsmtl1cPaPQv8DH62AXpVw3HTWcM32mWr3ydw?=
 =?us-ascii?Q?wUbkgj2j3Qj3H5N7hxNUxctBnuAFBmEGpZVlbHgmX8sXeR4tS+1k94oC5MjU?=
 =?us-ascii?Q?Z7l3WPSXO1ul+7ijaZ2UqOyjQxgPGHyjyx4NhmoOw7XVDiTuQIlHVqWk8LCy?=
 =?us-ascii?Q?GensDML+5/+xDQS3kAH9vC2zz/kSHiZEflLf4pwgZQ3qn5c0tlMkz+Id4IAy?=
 =?us-ascii?Q?GKdWPWC3qosz4qECyK/fOZ/D9CNE/AQzyrAoUeU3LSMFRJnDM/HRWxbp0rXt?=
 =?us-ascii?Q?KAUZd4WGftUgOK0Kledzl2MkgPdiRQKuTI+i3q0SpFdWr3HIHom/wRZfcbfa?=
 =?us-ascii?Q?bm6RmRe2szVHPu0JxcvagX8c7o9/huuynbfuDPeuuwOONxcJc9BhVGRT9qdu?=
 =?us-ascii?Q?gC/DE9hd0cW9ctv0SGs+OeNQKVLCudDmDa+bzEgR182mQmKd4Evu2WBVlNVG?=
 =?us-ascii?Q?KVUAe7bDWgk/yzAqF6nyxY8ore5r20eVOnEHkJEZ/1qzqZl6T80rPOTbfytN?=
 =?us-ascii?Q?Fsvsp/igqnAPUMNLPnf9AvEY+U3Ayqs3QOoRg0wkU8esuUTBU6tkmisNLmlt?=
 =?us-ascii?Q?RsPCJzEv83kwQIZp2daKyxCyysjdKyZDim7dP80I30kMhgV1PLkMm57nUcP6?=
 =?us-ascii?Q?RWQfCcsfkBj9k+Q+eQUEPhRvDeR0LenxFDSxRgirpRKfRoFmDGKGT3OgWMoj?=
 =?us-ascii?Q?4nKzmLuTune3CQ93C9D1vKJZtsjx/JlbuIxOJg84PdDVpF+FI8TrUomZIb9w?=
 =?us-ascii?Q?MdKVNjjW6YQwXa0mcid5BFdTQaOwU6XVsSFhrvar+8yZXn8ACCyXz3yPawmp?=
 =?us-ascii?Q?31aQqGuL5bN9GBL+2NA/zWvqw12d7ki9zZ11q71p/d0K7sb9k0cZp2AipuPQ?=
 =?us-ascii?Q?mmIh1UV+pT/sYyeLd12+ZFP4om3jpjR01ZssE8TaaiUUUSsT2ZEXwEmAP6cf?=
 =?us-ascii?Q?PYWYSOrShkizIvKrrkQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3e302f-0de5-4987-dde1-08d9a0576bf3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 12:25:58.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXPpIlyU5Bs6+LC24v8VLIjDHRd1F/f4Zi42X6YgGLOkBSXHBu37WhjvH8eEI2rs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 12:20:01PM +1100, Alistair Popple wrote:
> hmm_range_fault() can be used instead of get_user_pages() for devices
> which allow faulting however unlike get_user_pages() it will return an
> error when used on a VM_MIXEDMAP range.
> 
> To make hmm_range_fault() more closely match get_user_pages() remove
> this restriction. This requires dealing with the !ARCH_HAS_PTE_SPECIAL
> case in hmm_vma_handle_pte(). Rather than replicating the logic of
> vm_normal_page() call it directly and do a check for the zero pfn
> similar to what get_user_pages() currently does.
> 
> Also add a test to hmm selftest to verify functionality.

Please add a fixes line

> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  lib/test_hmm.c                         | 24 +++++++++++++++
>  mm/hmm.c                               |  5 +--
>  tools/testing/selftests/vm/hmm-tests.c | 42 ++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
