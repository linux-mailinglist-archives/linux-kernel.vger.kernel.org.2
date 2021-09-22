Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAD841416E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhIVGBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:01:40 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:14752
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231908AbhIVGBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:01:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5FQ5O3hx/CNw3XNboEV7LGAg7P01djEQyx072Du87smnQr9Yjzj8wXrhVZ+Yqt35mHx3kGy+Ccl1mW3ZUWa16rY8i92p1vxwRZbIy8r9QSJmUqbemok/iK1g+Qe4XgrJzFaShZ2JlOKxrufSHaRdMWVZYfMvauJWxdy71WynvhhRKLJjYdNA7IV5Ld5QmWDLqhMelTTGyw035GOS65AXOmbFRU7ixckqRQ4QZpShLwaxd2bGCgrhbExJxk0xPDCyv19bwIZ2FEm2/IJnu0Gj+eQnKQ74zy9xG0ctn7LSM6lHytd02vCbBhApZYAmuiK1a2GqjWeoL9tUEztYIVQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YmCUVtsMXDjA9HRutSBSA/03Asp2JPUW3+SkgvZgMZs=;
 b=QLxkO3G3/6RtzCKzm0DSNzqmRmosOnOq0EcBzH50k3WvC91Zjw6AgbejVTogINW/kv4FMAhkXpaMhumbmAEimPoP/oC9jGtoTx5WRlwJfmvywpoE0wJJdjN3OT+y6rQnJmmG5Suaf/D2829WjEi7Cth+9GNXWnLvN7nBua/CqCaYST8mtJlYmqJNEA7cO+Y/dLNlbvChVsZl7kKSVHKFp2cQWBX6T6CnrzhF0JF3Z6FG8kmRCEmkRs5uAVFkXKy+a6mcEhE5sl+0GOr2axv+sM8gEcMf4u4V9E/ENdUNi7LtGx8u3awlSQV6Ww1vhaguE5h6hxXcGXvnRd3WPF6TjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmCUVtsMXDjA9HRutSBSA/03Asp2JPUW3+SkgvZgMZs=;
 b=Pn3wWBvl6f5Qr/sR1UKSykOKF2GOky/sqML4BstryAFcaYzmyi95BwOsX/63TfmU/DOcXY8Wuv5ukHCcI6C/3DIoCUoXOvgT8BbVai6AYa8fwjmgJ5N92r4KIfJRqttgvcraOgI57lNPTj8vFKWusIC2tBMjtAYIrRidQMp5MDuLWUbVL7dEXn6m5+drTVmmMsLWBGxLRN6pJkINCEyWyPFIPYiC43zrsJWf7VWpFjS3rmHPLjzGp8n9rD0n2AABu509iVVrnJXBU1JpFpmOhBkP1XqzF+Z3Zw5JsKjfIasA1yBZrqTYKDwbKItSdiPsKvsTs5OMUV5Bkw3InWhTpQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2792.namprd12.prod.outlook.com (2603:10b6:a03:65::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 06:00:06 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 06:00:06 +0000
Message-ID: <ad62ee8c-c5c1-e02c-9225-3883f03aa0e1@nvidia.com>
Date:   Tue, 21 Sep 2021 23:00:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 1/1] mm/migrate: de-duplicate migrate_reason strings
Content-Language: en-US
To:     Weizhao Ouyang <o451686892@gmail.com>
Cc:     akpm@linux-foundation.org, almasrymina@google.com,
        dave.hansen@linux.intel.com, khandual@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        minchan@kernel.org, osalvador@suse.de, pasha.tatashin@soleen.com,
        weixugc@google.com, willy@infradead.org,
        yang.shi@linux.alibaba.com, ying.huang@intel.com, ziy@nvidia.com
