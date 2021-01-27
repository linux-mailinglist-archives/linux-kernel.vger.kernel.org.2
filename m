Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51C3305071
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbhA0EJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:09:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39510 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbhA0DsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:48:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10R1wx71135900;
        Wed, 27 Jan 2021 01:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vvqrYOIqH5WgTWI58vV0mRLFptFplnbY1sydeHlRN64=;
 b=WOvG2nmRE6SL7161kuvKsGmZpebIYmBr3RVmb/hj3xC2t1HyN8GzIwPxpcs0X/n+5w+H
 KpfGHLlIdeRs9Yw6CySxLSEHdoF0K6dudg+EU7HYyuWSQfr2MN7+O01MlQ3X1Wc+lpZc
 bsebGJVaPx6w6tDTp1CJ/MA+dtNFzjCYjbJCfbUJbi2peDQeBK4+aZU0b/R4QZvTtq/5
 o2hvs7PwWVYjeHrja59THVPRBEza1dCeGwd+FaqTDL1juJj5FhjQAUCSEEl+w7fB6gZm
 cSzVDo1xmn1btKFJSPjTI65tEuFx8XBagZpNPxCb0CeULa+gSTWMPFEBSSWrdGOmZMjH kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 368brkmr5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 01:58:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10R1o7jJ006036;
        Wed, 27 Jan 2021 01:58:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3030.oracle.com with ESMTP id 368wqx70sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 01:58:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHq/q/SuN75wjBj3sl7z9j2w/3qZFAhx4eKH1rjl3w2Y19NuIcYJ8DdOX4KmFXYLo4yaQEBL2vAxLQfTaTmy7CK3nxTnnpi9JdGwCFxDN+XQjPav0gMu8reMiOEsGUpEous86/tWmyEtAo9OIMf4nF0IsJWVexvNQ9NIsUXnyEoTo/Lg7zXDmWANV4nByNNfU5iXKXzntiSavVxNSigkYUgIn+Dy7za9RuWsBxIBxDNNbCDJZSxi9TgBQWD5ek8GMxaRFHVZoSKPwQXLfkcpPQ7d89oVRW23QXqz9lPXD4rPwbNsbNuJGRYu6IiA/WC9acDJc8JgbhfheltrlKha7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvqrYOIqH5WgTWI58vV0mRLFptFplnbY1sydeHlRN64=;
 b=GWi9HYAA1Ndt0dlXFNPAgCUly7cgRjpfHXD+8r0fpGV8usYBGGa6udT6bVctVRSY0HEWE52Ag/w0RrtvZUbSjj3/cie9q3GdJCeCdtrsnZ2RfqLVJuM/bPcSTfHF2h8xZbcdCZTvYKeFiXaW4uC4NusAuo7TJ6l3TxiLf/AZ61LWQUdjnnQov0tPGKwnq9KpvKZSjJb1wk4aBfV9HByrxrkdVaDMv+i5ywgKclcJ7HOPIYMde9in7HiKdgfKgady4RnVej7FGLkllwmF7WdAXKAAgLe8xISoOoxzT/dc0bDs8LzfkGGpO2XJmiEMlQB5IIn96n1KlWGCXGo4HQAm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvqrYOIqH5WgTWI58vV0mRLFptFplnbY1sydeHlRN64=;
 b=w5BtwBf2sLm0xlRVfvcWIaW63xN3EmMxrU2MkX/JBJRLSI2YOcD4F4zYKfL+QjyyRKq+nGKeXPmeVNmlvQXaNeW4y31XWMtW4j72bYk/75hJuG3qKcO1iNsaGNC7pcZC57iXBSrDZWCVoKiqUMKEpQSdeJW/o4mVR3EWK/zMO2c=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2288.namprd10.prod.outlook.com (2603:10b6:301:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 01:58:55 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 01:58:55 +0000
Subject: Re: [PATCH 2/2] mm/hugetlb: refactor subpage recording
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
 <20210125205744.10203-3-joao.m.martins@oracle.com>
 <3d34111f-8365-ab95-af11-aaf4825204be@oracle.com>
 <1ae0313d-de9b-4553-1f68-04c4f5a3f7eb@oracle.com>
 <4d3914e9-f448-8a86-9fc6-e71cec581115@oracle.com>
 <20210127000730.GB4605@ziepe.ca>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f1fc1543-72fa-44f2-50fc-0220abfdc484@oracle.com>
Date:   Tue, 26 Jan 2021 17:58:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210127000730.GB4605@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1401CA0008.namprd14.prod.outlook.com
 (2603:10b6:301:4b::18) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1401CA0008.namprd14.prod.outlook.com (2603:10b6:301:4b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 01:58:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0294718a-cd38-4303-ccf3-08d8c2671a2f
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2288D5592E01D29D3D5ABB58E2BB9@MWHPR1001MB2288.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g69NTXJofUfNf3Kq5CZLS/hHTmZ3HPZUIEqhGNsSDHY2z+qPs02WxopTFMuzhDOVpWW8PjJ5HQOZPbckhCCD79zJSLKTI7RYu4DCDEfhigO5X/VUDTLb8qrlcy7xbOEMihmH2XKOZPBXr2CFluRLNGRanDWaInby2zWKYcLwocXu3fI0kQDTGa6tKbQB7OU5sKS5nwlSwZWCN6zSbNbm6pu5ZNjsmKwrQKwQssjTW/Y05X5ZFiRwdCzQT7u/ndQi3CoFrPNh3RoUh9hhhqilf1HIxnEALK6HIwHQb0c9iKVceH3iUvu1I9KzbOtfU0GTtGb5b0BrPnn6Q2/WJB/4Fq4GfT/Vn6S5gkwgyhm8geJU9mVpD1egorPFK3TQMDABgcOUZDk3iM1JfhaA8ntFnINPD3FC6ydPmGlXMt1Elg47PeYasufG2YuZs2m5wNb7Ws9PmSoWXdCB9J2ZHiBBlYMygLcdbc0l2iKVSafkIj0l5YmIbN1B9FrlngsBRNeCnWzDVPpL13Q08/71kyDkCoM8UWFhMbEMnnRwgerpLKyhqWmYm6bg0hd9htHs2BoyKKmH9gsn3UNrMy63lnQSLtV6VI+/6tKtOJyDvtCQXf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(396003)(376002)(346002)(110136005)(6486002)(44832011)(16576012)(66476007)(956004)(31686004)(83380400001)(26005)(478600001)(2616005)(186003)(66946007)(36756003)(8936002)(31696002)(8676002)(52116002)(316002)(4326008)(54906003)(86362001)(16526019)(66556008)(2906002)(53546011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?blpUV3VwWkEyOHBxUGg0eUgwQ0IwNHdlalFZeDZxOEZqQyswSUcrWnZnL0lk?=
 =?utf-8?B?RnJQWUNwOVk0U3AyU0FoTW8zZGUzNDRvN3EyWTduSExwNU8vSW12OGRnZkVm?=
 =?utf-8?B?djlEejFUdUhHaHhZRFVKekMwMVJpT1FjejRNVWRxSXBDVnNjYzdOVUJmV1F6?=
 =?utf-8?B?MzJkNDJqaEYrb2xESHV3SDZnMkpwd3VQcGNNQ2dKUHpKOUxXdU9vK0hGUTdK?=
 =?utf-8?B?eWxYVS95MHN5S2RBblBDbWZUZzFaTmJjTFBWdW1pVzVuTUFGN1RUUUZzN2Mr?=
 =?utf-8?B?L0VGbTY0WUJDRDNhRnMreEppdGthNW1rclQyTW0wbTM0WW5JYnExRjdsZDdu?=
 =?utf-8?B?RjdRTlJJcFQ2cDlDS05mWHNGTE1qbzVZeityMmw5cU53ZzJqSjRQa1IzUGwz?=
 =?utf-8?B?a2JZYytSZWRsZlAzeStqR2s4czdqV0FhY0dGSTZSYWQxdFcvanIzdG1uTlRL?=
 =?utf-8?B?UHRxeTd6UnZLc2IvMXpEMnptTXc3UVJsT3JaamZ2TnJ0TU1PaDFIV3hVdUJx?=
 =?utf-8?B?RkpSaUcvS2JKeE9sdHZWWkM2bkl0UDlydjJsOC8vWEE4UHpXQTdJTnR6akly?=
 =?utf-8?B?ZXYyUTFmQlAvTnEwV1JaUlgwSVVvLzNBMkJBS1l0aXhBbEZxZUZxVlY5Q3Ry?=
 =?utf-8?B?QkJoeWdrYmRHMXk1dkNJQU9NTy9wMnh5cDlMRHJqRGIxbW1rTlc1OUJ0TnpL?=
 =?utf-8?B?ZnBvb3U5VmtJQTVSek1MTkpHN3JUeW1DaVRMZXZGd2M4ZzZQa3RCY1VyS2NI?=
 =?utf-8?B?TlNnTWZONUYvSHBtenZCd3pGSGdGUEdGNTIzUDA2cUw0VWNBNDYxTXRmNVZC?=
 =?utf-8?B?V2tCNmowRTJSWkp1c040dm0rTzFYcTU3T3lWdWd5dUJUbmx2ejE2S01vMjI5?=
 =?utf-8?B?OHpWMWdsOWF5SEthOTdzaWNYaG51YTYyTHBaTlFIaThqc3FxWDdHVjA0R1FX?=
 =?utf-8?B?a1BPM2IyWUI0WXNpYnFKamkvcy9LSkYxWnRHNm80bU5pN29OREJDNTFZRmI4?=
 =?utf-8?B?MTN6TWpsT09qTmcvMGl3QWdwWmdMZkJjVytleTk5bnJ1Q090UENUdG1iTW12?=
 =?utf-8?B?ZGtvRUt2dkU3QzZvT00wWnZjK2RqYnppTGlpT25NSU1DRWI5T3BEdWtQcy9U?=
 =?utf-8?B?YzFYRWpuaW5iQWhjcmJVcVQzY1ExNTlXMlY5aThmSG1SY3h4OFRHVG16UVA2?=
 =?utf-8?B?NVlmRWx4R3BOYnZ2dXpZSDIrTVRYbVZiaXdkU0VEcXBoSUlHTGxTTzhHeUF0?=
 =?utf-8?B?ZVozR3NkYWg4N1dGeStXMkJodlY2elNvZlB0NWg3THNZRVhHaklzd0ovNVFn?=
 =?utf-8?B?VG1QUFRuMVBZUGVETVlTS0x4OURMY3FXZ0RNa1huWlRoSFh0dFNDWmllc1hu?=
 =?utf-8?B?NW90UGFITHFvb3dseG1PclJGWHZ2b2oreHZjNzRramRXMnVjOERkaUZvL1Mz?=
 =?utf-8?Q?bF/zzS9c?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0294718a-cd38-4303-ccf3-08d8c2671a2f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 01:58:55.4253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /elDd/R9oJwLF8Rnj4dwSCUz1dHkkbGkDjPn/M/45qCFQvL+hwCLIa+x7iX5c3y6F5bemczLNHESdXah9dsc6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2288
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270008
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 4:07 PM, Jason Gunthorpe wrote:
> On Tue, Jan 26, 2021 at 01:21:46PM -0800, Mike Kravetz wrote:
>> On 1/26/21 11:21 AM, Joao Martins wrote:
>>> On 1/26/21 6:08 PM, Mike Kravetz wrote:
>>>> On 1/25/21 12:57 PM, Joao Martins wrote:
>>>>>
>>>>> +static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
>>>>> +				 int refs, struct page **pages,
>>>>> +				 struct vm_area_struct **vmas)
>>>>> +{
>>>>> +	int nr;
>>>>> +
>>>>> +	for (nr = 0; nr < refs; nr++) {
>>>>> +		if (likely(pages))
>>>>> +			pages[nr] = page++;
>>>>> +		if (vmas)
>>>>> +			vmas[nr] = vma;
>>>>> +	}
>>>>> +}
>>>>> +
>>>>>  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>>>>>  			 struct page **pages, struct vm_area_struct **vmas,
>>>>>  			 unsigned long *position, unsigned long *nr_pages,
>>>>> @@ -4918,28 +4932,16 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>>>>>  			continue;
>>>>>  		}
>>>>>  
>>>>> -		refs = 0;
>>>>> +		refs = min3(pages_per_huge_page(h) - pfn_offset,
>>>>> +			    (vma->vm_end - vaddr) >> PAGE_SHIFT, remainder);
>>>>>  
>>>>> -same_page:
>>>>> -		if (pages)
>>>>> -			pages[i] = mem_map_offset(page, pfn_offset);
>>>>> +		if (pages || vmas)
>>>>> +			record_subpages_vmas(mem_map_offset(page, pfn_offset),
>>>>
>>>> The assumption made here is that mem_map is contiguous for the range of
>>>> pages in the hugetlb page.  I do not believe you can make this assumption
>>>> for (gigantic) hugetlb pages which are > MAX_ORDER_NR_PAGES.  For example,
>>>>
>>
>> Thinking about this a bit more ...
>>
>> mem_map can be accessed contiguously if we have a virtual memmap.  Correct?
>> I suspect virtual memmap may be the most common configuration today.  However,
>> it seems we do need to handle other configurations.
>>
>>> That would mean get_user_pages_fast() and put_user_pages_fast() are broken for anything
>>> handling PUDs or above? See record_subpages() in gup_huge_pud() or even gup_huge_pgd().
>>> It's using the same page++.
>>
>> Yes, I believe those would also have the issue.
>> Cc: John and Jason as they have spent a significant amount of time in gup
>> code recently.  There may be something that makes that code safe?
> 
> I'm looking at Matt's folio patches and see:
> 
> +static inline struct folio *next_folio(struct folio *folio)
> +{
> +       return folio + folio_nr_pages(folio);
> +}
> 
> And checking page_trans_huge_mapcount():
> 
> 	for (i = 0; i < thp_nr_pages(page); i++) {
> 		mapcount = atomic_read(&page[i]._mapcount) + 1;
> 
> And we have the same logic in hmm_vma_walk_pud():
> 
> 	if (pud_huge(pud) && pud_devmap(pud)) {
> 		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> 		for (i = 0; i < npages; ++i, ++pfn)
> 			hmm_pfns[i] = pfn | cpu_flags;
> 
> So, if page[n] does not access the tail pages of a compound we have
> many more people who are surprised by this than just GUP.
> 
> Where are these special rules for hugetlb compound tails documented?
> Why does it need to be like this? 

The commit where this was first addressed/pointed out is 69d177c2fc70
"hugetlbfs: handle pages higher order than MAX_ORDER" from back in 2008.
I only know about this because I stumbled upon it a few times in the
hugetlb code.  Although, it does not appear to be hugetlb specific.

As pointed out by Joao, you can also see the differences in pfn_to_page
for CONFIG_SPARSE_VMEMMAP and CONFIG_SPARSEMEM.  The only time we might
have issues is with CONFIG_SPARSEMEM.  I would bet CONFIG_SPARSE_VMEMMAP
is far more common.

Cc: Dave as he has sparsemem history.
-- 
Mike Kravetz

> Isn't it saner to forbid a compound and its tails from being
> non-linear in the page array? That limits when compounds can be
> created, but seems more likely to happen than a full mm audit to find
> all the places that assume linearity.
