Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C76413D14
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbhIUVzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:55:50 -0400
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:18529
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235782AbhIUVzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:55:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ma8GIwpg1FgDev14EkRe2WhBwG5iUYvO/qnThYj7shEg4opB2NaLeVHSzPhriCeMj4EHAP53lBGU/nwgquS1+sBMsxEEgpPjQQ5TAD5yye1c/A2iIm8AWEC+Ekg5dNAa0PWe85vYSUJT/0AgEuH6GRQYLMmT0v5Z9Ynya03KZ2q9lxAkzxxWsivgMuZtCwFLSty5/7cIx/+CIEsbFD7raq4m2bX4KpMHjt6py4XY6Bl6FQbhb2v2dibvSRh47UhOfk7pAYnQU5MbeSUYvFpIFnnz77ybprDvxrXUQ+EDnTWts7Ow/Vk2zHcuWXw6lLGtIbU2vsSYYITIqU82nfGpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FFJDC1tzEScc2W8JUZfgEbwe0rHENG8W5IJssSTSFC0=;
 b=apkK0+I5geZl5+AsDcaOJTsDacdLgbZJMpuHz6pKKiMRr/IiVn1m/1lb4K+6JutuSowzP1/Uh2lruiGfyM4cpuftzYEw5M4o1RKnJaYHy2wDteKgjp+ZBP70D3/w3ZdsK1TZ5K1d5Wwvzys/TlZy99Ekn+WRYLmY/ehcoUr2yoHGOMb3u8fLkZ/gQhpPK75slCRDnZDQZ01O+DwWbF98IXtTEOjXC+mL7AUDrC2/kpjYSN9u40aPoLbhwCztwK6tymJlJQSmZ7Y05/LstpGyUC4HEHpbrABrisNpq3idaBQCRZFFIKY8jwF7Pi55680UsghKWlgCGCjHISeRcDY6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFJDC1tzEScc2W8JUZfgEbwe0rHENG8W5IJssSTSFC0=;
 b=jFeiPA/V0MT7/6BnanxhRQka9VbOuSoecU5cDJkz/DeDWi1tfslLidwmCdFad2UTiyafSUkBPHsL4TGgvAwpyEuOFG/de2dCSa8GASjbA/51gPScTv5zSm0WurRcxGd+kgUWE8jlewKYV/acilpXZ7ruNVDxrn+LeweZGR6NJvp0Hm5fI39XT0PI64F/OJxrKMqSSl/DsU2kWxiV+6FyIk5Q9Q+x/z0ocepB9iZtD/0vJLEjaCuBmfNQc6tOnuUgqapft98tZ5WHA1nt/kVH4MlcWz/pwgag6rTIpw1OgEWJRB185wYDylcPaFkFFwAc1Em94+s5sp0vQogF6259mQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Tue, 21 Sep
 2021 21:53:35 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9%8]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 21:53:35 +0000
Message-ID: <375b4cb9-b031-964f-7e37-f5639254742e@nvidia.com>
Date:   Tue, 21 Sep 2021 14:53:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 2/2] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>,
        Weizhao Ouyang <o451686892@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Mina Almasry <almasrymina@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>, Wei Xu <weixugc@google.com>
References: <20210921064553.293905-1-o451686892@gmail.com>
 <20210921064553.293905-3-o451686892@gmail.com>
 <87mto676fq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d57aaff2-b154-4462-1a7d-3d288ebabb6a@gmail.com>
 <87ee9i6n1w.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <384b551e-28f0-ca7a-61b5-78f238de6e4d@nvidia.com>
