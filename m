Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271D0305238
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbhA0DeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:34:19 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52362 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbhAZVWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:22:46 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QKx8bG002009;
        Tue, 26 Jan 2021 21:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qMovRLvsEbQMKNnlWCpGhmTNaNVQmq2V7I+/XFp8+kg=;
 b=b7GD99cTatzd6UqaW4FTVqayA8yKf1fYrhSfCckvbXMbHitdpKt2Mu0U9EOXjiuY7ESE
 YqKn9PYThs+9KhbdVz+JkgRiMdIvdsQvkIgGRm3zbM1Po0CmFxNlooesKl9xDNtsyx6v
 7ptKeUFT3ypRafp6tPLNfXlXHr23ACwne0ZeZtlP42i3gYLIMqsUt4VMnikUQq+RW0kE
 vPVWOOjAxVDfsB7nq4coAJtdffwNvnXVNnlwfobbXOUh9YVxF81hJYPuDRZ/fQ0gl5AZ
 qEf/0IjXPH/RH5Kh+/CeX0YZXxNyo7pmujo0Pp0BD7pBmZtFcPBI4cDyIFrxH973Sqnq NA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 3689aamah1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 21:21:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QL14e7195014;
        Tue, 26 Jan 2021 21:21:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3030.oracle.com with ESMTP id 368wcnetuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 21:21:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjeiyqYze+MF7g5J1yg5m1JfxS0v6MBHXXr93u7bgPLqdmpo15kk+1IkDSnKiAkG0lcAFHXA2L2cMtc4LpJX1ptPRIuZ3R9oUKkxOKtkQevAUOjY9GhG96qYz78wwbLTJuoTytxlu3jomVrh1LP4GMetNjHFko1OWspHErRbNqd93t8xOfr/+rlExxC5YitIGDFbm8zqgyi9Y87cZECIisAHwX4n70RyfqzUvnc3XvnNrHS1RCG3MZMHmBfqFFnsO0mfSzncO/rzrYNBzJY0qkTrsWt6B4wO9uiZEhhT1Bd8JP06ayxjLSN8FGgdYgTA2NDDjSmMKQmudQW554uhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMovRLvsEbQMKNnlWCpGhmTNaNVQmq2V7I+/XFp8+kg=;
 b=R5yjiGAUz/CKOhm1OvhEzv+i1JXmyaOs83u11k3wtFjcSeb0Gk/c3cSzFrxdyrBj4eF0BkxDzMRlaN9n7jd41PjiCgDdeSa3ckrybW6MxquaF3N/VuxQHWTDAx2kQwv6ussBbwPePhC9EkyGj1GQ7eIGgTwBFGSe6BkK16uCYr6iRc6GqA8WbGq+kjt9hIHHeiaZaZnIZljSrpS4FeoHGEqKcwgk2pxPfP1XhdzB2vQMa8zV/14En04pPAdPOuSW+73Oq/vpo4Og8k4+nvZv2xW4b+Wx0zCQqjvWKuF0NTpD8h795jZ/idUVNSBW0vZuL9m3UZ3PARqw90oFcArDoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMovRLvsEbQMKNnlWCpGhmTNaNVQmq2V7I+/XFp8+kg=;
 b=CoGIpcYjNo3s1RMSumhpP0eGrIwNyl7MKFafsgeo3azVj6fnp4wFsWleDBYOXxMzXELTsRmnoQVzYkUUQfv9vtW3zVCBS9EDkrRBkit/g11DxJmKkFl9Pp0ZcrxGIioeaBp/RdrWIahEaPGFg9qJS81ZGrqH9mVhi12VpIvP0Eo=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1807.namprd10.prod.outlook.com (2603:10b6:300:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 26 Jan
 2021 21:21:48 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 21:21:48 +0000
Subject: Re: [PATCH 2/2] mm/hugetlb: refactor subpage recording
To:     Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
 <20210125205744.10203-3-joao.m.martins@oracle.com>
 <3d34111f-8365-ab95-af11-aaf4825204be@oracle.com>
 <1ae0313d-de9b-4553-1f68-04c4f5a3f7eb@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4d3914e9-f448-8a86-9fc6-e71cec581115@oracle.com>
Date:   Tue, 26 Jan 2021 13:21:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <1ae0313d-de9b-4553-1f68-04c4f5a3f7eb@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1701CA0021.namprd17.prod.outlook.com
 (2603:10b6:301:14::31) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1701CA0021.namprd17.prod.outlook.com (2603:10b6:301:14::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 21:21:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5278683-ecc0-4048-d623-08d8c240639c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1807EFF4E1724912E561079BE2BC9@MWHPR10MB1807.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBwa3CSnUQHAEsOxTy9QHgOd3G7FlhH8IB461sXuYZQGjxVggvItKq2GvSg3m5+F2mtM/Eh3pVsZUUHTKZcIx26LzeN0PTEbxJzt9uoHZgraszFbyBEIvOYkfezgirRDMVaURyvLsRfEGP4Z/bcvyXCfTHUte1G7iQokTcIHiZP1egtmnTuYD8CY9o1DUW3sZULUAcZ79Ga2v6hdqiRMegPBApmPS7qLGKTOg1aNVJUXU6o8ydCXMfCFjKMkslPbyFSmBcwgz39xZP8bHpUaHeAgObp3HJqevV5CWi7T0mbaxIgLCTiGpf9/iEOuGu0ylUmmC0jo3UJddx+c4BoqOuEfLqf7T5MyB7G5V6lxgJdheb+PT4ZLF0PYdafb8qqyfV24EhkuMNS9FQyiWigwbP5FGUEuFRLnT8gbH/Hydr+Q2wwYMGZ1cZSMWGwl61hOYV7dJjNr4IYOzLpQ3wumWVDk+hW1WCn7kYJxHSQUd4SbEjoQfk6/wBE80jZHCQIQzybL04lhLQryJ5W27UyFkv62C1dN8/vSeWFnU/wek/toHwFbmXbO02+2qXUlI6eGKhbi8Iyvo6FZA9skm7YhoMfa51KNZZgeOpq3On2iXDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(346002)(366004)(31696002)(66946007)(53546011)(66476007)(66556008)(8936002)(86362001)(16576012)(4326008)(31686004)(52116002)(16526019)(186003)(54906003)(8676002)(2616005)(44832011)(956004)(36756003)(83380400001)(26005)(2906002)(478600001)(316002)(5660300002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Mzd1VTEwV0xsQ2dyQlBNMU1EOGR0OUs5THBZZnFZVHh0S0lLbEVCZnErdHNa?=
 =?utf-8?B?VUMvYXpzOHZiYTNzK09sTnE2MmZtMG1nTExhMVY5bmxKM1lLZTliVzJWYVVu?=
 =?utf-8?B?UHR2YklNRzdHeThsSXJ0RkVpL1RsdnJ5V1F1Q0VtNkwxdUpjMnJUc0R5UDhz?=
 =?utf-8?B?Nlg5YW4yQytWeFBPSUFyM1ZVQXN1SDk3aDVmdytLR1BSYWM5QWNwWXBwVm80?=
 =?utf-8?B?a2NpdGFLa2E3dDhGa1FVQVFkZHlIc0tLM3RiNGQ0akJjTjNTYkJnT0IyajA5?=
 =?utf-8?B?cnF0dWx4WFVhWHdZclZQM2ZxbTZwUHdtWXpkVDBxM054S3RPQVVqdnF3L09F?=
 =?utf-8?B?NWk1MEUvcE1RRXZ5QmVsa0phQXJ5dTh0Qmh2Nkt1bm8wOHpVc05LaUM0R0xU?=
 =?utf-8?B?RWV4V3VHUGQxd2pJYU50V0JkUGErZFFtZzdEeWYwMFV1Z3oxODBVR2VvRlpO?=
 =?utf-8?B?YlhKSWVzWDlRTlY3Y0lIa3dIZURvYXVxQnNuTlhXdnJ2VzdndkV6QzBxbCt1?=
 =?utf-8?B?aFdvWitTZWlpWVplSW51R2pkWjNNRUxvYkNVcnVaZEhML2NadGdLQmpFTHE3?=
 =?utf-8?B?TDJOOHRnQ08xcE9GR1pGTzh5elZadnEwb2tYTTNZdWhMVEhCNGlrRGd4cVhl?=
 =?utf-8?B?bHVobEZDSVF3UWM2aVRySExZNU1Bb0ZhdGxLRHlIMTIyRjFZaFlSRlFzZGFz?=
 =?utf-8?B?SGY3Z05UdnpJeFh2eDZKWHpjcGRHeDlObXQ1TFVCTHRCek53Uys5S2FHVExY?=
 =?utf-8?B?ODE3SkpyejhDWCtRWC9ONjFibk9sMk45SFhDajgxcWdZRU1WblBpTkZJa2FF?=
 =?utf-8?B?dVJkZkorRGhyOGgxbG5WZDRtOEM5VVBKV1Q4NnBBSmdoaW5BWnlmcjFoQzJV?=
 =?utf-8?B?Q05yRG9IRjJTVVlEV3p3WW5MOWRBblN4MGlGYll4UHMvb1k4V1dZU3JPVEQv?=
 =?utf-8?B?ZW9vZXRDcW5ZQ2VMeFlSZHZjcGRaOTVlNVFENnJOaktoU0RGWlJhVFdDK1BW?=
 =?utf-8?B?WDhRZWRYNjVKakx4WmNxV2lRNVhmUDVoT2xjTVBKQktKUVhGcXdXb3RRbzN5?=
 =?utf-8?B?cjZlVjlYRjdpT2hEODVSVllIazFFTG5GSkpiRThGQ3VIeEhuWTYwMURVbGhF?=
 =?utf-8?B?UUFaeHh0NzVZbHhYQldBU0dpUVorUlpPdGJGTi90dnEzaVZseHNhVERucUhv?=
 =?utf-8?B?bXE4T3V3dVd0VzhiUkg0L2l5RWNhSGVVa2J1SE1PWEVBZHhJWHdyNWRYSmI4?=
 =?utf-8?B?MXdaeEpJNWtsek9LWnZJT0R0dWtJNUJSN0tpak1naURna2Q5WVkweE1aRHdu?=
 =?utf-8?B?YUpIRk95b2JkSUt1OGVSWjlGVWxCNjJDSEJnSW1CNHRvRlBjWGQySWplaXhC?=
 =?utf-8?B?NGkwM21UMXFvb2lQa2ZEKzlzMGc1bUlGeWc4MmxmSEhNVEJTTzAzR2VSVXNj?=
 =?utf-8?Q?TpHLA9xD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5278683-ecc0-4048-d623-08d8c240639c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 21:21:47.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hoFPCLH7SA6Edqz+8l37AwikyR97FSqB/JkbADSYUjtUTwlBtqEKpOGr9E946MNAqnq5iONCGtX1JGTJMwZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1807
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 11:21 AM, Joao Martins wrote:
> On 1/26/21 6:08 PM, Mike Kravetz wrote:
>> On 1/25/21 12:57 PM, Joao Martins wrote:
>>> 
>>> +static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
>>> +				 int refs, struct page **pages,
>>> +				 struct vm_area_struct **vmas)
>>> +{
>>> +	int nr;
>>> +
>>> +	for (nr = 0; nr < refs; nr++) {
>>> +		if (likely(pages))
>>> +			pages[nr] = page++;
>>> +		if (vmas)
>>> +			vmas[nr] = vma;
>>> +	}
>>> +}
>>> +
>>>  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>>>  			 struct page **pages, struct vm_area_struct **vmas,
>>>  			 unsigned long *position, unsigned long *nr_pages,
>>> @@ -4918,28 +4932,16 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>>>  			continue;
>>>  		}
>>>  
>>> -		refs = 0;
>>> +		refs = min3(pages_per_huge_page(h) - pfn_offset,
>>> +			    (vma->vm_end - vaddr) >> PAGE_SHIFT, remainder);
>>>  
>>> -same_page:
>>> -		if (pages)
>>> -			pages[i] = mem_map_offset(page, pfn_offset);
>>> +		if (pages || vmas)
>>> +			record_subpages_vmas(mem_map_offset(page, pfn_offset),
>>
>> The assumption made here is that mem_map is contiguous for the range of
>> pages in the hugetlb page.  I do not believe you can make this assumption
>> for (gigantic) hugetlb pages which are > MAX_ORDER_NR_PAGES.  For example,
>>

Thinking about this a bit more ...

mem_map can be accessed contiguously if we have a virtual memmap.  Correct?
I suspect virtual memmap may be the most common configuration today.  However,
it seems we do need to handle other configurations.

> That would mean get_user_pages_fast() and put_user_pages_fast() are broken for anything
> handling PUDs or above? See record_subpages() in gup_huge_pud() or even gup_huge_pgd().
> It's using the same page++.

Yes, I believe those would also have the issue.
Cc: John and Jason as they have spent a significant amount of time in gup
code recently.  There may be something that makes that code safe?

> This adjustment below probably is what you're trying to suggest.
> 
> Also, nth_page() is slightly more expensive and so the numbers above change from ~4.4k
> usecs to ~7.8k usecs.

If my thoughts about virtual memmap are correct, then could we simply have
a !vmemmap version of mem_map_offset (or similar routine) to avoid overhead?

-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1f7a95bc7c87..cf66f8c2f92a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4789,15 +4789,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>         goto out;
>  }
> 
> -static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
> +static void record_subpages_vmas(struct page *page, unsigned long pfn_offset,
> +                                struct vm_area_struct *vma,
>                                  int refs, struct page **pages,
>                                  struct vm_area_struct **vmas)
>  {
> -       int nr;
> +       unsigned long nr;
> 
>         for (nr = 0; nr < refs; nr++) {
>                 if (likely(pages))
> -                       pages[nr] = page++;
> +                       pages[nr] = mem_map_offset(page, pfn_offset + nr);
>                 if (vmas)
>                         vmas[nr] = vma;
>         }
> @@ -4936,8 +4937,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct
> *vma,
>                             (vma->vm_end - vaddr) >> PAGE_SHIFT, remainder);
> 
>                 if (pages || vmas)
> -                       record_subpages_vmas(mem_map_offset(page, pfn_offset),
> -                                            vma, refs,
> +                       record_subpages_vmas(page, pfn_offset, vma, refs,
>                                              likely(pages) ? pages + i : NULL,
>                                              vmas ? vmas + i : NULL);
> 
