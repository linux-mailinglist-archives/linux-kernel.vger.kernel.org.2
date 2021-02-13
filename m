Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CA231AE11
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 22:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBMVF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 16:05:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56652 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhBMVF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 16:05:26 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DL4aha018151;
        Sat, 13 Feb 2021 21:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NVFndgmnOB36q6QsBIwpEaZ3D1VuNZvMnTIe6f7e3Xg=;
 b=egq4POaiVrAaLjdyJAIOeKktGJFmJaFDpRUajauJIClixDvkQfE4ZqL4WloxgSdhREG4
 QLCHYyuaag9SdeFs1FREmc5qe9HYBPYbWhmQu/1rFvUnWHaFq1F4HOSm8AAx6ZkSFT92
 8DIULu3cXMnDj9QUMffzvdBGE6/gmVae5zR7UBCzt/0NxXrkT5ikjDd9tVv889w6FqW+
 geaiI/L0EC19GtndL8XhwiZC4hePgC6o1t0S4zEGrfsLxEAt7A3EMB4uNeyJ6Vot4EXc
 1k18Umvw/Y0gmGhQNFG2IcjkxDDzC3Y58vtlqIpRYfZOMmy549o77At5X/CO/iPzv2wf Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36p49b16g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 21:04:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DL1EVq024540;
        Sat, 13 Feb 2021 21:04:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3020.oracle.com with ESMTP id 36p6d4m1t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 21:04:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/C9Tcu/Ux6TjPdFn58uHSCUPOEL35NJj1CBleb/l7ZFV8e3V7a6+0n23tNnh75hfMg+hFUcT/rh/XqQxB+hKs1LcksZy2Ez4Hs4ZgTvVp1jCYHGwswOoG23wFHxReDmoze1eyRZcS/hmROhNOOQrwms8oqVXejPlRynIA6nuR+PTNvAaIb0Dau01NNrswcB0Ns1rp/WuE0Z2je03+cyO2jxWliXF8LHUcPw9XJ0Swo6G8c2JLalH+v469xQEGkmid8gxgNxT38KLzUyGiXj15LN7/YefaKOqTh9yVsSCGDGbss9CA81xqUyeH/SZ12hefe3H/DZOTrJLwlNXBJjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVFndgmnOB36q6QsBIwpEaZ3D1VuNZvMnTIe6f7e3Xg=;
 b=RcS5J85BKuHoU4K1PneFFa9lcPxXj67nRoRPU8hkLX5mHiazp65naMiz/yY00Exsj90Gs4FaJ2J9eqBl56OtJjuskKaeluTIOZ2tEuO9qDa9cDd8BmxH7ynmHTyHVhmw6ibnKRCFhEq6IJkbjrx5FgTwux9Xxn3nsTog0JIKeg9mtjjPgT/jFDLczaQX9wPf1yr9Wz6UuBXHmOo9LQXiP/y14/Rkh6NVG2q1fbQpMD6fos8Yv9aBP5uqqIj+QdpL2NHLZ6IR1TeVPX2eQEpbBeNqGHw7h3kO2Qxs0Yp/dk/Wz6Hh2q8LjWkjePJCr1DPVDtNOFPHQdrn0yP5ej0MkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVFndgmnOB36q6QsBIwpEaZ3D1VuNZvMnTIe6f7e3Xg=;
 b=P1qQys6zrTJqeBH0wvLy0rVwhSrY+5JPqTMuqjLisEPLxgUPnhv/W/vh/WKxils8CM1WgghpNjSaT4HBDp7PLFg/NlYw5eNFHFUFtl1zJF3lgOfcbB3UyUIRDfiJoRjs+zK5C3GEsJmjIV15DwdPwuVyZNS8VWV6LAic3MbOhog=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sat, 13 Feb
 2021 21:04:33 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.035; Sat, 13 Feb 2021
 21:04:33 +0000
Subject: Re: [PATCH v2 2/2] mm/hugetlb: refactor subpage recording
To:     Zi Yan <ziy@nvidia.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210128182632.24562-1-joao.m.martins@oracle.com>
 <20210128182632.24562-3-joao.m.martins@oracle.com>
 <b550e766-b0fd-2c99-c82f-80e770e8a496@oracle.com>
 <68570840-78E9-4B32-BE0B-B6DC60479DB0@nvidia.com>
 <07b6b61a-2a78-4f49-70f8-e387462a95cc@oracle.com>
 <16F7C58B-4D79-41C5-9B64-A1A1628F4AF2@nvidia.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3d2acb33-57e2-060d-616f-cce872c77307@oracle.com>
