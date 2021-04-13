Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4621035E554
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347329AbhDMRt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:49:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20058 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347320AbhDMRtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:49:25 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DHXHHX008428;
        Tue, 13 Apr 2021 10:48:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=b4LCig6QV6Y6KLrSWnbORke+5WAPq+fhnSfBKH0S3WU=;
 b=pZ3VAS3Rj61Gx5/9sszV+r5SDGd461hp7867oTf947Pl3wSxGZxF9BtF++Dc6WA9J+Rm
 1aR9w5kUkgQD4opP2t27p2/P0UKdVazSBTzfInN9hHPcp1ICa+9YrNjyzLwiHgtzSy3f
 1B38yGW7PG+OUU1XQFoEx9B6d0yJYO/1rmY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37wabfa89k-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Apr 2021 10:48:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 10:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IobEBhWPXdgUOxYn6zzSxZJ8bZ6nACvelBrTTv2nOAyIMuJdtSqf6MyX4f1kM3A1/5/5mtIM6Nm0Lpyc9OK+voivVed/K4E+2JEHJJsoSLQ6pXOqmgaD4mcgfqKhiPvg6iVtdIDTi1P/7xo91gtuBK65q5DCz8mk1J2R3TJF/Fpj7InMn967W7zBE/881jaQMdWY007tQsO7zdOHhbsvGXv2eLWfLKVWFDeLjb6EYoBro0GBCA+BILpqfwlzPblnRZEkVOIdcWwYcoY/QQcgb7fOmeKnGIbGWjmezseDN+iSD3OYfnvDpvdZUE0PBvz9Fq85x6prEGE8XbTAoH3f1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4LCig6QV6Y6KLrSWnbORke+5WAPq+fhnSfBKH0S3WU=;
 b=E8xr6/bvUc7HxJOD/Z1FUWtOjBJlNNCjFCRo8V8XFP/Fk9hihqn8B6vGvHEV4rGiOGcCIUaa5m8cHUVuo/4wTlS72+zCi9J9x9M+p5E56f4fj4ksZKkieI95c/nqy1T0brvkkQOYzxZe+AhLkkNAkQ0aATJT2rGyrLutVPmHnob4yVjcn5Nou31ExY+q/1ETjPn99i9sgChb2SUCvSAI/lx0z1H+TMAX5exFATvaEN4Wlu3Vpv+gpy/PdfPz3uxbXtfLFoLCjATi6YQKJYgHK/06OXBIhHUu8WVAGIIHyZ3/0QA6z1uxO7TfWY6q4fsSb6AR/gFI1Y5wOnaZhixM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3077.namprd15.prod.outlook.com (2603:10b6:a03:b1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 17:48:55 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 17:48:55 +0000
Date:   Tue, 13 Apr 2021 10:48:51 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>
Subject: Re: [PATCH 3/7] mm: memcontrol: remove the pgdata parameter of
 mem_cgroup_page_lruvec
Message-ID: <YHXZgwpx2RRJ2qJW@carbon.dhcp.thefacebook.com>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210413065153.63431-4-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:ec38]
X-ClientProxiedBy: MWHPR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:300:13d::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ec38) by MWHPR20CA0013.namprd20.prod.outlook.com (2603:10b6:300:13d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 17:48:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53fe8854-2e0d-457b-c0ee-08d8fea46821
X-MS-TrafficTypeDiagnostic: BYAPR15MB3077:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3077F53F1570262C1E1EAA9EBE4F9@BYAPR15MB3077.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EGytNd3aQSvHsUFVWhV3oVn/HzxROw5ZdSMkxcTIGv2KPFqDqPJTaXlVquV0JkSWaB0LWPgq6xqtmssSioSCyZxM4PzEPFv9Uo4a1dcEYsmH1boy0nrgjIjbQDRsG/ILlHRD1f5XzuCVwBjTetuOmSg8r4k4NOBgidGubUSx3k8FR/Kr7Gaql+xRbNJ8Pc3X368Q/1quAuVW44GSNvIwh1BGDKQW1PbNJBW4cV38MhNNU1Ubh38Klibyu/AKbxThStBq3b4mA86dlmI2kOYZiG8ITmx+7D9NUxZ96rpMel0qG1+qtJXd494zJbpFawhAF6qTXe+FrlcOH4u+dmn00IOaIeEmU7Cj4Bzxk0iMsNA1lKTUsWVvNhszO35OSeNPkjt0R+m6HyWBb4wFrADLbJKJ6ExMZZ7F0MhTiZFm9gcaGzvd7MLUizmKPdagWXgiU8DIRO/Vm35XJezVs908QqLcqB/X2qlpJ33TgCuJCWscc/kt/QT74DUK3cqikVrU/Q7iGNluTrWwGVgYs5PWqj/Euu7PTOSvNmOq6x42TqNUK4TRio6eWK/qsuPIY+pfbipRajO4NnT+fW8rvzK6uNrsy0P+lLMiDILxOjrQHu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(83380400001)(316002)(86362001)(6666004)(8676002)(7696005)(7416002)(38100700002)(478600001)(6506007)(66476007)(186003)(16526019)(66556008)(9686003)(4326008)(5660300002)(8936002)(2906002)(6916009)(52116002)(66946007)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Cm22TidWv94MtfDygqjos351i6JhygyGIYshaHker3RHLvgJngaT0T6o0UJp?=
 =?us-ascii?Q?WD3GBBYStxofHrblk6uIeZCw+AB2bIjH45CkoGSERxkrXgKLrUEOlDNlgNQr?=
 =?us-ascii?Q?6klbqjlxgNRIhPYH5kSkl7SOTA/eJnTqFzTg03PC8AxPekWTGuf+imnGnBR7?=
 =?us-ascii?Q?10+iKPN92KLdZxdcdDBOSgouVPUu5jLB/NFlyEhkii8o2U+BSSS5ecVKfJnI?=
 =?us-ascii?Q?2ALtUN2h+AkJj51jMXCpmNPdlnLQ1tDkdrOgo8u8AE5m2Tj6/A2ivzP/tTT/?=
 =?us-ascii?Q?oCAiICCnvJyE9uB2dlQyCnCqc4bnp4bI67PulhSb0MhuT4yxnvrUqhbGWg2D?=
 =?us-ascii?Q?WWL/GpWcBadrf8cCgUll1CJzmyCBlEDJX81paXxezGeRHFP86x3pMvjOC2aK?=
 =?us-ascii?Q?M51j4k6t/sk7HdPNGVL+svNfqBXF+oQ1pPteGP2JOrDhVmAk/YdIyu+9DntX?=
 =?us-ascii?Q?Ah8vxQPGrunoQFwe0EovlrBhtew1tV29TwXKaCUytPoxaHJ+1+MyaGInlAgw?=
 =?us-ascii?Q?MuS16jtfgow4j2n0iPDcJegtQV/6VC8zQM537XV3PMTkFgttxPQbRDgCbYGw?=
 =?us-ascii?Q?KK5P2QacJ7vyIzp9FKBAVCzxMrlLAVhE3S2yLEGV20jZqB6c3/hJsFRLCRBs?=
 =?us-ascii?Q?1vfG+m5oMCzhg2VP36yAMIc54R8uYjJSvIEqjOYOV+kOUl0MWAzrl1cj+z+n?=
 =?us-ascii?Q?mRoLAmxdmfhf9k6PaUBHWd7z8hxFBNgubLyX4ymea/qHo+RnhgjXiCBoKvzy?=
 =?us-ascii?Q?NS3+JBrlnb+AfSMdjiyzCoRALzIBGN5rT3TuWS/mG+lHYLfCXUho0WV2avoO?=
 =?us-ascii?Q?Eh7mLt8XQNjVjW+XtkcDLmLrxoYM8k1MzcpxH7hLKH2Bggu2voYt9TDgcMQY?=
 =?us-ascii?Q?i/qlmgiZyCSiFB8UNbcoPFvgy50CvYe32bE49e5l0ID4LzkeNKHZgez7QPEu?=
 =?us-ascii?Q?IgMCrKMyQMxc8ks1zZ2L7baSOwcHK/d0BWgj3SADvmmblZjMorslsRJJ8H1H?=
 =?us-ascii?Q?JL2XECCSZ8O+HEk5zBYAsvVMz827OcGlsVoP4bIx04vKgn6gExRnWn4VFT4w?=
 =?us-ascii?Q?EoJkdk9in/f9VMeZp2W/z0soFxqeapVYRsBd0HSgf+1oUIhydGVYjxT5xu3u?=
 =?us-ascii?Q?98PU3zD+V6FcLjFG+dbC/yKH3uywQdQfa3p3j9bFKqdo1TErhSoRoLwEyHS5?=
 =?us-ascii?Q?kPYOH1o9TL957d9fIARZKqsAazBhi1b7eXm2Ec5V/u7gDK6DjsAGMnIqfIgN?=
 =?us-ascii?Q?WBdSCluBMQgPwRf3b3EgnsPBJl+Vzqdc6tCOGjZO/N8xBI1wym9pCuC4RMmu?=
 =?us-ascii?Q?ApAgHwkMpfHMEXYbA2Zhaf4Dt1bxRN0G500rFqKdZUMTAA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fe8854-2e0d-457b-c0ee-08d8fea46821
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 17:48:54.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTQgZYVN27HGmktGpQFNyB/0OJic9vZqCA8eiSChJBCbi4f4aaq7+b5Ezx7eYLx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3077
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ih28UNQVCPrmIpTw30AMSXn68c-VESmy
X-Proofpoint-GUID: ih28UNQVCPrmIpTw30AMSXn68c-VESmy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_12:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=889 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104130120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:51:49PM +0800, Muchun Song wrote:
> All the callers of mem_cgroup_page_lruvec() just pass page_pgdat(page)
> as the 2nd parameter to it (except isolate_migratepages_block()). But
> for isolate_migratepages_block(), the page_pgdat(page) is also equal
> to the local variable of @pgdat. So mem_cgroup_page_lruvec() do not
> need the pgdat parameter. Just remove it to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  include/linux/memcontrol.h | 10 +++++-----
>  mm/compaction.c            |  2 +-
>  mm/memcontrol.c            |  9 +++------
>  mm/swap.c                  |  2 +-
>  mm/workingset.c            |  2 +-
>  5 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index c960fd49c3e8..4f49865c9958 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -743,13 +743,12 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>  /**
>   * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
>   * @page: the page
> - * @pgdat: pgdat of the page
>   *
>   * This function relies on page->mem_cgroup being stable.
>   */
> -static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
> -						struct pglist_data *pgdat)
> +static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
>  {
> +	pg_data_t *pgdat = page_pgdat(page);
>  	struct mem_cgroup *memcg = page_memcg(page);
>  
>  	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);
> @@ -1223,9 +1222,10 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>  	return &pgdat->__lruvec;
>  }
>  
> -static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
> -						    struct pglist_data *pgdat)
> +static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
>  {
> +	pg_data_t *pgdat = page_pgdat(page);
> +
>  	return &pgdat->__lruvec;
>  }
>  
> diff --git a/mm/compaction.c b/mm/compaction.c
> index caa4c36c1db3..e7da342003dd 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1033,7 +1033,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		if (!TestClearPageLRU(page))
>  			goto isolate_fail_put;
>  
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +		lruvec = mem_cgroup_page_lruvec(page);
>  
>  		/* If we already hold the lock, we can skip some rechecking */
>  		if (lruvec != locked) {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 9cbfff59b171..1f807448233e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1177,9 +1177,8 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
>  struct lruvec *lock_page_lruvec(struct page *page)
>  {
>  	struct lruvec *lruvec;
> -	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +	lruvec = mem_cgroup_page_lruvec(page);
>  	spin_lock(&lruvec->lru_lock);
>  
>  	lruvec_memcg_debug(lruvec, page);
> @@ -1190,9 +1189,8 @@ struct lruvec *lock_page_lruvec(struct page *page)
>  struct lruvec *lock_page_lruvec_irq(struct page *page)
>  {
>  	struct lruvec *lruvec;
> -	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +	lruvec = mem_cgroup_page_lruvec(page);
>  	spin_lock_irq(&lruvec->lru_lock);
>  
>  	lruvec_memcg_debug(lruvec, page);
> @@ -1203,9 +1201,8 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
>  struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
>  {
>  	struct lruvec *lruvec;
> -	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +	lruvec = mem_cgroup_page_lruvec(page);
>  	spin_lock_irqsave(&lruvec->lru_lock, *flags);
>  
>  	lruvec_memcg_debug(lruvec, page);
> diff --git a/mm/swap.c b/mm/swap.c
> index a75a8265302b..e0d5699213cc 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -313,7 +313,7 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
>  
>  void lru_note_cost_page(struct page *page)
>  {
> -	lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
> +	lru_note_cost(mem_cgroup_page_lruvec(page),
>  		      page_is_file_lru(page), thp_nr_pages(page));
>  }
>  
> diff --git a/mm/workingset.c b/mm/workingset.c
> index b7cdeca5a76d..4f7a306ce75a 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -408,7 +408,7 @@ void workingset_activation(struct page *page)
>  	memcg = page_memcg_rcu(page);
>  	if (!mem_cgroup_disabled() && !memcg)
>  		goto out;
> -	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +	lruvec = mem_cgroup_page_lruvec(page);
>  	workingset_age_nonresident(lruvec, thp_nr_pages(page));
>  out:
>  	rcu_read_unlock();
> -- 
> 2.11.0
> 
