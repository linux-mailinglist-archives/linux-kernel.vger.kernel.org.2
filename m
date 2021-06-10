Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939DB3A3734
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 00:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFJWhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 18:37:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45272 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFJWhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:37:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15AMWCtB106254;
        Thu, 10 Jun 2021 22:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=YhJaFPjrfxzz6rQgWz0uSuU4qeFcxGv1iOI7O060YFo=;
 b=frnTDeV0JWQBztFSkjEBdSnAsoLrxXAaCYqYgww1IRttmXsEtY4NKQX1rBUhcG+qLLqZ
 4Sxz1ghIRxdNNlfdbE/RZubKKplZn4QU/4p398aAAjAl7bfTupL//GAhpj0P63OhJ6wl
 qZ6P3bGElAgvMJFe3yt2pNaL1UyYHGeIHH7kK8HkLI/eBu0Q33z4XXMc7ZTBs4LCpmgM
 nzRqPlh41uBlS6box/J633Shw0jb6mUB6QJZWAdxNQZjv9HAyh+qztoaLM+tnfo05tXM
 ohy0dDla0ZGT/7qOUFbmifYjuBpK5G8OwLbuwxWKL0ocdfsMzXpDFnjrXtkg21BJ60g4 zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3900psd7es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 22:35:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15AMV0n3161438;
        Thu, 10 Jun 2021 22:35:08 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by aserp3030.oracle.com with ESMTP id 38yyacx74y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 22:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OK9HmFOqpmtY2quU3SylNsN2lxPzsdwbChzqS609bMuLAVNUWpusutnH1Ryt9flPMGgHgIR4b8W3+J7inOMf6F1vpR/fBcZqZuQ09SBELfpjaXjmL6/lP5VULmCCargPYO2SLC/kdTJ60Fam5uIVr5A0vSHuqR3HjdnSqC8ZGidEiadJaq9TC43d+GhaP+S7Ayp74AiL66BL+A00MhYrWs2QxMZEuk1mR+VlczKy3rjLbwDaamAce0o2IdTd4V8Ier7d1Fi/X6sJtGQyT7umwZ61cpyrSURvTwF8KiCfXGhnxfqA07X+iirGT1/fY4I/mofpRkxus4bDpF64BAYLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhJaFPjrfxzz6rQgWz0uSuU4qeFcxGv1iOI7O060YFo=;
 b=mjcpf/KwaPXxPJsTgWqHn0ed5k2UE7S6T+fkpajc7wb1UoHrHyeDqmOtSXZgvEK+5VKlTNQcWMvf3dbo18uSjOpgNLQsdt2q7kG2eMWm7Foiztns3YctMW3I9KfaOol69k2M22+viaAd93KvjUay0OGEr932KNCf+GYfoMDZGbwdLXr3ePeWJHGN3fSoxbV/jpEWCSMVr+oPeV90bnX9YqINPCzKm5fR3KRdP/aAqN82lggC7Liqw8OCqBgyqmhHufJyrNem2+YkSiTPnAHBkrDiCMfCQxr0ReXgegwIAp1IOJl+91mZkRwtDWptD+1zCy2dNdcAj/i4JDBlX0hP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhJaFPjrfxzz6rQgWz0uSuU4qeFcxGv1iOI7O060YFo=;
 b=Xu9TnXi6XSUtp61xRj+uswLnicEXTr9HhI9E09EeIm/epzJdMF9vfEjPawWj8zjWevclB6DS0dRk2ddcb890eHa3NVMdg72JtXjYIsAt/IIF42OBPEvSUXwBGSBLjAd+9Vi4/fphnmTWpKAH6MELcD77dVXlPVy65W9SFLnuMWQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2551.namprd10.prod.outlook.com (2603:10b6:a02:b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Thu, 10 Jun
 2021 22:35:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%3]) with mapi id 15.20.4219.023; Thu, 10 Jun 2021
 22:35:04 +0000
Subject: Re: [PATCH 3/5] mm: sparsemem: split the huge PMD mapping of vmemmap
 pages
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210609121310.62229-1-songmuchun@bytedance.com>
 <20210609121310.62229-4-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1c910c9a-d5fd-8eb8-526d-bb1f71833c30@oracle.com>
