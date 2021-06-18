Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FEC3AC2A0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhFREvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:51:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62220 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232253AbhFREvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:51:15 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15I4kvAS012176;
        Fri, 18 Jun 2021 04:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=o7OY5hlHFBmLcfL9ptBG5DRhPREE7aytQzAhItX9nGE=;
 b=fQtIVsxQiR4Yd8y/+dEhEitJmBjTbhRaPU+KP6+oKv5WTg3mYUFUCK0l7hRqjI/DBHL0
 11L3WC54SO5XJY2IhT+lJz1DxINdPLLU7kaKRKcU1xH10EaxSSkiZzG17m+2MSf+fpbI
 OC5+gzwXiJAWHCAbBJbskYnY9nSA5GKGofyyYjWtm5YpUj8lPreD+M7175ykBqQRIK+q
 D1ze6+CfojwNigjbD2xBGSMQgyXpeQjaFPRQPEoMx2Ll0NOohUiKaJ3fe7QSrKBmiqPk
 mjjV/z99v+7AWuht/dlVKS6jqlCNp2uJSXF3dB4LfVkBTgh5QQuU4ghJcuGIKVTUbCHF QA== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39770hckrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 04:47:54 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15I4lrD2149942;
        Fri, 18 Jun 2021 04:47:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 396wayfhj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 04:47:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qhz3SJ3Pzb7+to+bStojGGd15ERCn62WJtkKlVcOE/pybc9QL2o9J3KHj69RFYum0PzwZbLINP2Q3kSkccHVJNmq653HZV3ONmFMj6j/XX03Rk5o8/TYIaHnD+/+fypgDs28CnpLlsft8m1/QUx15Tmrv3SNxK54uaeAqFAoqKvXEmNnWV4PB9gytrYERgQeeaPCXJTW7LkmhPm5+reKM8/iPBsBQj5XoSJpDuxK49dUdlfIfqGyTwfxrlsYMdO8hz3UYgRf3ztIrWlmQph1sBQGa1Aw8m8zRYk4/dUWZjlyWNxQ43ovCsxxyECAV0qrs+qAyqBoD7s//cLXkwfSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7OY5hlHFBmLcfL9ptBG5DRhPREE7aytQzAhItX9nGE=;
 b=cuNR58bqDTdkET8/Vrik+62QrdP9OQLoO8fUipdfxVsxl960R5sQMfohVQvpdPfTaYimTjEeQSyj4UAX8deMt9BDFQl44wftgGkZIlhvuAneb7z4vNbihN0envnuSvStIdd/+Jz19DM6OUUiG/GWz0BiwclTklf/nNYhHMX0Ig/K5uX9TG/L50oyfKfJppaSjNs+49haBissilD3DQj3IaYPLV2uALa+N2eCV26BWZDhYx0H74oWUnpNmQ9UDr4PTLT5EcPdHXfBb/4+WREVxk7ExaOQRrsR/862smABZ5Y+WoqTAol2P5JMLYvkki1as+jBXdmg3thKGYEI75Xvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7OY5hlHFBmLcfL9ptBG5DRhPREE7aytQzAhItX9nGE=;
 b=F+tQnrCjK9++imijqyDTSXlVSfSNjaSXefzW+9UwJe1/P4t4/GQ18iV8wGNvdXMXsiPlK8tQwIYE5BUWbqLtYu7/na1pOgtJnqeOSM9NBh8lhUfb5izcWlJP/LXA2JslFZBSyhxpc7P8NceuKjb/BujiSc/c8bX0rLymGgGCdw8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3445.namprd10.prod.outlook.com (2603:10b6:a03:81::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 18 Jun
 2021 04:47:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%4]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 04:47:50 +0000
Subject: Re: [PATCH mmotm v1] mm/hwpoison: disable pcp for
 page_handle_poison()
To:     David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20210617092626.291006-1-nao.horiguchi@gmail.com>
 <a7367b3b-f772-f147-36fe-fdf67a7aaa60@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c9a5d349-cd3f-2cb3-d16b-7ca3fb679e1a@oracle.com>
