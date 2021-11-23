Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B53D45AB75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 19:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbhKWSun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 13:50:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11910 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234139AbhKWSum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 13:50:42 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANHuHO8010833;
        Tue, 23 Nov 2021 18:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UJkr8pGJCJriFLVnlQUEqZNVd6/gANyh/uOsdWohUBA=;
 b=KvmArbfVb8lkPbanMul9U2JEjEFiGBBAtmyjU8nNS1oHej9IhL6vM+R79TUKaTAzOE5o
 iQm43aAZjUye/2dZirzJide5BWugOxk+RhCLhRtuIo8oPF9LseFEsnF0VkOgUXFlomuo
 4Ad5GgKcvP5mpV8T/dhoqpPHbCXu5/TId0OYAmNvazCKYpsIEuhzMkyqz5L47ynCmNVK
 oZyJD03IoQRxf5RrKgBXrH05lAsagDLa7e7fc7D6uvxNl9XiDfbN+qsB/KXhJ7uOcNBk
 eUIpyFL/5wFBeKiNDDoD+rwZSDtxkfP3ce3bvcQv/jeUb4QhqprTpDxC7y3L24pWx80Q DA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg55g488w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 18:46:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ANIenEa048653;
        Tue, 23 Nov 2021 18:46:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by aserp3030.oracle.com with ESMTP id 3ceq2eqph4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 18:46:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmFk2t3Z5QddG4IAFbpiicpyZotchNOHmv95Ndr2tfufNPBH6PxU+bzv+fmGCv+3uf6nDCzktBZGS7dg/yjkkRlZ0KVACcqHKrQlj+U4Dd6iwmU9lH7N/I9Y8wwCS+zhbJ6Sqx+laKx8oaO12L8tFW7Gkp3N0LSZ7X6FlqK5WGbU8ptV55nU/sh6+41b+M3mvh/qMNtwPwKSQRCt0nIwwnFo/0zY2mXEapHXDTLkZPAW5caj58Ldgp3oH+12btkzAGSZGmf24PSnLDnlVm6ubR1xUNeWlLPnDDY2aK5PfvSDmeCQopxGQvjxj+wjw1A44RzUoP0Fx3pvdM1sojvhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJkr8pGJCJriFLVnlQUEqZNVd6/gANyh/uOsdWohUBA=;
 b=GBK1cn7F+19GfjbvDiQEVNCfCg6bArgok3Kcj6dwgmUUQOxSxi+h/cp9E0HgNqq/12OvvF7NJFQ9h7PvHrUUMkEvH2dKCIWcPGsfE9A61dATRJc+4Jg/ltY9xefSvqYTC6kB7PLfpJEyXuAHopI3ob1o0NBB5MuLTQzq3vgdwneT7Qa7J6AkpjAof3jiS4xeI+9IENZrYBh2ToBey9KaIVWZWg3vW7pCMu2/HB9xvE3zOIdV1/XcGfTwIJGta7GHft0RfOIeY/DIqwsb0kYWYHGWboI4xBz/ho2iU12M5zWbyhFGOvTLbGBpQpa14efceKevUXnjnzyE2MKagpNcxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJkr8pGJCJriFLVnlQUEqZNVd6/gANyh/uOsdWohUBA=;
 b=v9vwioQky1ahDVY87EWoTSCaCJuU1HeXA14c94EDFozKhoLfBvEZFoig2AGV6z2hognWZQ2LZiyOOpYeZrPHL0aMr7/ZodIUzsivXWHQ9x3Nv+i8VK9i9EBbwjydmNeDCNi23z/vL7FCKKQvZwhSe7Jb98Bkmw6xDm6wDtez2IQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4541.namprd10.prod.outlook.com (2603:10b6:a03:2db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 18:46:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4713.021; Tue, 23 Nov 2021
 18:46:06 +0000
Message-ID: <13b2c5d1-ef3b-3e29-32fe-cb4294bb1531@oracle.com>
Date:   Tue, 23 Nov 2021 10:46:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/3] mm: migrate: Fix the return value of migrate_pages()
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     ziy@nvidia.com, shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
 <6486fabc3e8c66ff613e150af25e89b3147977a6.1636275127.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <6486fabc3e8c66ff613e150af25e89b3147977a6.1636275127.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0373.namprd04.prod.outlook.com
 (2603:10b6:303:81::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0373.namprd04.prod.outlook.com (2603:10b6:303:81::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Tue, 23 Nov 2021 18:46:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f4608ed-77ac-422a-83a5-08d9aeb1822b
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4541:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4541647865B353FC9D0DF5AFE2609@SJ0PR10MB4541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9e7Gj3oR9R3iOHJvBBOBJuePLp/U5v46Epl4KJULo7LwYoAkRcevQoe42TW86pC+gJldBfvqtpuQ5KYCV896gM/TodrRNDQDp7nAkc1FdJMUgulQhuTio6Oz/tK3d+C3DIM5BigVtaZX5hjXAeYsTOhN2X1M1D0raai5x5nh4iYZwm/yH3m4LJrlzLw5JZJW3l1IsJI/s87Y4pPP3aykLCLH6jMqwAmdLu0FTxROTVotbAg7uVgVe+OY6a1kWgTei0THDyquFDR2sYRMw3OvPXlswpPHGTxdjs0yE6WIcFYox0+HKBCbPn/ML8vR2t5NaSpAXwb8e8C8kIbLvKcTeP90mu9MfxRd+9bEL+xsQspyo9c3b8un4YnYeEIZsg5kpzwZNp5cuWsowlaWgBoF1P1WaJu1zE+vHd8UfEWLPBaKIbK3rnFgJXWZaQse0ZYi+4xcXYWCOoi9xZu3RA9qSzh9k1f1dibmOOicvmT1E5uxHog9UxHsn03cXLT4SoRf+JgReYZs16xQgzcUqwaUb9nnTQQX5jlObA+UmzWrZyz7CeWKM63oymn38NbqVznhb8U8X4ZDF2Ob3VPf3EIygFOqNdc0Mam/BNRfBgasX5KJjv82BNG84D+ZHTyrzTlaasfv5WV6XZ5xrVw4fVtttgVPZSvS3eFTRxXTJnES07cDebeeWQ3CioTeYs4hHF5S2HAoUwRx8ltj0h0wYtpzXJgnK3gjISwZfBVijKT2ZAyKLm7HUnDnZUJVgy7X1qq89JMnvfuJrJnmhS5qII1J9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(31686004)(4326008)(52116002)(26005)(8676002)(8936002)(66476007)(86362001)(44832011)(66946007)(66556008)(508600001)(36756003)(16576012)(316002)(31696002)(186003)(2616005)(956004)(53546011)(6486002)(2906002)(5660300002)(38100700002)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3JrN1dWOWs2Umhld0x3bU50aFUwUFRvb0VmU1pGWEFRSFdCSWxmdllXY0xV?=
 =?utf-8?B?NkZPcjQ1TmJlL0NXRHU1VjlwVmxIdGVrTHNRQzlFcWVzTVYxTysyRGYxU25C?=
 =?utf-8?B?SEVRSnJidXJhR0VkQkFqS3VMOExESUZ6UExHbHh2aHVaalpDZmIzUzQyUlhJ?=
 =?utf-8?B?alQ5WUtqYndmcUNqTU9QWkxndG1mc3FsUnJuaUpEbnU4dDdNUlYyK0ZSL2pu?=
 =?utf-8?B?U2VyeFpFdlVTTDJrbEl5WDVzWnByQUtKODNPTExaSVFGakxveTdScWc3WUNB?=
 =?utf-8?B?SWp6cHAyVHNLL2UzMHNFcGFNWk5rL1NEL1BITW1lazgxSitTM2o2NHVnU1Bk?=
 =?utf-8?B?MlZqVHJmL0ZZcmg3VFI0OVlTbElEK2J0bnRibWEveG5pelJCOGtMWHNQQlQx?=
 =?utf-8?B?N2NIQ3Zzc1FXUm92OWJVNGcwOFhTYS9wQ1Q5U2JQSmdhTmhCRTFvRlpmb3o2?=
 =?utf-8?B?QzdwL3E0MDFHdksxRjJnZVA0KzZQMU53MDI0YW9hT1JpQ0hYdkVEYi9ySlJx?=
 =?utf-8?B?T0tuemVodEwvRkdJYlRJOTh0M0M0ZGI0ZGg5MEFPR0h4Rk5HUXpqTE5kRDl0?=
 =?utf-8?B?ZC9kTHl3eEkrTzVtL245cWl5Q3IvQ3k2blJnYlpTMXIwa3JjUlZVYVNQMDFt?=
 =?utf-8?B?VDlzQ0pWbXMwTUhhUEo4TzZBYkxPRzdWVVdKeHIzSG04UTFKSEw1cXdZYzZT?=
 =?utf-8?B?Z3dOcEljTVREUGVCckdKeUp5aWpQVWQrcGpWeHhvLzdBdUtBdFB4MHoyTlJH?=
 =?utf-8?B?R2ZnTURqeHhTWWtUaVdGcWpkNUtVNHdoakFSNk1MeTdRem9ZVWtRMXBWbFR3?=
 =?utf-8?B?YXBxRUhISFlxeTJxcnI2TlB3aklzcnFwQWR2WGZTVWlCa0I2TjZzV2ZhUU1X?=
 =?utf-8?B?ZS9ZbDVMM1drWVhZL1VoeWNoNHhPcG0vNnRkcE4rUWtQbWdxekIvKzFBZ0VY?=
 =?utf-8?B?S3hTL2pZVUI2WTVEYndBTXdKbzBFTmo1ZlJ6LzF5dE9SVmRuRkZza0w5WXor?=
 =?utf-8?B?SDNGcXpKYVhmWng0UXZUVHlGWlAzY2NyelZkcXpXUHM4bTJOTEtVajF1NW5F?=
 =?utf-8?B?QmFsb2NQTmI0RUNlZUNWa0J6MHFWdVJuYlEzc0FTaHQ1d3JGZHBxWHBEZnRp?=
 =?utf-8?B?Zzg1UU5sbndmNk5NaDk1bk1MeG82a3BMQ3F1NUtpUFYxNkQxQ1ZycVROZzR4?=
 =?utf-8?B?dFVQcnR5dno0NTRrTE03UUV0ajJrT0NLQlBxZStYTFJsUDRjZzM3RklpOGFL?=
 =?utf-8?B?WTRDQkwwdmRLWE9vVW5QUmcwU3RhOGdTaXMvVHdKWTdYMk5IVzlML0tSOGNP?=
 =?utf-8?B?VHRwNWdZSkZncDJ1YTM3Y1ZNTU40cWNURzRLTjhBbjk0OVlCdFFGMzAySG5s?=
 =?utf-8?B?TDF3T1ZWQ0I4aDYzLzVlSHJ2Sjl3K2l2UkV1UmJ0dkRDWWpHZlVjMEI5cWIx?=
 =?utf-8?B?ZThoVjNYVE9YODhocGtYM3dINGdpRGZLMmNSa051a0hJV2ZvRTB4c1ZBcTdz?=
 =?utf-8?B?dlFaNUF0MXFCNVYxc3hWQWI4bVJmRWxGWG9abGQ4aTRvdWcyVXBBZ01maGNC?=
 =?utf-8?B?dmJEeHcrb21iQWF4bWx3d1l0Q0JrVk9Gekw1ME9yZXNDemhpeWNJV2gxTjc2?=
 =?utf-8?B?ay9laWM3S0J5NTJmc1RSZ251WGZiSDF4RElyUUxJWitkT09HaStMYWEwRlEy?=
 =?utf-8?B?NGQ3aitWaFkwNFQxYlV0aE1ieXdTVjFBR0FLUFZsc1kwaFhmejlDTjM2UXo1?=
 =?utf-8?B?N3JkbG83QzZPZlhNbklWMS81NWtGeEF3a1BWalVUbnRPZERMSGNXWDNSc2Ft?=
 =?utf-8?B?T2dBbTRneEZBb3d5bjU0a3ZmL3RXdVMzWWI3MFRUQmxXTURRd1NtS2ZFRXNM?=
 =?utf-8?B?Wmk4OUV1SURQcmNISGZqRjBiUS9hVlRCRmpQUlVXWVh6ZVJrY2hNMmo5RDhL?=
 =?utf-8?B?dkhmMGp1RzRtVnkrMHNCNkV0L2EzMmFhWUZoZllYNGVOaU5EYXJSS1NGVFl0?=
 =?utf-8?B?TjhVcnhsYTZIV2NWSlFucmZLbUtzK2RodmhIVWlIanpjRzFYdTNMa014NUlT?=
 =?utf-8?B?NVU0R3VVM21rQ3lETEEySW1mdUgrajk5SU9oT3JiYnh0N29BdDc2M0JoUmhO?=
 =?utf-8?B?MkxjdkM2R05tekNhMW5OamJLQzBIbnN5enkxSDNMRFlkVTFDTWdZcW55dTB5?=
 =?utf-8?Q?sCSZnOmhgEipkkt6lNTrrsA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4608ed-77ac-422a-83a5-08d9aeb1822b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 18:46:06.7762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cnb2JbfUC3cpwaet1gpojYjYY0tm5peowBuZtE0zuoI3zD9FPbwHXrqDCPLL88+qUR37rMWkROlJBOZ+E6Il1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4541
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230091
X-Proofpoint-ORIG-GUID: B6WOUaKSPEjAd2CiT9peuD7y02_dTTIR
X-Proofpoint-GUID: B6WOUaKSPEjAd2CiT9peuD7y02_dTTIR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/21 01:57, Baolin Wang wrote:
> As Zi Yan pointed out, the syscall move_pages() can return a non-migrated
> number larger than the number of pages the users tried to migrate, when a
> THP page is failed to migrate. This is confusing for users.
> 
> Since other migration scenarios do not care about the actual non-migrated
> number of pages except the memory compaction migration which will fix in
> following patch. Thus we can change the return value to return the number
> of {normal page, THP, hugetlb} instead to avoid this issue, and the number
> of THP splits will be considered as the number of non-migrated THP, no matter
> how many subpages of the THP are migrated successfully. Meanwhile we should
> still keep the migration counters using the number of normal pages.
> 
> Co-developed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 63 +++++++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a11e948..9aafdab 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1428,7 +1428,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>   * @mode:		The migration mode that specifies the constraints for
>   *			page migration, if any.
>   * @reason:		The reason for page migration.
> - * @ret_succeeded:	Set to the number of pages migrated successfully if
> + * @ret_succeeded:	Set to the number of normal pages migrated successfully if
>   *			the caller passes a non-NULL pointer.
>   *
>   * The function returns after 10 attempts or if no pages are movable any more
> @@ -1436,7 +1436,9 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>   * It is caller's responsibility to call putback_movable_pages() to return pages
>   * to the LRU or free list only if ret != 0.
>   *
> - * Returns the number of pages that were not migrated, or an error code.
> + * Returns the number of {normal page, THP} that were not migrated, or an error code.
> + * The number of THP splits will be considered as the number of non-migrated THP,
> + * no matter how many subpages of the THP are migrated successfully.
>   */
>  int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  		free_page_t put_new_page, unsigned long private,
> @@ -1445,6 +1447,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	int retry = 1;
>  	int thp_retry = 1;
>  	int nr_failed = 0;
> +	int nr_failed_pages = 0;
>  	int nr_succeeded = 0;
>  	int nr_thp_succeeded = 0;
>  	int nr_thp_failed = 0;
> @@ -1456,13 +1459,16 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	int swapwrite = current->flags & PF_SWAPWRITE;
>  	int rc, nr_subpages;
>  	LIST_HEAD(ret_pages);
> +	LIST_HEAD(thp_split_pages);
>  	bool nosplit = (reason == MR_NUMA_MISPLACED);
> +	bool no_subpage_counting = false;
>  
>  	trace_mm_migrate_pages_start(mode, reason);
>  
>  	if (!swapwrite)
>  		current->flags |= PF_SWAPWRITE;
>  
> +thp_subpage_migration:
>  	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
>  		retry = 0;
>  		thp_retry = 0;
> @@ -1511,18 +1517,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  			case -ENOSYS:
>  				/* THP migration is unsupported */
>  				if (is_thp) {
> -					if (!try_split_thp(page, &page2, from)) {
> +					nr_thp_failed++;
> +					if (!try_split_thp(page, &page2, &thp_split_pages)) {

Does thp_split_pages need to be initialized before this call?

-- 
Mike Kravetz
