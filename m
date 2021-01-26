Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2038F305024
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbhA0DqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:46:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38346 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388485AbhAZXXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 18:23:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QNKY3N029572;
        Tue, 26 Jan 2021 23:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eLpsFDN8B7SM5dmOrIy0zhap31ie42o7Ol477SSGGTc=;
 b=a8zJAStFs9hNPqDdJTOaUv0QEDUUkYNskH22/YHZb3Dtdg/LSfX218gw8hjFNxYKvaYW
 HoSjQPLthndzSU+ScQC/Ej3/LAMFW9/OD/uJQm3og31uHI1Ue/HYKSc/ZWl4+iZ23ndC
 rupkIVH3KafncKCmkLYdVuH3fSq+nE9bl3R1sphwVjEQWZPOQm5Iys2X17/AcsdRjPt0
 EZKQRfYE3ahIYRoVsoDH+JdOvs+AOYGPZ4HzPH6SR5xir++0DO5BQTuyP021Nh9GmxHO
 JycIHZCLDus+Iicf6es/jaV/pog0rSmysMyAlsmoyQMpD3fee6b2EcinKsizL5+bosdp 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 368brkmek1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 23:22:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QNKBVL180524;
        Tue, 26 Jan 2021 23:20:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3030.oracle.com with ESMTP id 368wqx34m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 23:20:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMklWcORdEINO6hKxwerF7sNobrSUIqf4qUXBp/0uIa6Qa2xpx2WCMaWUOHe8gJX9+GsQwzbj55Zh3tBlRgI0U1cE54LpK9t27oqdZJPYVqDQ8yVlHLcpDqiLTCp5DKxqbd5evrV3yqJlBBXcST8ydvo2Oq2X7Ds7I9Y73cP0jCkcvpdhUPNarNa1RnLqzvlJ93XflL1Lmx9e0xU0oO0W8yKxMChBSnMTpn6HjDLXOZwB1MiEciVze7MUpJKy44HBE+hGBMeoCh7+w430xBStAe11nIEcRJt7k5JcZwxkAPVYnuzPtfdvLDLP42vxaZ4r/TIkBPerSvNVv2zh/KOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLpsFDN8B7SM5dmOrIy0zhap31ie42o7Ol477SSGGTc=;
 b=YDkZPqP5zum628YNtqZ9Iz6OhcSiNP4taXDjjt0Qm4Wzfwq2KqnR24LghVy/c16OC71p14HTlxDsNQtI0DeHYmumzsX3dAdQ+FvHWNjOjX1ew6sw1tUbQXORz0/K9KKh0ePZALzowbo8CkwE5kTRFoT6cGANgttQnbQ6MwLBMIyoz6UKBE+NGQIywJ9tIKE+VCUKdpODEca0XQ6A00zawHG1uTaxVcGWA90qqY17/Bn0HOO7PFEYRXycEtXyZlviHLMatpXzbo75BLxe4K63kDvGOXWuFh9knXR4Ka9k1uuvAcXKNsYiyFbWtJIFSiHBn9+uJkkIdV+Ulbtg7zCMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLpsFDN8B7SM5dmOrIy0zhap31ie42o7Ol477SSGGTc=;
 b=NQg+e+iujHLeKWgD/m5vgCRmVW8GvPTYXhYCGWamCkr4SyCaTndrA5goADs2ueMbW195hYTOxE4c4D4D2GJU876NtZU4yoLlEHhT3AWPjClmbg9/qAHqdXb/5DdEp9m02ydUYJN0WM7VdCUS392nSpYobEfucmqZABF3H5ybYtQ=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4445.namprd10.prod.outlook.com (2603:10b6:a03:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Tue, 26 Jan
 2021 23:20:24 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%6]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 23:20:24 +0000
Subject: Re: [PATCH 2/2] mm/hugetlb: refactor subpage recording
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
 <20210125205744.10203-3-joao.m.martins@oracle.com>
 <3d34111f-8365-ab95-af11-aaf4825204be@oracle.com>
 <1ae0313d-de9b-4553-1f68-04c4f5a3f7eb@oracle.com>
 <4d3914e9-f448-8a86-9fc6-e71cec581115@oracle.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <90e28835-cc36-5432-bb3b-4142fbbb2c21@oracle.com>
