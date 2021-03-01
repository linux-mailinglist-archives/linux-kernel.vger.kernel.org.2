Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560223275A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 01:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhCAAi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 19:38:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36858 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230214AbhCAAiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 19:38:52 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1210bx67007571;
        Sun, 28 Feb 2021 16:38:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KF8hsSuNPfqpiWvuTGO+UlYtE6qKYO7kA383Pn5eXFQ=;
 b=jnXpv5tLbaB+vMP2kE9hTbyUmEedv3b9X3PP7FVNTvj/1U2ttFS5ISBP4iodNJnQ2OzG
 toYXiTbIS0TdT+viCTTjcklB7/D05oO0uQyTKZVz3jwPmUuC3CdXuEOTCOg5UHhYLVHj
 QTZc8Sn8MeeEtIi5X8JUvf0k5cSLbzLWj+s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36ymsrd61j-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Feb 2021 16:38:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 28 Feb 2021 16:38:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xslgcx0wsZahGSRpqUSyGVTQMsT/2Ld1hWD3ekEohn5GXriWtrywMKRTgp3o0acFOGaoDSSutdQIcYem1jKNb8DvH8fq6BtUUASH4RfPcNaW3l2ZCKBe3BmBuELwJn+2ALl4dXmaijMJCIxPZcKsv9QhX0sCDgMYeCMitjJFenYiN90F35j80MkNKi5z/Y6AWXYXugpQ+7dq5m7Wq3XtZSu978qlIO97sLuAMn4iF6yS4ssr4W2/3WNveVdstmKXp5QMmdeS8J+fI5hdKSiALsyL4riL4uKMQshxZTe9fTbDVA1AdXGwbH4AyadrOAnKQDRF5xSqp7dyfC+NBLPoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF8hsSuNPfqpiWvuTGO+UlYtE6qKYO7kA383Pn5eXFQ=;
 b=M9OqdG5kW4KCkBEvCKx5h9ziA62dQd50j7l7BUlwkaAUwyI4HVkVrcBozLA5+plaIWrDei+/cKxLanf8e8pNyRQAce0OeF8slE5/PZUv9+sjjGFU12b5udb9x6xoU71PWAR8mKqcmKUlOXdJlOyIsvlV1c28sNgnHaAqSinsWb2yf3f2Wl0Old3yOZlxF0pjWW/BDjuY9Ord2vuS6EvyYSB86obvyyxlMAiG75QZlfcMix8yINZlVkpZ7ApPQVVV1rnKmtTE1c43nUXiTHJbvaYOA45/JRNCoVJl+7Y1rqVm1dQKELNERGpplIGchbxT4ebfta9GVU/Epnw9gIpkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3556.namprd15.prod.outlook.com (2603:10b6:a03:1ff::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.22; Mon, 1 Mar
 2021 00:38:00 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 00:38:00 +0000
Date:   Sun, 28 Feb 2021 16:37:53 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] mm: restore node stat checking in
 /proc/sys/vm/stat_refresh
