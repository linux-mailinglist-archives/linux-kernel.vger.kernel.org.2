Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4589357430
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhDGSZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:25:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3866 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231526AbhDGSZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:25:54 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137IOV7O025073;
        Wed, 7 Apr 2021 11:24:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=inlensKERx98K0gesH+MDUmYuRFVYNkqKy7NTlsD0Tg=;
 b=X8bNFU0dOTs+VaD52dqoe2LNycSeBoXYbYi0ax/WaaWX06jnJNIwxSwH59LcA+Xx54F8
 b/K1hHbsH6VahPGmK2JuIOOowi+BkO2+4aZlrxFY9KDUsfjTdFqzM7ZiOrccGBFW4KO9
 sfhDppnPQ9+iG71qtI7t30pQOqkpy9j4kMw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37sfq6165k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 07 Apr 2021 11:24:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 11:24:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDcXTZyl7m5eKne0/909sA1tvuvKhk3rUDONU31r1RPSRLHc5lFXN1UmYcDGJmhPpJ2pE14A5gSlW093wt5o3zv52BUeVvBD5yv0/w4DoZEXtI9wpGgBuTcX+KbjARRtgBS+IbvcLhDKfnb7kdNTUDfvDBDK/8udlzFivHrpfwXlidhqG6XbeVUDw5uahD/9/y47G/6JYv6x6AAbNaSipeY6lpBzzoYwbO8VeLmZxymS9WY7oOoTRgxR9Ek7HVsICUnz3LfSiv5ncSSbfnUjPmswsjXAJ/SEY2yuhHNqmsQ3tNZzvUZs+EMU0JbQuM597JDidASwbmb67rM+nxxDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inlensKERx98K0gesH+MDUmYuRFVYNkqKy7NTlsD0Tg=;
 b=BlBNMh2mFs1G8VqIsntMrqbeQQ6uTB+mGsVf41i9lfU7osD065E5Z03uIU0UoKSVQ9mF0Pn6khtqRCbWXIPibKhd0VBjMrmkks5vACxHO4GeIuFLAN5Asw/ZpiJlTauypgjPL2phA/+XFnf7dr4qMejw9+cp6EhxG3Gs/Cdfjapqra39BUpQf7UKiV7OCD35b+tzpcT6rY8lOy1bp//cfpjmZW68DzRRGY9gpjz4YUhkoOQRHpp3PtDZfqktg0LC51URxnsdEaL3HaVjF7Qdoj+WSwjQuyRZQEYCcu5vNXneGm/a182E+pjXyztxv+m6YUldQgJnkof7e0nj2nRFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2808.namprd15.prod.outlook.com (2603:10b6:a03:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 18:24:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 18:24:24 +0000
