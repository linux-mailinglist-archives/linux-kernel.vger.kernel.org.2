Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488E840F33C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241073AbhIQH3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:29:20 -0400
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com ([40.107.93.43]:13153
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240170AbhIQH3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:29:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8QprET3bJnwYKNEdxlAnbu+7jkHXnXCPno2x6jlF1kyEx/QKqtooQZYKlEiXHe/iDZJ3gAIo/Xw8R9erfwFpDgPezvWAFdizF69fiCJH4YQm3a7Jstxnb/EwUh8Xvx9iTHq9znjS9iDbKof5gibPNZn9H0BN8QGOKQzTHx0GdvxGmCDed92fvlWCxkkl2OvUIvBzVNeZr2MdChWGXmjT6xg71P0nWvExPqseYRg3msJdRqgk3uol1E8ATTHPIGc24gjj7FGCvxn1xbs6cZTIrKR7i9yVOOryiKf+0O1tmYW7pIT7Unsq3ju7sj3u8lWCAuPS/8GTQ6f4VwALtsiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UDaILTm4az4m7Yb3yIaFBQdmQyME8PsUKk0mViH/jEU=;
 b=OXm68pa67j6KEVQ2Y53gVif6XMBrszvci3yhOiSAEl6mOkXaGec99V1Q6JHwMC+Gc3ijzCfu3TPOkfjgp0fa2hIWKZSdqxWEvWkZEQY0o82DWxECnhEgaQdnWIH+/5o47/pkaqSse/3UP0KoiBaUZ59f/yMO63KXAjCeuGYCkLnCg8jV6+XKDE5592TQJhAXaF83IrawMYsKFRml9L+bXOKr3sAZqudmchikE8LqJGq+CVIFJeaGVbK9dj4TSEZeX2Dw5jUoocxiyBOv/rBZ9maMhWUEkbI0OJxAMQXrrKDd8ZA298aR3X+AotA73r5XEXTipCVSZT2eUzmxjuTTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDaILTm4az4m7Yb3yIaFBQdmQyME8PsUKk0mViH/jEU=;
 b=AXHEjIRWbTqjvlxqnNmUxPV0VnwQ0fYTHbZ/hC26jdooc2h+lJ6SmCGCsCojRcLcPXxpbjPNzGe5ob7CqgwpvQU5Mgor7SWgFSWHXJLSi4N+ZRy08g9oA04fDrR+Lq2x3HnVTR8OoelcvMD1W4RwLyAEi9XAq2ZJh1T0TbTd6wuZTwEvqDJmthBQc1BLA7mjL2isaumouNEnhafJ1rZC04hEHj9VSWGDzH4p7vK13VGUa1PQ5v/pmhd2SULxtQb8uoyhSrdwPcAV4RZkgeli9OltJaFNyHi1V1osHQ5baCwwgEQZgTzi/HtXHFa0VtcYZ7d0nSAvn40+huebKsdAgA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4853.namprd12.prod.outlook.com (2603:10b6:a03:1da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 07:27:45 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9%9]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 07:27:45 +0000
Message-ID: <16fbae70-9cbe-acf7-5c8a-f02f0881c7e4@nvidia.com>
Date:   Fri, 17 Sep 2021 00:27:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Weizhao Ouyang <o451686892@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210917061432.323777-1-o451686892@gmail.com>
 <871r5nptt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <871r5nptt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:a03:331::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.48.243] (216.228.112.22) by SJ0PR03CA0082.namprd03.prod.outlook.com (2603:10b6:a03:331::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 07:27:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dd6a55e-47eb-438b-6dac-08d979aca46c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB48539C3150E821C0FBB407EBA8DD9@BY5PR12MB4853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9WGv24u0E++hyvgkXwNxiKJAlNxxeHLnaGTpPLsyJtVNq3/5djbiY56EStBkgc6SerZBTHaxcbGiLZj4r77ci7Ay8NWdCu0ElHIV4PlrQxVWPHC5Wks5QlSHTL6/F6sEw0Mz6P/8qpp3/xKzLo7dlstvmQanofW5sW9qTMai3U3AJX0HK9Pm2chVZYpJFfPNCO1U1bNDHu51Q9afc669psVy0vX/oWtqut31bW+z7YY5lnptvm5fjyX+R3zyUBFaBULO+/VS7lz2skJjRPnEnw+cQpHJjnCHAAblOT9wD13ovS23U38XrYRwZHrrlAE/Z4MjCdxuKw/ZMuIpaCTV54+SM58Fus/1aQtE2OzXx02/svfEx8xYzP20tI1OroTKv2K4YRr0YtvY7KCrEvbtmgyZQbNRQT6vAUept+ZCCtVFbh8VCC2sO27A9gsMv01BdIlZh8hssVTDUwpsCL3zvCIcHcvxlXDcRSKdqHYAmzBRuTQ9301fcOKnv/fbw+rBoXL1z8iSz0XRjDMxpKGlo8zqcN30oEUC9VNAhXXf+e5XgIb1ogg79qsbPlA/yi62E9GseD37UZKdZShrGeeDDKZLhQ4HlfhbIUC4JZKRhVN++zi+oOIT/snvjslRqsyo0UH9nYrGkOCH3TOv/ECqDGqQ9UbKuLMkg8csQrQRGZFSseWn4v2BEcxzLmbhqZUXonhkBxkBbfRLutrDMfz205NDzM9+z7FCPYeOUdNVWnhJ1AWE+dvo8tnXpACkoxwc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(956004)(186003)(5660300002)(6486002)(66556008)(2616005)(8676002)(54906003)(316002)(4326008)(66476007)(16576012)(53546011)(66946007)(38100700002)(110136005)(478600001)(26005)(83380400001)(31696002)(8936002)(31686004)(36756003)(2906002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmY3b2FEUElCZ3p2dE04Y2hkaHhYeXNhck1lL2Jkbi93RTVEK3UrSnpvRndG?=
 =?utf-8?B?b2U1VzBTa0VoSnJDeTJJVDZUM0NvR1Z0cVNBK0xaOTBFckZkdVZQR0Y0bnpi?=
 =?utf-8?B?bms4NHlyMnVMaFRYaHRyUkF3VDNWNFpmemZJMlk5bFhKUWpOUHAyRmw2ZDJ5?=
 =?utf-8?B?ODBSd3BvVTRJenlaY0ZDKy9veDJlVDBtUnhNWFZQZHdZQ0EyQjVvSWM1ZVdO?=
 =?utf-8?B?K2duclhHWHpYRTc0bHEyOVhMcWhKUk9kK2JXTW44dFRFd1pGY1JkRUVNdmpX?=
 =?utf-8?B?UmRnUlU3OTlSK3FKbHhoYnpQSGVQOUVoVk5BZ2lWOE9MYkdmTE9LaWRudnFa?=
 =?utf-8?B?T3lZSEgyb1ZwZmpLbWZxVlU2Yld5eXdPREdrZmxVTzRMSXNUbGMvZGFZbVl6?=
 =?utf-8?B?dU85eTZ2YzhYNGkvN0x3Q0o0ZCtITC9pZTJkVmljbjZOZk9UZ3o4RFVaV3g4?=
 =?utf-8?B?clhmL3Q3cU9nMFkwbUQ1WkEwdHluWm8zSUN3aWltMHZwbS9XZ0VpSm42Qkx5?=
 =?utf-8?B?WEQvSHkwMWFqNkVIVWk5UUhNeUo0UVpYQittdDNBbks3NVU1YThrVk1Ud1JD?=
 =?utf-8?B?NHdwdVh4OXRFTlcrWnZ0WDhoaEJ5clNnWlhTRW84NCtveVJTMFE3elJYT0FN?=
 =?utf-8?B?YkNhYk9NMGU4djMrZDVVR2xpcDViTFhuWXIvT0tFR29IN3JZcGFIS0NFdGtN?=
 =?utf-8?B?RWtyRlVkOW5paVYyV3NyRXRKT2Rwa0FkYzBqcXhhM0hHb1gzUmwrWWVhaFRQ?=
 =?utf-8?B?T2QydmtQWlRjeG4wNkx4NkN5VXFmYUlwR3FObWF6Q1hMWmVmWFBka05SblJK?=
 =?utf-8?B?aFdkbWJLcEhBSVhYZit6TGJ0VjBRTXlIeEhuOGhTeFlNVWZ3Zit5ZDJWN0hO?=
 =?utf-8?B?eUpRNlFWRnF2bHVxTkFoRDRWdmpWK2R1cktnZncxK2YyOS9rSTBYS21KM1FG?=
 =?utf-8?B?OWRTbVQrMksxZC9adWlnME9veG5BTXZJczBxVFMwUERoZWpFWFZlalo2VjJw?=
 =?utf-8?B?Y3JJeTB2L1dOZFRBaEhPTG95MTZyYlMwWnY3S1RMWEdwK1FtdEdML2ZvQVdK?=
 =?utf-8?B?NC95ZTJjY1lnbmQ4Y05wTmFjY2psbFdxdGFIMFpTbkhtTm9USUFyWWxZVCtJ?=
 =?utf-8?B?YTZPSldNNFlodE9vTzl4U1ZQRjBnaWtuaUVhMTArMU1pVEZxd0xkV0xtMlRZ?=
 =?utf-8?B?QnZIZmJrTFAyUnZTNFZJekRwRk1GYTQ5MWlFSUFBRkpEQUlIbWdjeXF0WW9w?=
 =?utf-8?B?dzB0OXJkWWpKNkhIeHladFJpcGlnV1BiV3kvU2l6b2tsUk1SZys1Z2RTTzhS?=
 =?utf-8?B?TUpnWXlOSll1S3NVdE9xMXRrWkoyZDFLQUtyNm5wc1VTazVUQk4rWWZmTjE1?=
 =?utf-8?B?OXBGRURMVS9vSGs2NS9ramxFMGtnekJHTGQyNkZ0WE9uT2YxaXVjVXBCcUdu?=
 =?utf-8?B?d2hEYk91RitXVXBSSC96SjVDRzFKTC90RFJ3ellJZkdSZENQZlNDdW16d3RE?=
 =?utf-8?B?RDNIQlc1V0NGRTNsdDE5UjJwVlBlVGl6VkRkY2ZsZ3BZQk0wUXJ3ZlFuVGdr?=
 =?utf-8?B?YlVzYmtKYWVLMXNWV1RDSEhMODVkWEg0bkRiR3NrUVhsUUZ4dE5aRUJGR2Q2?=
 =?utf-8?B?eEtCbThnS1huWlJDY0JxRjNjWU1EL2RQdU1rQ1d3NUUvZzlLSnRmWFBmaEcw?=
 =?utf-8?B?UEg2eG9zZmhyNC9lZUJhQkRMTjFDcHhKNzlFNENORFRuT29qZDRMRzlTZEo2?=
 =?utf-8?Q?61st4laRPEYbAfnrqw6VkIln4OS1EbOAYudFj3P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd6a55e-47eb-438b-6dac-08d979aca46c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 07:27:45.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXlc5C7FB/R9O4gsCEGgbbebjujlU2yjZmyMylKorw1heOQOghEA/Jd4nOVIGYVg8kD8ElO74ge+RLgIwZWPQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4853
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/21 00:03, Huang, Ying wrote:
> Weizhao Ouyang <o451686892@gmail.com> writes:
> 
>> After related migrate page updates, sync up latest migrate_reason to
>> migrate_reason_names, page_owner use it to parse the page migrate
>> reason.
>>
>> Fixes: d1e153fea2a8 ("mm/gup: migrate pinned pages out of movable zone")
>> Fixes: 26aa2d199d6f ("mm/migrate: demote pages during reclaim")
>> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
>> ---
>>   mm/debug.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/debug.c b/mm/debug.c
>> index e73fe0a8ec3d..733770b0ed0c 100644
>> --- a/mm/debug.c
>> +++ b/mm/debug.c
>> @@ -25,6 +25,8 @@ const char *migrate_reason_names[MR_TYPES] = {
>>   	"mempolicy_mbind",
>>   	"numa_misplaced",
>>   	"cma",
>> +	"longterm_pin",
>> +	"demotion",
>>   };
>>   
>>   const struct trace_print_flags pageflag_names[] = {
> 
> Good catch!  Thanks!
> 
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> 
> It may be better to use BUILD_BUG_ON() to capture similar issue earlier?

Yes! Or if BUILD_BUG_ON() can't work here, then at least a comment in the
various locations, explaining that these must be kept in sync. But
BUILD_BUG_ON() should work, I think.


thanks,
-- 
John Hubbard
NVIDIA
