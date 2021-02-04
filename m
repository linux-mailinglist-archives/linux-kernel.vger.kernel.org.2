Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752DB30E933
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 02:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhBDBNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 20:13:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39312 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhBDBM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 20:12:58 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11414ecb161399;
        Thu, 4 Feb 2021 01:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fQWnCluRCGxfDaqBtqNtaI2qf5kcniI0X9tPFQO0Ad0=;
 b=GzOxaZulcInWrDK+X+ZnNjR5lkOG7+6IjQmWhWzwgE/ttScdamo1vsfIW5UD/y7mM0q+
 QjOM0/HgtO0AWszIzNWhzZ7ra8O3Jcit8x67w3+r6YgdypxXnCbgSxjcWZh0RzezbOUT
 xd+6V4Qy9caSZSX29DU/0ctuLWbrMEFiL3lFz9ejVB74nFf2Ku1UdZWeLG9V2jLW6wrn
 AJGkHp9RMYWh8RfJYDcc8w3J4AlNHw7CYo4Z2xJD7gK7VO+pQCUztuzdfDiNGos5fWjA
 iFawrGgznVaSNt49WuZv6gU4qMF9nmfx6d2Zc+ag0Lrp1QKfx/tY94kxCUYcpIv2yBJp Mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36cxvr5p8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 01:11:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11415aPf050589;
        Thu, 4 Feb 2021 01:11:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2052.outbound.protection.outlook.com [104.47.36.52])
        by aserp3030.oracle.com with ESMTP id 36dh1rrmp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 01:11:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnR3Qg+qEO41cYsUbJLHvSSCv6OdjqiSP5bDwT3IQZtUkkLpubWUcrjkwXCFgHoNYAGCkEexl0HrvosgrU6s9TVOeg2QtWGPcjSjMn/Yl/V2hwVc51rXSpXtYzKMLWhQ7FYYb5Us2l1aMN6aAUuxoE4+Art5GJDJBbrYFRKw7nNoNvmf4dHc8dqt83XQh6/92m0Uz48r6OttDzYYcYRxY2RIRaBmXq/K8+luXacMOiy4kGU0eXRlIrIouepThPlISHArppAG/BgDYqDR4CHWuwpaC7e91aj6YDm40iCIpcCZ7qLdGFnQw+ebAaOFRTEmJ5rNOF1lYsWIjphYKZ2Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQWnCluRCGxfDaqBtqNtaI2qf5kcniI0X9tPFQO0Ad0=;
 b=Pjv0Wb82kywohaNqvPcZTOvCWH2on/0UiW+OU6JA470XISGtWb94ipqgup8Z0v4JgKNOwXfvTBclwHN+HQ7EJGP8Lws31kOeJ4J7g4NmrJaDqqCwPFh3TfhuiSx6Eua+i3z0gcT8bt8i8T1QC/dzoYMIGtVmhVWnoZIhaHvnvA1/tzbuj8ufgf1SN9hjkzaj/D14kMW6MBeboI5I6/0jpdHi43gSWjHz0vR7CMYu4ZQ8Ii2/V16s6Wu2J9CFoZZSaKzhyIOqqGqTWn2NyXxIDl6GgwkTrIiU4DfRAHM8AKJT60KsbVEsOEYSEOoIpLp6xFpWHP1xF/Qi64+v4VHkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQWnCluRCGxfDaqBtqNtaI2qf5kcniI0X9tPFQO0Ad0=;
 b=iakVk+KwFQlZi41Sm6TeDbyKKeuKm0YZQb9X/oqP//1Hh3rVXiaqUARiY8H5Um/qZjT0Og8+hDsNNM7bUUWfdJvF0rMgex9nc3LKNwEQYLsA7iIFI/T/4B9kKWvt2fL8LC5k+NWiGzi6dT4/c/aUfC5AFPqEEbVcTO8CV5TFO3s=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1856.namprd10.prod.outlook.com (2603:10b6:300:10e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Thu, 4 Feb
 2021 01:11:42 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.020; Thu, 4 Feb 2021
 01:11:42 +0000
