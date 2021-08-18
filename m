Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3454B3EF7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 04:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbhHRCRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 22:17:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47242 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233380AbhHRCRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 22:17:11 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17I29fqQ011877;
        Tue, 17 Aug 2021 19:16:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ezYUnDUBHLcCEqG6IHd6G+mfOcQ76R6FDtZdqIskcKk=;
 b=FiNRSosWTMWDsP2yPMSA/OwAmsAGvmliJOhUeWUm9JBy6Jkj7uHlm/YSujK86zTncRjN
 nhPf0DJnF3zk5H/64Bd3Ja2ci8N8suj7ueLAgYyIvU583qTcE3ZolvCoonsYicaHjNxG
 xtEpr1gAyGP7QkVY7z0ZwCacIUQ7/QsLCuo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3agfhqbt93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Aug 2021 19:16:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 19:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdROuT2tJa8qNlCS19E1HFxXarEab8yZek9Z/5x6MH843aG0MmThjI6MVNrVIOVZd/lphINsagwuPEaP9gY1fNU2Yr9kLBSA+WsZUF3xADBW4VBVSixA/qCQ4rc+fZR7jdcvgf2DeJFTm3dmQ5SybGaK8qJkUxoJ/OJi0e79juHftIZzTqflIq3KpsPq+diKR8Wvqrxn3S8layTYWwo0L3oT2PGT8ikZNfNkPsKQGZYgFuffFR3bo32YKACQ51/CEkfKIjDb+gcrYaWT0Ly7tTKXcVtrUvDNyVVWEqh2ie1xwZxQ11g5WRMPJOSOS2SzEecJVop088sFzepZ54N87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezYUnDUBHLcCEqG6IHd6G+mfOcQ76R6FDtZdqIskcKk=;
 b=M1lV+E387x/pc2zAYf7eIUp8Kpxx8IpFqeACw2wbjLgUkVsrW1+7HGeznc/zP2cTV4s8elet9NDljpupvRdv5fPzqSIml8qyNlDpuF2iA7M8qTx25FCCUIma6YiOWc46heeZlEBPMMxZZpP5d+uoN5b9HlnS0sPxpNtBzL6fJu9l/uPzbjBEa9DsEXlOhVN13z1cNoC73NVdy128csnjN8Hqe5YK4C7J6SekJYBemZdObMy1TPIWGFhRtgJXvkdwYfNx2nX1s009mPSA6kJR3gmY/jhXUl1bAEEtNZ9vouVW6W/T655iCFyuL6+Qx32aPBxbuB5GpwOSSp4ZEyK7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4219.namprd15.prod.outlook.com (2603:10b6:a03:2ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 02:16:11 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 02:16:11 +0000
Date:   Tue, 17 Aug 2021 19:16:07 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
Message-ID: <YRxtZ3X8QGv/bui5@carbon.dhcp.thefacebook.com>
References: <20210817033032.76089-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210817033032.76089-1-songmuchun@bytedance.com>
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e413) by SJ0PR13CA0203.namprd13.prod.outlook.com (2603:10b6:a03:2c3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Wed, 18 Aug 2021 02:16:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dd78b91-205a-4fa8-ca08-08d961ee2582
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4219:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4219BFFF0B5E0B77E4B7E2B3BEFF9@SJ0PR15MB4219.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:106;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJErv7rPSfkd+wogH7INuhXaL7reJa4hjsan/JFMazTOTNBuMbHJzIG1uwBqh+xVFe6XtGvhga/Pd4koapFA7jZxk/bSBkn6QLRAEaqZi/XlShKm2QM9CNX1FQDjJKZPkNCG5MY+BzbZTIDsdbjnnL0B3cufbeC5+XAzV8OVGuY1B5fULJjrKB66ucuL+kBvdNZmK2pbB75e9NDkKP/Ts0X1cVJO1pU6kZ6zrHA9OkuPbFzDo/t2e2WEmId/EU/oMQYqSXbrPZtfdPvOqPf4vvmOILG6Yq4rpvi+ObVYHFoxb9ntU355ZKDmDCMkKo6d/I0fw+uK/+9W6eWh1zYQEmdgS8H1eyCrlhIy318qcqyyqE+r/0SWIdXvnbrBHKdzWMOK1S+beV8BVeJIAzV/xw+kOknuSNe84ywKPSRF5zKEzYwhWbrzk2IeGi0UDs3hakhWxbECC6/XR2bzJ8A+HWcHG9F6qWYja8z4udVPX2Kp08vVwS+nSTKRZvUwvQeBZYkmQmpGMqrdd2slkRCyeK/BXytz1ekgX15NysLML4J/JEmi8or6W2DikN9zNwlb1ytW6OtJc98Ba2Azsb8kcLr20pWb0WL9w3zJIkKjBI/Q1EcrMC/dWeIwy9y8bInwNqOJQn/Cf2/hahlbC1SFwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(5660300002)(8936002)(186003)(4326008)(9686003)(55016002)(316002)(83380400001)(38100700002)(6666004)(478600001)(7696005)(52116002)(2906002)(86362001)(66476007)(66556008)(66946007)(6916009)(8676002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?btBQ12Z3E4nXfHRgh21/0INadd4mmsK/31ORJgYmERhp3D7AwyjUqabPO7Ve?=
 =?us-ascii?Q?ojH2N75UvfJqIImqTivHpOjBkv2Ngzets0iD56wJSbO7ljZ8d5fDy+9cixz3?=
 =?us-ascii?Q?eRo1WpDg5HyCNLYuzxG0C5JRf+NrTdHAqwe8+FgPQaSvJRQkEdCCK3TlZci4?=
 =?us-ascii?Q?z9Fcf0gdyW5NDfGR3sSsTcTz4YUm/pn/QO60pJWF36/yLVn3VojHFmiAViSS?=
 =?us-ascii?Q?Ec17Uj2N24dIY1JrjqaSiWqxwN42dXCkKy5N9EqWnlQNs5EvJ8RRLM4fknQR?=
 =?us-ascii?Q?5wEUEJrjF4MdmBiAaPhKGsoxHLglk4+jXkLzEHRy36tadrhp88ce2eBK2iD9?=
 =?us-ascii?Q?+Iuzps+j+RBzdi18Mq3+cv62PC4rz/BFPAwzGeJ64KjVpVqyZL0WoA39jh7N?=
 =?us-ascii?Q?u3uusDGH8OFr/QDzfsBMuINBzxjfvQt6oRbYzROiEi7ro4es1rX7WCzxgSeu?=
 =?us-ascii?Q?GfBJjnoZPRYDyES7pFuzX0FET/5OnMy12i+30hHDYB60ApKUm4OvQQKRd2QT?=
 =?us-ascii?Q?9wAzvkN6X3J2lmoI+noy66nvovwDj0/P3kx18SmiFiU3UTB1SMt9+2widJhJ?=
 =?us-ascii?Q?AGttyl4KrtdSM5JOG/X6GwxUsNizLyLUA2iLPBXlpZkdtrkA97sm8XIbfPzC?=
 =?us-ascii?Q?/iIUaFDVz8h9Dd61Go9Sm02ubayYVLB/nFvUp+A0zp1WRZTElqAYlyU8j6e5?=
 =?us-ascii?Q?LrMq+hfbhQrqAk4QQeS70EgTJLksE4m/HmCH/+Hdf09oYJ6x0bmzj2MJvBo0?=
 =?us-ascii?Q?YDGhejmykCS23lZv7inQt/nknigFR+NBo67jAHJF0UXQbbuuSBCnEEuRftG7?=
 =?us-ascii?Q?e9S1rw1ThWHMQ/Qx+2P2K7n76ErQkjcpwI+ttTFfhl74/EeQ+tSU16I/RR2w?=
 =?us-ascii?Q?z7bww+raXNxJhAnKHANukOe70M6DK6nuXnDkX3hU0efOe2M/3CQId2VxqFNP?=
 =?us-ascii?Q?stQ0vxs44VoDAKruBvVz7+pcslMa9Myu4RoytUKxvWs2SOk5CftfRdyc/ahE?=
 =?us-ascii?Q?iK4FZGTdybgggjJzB0wDc6x1PaamLxSl4g7aVTNFWhzISEtMOyUwb1Jtz9bH?=
 =?us-ascii?Q?IKXP+wevJNbKxUl5jtHBhgL0lRDOzenmETTpXxNfcmyUauW2gzQr7V4KunHk?=
 =?us-ascii?Q?I4GcVvNrGW9/H3o3yg8dkrrqFQKV8ci04SDZsHlEOLXC3vlPMfEDaSKBA9wm?=
 =?us-ascii?Q?RF1tbrD7G5ZftmatncHevKHvIdi/0DgNqs8dyxYHDZQ+ltDbSI08GeKv6osV?=
 =?us-ascii?Q?2uXgQ6jy7JuiLy5sG9IVdWTlOkWpcj6c1tyctq54l8ZtasMdXyLyQ6qzWQeZ?=
 =?us-ascii?Q?Mw9kB+Eal18RgkZz/Hz+mjsh5ZZywpkPLwjuW6vufFp+6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd78b91-205a-4fa8-ca08-08d961ee2582
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 02:16:11.0803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DW/N5ybz89Cvjg/u53a9YmEAh2rDFfXyZ5NSu/6NHB6NPr13GM0klHVnZzRo4Fhq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4219
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: npkv_Y7caYgcUBg7vJhkpOjqxDdZzu4J
X-Proofpoint-GUID: npkv_Y7caYgcUBg7vJhkpOjqxDdZzu4J
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_09:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=897
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180013
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:30:32AM +0800, Muchun Song wrote:
> Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
> PAGEFLAGS_MASK to make the code clear to get the page flags.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/page-flags.h      | 4 +++-
>  include/trace/events/page_ref.h | 4 ++--
>  lib/test_printf.c               | 2 +-
>  lib/vsprintf.c                  | 2 +-
>  4 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 54c4af35c628..1f951ac24a5e 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -180,6 +180,8 @@ enum pageflags {
>  	PG_reported = PG_uptodate,
>  };
>  
> +#define PAGEFLAGS_MASK		(~((1UL << NR_PAGEFLAGS) - 1))

Hm, isn't it better to invert it? Like
#define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)

It feels more usual and will simplify the rest of the patch.

Thanks!

> +
>  #ifndef __GENERATING_BOUNDS_H
>  
>  static inline unsigned long _compound_head(const struct page *page)
> @@ -975,7 +977,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
>   * alloc-free cycle to prevent from reusing the page.
>   */
>  #define PAGE_FLAGS_CHECK_AT_PREP	\
> -	(((1UL << NR_PAGEFLAGS) - 1) & ~__PG_HWPOISON)
> +	(~(PAGEFLAGS_MASK | __PG_HWPOISON))
>  
>  #define PAGE_FLAGS_PRIVATE				\
>  	(1UL << PG_private | 1UL << PG_private_2)
> diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
> index 5d2ea93956ce..643b1b4e9f27 100644
> --- a/include/trace/events/page_ref.h
> +++ b/include/trace/events/page_ref.h
> @@ -38,7 +38,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
>  
>  	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
>  		__entry->pfn,
> -		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
> +		show_page_flags(__entry->flags & ~PAGEFLAGS_MASK),
>  		__entry->count,
>  		__entry->mapcount, __entry->mapping, __entry->mt,
>  		__entry->val)
> @@ -88,7 +88,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
>  
>  	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
>  		__entry->pfn,
> -		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
> +		show_page_flags(__entry->flags & ~PAGEFLAGS_MASK),
>  		__entry->count,
>  		__entry->mapcount, __entry->mapping, __entry->mt,
>  		__entry->val, __entry->ret)
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 8ac71aee46af..eadcc6458b10 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -614,7 +614,7 @@ page_flags_test(int section, int node, int zone, int last_cpupid,
>  	bool append = false;
>  	int i;
>  
> -	flags &= BIT(NR_PAGEFLAGS) - 1;
> +	flags &= ~PAGEFLAGS_MASK;
>  	if (flags) {
>  		page_flags |= flags;
>  		snprintf(cmp_buf + size, BUF_SIZE - size, "%s", name);
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index dd006adfe853..ff7c180a2971 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2019,7 +2019,7 @@ static const struct page_flags_fields pff[] = {
>  static
>  char *format_page_flags(char *buf, char *end, unsigned long flags)
>  {
> -	unsigned long main_flags = flags & (BIT(NR_PAGEFLAGS) - 1);
> +	unsigned long main_flags = flags & ~PAGEFLAGS_MASK;
>  	bool append = false;
>  	int i;
>  
> -- 
> 2.11.0
> 
