Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDEB45D05B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 23:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352092AbhKXWtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 17:49:15 -0500
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:7137
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245389AbhKXWtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 17:49:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSYYMcXcj4s6Q6+H2bUfqzsEKMRCtaOAEHnsp6W4lx4nkeJLJYLpYpbhp8lG1YWqSTRwIxMDos7IKlTCvEd+QPi437SRk5+MlwzSKUYDoeDqVc9jprvisW+2v/FFB2PalQnPE0pScY3HZs+owEA5AyNqh6gSYZzsVYV9h5OJKJdrgLh2gUiGspt9dwUhtKXzeDS7yT9P1DZNaxAwOX6TNrTywThubg0L3TECU1AhjXtjrsWYBg6yVxRfizzmuUeXydnqLhXOqoiwnzWs/jo/FYVlzgXnrjcj8fKdnlmIJRwHSMgGlaGjpCYl0oL7F+d2qwMJu93nxFmgCGzwZK0ciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNUQn+/4wiHnKx+/eSBJBEUuE1HhDAQ/KXnoi4rc1lo=;
 b=n57jWkjiHZJahRdOk3L63Eg1e3ATtUGheDZOhJVmzEfX+eAk/nyCdw4BGNCcZ9YiOghOu+RPhnPvkIiDQV4QmDIHjkANpYXI1LKTsWImcnuHJJPOQ1b3DbFkdRrp6BH2OJssuqpb2LqHJg3gqUcNDQsxMuLpvlnLsolL8mBho/FnRMflGxaQJaLZ07py4c5zr2tR5b6bs9zGqMv8W11bz1jTBWG24EZtdY7Ej4gNEXky7V7i5TZfhQJD/BQN1v1WEnV0h++mVSJ/UzSDwE/UtVnL9df1tguWNBm8wvK01QxDP1l4ZroXdyY1ORFwU1nuafaJsIshcn+cLLgW4CgLNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNUQn+/4wiHnKx+/eSBJBEUuE1HhDAQ/KXnoi4rc1lo=;
 b=eLxdjDrJc+jLd1V61wxI+Pd4ZGs9bKRxYM9T1Th4SQKWEPWJoE1BDkUEPBaNeaWzSIJpwZNbMzjPa+5CkG+7PBTXc7lBXohype/FIB+KsCzUxznfoTj/aCD7NrDLIR2bvGORvvtmtvnrCUqnVeDZQrDFyR+pyGCHnZQHtSX8reJjnnkIwAiwAOALb7qx7uXNJg+b6h8arJizi5r6XtmXgglHA6sockMeYjUwYYs1nUs5QSeXMGe2ztcXjW1vEVd4MD2a45FNEHVCZvdGsR91cxG52nnNpIeBuoqpeWWBHDaQ+vtMxCiLJm+ZghyPeDGprFn02b2CebVnP7drmjuHXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2837.namprd12.prod.outlook.com (2603:10b6:a03:68::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 22:46:01 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%3]) with mapi id 15.20.4713.019; Wed, 24 Nov 2021
 22:46:01 +0000
