Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82E33A36E0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 00:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFJWPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 18:15:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38200 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJWPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:15:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15AM4KKs072706;
        Thu, 10 Jun 2021 22:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=zC8z35L+iK24+pWMAPiEUN/IQ9lbXoeQmWLkoAsULGo=;
 b=ZJUE11I8BYp+qIhCG9VY3q3iJ3wQ4KsURL4ikyhRnox8D7EEiBBZpcGzcGc305HTyScm
 eEymVYWav6kR2oA1jd2okW9pQ0IML6ghDjcYJAj3fBN2SJ9KoPx+Ib5n2bLZAoSZ5yMm
 Vo9A/IijszpRWTvCMWnAENOhLQIcNpYky97UB+NPIOZOLJMfa7sT4L2p3FAVkf8FE6fW
 Urjv5UmzE/KB/QS+QfDroSHAqsNizIVmyZNlYV3ft7Cj/CGnfloi9K6vFZOTPWj1Nzh2
 xpzU1wyPlV46prETdEjcCpCoUU+d+eKI3kdnn50/jW7N7asZ/mEd2eS/JhiN0GdP/XXA Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3900psd6qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 22:13:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15AMB1sD124526;
        Thu, 10 Jun 2021 22:13:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3030.oracle.com with ESMTP id 38yyacwv1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 22:13:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWV5ip5mlSu0KFyDKxdhbn/Wp1kpcGoYYdzhP59DUUamTSPbMqITB4FehyKTEH+xtXdsRD1FLorizv6BkQiq2QAdmo2K5tmuzud5jvTgXC4+vjETDBpKpsYHEJedRSrUsRKZ5xj3Nq2WrlXlUu6XOPZ0I3dlcg/cXkuBdvXGY+Wma2DlCS3nW4mjojduDe7MW2BM/kVchMy1coC11ZqUW6B1d857k2Bt+mpnE7Llk2ozPGE3ZBpyCcTs3jU6EeXaFzdS+8EFYceQ0iFKR0buAuJQSkuWkYiIKusN5DdT9oti66LznHOKvPS4SzcLDcJbNPhbRtI8pGiSnN7nQuMz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC8z35L+iK24+pWMAPiEUN/IQ9lbXoeQmWLkoAsULGo=;
 b=JZJf/DRgBWNdqoHJi8IYQ4RAc5kKvOiueo4kQ3pkVxMrc5lo50QTORKmfQUT5dMwHWwq9rOHfWSKJ8v4qmMVOOSUW7HAf/Cm4OYWSYi2bJfjxjYGVdO7iX4EkDlxCWCLKoph02guqDxOQtWW7SHJyisW+Q4gjKykSTchwEo4nzV8gj1+V1h5iTYzHvfK9VKM80Isz0hjYOwAQGNF0kErYvwbij1AUeF7093KtWXKj+arnS9GFu8Kc5JooNsGF8oV9is/e9n1etKP7CpIy0LEWuIZ+AWrpe+I2KykNF0eINixH7b+evzZfU/ihu8GR9maABP5UTmMfFROiN332xqYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC8z35L+iK24+pWMAPiEUN/IQ9lbXoeQmWLkoAsULGo=;
 b=fqCeH5xjEkK4V4lLPlT3iYiBxHG0wEQMa0aHLi7w+oilbAEM+VagI5D33oeQpxy0tc+Eo/VxAGbO+0tH5Bw/3T2zmdzYNjQnFocpU5OCE2hlgGLnhJQGxAN0TeufgO31NIj2D1+WQHcMqfSMtZKoC6Xabd2OBkDdqtIectFBDPk=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3987.namprd10.prod.outlook.com (2603:10b6:a03:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 22:13:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%3]) with mapi id 15.20.4219.023; Thu, 10 Jun 2021
 22:13:06 +0000
