Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642EB3FF9AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 06:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhICEpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 00:45:20 -0400
Received: from mail-co1nam11on2078.outbound.protection.outlook.com ([40.107.220.78]:63189
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229561AbhICEpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 00:45:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsSg+lZ90SagLTfM3hzRasZ2fFtvW0ewW7kfzzkFiM84ZTwbUJLo4ICGA6wI9q5uYjCAivkd/ILqJnMcyQbA7UVhmmxPNSbl1rJBNMikPkHIenyFL7ICo5lu0Cww7vhEI86DMb8jfFQmDIA/bqFa5Cv89nYa2hf7vzArMGrGMny9Jbbc9ISgxjGc4sCQ6S1axBuyfNQx/kgNk9bcl/bxDuzJ2Mkqco8tVJnAzJi2iJSl1pqmKXMpPqg4NgLXc8BiVQTZC02giIML4o57z7UHWqT2QQ+PWDdsqu6+kT5KyL/hL5lUfRxM1sL+ZgkD58HRy+2oj7uhb+3rKSJdG7pFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvvOwLvdOdtfU+eXPvRpUMabvkYdTK4trY2Zs3A0qgs=;
 b=SW3yEPMKbdv3ttBUoxe6rCXBOmNTNk8l2y4u0vGQVIhyCF7DDOdiE7lc8cyEh/lNvuyYBRmG3prf3eVF3MuoDBrMOrfR5NEG9ObE22yA0xKfVx/ORiGLfsZlmAHCgtiMK+NRiWhbGfK3Eo+6q+XzuJyT0pXngCH8EMcoSjthLQ6/HNx1pwxc4pvYEFSNwfVG/hT8dOjEWYebooNNQGXw+O0ivoywyQ74cW8bAZGnMXhpF7+ak8vAZb/ETT1K+7rQbZ8kpPhxub26z00rxHBl7mI6tnshSl4DCL/5D4ysBfZm0N5YZej7/qgikWh5D8DNu3SYHpMYTkpiWm92U1N8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvvOwLvdOdtfU+eXPvRpUMabvkYdTK4trY2Zs3A0qgs=;
 b=2TSLI6hSzEC3aXkvN7l5xd0GqAvKm556DHShLXz83QowDScTL5rFgsb1KJ6GV9g0lD69KSCVSszt93uQbvds8j39/rNVtg7YBx9oQCuhAAVA2BlQ3d5sq8mKd/Z0RVGgCMMjUF/l8qgZ2OVwlRwYhN/CXEDpuf3GKWdzLrPYqO0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by BYAPR12MB4694.namprd12.prod.outlook.com (2603:10b6:a03:a5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Fri, 3 Sep
 2021 04:44:14 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::d835:2252:aefb:e3ea]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::d835:2252:aefb:e3ea%8]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 04:44:14 +0000
From:   Bharata B Rao <bharata@amd.com>
Subject: Re: [FIX PATCH 2/2] mm/page_alloc: Use accumulated load when building
 node fallback list
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, kamezawa.hiroyu@jp.fujitsu.com,
        mgorman@suse.de, Krupa.Ramakrishnan@amd.com,
        Sadagopan.Srinivasan@amd.com
References: <20210830121603.1081-1-bharata@amd.com>
 <20210830121603.1081-3-bharata@amd.com>
Message-ID: <0d67b3b7-cf2f-61f3-c67a-76e85e05a3ee@amd.com>
Date:   Fri, 3 Sep 2021 10:13:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210830121603.1081-3-bharata@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::18) To BY5PR12MB4289.namprd12.prod.outlook.com
 (2603:10b6:a03:204::14)
