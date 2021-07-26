Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D533D6867
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhGZUYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 16:24:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2800 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232772AbhGZUYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:24:20 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QL2de7004717;
        Mon, 26 Jul 2021 21:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jP0yE6FJwkwy8UQ5ymjgEZQlGAxfb2I+Yq/Bpl6IkBo=;
 b=zRz0irdJcR2Q5LGW6yuAdfb+ETOgsMQricwZj0fRMnks4zM1XsA19JSv4DMr6PyMfrpp
 nBIY9hJ4KHHy04j3eYKOWHzsiOUke0DNdSRQRgd9d5EhfSq0p47CNZ0cd5wHyq19DVsl
 RlYOQjchXcejmkGEPQCEX6j1lkG3hwGkZZglmR6jATLwHgmWRcB01i0zp25uSMZCYFRl
 xNPYRKhsIfb85fbe8kea2vw4Fs0gWdKWK3zxmdcvFsHL/SA8Vhv/pHjjudXCUvX8WfM9
 V86cdDMuyBPpaO12oIihKBawP5vSVx9pwzWRiJJekHvts8RYoPaZJjVb+SUOguhRBKd7 3A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jP0yE6FJwkwy8UQ5ymjgEZQlGAxfb2I+Yq/Bpl6IkBo=;
 b=TZa0scbbkwK6ivnF8m5taxzrS6AeKEtlccrwJTEL18aSoRAVTPbD9qD4SGtuI9WuA9l9
 sEfcI31ZrsFe8VcevR13nrd31Oa3DJtmrd/gS1H3EtR2/TjF/Y/wPU7Xjj2hXuZ9HY8g
 k0TupElDYwhU/nQixIRmVeBhXKrRGBYGnVKGgTNTKFa/czy9EGgdLXgcItRCUsBtrJoE
 F3jovpiybys8xmOi3kBZUOm90t78xZmTBtTC9Kz0PbNvjeGybSZPgd15SvSDjK8FKRTo
 GlPodHYoWDQHAJMJQ+XJua+p5oHvlWIutZsSzKdgUpeb0kTz+qY5pFD/AKSX6wVzDetR uA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a234n06ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 21:04:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QL1T2k005277;
        Mon, 26 Jul 2021 21:04:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3020.oracle.com with ESMTP id 3a2346vrwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 21:04:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi8+sCpbAxRc4QWlH+t9TF+6bAlN/V/bQ0ZpMpvbWkKumIktqFtBfZNBnAsDuP/pCpkxe1n0HY5AwHEP+37NjGzx8tsjNESeQuKjlsSYSnloRBgBGdbTjhZgU5M2Obr9qmmBK7S8wBQBB9bgqM0Q32+whLUIceS0cZcS/EqbErPCezDG9pkppW12hhTba8ZGivxcFsjArSZ1OMzTquzvQ2xLtcEpWcTzb/7KZdKOXFVIhsjlESr3GD1NRRbZXIJ+WfNREXS77iG+9b6wPQjNOljf7JtsFa1b3IXMnkApmvJM5IXpKxQUlXsRpcJOt2ubkC7CMXKJuvnlOAeFhCqzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP0yE6FJwkwy8UQ5ymjgEZQlGAxfb2I+Yq/Bpl6IkBo=;
 b=Z7fmNxaX23s3oafcmrL7GQqWN0QnQzeGPqrzYY//iMvIdHKI+tDYjADiriezZaUTJKujTS79Gqy4frjNB7BMSaf/Ao2HtFaB7OgQLh52/dBI5x1k1GAScAYq0jzWQNmILFoZ9AnFeaGojVneqEiKxVSfqJbJva24rvi/pgnxN1cEbfXu/aqFTtG5WM+JYfysMGpSB0n6Go9cgh0fb7cR4H9PKXr5Ji9obSP81iumssSu8/YHI7yaWZY30a33qToR9VvlnGgCViJXDogUDB91gWlwRns/NZHgsEVV+km4ghDboDOtoHx39YDHcK1jXKYdFdiORXJq5IKqprK5MT7hUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP0yE6FJwkwy8UQ5ymjgEZQlGAxfb2I+Yq/Bpl6IkBo=;
 b=uONEwmGVZQ9uPO8L2IU55gcSh1FQ3vHFMgiHmrmR1Kwv8o6Q2CNsYV3C6bpf9HqoK6e2OwApJS+/g4OOd/x8SERZ+DQiTcMMuNan/kJzQxvaG0rDL/RZXGzf8l70SMCyEQZEYUsns+j9g1WU6/zmwyMowHBTjmgInsoafyhhi+E=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2743.namprd10.prod.outlook.com (2603:10b6:a02:ad::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 21:04:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 21:04:27 +0000
Subject: Re: [PATCH 1/5] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, zhengqi.arch@bytedance.com
References: <20210714091800.42645-1-songmuchun@bytedance.com>
 <20210714091800.42645-2-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <cf279a44-2a1a-6385-8230-86e083e11ba0@oracle.com>
Date:   Mon, 26 Jul 2021 14:04:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210714091800.42645-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0049.namprd15.prod.outlook.com
 (2603:10b6:301:4c::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MWHPR15CA0049.namprd15.prod.outlook.com (2603:10b6:301:4c::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Mon, 26 Jul 2021 21:04:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a86a4600-115f-4129-6b40-08d95078f3c2
X-MS-TrafficTypeDiagnostic: BYAPR10MB2743:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2743EEEA832585603270FA94E2E89@BYAPR10MB2743.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlMUEaYg3CY4aczabh9kSVVbjLnPr5jLmsLZe7mdMU79SWXP7aBZkl/+NeMYZFHzNbkaIkjy1qfYGqFnpIR6v1XfZ8BMEh/WT1aWTjBpQYsHj6Tj6o6fcgm8Aar0fbtJpS+n1CWQZINAFMsESfVWpVnSFGU2Fpp0wzYgV2K1azJN34sSSeVnHymkm3u7wa+7cGKKQdr4j/KyluhwN/iHb3iF61MQqpHWMgs0AqLNI8rm7GfGQZ7zogILNUOaAG9Pa28MFn6rULqmelNi+JFgMn0k27qBSM9T8NtuyS03HoaX0Zjrvs0gBonQa/jBpmuqhnDQt/kC3zrcKfLdHAfqSf5IazuTPVRtOJee7MC1Lim5e+/b3zGTjfVEGpPh6LI8yt/Z6oKHr4ebccbFqzyHHAN85Im+ElLQHdIDzIrvjLxAJsqCkYeW8iW6y9F/Vb1m0q4KswldB+maV1HEx2n5nR4EvyJNk7eftrpgA6r9sFP/QeDQzLQ9y42JZ3YoSDE3sXJkc1XD5nDGGlgZxEgTFRtSO1Ilah+vRhnXsBf5jKnWVGRdcCmDjOirPJdZc9AYI3xYEV1YpJzfqXVn5TmhpOXCjCR3ZuTrjNv6CMubor3Irf7GQklkjWd1yW98/CAZJnl477q28Y4+xpQFME3QlmfCaUN6gnqnWSGypiEH6LRlbU2mhwoj/LCABCA3Ap9SImaGKTWgDkrHFLgESCq2fMGWFsm2JYV9eZe/p8GCMB99xYCoF7qw+3jmK+7SuA/rYwY9YXWbDAy77Ihtbrsz7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(366004)(346002)(31696002)(2616005)(478600001)(38100700002)(956004)(8936002)(8676002)(53546011)(44832011)(86362001)(52116002)(4326008)(16576012)(5660300002)(7416002)(316002)(83380400001)(31686004)(38350700002)(66946007)(6486002)(2906002)(26005)(66556008)(66476007)(186003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5f09nhe0JDq5zetflpYKdnjtQBLhelz/v2Fu+Lu3l60/Tw2QMtk3h56hvkCz8s9yeLggzrlUm+sFS2pJRsHRlK4q88B6S4uWAE4GsSb6zBylhj1LepknqmI+Rjcy1nxVyicuvyDNBVDQU5a+cRi4pNadG+lYcAMv42kgt7nLGX0KUAcIV7yTMaSrexNShouYLx87l5nLwHe8oXyV7UtY+ruAFLdRdW7v3s4QUV4UbC/HsNorEps7rQqB8WpwuWslIBCe3WRqIS/ZOAqxik9TW0ZZrhL2Vqsu/QkmZG/8B3lkfuD9NtetsX5lbgkVKB3ZmL6/DFMNm1fWyQrtYJvpXeT/10/YRVVIaBHtUFotC6wEi6iopRJG8EUmBGTakzsW01IAyglVOaJDvDGvm9J7C2kPqCBiIVX7DoWkVR6JbHVE9Mba8qqZ1+98CaL6Evzv3hbALNx7kXtLLBPFXMUi/MuG1dG7Q7aNNCGfGzS7FIY0Gn7Xs3mGl0OYGj5oH1UNoE5d3Nh98B/dTapYzT2DQOqLz8Q+fuT4i2lxNrn7i0RscfXJKGcrvpWrB6QlM2ujUALa1SPKVOB6Dz2BqjAI2/cwuAencZ+4AiPEySmCFCIi7uT8QQIZKhxS0IHYlo4kHX+A9o8CG1hC9sxjoXlot7ieYM4+xHffK8FLqyVL1q7ZvkkB9XF4RzInjqU1XHTG7y+fwoHlrwtZLJc+t1LSxragPoM+NaHQys0c/mOHZuk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86a4600-115f-4129-6b40-08d95078f3c2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 21:04:27.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EF7IMaR9wELCFWX4E9ckJrPQf0q3TkZCq9hWPAM+gzN+qfH0qHmB+pDu7lnKn21wetWS4pbFstXjzoq6yoc9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107260124
X-Proofpoint-ORIG-GUID: b3Kr3VzG_1Ilw8AO_TWfEppka2IZgXhf
X-Proofpoint-GUID: b3Kr3VzG_1Ilw8AO_TWfEppka2IZgXhf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/21 2:17 AM, Muchun Song wrote:
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
> index 5922031ffab6..358d3f6fa976 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -178,6 +178,8 @@ enum pageflags {
>  	PG_reported = PG_uptodate,
>  };
>  
> +#define PAGEFLAGS_MASK		(~((1UL << NR_PAGEFLAGS) - 1))

Can you explain why you chose this definition instead of

#define	PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)

and mostly use ~PAGEFLAGS_MASK below?
-- 
Mike Kravetz

> +
>  #ifndef __GENERATING_BOUNDS_H
>  
>  static inline unsigned long _compound_head(const struct page *page)
> @@ -859,7 +861,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
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
> 