Date:   Sat, 13 Feb 2021 13:04:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <16F7C58B-4D79-41C5-9B64-A1A1628F4AF2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0078.namprd15.prod.outlook.com
 (2603:10b6:101:20::22) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO1PR15CA0078.namprd15.prod.outlook.com (2603:10b6:101:20::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Sat, 13 Feb 2021 21:04:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce702b48-7b45-4233-4479-08d8d062f647
X-MS-TrafficTypeDiagnostic: CO1PR10MB4450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44505E55124AAA8BE1792FF8E28A9@CO1PR10MB4450.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOgLUaS1k6ZXhS8J+Mo7c8jHg+bQvKmKrHbxRqC8fs6n/UniWV/yb7tzA+5wBMppE7dQKFECzd/gUwek0f60llGV2ES72712+RVTK6fNyf9y3jMRZckVmOZ+B09eEayC2ST9y3e1cPfPbwLs8f+OMW7f0rkHkneNXu4nRmV4T7otEdhYA7WDnkb8rixTl5iZbaUaqSH3TVtZfsuVmv+uP7MOO2iFf7j75oGfVt8kK9acxutxz0x8juxc2X8RLmxgS9QsFo/6tZ8022BnbaPS2B4gV2d0ZIrQjoEXkAa7BM2CnrKkL/UffyU5Rk8Bkka5ulUPa3SpewjjPf2y1Y56LQ+eKB5cwjcKuSqT2zXjZjH41mL6+rAUxKG3KQ4l/UDAe1BuYLzpMCIay39+LAsYrFQlVZAbMjKbglc4U8C1fUmMD4xsoCgM0s0/WJaQsuRizoczHW8SLHa17zUl5GssSeCh79pBZIPH/mSeWWoJLWv+4bQkcz1PznEmcZmdxRHFUbY2o8/rDOKQG2xg/yxff+noRwMfOq9/7I99zg7FA88LVPSf+ax1CcI1R0/l91Zj6wiJJlJKEcdEgM5C+KYaiO+IiLu2zmttKmOKdn3dDBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(136003)(376002)(366004)(83380400001)(478600001)(4326008)(316002)(6916009)(54906003)(66476007)(16576012)(66946007)(66556008)(44832011)(31686004)(53546011)(2906002)(8676002)(8936002)(6486002)(86362001)(52116002)(26005)(36756003)(31696002)(16526019)(186003)(5660300002)(2616005)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WVAvVFVsL05EZWQ5N3FsK0Z2V0ZhOTdYVGJxL0VmcGVTTzk1c3gwNTRhTWR6?=
 =?utf-8?B?VkRSUzBOVEQ4UTg5akQ1cXhBRzF0STFrRWhWMGJQOUd4NERkcTRzM2tmbzdw?=
 =?utf-8?B?V0k5eEdUNnhWUUV5VEd4RG1EU2hwTmZkdmQwNnhaYWdJY2xQTjcvNmlKOXdo?=
 =?utf-8?B?aTM3L1JDcGk0R1Y1WldEQjYwV1J5VEZVSmZsNUxITFZ1cStTK3o1bmdaVWpH?=
 =?utf-8?B?cnJoSitWL1hZRzJiTkRuQlBHT0VYRGZLSk1nb0FkK2xBNGttN2I4OEJxTDVY?=
 =?utf-8?B?bnAwMnVEWmFRQ01NSUpLU1pmR2RFQ0xNOEN4RkQxaFowSVVXS3JCMS9ZcW40?=
 =?utf-8?B?U2tQUmhXTVFueXZaVXgwZytkckNTTC96QjFxQ3o0RS91WHptblRYSFdIcWV0?=
 =?utf-8?B?RzdxTFNFY1g3ZUVJRlhodlNRZXA0T2VaZktaZVhpZmJoMmMxcW0zbnp1ZXgx?=
 =?utf-8?B?Yng4NDA0Y3ZOZlNSUlRzK1llcWZBSEdWQU5FZUlHYkhlQ3k4bmQzbW8yWmp4?=
 =?utf-8?B?Z25rSFNJTVdRLytObzY3dlJhc0ZWaHYwbFQ3UEhxWjZJemJ3ZG5aQUpoWUcr?=
 =?utf-8?B?NTdWY0FVOTI0WVpFdDRhV0JmTlNLTkFkSlAzMS9tUmlVRWh4VTZsMDkwZmJO?=
 =?utf-8?B?UVFCRE4razRZRm9jeTIxOGdGSUtKTGRmcDA1Tll4U2szWHB5a2JLbG56WXNO?=
 =?utf-8?B?OVF1eUVEYTJobVlCR0dFTmlDdzZRN1EzT3JvNjVVQ3FEcWF4RllpLzllMWU1?=
 =?utf-8?B?Sm9oanIvZDVaTmlia0pTUTQ2dEVSTjRpcW52YmV0YWhTdlFGdlI1TnliSlNM?=
 =?utf-8?B?cDhGLzRVbFFQdnVYQU5JT2x3QnRZblB2Y0MvNFU2dWY3SXF4MEFKVEFNUkR2?=
 =?utf-8?B?dDNPbFpDR3VoVzZtcUN3RU5rbUJ1MzBPVmRCYzZIRDVEcVAwMzF2Q2tYd1BO?=
 =?utf-8?B?T2F3Tmc1akVuVXdiT2QwWUs2ZS93WTJKWHBkaVUvZk9obWp2US9sQzFuR29D?=
 =?utf-8?B?K0FNTlh2a2Y3ZnVYMDBpc3FpQTBCd21vcnMrZEZaMGJqRzhKaUZIWHpPWlRp?=
 =?utf-8?B?TzZKbGdNNG14NG5ZZFVST3lUcDVtQW5pbkdMUXdvMmxURkJGV3FxTHp6bzNx?=
 =?utf-8?B?R0JjZlNyd2ZyZEJvMFViU0ZTVGtFUnRidFJHVWNPM3V5NjA5V1RnUkk3OTlS?=
 =?utf-8?B?VTJYeE43Skp6S2NhY2IwTitRODYvVW94MU1iN3BBL0s4ajEwZXNySUNucXgx?=
 =?utf-8?B?UjVvWkZRZi9rUFZ1Y1IyMjNuZzE4QWJPaFFRSlIybCttdXhkcFMySk1lWmJu?=
 =?utf-8?B?QTZ6UnpkOEsxZHY0MzBOc2tSWEdndFM1bzJUSTg2dnNua0FSKzlQZFZXZDJi?=
 =?utf-8?B?amxxRlp2RmR1QmwyWVJjVHB3WXBRa1lYZ3V3N3p5TTgyRHhVRnEyaGlvdlpN?=
 =?utf-8?B?RUJLVU9MZi9vNzJ6aHhPMVJlMFdyNVpMY2VQOWVhMkplam9LMlVVdFZ5dERP?=
 =?utf-8?B?eVI2bUd6TlByWVY0Y0FuNk1tOE5ydXovT2xRSGc5MnJkV0FqRmdocFpSNDRz?=
 =?utf-8?B?VU95blR3SHpCcU9YendRc0VnUkFqbUdoMmZmdlhqdzcydFpyZ01FTEVJaldD?=
 =?utf-8?B?VS91dCt6ZXdPa0QveitiRHdTbnpMYzRYaXlBMzZZWmdBbWZkYkI2QXJNVCtS?=
 =?utf-8?B?ZkFYVFA1L1o1OVBlNUUzSCtjVnNCUTRyaEQxcXlFUmI0NVNyc1RGQ0tLbXJs?=
 =?utf-8?Q?O1NbVi1yQHL2+fkRGQz6vnBFXs9bPGchpU9CR5q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce702b48-7b45-4233-4479-08d8d062f647
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 21:04:33.2882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q23RRWBJgfnxtBwwzPdIpaVkhS+HYsWfrEAUo2r5cFlsMdlV08s/Z/RJ6Ztr7ROgJjkbavX/b2RMxQvImXhJuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102130196
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102130196
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/21 7:44 AM, Zi Yan wrote:
> On 11 Feb 2021, at 18:44, Mike Kravetz wrote:
> 
>> On 2/11/21 12:47 PM, Zi Yan wrote:
>>> On 28 Jan 2021, at 16:53, Mike Kravetz wrote:
>>>> On 1/28/21 10:26 AM, Joao Martins wrote:
>>>>> For a given hugepage backing a VA, there's a rather ineficient
>>>>> loop which is solely responsible for storing subpages in GUP
>>>>> @pages/@vmas array. For each subpage we check whether it's within
>>>>> range or size of @pages and keep increment @pfn_offset and a couple
>>>>> other variables per subpage iteration.
>>>>>
>>>>> Simplify this logic and minimize the cost of each iteration to just
>>>>> store the output page/vma. Instead of incrementing number of @refs
>>>>> iteratively, we do it through pre-calculation of @refs and only
>>>>> with a tight loop for storing pinned subpages/vmas.
>>>>>
>>>>> Additionally, retain existing behaviour with using mem_map_offset()
>>>>> when recording the subpages for configurations that don't have a
>>>>> contiguous mem_map.
>>>>>
>>>>> pinning consequently improves bringing us close to
>>>>> {pin,get}_user_pages_fast:
>>>>>
>>>>>   - 16G with 1G huge page size
>>>>>   gup_test -f /mnt/huge/file -m 16384 -r 30 -L -S -n 512 -w
>>>>>
>>>>> PIN_LONGTERM_BENCHMARK: ~12.8k us -> ~5.8k us
>>>>> PIN_FAST_BENCHMARK: ~3.7k us
>>>>>
>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>> ---
>>>>>  mm/hugetlb.c | 49 ++++++++++++++++++++++++++++---------------------
>>>>>  1 file changed, 28 insertions(+), 21 deletions(-)
>>>>
>>>> Thanks for updating this.
>>>>
>>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>
>>>> I think there still is an open general question about whether we can always
>>>> assume page structs are contiguous for really big pages.  That is outside
>>>
>>> I do not think page structs need to be contiguous, but PFNs within a big page
>>> need to be contiguous, at least based on existing code like mem_map_offset() we have.
>>
>> Thanks for looking Zi,
>> Yes, PFNs need to be contiguous.  Also, as you say page structs do not need
>> to be contiguous.  The issue is that there is code that assumes page structs
>> are contiguous for gigantic pages.  hugetlb code does not make this assumption
>> and does a pfn_to_page() when looping through page structs for gigantic pages.
>>
>> I do not believe this to be a huge issue.  In most cases CONFIG_VIRTUAL_MEM_MAP
>> is defined and struct pages can be accessed contiguously.  I 'think' we could
>> run into problems with CONFIG_SPARSEMEM and without CONFIG_VIRTUAL_MEM_MAP
>> and doing hotplug operations.  However, I still need to look into more.
> 
> Yeah, you are right about this. The combination of CONFIG_SPARSEMEM,
> !CONFIG_SPARSEMEM_VMEMMAP and doing hotplug does cause errors, as simple as
> dynamically reserving gigantic hugetlb pages then freeing them in a system
> with CONFIG_SPARSEMEM_VMEMMAP not set and some hotplug memory.
> 
> Here are the steps to reproduce:
> 0. Configure a kernel with CONFIG_SPARSEMEM_VMEMMAP not set.
> 1. Create a VM using qemu with “-m size=8g,slots=16,maxmem=16g” to enable hotplug.
> 2. After boot the machine, add large enough memory using
>    “object_add memory-backend-ram,id=mem1,size=7g” and
>    “device_add pc-dimm,id=dimm1,memdev=mem1”.
> 3. In the guest OS, online all hot-plugged memory. My VM has 128MB memory block size.
> If you have larger memory block size, I think you will need to plug in more memory.
> 4. Reserve gigantic hugetlb pages so that hot-plugged memory will be used. I reserved
> 12GB, like “echo 12 | sudo tee /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages”.
> 5. Free all hugetlb gigantic pages,
> “echo 0 | sudo tee /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages”.
> 6. You will get “BUG: Bad page state in process …” errors.
> 
> The patch below can fix the error, but I suspect there might be other places missing
> the necessary mem_map_next() too.
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4bdb58ab14cb..aae99c6984f3 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1319,7 +1319,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>         h->nr_huge_pages--;
>         h->nr_huge_pages_node[page_to_nid(page)]--;
>         for (i = 0; i < pages_per_huge_page(h); i++) {
> -               page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
> +               struct page *subpage = mem_map_next(subpage, page, i);
> +               subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
>                                 1 << PG_referenced | 1 << PG_dirty |
>                                 1 << PG_active | 1 << PG_private |
>                                 1 << PG_writeback);
> 
> 
> —
> Best Regards,
> Yan Zi

Thanks for confirming my suspicions Zi!

I thought hugetlb code always handled this situation, but was obviously
incorrect.

Perhaps the bigger issue is the GUP code which has the same problem as
suspected by Joao when we were discussing the first version of this patch.
It also is going traverse the list of page structs with page++.  I'll
point the people on that original thread to your findings here.
-- 
Mike Kravetz