Date:   Thu, 17 Jun 2021 21:47:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <a7367b3b-f772-f147-36fe-fdf67a7aaa60@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0089.namprd15.prod.outlook.com
 (2603:10b6:101:20::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO1PR15CA0089.namprd15.prod.outlook.com (2603:10b6:101:20::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Fri, 18 Jun 2021 04:47:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12c149d0-4b80-4bab-a2c6-08d932143a14
X-MS-TrafficTypeDiagnostic: BYAPR10MB3445:
X-Microsoft-Antispam-PRVS: <BYAPR10MB344540B6825837C540CF8E76E20D9@BYAPR10MB3445.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFOBqn7nMaDUTC6+ZsH/BmqS2jzUgTWsFtw50hSw5zNPn9wZVXde2XA+JWOGEcL/wnnfAAayjo0UFg3MC1sd0k78L4FCPKdotGvNGh/8GBuwOldhUoZCXI3H9J5JssZ8Q+3kY8wkT8tRRiIxRxv50Fn/g00GlkgjLu9ofREDcWr8Fmk/12C2cehQYnpnbDLdl0BPv5tZFpVvIHqNxJg66MSN4N7HsOjP41d/YrwAHub3Nyn2LrUp6Tt9Zy9oCiTqc869XzN9ntO6a8FrffrxSLVfELvdW2Feup7LUYikJLWibjtGBy4t8/yEu68zImoV2qyNfaVW8SG0nOrHZUsKn187M+j9ZiL++gh3TIgveTkvT8ojLg7T92pbqTIQLmOVoWZz7APDuKo6tZSajVv20UgFjp9NzRgq+bw8b1GInQDCH6yA/I70fKfBB318AWfyxbkTW5UknEMPRPzF+5vSrMETQGw/KSDbQa+Osv8cYJXZ+6E0BpBQJdyZjEs3/+wgQpB/xhD2uN7j6zmmwzV3bWUiAr+AzccCKehy5EAhalMs6XmdHQ9elQuoVe4fNBXgyI+SFFtY1YWBjFAVix0RMvtD1D9yCfh5Mu1LEef5N8bJqTlH0rB2SPbwjIBciDVJQI0EWxtO8uuajbR77XVAkYtX2jB7nhJKhI9LIiwNWjSXq0uBbRdt9Ou1lXezIfoD8Qo43RFeAEsYKrODJ+hSoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(39860400002)(346002)(316002)(54906003)(110136005)(16576012)(956004)(53546011)(6486002)(52116002)(5660300002)(31686004)(36756003)(44832011)(2616005)(26005)(186003)(16526019)(38100700002)(38350700002)(66556008)(66476007)(66946007)(8936002)(4326008)(8676002)(2906002)(83380400001)(86362001)(31696002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0IxVk5Eck9oNjI2bTZtSUdJeDhlckNIcG5KZU1SWmZPSWpKRDg4TzdTUDZX?=
 =?utf-8?B?eTF3Y240MXJDdm9QQlNSRVBhMXdKbjFjb1ZBSE90NEhKZTh1djlVcExlQ1Bs?=
 =?utf-8?B?T3oxdnAwQk5PZVVLdnFoMXBVU29nRjJwVXE2VTVNM29ScjBnRHQ1dkdUK1dQ?=
 =?utf-8?B?UFQwTzR5QmRGMmJLY1pyNDh2eUpGNWFqZGdSQTZ0QzJHNlBSem9KUXlqUm5T?=
 =?utf-8?B?RnBadnVCbU9KcTROY1VNQm1pdUROb2pDSjNUaU1pTnIxRUVvckJjMC9PRWxs?=
 =?utf-8?B?TmkyMUd3eTNHOWpZV0JTRENSMGJTb0dKbHErenduSlFUN0pBWktabWUxZDR1?=
 =?utf-8?B?dk56UEkyMHhsc1Z4Si9haTVMQjkyNmZuSkV3d2VndHpqbW5OZmR6NUFBdEtz?=
 =?utf-8?B?cm5BK0hzOTduNnNObGJEVlR5S3I2ZXdMc2Q1bWpacnU2U0M5dndxTFJFZVVC?=
 =?utf-8?B?WUNnWGwwNnV1NTRDcEY4cEpSOEhZbTQ4ejJvdGdVbGVDWFJ1cHFnVjNnMFpl?=
 =?utf-8?B?ZUFWUEJFYzVXSzEwc2h4dnBKMXMrbUFPU2ZVNHJJSzBLRWVNZnRqbzVKOVND?=
 =?utf-8?B?UWVYWk5xT3JpUEg3QVN5QnF1dGFKNzhHcmtOWHZaUTUxaTVKSFRpb2puQWhU?=
 =?utf-8?B?RmpyUnZIancrOVdWcGRYNmkrTVBEM1g2YmNQMXRBcktDNnRxM2lmUjJJWUFC?=
 =?utf-8?B?YXVOZFRpQ3Z0OEdRaTJBUTUrUFV5a05wV2ZEby9CTys5Zi81Q1A1STY3ZGhH?=
 =?utf-8?B?S3o3K0JpMSt4Q3FnV1d6OEplUU5GUW1BMUdzVW5PWHBLTkxtTGs4Zko1SlFw?=
 =?utf-8?B?UmdpZ0VYOWJ1eGIxZlBMYW1YSkNMZWsrbHlxekl6c3BSSUpXczR3OEpHQk5L?=
 =?utf-8?B?ZVlDa0loandja29XQklZQjhZQ083UzB4K3JWOTQrdkhSSDEzRTlXdTZyS240?=
 =?utf-8?B?enJ5ZXlUMlg2Ym9lVGJiZXFRTzNoNkh4WDlNd2MwRjczcEZmTzlKYkVRcHdl?=
 =?utf-8?B?cEVOTU83L2JFMHBISW1zMFVyYkh5YkJqRmpXNkt6MVh6K21BZVhISGh4Wncy?=
 =?utf-8?B?bEVrVVNvblFXaldqaHVrbms0dVhOWGZVcTk2VkF3SWNZK3pOREM1cDh6QTN2?=
 =?utf-8?B?SmhYSUlhOXdhUStFa3JtRWtWZTFGdGw3aGtmSFJjWlRRdllHejk3U3VxVXJx?=
 =?utf-8?B?MkdDVndtQVI4WUk1S0x6V1FyYTY1RUtCMzd5RGwrSGxUU3ZRWkJ4Q0xaUWha?=
 =?utf-8?B?STVTenJ5Y3NyVU44N2F1aXI2MnR2VzcvQ295Lzh0N240bUVIWUk1MFVKaUsx?=
 =?utf-8?B?QkdQRzJpUkRPZTQzdjZMVUtZWWNUNXA2Q1I4bEE4RlkyK05Rc2NmOE1rVUdD?=
 =?utf-8?B?R0UrTTYrdDJ1YmRDNERtTW1nSFpnbmhvSHBwN1RrS0JYc3ZMYU1WMVlObmJ4?=
 =?utf-8?B?d1dPUUduKzBtQXVDSWdUKytTM3o5dFduYVREZWloMitVa0YxNDh1ZUYvLytU?=
 =?utf-8?B?QlY2N3BLaldlV2dnQXlEaHNoMDRzYW5BaFdiZndBeEtmMDdWTHF1eUNBdW1D?=
 =?utf-8?B?Rm1RMVVMZGtZenhzNjlaTHZhYTl6RVNuQnEyWlVreWxiY2VQK3JISkw4K2U5?=
 =?utf-8?B?bGZ1V0hubUpHckJYajRiMURxSGtFbzRrQzcrOTg0KzBJQjF3YlkvL29KU2JB?=
 =?utf-8?B?MGhNNDh4NnRXbWhTQUhwK3FEMjdqT042K0gvdmNTazlKbTdtbnRyVTlxcXBU?=
 =?utf-8?Q?xVMzdkGW5YXil4MYIiX2cBJc0V4+3pcqfOGV8k4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c149d0-4b80-4bab-a2c6-08d932143a14
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 04:47:50.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0RVt+UJxiqguBAqzINKry4vZIM30/3BDpiLdLHf0SfJ6Nm+S1VIzXHlUK7J3qu6sR8n4KS1C5pIPUBu+EitRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3445
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10018 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180025
X-Proofpoint-GUID: vpJ78MZXmDkGdAywl25f8s0FcOXqRsvi
X-Proofpoint-ORIG-GUID: vpJ78MZXmDkGdAywl25f8s0FcOXqRsvi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/21 5:21 AM, David Hildenbrand wrote:
> On 17.06.21 11:26, Naoya Horiguchi wrote:
>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>
>> Recent changes by patch "mm/page_alloc: allow high-order pages to be
>> stored on the per-cpu lists" makes kernels determine whether to use pcp
>> by pcp_allowed_order(), which breaks soft-offline for hugetlb pages.
>>
>> Soft-offline dissolves a migration source page, then removes it from
>> buddy free list, so it's assumed that any subpage of the soft-offlined
>> hugepage are recognized as a buddy page just after returning from
>> dissolve_free_huge_page().  pcp_allowed_order() returns true for
>> hugetlb, so this assumption is no longer true.
>>
>> So disable pcp during dissolve_free_huge_page() and
>> take_page_off_buddy() to prevent soft-offlined hugepages from linking to
>> pcp lists.  Soft-offline should not be common events so the impact on
>> performance should be minimal.  And I think that the optimization of
>> Mel's patch could benefit to hugetlb so zone_pcp_disable() is called
>> only in hwpoison context.
>>
>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> ---
>>   mm/memory-failure.c | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git v5.13-rc6-mmotm-2021-06-15-20-24/mm/memory-failure.c v5.13-rc6-mmotm-2021-06-15-20-24_patched/mm/memory-failure.c
>> index 1842822a10da..593079766655 100644
>> --- v5.13-rc6-mmotm-2021-06-15-20-24/mm/memory-failure.c
>> +++ v5.13-rc6-mmotm-2021-06-15-20-24_patched/mm/memory-failure.c
>> @@ -66,6 +66,19 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
>>     atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>>   +static bool __page_handle_poison(struct page *page)
>> +{
>> +    bool ret;
>> +
>> +    zone_pcp_disable(page_zone(page));
>> +    ret = dissolve_free_huge_page(page);
>> +    if (!ret)
>> +        ret = take_page_off_buddy(page);
>> +    zone_pcp_enable(page_zone(page));
>> +
>> +    return ret;
>> +}
>> +
>>   static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
>>   {
>>       if (hugepage_or_freepage) {
>> @@ -73,7 +86,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
>>            * Doing this check for free pages is also fine since dissolve_free_huge_page
>>            * returns 0 for non-hugetlb pages as well.
>>            */
>> -        if (dissolve_free_huge_page(page) || !take_page_off_buddy(page))
>> +        if (!__page_handle_poison(page))
>>               /*
>>                * We could fail to take off the target page from buddy
>>                * for example due to racy page allocation, but that's
>> @@ -986,7 +999,7 @@ static int me_huge_page(struct page *p, unsigned long pfn)
>>            */
>>           if (PageAnon(hpage))
>>               put_page(hpage);
>> -        if (!dissolve_free_huge_page(p) && take_page_off_buddy(p)) {
>> +        if (__page_handle_poison(p)) {
>>               page_ref_inc(p);
>>               res = MF_RECOVERED;
>>           }
>> @@ -1441,7 +1454,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>           res = get_hwpoison_page(p, flags);
>>           if (!res) {
>>               res = MF_FAILED;
>> -            if (!dissolve_free_huge_page(p) && take_page_off_buddy(p)) {
>> +            if (__page_handle_poison(p)) {
>>                   page_ref_inc(p);
>>                   res = MF_RECOVERED;
>>               }
>>
> 
> Just to make sure: all call paths are fine that we are taking a mutex, right?
> 

That should be the case.  dissolve_free_huge_page can sleep, so if not
we are already broken.

-- 
Mike Kravetz