Subject: Re: [PATCH v3 3/5] hugetlb: only set HPageMigratable for migratable
 hstates
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-4-mike.kravetz@oracle.com>
 <20210127103523.GI827@dhcp22.suse.cz>
 <2196d93e-f573-7163-183e-0ad2cec7555e@oracle.com>
 <20210128055221.GA3166@localhost.localdomain>
 <20210128133733.ce1fb2eac98ab5696c08f288@linux-foundation.org>
 <12187293-e972-acd8-7789-22ebfa736f95@oracle.com>
 <20210128141531.17fec31e6075fe0eb6e33683@linux-foundation.org>
 <62a80585-2a73-10cc-4a2d-5721540d4ad2@oracle.com>
 <YBfqzlG1C1mtKj4Z@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9183032f-3d77-d9e3-9cc8-fbaf3e892022@oracle.com>
Date:   Wed, 3 Feb 2021 17:11:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YBfqzlG1C1mtKj4Z@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR07CA0045.namprd07.prod.outlook.com (2603:10b6:100::13)
 To MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR07CA0045.namprd07.prod.outlook.com (2603:10b6:100::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.21 via Frontend Transport; Thu, 4 Feb 2021 01:11:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d3d6232-422e-4459-d733-08d8c8a9d52e
X-MS-TrafficTypeDiagnostic: MWHPR10MB1856:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1856169507D6A64576C907FCE2B39@MWHPR10MB1856.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQEjnM2mOiXYC6yccoxFAZEqBibm7IkOJH9P0DcS4vM7hN+z6lJyC/0gy9aHn6ML27ObUZ/ALV0seIVE6cy7wPdVhhY14EhsHzshCItqW7xPm/CoLudoMgx2FHrfyY3vJkvByfqWA8Kl+TYkkd5fdVFiUOtVQ4I+vx71pXR+NFZ1AscPvFAx+GfYZq3ypHJmcQZv70ZnE+lFjCmV/Qv+qShGlUibwDfUv52WlySC6x5fJKnYFnzMFTP4SPqXweVLPWPcgf7dIDk7VpDMwJRxmndRsNxnvBbtHtyxXwdKBokuKfa+oxDYORfqkOGeo/pg3HjxqZXbkWsFwoRnfyTjXyfnng/otrdbNIOI5/VdLkdXvyi+b1pGHTD1aND99RE9x/LsBhGPtIez+n6vZ3gx7B1Wvrizyki4i+csl2yl1Zo2PIo2ffgQ65mi0wqV/MXdJ2HSXLsoACSWNDJWfOaFv8f1Zczb7scNCeiUVpJzX4wRrom+l+jSb4PG2I+6cPefhl+NxX6x6RGtsMSOEzxmwNJVkXfYkSX1Q/MNAP+B5F+eyxfAk11wWaAQ8S3To8LCeAkJTLHruNQDFQNry9Te9uY6KZKAeUO8TAVfJGX0al0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39850400004)(376002)(346002)(136003)(86362001)(6486002)(5660300002)(53546011)(8676002)(26005)(16526019)(52116002)(66556008)(186003)(66946007)(66476007)(36756003)(8936002)(31696002)(83380400001)(316002)(16576012)(54906003)(31686004)(478600001)(4326008)(7416002)(2906002)(44832011)(6916009)(2616005)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZXFyazlLa1h5cmViUE80dENyc2NadWhWTkR4SG12M1FkcCt3SlU1QkZ4WjR2?=
 =?utf-8?B?VzdUNU9reGd0S2RJK1lMVGFERmlZYUVKNUxnWGlhUUZYbnYvNHkrdzh1ZEZw?=
 =?utf-8?B?dHlOZUlXd2hOTmhKdHh3ME1uS3VhRUZXcEx0eS82RlI3amJOUUNrTHYwaFM4?=
 =?utf-8?B?c3gycm84TXhZeXo2OXZzU0tDZ09SYlM3MUhGSHhGVEtLeitSM3ZwYXB5SHNw?=
 =?utf-8?B?b0o3V3VXZmpwYXY1L1hDR0dvaS9Kanh3dEM3eU03MWFTZUFCVzBSNC9LaDQz?=
 =?utf-8?B?ZmV5dDJuejk1dzlJa1o0Y2t4cWtCaEVpYXROdlRRZFVibFpsWUQ0OXVaM3BP?=
 =?utf-8?B?RmwzL2taTDhUNTZuaG4zUlhiWS9PMnJZeVI1ZTNpenhKclZtTURhaDFZc1BX?=
 =?utf-8?B?L0FiYThpN2l3aEVKTHpobjUrUWVGVFZhdDBFeGFCK2o4UUpTRGZLekdFZ2lG?=
 =?utf-8?B?Y0p1Sy91bS91dDM4eDdsS1JWekpGS3dGUnhZV3c1TzVkaGxCZ1FmQk1pUEZW?=
 =?utf-8?B?b202SlBoaFdPOFltV1JVUHFOTDNFNExMSDVZcmJzUmRUSmc4dzNOVHI3ZFBP?=
 =?utf-8?B?Z09SNUpIcVFpMnJ5K3BPeFZPQk5DZUJFbVZoSGIwVUZCTXE5RkZBMFpYOEZa?=
 =?utf-8?B?bE5haU04eGhQUnpHQmhyTVFYZzFNVlZUczlWdUVKT2dJZ1pQejF0eFUyc0pS?=
 =?utf-8?B?bUloVW1LL20zazkyWjN2dnhiOGlocjdQWGpLZW5RSldESWxzRXg5azRqaUoy?=
 =?utf-8?B?Zzkxay9yV1pseVdxSlNBRVhaRjRqQk9wemNGOFJUemdGMTVtM2kvek5LTWQw?=
 =?utf-8?B?UWpvTDhTZ1ArUmVjWDZJdU85TkRuRmVCcTJpdU5aWGFYTGhqL1pkTzdOdHRy?=
 =?utf-8?B?VVE4eU01NFJ2QjBxbHd0RlhPbUU0SzFiZGthT3pKcnRHQnBtMy82S3p4cFR0?=
 =?utf-8?B?c2M4V1RGSmFPTldaeHE5cjFDdFdISGN5UFpTQWVkWVBVamJMbVRQSkMvd0FH?=
 =?utf-8?B?bmlEZEFibVZwMEJwcHFRWjUzbkp1TG1kZ3FKQng2T210eUpZelpkZ1pZY1dp?=
 =?utf-8?B?WTJLdmZoMTlDcG80ZUt4UXQzV0crZHp3dFBZQVZVTnozRHJ4TFRoRkIzTHVa?=
 =?utf-8?B?dFFOSlhpTXp6M2xOMS9sYVpJa2hLOUhPUmwwcnd1bUZlZkpIck54SkxCejNR?=
 =?utf-8?B?akwzTWR4Y1k2OTVsOWlSQXBzUWFHTG10Z2pyZlE4eThreHowU3I4cXlaeDVZ?=
 =?utf-8?B?QmYvdnB0Z2QyN2EzK09UTm9WY25KSzg1V203UmVDdWZra3hNY0lUYWF5bEdW?=
 =?utf-8?B?b24xbEhRdy8zOW0yeDFQVGZlMVA1TXVmUi8yMldpL3FzNHV2VGJsVG0yeGJl?=
 =?utf-8?B?UCt5b2RvcGtPMmFnL0xuUVBnV0k3YnVpMUZYcE0vOGhlSFRybFV6U2VldWEz?=
 =?utf-8?B?RTU3MmRvaEpFdDVnNVM0NnN4d21rM0N1QzFzN0laVjlpNXN4WmEzckFMRExR?=
 =?utf-8?B?c3ovVjhocEQrQm90bkRybm9WSzlUZ1hzK1BySXlxNkQzYm5vMXk3RDFWU3RP?=
 =?utf-8?B?UldkQmRNbVY5M3FsaERscDBSSEFYR2dUSWZiWUw1Yzd5bTlqenlqUUd1dmor?=
 =?utf-8?B?bXF0WEtBc24xYmthSC8xOUNhcEFPVnNRUHNUZGliRCtCL1hlRWN6UUhwTWJB?=
 =?utf-8?B?elBhMlZITFphM3BhNUY5d0s3eGVvN1RpVTl3a1lNdXl2dkNOWG9PQWFocUM0?=
 =?utf-8?Q?WBYEzC8/iww1AasokhVssZ8e+PXdY5xoBXPNsWU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3d6232-422e-4459-d733-08d8c8a9d52e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 01:11:42.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypjqsbwhUzCApu/THxlRAINsfrBb7cd522aeS8qJ8Xq/cuRuqqvfuS3q3TCRP9UN1CTKj0J+byeSNn2w3c+Ucg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1856
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040002
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 3:49 AM, Michal Hocko wrote:
> On Fri 29-01-21 10:46:15, Mike Kravetz wrote:
>> On 1/28/21 2:15 PM, Andrew Morton wrote:
>>> On Thu, 28 Jan 2021 14:00:29 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>>
>>>> Michal suggested that comments describing synchronization be added for each
>>>> flag.  Since I did 'one patch per flag', that would be an update to each patch.
>>>> Or, I could simply add a patch to update the comment block based on what you
>>>> already have.
>>>>
>>>> Let me know what is best/easiest for you.
>>>
>>> I guess just one patch is best for reviewers.  Then I'll split up into
>>> a sprinkle of -fix patches if I'm feeling energetic ;)
>>
>> Here is a patch to update the comments for all those flags.  It should
>> apply on top of what is in your tree.
>>
>> From: Mike Kravetz <mike.kravetz@oracle.com>
>> Date: Fri, 29 Jan 2021 10:36:12 -0800
>> Subject: [PATCH] huegtlb: add synchronization information for new hugetlb
>>  specific flags
>>
>> Adding comments, no functional change.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks Mike!

