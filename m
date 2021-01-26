Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1824E305317
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhA0DN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:13:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40728 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395431AbhAZTWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:22:32 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QJ3uup151222;
        Tue, 26 Jan 2021 19:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3dROXshz7IPV9BLu5xu9ODaiij0jO5lNufRlVhmdNTQ=;
 b=Oiljnj8lpOojJJTpxLI/CsuicVNqXre1sfynQcYcdVuj9ndaM5ZvoJOA/1ZV1VASDth3
 iOaOSZq9H8Pe+aleJLBedfAlL+i+aw/Jf8G+WaDgn5RCT1282bvksLWlRe8MDBjG3GIO
 OzYCPQ757Bzkrj74FE/JBjUbVg8jGtKQUbic5UtN/db/Pru94IznjzL5CBKRV1YxQabq
 vfn8sUVPttZipy4Sa2e5cHnCbAMFjbldKbD5/JVUL2wqv5FVQuSUfOUudX0ysalGPrxp
 rXAUHc0bY/j0IrivOTLHphH57Awp5toHJ8Dh05t3sHaE34fv8YWwrcFMlEFeao47gsnf Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 368b7qupsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 19:21:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QJ09gk196534;
        Tue, 26 Jan 2021 19:21:46 GMT
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2050.outbound.protection.outlook.com [104.47.45.50])
        by userp3030.oracle.com with ESMTP id 368wqwur5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 19:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrIn7PL63eV4KDAKthwoQkqMUiH2dGGgll8dbl53pXemoNpCEqttLskvztE1+cjMNf+EUuOmC/MnBdxMEcclDuIz07S2V68MdaCbmKaWGzuEwMXtl6oQ/Z0SvACrJ+K265JtGFlBHYYQ69zvwhm8MUVrwkVQ3XwvbQ57JN/UmiLU4tGcGnO+knGlAe+GZg+wSqr8fDaiDw10uADDWNQ95cU/5i6p961b2U8oRiiDLi+xihdPvCywyWYtUUF18Bu1/PbT95BMkj6qDzcSejPpc04957ON+ls5C/C2IMSsnjAWB55PjzrX0kaiMbaDZg/vn9c+6FKM6wQUkDUHhCT5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dROXshz7IPV9BLu5xu9ODaiij0jO5lNufRlVhmdNTQ=;
 b=oDj50GnBiDf0oQvNS8ovjvdIuNWiFyEkfivQPvLgYACV6GRfLRvR9PRar45cYN3PB9nmuyRhr5+6E/zBwU7MywEM9iQl1jQS7Y8IDLMl/SOTQcf60lLkOHFkXcfRQuxJnSbe7h+NIxADgxLUh0oKsOzTgH/uH70TGE95KSspoONyABL9yKZeWFHRNbBtGsY85JRQtazkLWsDq+6yLsDun97uaSY7P37SpxzMLQ3yV+sVjgTCE7+qwlQJEloIhGz1x+YWsiNEYZ/nGvtmzUJJHCfVbVsI9/mDdhBXh6z9AimEhtv0l5svFT8axpuvhLy00wDtYlaItNUM8ENT3d4YWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dROXshz7IPV9BLu5xu9ODaiij0jO5lNufRlVhmdNTQ=;
 b=s8gmy7hKCjKCDEdSlbygnYIDqO5e+nBZYIXu4n4cLnI8+spQ7l8DpBaovQOe0s6jRWg702o4e3ayfNoqVGSFUoFfvYaBqyKLdO5FuFV7cbBqDT46yszHXbWVmrKjxH91fXCktElG8XQ0c8+4ryh4mdtj8BdKHRYCG2vpGZ+Pz3g=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4592.namprd10.prod.outlook.com (2603:10b6:a03:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 26 Jan
 2021 19:21:44 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%6]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 19:21:44 +0000
Subject: Re: [PATCH 2/2] mm/hugetlb: refactor subpage recording
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
 <20210125205744.10203-3-joao.m.martins@oracle.com>
 <3d34111f-8365-ab95-af11-aaf4825204be@oracle.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <1ae0313d-de9b-4553-1f68-04c4f5a3f7eb@oracle.com>
