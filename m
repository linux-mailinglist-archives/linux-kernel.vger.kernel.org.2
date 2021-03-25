Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27614349370
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhCYN4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:56:48 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:5793
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230494AbhCYN4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:56:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/EQdy9MypPXjzDTq6zDglIQ260kd4C9C7R9u0FS77p+DkPGV//JCK+OfSBX8ZsS4DDQz5sZ5AhFb1tfY7VyMmfIi9dOJqRAdF0v74XuYDWMSvlf0ejnbfvhNdve/AA6sJrkHJw+SN+Z7od69Fa6yZGxi6Kdf8o2UIS+SbYJmQxMIgSwTvBdmtqbr4XSqy0t7Y8V4i3JDGqwV8nHeTl5Arcqg8mBVASHlscWhBr2k7gkVnHpVNy25DEA/we4aTLj9tvpNx4zNadQfaPCAfE/oyXjm31ZmaPVoTA/X4bl3m7Jc+wb/jUu7R8462T08yf/x4y40CSJvx8VVjyvx07nzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0spEM3RsqLiePQWkSRAtPAlUKfPyTADcljsaQzGDewA=;
 b=nRQAp5gm3dLRYgv8QReRLnIRRyN1vPExEVZMdashUOxQUUR+HuwRkuBKl33+e+PCz07g54USUfcno0lqJ1tJzA1e4Wc6JoujE1kOSIk003rerRqTUO45GvzJUXVf9thPbOWeQNWQDAp7talTmxO8h8RoPDYEWZFy1Lx8CIZ89s7RGACN8fBfFeYZ+AfR+DW06c8SC8qqiDEKX33stsPgHTrNAx2fagfzSQ7Ijzepkfv7sQUQylAHtevGN7zUSZp0DDjw4lPqaF8HaQ0m5e3dAB25Hemir7Jag6d0yfHRG9ztq0W1kzBxO6ZCpHVsgwZB3Q08LuvnNY6aPEQ6tBSHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0spEM3RsqLiePQWkSRAtPAlUKfPyTADcljsaQzGDewA=;
 b=UpHgznq46m3mjpPnGdq5eNZyHB6K9YJTbjUrIID+cGBi9HOKdvQKpCzsSUKHJVJQui6pWLxwhMf0uz1RnooSro+IKrDU6p5hMCo7Ugm8bShJvmTigcbJ9gG09tNiEFv21Obd5ZOepR7KCofxGuIOcae8z3nWBHGTE073JElUj2/VnMXDKqIxiLsdxi8eOP6xN68qGlHp3mF9Lpk8iW/YbMr1mH/2ybRjxjuMzwI5DQrFa7/xIn7kI4W0PeWlqJgI680oVB1H0AoLh6BDxH4rNImBocnUttFWOewsITheB1Ma9sx43aXHiJxu+Bpzq/rTD7vnMtg5OnJ06KKIGgVmqw==
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2937.namprd12.prod.outlook.com (2603:10b6:5:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 13:56:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 13:56:20 +0000
Date:   Thu, 25 Mar 2021 10:56:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Message-ID: <20210325135618.GZ2356281@nvidia.com>
References: <20210325113023.GT2356281@nvidia.com>
 <afad3159-9aa8-e052-3bef-d00dee1ba51e@shipmail.org>
 <20210325120103.GV2356281@nvidia.com>
 <a0d0ffd7-3c34-5002-f4fe-cb9d4ba0279e@amd.com>
 <20210325124206.GA599656@nvidia.com>
 <00f79bae-75c4-d694-8dc9-35ac21cd1006@amd.com>
 <20210325131756.GX2356281@nvidia.com>
 <13227fd0-6c41-992e-63e7-877f718c1577@amd.com>
 <20210325133347.GY2356281@nvidia.com>
 <8cf06da9-2a08-45c4-1339-bcc38fdd04df@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cf06da9-2a08-45c4-1339-bcc38fdd04df@amd.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:610:58::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR20CA0015.namprd20.prod.outlook.com (2603:10b6:610:58::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Thu, 25 Mar 2021 13:56:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPQTC-002Xjs-JX; Thu, 25 Mar 2021 10:56:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4627911-a466-4667-3de7-08d8ef95c478
X-MS-TrafficTypeDiagnostic: DM6PR12MB2937:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29379F72EF5D4A9BE106D5E9C2629@DM6PR12MB2937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AB3yrlyLTBjxOHbn9xLLFJnr+mzbPlC5nrFQeaGXGyLt/XJ+R34ONryUxjhgkojm6gTkOk4HrfTTiYQ+p1AEJuWnbWpONY0YaYN5hvlr5LcCzWX8EArSR6UGSGyljv9os4X76zaa5nuQgvP9NV78UMuFCT8vreGEC4AvcXo0DcVXtKdgI8wlkVnfwVOIFzHWIymrg4ElrOU/WM9FMw31Rpsg/LDqJ75F/KETH/KtR58MwcfppwMNQp4JpT+2zTC/CGERJd9D7T73Rv2PhCtmIAtFZsupaAKJaoofsCLUeNk9k4CbTdUIdM4CtzOzxc/xc6tRKwkYC/90McKw4EHm5YcUtyeB9VNPkmt+Q3+nuRMi0nHROPL/nextyRzugK/ZV1W6IBj2lOJ12VksTOVAYpZmLiBFmr99pB0oL6Cy07lVjYie+nWoL+ura7ghzt6s69vhlbP54skdV2Js7Fm2ofhe/tsI+mXKNfR/ZwjecMkDyUxn+oQak0brKtdUQnt5zFLIAJOYMzoFeq3A8Y0WLcn+2vBnanflwfEcQGGvF919NdzoY/r0emL1R9qy3+YRPI1UdP9vIuTVNiWyx1YVS/q1O7+bCFRawL5jBfwMMM3JK1SsxXkCIPtGV60PhfV/7lruLeWNoZMWOki0gfE9Y5kDyz242DZwqKixdzNyayeRKc6j4C3sWnew9SWFhKcx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(66556008)(1076003)(66946007)(186003)(66476007)(38100700001)(2906002)(426003)(4326008)(9746002)(83380400001)(6916009)(36756003)(26005)(9786002)(5660300002)(2616005)(54906003)(8676002)(33656002)(8936002)(86362001)(478600001)(316002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dXF3VnlOV0kzNjk0T0hkcEEzdXVlVGtaUnl0SGZGQkJsb3c3VUxIWml3V0RJ?=
 =?utf-8?B?Ukh3OUtSTE1PNFpDcHRDaENRd28wZXFQVjBaN0xVOHVzZCswUTdQQWgxWk5D?=
 =?utf-8?B?ZHdjcEN4REcrZ1E5Z1BKN0FlVlJ3K2JTblpjcFBCUDdUMTdycDNGb3JRb3Zj?=
 =?utf-8?B?eHFSS1RDaTNkRTVPanBjczFycjVZT2p1Uy9lWTBnRGtGT0UwMmFlVlN0ZWhw?=
 =?utf-8?B?SkExTTVrWnBHMGhJbjFteVI1L0t5bjlJQmp0UTErL3hFelVLd0twenhNZVZG?=
 =?utf-8?B?QXF3dVBJZjV5VUZvQ1ZBWjdpcFRlR3huTzFrKzBpcXBQTzFmcStVek1Td0Iv?=
 =?utf-8?B?MktIc3Zwb3ZhUkJ5UEt1bFZaSVhpWWFYUHk3L3gvdzZxYjFlTHY1eGZFZk04?=
 =?utf-8?B?TU5qaFpLUDltR2h0WitBNUNQRGJzYWF4MTZKMEtQc2haQWN0L0k5QTVMblpB?=
 =?utf-8?B?YUJCajVJaGZSRCtnN2pjTXZqbFBzQmZjRlp3U25DaWZoZ3BiOE1wS2ViQURl?=
 =?utf-8?B?WTlYZlJDcTQxd0ZkRTNuU0orZkQ4WHJaS3liRjRCQnZVazlsand6Q00vVFZi?=
 =?utf-8?B?OU5JQUd3bTZFK1hWM3YzT1YveUg2amxBbzdBZHNaSVU1RVdYOGtQUjBXaDVy?=
 =?utf-8?B?OVkwZUNpZmlLaU5zZUdHQUhQaEYzTTJVU2ZQNjNBSFpIemgrKzRFQVlaQzZx?=
 =?utf-8?B?T3BJaTlqNXZWRkVWaGlVZU9La0dpdTBVWXNIZEtnN0FObFRVK0tKOEVXdnFH?=
 =?utf-8?B?NGFld0NsWkNFWTZrUnlRMVk4blpYMmVnQXhWV09VZ01jUERMdkY1empFWnVX?=
 =?utf-8?B?L2hKcjVVSzFwZnVLUTg4U3RsOWJubFJ2WUNlc2hJMXduK0JZOS9teTY3eVdY?=
 =?utf-8?B?VVYva1NKOE41UDVDSERqdE9qYk1LT0lCSlRiQ1pFcU5mOVRKTG9oNDg2eTlo?=
 =?utf-8?B?bFluRUdVMmtuWWpQV0pFY2drMGJYZkJyMHljTnZRR0VIUFBScUlFcTVBRkpz?=
 =?utf-8?B?c3RkQUJGZ0lDNDh0MDJHc2hBR29uWlpmUDJCdlRhcGJFRmVSNzVJMzJGdDFX?=
 =?utf-8?B?K1ZRS1ZxZHdMU1B4OUJJOUkvWnd6cWxmNGYvM2hNTmQxbmtxdXVOZ291NnNX?=
 =?utf-8?B?RnN2NDFGVkw4M081OG9nU0ZZaEtZZWx2ckRyclZsMG1DSDF4NUMzSWhra2hV?=
 =?utf-8?B?WnZjUUNJbmcycm1sV21SNVVSMS9pTUdobUNxVkpMUW9TWHc0cmtHWndyYTQx?=
 =?utf-8?B?RVpCN3FUY0s0V2prZC9DVGZLWEtORENMVG81YWlmclo1YlNtUE9iYi9lQXdv?=
 =?utf-8?B?RDhhV2phNkV0VXhpbXl3SEljT0JFd3NTYzAweDhscXoxWkVOZTFqOWJ1NWt2?=
 =?utf-8?B?T1JST3c3c1lzV01hRERrSUNFcll3M1lXbXdoMVY5bGk2b09kSWNlTEN0VUhl?=
 =?utf-8?B?MWZLMlhKTEZQdUpRNjhsU1BRdGxrV3FTMVpCRHIzaXplT3l3R0Jndy9HTjVZ?=
 =?utf-8?B?YkU0SzRrR1VRbjBIVm55NE1oVDVHdDVxV0xhNWZZRDcrOXVHZlRlcm9TWTU3?=
 =?utf-8?B?NDc0UTYxYmlJcTZzd3EyMlZXWFhaKzhpWFNsa0xmNHFvSzREWWh3V1ZaZkd5?=
 =?utf-8?B?K21SdFhNY21vczV6Wll3aDV5M2tCZnNGajlEMU5vb0Yra3JFNll3Q2VyUUZ4?=
 =?utf-8?B?ejBSUFM2V0tFbmx3OVdUeTdRaWI2Z2QxM3lubkNmOFJzM1hyNnpNOFptWkpS?=
 =?utf-8?Q?L0MflCVX5eTa6ddUi9lbbhPu7H+1LrGUxAReBav?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4627911-a466-4667-3de7-08d8ef95c478
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 13:56:19.9334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdZPIaPUJrYkTJtdMCAFrdICFoHjobXqId8hrQQGTrkzTyn1sW3AmF5QdSdxEonL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2937
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 02:54:31PM +0100, Christian König wrote:

> > The goal is to optimize large page size usage in the page tables.
> > 
> > There are three critera that impact this:
> >   1) The possible CPU page table sizes
> >   2) The useful contiguity the device can create in its iomemory
> >   3) The VA's alignment, as this sets an upper bound on 1 and 2
> > 
> > If a device has 256k pages and the arch supports 2M and 4k then the VA
> > should align to somewhere between 4k and 256k. The ideal alignment
> > would be to optimize PTE usage when stuffing 256k blocks by fully
> > populating PTEs and depends on the arch's # of PTE's per page.
> 
> Ah! So you want to also avoid that we only halve populate a PTEs as well!
> That rather nifty.
> 
> But you don't need the device page size for this. Just looking at the size
> of the mapping should be enough.

Well, kind of, at a certain point we start to over-align things which
is a bit harmful too, it is best to cap it at what the device could
actually use, IMHO.

Keep in mind address space is not free, and 32 bit in particular needs
to be efficient.

Jason