Date:   Thu, 10 Jun 2021 15:35:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210609121310.62229-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0320.namprd04.prod.outlook.com
 (2603:10b6:303:82::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0320.namprd04.prod.outlook.com (2603:10b6:303:82::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Thu, 10 Jun 2021 22:35:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 391a1760-618b-47fb-41c9-08d92c5ffdf6
X-MS-TrafficTypeDiagnostic: BYAPR10MB2551:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2551EDA69BBB4F9AC59E01F6E2359@BYAPR10MB2551.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzWBQicQ75hGHvJZfm/6+QkZtbpUM+EfVxLCqUBcGDeJhLs2zRMDVgvaMBD2FWWl6b7V2/h/tbOB+3JqKE4weF+pWrT6s60ybYzMMniSzNxXJf/pIP45+FJ5pgLIggSFvqfWe02be3bczAzwFEJ1pY4CzKAqGtAuU/Ao9Tx8jA/s59wcPh5HL/a93JFZm7ca/Fjxhl3xGGIuhhyjFD8rq1Edr630c3D1UeFDk1UBOhftv3MUzeYpICdI2c5likwsGdyL2NgHcZNf+xms9FLrDd86lHrJ00fYp9d1gUsr4+MAekbspG5oALHhxsgpqBF/jn6azuu5hYbfNBXuJPt3XberB2nhbyBHloGxnOhZLo1AIW8Pnu7MQwZq0QpqEwGIUllTfABgnHlt+GvynDWb5KwR8kD7Kn3y7gjTANvFgvCyCmykVdeqhiQoVxq4KtywyrYukcEQiAnoeV6lY/ysFBNVvH8F8d5lGGENPC9CMXFvYrkbrNuMBtwC2WtaT4+psYAVplakLD3M63rnYcJt2QoxiDnA70B5z++1rl5LLNfI2AceEJCQNtCqbHCfuzQ+UxMhDh6T5YdauKjcIsBNVqGHh+LomNIUkYS7JjNF4s3elmDTk7E2FUiHULuCivrYk+BidRA3U89iAkarJJRq06hjF6qWI1kUt4MB1Xwl7qb/RYveTW97NqyWdgVDkMI5fI635oRbKFrG4iNTSZgfRlmxRvw57ld7dBxN2nCqvGUReMr9xTz+jg+/kS6/aTEw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39850400004)(366004)(396003)(136003)(376002)(53546011)(5660300002)(478600001)(26005)(83380400001)(8936002)(7416002)(44832011)(8676002)(2906002)(66476007)(956004)(66556008)(2616005)(66946007)(186003)(31686004)(16526019)(316002)(16576012)(38100700002)(6486002)(38350700002)(86362001)(31696002)(4326008)(36756003)(52116002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1M4eERoQWg4ZnJlYmNndGRrcExJNFNiR2JnNXRjd3RUWEJjeU95QjZQMk5k?=
 =?utf-8?B?NDdsa2g2aTZqWW1iUHVzQ3J6MFF5RW5WQmtQaGhJeFNaaEJMcW4ycDNSbXhw?=
 =?utf-8?B?NWx4NGx1SUM3WFVBTU9JZjNRVFBiZEQwNWVEL0pRSmJwR29GUWFNem9mWFpH?=
 =?utf-8?B?VEpSLzVIV2FTOXFUN3hzRlZhaFVSSmkvSmxpMDRZT0h4MkZXdVZUUnFlbHFL?=
 =?utf-8?B?WTN2QW9OVDNEUllpTkp1ZkJrYUg0WDRiclQyMEtWQjFxbXU0L1c1QmJKaXU1?=
 =?utf-8?B?TzdqSmlpMndhNFE0czRKQ0xBTWVnN09FZHFldDVPd3E0VXlYamJzSEhweG1y?=
 =?utf-8?B?VUtPTFVxckIzQ0NZZUVVT2xSSFhMUkVaLzhIQml5YWp5cnNDbWExVHFib01H?=
 =?utf-8?B?eWxBUkJCekk1dDhCTzJpemt4MmZCY05lUThDTllNVUZDa0NDMWliMVNRNGVM?=
 =?utf-8?B?VW5oeFVWbzI5NW5Ob3ViS0pnNDJUQXliWWtKV002WUJzeDdrZ2tKVktEZEtF?=
 =?utf-8?B?N3hiR1pRNXQ0UkZJNUFaSzBnYklXN0NzbXVrT1Rhc00yS253VUNnS0kydElw?=
 =?utf-8?B?bHltNVdialQwZEFNL0JyQW9wTnFqSXYyb21GeWF3bTJiZWg1NDltYVpQTURr?=
 =?utf-8?B?ZUhXdVhlVjFlTXBFcjFnNXhLblFkWmxrOHMzK1VhSGFyQmF6dTI3SHByWFJN?=
 =?utf-8?B?U2VYeHdaUnB0Z25qQ09OdnlUcDVVaFFXLzlUZzd6R1lBNTkwSTlzWGdOd2tv?=
 =?utf-8?B?aU1WWDZJeTRCV0JUTDZlWU5jL2RzNjNmMlp2eGwrbWFMekpXNmg4MXdxRGg5?=
 =?utf-8?B?dUtyZENuWEVRU3VqN2JyQ1NPbG9FbWxXV2pyaVJ5YjNuU01XOW9PalV4Nmp4?=
 =?utf-8?B?OGM0eElpZkZHd2w2U1ZNbDBuRXZDeTRBUGgrRm9XUldHbVU1QktnRFFaR2xE?=
 =?utf-8?B?azlPeklmalZaZGIxY3NRSnpjbi9OeXBsSC9KbTR1cUpIcTdLNlkzYU44c2lP?=
 =?utf-8?B?TDdlRkRPbDNWelhLUlduS0FxajZuUkpaWjl1L3hTb0oxbDB2TGtiTUlPdnZG?=
 =?utf-8?B?VkU3S1VkNkMwNmREY3ZIbnNWWUFIc2Q2b21UYm1aM2MvMklYZEdBVWdJOTZu?=
 =?utf-8?B?ZmVzUVZFZitOZGtkOENkQkN4ZkR1KytjbThILy9Rb3NGL2NOcXp2dGFtK3NM?=
 =?utf-8?B?Mm02WFhrZW9pcGg0U3VqV29PNUF6Q0s4ZVUrL3dSQlpxaWtuUnpRKzFxZ2pB?=
 =?utf-8?B?ZWdsc3F0SmRHV3FjY25JejVOT3pwNlZ0VTFYVHlPUUZ0eWtYOTVDOHJNUHBx?=
 =?utf-8?B?NW9zcS9XSGJ3amFXcThNSXppOUZDMlJNc3BYSWxMRkduNG05VmpwaEpmVUs4?=
 =?utf-8?B?VzBwbHY3VFMvSVkraUxMM1FwUisvclZkSnJITkRwYmVPUW8zai9pRy91TDdm?=
 =?utf-8?B?ZndwNVl3cXozTGxDYi82K1EyVDNnQnBudXo0UGJTVUdDSTVaQVBvV2pDalR6?=
 =?utf-8?B?ZzI5ZWtTRXlSN2tONUdOK1ZLKy9ROFVRQ2c2YW9YTi8vV1l5SUlVRFVuUkF2?=
 =?utf-8?B?RzJsdUt3SXZ4M25nY2taN08vbXJpeHdGbTkzcFFEaWlUWXU5SEtaNXFTQm5S?=
 =?utf-8?B?aTdvTXdBVTZ0aG8weFEvb2RLSUtHNTB4RnJSbjdFc05jNFlnTmlHS0FIUnFs?=
 =?utf-8?B?ZXNoQnhVdyt1Q3dkNlFmZWd6RUdnY1A1SG4rdWZLOHNJSVZ0TlBydzVZSHRr?=
 =?utf-8?Q?5NiAuNoKBFry94Ch4duT21gbbsGWhO3TIKAW0y5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391a1760-618b-47fb-41c9-08d92c5ffdf6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 22:35:04.7330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGjUUXq5Mdibox40k9YBpV1SM4++f3P4xRWedYbPTNsJMK4aTweDWiuTuJBipUfeehceka9iJkPHm9Y0fTJYEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2551
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100134
X-Proofpoint-GUID: iWuCJM87vT8XJ2uhv5UgUJj9GcSau2uj
X-Proofpoint-ORIG-GUID: iWuCJM87vT8XJ2uhv5UgUJj9GcSau2uj
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 5:13 AM, Muchun Song wrote:
> If the vmemmap is huge PMD mapped, we should split the huge PMD firstly
> and then we can change the PTE page table entry. In this patch, we add
> the ability of splitting the huge PMD mapping of vmemmap pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/mm.h   |  2 +-
>  mm/hugetlb.c         | 42 ++++++++++++++++++++++++++++++++++--
>  mm/hugetlb_vmemmap.c |  3 ++-
>  mm/sparse-vmemmap.c  | 61 +++++++++++++++++++++++++++++++++++++++++++++-------
>  4 files changed, 96 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cadc8cc2c715..b97e1486c5c1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3056,7 +3056,7 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
>  #endif
>  
>  void vmemmap_remap_free(unsigned long start, unsigned long end,
> -			unsigned long reuse);
> +			unsigned long reuse, struct list_head *pgtables);
>  int vmemmap_remap_alloc(unsigned long start, unsigned long end,
>  			unsigned long reuse, gfp_t gfp_mask);
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c3b2a8a494d6..3137c72d9cc7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1609,6 +1609,13 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
>  static void __prep_new_huge_page(struct hstate *h, struct page *page)
>  {
>  	free_huge_page_vmemmap(h, page);
> +	/*
> +	 * Because we store preallocated pages on @page->lru,
> +	 * vmemmap_pgtable_free() must be called before the
> +	 * initialization of @page->lru in INIT_LIST_HEAD().
> +	 */
> +	vmemmap_pgtable_free(&page->lru);
> +
>  	INIT_LIST_HEAD(&page->lru);
>  	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>  	hugetlb_set_page_subpool(page, NULL);
> @@ -1775,14 +1782,29 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
>  		nodemask_t *node_alloc_noretry)
>  {
>  	struct page *page;
> +	LIST_HEAD(pgtables);
> +
> +	if (vmemmap_pgtable_prealloc(h, &pgtables))
> +		return NULL;

In the previous two patches I asked:
- Can we wait until later to prealloc vmemmap pages for gigantic pages
  allocated from bootmem?
- Should we fail to add a hugetlb page to the pool if we can not do
  vmemmap optimization?


Depending on the answers to those questions, we may be able to eliminate
these vmemmap_pgtable_prealloc/vmemmap_pgtable_free calls in hugetlb.c.
What about adding the calls to free_huge_page_vmemmap?
At the beginning of free_huge_page_vmemmap, allocate any vmemmap pgtable
pages.  If it fails, skip optimization.  We can free any pages before
returning to the caller.

Since we also know the page/address in the page table can we check to see
if it is already PTE mapped.  If so, can we then skip allocation?
-- 
Mike Kravetz
