Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2C35E548
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347292AbhDMRqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:46:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17752 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347286AbhDMRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:46:36 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DHaZ8I005919;
        Tue, 13 Apr 2021 10:46:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=X65k1IbD06fcpO7AtqPaDulKGiTZ9JsXn0DjdrL/kkQ=;
 b=q0++aarRIK7Fuc7Ajt7jJInUv0OhGgkymh8r4aaymsjnuVIhy23srLkJfAjU2WLy0ixn
 NhwaRQ1mYnKg9w2/sSSTyyGeg4n5XcGEGx4xXPKipuS0oJMqYe1dPf41+VxBfmfLHf1f
 exv0zRntBSAE6AzeAW7czr+P6b3ructGTCQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37w4k83ub7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Apr 2021 10:46:07 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 10:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3PbUvyLrFUBiHkn/5y49RbszX1L6tU8pnPoc4YLUN9vA+N6XV9LzjzP4r9/ZRfLrtq2cHnYr+lUxgTudGH1AP4epk3xz1qlL1Cit26ji2Fmrj9fD/KgLIyyKsazsfM2xFI0PdkbXflb2GEgaZSs5as4vjRJptYDJaiP8YEtG3+odZVzRem46hRsuaJIKaMHZdWkCx87xaGOO9C0bhkecHYdehJY1se9ebKJaKa0osaz76xLL1JXvCqIc3obW2jew8IiIN+vENGuu5Mhl2lJidBOqJ3nWEtREBt384AFnk3ZiELIqy+c7xZLs2oGntqdOGv5bju5SCzMlKBMnciflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X65k1IbD06fcpO7AtqPaDulKGiTZ9JsXn0DjdrL/kkQ=;
 b=W9o8nKtjbbHPbJP1OX3EpjGNO2z2YTHfaQVD9vvkZ7somt4VgihvWkWLfNJvSZKsK+2ZF+q8CydaInikjUxRwuC5iA6a2voF7qXygS99Gq50E/pE6+aEuHTOyiXoAf2u8/Mia043mER2R7b2vEtSC5i3yrqcDCEIrjI7DaaIB8xXfhx4yYFWzJztL7v87ddeAwqtuf7fS3H/e90nrhuOjp63OWoKsAzuVQSkOFR+YR3P+wBiYU6/i6KC54i1WknKtvf+OqAlIgwUAB8V4sLVJ8AD6pCaZBRCgSv4sRQG2BFl0I+fQJ1aC8UXKKif0FdKwGDptP4ISJS9zglHZdZZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2440.namprd15.prod.outlook.com (2603:10b6:a02:91::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 17:46:04 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 17:46:04 +0000
Date:   Tue, 13 Apr 2021 10:45:59 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>
Subject: Re: [PATCH 1/7] mm: memcontrol: fix page charging in page replacement
Message-ID: <YHXY123MtiWc5wPW@carbon.dhcp.thefacebook.com>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210413065153.63431-2-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:ec38]
X-ClientProxiedBy: MWHPR14CA0017.namprd14.prod.outlook.com
 (2603:10b6:300:ae::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ec38) by MWHPR14CA0017.namprd14.prod.outlook.com (2603:10b6:300:ae::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 17:46:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0444286a-185a-431c-c5b7-08d8fea40225
X-MS-TrafficTypeDiagnostic: BYAPR15MB2440:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2440763108349A938CAC4C43BE4F9@BYAPR15MB2440.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ohKfABAyX+lSOVa2LMwZkQoLa5unCao1bOrJWKIHePzn7aeHgyqXLxRlhh6q98LDeFFfT7An0AUNfIz1COmDjNbfg5GdkAKJe3SR4xXy9PNrvSml9OUtXtQbvg8iA0STxe8iF2P0XUz6vvR7PQP3PLmgce8yEdBRL/FV0L5qHxMhLF7g4VuRVpW5PpfaoXpZofA9775GE2AyQZqwTbxJydWIAq0m99DttnVJa7Mzfo9QGybO2/ibqUXFHMpNUWAl/UFc19pk0P0UEwtb1h/Vo8vZ45PC9J8O0GSSfoPh2zikhIv0QTRR+iqQDYpfeIUrdheenvOXT6mIEQ2vZ8iMrYEqeRWeOD+hsRKcF2opPZwjLuf7+p9FZFlQklZKPYbppbeBVAsqZJtjHMiqOEE4+fRJE5Ne8K1hY1XDh2ZgeJrMWzZy+7CGuHTb1scMSy/10+dVLLMM5ldes4ZOs34InR0oVy3EDPqKs0xDOTN8rSYnnvvvnpAcCRrspYmjVPReAGlw5BEdwZMcB06HANvP3XAZoG0iT86lFTuS9d7R/98eozoJJvkvbfh7uBv67xjWF35HlZE0P/EEEaqljJOdbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(478600001)(2906002)(66556008)(16526019)(66476007)(7416002)(66946007)(316002)(9686003)(55016002)(6666004)(8676002)(83380400001)(4326008)(7696005)(186003)(6916009)(6506007)(8936002)(5660300002)(38100700002)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dUCIvlduaAjwMHhrz72aeDMYKV+C4NtYPQnuyVIYR7LSFqqU8uHWHk7uJdNa?=
 =?us-ascii?Q?VUXDHwaQ4ay7dsrIRUI1pPXncf/WzvKM+GuyC5wrtWcyWEkSe1PX08+oTxad?=
 =?us-ascii?Q?3s8n7Yc1HESN/50PwLEimSM7mILMKDuD2vr753JU6I2ymj2oZS1b1DaWvS4T?=
 =?us-ascii?Q?dhGUb5ifltljeviad/8/TU3WkqlWfe0ZxDQjAa6ECU1QdtHOT6I4d/Djtvcm?=
 =?us-ascii?Q?KksBTEtJvENpqjr5hhPx/98MtBljj8doxk/OfO7DhmhcM6mTx9tU/O3OP6hP?=
 =?us-ascii?Q?mr3KIb2gl0bPHsHwuPi7PldhoK5rXVukb1iJiosEUxKsSqRzVje6Vk/7/1Zx?=
 =?us-ascii?Q?L38pdKHs4nNGz87ek2ApTiL4v3zWkfTNiTMqeNKEVJ5W9sdgzTBIvclA4w0z?=
 =?us-ascii?Q?k9syb2mDaoU2Oqg4ShcGgmV9Mnz663AG+aGqUz/hJwanFz6FAs11KJRPfVcT?=
 =?us-ascii?Q?482Hr2gx5GFR34j+AXH6OVBTisPF09a3QzRCnJ9WfDNKq0tSW0KNNK/rqvD3?=
 =?us-ascii?Q?l7kzbY7d19vmT+qQq/LF0BQqr2fPPrUAHZqYauydJq8vkqepzytg2WEt5Pyc?=
 =?us-ascii?Q?+LanhtBMwkrbhIF9IS+Y6sZ0BygUETF7SW5RnJKMQFyJbZMlXgrqKgmzW2ih?=
 =?us-ascii?Q?vjzF6mcNV7Qg39OxIsESY1SwTx+81dvU4GtWlpjaE/wLgxNAskF1rW7wJU6o?=
 =?us-ascii?Q?Yb5fSS7AVHYUKTTqpmSm6e6y6DNSVznzobRJTIVfm3CvgBKh7tsQnXTOQahb?=
 =?us-ascii?Q?zddswOoYOxvtMN9Y5diYOwCHIzNkPVWlPA4v/B0JcRD0lhaRHaM6urJuuvft?=
 =?us-ascii?Q?kUYIYr99CBqRQigA1dV9LNQ5D8xH/7dUh4zCETBPH2oSqm68BVySW/V94Pij?=
 =?us-ascii?Q?4PVg5ubbMJUOzjb/vRVwPA6ApcA3T1qAK6Ngc+51+/Yvagn37jtkprJ7tCdj?=
 =?us-ascii?Q?jc41h2BRJ3Z9jtHq46/Ij9XJS6Jq9voGRw277szMzCOoOzlBAZnuWaIZ3wfv?=
 =?us-ascii?Q?Edy3VESOpUFCD/AxfsmpmLE7g+F2Own/fBxSPjNulxxSZHJ9Q3n6gFle+f6J?=
 =?us-ascii?Q?QyKIqU4Glnlk+CH+RZXiNk8FypdY1PBO7ndvVzOo6tahWiJaa4/04Re0sU+0?=
 =?us-ascii?Q?iFqoeC9faF8L9LU18f+6bs4RzIunWWGybAw6I/PXqW/WWTKb5z1Lc31m7ByK?=
 =?us-ascii?Q?LKyOlGrSgRwoMMNT/s548uPACSNa4UKffSHXYzqcRuVKxTxDG9w7lkWzww59?=
 =?us-ascii?Q?tcrVt+fKn4Q/A973hLtIWpCcUgqKfQ7D9eIWGoAKaTr6QqWwO4a6G+7raOOf?=
 =?us-ascii?Q?J+W2xxX+tsJuvKOFXG92PbgjHhs4LL3789cLf4J8oThJSw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0444286a-185a-431c-c5b7-08d8fea40225
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 17:46:03.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0lZDvx48ffBmcaKCK3x90XoIhgmCm2MXFCwqHFgP0CJB5/s7Yn4ehMuFWwQgPMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2440
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: vINEpUHNEHzrzztkFMqPKQ3zCyu47CI1
X-Proofpoint-GUID: vINEpUHNEHzrzztkFMqPKQ3zCyu47CI1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_12:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:51:47PM +0800, Muchun Song wrote:
> The pages aren't accounted at the root level, so do not charge the page
> to the root memcg in page replacement. Although we do not display the
> value (mem_cgroup_usage) so there shouldn't be any actual problem, but
> there is a WARN_ON_ONCE in the page_counter_cancel(). Who knows if it
> will trigger? So it is better to fix it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
> ---
>  mm/memcontrol.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 64ada9e650a5..f229de925aa5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6806,9 +6806,11 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
>  	/* Force-charge the new page. The old one will be freed soon */
>  	nr_pages = thp_nr_pages(newpage);
>  
> -	page_counter_charge(&memcg->memory, nr_pages);
> -	if (do_memsw_account())
> -		page_counter_charge(&memcg->memsw, nr_pages);
> +	if (!mem_cgroup_is_root(memcg)) {
> +		page_counter_charge(&memcg->memory, nr_pages);
> +		if (do_memsw_account())
> +			page_counter_charge(&memcg->memsw, nr_pages);
> +	}
>  
>  	css_get(&memcg->css);
>  	commit_charge(newpage, memcg);
> -- 
> 2.11.0
> 