Subject: Re: [PATCH 2/5] mm: hugetlb: introduce helpers to preallocate page
 tables from bootmem allocator
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210609121310.62229-1-songmuchun@bytedance.com>
 <20210609121310.62229-3-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7c04420e-c564-7e19-6c2e-ea81dd51d396@oracle.com>
Date:   Thu, 10 Jun 2021 15:13:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210609121310.62229-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1601CA0015.namprd16.prod.outlook.com
 (2603:10b6:300:da::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1601CA0015.namprd16.prod.outlook.com (2603:10b6:300:da::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Thu, 10 Jun 2021 22:13:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8dfab54-0567-4049-48c3-08d92c5cec01
X-MS-TrafficTypeDiagnostic: BY5PR10MB3987:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3987492354AE3E434D024FBFE2359@BY5PR10MB3987.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOt6n00kMeX6p/80t8bf39d/EnI928GV+6KpWARrPcz1qvPGHllIOJ16n9ILsWtrP5BxclDKzJDLRmjEBX+qFZguDBkZ5wnFkkRd2S/fQsYXJCmI+b1SH/ocNBoEcyWwMfwMp3K4OOInSo0qrTDzdy/taVVBANk5w9qHp+F6CPR/wpW2Jf2vle9xzrDVfGzWzEIgdPmUnJRwV1vxeUW/DRIoddU06l8zoUkdZ4YV2j+ReaiUDB14ZmczM9fdKYOLQixo5+UuvTEink+mKVj6r3U20+RcVkdohnxXPTcjJ8qBMUJorit1CzeG6lkpzm6yACgntTfJx2zfBns0nHqmvI8GUjseE1iBUdwVAhKUisYpegqbsfG51tvgXmp8NkjE8Vi5183tr+gKb6TbF9qz6b/4qsFH2picWFz58R8pNdm621b3tBJQDNtPknXd2ZK3st5+JA7jlpLAvzdlGqTHod8im3+mOFlcqr0JCwNGkJ7v2BKaFs2S1g+unbRqpYW983qoml9lxf+vLDtYvcvq2I69XdcxwVoCpCAqOdXlezN0E+9ntZOl8fGbT9Q/Ezd+JW3kHp8OeU5K3kf8pK13lfURzon45n6GS0i1mJgYu4GpRQePjHul9iUk/WFHDEWnNwybbrgIX8EJiEnf6ATIf+P6DzcxyXGoB9RzCVd9FxkP9UUSv4/prSqC+Dnq2EVPpwPwyZdBBiVfZDla38s9GCKNu2JGdwNF1ZgJmzIU7Jo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(376002)(346002)(396003)(26005)(16526019)(44832011)(186003)(2906002)(52116002)(5660300002)(6486002)(38350700002)(2616005)(66476007)(66556008)(66946007)(31686004)(956004)(86362001)(8936002)(38100700002)(8676002)(478600001)(7416002)(31696002)(83380400001)(316002)(4326008)(53546011)(36756003)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlJnQldWUjFDdmZXbzZUR01wN2FWaDVxaXQrZnBkOTVhUWhndmRZSUpuMEJ4?=
 =?utf-8?B?aitRbzZwaXhqVFpUM3JtYnNZYXovSVNYV3VBdlZUWHd5N1RRb1BkZzV5K1Bh?=
 =?utf-8?B?cEx4eEg0a3BKNGVKYnJwUnJUblh2bVArZW0waENEV0M2VDF1dDl6NGhUWWRH?=
 =?utf-8?B?bGZzbFN3Y05XL1haeHo0UGl5OGlqRzB2aEZBWVplNkhLL3lla1IxVDg2MGh6?=
 =?utf-8?B?ei95dkQ4SFlyYXU2RXVwUDQ1TDRqaHlQQzFBVUMzc1hvRktaQm5JZTBXZWQ1?=
 =?utf-8?B?ZDl5V1pWaUx2NGlHVi84ODJPUUpEVkVYaW5OL2lmTTZMQ09aWWZpbjNuMWJ0?=
 =?utf-8?B?ajBzbTVaWHo4OURmZFJUWFlpUm1XLzdUSkJsL1hxcE1FNi9KMi9YdG0rWVZJ?=
 =?utf-8?B?cEJISlVZWEk0akYwUUV2M2JYSWR6WStNLzVLeXQ5cEdLMFcramNOaXVoaFRl?=
 =?utf-8?B?YkJYRHdvaDBFTW9ycTZ3K3puL0JUbTg4bU1XL1RCVGhjSE9pMHY0azhaVC9J?=
 =?utf-8?B?WkU5OWZRV2U1bmF4Zi9lK2NPeklESVg1eHplTHpmZmxEeHY4Slk2dUhQNmsr?=
 =?utf-8?B?WmJvM2dNSlU1VWtKN3FNRUJQMkJFc1htUFBQSWtORFR2R0xCdzlnb0d0VlJM?=
 =?utf-8?B?aEtHWElpTUZSdzVKRWQwR08yRVp1RHFuVm42c3hHeG9JYzhzNjluQjJ5dkEy?=
 =?utf-8?B?dTUwTlVmR3VFdmhSbXhxNkVoOVRBdDVOaFgyOWpINzFlOVNiZGVHSnp0VmhS?=
 =?utf-8?B?MW9HT0Z5V2JDUnFHSlBMU3VaV0p5QXk4NmtFMG1uczdwTzg2S0hORmlKS0d2?=
 =?utf-8?B?MzlJU0N6aGQ2QkZtWURWMWU1TG56NHV6TU1VSVFIVGdNcFpRVHl3OUJ4NExs?=
 =?utf-8?B?YzBQUVNwd3BDeWpTblVnRGo2ampOTk0vUmJlYkxZcXBMM1J3UTBhSThYYzFO?=
 =?utf-8?B?bUV4VHVJTEhiQTdGK3l2dm5oMWhlUHZKM0ZpUkFxOVdjbTdoL0gyc3FuL1Av?=
 =?utf-8?B?SlJYOERiM2c3VzNJT3hQNEZjcGFRSHRJTnhHTUtiR0I3VENObHAzeE5RTHE0?=
 =?utf-8?B?MUJxVTl1VXRodUhqbGhueTJvWHNCVVE1NnRQUmVxbzc2SVV4UlRlczhRVWJY?=
 =?utf-8?B?emJSdnc2Z3JFcnpzYUVNUWYrcE53dHdESUNhTU45N1VkM2hSSHNyVTdMTnJK?=
 =?utf-8?B?bWpjNVNKMXNwTVNEZy8xSkpqYUlGM3ozelJPWWNqTTdWRDBOUFdMNWdmSEdM?=
 =?utf-8?B?ZXpqUTIwVTF2eWF6Znk4bVhhMGkvZVVONkRiczgwV1VEanEzSEtmSllsU3ow?=
 =?utf-8?B?VFRLWWppN2VHbHUyREl4NHFmbldoWDZRNnlHWnpxWUpsNHpyVERLS0RZbzZB?=
 =?utf-8?B?QjEvLzVYeFpsbFlmeVRqSDdwb0VoVGJJcHoyNE1oOGtnNEtWcEoyTThnd2Uv?=
 =?utf-8?B?ZmQ1My9FTGpZQXQ5SGxUQ0ZJbHRFaWFvb25sNnVmSnlwUEFEaXBTdXQ5Rk8z?=
 =?utf-8?B?VVMwUThZK1RWWFlWTDl1UVREdGw5b3pybkZoNDB2QjRLTWY5QnNnbzJZM3Jl?=
 =?utf-8?B?Y3pFVXlTZy9UbFV2OWtOalE5cGFtcUFiUlRTYndGUDhpRFBFQVRVdjlmNXN1?=
 =?utf-8?B?WWt2dExYK1FmYy95YW9ZamVidXBYVFhZZmV0aVVyTUN6S2MvZDBnS0gvVzhs?=
 =?utf-8?B?VXUzVTc3Tk5WenkydmJIdkJzU3ZwWG5sa2J1dGJNZ1BvOWFsS08rYkFBQmk1?=
 =?utf-8?Q?z+/vT07JBs65GG9V1zLXAQYAHVwDLD8YNQgxq5O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dfab54-0567-4049-48c3-08d92c5cec01
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 22:13:05.9319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WU3W2mDoWYIIXR0JCG4+rS0B8ZoJvnNO8A0irbmPYEOTPANVLAma+KrWRv5LYzRlEoL+oTmfvfEror96hX8ABg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3987
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100133
X-Proofpoint-GUID: kWsMcaPZ6butNh4lwKSve0oLJdohevuz
X-Proofpoint-ORIG-GUID: kWsMcaPZ6butNh4lwKSve0oLJdohevuz
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 5:13 AM, Muchun Song wrote:
> If we want to split the huge PMD of vmemmap pages associated with each
> gigantic page allocated from bootmem allocator, we should pre-allocate
> the page tables from bootmem allocator.

Just curious why this is necessary and a good idea?  Why not wait until
the gigantic pages allocated from bootmem are added to the pool to
allocate any necessary vmemmmap pages?

> the page tables from bootmem allocator. In this patch, we introduce
> some helpers to preallocate page tables for gigantic pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/hugetlb.h |  3 +++
>  mm/hugetlb_vmemmap.c    | 63 +++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/hugetlb_vmemmap.h    | 13 ++++++++++
>  3 files changed, 79 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 03ca83db0a3e..c27a299c4211 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -622,6 +622,9 @@ struct hstate {
>  struct huge_bootmem_page {
>  	struct list_head list;
>  	struct hstate *hstate;
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +	pte_t *vmemmap_pte;
> +#endif
>  };
>  
>  int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 628e2752714f..6f3a47b4ebd3 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -171,6 +171,7 @@
>  #define pr_fmt(fmt)	"HugeTLB: " fmt
>  
>  #include <linux/list.h>
> +#include <linux/memblock.h>
>  #include <asm/pgalloc.h>
>  
>  #include "hugetlb_vmemmap.h"
> @@ -263,6 +264,68 @@ int vmemmap_pgtable_prealloc(struct hstate *h, struct list_head *pgtables)
>  	return -ENOMEM;
>  }
>  
> +unsigned long __init gigantic_vmemmap_pgtable_prealloc(void)
> +{
> +	struct huge_bootmem_page *m, *tmp;
> +	unsigned long nr_free = 0;
> +
> +	list_for_each_entry_safe(m, tmp, &huge_boot_pages, list) {
> +		struct hstate *h = m->hstate;
> +		unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> +		unsigned long size;
> +
> +		if (!nr)
> +			continue;
> +
> +		size = nr << PAGE_SHIFT;
> +		m->vmemmap_pte = memblock_alloc_try_nid(size, PAGE_SIZE, 0,
> +							MEMBLOCK_ALLOC_ACCESSIBLE,
> +							NUMA_NO_NODE);
> +		if (!m->vmemmap_pte) {
> +			nr_free++;
> +			list_del(&m->list);
> +			memblock_free_early(__pa(m), huge_page_size(h));

If we can not allocate the vmmmemap pages to split the PMD, then we will
not add the huge page to the pool.  Correct?

Perhaps I am thinking about this incorrectly, but this seems wrong.  We
already have everything we need to add the page to the pool.  vmemmap
reduction is an optimization.  So, the allocation failure is associated
with an optimization.  In this case, it seems like we should just skip
the optimization (vmemmap reduction) and proceed to add the page to the
pool?  It seems we do the same thing in subsequent patches.

Again, I could be thinking about this incorrectly.
-- 
Mike Kravetz
