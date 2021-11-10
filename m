Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834FD44C135
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhKJMci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:32:38 -0500
Received: from mail-co1nam11on2085.outbound.protection.outlook.com ([40.107.220.85]:53728
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231131AbhKJMcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:32:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHFrBDjVhogVf4AaLQPuRFWljcIXgG6lOonl3Y22B/U7EynA8GDFnefFI9Zw+SgKx3khRxdd3AYdjzMRU+3FoZ5/bvht1bvb3Px3JPW30CWCN5sTtuqk0r8Qo1ouXcCvJMN6NzPR4UBiSdtILkQlsqo5qqA3zdfA/l6px9+qwxgP02YNW02IYPfD3ndy55wy+eEhW88hAB4FSO9VSfap9bJAzqcM5/y6MA3EOZbwCba/PnjXoNvdf7fVeofqQD5h3dfbxH3SEAdFEcitWTy/VMc2mPLmTD82GCZf6Oh/Pv+3pO/AG0QsQNs19usk7FZgROUYpoOEGFMYz/GkaXjiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6UUwyQoBRZv9DF0V8sh1IKSskp5lxvIPuRepbxlUXo=;
 b=MVeAT/t8eRanANGQtrlo4F9EawmEaHaGsHr2ZGbPFAnvMgXAVVX4qjY24S0ySesqWs2fJ5MMF5htPDk63PQOdDqezF2ckuiGznKQwQLMfkafSHQ0nFpj8PHpJsxQloRrj8+nmVjFBaJz2GfqlYPL9p9UVpz4tWaDg5O8rt5WPtTWtcAIDehOgm36qZOqoJ210hu/Knghv8HtXiZ0/ZKQk5z6dKxS87Og8dGZD0DZoRFGJb0xR1PpuE4A4ZI/nMW8uxLIcaZzCGq3YYSGvqt/uu6J6T8S7NM3PHiI+svafaC7Inj9BGAYtSK6sLTsi/6gVnpWCKWfG3sfPV9GqU2+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6UUwyQoBRZv9DF0V8sh1IKSskp5lxvIPuRepbxlUXo=;
 b=mnbBq5nKTwaQODEb+hogwBA/gBOZ/Mp1YOx3J3azEcgbD4tVLxbeXLjvpdTTDucBk46EE5Kp5g60IzZA35OoH8savynzmfgYvqnwGvzb4hnR+A9cgCuByrcGjjttZcKbgEy7CuwmvOz2x1oeW/O6fNn/5sW1MSPscxgWuhFJdtfIMcY4qvgW0mG60Cs4A7EUPHBS787Vfv4G/31/7RXE/DLOMCBbuVyhR/exjm59wcLL5v8dzIHccZDlNCUe5vPK1sL8eSeQ6bES4Nuof5sSsMogajp8L9ghl7/yny3HCkK+a39/R5TBTuV6IjFWYZOKvnziCNrdZJR05dJeRBMfLw==
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 12:29:47 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 12:29:47 +0000
Date:   Wed, 10 Nov 2021 08:29:45 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com
Subject: Re: [PATCH v3 02/15] mm: introduce is_huge_pmd() helper
Message-ID: <20211110122945.GO1740502@nvidia.com>
References: <20211110084057.27676-1-zhengqi.arch@bytedance.com>
 <20211110084057.27676-3-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110084057.27676-3-zhengqi.arch@bytedance.com>
X-ClientProxiedBy: YT3PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT3PR01CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 12:29:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mkmjZ-007xPr-E9; Wed, 10 Nov 2021 08:29:45 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1c7782a-63fd-4ab0-e947-08d9a445c840
X-MS-TrafficTypeDiagnostic: BL1PR12MB5080:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5080DB80FE718877D12A7262C2939@BL1PR12MB5080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtkyRISDFIxRiigozgwqn7q+t3dpXn/kDimFMLJSsN1szCVq8ixelgW4MnCrKDUrS8pVOr5Du5GZbgjX9yT0E5qwydYsUbMszxge0jLO4wphDzslM0Xh0zee9GeSw20tRVhIPxW4TaqA+fuw9zbyP83f1bDt4gUny9ZKtJwXR76qv+a+4O0HWjwWPHfHVJcJ+Yyqcm3K4hqkG/1GrA+H7mPAECSxBKErR6kR/XHEowpcdSEz8kP2YH++z+kcq48x/mCFMIKF6LSKIiGHz569tk/T0QdumfMOcloNZTcZElK35Nar8jf1bcm976pvtZbL4+ZOKjYUkU3CFD0HZ+gVRATnsKC3abEa7s0U3VF4ZjozKoMs1kouguRBYRBGBHpeIq7Cobz7d+VIOEuoGSh8TL0qWAVwctVV/hFMf1T5Cdj9UA7rcffqjVw1dlGxLRfBW7CxkiIHZm7zEe4ZQkHiOTF1brzcG9LJ5HgNVhTvhMdJR+VPBeBfD+FccklQ8UhXPgxAuY7FQCMDHRoybGkYOBZS9FrlNii4UzPAiFAHJD2RjOcFpMOkO7HcYyeSK+SinNz3TBmBIMl7xyvnhQOxNgzEmqm2ffw7FEkzVamyqFmyYqE6zcn0y1ztYfCMgtQfHGWOlNjNQws1phcIjuJjaqp7/JbbNMP3ZuCHRsEpcA21dC5KsEiqRZuhT2lewDlGpEt79LO6Uot/x4sMEhY6vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(8676002)(4744005)(66946007)(33656002)(4326008)(426003)(66476007)(1076003)(66556008)(508600001)(86362001)(2616005)(9746002)(186003)(26005)(36756003)(7416002)(6916009)(2906002)(5660300002)(9786002)(38100700002)(8936002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h1whQRMrHnAVdKwdVQa+otSahyS84TjKLeXJghtsPGealOcRpD9VuQBIsH7C?=
 =?us-ascii?Q?OcEEFTbbLN+49zew6JBKC4QumoOh530GRW65ZUu/5gLsEuhkMjTtENx73VP/?=
 =?us-ascii?Q?XsbiKyu3K0JJvEGe1u35DQcKJR22Itf1xRzzP9lVUST7pi9eazR0LcMVLudl?=
 =?us-ascii?Q?XoytCnbNyV7b3maRqX7yd/UaGxVvHxGD0FmeOJNvoSOPP+xyb106PGL4IQLj?=
 =?us-ascii?Q?zrCE2iQiqpg2DgXl70intBE9qdRfkKKX9rV4mjjwWkNsXoonFzsRhd6Kmg9O?=
 =?us-ascii?Q?ziWoc5Vb7fOR9l290NPcMrSgvllNBqNI4HcUrDSez97PqoZQ5joOHHMNNoD+?=
 =?us-ascii?Q?F2cAw249ivcrhFVSMzIXcvv3KidsINkqexe8rcGDF7l92220j9kbq2DHpoqO?=
 =?us-ascii?Q?ADlHAObCz4+Zud6dGgOyxKFf4lascXaigqHvY2RQ0YtZLcxnti2q1witlfNF?=
 =?us-ascii?Q?QKtK6KMyGF5SVQeVHhYRn7B4fPfzCDx9sfhFMWbMsKXmkSghOOqXTovSENwk?=
 =?us-ascii?Q?Unfv6PujWQCtJHBew4FOTk8XHSoBTnewEFzLJmzLjaIsD2Io9g6Pbv3hg7HB?=
 =?us-ascii?Q?mDoV3leJp7lx6AFVFfFqBFe4egqCe1UErIjOuKJAXiLEjQ6evitBw8hzORtv?=
 =?us-ascii?Q?rcS3y9rJ0vM0JDqqNFj64D6YZy9r7Ap11eYTr4PJKqkIMjmzipgxgISognfP?=
 =?us-ascii?Q?c0RZIn90HLSCCf5g2xN0WukF0XIC25paLoEhP7XQMNApv/yVYq8B9NouskjZ?=
 =?us-ascii?Q?O9Nr7QpbFAggtiX/q8oFJeOt9gt/5Xv290SVgDhttJiEF9SBmY85H9UfceJe?=
 =?us-ascii?Q?s7XbmHq3hyVve6vohmSmt2y1yovczAAfCFOSMFicThPwGxu1V4aEZ99DOh6u?=
 =?us-ascii?Q?N+U3B76CjPAe1IxfJZd/nOWVGb5j7Tf2PP9t1j9oi0Gv/xNphnguonQmET+1?=
 =?us-ascii?Q?0o/AMHt3xmqjOVzQ9Rtoye0zFClTwPg3ef2KjzJSDsxgLNr8jVu0JGdr8s/e?=
 =?us-ascii?Q?lJnIXB114DQCNSfrvWMRt8eoJ42FKDPCrcCHH7njJ4O4lroktt6jdkMoT8Bz?=
 =?us-ascii?Q?+Vc0Fa+YGsuL2vxLMGNxEykcIPnyUIlpvZtiHJpdA+PERYqGT87SNKVOk4ue?=
 =?us-ascii?Q?kyvXIbjWJo52LQkhoYSe5eY7umtAWrUinu0qSnm+IsEXkb6g6/BFpuflc8T7?=
 =?us-ascii?Q?TWLotz6CZQ3d5A/XkEXS40vQqP9Ak86cafpf0BD29d4gbV1VwCwI21o9G74D?=
 =?us-ascii?Q?VHsdYe7xzlYNDpbNvQw6FhvEedqwgox7aaC5TIj7NY6pEhfzASCYb/hcQgRh?=
 =?us-ascii?Q?cqZfOeuxW5MHd6QFM8zC7cg7ObyL60OHUsoCUMAC8JN6bMx8gA3dUfSgFQ/U?=
 =?us-ascii?Q?SwsIW/5wrfRTE1RKh9H3nlO8Oq5B9W/rIYfxj3dTtK22SYUMkAxYOFxAF6+u?=
 =?us-ascii?Q?mJOgzn3sQjM2yGRVBG/oyhjBJOgjP6eMpn6KpmalIYpyuUPyEm/5g4iye2Lk?=
 =?us-ascii?Q?lm5paBigjTVzYKItraiZEGlqg6m64RVDJQba7tDthaRbSxoDWQQRIovHGYoB?=
 =?us-ascii?Q?NCSGqgr8pRcdr3ozaz4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c7782a-63fd-4ab0-e947-08d9a445c840
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 12:29:47.1520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6wSyW2DbVn23kcSMDkH+vSSzTpgJNRYXw0jkh8jIRMTd7ABDqe69+bAh7QnFYEP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 04:40:44PM +0800, Qi Zheng wrote:
> Currently we have some times the following judgments repeated in the
> code:
> 
> 	is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)
> 
> which is to determine whether the *pmd is a huge pmd, so introduce
> is_huge_pmd() helper to deduplicate them.

Isn't this pmd_leaf() ?

Jason