Message-ID: <YDw3YYHHXaB8uSk3@carbon.dhcp.thefacebook.com>
References: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
X-Originating-IP: [2620:10d:c090:400::5:8cde]
X-ClientProxiedBy: MWHPR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:300:16::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8cde) by MWHPR13CA0021.namprd13.prod.outlook.com (2603:10b6:300:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Mon, 1 Mar 2021 00:37:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9deabcc9-013c-4b79-de81-08d8dc4a43e3
X-MS-TrafficTypeDiagnostic: BY5PR15MB3556:
X-Microsoft-Antispam-PRVS: <BY5PR15MB35562CA70922FCB1CD716137BE9A9@BY5PR15MB3556.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U95z99ryvkprqj0YU0LnKSwg4s5R/NUrQUd7zCVJVDlEqVn+0Hqdgszn52BzDYiGJqQ9kyF+oBr18NrsPur7W3yOUTJPTLh++q5q3bq0fN+zFXDbecsE40IHjQk45SXyocQDRSLza54eomrsh/6OrFL0+EiWMgNRQXg4mZ4KIrAfHN2vjeUUjXkdUlU/qS3hd7Hgm77KAg+lRORERue5JGRlCy2mT6UeMGfzktVCV9V/gpWuJGCsGN/ySgTJ7dy5Bwtg0UkusWazhT06L75BDgAFNhjxrCy3ntUnl41ArLa97u5JRyeFa7HZWwpaR+fOZoq4RaCdkNUvahyDyphpLrKIkRhoO7yzO7eTkaZC7LHjneI9MUz0w2KnxArkfyZooRWP9xl65v1b00aDpysmkPlocIE4Daz3/CzHL6I3ILcHA5xODA1dpJ82psMQXk28YdXrn77FgrGs/KAlIQPFThtQ3yZnyoEuAanrraeVxSUbYW03Lo6FcWTbFApL6Z7mepegaq1i/8ikikxcdbs96g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(396003)(346002)(376002)(55016002)(9686003)(54906003)(6666004)(478600001)(8936002)(86362001)(16526019)(83380400001)(8676002)(2906002)(6916009)(186003)(316002)(5660300002)(4326008)(6506007)(66946007)(66556008)(52116002)(7696005)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Y0/JE5T+wOtjkG+oDnmdu3Vwifw+YOx2vePylYeNDSaYXfQyLRq1uf1UPHqb?=
 =?us-ascii?Q?cZ8cuVT/WCl3/WoyuQ3bupoOb6GHICTAebCXpDBDHl30dsN3sx3Jpba+URHy?=
 =?us-ascii?Q?ghYhCG0OguwpspSOW+1fduFgKfUm5Ozf27OOVI68d3oqLme/RxW0O+iv2QoQ?=
 =?us-ascii?Q?CE38drOnw5xRaiDKcCDiC8n7gos84Pav4JtAQiqhcOwvUph7a0MSSehcHb3g?=
 =?us-ascii?Q?yHvIXiAFE3CLOWWbjuRcNaw2FLliglK04vDD/v9itoNqMBgNlqXqrhdfZepD?=
 =?us-ascii?Q?Y9+oagh6K9kZwwTYqxvQuhrk+SODa/VJPsPrvM5NqTY1pQUU2eTNCssRJiyi?=
 =?us-ascii?Q?b30SsyJyNCdcQrFQskWj1hDxeE50NnWXpQYnNKqyb/0IPutFt0Ow5qmHXqnt?=
 =?us-ascii?Q?DT9SDe+YrQLa3KbRDW4A14XRL7/v+9GqARtj/ojVvdeftQWkXxp5AB9bW+iu?=
 =?us-ascii?Q?qmoYddJj+M/yA8oeaaFfiSRhokaJEh9e9kdSZQHd0ycv5G8hLHMRHZJIaCjb?=
 =?us-ascii?Q?sUq43Yimjj3/75IPfxEwQHXot96gn1/cGyrM1J0+E/wEaolF5J/n5WfeM4j8?=
 =?us-ascii?Q?9wUaoTwSy9CNhF7d0rDLh04IK3KfYyzq3HsjFYKFirtVxO1A1DtBNjmiFmv1?=
 =?us-ascii?Q?sWxEMjLldp5XBPKxPfpfKeAUHSGBuUGXFzSVzeXeUtDBhTWV0IP2S5ZE+Q6d?=
 =?us-ascii?Q?z6/FJXeXHRyqL+ir8Jd+ksxcApInjOUjb61mqk6jf73Q+q2758zYkLJQL9tQ?=
 =?us-ascii?Q?90ItFqbJUkYxgf/lL6UCE0poa9OcMPX2XySugXCmdLrmLzjr247Hc/jpwG48?=
 =?us-ascii?Q?bcqGychcd4I2SDpAnZ0vk608Xk1hsM4m/k+gXGqLZqYle6fxJ0LPPKVpEKIK?=
 =?us-ascii?Q?GdYpq9cGE4RhLymEZicQq/Y45dGRdXEW+xP0+xUFybiISwybTK+KozInbaQ3?=
 =?us-ascii?Q?qHfCgMPu6rVlKq5n+FAinAr0+iX+ZElX2F1RKuMm9J8Mx6nmnXZHiglDV9Va?=
 =?us-ascii?Q?LoZuNznpyYvOZ4HQM9YjfLwGbda1P5FUf6yAe5MeEcmMCY+TAvuD9+7J3fh9?=
 =?us-ascii?Q?y0qMLrWdP4C25aEiiBb+ILL01GrPstHXqSs55lYd3melr9ae72WfO7EpggdN?=
 =?us-ascii?Q?aRDefcyIFTLViQl9N+VDIF/m4F9ydPo7XPN8K5IbKkIb//hRH6nzHLtmmFnk?=
 =?us-ascii?Q?/M7q8nl+lw5YOg7q+bVYllCxtXr2bgXtdUcNlxO/AHAcwfXts9mBu4DwiRim?=
 =?us-ascii?Q?ufhLxjZMIMRVh7i+YAOQJ1JOR9Cfr9bYj+CkUCWbrN+q1KlYTE8xug8YzcfQ?=
 =?us-ascii?Q?5E+xsZjV+Hatq2grZ03lZ5u8LZgFnh8DQOzLuHL2jrgHfQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9deabcc9-013c-4b79-de81-08d8dc4a43e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 00:38:00.0371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLQMWOxCvE+g4rOFUl/3WdrTZRnOZeNadfX8NBRXkodyrRCJdzA+bSNwQrWA7PhB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3556
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-28_12:2021-02-26,2021-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 03:10:09PM -0800, Hugh Dickins wrote:
> v4.7 52b6f46bc163 ("mm: /proc/sys/vm/stat_refresh to force vmstat update")
> introduced vmstat_refresh(), with its vmstat underflow checking; then
> v4.8 75ef71840539 ("mm, vmstat: add infrastructure for per-node vmstats")
> split NR_VM_NODE_STAT_ITEMS out of NR_VM_ZONE_STAT_ITEMS without updating
> vmstat_refresh(): so it has been missing out much of the vmstat underflow
> checking ever since. Reinstate it. Thanks to Roman Gushchin <guro@fb.com>
> for tangentially pointing this out.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
> 
>  mm/vmstat.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- 5.12-rc/mm/vmstat.c	2021-02-24 12:03:55.000000000 -0800
> +++ vmstat1/mm/vmstat.c	2021-02-25 11:50:36.000000000 -0800
> @@ -1857,6 +1857,14 @@ int vmstat_refresh(struct ctl_table *tab
>  		}
>  	}
>  #endif
> +	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> +		val = atomic_long_read(&vm_node_stat[i]);
> +		if (val < 0) {
> +			pr_warn("%s: %s %ld\n",
> +				__func__, node_stat_name(i), val);
> +			err = -EINVAL;
> +		}
> +	}
>  	if (err)
>  		return err;
>  	if (write)