Date:   Tue, 26 Jan 2021 19:21:37 +0000
In-Reply-To: <3d34111f-8365-ab95-af11-aaf4825204be@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO3P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::18) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO3P123CA0013.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ba::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Tue, 26 Jan 2021 19:21:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c965eada-d9fe-4c78-62c4-08d8c22f9ddf
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4592A537404A31F947E3DFD4BBBC9@SJ0PR10MB4592.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xfzkp1LKivNcoKrytJl48GKES9+7KHfe8yfmzi2Hn75dlevK5Rkuv49ZwCYVGb1APXKswNCeT7GQnfzfhSI8q6MMoy0dEGqyjN9HgI6xXeH5M+rQkl5wwz60NEXG19Dn/pvD7zJQrNduRopnHJZvvtqtWV89JMejRbfx7j2PqM2UekWS7OiTm0hRXOBRiZW4F+NQP/gksGJ5KvYh1qE1cF3R2Fi+uIMYfLld9tKMnlIVrK1iG1zg+Zw9d4ppoLWGMo549j91WKmmPmctFu3P+05nr7rtuehizppdrfkHz9sHN8Fdz+WCGhJUR/J7Ol4JCEtxa1KRGKAcsnmhJsaGnCFCyzoZNJqBqU68tDVvmPX7dwmC9tkNbLIn0igu8sR84oNi4ID2V4fpbdEqLME1yTh58ZTz+oPaFNij1US/L9KzlG0lVoyGrKM0rYYdO98S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(36756003)(26005)(31696002)(53546011)(2616005)(16576012)(66476007)(4326008)(2906002)(66556008)(6486002)(66946007)(31686004)(316002)(956004)(83380400001)(8676002)(5660300002)(16526019)(186003)(86362001)(8936002)(6666004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QmExTUZWWmJseUg2V2FMUUZnVytYWGpEUG9QaFhtb0c1aHMrSmduY1FZa1lk?=
 =?utf-8?B?UytRamdvUG1JUWhUNG9OUnBLRHZkMzQ5d2lIb3VhSHVRdTNnOXhDSU9aRE02?=
 =?utf-8?B?cGJYbWtSUzRROVlxTUVGWVhtZEVyUHg0S2lOdCtITHBHeWRjWFRSemRQMDY2?=
 =?utf-8?B?a2N2MFNGNjYxK3FvTWZzZkl3ajh1TVdvNGl4MUNZUkYyd1ZXRDZLMndjSnA4?=
 =?utf-8?B?dSt4SE5Ob2VKenovb01rMnpheE5aM3RhSW41UjhJV3ljbCtqRGJXL0Uyci9Z?=
 =?utf-8?B?THlvYWo5dU9CekpHdjR3Nnp2dHBtamVadjRONm9rb29LQXlZaFljbUNibzlr?=
 =?utf-8?B?OGQvSnhiaFJQaHYwQXMyVzNYQUFDTy9SQWZ2TGZtU0FQazdrZC9pbWd5cnRl?=
 =?utf-8?B?SUt4cTZLS1lxODZ6L1FBQmtlOGZCd09DVVB0RTZNSWR1QW02UDRFVlVmUzVR?=
 =?utf-8?B?bnpUVC9sQ2NERExHM1htM3NFVm1wWVpNNjdVTEo2YXhxd0hMZWJqNG0xNnNX?=
 =?utf-8?B?VElxRXdkOHBJQ1NCK0JWMVpTdGlLL085dXQzOS9aV1BzMXZVMmFmREdxSDhH?=
 =?utf-8?B?clEzL0t2dHl3Q0JMTGVyOUFaRjJiWGVrc3U1NVdwRm51NFZ2Q2lNT0hBMDlw?=
 =?utf-8?B?eW5VV2J0Q0xHaDJMZVRjZXZJQWJ3Z3dTbkZlV1hYTTdpR1FrazdRSFhVd1Ni?=
 =?utf-8?B?SksvZTZFR0xuS3pSRGczQzZBRHJTd0F4M2dtb2NqVVJIR2JnUHVvSHJPaHNQ?=
 =?utf-8?B?M3QwbFdPL3F1WmE4TCtYNjNQS3lBUjNZR1Izd2k4MTJYSGh4RkNhY1dENkU0?=
 =?utf-8?B?K29zaWtnZldaYzlyZDZZK2Q4dFdjMjlJdVl3d3NJbUZYK1BDdU1RWW9RVVVS?=
 =?utf-8?B?Vkd1TmJBQzFMcm5Tbjd4Vk5Kb3JTcWNGUkFQa3Q1cHJtQ3BJOVBoZU15Y2Mr?=
 =?utf-8?B?Wmk0aEFWdUg0aStRdUZXa0RSd0c0UWRPanlPVkdMMWZOWURoM1Y5aCtjek9R?=
 =?utf-8?B?cFJpd2FmNnNwSmJaVFNnSFJEa3pZNFA1RlhVemNodi9oajVobEFjOWFXVXQx?=
 =?utf-8?B?Z2NTc1Q1WXEyaTBidHBxa2FCSzRiWk9UTTlNb0pycU9heGlPK3VHSTdrUkt4?=
 =?utf-8?B?Z2xUUlI3MnptQnJMSllTaEtjUlo4bTIvVGttZVk0MjhOdTN5R0pkMWRhVXlX?=
 =?utf-8?B?WXIxSDhNVVluTnEyeXFEUGNqNkhQOUxhajlWV1VrUG1kYjVPNloxK1RvQ0ZE?=
 =?utf-8?B?VngvMXY5NEpBajVLVHk2YzAvNmhDWDdOZXBvUFVWKys3aUdRbjBoSHhHTktN?=
 =?utf-8?B?OHcxZDF0Wjg0NVlLc2xtQ3dYbVRpMzIxQ3crQzFHRWtBUE54cHhmcVQrQkwz?=
 =?utf-8?B?UmNaTkRGd0lHaWk1bDZKZk1FVFR6SnZZUCtNWWp4NjNWSkNDejRlRzFpM0FV?=
 =?utf-8?Q?nHpqGiiK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c965eada-d9fe-4c78-62c4-08d8c22f9ddf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 19:21:44.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGRn1PHHF8eFj3v80dgy1l/mpxlj/edu6UsLSVFCsip7huRgjPWmCOpZHlUneahCYpOsn5mvGquGAX2lNVzfI+FLVtkEn6SNxoeWbwRPUZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4592
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260098
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 6:08 PM, Mike Kravetz wrote:
> On 1/25/21 12:57 PM, Joao Martins wrote:
>> For a given hugepage backing a VA, there's a rather ineficient
>> loop which is solely responsible for storing subpages in the passed
>> pages/vmas array. For each subpage we check whether it's within
>> range or size of @pages and keep incrementing @pfn_offset and a couple
>> other variables per subpage iteration.
>>
>> Simplify this logic and minimize ops per iteration to just
>> store the output page/vma. Instead of incrementing number of @refs
>> iteratively, we do it through a precalculation of @refs and having
>> only a tight loop for storing pinned subpages/vmas.
>>
>> pinning consequently improves considerably, bringing us close to
>> {pin,get}_user_pages_fast:
>>
>>  - 16G with 1G huge page size
>>  gup_test -f /mnt/huge/file -m 16384 -r 10 -L -S -n 512 -w
>>
>>  PIN_LONGTERM_BENCHMARK: ~11k us -> ~4400 us
>>  PIN_FAST_BENCHMARK: ~3700 us
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  mm/hugetlb.c | 49 ++++++++++++++++++++++++++++---------------------
>>  1 file changed, 28 insertions(+), 21 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 016addc8e413..1f7a95bc7c87 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -4789,6 +4789,20 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>>  	goto out;
>>  }
>>  
>> +static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
>> +				 int refs, struct page **pages,
>> +				 struct vm_area_struct **vmas)
>> +{
>> +	int nr;
>> +
>> +	for (nr = 0; nr < refs; nr++) {
>> +		if (likely(pages))
>> +			pages[nr] = page++;
>> +		if (vmas)
>> +			vmas[nr] = vma;
>> +	}
>> +}
>> +
>>  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>>  			 struct page **pages, struct vm_area_struct **vmas,
>>  			 unsigned long *position, unsigned long *nr_pages,
>> @@ -4918,28 +4932,16 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>>  			continue;
>>  		}
>>  
>> -		refs = 0;
>> +		refs = min3(pages_per_huge_page(h) - pfn_offset,
>> +			    (vma->vm_end - vaddr) >> PAGE_SHIFT, remainder);
>>  
>> -same_page:
>> -		if (pages)
>> -			pages[i] = mem_map_offset(page, pfn_offset);
>> +		if (pages || vmas)
>> +			record_subpages_vmas(mem_map_offset(page, pfn_offset),
> 
> The assumption made here is that mem_map is contiguous for the range of
> pages in the hugetlb page.  I do not believe you can make this assumption
> for (gigantic) hugetlb pages which are > MAX_ORDER_NR_PAGES.  For example,
> 

That would mean get_user_pages_fast() and put_user_pages_fast() are broken for anything
handling PUDs or above? See record_subpages() in gup_huge_pud() or even gup_huge_pgd().
It's using the same page++.

This adjustment below probably is what you're trying to suggest.

Also, nth_page() is slightly more expensive and so the numbers above change from ~4.4k
usecs to ~7.8k usecs.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1f7a95bc7c87..cf66f8c2f92a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4789,15 +4789,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
        goto out;
 }

-static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
+static void record_subpages_vmas(struct page *page, unsigned long pfn_offset,
+                                struct vm_area_struct *vma,
                                 int refs, struct page **pages,
                                 struct vm_area_struct **vmas)
 {
-       int nr;
+       unsigned long nr;

        for (nr = 0; nr < refs; nr++) {
                if (likely(pages))
-                       pages[nr] = page++;
+                       pages[nr] = mem_map_offset(page, pfn_offset + nr);
                if (vmas)
                        vmas[nr] = vma;
        }
@@ -4936,8 +4937,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct
*vma,
                            (vma->vm_end - vaddr) >> PAGE_SHIFT, remainder);

                if (pages || vmas)
-                       record_subpages_vmas(mem_map_offset(page, pfn_offset),
-                                            vma, refs,
+                       record_subpages_vmas(page, pfn_offset, vma, refs,
                                             likely(pages) ? pages + i : NULL,
                                             vmas ? vmas + i : NULL);
