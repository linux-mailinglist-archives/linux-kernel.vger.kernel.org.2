Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52943196D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBKXp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:45:26 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33594 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBKXpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:45:24 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BNeM6d058452;
        Thu, 11 Feb 2021 23:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xDRTvwTYN8CdqZmJCD3lj/kVON3Y7H3XvZB9NobNOgc=;
 b=e/pCPaOfEYFD/uN4WrVVp5Mjg2frH3JJG4VjaG/O49P5hjnfZ1C+ezOfhZq4bELlIpSD
 z6tDarxNDqQFN5C+nejS5BobcoJp2F1j/8S7IPqqarnNpz3wRSpjbmX9JgaLAMFtEjz5
 K6aAOi63prCBGVeZcFGvbZWU4SRMgLPlQ27VeiLXYmh7TD6nRfu5aI2CITHoq/dC30sO
 0AwHlkyUxzIvKpi+QyLR2RQEWpyoVR6ayXH4iWq7QNvmkKSb/ks2d7aCHcslc8/8+FJR
 hU9p8fyx8udxkEtM1kOivrBwzdTiIARMPlZkCOuAKAq27CJzhNWp1wx5PterhtXuSIvf 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36hgmaskfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 23:44:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BNe5RW015065;
        Thu, 11 Feb 2021 23:44:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 36j4ps82ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 23:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP/5Di0K+mmDJryRYTK63yUNQ9fhdET8ZyrkogS/kmyE+ykCPp0Jh8tVsK+uEYoxbsgL8C9bLdQKoZUHf7XN1JHByNcxmPHXVKfrPHrgARNRu55iuKVXmujPgiKv3ayEoW3X5spvt7OUtWjQQZiU4t+9Nc+VwGG5VZgjimepxo5uanydumNxphfdu7wXd6CdIiAu+mNU9/ByNHUo8WsiWUGYkJ3IlGEx2M00gBqc6249rszdG48deCMrA383125mT1egk29+AmjuNrwF5RIf8fQPn4ufeaSbODSogv7qlLd2XXGYF7uvAE3lVLoiRGMMCkfWfqyxNZaBlVlWQ3dySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDRTvwTYN8CdqZmJCD3lj/kVON3Y7H3XvZB9NobNOgc=;
 b=NTv+FcZ5Z3zo8acriSulqzAdU1WoydZKv6s+B4BaCsMt65yEJV5+CpLEJV0cpqrN+ngz4B7YqcmwqmE8PnZwicTOhPb0pXE8pcnZMjFAaBMATKG4XyldZ+KPLiGR5oWZgawjbwATEoG3Adpjf1xblaVAXcW+V0DxNYKQGjUBdvynWbKi0TgCX3yrVnp/rLrer5pg+kaQDmjL7/4w+RhzqIqhNraR0AA8gdsIC9yfk13KtvdamOcHz0CvFM7Lodk7N90tVjmdYq1/fDWq0RZlW7MgVZnL7jCDPCubloOIuP3uV1N53a7tVsJYRjwA4Wx5GrTwBNIWkWZexW4lqf0QFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDRTvwTYN8CdqZmJCD3lj/kVON3Y7H3XvZB9NobNOgc=;
 b=Y4i/01zbMQQfi22PLiIaJbt/tZCCAP8BEyS65rQIwrVLhbQb/tMyOnIKXn9ksIQCNsk6dA4U6wUve2UynGv0zXUIHM0bR2K2b5SI7R+Se8vmnv9By3GHW+Kpkf/kaPTI1XovII18y5VuM8v12CQGqruWwy4+BEdZT4D/+WvxBLA=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1504.namprd10.prod.outlook.com (2603:10b6:300:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 23:44:34 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.028; Thu, 11 Feb 2021
 23:44:34 +0000
Subject: Re: [PATCH v2 2/2] mm/hugetlb: refactor subpage recording
To:     Zi Yan <ziy@nvidia.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210128182632.24562-1-joao.m.martins@oracle.com>
 <20210128182632.24562-3-joao.m.martins@oracle.com>
 <b550e766-b0fd-2c99-c82f-80e770e8a496@oracle.com>
 <68570840-78E9-4B32-BE0B-B6DC60479DB0@nvidia.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <07b6b61a-2a78-4f49-70f8-e387462a95cc@oracle.com>
Date:   Thu, 11 Feb 2021 15:44:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <68570840-78E9-4B32-BE0B-B6DC60479DB0@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR10CA0007.namprd10.prod.outlook.com (2603:10b6:301::17)
 To MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR10CA0007.namprd10.prod.outlook.com (2603:10b6:301::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 23:44:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3521d7fa-f992-4198-8ca5-08d8cee6fbe1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1504:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1504F23B171EC736E25D8AA6E28C9@MWHPR10MB1504.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C33wY5N5CS391dzq9saOrJ7x+TE1coy+Udv5hIRZXRfBht5mJL/OkiOsy/73GvceKVdNs/peXePWAVPKjiNTgCj6NYFBAXlPqbhrawItjmcKLOOTmvdVKwoojUFyvU7ihQIOQsIQRDF/TwacH6N7pdfLQsPZ/5DmYzEXOYTnnok0jgRBdrED9ZQddEwzghV4J8CK/JVcQ5M6gP1enbHRNH96a8Cn0ykZ1BHx4AvdBWEELPmTuQVP/e5tlBl8fuqgvXE0Z67yo0f4yXkcfnhAnImuG+/XaoRQiUFOjh667ignEd8+rXfe6mMedYHzz5bDoBr8qEE/APbl/jSJbz3wV34slDF0Qn6rVUZRFAZwY/ImIGRTKcItGoRafjueCSL42U3LnCM5B/QsutlBiDN2Dmwq9UrsA4NumrgjN0bS1oJDa1f5VnJcqhstkDtoetRmhUk1UGDeBiF1+NDmqQKPbD84btJg+lVIKzFUvwSAeSkQWFD9FKA9C+1tbHXU1dkBGAQsRHn+FImycDxhAV8ngOx297xzl/OlZvH1FO7X3/GCrJkJwWQfoq14TAj9Ms96MzBvC/man673LVGoxy+I6uVeKpQhvhIU3IgdnxvgPaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(136003)(39860400002)(66556008)(52116002)(66476007)(86362001)(4326008)(5660300002)(66946007)(54906003)(36756003)(8676002)(478600001)(26005)(8936002)(31696002)(16576012)(316002)(6916009)(53546011)(83380400001)(186003)(31686004)(6486002)(16526019)(44832011)(2616005)(2906002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d09EUW9hZDFuUkVHS2tIRmdUbWgxNUs3R01sOTZqdkorVUhxUUZLVS8wT3RC?=
 =?utf-8?B?ZmZoTWptcVN1ZUhmdzAyRUJmNS9hWVh4Y2w4czMxL1BYS1VGc1ZkY3dad2pu?=
 =?utf-8?B?V1pKd1NjVEZxWkl0NkNoS3FCd3M4MzJvK1dFU1RtZE5TaHFNcDZ5WDZyeXpt?=
 =?utf-8?B?WUszNkEzL2VKZ1k5aXlNZnF6OGJrL0tyRUNwTEg1bjBnaHd2SnJRNXRUVnZR?=
 =?utf-8?B?Ulo5bFhKU2hOMXFJVTVWQWVNRE1zOTVEaENYSlFKVXRpQkx1WVV1N0RmRjZz?=
 =?utf-8?B?V0FVWDF4ZW5RRDJPV3dxT2NySDkxcWorL015YS8zMFYxM0JGTzBnTFd1dVdB?=
 =?utf-8?B?Um5qVlA2VzUyUno1enFhMDRJTTduTm95aWJxdHMzakRPSFE4Ujhsb045aHAw?=
 =?utf-8?B?ejBkSUU0c0I3cFVzT0tYM1hCTnpaNTNyRm5HbXZjRjFhcWZJOTRnYUEzLytZ?=
 =?utf-8?B?VHVZVlY5Q2NFV0VzUDZhd3BVUW5XRFNYNlMzbDJ5Q2FDZGd3cmJlaFlzb2Q1?=
 =?utf-8?B?UFJDRVJNQWNWbU5PV0tpeFZjbHN5ODJXeWtIREcrS2pIVGgwSGpUeGx0Yjc1?=
 =?utf-8?B?SkMzRXZJb0F3UGhRM3h6ZE16THZIYmkvbW8yTFBnRmxkNGdVK21KblpQTTNE?=
 =?utf-8?B?VWU3OVNlRk1VYkdJdFRhVlMzMDJlVGViampsQUlnNG9UbFowWVhOaGx5S1F4?=
 =?utf-8?B?WXBJN0MwTzQrakhFZFFDVlZHaHR4QWIyT1NYaU5Wd2xYdUNKZFY5TEtYenJ4?=
 =?utf-8?B?TUp6QkxZT3NOQWVlMnJxRDVwVVhOREo5TnlxZWtsSDQreVJsMGxxWTd6Wk8w?=
 =?utf-8?B?U29DOGlmK2U4MzVDM3dYWEtNc2RmNFZmZjQ1Q1RVLzJUQXBOd1EvdG9MYXJp?=
 =?utf-8?B?ZEpJdEphRTNnUiswdHhabi9UWGNMTmpka25VRlliS2V3dU4vbGREdXVDYk5B?=
 =?utf-8?B?SGw2YnBoYjgxaVJZd3lGcG9uUnNlLzVrWThHaXlYdFZ6a2xwaXRVbldtYWhs?=
 =?utf-8?B?aXM2VDMzSXMvTXEyQzVDTEhDRjRoQUZKZTBvOVRsMU9nK1EwV0V3b29rQkVy?=
 =?utf-8?B?R1AwWDREVWhSY2xJdDZUWkRuUU5kdkhvd1kzblJGTDVnSFJyUS9uZXRkcXY0?=
 =?utf-8?B?YmliWU95aWNSTTlIVDdmUUhyRXQ4SEJ0RXlkejZlQWFqQlU5K1g5SkkrQTAz?=
 =?utf-8?B?WEhuRHhidjhTaGtScjdJZzRGcjkxd0w0Z1JsaFRZMnR6OThqRG94dmZkSlpw?=
 =?utf-8?B?QktSWkNXMVltRFMxSmFwb2ZKZ0JUMURiRGsrckF3SHBCSlcxUldzeVlXcTl4?=
 =?utf-8?B?QU9qY2Z5ZUhvNUJqSWYyWm9tc2dEN29sb1BHRGlnMm0xODlsNEpGQ0pHMFJM?=
 =?utf-8?B?bkRIQU9BeW41OFRCOFJ5NEM0YkIySms0d2JQbnFBQUdUYTRaTTJWMEhwQ050?=
 =?utf-8?B?Qy9yaTd1UDBQYXJxQVZBWTdIVFZHVWt3UmRuYm9qU1lTREVYeVVPSXlBcVZK?=
 =?utf-8?B?WVlNaXNqNzBHcHl6OU5EdmRzWXI0OTBMVzl4K1NTU1A2cE4rQU1kVmp2d0xi?=
 =?utf-8?B?NlJRSnVuczd3TFEzQVVPV2Zybk8zeEpFWkpSbm5yOXJNeVcyeWZ1VGlGMlBx?=
 =?utf-8?B?NFRMeWJ5K0tQeU9aQ1RseEp4eEhkdjJUekNEdWx2S05Qb1ZZN1J1UGFUS3JQ?=
 =?utf-8?B?K3FMbGVRSnFXejRKMDBlRnJNZXFKRUNyQkNmTTVWSG4zVHcyVE45REpYSk9D?=
 =?utf-8?Q?KfSIjUMXXxBxftOIGwqAyL4RyFXJsweHUHm481v?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3521d7fa-f992-4198-8ca5-08d8cee6fbe1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 23:44:34.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chLhPCczOCQkbA5AbJLzvX23Xt0Tq2LbtVy3uFQ9G6ftQW3BqWBKdmyEKmA2F+jEomqQ+DAYEWfry68HriPP+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1504
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110183
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110183
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 12:47 PM, Zi Yan wrote:
> On 28 Jan 2021, at 16:53, Mike Kravetz wrote:
> 
>> On 1/28/21 10:26 AM, Joao Martins wrote:
>>> For a given hugepage backing a VA, there's a rather ineficient
>>> loop which is solely responsible for storing subpages in GUP
>>> @pages/@vmas array. For each subpage we check whether it's within
>>> range or size of @pages and keep increment @pfn_offset and a couple
>>> other variables per subpage iteration.
>>>
>>> Simplify this logic and minimize the cost of each iteration to just
>>> store the output page/vma. Instead of incrementing number of @refs
>>> iteratively, we do it through pre-calculation of @refs and only
>>> with a tight loop for storing pinned subpages/vmas.
>>>
>>> Additionally, retain existing behaviour with using mem_map_offset()
>>> when recording the subpages for configurations that don't have a
>>> contiguous mem_map.
>>>
>>> pinning consequently improves bringing us close to
>>> {pin,get}_user_pages_fast:
>>>
>>>   - 16G with 1G huge page size
>>>   gup_test -f /mnt/huge/file -m 16384 -r 30 -L -S -n 512 -w
>>>
>>> PIN_LONGTERM_BENCHMARK: ~12.8k us -> ~5.8k us
>>> PIN_FAST_BENCHMARK: ~3.7k us
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>  mm/hugetlb.c | 49 ++++++++++++++++++++++++++++---------------------
>>>  1 file changed, 28 insertions(+), 21 deletions(-)
>>
>> Thanks for updating this.
>>
>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>
>> I think there still is an open general question about whether we can always
>> assume page structs are contiguous for really big pages.  That is outside
> 
> I do not think page structs need to be contiguous, but PFNs within a big page
> need to be contiguous, at least based on existing code like mem_map_offset() we have.

Thanks for looking Zi,
Yes, PFNs need to be contiguous.  Also, as you say page structs do not need
to be contiguous.  The issue is that there is code that assumes page structs
are contiguous for gigantic pages.  hugetlb code does not make this assumption
and does a pfn_to_page() when looping through page structs for gigantic pages.

I do not believe this to be a huge issue.  In most cases CONFIG_VIRTUAL_MEM_MAP
is defined and struct pages can be accessed contiguously.  I 'think' we could
run into problems with CONFIG_SPARSEMEM and without CONFIG_VIRTUAL_MEM_MAP
and doing hotplug operations.  However, I still need to look into more.
-- 
Mike Kravetz

> The assumption seems valid according to the existing big page allocation methods,
> which use alloc_contig_pages() at the end of the day. alloc_contig_pages()
> calls pfn_range_valid_contig() to make sure all PFNs are contiguous.
> On the other hand, the buddy allocator only merges contiguous PFNs, so there
> will be no problem even if someone configures the buddy allocator to allocate
> gigantic pages.
> 
> Unless someone comes up with some fancy way of making page allocations from
> contiguous page structs in SPARSEMEM_VMEMMAP case, where non-contiguous
> PFNs with contiguous page structs are possible, or out of any adjacent
> pages in !SPARSEMEM_VMEMMAP case, where non-contiguous page structs
> and non-contiguous PFNs are possible, we should be good.
> 
> 
> —
> Best Regards,
> Yan Zi
> 
