Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6031F3E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 03:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBSCMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 21:12:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53016 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhBSCMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 21:12:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J2B71x192964;
        Fri, 19 Feb 2021 02:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yuDq7OQLvcFaYl98SOjJZDjt22BmiLSTgx9uBb6pMSI=;
 b=zyXde6z1yOroUE/d55HUUw+BUnpeCj5zHbvtXUBKQH8syo06OyuNWGnPppX/3w5lpgu8
 5pHw9nYxse/gfSXCvEqlAtod+cFXCFLfT8CL1xxhtsSTGG2EOr1KhwQYMuuGpCd0I84h
 3+jdikLNZRFbEaqWgkpMfAbpYcB5NQMAvk3N5BEr5eGC4fBzT7CFi1eREDl2uPjwmzD/
 //7p5Ry7BBkIFxUuk6giasS5ZfAPmZwpDG6YfRjZZ0No3Od1aloicIeFo6twDoqnSUry
 X0zS9bVVdklQsHjUSBBSSksSJL+qAzZLB2nv1Mmc6hKznTYiCxZUWt+3rjmV979ag0f8 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36pd9affqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 02:11:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J2ADSc163543;
        Fri, 19 Feb 2021 02:11:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 36prq1a2en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 02:11:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZnTaoQeOCP4Z8WwzJ9qje3y+k1v0Iqh3lLRmCYc1lv9HNcQC70Z/QlDEMnm3DQ7kn3ORV7a75NINnPMcDfkDzkxEwGoBGevpA/j1V9KtEwkVXGTq1qxeF79BstfS11Hnv43OBuczNXmRqdDzDNJbXbY6AerIkn9e1JZqSsASloFi1Zv7mBgyNaCKJJNC++QsXYyNvMji9odhX5ZJ7sQk5rY3E81ALiGaoPL62upYxod8ThnH5Gy1kO2KEHraIjnaU84grpDvBsW5IKDDudvJB/QHsCT9erulnihubzUAqbAoGud5qFgyHOcYRg4LyQ9fZs5DWK+kfQZHBjYp8GxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuDq7OQLvcFaYl98SOjJZDjt22BmiLSTgx9uBb6pMSI=;
 b=W8S7e8jOtGNxpC2WFeVmD6CTCrL8PqbBBYD8fuRdD3h873GgTH4CC+8Kc77MJtY5gEN28+/gqKkxIqc9fYuaaM5oLAbCs2ZrFjOUSxYkBny+YA98n3CEyZjPgb8FL5SAR2REEVunJpR/CU6VuGvuKnI6jOt0ysmu+gL30YaRYVvxtzU2ABlQD2U4D7cCibg8nhjCk+yOAj/CIUl197xrMz0c7wj1RHdOhq3qreg3D0WO6BUIfSrJatjlXWccwvZn78IKvu8HGUN7j/GTBd7+TqZatfDhNy1aK1pVGNFhHRLEL/kZJ5gLtKfSf014xxs7nEcHzJccq3F6IOQ6AbE/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuDq7OQLvcFaYl98SOjJZDjt22BmiLSTgx9uBb6pMSI=;
 b=JnC/EmmTO9bqowbpPovefLWvGLJwgJgIse7fWWMU4/pvU09lyzOQhwrQH22zRq49zYGXIvlpoh7v+rsn/wtLGQyV0hNED5AVo1hptSxdh97Qq+8Bu81N1QMcGHGYaD31lN9V7fMdTSa2UMcoRPY/WcXg314G1fXK66upW95tF/I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Fri, 19 Feb
 2021 02:11:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00%4]) with mapi id 15.20.3846.041; Fri, 19 Feb 2021
 02:11:04 +0000
Subject: Re: [PATCH v2 1/2] mm: Make alloc_contig_range handle free hugetlb
 pages
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210218120028.6499-1-osalvador@suse.de>
 <20210218120028.6499-2-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9a902aae-7478-4287-ad5c-f6b0b7fdf2ad@oracle.com>