Date:   Wed, 7 Apr 2021 11:24:19 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/8] mm/cma: change cma mutex to irq safe spinlock
Message-ID: <YG34070Ws5EYENXC@carbon.dhcp.thefacebook.com>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210405230043.182734-2-mike.kravetz@oracle.com>
X-Originating-IP: [2620:10d:c090:400::5:ccee]
X-ClientProxiedBy: MW2PR2101CA0028.namprd21.prod.outlook.com
 (2603:10b6:302:1::41) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ccee) by MW2PR2101CA0028.namprd21.prod.outlook.com (2603:10b6:302:1::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.3 via Frontend Transport; Wed, 7 Apr 2021 18:24:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f0f042f-fed0-487b-e38b-08d8f9f25e98
X-MS-TrafficTypeDiagnostic: BYAPR15MB2808:
X-Microsoft-Antispam-PRVS: <BYAPR15MB28085FB31A750C968CF098D7BE759@BYAPR15MB2808.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykbFz59LyYR2TwgycUtO9iyWCdU3mhrj2m8h/YilLLW4krxL2jvR1ovJ2xgLjLlhOzChu9TKtPRi8ygNTi9bDLPN/7f3UaX1UZADh0VwQFnuDMTgYfRAOMSME1lKHad+p9d+yxts2vyZRFO4mCjMh+xoDIR48FE+e1QHHRM2zz4W5yljNCgyc8E1OSBOkbRtfHhKPpp8Gh3+SeLxdGoKxD74sv4vCtFB6Z6MgGNPVmXkucoYi6KXLxdUP/kXEIIOnC5XSg/A889NRxo+/l7xuEcIGugLqw5OetRip1QllP3a8aV33kR9B+mDgXmbSfGpJ1B50mVjHhwpaNsVSynGBBwYnOgg0ip7JgDCkYUGi4FIdtL2+ZUB2xIgFRvBlgl0lxyD2666u4FEpgntZLrsXigZ4VtCB0wuFsgNtqNRrkLjPptKW6l4MpJlPA/rBahQAcXSAEthENo8XJkNN4Xgv2EYFL9f9BAc6waPF+yQkpxyF+iNozwJaoTf2f6W6Jni6KTSC6FxjlsoKcd3TdUd6WWlpRbv921O+m7OEEfptn/qK9hxGWnjy07yNXckHfpE4KRXASYxhD2Ph3ErkUkUIgaV2pDBaMNbR4wgnYddu1EKFfQpr7w9QfuyM+i6Q7q0fSNuAvoWHFM7DheSXn4jBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39860400002)(376002)(346002)(2906002)(66476007)(55016002)(86362001)(8676002)(16526019)(54906003)(6506007)(478600001)(52116002)(6916009)(4326008)(83380400001)(66556008)(316002)(38100700001)(7416002)(6666004)(66946007)(186003)(7696005)(5660300002)(8936002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?i5YaYZXUS2hQB77fDMlWfvhLhY5v8nbBbFyJkMJtf17aqCuvvg87fPy06czp?=
 =?us-ascii?Q?sFsNzmkfYX93N/tLV8JGLqGc3at7/tZpVxFtjWZJUHdh02IELI0s9hCN/h3E?=
 =?us-ascii?Q?3/9iTykgnAdTZhq0GRD/azSayT9gD3+Be2BdkhwMi8OUizw+vw63XazQz8ii?=
 =?us-ascii?Q?pA+DsyO7COA2m7DMC6otqGT+lu/VP5oLfNgTrt797H93iTiSlw4E991sDU5F?=
 =?us-ascii?Q?Fc+hr2upELVBBJNiLZXDTDfbBL2bPAQs1DT6grvWONvdbEelxCkodW2XdEd1?=
 =?us-ascii?Q?siIm/4+cynAMumhm0SYTum7yvS/2PnCoGFmMYphecVKML3ZZ1s8xQ5IX5/5R?=
 =?us-ascii?Q?4SBXodF7Vb+YPvHUvfD/9EgpuyO/Qlk8XC0vQ3DhRMumukXo3xYDmJ0H/RNI?=
 =?us-ascii?Q?HvvSm0yTp1z/8M8X2Y1K7946+bqLb3WADa1mXd4DUyg4jwAXod3uFEOm5P8r?=
 =?us-ascii?Q?5T0y7I7bPeFEPkQkYGVjIN2TY8X1dwY1kslh//kG6UxZKEU13aPKJGURxW51?=
 =?us-ascii?Q?oe9aocNoc+axj9IVA/WgWxCXSbU2101ig5C9FU8UaiXFg3F+pRzi60MMEHUz?=
 =?us-ascii?Q?JKHJRTDo2qwjQlUP3gZ5LSmVkijg6Vao53bmxOP8VynkaShp9TXvKhKalLAC?=
 =?us-ascii?Q?IBEg34oaGAnpfiKXSmqyskJH8Rk3hCdChhWPwHo1K6pa7wVrjUrcCa/3WO+T?=
 =?us-ascii?Q?n93f32AXQjskUm5F7yqlqEEQBG3i92zTX2/iZICkZmmell4DEO2VlgmNuytI?=
 =?us-ascii?Q?FmQLYA32vpg6EmnwQfPjE4RfHtWSJDszXLuNAWXZhfmELHe+MKxeeh/yhKs7?=
 =?us-ascii?Q?wa5ID6lPT0yHEGLSZiGttigfO3q6SV1s06DgPpt4sFmEmCaeTFd1srguZz8m?=
 =?us-ascii?Q?+aSSoWnoaaunbC1wIXNXdi54xnUMkRldW7L+29GfDrHNeKTF73xjDqd0kKpJ?=
 =?us-ascii?Q?XxXx3xZHbU29kTKNzwrhjqG4aPw0yc++a3dCTYBxPmJ+kKqOodeROg+3C02q?=
 =?us-ascii?Q?owMXK9hotC55XHF134G9V8g4kipzitSuPVfA/vpThqy9c7cgoqmljE5kFT9M?=
 =?us-ascii?Q?HGzqfXMO7OEOG/ZgWt80IAL9Iw8bPyPDIYyZuOE/C++yLLnMeSOrQQFPEaPQ?=
 =?us-ascii?Q?gepO65wTm4RzbD5BfT96SGBJCJbrP5K2GspgUk3CFEtJ4i3wBQahkafcx9rN?=
 =?us-ascii?Q?FOCXnRjyU0JZf9DuT1dTmOevDDqAU3Q87VX36mae33n0gqaJiTdPAsTzNDAt?=
 =?us-ascii?Q?dQrbycjIajwtiUO+Nqz+M754O5MI/qPRJmzT1hKOwAaZGTICLKtpMBdRo6dU?=
 =?us-ascii?Q?kWCnhEPF6k+pNT+zZwKQPkTbyqg0ubIpUVvyGuhFDTg2zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0f042f-fed0-487b-e38b-08d8f9f25e98
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 18:24:24.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRrRgM0DBHqPT5erLk5vLCtU5pq0o6EWaM8fPgT/CEsagD3kxQXuxroeWTAzxGEF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2808
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: EU6pf_g83GErIxw3dRGK9PMcO3K12b6c
X-Proofpoint-GUID: EU6pf_g83GErIxw3dRGK9PMcO3K12b6c
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_09:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 04:00:36PM -0700, Mike Kravetz wrote:
> cma_release is currently a sleepable operatation because the bitmap
> manipulation is protected by cma->lock mutex. Hugetlb code which relies
> on cma_release for CMA backed (giga) hugetlb pages, however, needs to be
> irq safe.
> 
> The lock doesn't protect any sleepable operation so it can be changed to
> a (irq aware) spin lock. The bitmap processing should be quite fast in
> typical case but if cma sizes grow to TB then we will likely need to
> replace the lock by a more optimized bitmap implementation.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  mm/cma.c       | 18 +++++++++---------
>  mm/cma.h       |  2 +-
>  mm/cma_debug.c |  8 ++++----
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index f3bca4178c7f..995e15480937 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -24,7 +24,6 @@
>  #include <linux/memblock.h>
>  #include <linux/err.h>
>  #include <linux/mm.h>
> -#include <linux/mutex.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/log2.h>
> @@ -83,13 +82,14 @@ static void cma_clear_bitmap(struct cma *cma, unsigned long pfn,
>  			     unsigned long count)
>  {
>  	unsigned long bitmap_no, bitmap_count;
> +	unsigned long flags;
>  
>  	bitmap_no = (pfn - cma->base_pfn) >> cma->order_per_bit;
>  	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irqsave(&cma->lock, flags);
>  	bitmap_clear(cma->bitmap, bitmap_no, bitmap_count);
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irqrestore(&cma->lock, flags);
>  }
>  
>  static void __init cma_activate_area(struct cma *cma)
> @@ -118,7 +118,7 @@ static void __init cma_activate_area(struct cma *cma)
>  	     pfn += pageblock_nr_pages)
>  		init_cma_reserved_pageblock(pfn_to_page(pfn));
>  
> -	mutex_init(&cma->lock);
> +	spin_lock_init(&cma->lock);
>  
>  #ifdef CONFIG_CMA_DEBUGFS
>  	INIT_HLIST_HEAD(&cma->mem_head);
> @@ -392,7 +392,7 @@ static void cma_debug_show_areas(struct cma *cma)
>  	unsigned long nr_part, nr_total = 0;
>  	unsigned long nbits = cma_bitmap_maxno(cma);
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irq(&cma->lock);
>  	pr_info("number of available pages: ");
>  	for (;;) {
>  		next_zero_bit = find_next_zero_bit(cma->bitmap, nbits, start);
> @@ -407,7 +407,7 @@ static void cma_debug_show_areas(struct cma *cma)
>  		start = next_zero_bit + nr_zero;
>  	}
>  	pr_cont("=> %lu free of %lu total pages\n", nr_total, cma->count);
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irq(&cma->lock);
>  }
>  #else
>  static inline void cma_debug_show_areas(struct cma *cma) { }
> @@ -454,12 +454,12 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  		goto out;
>  
>  	for (;;) {
> -		mutex_lock(&cma->lock);
> +		spin_lock_irq(&cma->lock);
>  		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
>  				bitmap_maxno, start, bitmap_count, mask,
>  				offset);
>  		if (bitmap_no >= bitmap_maxno) {
> -			mutex_unlock(&cma->lock);
> +			spin_unlock_irq(&cma->lock);
>  			break;
>  		}
>  		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
> @@ -468,7 +468,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  		 * our exclusive use. If the migration fails we will take the
>  		 * lock again and unmark it.
>  		 */
> -		mutex_unlock(&cma->lock);
> +		spin_unlock_irq(&cma->lock);
>  
>  		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
>  		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> diff --git a/mm/cma.h b/mm/cma.h
> index 68ffad4e430d..2c775877eae2 100644
> --- a/mm/cma.h
> +++ b/mm/cma.h
> @@ -15,7 +15,7 @@ struct cma {
>  	unsigned long   count;
>  	unsigned long   *bitmap;
>  	unsigned int order_per_bit; /* Order of pages represented by one bit */
> -	struct mutex    lock;
> +	spinlock_t	lock;
>  #ifdef CONFIG_CMA_DEBUGFS
>  	struct hlist_head mem_head;
>  	spinlock_t mem_head_lock;
> diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> index d5bf8aa34fdc..2e7704955f4f 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -36,10 +36,10 @@ static int cma_used_get(void *data, u64 *val)
>  	struct cma *cma = data;
>  	unsigned long used;
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irq(&cma->lock);
>  	/* pages counter is smaller than sizeof(int) */
>  	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irq(&cma->lock);
>  	*val = (u64)used << cma->order_per_bit;
>  
>  	return 0;
> @@ -53,7 +53,7 @@ static int cma_maxchunk_get(void *data, u64 *val)
>  	unsigned long start, end = 0;
>  	unsigned long bitmap_maxno = cma_bitmap_maxno(cma);
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irq(&cma->lock);
>  	for (;;) {
>  		start = find_next_zero_bit(cma->bitmap, bitmap_maxno, end);
>  		if (start >= bitmap_maxno)
> @@ -61,7 +61,7 @@ static int cma_maxchunk_get(void *data, u64 *val)
>  		end = find_next_bit(cma->bitmap, bitmap_maxno, start);
>  		maxchunk = max(end - start, maxchunk);
>  	}
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irq(&cma->lock);
>  	*val = (u64)maxchunk << cma->order_per_bit;
>  
>  	return 0;
> -- 
> 2.30.2
> 