Date:   Tue, 26 Jan 2021 23:20:15 +0000
In-Reply-To: <4d3914e9-f448-8a86-9fc6-e71cec581115@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::35) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 23:20:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea56c43e-30de-42d7-25ee-08d8c250f569
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB444561DC18C40FE37364ED04BBBC9@SJ0PR10MB4445.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fnhvPyzok1FVXbGccv+3sz/HKYQUjF76jmzPfwhVl/2vEWJmS3bfTsfmV0zULZYendmSYZqRR3jghBegXg0OsGqp2rwGVny0pmEfYYLmMaSRNHLcahV8QGbG5igS5aqfnXUfCJM3KHVoLKivo4jb8XIv4cXm/PKjtzK5KefQ78x0bkRqpOHlEjFSYwrnJUcelz/JHy8XAQcyMjD83VDo3ZmXG9ykaYGlaCoTSfgtssK9pEbvfAvsMQl5OiqXYB1AJ2iAEZi2UXaDtHszBV/s+TI370K0vJ0sxpLTbaVUuVuKjCHXWnv+7xLxYNTjUdC6wrEROQ5nYdTOZMo7/hI7IfMzCDYByL2qaZQtS3oQkTurrbX2rkaXwXqdT7dRvH+k8Wg/6LSBtGyhortMGeO0pya2p7wKeMWKhZVZlyOZb1a/dwT1zrmup2WmNkK/1nOf2VqNUglUOs3hG1EU+nLFSYJAIIKwObdZvDb7M3AOL2DoxKv0VIas5eTuTf51yjfPzpU7OiHYFrqkxfEtN/3FJ81wOg/HPzwvurj0RibSOhhnfBe244RwetHczVQsuyq7h99C7Vjzdry5OMZ8322/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(39860400002)(366004)(478600001)(2906002)(16576012)(54906003)(66556008)(66946007)(5660300002)(2616005)(956004)(316002)(83380400001)(86362001)(16526019)(66476007)(6666004)(53546011)(186003)(36756003)(8936002)(26005)(6486002)(8676002)(31686004)(4326008)(31696002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dE1MYmRlallFR0JNNzFjTjJxeGlrT2l2NFhOL3hHRlkvVm5qVzYyUlkzRHBJ?=
 =?utf-8?B?Z09vdkdGR3NZVThlSkpjeDBrNFNvWHNPZStZMkpHODRZQ1VmSGRmV2RycWZy?=
 =?utf-8?B?dVJHNTB1VGlmZTVKd3Q5bEtsdUZwQlAyVGRLcDZZbkVrK2VqakgrakZsSWt3?=
 =?utf-8?B?KzZWSHkvMXJOQkw1Z0txV1Y2bVUyVHNUajFrTlNlU2cvdjhneG5UWmZ2dGVt?=
 =?utf-8?B?YjJTczcraE1pMkVYYXRPTUZaeXRNVU5UcVV0cDJ4K3NFeGVzSXdPalEzWStS?=
 =?utf-8?B?TDZaMXZtZjIrSDRBTWhCZGp3YVBmNFZTQ0djYlhJTU1GTzRHTkJjYitPVUl0?=
 =?utf-8?B?ZEtoTmJJWlArKzAwYlhVdG5sUTd2bHVueFFPVko5eWI2M2t5bWh6UndmRHR3?=
 =?utf-8?B?L29WQXJld0drdmw1VG9pWm1xdDlPcXBLZjJHcWtaUzdQNURBbE0vQWQzR0or?=
 =?utf-8?B?akhrdUVLdG1DYjVrRi9IQk43YmZGSUN6eXFoSU1JUTMySVpzbExucUQrMWZL?=
 =?utf-8?B?VDBUY0VzbGFCbW5JWTNja2JUZXBzQXJRbHJUOEUrNTlFNkUvUkp5TVNqSE9H?=
 =?utf-8?B?Q1FIK20wZ2o0c0xYNHVXOTNGTXlub0RtU2N2eEk2TTlKcXUzclNBUXB2YUc1?=
 =?utf-8?B?R3dpRyt6VnVrTXpJZ01sRFdXai9DOUpLKzg4NUZuTFVkMW5XTndxM2JhUTdp?=
 =?utf-8?B?NUdxc0FtZlBWRXZIaVBmamlnTlZKVWhmbUZsTzZmMVR4eWh4Mlp6MWZqazAr?=
 =?utf-8?B?UTdaUnJYaHV1ck16REJaT2xnWmdDYzJyUDBzRGtEUnNhdElTNXkxanNtS2xB?=
 =?utf-8?B?M0psUHFLWERSaUs3b2dsODR4UHl4Q2pQc01ENEpFMy9FamtnMFJXZk9LK3Rr?=
 =?utf-8?B?bHBDUXZvUnl5VGlqc2MzUjEzaGROSHh6aU8xR3pEODJMWGk4OElwQnZYTVJQ?=
 =?utf-8?B?MWdJMVBPaDZISklzSnFCQ1lkdDcxRUJ5QVhUTitQL1J1RWtsTlRrb1Z3RkZp?=
 =?utf-8?B?QVpUbmt1SlEvQVBINWFwcGJiRDAwK0RFVzU5SlU2YVB4L0VaR2dyUEFOS0I1?=
 =?utf-8?B?bEl4aHF3OEcvNjlzZXhyQ1NpS1FnSk9rZVptam95blc4d2xDVmZtN2w2MjJX?=
 =?utf-8?B?eUFCWUptbVZzbkhGS2ZUOGJtRlNlck5DSE5LV0tacVMvTytPaHdnbEEzNi9O?=
 =?utf-8?B?NzhxQUJ3SEhUaUlxNmVaUDU2a0VveVVNamxUTCs0ZUJKNHljRUxwVnZQT1dE?=
 =?utf-8?B?b3BxU1ZCY0lPL3VVbTZUdnRvekNzbjJJekROaU9XRFczdGw5SXdtY0xhc2Fq?=
 =?utf-8?B?VzZWQUc3OWVSTC9jLzByNDhvSDNuT0dpSll0QVFzdTE0ZDVhMUdJK0FWRXYv?=
 =?utf-8?B?QzhQQVM3eHkrN3hVcFhraXgwZEdndy9UcnZvclVibU43VE1xd0hTVTZXVVUz?=
 =?utf-8?Q?ljapeAb1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea56c43e-30de-42d7-25ee-08d8c250f569
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 23:20:24.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZCUTcpuu0GeRrn0aLZtchSydv/kI7xGkXf0VJB5CGOrWikmoN4VrrgkCv2sMxFcw2lEnUjVr2bzdVuFlc6eSFgkGfVazBlc2J9y/Mz0gdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4445
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 9:21 PM, Mike Kravetz wrote:
> On 1/26/21 11:21 AM, Joao Martins wrote:
>> On 1/26/21 6:08 PM, Mike Kravetz wrote:
>>> On 1/25/21 12:57 PM, Joao Martins wrote:
>>>>
>>>> +static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
>>>> +				 int refs, struct page **pages,
>>>> +				 struct vm_area_struct **vmas)
>>>> +{
>>>> +	int nr;
>>>> +
>>>> +	for (nr = 0; nr < refs; nr++) {
>>>> +		if (likely(pages))
>>>> +			pages[nr] = page++;
>>>> +		if (vmas)
>>>> +			vmas[nr] = vma;
>>>> +	}
>>>> +}
>>>> +
>>>>  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>>>>  			 struct page **pages, struct vm_area_struct **vmas,
>>>>  			 unsigned long *position, unsigned long *nr_pages,
>>>> @@ -4918,28 +4932,16 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>>>>  			continue;
>>>>  		}
>>>>  
>>>> -		refs = 0;
>>>> +		refs = min3(pages_per_huge_page(h) - pfn_offset,
>>>> +			    (vma->vm_end - vaddr) >> PAGE_SHIFT, remainder);
>>>>  
>>>> -same_page:
>>>> -		if (pages)
>>>> -			pages[i] = mem_map_offset(page, pfn_offset);
>>>> +		if (pages || vmas)
>>>> +			record_subpages_vmas(mem_map_offset(page, pfn_offset),
>>>
>>> The assumption made here is that mem_map is contiguous for the range of
>>> pages in the hugetlb page.  I do not believe you can make this assumption
>>> for (gigantic) hugetlb pages which are > MAX_ORDER_NR_PAGES.  For example,
>>>
> 
> Thinking about this a bit more ...
> 
> mem_map can be accessed contiguously if we have a virtual memmap.  Correct?

Right.

> I suspect virtual memmap may be the most common configuration today.  However,
> it seems we do need to handle other configurations.
> 

At the moment mem_map_offset(page, n) in turn does this for >= MAX_ORDER:

	pfn_to_page(page_to_pfn(page) + n)


For CONFIG_SPARSE_VMEMMAP or FLATMEM will resolve into something:

	vmemmap + ((page - vmemmap) + n)

It isn't really different than incrementing the @page.

I can only think that CONFIG_SPARSEMEM and CONFIG_DISCONTIGMEM as the offending
cases which respectively look into section info or pgdat.

[CONFIG_DISCONTIGMEM doesnt isn't auto selected by any arch at the moment.]

>> That would mean get_user_pages_fast() and pin_user_pages_fast() are broken for anything
>> handling PUDs or above? See record_subpages() in gup_huge_pud() or even gup_huge_pgd().
>> It's using the same page++.
> 
> Yes, I believe those would also have the issue.
> Cc: John and Jason as they have spent a significant amount of time in gup
> code recently.  There may be something that makes that code safe?
> 
Maybe -- Looking back, gup-fast has always relied on that page pointer arithmetic, even
before its refactors around __record_subpages() and what not.

>> This adjustment below probably is what you're trying to suggest.
>>
>> Also, nth_page() is slightly more expensive and so the numbers above change from ~4.4k
>> usecs to ~7.8k usecs.
> 
> If my thoughts about virtual memmap are correct, then could we simply have
> a !vmemmap version of mem_map_offset (or similar routine) to avoid overhead?
> In that case, we could ifdef out on SPARSEMEM || DISCONTIGMEM for mem_map_offset() either
internally or within the helper I added for follow_hugetlb_page().
