Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19ED0423074
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 20:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhJETAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 15:00:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43882 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbhJETAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:00:15 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195IhwC6029448;
        Tue, 5 Oct 2021 18:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u1vaD5eSkzs/6wYFCFmLFT3rgr2AYrSoNQ+35I+vRgk=;
 b=zsCYhMsISqTSWux81wnuwvRdPIgOJl5O6tCWy4vuJSuzufQBueItEMdKdIt2TRm/mHEO
 t1DJ1sSxMaaQtdTwuorQIn+lkIlJK/FN34B1b2Hqvrx/UgOqEj1crFJFYGIpnjplLrJ0
 ulJS5wp9RwP4CuO3xWlCg/T5DFioWvZofbSYDx0U7Hd4zxNVvkANCvxoEoyAi4Vf+sk0
 csmSFK6PMVlHo4h1DsFlvu5YZYiAYNnhhYtpMGTqY68rlXgNk1/OVHNaF4dZVSA8cbnV
 KLz6lzHI8r1RKKHG6UyaSBAwGjCCaWBOzxR5n7L9SxMyucNb6irINDdlAO+sYvvB1PEj sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kt9px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 18:58:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195IuYgW129730;
        Tue, 5 Oct 2021 18:58:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3020.oracle.com with ESMTP id 3bev8x6qgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 18:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXiFmrTRiKjx/5O5iFNFVZP4MMuqOzHTgo6PHFAelfg796571wjY1kr79vYYZ4rS2cxtkqK3EE17EZr3CmLqRplvYHUd6EHq9kdLTputQTeVR8GnNkOfiEcNQgKi5f3phq0CTxO9wDU49jLmjwXcJTEJSZFD7iqCU+YZa6Ymv9Fb7M2rR1YjG+cblks1mL1YvlL19fPBNdAQBtjSYvasXlJsm+qtEbGB+cPRSDzcHQgd/CoYFBKnaRsmSc3pU82ZnvcNbTMzmuCTqR/3PUzLq72I8pjmxE1dwfhukBYXkRMdMxmAyq2pLq9WF3n3KpZSWDDF6P5Va9aSDP/0NJf+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1vaD5eSkzs/6wYFCFmLFT3rgr2AYrSoNQ+35I+vRgk=;
 b=gaOA77svUd5zgXw9EgQzh/GxWsgNRigjASrDawiGmMlpIhLSobBrbs/LZE0LaU82XmZhh2IImWRkx0vRpGUXlY3hl0dfJfmkJyL0ZHERrfQeu1tEUSPhrkqusgHRFUqAz6INY+45G7uV32npFwPccUWfsDj4tH4dmhNj6EdnkXwm+Ekwwe0gwbkpQFMvv3DS0xZ9DW0SZKl5YjVzz1tre9/3POFNHnmMqG0pHWw5KpGs34LgIH+oBM8mI4dXU4TG0am2LJhi/hJPmv3dOOGS3Rb6H8r5bQ/pASTjA7WJMGV/h1oCi0KjMbBgKPs2/gTU+4P+BpCAApoUT6yDVHtX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1vaD5eSkzs/6wYFCFmLFT3rgr2AYrSoNQ+35I+vRgk=;
 b=FiyaPJUFwyIR5slIqhuXWU0rOIZsNpX8f9sywkx7t3u1B2DgL9Pd5s2XUvI+3m1ijFnGRkYnWJmPs6VBHym5FeXSg/RYHaxiTmy812pvs3wKjS61g+H/mdOa/dJO4VTeLvMnHExUIAeSM6UKWOMxhcvxacosgYmtS54WQAsAcmQ=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3544.namprd10.prod.outlook.com (2603:10b6:a03:121::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 18:57:58 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 18:57:58 +0000
Subject: Re: [PATCH v3 3/5] hugetlb: be sure to free demoted CMA pages to CMA
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-4-mike.kravetz@oracle.com>
 <20211005093320.GC20412@linux>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f1f011cc-5c5a-7c4f-5701-929918fa2dbb@oracle.com>
Date:   Tue, 5 Oct 2021 11:57:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211005093320.GC20412@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR10CA0053.namprd10.prod.outlook.com
 (2603:10b6:300:2c::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR10CA0053.namprd10.prod.outlook.com (2603:10b6:300:2c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Tue, 5 Oct 2021 18:57:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce93b822-c3e7-456b-4c00-08d988320b8c
X-MS-TrafficTypeDiagnostic: BYAPR10MB3544:
X-Microsoft-Antispam-PRVS: <BYAPR10MB35446491C6B129AA74CE12EEE2AF9@BYAPR10MB3544.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkS/CIH+0PE/39Hni4cpfdQcp9gxF3lhqannaU1GZ+D8TO/Diaab58FgmhcH8IlOo/SHtWU7FMkUb657H3+/eNtHbKrfFME11GQ1UxhsAvx6DWvKYKln7Iy1pJ5Xf3P0OqZobdw+diGfdvrbBH174wUSaM9NJnvlUKgWWMUUCYps/kZ3PZgazTSmw6EbAvAsMRxj3JKW4/ZMp+R5kF9/gsQktobT69Qb38x8RjtGqhu/zFNg2tlgvPb5EMkeZ2mpN4y03aKJUa5qB/9Chr9tb4AwHXhToW3H8LtT+Yqbb8t+NSK0LxRAAjr7wi76SfIfUYziTVDqZ+3QwYMIy8Vn4rKWw5vV0C2SPyTmV1uKngNAhlinnVsJdvBJN218qobiSCdu687BG7t1g7oGjE12kl3808+ycLL94J7m8CKlgRnNmzmT0QZQvtzHOIgfDuzLlZs/QR9bruA9Fhn4I1+Y41MM/SdctkqT7gDNYFTBxDboVVKI7H7cJYxOi6Q8wtjC12Lfo/LQuTgu9mcoiIEyDxgN6l9NEV9XiSNMCxSUWK6kCIsHFAl8fhOWbnTw1Mzyo1+qKzFb6WdXU68rDOXZsqCg7v9DgnL3fonI63pzDKcTd9WN8HfJmfUPJ02lrIFntRBkC2UrT9kV+X/1C0ZDOUwq7kbc97fkD2LCObacOvTcjpoONvxi5d9oopncHwgr7PKxfdYe7gQRyg/S5L10pMAWZOnort1cAq0UAVb8jtx/H4vnuUs4alkiRlInHJMlJyiZCfuWA0lFogSJE+XKHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(44832011)(2906002)(2616005)(956004)(36756003)(31686004)(4326008)(7416002)(83380400001)(54906003)(53546011)(26005)(38350700002)(86362001)(5660300002)(8936002)(66556008)(66476007)(508600001)(8676002)(31696002)(66946007)(52116002)(6486002)(186003)(38100700002)(6916009)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDlkUkVYczR4M016ZVExRUJ0VHVBbW9GQTdCendKL1lNNkdaazB4Y1RRL3Zj?=
 =?utf-8?B?ZnFBZ29YVG1lbFRFVnQzQ1J0WHk0b0dhenRFNjNlSG9xWGlDemJNR1YrTHVR?=
 =?utf-8?B?NG9xamNlQkppWGRiaVZiRkpCbUIvMzFYRW9HbFV5U3NqY0JVbS9ROXptSWxv?=
 =?utf-8?B?MkRoSG1QQzgyaFkyb1cvR2lWc3pvdFJYWmh3S0JsM0I0dDB2NElvSmZkdzRK?=
 =?utf-8?B?Y0ZTSG9XTlFsRlJ5WkY0d0ltYStNRU5KakU1TDBXY2dxV21FeXlUK2tPTDZ3?=
 =?utf-8?B?aW9taFI4TnRHSDVFWWNhbHNrZGdBcnRzSUYvQm5naEhtRjYwaDRUcUJVaktH?=
 =?utf-8?B?VHkwcE5KNUM4Njg1ZlhiYnZrUGlqb2dPY3BFTTBON3dUTTA4RnBDN3R4M0ZR?=
 =?utf-8?B?bjB6TjBELzBqQTk5ekhIekpGY01GbERGcFdkVUswcmRTMm4vTnJSQk96Vk9T?=
 =?utf-8?B?bzBoTXRpZzNNTUpsVUJlT3k1TGxMeFJtWlRFaXY2ME9waUZTRnpNWlkzZHdr?=
 =?utf-8?B?SHVjaDYxOGxZVGkreVl4U2RCbURhaUtpZzUyY1ZIRnRKU1ZNY1dYQnpENE5D?=
 =?utf-8?B?eGo4aVhobFRWQi9DR3Q2RVI5K0x2Y0tZemc4dGQ5QkI0T3haU0NFVGVCdEhI?=
 =?utf-8?B?azRtTTh0REhJNnN4dW5yWHcxNnN6KzI5MVhiaVFLSE5XTzBaWndmQ1J5d3Rw?=
 =?utf-8?B?L0Zlcm4yV0U1SkU2c1JXUmVjcEkvN2RwdUZIRU1vcUMyVDJBNFUzc01zY21C?=
 =?utf-8?B?WlNkcE9PTDZNcXdBbGM2MDc5TjRQZzVKZ2NDVzJaUnI0NXpONlhiWHVHM3Nj?=
 =?utf-8?B?d0MrRndzbWx2cEY4RXp4WGZYM0lVNmpCZ09HeDMzSkV1MUJIWHNRZ0ZvV3hK?=
 =?utf-8?B?QWR0aWlDL2U1N0dxbkFlekErdFA0UGFvcUlUVjRidEFMQzluM1pKbTZOUGhP?=
 =?utf-8?B?OFdkblpMZ0FyNEh6UTN6anpkZ2tJM0FDVHoxNHpOQjljNEg0TGc0WXRoYzAy?=
 =?utf-8?B?aG9HVUg5QjRDNElBV2dZUXBkbnRrYjE3SXhJeUFva2k1NHNZc045ZmNZYkFl?=
 =?utf-8?B?ZnlBWkxxZmR2d3hwUmZvaUNXNHJZZSt3Uk54S0xyWVBqSnFpSkd6NlBNT1hI?=
 =?utf-8?B?cThVK1Y5UW9ycGljL2xsK3ZBdERQOXEvSHM1WkV2cXBnLzZJQTdVMTh2TFl5?=
 =?utf-8?B?Y3FaZ01TL2ZwY045UUJEUkwxc1FHOUU2OG1hMTZsN25KTnlvS25SbkxJOVdD?=
 =?utf-8?B?RmhxdUxXQmZmdlUvZG9Qb0ZuUlVLM1A5TkF0YU1JaXFZN3I3ZUlKSksyS0d0?=
 =?utf-8?B?VUlUNDFuaVlFNTQvSlZPdE5kQTZuckNZSnFYTEk2eFY0UzZORHBEcVZYZXdy?=
 =?utf-8?B?M2ROUS93NVFsMEM1T0NTWlBWWGNaNGxrN2tHWTB6bmpPY1VZRmZpUkxyRFg0?=
 =?utf-8?B?dzg1eTYvbnlXZkZUbXpsczA1dkRZQXo3THY3ejU0UmhXQzFvV0R3QnY5QVBT?=
 =?utf-8?B?c0gzU2ROaEVmaDNtWmpWMkhGUnd2S1AyYnZnOGl5NlNFY2hNRUdaejZkaGtC?=
 =?utf-8?B?YUtQNHNPWlhBeVNZSFA0U2V5S2lGNDFDZThOem5ib2R6emVNOW5jKzU1Q09r?=
 =?utf-8?B?TExHTytCbW1lUFViYlpJUHRSTk1McTFlWHF1S2tOY1hrdUV5WHUyWFZ1anF0?=
 =?utf-8?B?TTFQZGpJSTFlZ1dzeTRxTi90V2o0d1gwb0lmUnZzTEJMa25sZWdNdXdWTVk0?=
 =?utf-8?Q?2XAJ6HgLex3oYdw1umNmKv249cUKBOBoW7WY+2T?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce93b822-c3e7-456b-4c00-08d988320b8c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 18:57:58.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPxrxMh1nOUgW+hcD7mf5k/MZUgxCJg+3BzCfGQ57aLE+e3J6Fh82m5Ga0llaYKNJZBJhzTexvS2MG2kds+hmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3544
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050112
X-Proofpoint-GUID: SxLGx8M5ImoWa-OrOwsCdKzEDUZmD4vp
X-Proofpoint-ORIG-GUID: SxLGx8M5ImoWa-OrOwsCdKzEDUZmD4vp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 2:33 AM, Oscar Salvador wrote:
> On Fri, Oct 01, 2021 at 10:52:08AM -0700, Mike Kravetz wrote:
>> When huge page demotion is fully implemented, gigantic pages can be
>> demoted to a smaller huge page size.  For example, on x86 a 1G page
>> can be demoted to 512 2M pages.  However, gigantic pages can potentially
>> be allocated from CMA.  If a gigantic page which was allocated from CMA
>> is demoted, the corresponding demoted pages needs to be returned to CMA.
>>
>> Use the new interface cma_pages_valid() to determine if a non-gigantic
>> hugetlb page should be freed to CMA.  Also, clear mapping field of these
>> pages as expected by cma_release.
>>
>> This also requires a change to CMA reservations for gigantic pages.
>> Currently, the 'order_per_bit' is set to the gigantic page size.
>> However, if gigantic pages can be demoted this needs to be set to the
>> order of the smallest huge page.  At CMA reservation time we do not know
> 
> to the smallest, or to the next smaller? Would you mind elaborating why?
> 

It is the smallest.

CMA uses a per-region bit map to track allocations.  When setting up the
region, you specify how many pages each bit represents.  Currently,
only gigantic pages are allocated/freed from CMA so the region is set up
such that one bit represents a gigantic page size allocation.

With demote, a gigantic page (allocation) could be split into smaller
size pages.  And, these smaller size pages will be freed to CMA.  So,
since the per-region bit map needs to be set up to represent the smallest
allocation/free size, it now needs to be set to the smallest huge page
size which can be freed to CMA.

Unfortunately, we set up the CMA region for huge pages before we set up
huge pages sizes (hstates).  So, technically we do not know the smallest
huge page size as this can change via command line options and
architecture specific code.  Therefore, at region setup time we need some
constant value for smallest possible huge page size.  That is why
HUGETLB_PAGE_ORDER is used.

I should probably add all that to the changelog for clarity?

>> @@ -3003,7 +3020,8 @@ static void __init hugetlb_init_hstates(void)
>>  		 *   is not supported.
>>  		 */
>>  		if (!hstate_is_gigantic(h) ||
>> -		    gigantic_page_runtime_supported()) {
>> +		    gigantic_page_runtime_supported() ||
>> +		    !hugetlb_cma_size || !(h->order <= HUGETLB_PAGE_ORDER)) {
> 
> I am bit lost in the CMA area, so bear with me.
> We do not allow to demote if we specify we want hugetlb pages from the CMA?

We limit the size of the order which can be demoted if hugetlb pages can
be allocated from CMA.

> Also, can h->order be smaller than HUGETLB_PAGE_ORDER? I though
> HUGETLB_PAGE_ORDER was the smallest one.

Nope,
arm64 with 64K PAGE_SIZE is one example.  huge page sizes/orders are:
CONT_PMD_SHIFT	34	16.0 GiB
PMD_SHIFT	29	512 MiB
CONT_PTE_SHIFT	21	2.00 MiB

#define HPAGE_SHIFT	PMD_SHIFT
#define	HUGETLB_PAGE_ORDER (HPAGE_SHIFT - PAGE_SHIFT)

So, HUGETLB_PAGE_ORDER is associated with the 512 MiB huge page size,
but there is also a (smaller) 2.00 MiB huge page size.

After your comment yesterday about rewriting this code for clarity,  this
now becomes:

		/*
		 * Set demote order for each hstate.  Note that
		 * h->demote_order is initially 0.
		 * - We can not demote gigantic pages if runtime freeing
		 *   is not supported, so skip this.
		 * - If CMA allocation is possible, we can not demote
		 *   HUGETLB_PAGE_ORDER or smaller size pages.
		 */
		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
			continue;
		if (hugetlb_cma_size && h->order <= HUGETLB_PAGE_ORDER)
			continue;
		for_each_hstate(h2) {
			if (h2 == h)
				continue;
			if (h2->order < h->order &&
			    h2->order > h->demote_order)
				h->demote_order = h2->order;
		}

Hopefully, that is more clear.

> 
> The check for HUGETLB_PAGE_ORDER can probably be squashed into patch#1.
> 
> 
>>  			for_each_hstate(h2) {
>>  				if (h2 == h)
>>  					continue;
>> @@ -3555,6 +3573,8 @@ static ssize_t demote_size_store(struct kobject *kobj,
>>  	if (!t_hstate)
>>  		return -EINVAL;
>>  	demote_order = t_hstate->order;
>> +	if (demote_order < HUGETLB_PAGE_ORDER)
>> +		return -EINVAL;
> 
> This could probably go in the first patch.
> 
> 

Both of the above HUGETLB_PAGE_ORDER checks 'could' go into the first
patch.  However, the code which actually makes them necessary is in this
patch.  I would prefer to leave them together here.
-- 
Mike Kravetz