MIME-Version: 1.0
Received: from [172.31.33.28] (165.204.159.242) by PN2PR01CA0163.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend Transport; Fri, 3 Sep 2021 04:44:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 403a61b5-a9a0-4140-ae8c-08d96e957acd
X-MS-TrafficTypeDiagnostic: BYAPR12MB4694:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB46948447864B93B730BEB0D2B0CF9@BYAPR12MB4694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQI14jZL9NcNlbPjWTTWaj6tY+5Sc3+dSoJ4clHsNHxavrPHQByHWFTeRmkNBEMtuNL00WEfnAf1MYis0/ppmMVg1EkgNrsW8WjR5WqJTa7wJF9DsFFYXZDpfzl/xqFuMjcn6SMWEtWETHfpEGJXgEP358rRLf+n/cR4mhFf7h4fzGBepy68xIO5ESpOSbBJjyqSGyos0Mo09WCbWGjgRLTlpXjXH+JjWIA5LcVFURoKW+PAi6N6olUwezCmiKB5Zbr20eyazZuehX9RGSNNg1Tmhrjlkfy9KcWQ/Uovw1B0qoraIhba+fc/oIpkJWc/1CZcFzr5OsCyLEAxzlJSEAk85ZeIwfX1P1n3ohy5Y813N94ZRQEoXeq/9U3hb4cxnU45soZKaSE9OGbBvfOCYS91SZ3ct82O8NKemJNNiqsD1NMlqm0gFVn7qEOhKe9gBtsIOt3TDn1lrQvAjIWbDrEg+inAaVkcs8tcBk+vPN6izAy0QayIgLUHsu1Wj5i0d0r2qkIwnXgKCrqYyeHZrS9+dxr5sLDvzOcoMnmseMHf1bHa7SuMS0vXp/8Rv+K38WaSFFWnb4H9RJFaY3/utNtgM7le2Vsa5nSj7Uca2eLs0YEouiyUIVe2A0Gc28HfbvYymNqHbmFdPYA9MLZSInQcuy9YtCuqW1NdkE40DuCbY/FQe+7tXFhy7/FFkGqMJzjLjicMrKbD5FwXYrKC6oeDoGqijlot0mfbLRjYRLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(4326008)(2616005)(66946007)(86362001)(31686004)(5660300002)(31696002)(8676002)(16576012)(6486002)(8936002)(478600001)(66556008)(83380400001)(2906002)(316002)(53546011)(38100700002)(36756003)(66476007)(26005)(956004)(186003)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5ZTzVHdm1WN1RUTEV4NXJ1bmQxSXltdnlJSG94L2NxN29GSDZ2WUErblls?=
 =?utf-8?B?a3J6SGZZVEUvMExhQUhqNmE5Q3ZMeVpnVFZMTkh4enYzWE12VFYxRFE2UjZl?=
 =?utf-8?B?RjFRWk5uZzZueElPck5GVjVacUdTcXZ0RXJ3NmlWbHlxV3RLVDZxTHlMYUox?=
 =?utf-8?B?UVhwNytjTFZkSlJwL1grNjBFMnFVUHNNeU9ISjBna1k1SElQeDNuUGF2RDYw?=
 =?utf-8?B?Q09MSkpSckMyQnhXbWJsbys1RjRRWHgyWDVBNzNTRTViWGpKaU90SlpZZ2Js?=
 =?utf-8?B?cmR5QUw5QjdDK2IxQnpQSGJPdnBLT0JnVnI4S0h6cWl1ZVdrYjFXR2pDcjEv?=
 =?utf-8?B?Zk8yZWJ2WkRwK2ZoNFlXcjd4dnROa0pmWmlRQ1pDcVdUMFhoNXpFcDZtaFRN?=
 =?utf-8?B?bis2YUFyR0kra1lEcFpxYnltWlFjNlJ0RzhETkZlT2VZTVBVanZtY1phdTFJ?=
 =?utf-8?B?ZGVvajg0NnJuenQxSC8vb3JrM09FWHZ4bEsxeUdjUERFc1l4UXFob0t6WE12?=
 =?utf-8?B?cUVSeVozb0dJaTVHUFRiMXFxUCtPZDVuRVBjTFNpaEV2MWhUY053WlBtOEs1?=
 =?utf-8?B?cmg3dTZvSGoweGEramhTVDJ2ZlViMVRxRndFSk11dmhPOFBJTVJqWmN5blBM?=
 =?utf-8?B?RkNrN0ZMUVhidFFnMklNaDNrYkQ0ejF6Q29RVmhVWUtUUzdmc1B2UW8zK25s?=
 =?utf-8?B?Qkp6UzBuZVZJYS9oSGJPUWVHMStQWDkzTDBSR0pkaFdEYmFVTEFSVEIwQkRp?=
 =?utf-8?B?NGcya05JTmZkUXVlQ2xOS2ZzZmV0WUMvRlByelFHSnN5VWpTWENZTWl3dnEx?=
 =?utf-8?B?SGRKSWJNa0w3M0pkVk0wcytrbFdFdHpLN2k5TEVGUTNtaWVUWm9tWnN6dGhx?=
 =?utf-8?B?QUtVZ0VzNmJUMDd1bUtuNG9UVnhYcHp3akpCS0hJUFlpcGk5ckF2dytWOFBY?=
 =?utf-8?B?VUhSa0grTUlzK3JNU0d3Nzh5eVFHL3F5a21TZWtVZkF0SnJGdEFpWWlqcU4x?=
 =?utf-8?B?N1oxWW5HcDhaZmpSU2lLL05uWHV0L2kxTWgxREtPd0ZvaFZ4bVJEbGZ5Nzkv?=
 =?utf-8?B?V1NqcjJOYWtOdmUwYkNYYSs3VnVRRy9scUZIZ3o5cjlGRzViakE2UnlwaHpL?=
 =?utf-8?B?bWVtTy9YOUlOZ21kZ05FekJ3cUVoUFVoZS9ZMTYyaHFTbDNETE40OXlVdjZw?=
 =?utf-8?B?NHlXL3l2dFlxQUZGYnhtZWcybjVUYVpnK1pwSmZzVmFNTTVFOVZDZnlTVTZH?=
 =?utf-8?B?a1VkbGNGNHNuS1RDWHNjaVhzT3grNFZKU3pLVjZpcVVHeWNRN0tuQ3BaVmdX?=
 =?utf-8?B?NnQ3c0pMVWdiS1lCdndPblBMVDdpUkkvVnhVZlJKS1Z4QnAxT1U2TVVpbjNo?=
 =?utf-8?B?UTdsNGI3NXY4RUlNcklVZUFjR1EyZTJyWnZVR29YcXZRV3BRYTJOVHNYajVD?=
 =?utf-8?B?QmZzZWR6VjNkTDkyNFFDVWY0MXo5WGhwOElqZzY0Yk51aEVwMHNiQ2lvVStj?=
 =?utf-8?B?MlVRSTZTZklvRE9EMlc0bHpqL3ZoemhZbUptdThXcGFGUkpaMzFYd0tZUWtl?=
 =?utf-8?B?KzJLUGpOckw1WVkxS0tlN1ZibHdQM0YwcHBTMmZna1FoWnZrZmhOWGdTQ1Z4?=
 =?utf-8?B?aTcwTDVjVnRkbk0zdlJ3ejZFaUtWSVNDQmdoWjNQZWJ3T3hOejhhRVB3NU1y?=
 =?utf-8?B?QjRYaVRIOW5yWC9JOUdMVmtyck96YTJtU1gwQmNSeitIYm9WK0puaXVPamNu?=
 =?utf-8?Q?+iQ3O6smLUPhU67o2TtRSP7WyyStfHToTo+hRLE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403a61b5-a9a0-4140-ae8c-08d96e957acd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 04:44:14.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOQ+w8BXH3UEHdTPmXAIx0eeYC9zz4U6wSPgvOWOeoKBl7afPfhtz1St8lo07otLzYzSkqMN5Mszp/iL845AHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4694
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/30/2021 5:46 PM, Bharata B Rao wrote:
> From: Krupa Ramakrishnan <krupa.ramakrishnan@amd.com>
> 
> In build_zonelists(), when the fallback list is built for the nodes,
> the node load gets reinitialized during each iteration. This results
> in nodes with same distances occupying the same slot in different
> node fallback lists rather than appearing in the intended round-
> robin manner. This results in one node getting picked for allocation
> more compared to other nodes with the same distance.
> 
> As an example, consider a 4 node system with the following distance
> matrix.
> 
> Node 0  1  2  3
> ----------------
> 0    10 12 32 32
> 1    12 10 32 32
> 2    32 32 10 12
> 3    32 32 12 10
> 
> For this case, the node fallback list gets built like this:
> 
> Node	Fallback list
> ---------------------
> 0	0 1 2 3
> 1	1 0 3 2
> 2	2 3 0 1
> 3	3 2 0 1 <-- Unexpected fallback order