Date:   Thu, 18 Feb 2021 18:10:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210218120028.6499-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0064.namprd15.prod.outlook.com
 (2603:10b6:101:1f::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO1PR15CA0064.namprd15.prod.outlook.com (2603:10b6:101:1f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 02:11:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c763a76-3c47-4fb1-6ff2-08d8d47b9c35
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4654:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB465423FA1B4C48F05A691050E2849@SJ0PR10MB4654.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q1Nsi3mqIv6A/f32dgK3KoPjkRBwyS/e0/uYjm+OOGQp1zKV8pWY+9s1UN6OgSjN0hFx2n2E7JhvmLsrof3kOpnSv8SNhDbHV/i9Qx5/6qXNO5m16uBWlcIU9fI61tT9O6lzSwutHc4xf6kQwkWoN6MJBQ7L5b8bIFcfYWAFwqsOGT4pIl+NBqcsvRApvFLtR4MmYhTB4raVVP3lsz9pMMv8KvkdoR/Kbz+ev1NOa9XXqi9pAV9LmRiZWOKe2zq8Ssur8MvqZgMhNqCMG54Z/lGKJ0AcQoGaURPMhY8t+z+h04/svhswyr95g33S0wdjv6cGsQm24LC+EC3/pBL2UfV0EBjPrjFnxbwsktBcV/rdt8HG05prlUez2VBAYnix1xHpnco+oCtQxZJVaxr9+GMEI7FOvxil7T/GJ05B+lzbpKJ3BSlMHw4nrRAyKDDaOPUC3mJuaU17YhyzH8kLj6P8aV05HyMPMNhbF53hV7mbqV8hsfc5sijMfwbMbURGUwUFCkSBMZ7Ux0/4gYdPfqpAELrb8kV+dWGSbOPjuzxgtMp6n4Ghh8R6vgTPlTJUg5p1cDRD6lkKeOXEduIwT58j3Ec7gdyGAb8QQW9l2rMK1rI73sbn4wVNLKGIHC6q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39860400002)(396003)(366004)(4326008)(26005)(6486002)(16576012)(53546011)(316002)(31686004)(478600001)(186003)(86362001)(8936002)(83380400001)(8676002)(36756003)(16526019)(54906003)(2616005)(66946007)(66556008)(52116002)(2906002)(5660300002)(31696002)(6666004)(110136005)(956004)(44832011)(66476007)(87944003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ak5yd2JEVHRrSmhJdjRtRnFSVUprRVJSTTArc1YrZnRpcFEwelRFMEVhV1dL?=
 =?utf-8?B?Y2syR0dtbWhocDIrN0NXWUx3UG9QS1MzTFI4VDEzNVJaM0JXeDBSOUxIOXFl?=
 =?utf-8?B?c2hGMDBYVmdCdzRpRWUrOGh3RXM5T0FvMVR0WWtUS1N4V3NIK21oUFBUbCtE?=
 =?utf-8?B?V1h4YkxXd3ZXUkZRdDRsSEJPRE1NZFVQemxLa05WaDlyNTdFSnU5bnNLczNI?=
 =?utf-8?B?cFN4Y0dQWG94eHVScVNFam1FMFBHeDdseFM2N0xaZ2F3ZEc5czI0Mk5DZjhl?=
 =?utf-8?B?T1pFK3d4ZjF6aHl1Ukd1MUVlWWhqdWF6SVdqeDBORXNnVnM0eUtQalIxYS8y?=
 =?utf-8?B?YXdEeDNtc2tndzJxeTFuWkNaamhsTC9nRitnSVdTR1U5TUdwTjBzeFJjRFFI?=
 =?utf-8?B?RUFucEVXVkZVMjV3Um8xUE0wa2tnZC9RSHBqSUJPVmFGUjlkTi8rWW9XdTlp?=
 =?utf-8?B?bEQ4YTJoZ1luYnBsaWQ5ODNMcmVPQkxnQnRpOFl6dUtZRTF5YlM1K2lFcSta?=
 =?utf-8?B?MXFLaWtVU1JNdXFURG5jdUNEeUxDVGNnYnd4YTVHL0dKQk9QVkFvamlENWdD?=
 =?utf-8?B?QTBhWGh4eURHdm4rWEZPWWdGalRRRGUvYkpIMUNIZW5XblJSUWwrdStRazJ6?=
 =?utf-8?B?a0U0ZENUeHZ5Mzk1Z2JJclJHWUFrU2o1V1NGaExWTFVNRVUvbmZPZG5IT2Uy?=
 =?utf-8?B?Z2E5VEE1WVQvL3NqU1VKbU1FNWcvS0VUUUFmb1NROU5ENGQ2azZZaEszbzEv?=
 =?utf-8?B?SGNTWEttU1dEVCtnZXJZM0s5ZmF5bExpZXlYVkc3Q2UwcGdyWEhTYXh1RStT?=
 =?utf-8?B?cW93L0dhdEdlRHJGMUMrS3ZWa1ljeTR3a3RscERhUHV5a2dGcTV4SC9ackti?=
 =?utf-8?B?TWxMNTVxbEVRRUs0MUh2c0FZMS9IOTZEMk9Nc1hIZ0NyS0NmdjVJNlBGTFdj?=
 =?utf-8?B?cWxqYzY0Z2ZnRW80OWl1WEVQZGM0WU5ycnJGWXJzbnAxQnF0cnBWZXJScTlT?=
 =?utf-8?B?SGhtUnRuUmR4U3V6dXRsNUpiN2JjZ2lVNFYyZmRrQWYveERWOTZIRG02UG5R?=
 =?utf-8?B?dlU1YTBGSzQ4MkErUmcyVzAwYkVuY3h5aEJhZXRCVWRRMHdEWXorQkFXMHFk?=
 =?utf-8?B?SW1sTmlJVjE1Wm16SkhvK1UxVURVWEpIMnl0UDFpaVkvK0N0NXJ5em53bUVH?=
 =?utf-8?B?QTl3L093RWVTSm1neWdwb1NsZk5jZTRNNUs3SjdpZThQSVBUUHpsOEhNTlJo?=
 =?utf-8?B?a0U1MnFkTkovRUthSWJJRW1EU2lCYTdnaEpBODJ1Z2hNemhNKzEyclZLYk1U?=
 =?utf-8?B?czM4bjhSd0traE5jSGJDWkZEUjRhUFBWZGYvZGIvejRpTDZMMTl4WDdHcFBP?=
 =?utf-8?B?eExHU3FTR2VoVUNGd0ZVaVFjK3J6VU5JWk5tOUZnc1hhbjdzNlBST1c4L0ln?=
 =?utf-8?B?djNLK0ZrMHhPdVNEY3FTR0lGWDhMSE83aURHMXIwUWxxWVpxZTFSOEc4cVFS?=
 =?utf-8?B?MGxiYStFWldSK1FmelppUEFWcW5EVWo5d0Zpbk80UTgzdTJ3eGNuaStQc01h?=
 =?utf-8?B?Uy8xdTRmOXFXVGNRWFdyMEF2UGFuY2VxTGtYVmpFYlBoRU1PYUhYM1FVdTcx?=
 =?utf-8?B?cnFjSlhvOWFsclhmUFE1OFlxdGdFVnlQWE9hckdUYjVnbFRLYVorSW5pV2VJ?=
 =?utf-8?B?eFVRN2lmVm9BNmt0ZVNlQWI4SXZueDFMRzFFZ2h6RS9Ua2hSNEc2NVBjc2M2?=
 =?utf-8?Q?fgy6r4vCeKeetkT+A+6RZ37hKtHYaHL6PpduYg+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c763a76-3c47-4fb1-6ff2-08d8d47b9c35
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 02:11:04.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qim5hwIWAFErdmJrHgUVpwu31uOrTWk5HN9LR0Er5jaxkz3hzbUM0fh56/kKF26hlmXib7sAnKmYV4iCyZROHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190012
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190012
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/21 4:00 AM, Oscar Salvador wrote:
> alloc_contig_range will fail if it ever sees a HugeTLB page within the
> range we are trying to allocate, even when that page is free and can be
> easily reallocated.
> This has proofed to be problematic for some users of alloc_contic_range,
> e.g: CMA and virtio-mem, where those would fail the call even when those
> pages lay in ZONE_MOVABLE and are free.
> 
> We can do better by trying to dissolve such pages.
> 
> Free hugepages are tricky to handle so as to no userspace application
> notices disruption, we need to replace the current free hugepage with
> a new one.
> 
> In order to do that, a new function called alloc_and_dissolve_huge_page
> is introduced.
> This function will first try to get a new fresh hugepage, and if it
> succeeds, it will dissolve the old one.
> 
> If the old hugepage cannot be be dissolved, we have to dissolve the new
> hugepage we just got.
> Should that fail as well, we count is as a surplus, so the pool will be
> re-balanced when a hugepage gets free instead of enqueues again.
> 
> With regard to the allocation, we restrict it to the node the page belongs
> to with __GFP_THISNODE, meaning we do not fallback on other node's zones.
> 
> Note that gigantic hugetlb pages are fenced off since there is a cyclic
> dependency between them and alloc_contig_range.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/hugetlb.h |  6 ++++
>  mm/compaction.c         | 12 ++++++++
>  mm/hugetlb.c            | 75 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index b5807f23caf8..72352d718829 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -505,6 +505,7 @@ struct huge_bootmem_page {
>  	struct hstate *hstate;
>  };
>  
> +bool isolate_or_dissolve_huge_page(struct page *page);
>  struct page *alloc_huge_page(struct vm_area_struct *vma,
>  				unsigned long addr, int avoid_reserve);
>  struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> @@ -775,6 +776,11 @@ void set_page_huge_active(struct page *page);
>  #else	/* CONFIG_HUGETLB_PAGE */
>  struct hstate {};
>  
> +static inline bool isolate_or_dissolve_huge_page(struct page *page)
> +{
> +	return false;
> +}
> +
>  static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
>  					   unsigned long addr,
>  					   int avoid_reserve)
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 190ccdaa6c19..d52506ed9db7 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -905,6 +905,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  			valid_page = page;
>  		}
>  
> +		if (PageHuge(page) && cc->alloc_contig) {
> +			if (!isolate_or_dissolve_huge_page(page))
> +				goto isolate_fail;
> +
> +			/*
> +			 * Ok, the hugepage was dissolved. Now these pages are
> +			 * Buddy and cannot be re-allocated because they are
> +			 * isolated. Fall-through as the check below handles
> +			 * Buddy pages.
> +			 */
> +		}
> +
>  		/*
>  		 * Skip if free. We read page order here without zone lock
>  		 * which is generally unsafe, but the race window is small and
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4bdb58ab14cb..a4fbbe924a55 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2294,6 +2294,81 @@ static void restore_reserve_on_error(struct hstate *h,
>  	}
>  }
>  
> +static bool alloc_and_dissolve_huge_page(struct hstate *h, struct page *page)
> +{
> +	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
> +	int nid = page_to_nid(page);
> +	struct page *new_page;
> +	bool ret = false;
> +
> +	/*
> +	 * Before dissolving the page, we need to allocate a new one,
> +	 * so the pool remains stable.
> +	 */
> +	new_page = alloc_fresh_huge_page(h, gfp_mask, nid, NULL, NULL);
> +	if (new_page) {
> +		/*
> +		 * Free it into the hugepage allocator
> +		 */
> +		put_page(new_page);
> +

Suppose an admin does

echo 0 > \
/sys/devices/system/node/node<nid>/hugepages/hugepages-2048kB/nr_hugepages

right now and dissolves both the original and new page.

> +		/*
> +		 * Ok, we got a new free hugepage to replace this one. Try to
> +		 * dissolve the old page.
> +		 */
> +		if (!dissolve_free_huge_page(page)) {
> +			ret = true;

dissolve_free_huge_page will fail for the original page

> +		} else if (dissolve_free_huge_page(new_page)) {

and, will fail for the new page

> +			/*
> +			 * Seems the old page could not be dissolved, so try to
> +			 * dissolve the freshly allocated page. If that fails
> +			 * too, let us count the new page as a surplus. Doing so
> +			 * allows the pool to be re-balanced when pages are freed
> +			 * instead of enqueued again.
> +			 */
> +			spin_lock(&hugetlb_lock);
> +			h->surplus_huge_pages++;
> +			h->surplus_huge_pages_node[nid]++;
> +			spin_unlock(&hugetlb_lock);

Those counts will be wrong as there are no huge pages on the node.

I'll think about this more tomorrow.
Pretty sure this is an issue, but I could be wrong.  Just wanted to give
a heads up.
-- 
Mike Kravetz

> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +bool isolate_or_dissolve_huge_page(struct page *page)
> +{
> +	struct hstate *h = NULL;
> +	struct page *head;
> +	bool ret = false;
> +
> +	spin_lock(&hugetlb_lock);
> +	if (PageHuge(page)) {
> +		head = compound_head(page);
> +		h = page_hstate(head);
> +	}
> +	spin_unlock(&hugetlb_lock);
> +
> +	/*
> +	 * The page might have been dissolved from under our feet.
> +	 * If that is the case, return success as if we dissolved it ourselves.
> +	 */
> +	if (!h)
> +		return true;
> +
> +	/*
> +	 * Fence off gigantic pages as there is a cyclic dependency
> +	 * between alloc_contig_range and them.
> +	 */
> +	if (hstate_is_gigantic(h))
> +		return ret;
> +
> +	if(!page_count(head) && alloc_and_dissolve_huge_page(h, head))
> +		ret = true;
> +
> +	return ret;
> +}
> +
>  struct page *alloc_huge_page(struct vm_area_struct *vma,
>  				    unsigned long addr, int avoid_reserve)
>  {
> 