References: <20210922041755.141817-1-jhubbard@nvidia.com>
 <20210922041755.141817-2-jhubbard@nvidia.com>
 <90e7cefd-5ca0-f284-8c96-743e0f5ef8f4@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <90e7cefd-5ca0-f284-8c96-743e0f5ef8f4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::36) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.92.177] (216.228.112.22) by BY5PR17CA0023.namprd17.prod.outlook.com (2603:10b6:a03:1b8::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 06:00:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fad05cef-a6cd-40f8-8b6b-08d97d8e39fa
X-MS-TrafficTypeDiagnostic: BYAPR12MB2792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB27929D150D0B7326F4F6C0FFA8A29@BYAPR12MB2792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: midMEGJCUp8eboZV8JltZk2kwd/068Jp0ewGiQ0BwertGeFKa3/0Gb+nW8sPAq1WWS5T21j+1ZxA4pq5Kg6WWsEfr9Z2dOL1QQ+6BUozo0N/ZoWD8e7aNGLf08D1v9Ik6xdbuvCJGl0hNogan2pASzkhCbX1wb3s2CN8v+WlAnc+EluiPHr++5Y5wAmRdBPu4Kuykv9xa2G4VUXO64uZm8IoEs6jx1vqqyJo0nhpWPbEYft/Yf2raOHoyjDMZzAqiDINjSUoQ6rTGKEPQ7Rwn/sI5M/m94/PJ4K2XxzgOV5gyM8Jr6Oj3IXnlW5CyWr6vI71Zf8QYpAS5YVzCUcytoKhmyCHC1khsCCGk/p+YNbdvQ/8Il6TLZCI3mpivKFfbDefJe7w9H6WBWqa8vQyMpQVR+X94IO2ovgpypq9X3KLun8CZ4bMypWNf5l6dIFEhNBLsVjAarh2o3vB8bglHVC06A2PHrBOy3V1U2QkunPlWAI9r/Dcl7gmSOir5xzafVSxDEmuw9Y+RBUbgu5gZve9CgbiIDCK4ANJAH1CitDugWqI67ZWCYq5FJOZa6DrW+5My2b+XLIxG88X3uDN7iQc/YxXK/tr4OBb02iImkha80/n3AHYVup2YObNO1vGztHt28EVxippWFwqHYV0THqX5O3PKNcI9/uU7ju7mHu1BAgpy7JZ4Fll8Zq0NAWZT/5q5YfvJnEUQ34xQipGNblZYWZtf6+EMIzOAFGBIBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(5660300002)(508600001)(83380400001)(7416002)(31696002)(16576012)(6486002)(53546011)(316002)(36756003)(2906002)(8676002)(4326008)(6916009)(186003)(2616005)(26005)(38100700002)(66946007)(66476007)(8936002)(66556008)(107886003)(956004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2V5SVJIWGJOZEt3NkRHR2RMdkZ4RnROVzdkeVV1Qmw5cUE3aU1xeTlOaXFG?=
 =?utf-8?B?TW5mR1VSYWJrWk1zUTdzL0NTdG83aCs4K1U2RHd6eGovc1EwWVhkcnVhUEZI?=
 =?utf-8?B?OXBKcVhOR0hiRVNKWWZCL1VMVzY0RUl1b2ZpNFN2YXh3eHBoYVJuQ2ZTMVp4?=
 =?utf-8?B?aFNQVUpMZDNjRUNqWDhYeWk2M0t6QXpwcDBkT2dJeWpPdXZSbDJpNHpUY3RE?=
 =?utf-8?B?d0tOV1Bpb3UrK2dhVEQ5eTJnRyszQm1sSHJveFFyV1p4Y2NwTTBFd2w2Z0pP?=
 =?utf-8?B?NlJIaVNJbnZnS0V6NGYxQWgwZFYzNFhmRTZDWkxPNk9keXhGWDFDcm9zdkRh?=
 =?utf-8?B?em9iaENHU25WRm83UHhocitreXVLTm9rYWl4VUs0RjBsWjBZNThjS3R5QW81?=
 =?utf-8?B?eHF2UU5vS0I2dnk1NkVJQjExNXE4NHRtMHEzR0N5amRLVnhLbXRtV0h5N2RM?=
 =?utf-8?B?bmRFU3hXWnZYWGZWZXc5QjJUMm1oMnRvZGMxVVV4bWxFaDJPZDRNcVUxUWN0?=
 =?utf-8?B?QjIwaXI3TmlkVllJR2hVallObmZqOG5DMVNqRzRPdEUvdUlSak9HdVpGZWU1?=
 =?utf-8?B?cTYybS9hKytuZ21OajdjcXRSVFNuOSsrc1ZzeHk5aE1tSEF4WWtXZWp5Q21j?=
 =?utf-8?B?OTZyWE5ZK0U2dHdjbVljRjN4TmVPczRtR3QwYlBNQUhXY3ZyQlNBdkQrSjlD?=
 =?utf-8?B?OWtjUnFBbEtubWc2UWxQd215b0dRemJqc0twcjBHTUN0RnJVU2lNU0dsaHRH?=
 =?utf-8?B?SDNncENuc2hmY3cyaUVGMjg5cGJOc2lvazhJdzREUE45MDRTbCtPU2QxNFdo?=
 =?utf-8?B?bmxlemNidnpSMU51clpSZFpqdjFrS2owYmxybjQ1TGpla3pkNU5ocVhvbUVH?=
 =?utf-8?B?WXUvMzUrUkZPY1ZkQTE1ZmZtenZrVnBFaE5XUUh1VkpZSmswVGVVVGtVYncw?=
 =?utf-8?B?Q25ZU1RWNVY2VThlUGxZNWJNMG8vSXQrczVXeGtFVk95enZ0V0pZVUo3Y09L?=
 =?utf-8?B?MXNLSG82eWtvUk1ySXFZR3VVSFA4TjFCdmttS1pYckRoSnIwaDZCY05pY2Fm?=
 =?utf-8?B?dnJud1krNVhWRUxLMFVteitaK1Ztb3p2L0VhL2tNbVVWc08va0lEVTBUYTdZ?=
 =?utf-8?B?RUduVldSa1BYbGpraGVQdXF1V0pDNEJiZ3pXMTdIRUsxMW1KelB2ZnFjYWZu?=
 =?utf-8?B?TlQ0anRtN2hFM29TS1hybUluTFhtTWdtK3lQam5iRWZCcTJlK1VwK0x6OWhi?=
 =?utf-8?B?UHQzNXRETkZJUkQwaXJVcmxPeVdDWXpGc0d5T1djN1J2Nks0U1NXWFBvbWda?=
 =?utf-8?B?TnZQZGNrNGFqaGFTUkFsTFBMcC9XRU1tZFR2UkZzUVRPUis0SEloNFNIL0JV?=
 =?utf-8?B?N1hNUjk2OGpnUjhOa3FVcllHVEd3cHVPWXBSSy9tNEVQdjVBalpjZ0FDWjJK?=
 =?utf-8?B?Y251SCtLbHZiZnc5N0IrOVZ1VkxleDkycjVmd3AvYXMyWC9YSzZ1OHNQV2NW?=
 =?utf-8?B?aXVoQzNJc3JOR3IvK2Y5TWgyNG5ZRGUwVHRSVnBDUmptTWFWM0ZGVlpYRDUx?=
 =?utf-8?B?V0gzWHY0WmNmL3crTHh3VGlwYU9TdFJBbGg5TDhMaktIdG9PdisrSEdzQk9R?=
 =?utf-8?B?aEIrWTFuMUd4ZUNYRE5PMkt3TnE5R1Z2cU11ZGZyRUxQVFZTSFZnQTJaU2kz?=
 =?utf-8?B?REU4RFJld3NkMVJpSzVGYVNHR2VnRC9NdCsyY1RRZENHZEkwTExadzJNam5m?=
 =?utf-8?Q?43igfZwSznGeCkoLQ0VFJVcsxARpuiysCuTAigK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad05cef-a6cd-40f8-8b6b-08d97d8e39fa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 06:00:06.3166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSTuElutNoaAEjYtrMrdSJZcxSd/H3IAvZxue/9WuTHWPCXP5B4Wfr0bA5rpEPoj6LnAbLTcFWKAg5UsKNEMDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/21 22:53, Weizhao Ouyang wrote:
> 
> On 2021/9/22 12:17, John Hubbard wrote:
>> In order to remove the need to manually keep three different files in
>> synch, provide a common definition of the mapping between enum
>> migrate_reason, and the associated strings for each enum item.
>>
>> 1. Use the tracing system's mapping of enums to strings, by redefining
>> and reusing the MIGRATE_REASON and supporting macros, and using that to
>> populate the string array in mm/debug.c.
>>
>> 2. Move enum migrate_reason to migrate_mode.h. This is not strictly
>> necessary for this patch, but migrate mode and migrate reason go
>> together, so this will slightly clarify things.
>>
>> Cc: Weizhao Ouyang <o451686892@gmail.com>
>> Cc: "Huang, Ying" <ying.huang@intel.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   include/linux/migrate.h      | 19 +------------------
>>   include/linux/migrate_mode.h | 13 +++++++++++++
>>   mm/debug.c                   | 20 +++++++++++---------
>>   3 files changed, 25 insertions(+), 27 deletions(-)
> 
> LGTM.
> And, maybe rename the migrate_mode.h?
> 

I thought about this, and after failing to dream up a better
filename, just figured I'd leave it alone. But I'm open to suggestion
there. And it is easy to change, since it's only included from two
places.

> Reviewed-by: Weizhao Ouyang <o451686892@gmail.com>

Thanks for the review!


thanks,
-- 
John Hubbard
NVIDIA