Message-ID: <348f3a1f-c7d3-c21f-419d-7acd2e5290b6@nvidia.com>
Date:   Wed, 24 Nov 2021 14:45:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] mm: Use BUG_ON instead of if condition followed by BUG
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     cgel.zte@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211124030849.34998-1-chi.minghao@zte.com.cn>
 <YZ483gwnwTysPt0G@casper.infradead.org>
 <20211124142751.e48cdcc3aea9e0ef899f4347@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20211124142751.e48cdcc3aea9e0ef899f4347@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.51.66] (216.228.112.21) by BYAPR07CA0099.namprd07.prod.outlook.com (2603:10b6:a03:12b::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Wed, 24 Nov 2021 22:46:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aa65abf-7185-4913-2a6b-08d9af9c305c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2837:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2837523315DB398AA80CA5EFA8619@BYAPR12MB2837.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EslxtS+sMKOY4kkvt3N8kxXjMpNuYESHPHy4tkeaEBJqobjrCwU/cKK0q2oklyVVqhV3tyHnSBejmrAkPlplJj/D3XMRa+cTorI7CoQN4MaVK0zEh6FaAmbyHkUG880gTF85tmSfo+hSL5mwGmlFwXQlvHsnebFaaIPrB8iPy7QdS08eFhK81WPiWproTRyGVNtnT4a+ATyXDeuSJ7ne4RHtSvHI4wAzBGsjY9OAUgfcMjx9UijB5TpggXctsmse+TUSMAkoATF0Y7nLIB/6HrMkc80IT7lSKYUH+OXc9Jdy3SP2lPOcpJfQLs78nGpzBvygGPv+GH2kpQl9Z3591a2iaHrUOIWWzMNvRlk1zSWhk1L6yQHPK3yqAuA6LlJz5Edof2E3il81QohBP+MYao+XONWORtm6OtLyrBtn2BQ0a+GfHPp29n1vsfVz+eW4iuTc4tiPFNcQ7K+B16UP+jPvGvDxYmXvbM2jCkyy7YvqFNWbeKFjDeRsyGALNga73XnVIWHPGpsGns0Kc5x2PWgdRi20Nr1djEOFyS7MTdl+e/DasOV0MJvboOGZc9jXRoIVSovwIdM4WAGhoyL/U+JxyzH8jgHiaLeaIHo4HM2wR6eTC5ET34TxYbxWbGvZTD8hUesANToUEamdP0kBodvGHARnjugTJ3gPtXq32u+RDpaWhiXbPYcDkKVOmf3AfRJDLjX2cRfiVqpNXATBM7Kl+Z1HS7yufhR+2zq1jF5XZFCYPegr8dY36HIg7hfJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(66556008)(66946007)(16576012)(956004)(31686004)(508600001)(83380400001)(2616005)(31696002)(316002)(8676002)(5660300002)(26005)(36756003)(86362001)(53546011)(8936002)(2906002)(4326008)(54906003)(110136005)(66476007)(186003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzZlbGR4SVE0SHhzZHVuWnBMU1l2Sm4yalV1VnN0aW5UMkZRamlMUmJ5L1E4?=
 =?utf-8?B?c3cxU3o0c1N4YXM4LzhIcDV0OXlneHBhUmw4UHpCOXR6VWltWURmWHhsSGtr?=
 =?utf-8?B?UGpNYk1DZnhuZndHTURnYVRMWVBldlNYMURyV3dIYXo4d3JUZ2pQVU9TQmcr?=
 =?utf-8?B?eGVSVDJYWVV2a1JjOHYrMnM3S3dHQkMxQnp0UzBkZFZydzVLZXFuU2tVQ09w?=
 =?utf-8?B?eFV2MmM5WTBFVDBPQnpuajYzK1J1NEQydjl6a1U4VEl2aTRnL1lMRjZ6TkRF?=
 =?utf-8?B?bU9KMWZBQVIyZjh4aWtPelAyZmlEelFjUVV5a0RrVUdFN0lDVUdrZWpPZDBJ?=
 =?utf-8?B?dzNiYktiUkZ0d2RBVENCVXBxZTd3SEtpY3dSa2tkUEJ2M292bVRUZDFGa21U?=
 =?utf-8?B?N3dGVjVmeW05Qm1yaDE1MmNMdHhWRUJMS0FYbVlSajU0eVlnYWlZM0dmK3Ny?=
 =?utf-8?B?M3ZWUnRIbjlTOTExUGI4ZVlzdmdUVHVvZi9weGlzUlhlM1ZnQnRtQW5Uc2sr?=
 =?utf-8?B?NEJCYmdwcUJCYkcxUEN5UkgxS0Y5SnlBbzdqb1dkRkRQVnpyeEF5Z0dEUzFT?=
 =?utf-8?B?bTFva1VLL3ZYTGVMRFRDSmJ3bWd4eVVrb0hsRWd3VU1tN3NzNm10UUgwNjRZ?=
 =?utf-8?B?am1vVWhmV2U1Z3FrN0RTL01NOWZocWppVENaMlVSeTc1VmlhT0pscWwyTnVn?=
 =?utf-8?B?dzlYc0txTWlUZURiUWN2QmpzUUJxNGFRMTlWbU4wSmVuVzFFcTU2R1E3VmJL?=
 =?utf-8?B?dS9yT0p4UXZpaGkxWGRpdFRWZmZkOVk3Tk4xdmJaY3pxbDJwL3VsWG0vQzZl?=
 =?utf-8?B?TTVzdVBSbmRnRHo4VENTVitYcTVPNUFUVlRMU2JqMEVSVDVDa1JZN3JyQWps?=
 =?utf-8?B?bnZuNWVockp4ZHhKNDFVMnc4YkZWTVhmTk5MQTVadzVXWHlmNkxUZXpBKzBJ?=
 =?utf-8?B?N1BBek5Gb1Eyb0poTWUzYXhySGF0ZStrVkViaEJSSit6dU9PUFNFMUJyUitH?=
 =?utf-8?B?ODU0NWwxTFFCYmZDUzRqeFE0QW8xYjFxZDBmb2doN0h1MktOWDlyZWw2NC9l?=
 =?utf-8?B?ZmZiNmdOeWovcC9zUEJrNVNYcWhxN25GVlR1WXBUSUZCZ3JwMVdpVWdmY1JB?=
 =?utf-8?B?dnR2TW90eEkzeUJKRTF2K1RMSTFnajZEL3ZlczM3aWkrRkYyNHc3b051UVc1?=
 =?utf-8?B?QmxoVk53YVlrNnB2OHUvUjJ1aG1YbFk3c1lOWDF1c2ZFcGxWM0l1WEZMczds?=
 =?utf-8?B?US8vTnZjS1dsRnhPZGdXWi9HcEVpODA4bEM4SEd0R0ZLbU1tWHpoVFNrek1I?=
 =?utf-8?B?RmJXamloT0JsajdsVFJGQ1o0VmxGekNsT1ZzWmNLVmlFTndjOEl6K0VFQWw4?=
 =?utf-8?B?SWtLTG9KdzVEVG82dllqK1ZFbG1DbUpkRThKYzdFSitKcTZpa3ZFWlROS2pN?=
 =?utf-8?B?VmZzTFM0ZzA4aFIyM0w4Q3hTTjBxbVRRcEVGVHk2aGdHb0ZmcHYrK2NqNnRi?=
 =?utf-8?B?Z1JGL093U3hJbFlCZGVXTkdTazFuRjJLMkZxWldva0xueW00aTFkME50THJT?=
 =?utf-8?B?WFRPTStwZGVJY0xiRFhqR3NuaGxlRzBoam1YLzNSbVBhOFI4ODNkTkRoOWQw?=
 =?utf-8?B?QXlrd2NTRWRJbDJaQWxJV3RMbFdaOWdzMENwdWZRUS95Zm02ZFVJYThYNVI5?=
 =?utf-8?B?K3Q1QjFVZHc1MFZxQzlMT1NOdzV4V3RkWE5uTkhtL2FWOUE2Qi9SNVBWWjZK?=
 =?utf-8?B?Z1RBVFNYd0RlRGkybGdacDBsdS95US80djdyY0JPT016MnF2MHl1Z0VlSXJP?=
 =?utf-8?B?dFR1cnZpREtSemVvdWJBWjRPaVlhL3NENVVsRHgrVHF3TWFaUUsvL3M2bjNZ?=
 =?utf-8?B?TW1XRUwxb3FLSERzTWU1WjlBQ1g4d3VHWHcxMUw3UzBRS05DQm05NUZQaFBN?=
 =?utf-8?B?RlRXNGJDVFpPTmhtZVQzMEc4dGxLWHVnd1NUeWRJZ21mbmpYOWRMa1FPSVNE?=
 =?utf-8?B?ZlJqV2w2UU9zV0lHUkJTOFFNUE5lT1N2alZMY1RXS0xOMm05eDdhNERObHA1?=
 =?utf-8?B?ZEMyUGN3Qk5FRWxIa2ZHWDBJR1FtSC9nLzdOWEhMcWY2SWFYNzNUa0tlSFFH?=
 =?utf-8?B?ZXFFZzdjK3hKN3JrR0VqY0pKWnVEUlVMZEtOSVo3V1Y5WkxySHcxRXNNNEYv?=
 =?utf-8?Q?ldUdoyK2uwYbq+r6PMqzDJU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa65abf-7185-4913-2a6b-08d9af9c305c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 22:46:01.2075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXyC7TR43kohoe3f70Ej+moOF8DU0uZ8KbJlKhIfRhWja16pec79kNaSkG11YdFad82z2CH1CrSCN1f1KCluRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2837
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/21 14:27, Andrew Morton wrote:
> On Wed, 24 Nov 2021 13:23:42 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> 
>> On Wed, Nov 24, 2021 at 03:08:49AM +0000, cgel.zte@gmail.com wrote:
>>> From: chiminghao <chi.minghao@zte.com.cn>
>>>
>>> Fix the following coccinelle report:
>>> ./mm/memory_hotplug.c:2210:2-5:
>>> WARNING  Use BUG_ON instead of if condition followed by BUG.
>>
>> What coccinelle script is reporting this?
>>
>>> -	if (try_remove_memory(start, size))
>>> -		BUG();
>>> +	BUG_ON(try_remove_memory(start, size));
>>
>> I really, really, really do not like this.  For functions with
>> side-effects, this is bad style.  If it's a pure predicate, then
>> sure, but this is bad.
> 
> I don't like it either.  Yes, BUG() is special but it's such dangerous
> practice.  I'd vote to change coccinelle.
> 

Definitely! Or at least use a safer pattern/habit, with just a passive
variable in the BUG_ON() call, approximately like this:

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 852041f6be41..48bd5ff341e7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2201,13 +2201,12 @@ static int __ref try_remove_memory(u64 start, u64 size)
*/
void __remove_memory(u64 start, u64 size)
{
-
+       int ret = try_remove_memory(start, size);
/*
* trigger BUG() if some memory is not offlined prior to calling this
* function
*/
-       if (try_remove_memory(start, size))
-               BUG();
+       BUG_ON(ret);
}

/*

...and by the way, while going to type that, I immediately stumbled upon
another pre-existing case of this sort of thing, in try_remove_memory(),
which does this:

static int __ref try_remove_memory(u64 start, u64 size)
{
	struct vmem_altmap mhp_altmap = {};
	struct vmem_altmap *altmap = NULL;
	unsigned long nr_vmemmap_pages;
	int rc = 0, nid = NUMA_NO_NODE;

	BUG_ON(check_hotplug_memory_range(start, size));

...


thanks,
-- 
John Hubbard
NVIDIA