FWIW, for a dual-socket 8 node system with the following distance matrix,

node   0   1   2   3   4   5   6   7
  0:  10  12  12  12  32  32  32  32
  1:  12  10  12  12  32  32  32  32
  2:  12  12  10  12  32  32  32  32
  3:  12  12  12  10  32  32  32  32
  4:  32  32  32  32  10  12  12  12
  5:  32  32  32  32  12  10  12  12
  6:  32  32  32  32  12  12  10  12
  7:  32  32  32  32  12  12  12  10

the fallback list looks like this:

Before
=======
Fallback order for Node 0: 0 1 2 3 4 5 6 7
Fallback order for Node 1: 1 2 3 0 5 6 7 4
Fallback order for Node 2: 2 3 0 1 6 7 4 5
Fallback order for Node 3: 3 0 1 2 7 4 5 6
Fallback order for Node 4: 4 5 6 7 0 1 2 3
Fallback order for Node 5: 5 6 7 4 0 1 2 3
Fallback order for Node 6: 6 7 4 5 0 1 2 3
Fallback order for Node 7: 7 4 5 6 0 1 2 3

After the fix
==============
Fallback order for Node 0: 0 1 2 3 4 5 6 7
Fallback order for Node 1: 1 2 3 0 5 6 7 4
Fallback order for Node 2: 2 3 0 1 6 7 4 5
Fallback order for Node 3: 3 0 1 2 7 4 5 6
Fallback order for Node 4: 4 5 6 7 0 1 2 3
Fallback order for Node 5: 5 6 7 4 1 2 3 0
Fallback order for Node 6: 6 7 4 5 2 3 0 1
Fallback order for Node 7: 7 4 5 6 3 0 1 2

So the problem becomes more pronounced for bigger NUMA systems.

Regards,
Bharata.