Hi Andrew,

You may have missed this due to the depth of email thread.  Can you pick
this up, or would you like me to resend?

Thanks,
-- 
Mike Kravetz

> 
>> ---
>>  include/linux/hugetlb.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index e5e6ffd55392..cf70795d2209 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -480,14 +480,24 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>>   * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
>>   *	allocation time.  Cleared when page is fully instantiated.  Free
>>   *	routine checks flag to restore a reservation on error paths.
>> + *	Synchronization:  Examined or modified by code that knows it has
>> + *	the only reference to page.  i.e. After allocation but before use
>> + *	or when the page is being freed.
>>   * HPG_migratable  - Set after a newly allocated page is added to the page
>>   *	cache and/or page tables.  Indicates the page is a candidate for
>>   *	migration.
>> + *	Synchronization:  Initially set after new page allocation with no
>> + *	locking.  When examined and modified during migration processing
>> + *	(isolate, migrate, putback) the hugetlb_lock is held.
>>   * HPG_temporary - - Set on a page that is temporarily allocated from the buddy
>>   *	allocator.  Typically used for migration target pages when no pages
>>   *	are available in the pool.  The hugetlb free page path will
>>   *	immediately free pages with this flag set to the buddy allocator.
>> + *	Synchronization: Can be set after huge page allocation from buddy when
>> + *	code knows it has only reference.  All other examinations and
>> + *	modifications require hugetlb_lock.
>>   * HPG_freed - Set when page is on the free lists.
>> + *	Synchronization: hugetlb_lock held for examination and modification.
>>   */
>>  enum hugetlb_page_flags {
>>  	HPG_restore_reserve = 0,
>> -- 
>> 2.29.2
>>
> 