In-Reply-To: <384b551e-28f0-ca7a-61b5-78f238de6e4d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::33) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.92.177] (216.228.112.22) by BYAPR03CA0020.namprd03.prod.outlook.com (2603:10b6:a02:a8::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 21:53:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a58625ef-715a-41c4-4439-08d97d4a4303
X-MS-TrafficTypeDiagnostic: BY5PR12MB4888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4888DD60190F3DF0A46D64A1A8A19@BY5PR12MB4888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSzWFyx2PDn70IAdQtm3Cnar+2zoSK+Ohi99DckHdfZiadsSL+PoHdDqGegxouiZFx3qtx+0cbTvn8CSMx92FR4AyhhYR4EE21BGYk8LCAXlpmXbnHqDOYmUpgWEoQaeOFJqc26vYg8LHavwnk4ojTzlgam0hl1fiQIx8MlOJSBD7DgQRmqMs5nEp+Juz9HIL1U8a6WzXNndnn4U4iOC/L85zD2VmCX0N0SJDTNRY3kWIak8Z3Nh9KUsr+tr+/dhIIfp2xY6xciL/ws4Rak83WsmN8/ktH+bU7kvVDPNiUmtvB97VHOZw4AEHQazq1UYC86pdTM3myWgq4mtLoqmalU65WjLBLqSibueTwd/6R9F0LDmEEAH74doYAEhBvHBMXYnKeUDSaJNvyWJXyDqrfTHqJrHtiiR61Q80DI/rIXDb3UdoWKfiPKn/6w0jfbhU1RAqua+yeK4xoIyOU4AL8e0Hq9bPj1MfeRuUvdWQn82HyXYjQ0b6Tr/K84ycPzjIKZFnFOX1KLEfd30EA+TIlbXTUI4Q8KDYr6yAeUbz0fwXDOTFx/Q9t+i1rJwphl1v7qHMjXmkJQ1mzDCYiuyM2+YcE97kYHtnArCPGpzre/nw5rwmGsh44va8ryOQmault4Vc5Zbh9C0liPFWV6YvZxFkpg3MzhLxa/8PfQWOQNUc23L9mqbt8Ra/5QpKqlbKvksdnablBPyKcE77a/YcNi9vFMH78/4vQmfHNJ1HQZBd4LqJV9PzYeUtClZ8I/q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(83380400001)(7416002)(8676002)(186003)(2616005)(508600001)(36756003)(956004)(31696002)(53546011)(38100700002)(86362001)(31686004)(26005)(6486002)(4326008)(110136005)(66556008)(66946007)(5660300002)(66476007)(8936002)(54906003)(16576012)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEpLcmx0MDdnVSt3RC9FL1V2eVFFK2NDc2ZLNkJ2ZzZZbnVidVVPMU1TQVRn?=
 =?utf-8?B?Q2x2dXd4OTJyYVZ5d3o1ZnJscmZXbUJ0RHpPU0lsQnJLbWhjMklhVUlDMTBB?=
 =?utf-8?B?TkEzeGhlQmZ2QXM4RWRhWFJOTGJSUEwyeVVralM4eVloVWhsMHQxQWcxVXkv?=
 =?utf-8?B?UEtIeGRIMGNPa1R4TFk1enpHVzZ5bnp6TlFlQ011OEkvb2dNZzZTd2lSTUlD?=
 =?utf-8?B?anRyQzRvMzNsUVhhSS9QSkFCcm5IQTNScGJ0bXorek9PUUdYcGVZQThVQ0FP?=
 =?utf-8?B?VWJxR3oyZEhsaEprQ2ptb2ptTENHTzBxblhJVGpub2tRZU56WWV5V1pEZ0Rz?=
 =?utf-8?B?K0NRR29kbXByWUdyRHdVSVgzT3Q0UHF1R0xvUjhKWFVTR0R2R2FkaVc1Zk5a?=
 =?utf-8?B?NTBNT3NIb1JUdmJaNWR6OWZEWXc4Q2Z4ZlRjc0ZYZXBmK2EvZUpaSlFHU0FO?=
 =?utf-8?B?cmxnVGxGeHdqaW10a2tBTGJiQzdpU1QwbC8vdTNYUW1LZmN0TWgzdENXQUFJ?=
 =?utf-8?B?NW0rNllFeG91YnoyRDd6T1k5bnBUdlJhdWt0ZFZVRTl3TW9jYk9HRUxoa2FK?=
 =?utf-8?B?MHh2dFNMZTJTRE40RG5aVWFySWFIR2hDT3JjZGRQRDNQNnFzZlNBOVk1eTZu?=
 =?utf-8?B?UWptS1lwZjRsLys3Zlc3UEw0aDNGdmNiRmNGYmowaXZKUmN4MmpjVlkwVzJJ?=
 =?utf-8?B?ejNBcWJhY2hqWFE5NGFMeEFlUTZFdWVGeGhmeENhRVBTT2s2aHZvM1ZGWWQx?=
 =?utf-8?B?VENOYkloVDFDYUJWOHRybXUrVUpkUDZRYTJWdVByM2tXMFhOYkZtK1F6em0r?=
 =?utf-8?B?d21CdTJIVjVGT09oZTE0aWIrSVdnLzBWT1NnUUhkWngyRnUvTktxOHFPWGlz?=
 =?utf-8?B?TGF4Mm1SYkYyenVpeTJQVnRSVnk1MjJMVWpVRmpNSFhha3o4Qk1YZVRWMW50?=
 =?utf-8?B?SWpzRWFUQjJUZi9BbHVkSDBpbWc2TlRFckVMSEpxWHB5WGpETThpK1c2U0JL?=
 =?utf-8?B?THdQY0poanFHckYvSGlSdHNIR0FDRnZuejFENkhrZDhUTTNqeFVxcnNjTHRJ?=
 =?utf-8?B?UDFRQ2tjdTdCWkJaU01aVWo5VCtaMTNkMXpmQ2tzSy93SU9qSDgwUEQzdnpE?=
 =?utf-8?B?UWtvSVV3Q3RlTlRhYXZTNnpHcGVNU0ZhNytyMEszNG16VkdPdDhkcW95bkIy?=
 =?utf-8?B?RnNVN3NkajBzbCtabTVsWkVud1AxWnFSTlIrRHFWVU01UkU4cTVWZDIwU3lT?=
 =?utf-8?B?TXVBa0N2c240bnhMZjVlV3JheTVZSHE3SkViOU5wNHd0QnBJMDBienYvOWJW?=
 =?utf-8?B?SFNkaEdsQVNQbTdBbnF3S1A3T1ZGZXFmVklJY2xSOXBGaS92SUxBaG81ODdT?=
 =?utf-8?B?QzFjaUwrN1RFM00xWXM0U2dEV296RjQ4MmUxRE9GZ1d6aHAycUU5VGRkTTFm?=
 =?utf-8?B?MWZmNXA5eWR3RTZtY2NVVXFUZ3hJbjZmVlhWSExRRDJaWFZWcjk2ZEROQjdI?=
 =?utf-8?B?M1N6N09wT1RaeVcvb0IvcWpzWE1jK3dFaGltZjlyV3hYNXprVjNCanF3OWx0?=
 =?utf-8?B?TDRCUXc1ak51L2pOQlFFbTdPYXpOcUo5aGg4UTNSdTNmRTZGbVBzRlVKMHFU?=
 =?utf-8?B?SkF2RTNjN0I0eDFiNnpYUHhzeFdJRVozVlBwN08vZmZVaTVIazduQldtQ0dO?=
 =?utf-8?B?TU9nTkpFd2hkQXRLaVNKU0dFemdkSU8rZzVBZTVRcmdSNEE3cERma1M3a2Vm?=
 =?utf-8?Q?cmI0H11fbDu5jS+eYoU4dl9pZaRlkNrfV5gc1pj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58625ef-715a-41c4-4439-08d97d4a4303
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 21:53:35.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGdtR2MZyaKbXVR1+XQrA40q7EpRGUz07SNhSy6ZKaMWzCqhXZzmu8LkIr+OPidz+BScaDqSjQNKdJYj+idTwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/21 11:00, John Hubbard wrote:
> On 9/21/21 07:06, Huang, Ying wrote:
> ...
>>>> Can we add BUILD_BUG_ON() somewhere to capture at least some
>>>> synchronization issue?
>>>
>>> Hi Huang, we discussed this in the v1 thread with you and John, seems you
>>> missed it. Now we just add a comment to do the synchronization, and we can
>>> figure out a more general way to use strings which in trace_events straight.
>>
>> Got it!  And I think we can add the BUILD_BUG_ON() now and delete it
>> when we have a better solution to deal with that.  But if you can work
>> out a better solution quickly, that's fine to ignore this.
>>
> 
> I have a solution now, it's basically what I sent earlier. There appears to be
> some confusion about it. I'll send it out as a patch that builds on top of
> these two, hopefully in a few hours, if no problems pop up during testing.
> 

Oh OK, I think the confusion was on my end: you are hoping to integrate the
TRACE_DEFINE_ENUM in with this. Let me take a peek there, because otherwise,
we can only reduce, but not fully remove the duplication.

thanks,
-- 
John Hubbard
NVIDIA
