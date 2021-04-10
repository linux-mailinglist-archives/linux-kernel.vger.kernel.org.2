Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2335A9B3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 02:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhDJAtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 20:49:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33232 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235215AbhDJAtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 20:49:49 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13A0hmGD018909;
        Fri, 9 Apr 2021 17:49:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=X4u90LDkiWdYNSLuOEPN06B36rNJJLn/4RRrCmtdtcQ=;
 b=qJB6ZPmg8LoBa6MG6FnUkv9j83FHQjh2AYSYXinikAolciQo6kU+RnbDZgXOqswBOv2K
 A3RMS4F51LH4qHRCay1rtwWWWnofLLnbFdhpaer7cZtA8K9HV5MNQTCBQzr3Z7xLAerM
 H5Q/q2mXE0S/uTGkQrMP3UaLH28FJrNZLjQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37tv4g9qc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 09 Apr 2021 17:49:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 17:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfFbm464VZNE4wTJNJEX0fukxzjHqDnvvBlds5cA3glBv3iFCESdgC+/uClVj3DEKPtRrbwyw2N7oMLQEVGUeBrX3agSUpldhbYiFOczJ6GQmTB1ZWU6OOjD6vQIhFQqBa2JPMcy7mP8rOEJVH/nZpRTonekrXqIJYpeZd2rEIzIF4kf1JVDkmLDq+84NWohr5SzhSd2JglMY/NexooEmsu890gTvrpu0piA3zWFFgW4JRdvs9MgbS0S3JEuqWXzaqF5EjnzW5qRhB9UIM/1LYeCFDogBZI077Hppi2Jj3RBhgTWqmuZvInFxexZGv8DI+HGG6AyJw2bHcdBJRs3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4u90LDkiWdYNSLuOEPN06B36rNJJLn/4RRrCmtdtcQ=;
 b=CAKOlnPS8e8i7tcfuwmtXxTOGexWBThz8djWC/t+EHujjKot03Y6UWBsTzB/AH6jOje+4nviuG2Di58N4FJ4zLgr4fmh+wDdQtIa1tW2OZnugnNUTrL65aXvDpkO04XCgubHdoeu+jn0P8DOD/kCeaWyX7RVjW0Pn21Au0bT83ybtnrjngtK++khJQdotoynaOB198afP391Py4Q6hTiB3eXibEeDeqdZF5zBSYP8dzC/FBTr710JDEEPRI5jW1cpt5GZfih9mvlwk18CursuWmx4gqCqUtWSstOsNGBT3vlQ2jBW5BqhVxeJBifcs5G1bBXIVIGXHj8yPhY9raEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2520.namprd15.prod.outlook.com (2603:10b6:a03:14c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Sat, 10 Apr
 2021 00:49:22 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.021; Sat, 10 Apr 2021
 00:49:22 +0000
Date:   Fri, 9 Apr 2021 17:49:16 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>, <bsingharora@gmail.com>,
        <shy828301@gmail.com>, <alex.shi@linux.alibaba.com>
Subject: Re: [RFC PATCH v2 09/18] mm: vmscan: remove noinline_for_stack
Message-ID: <YHD2DDzSsS6PVzaY@carbon.dhcp.thefacebook.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
 <20210409122959.82264-10-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210409122959.82264-10-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:c3af]
X-ClientProxiedBy: MWHPR21CA0032.namprd21.prod.outlook.com
 (2603:10b6:300:129::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c3af) by MWHPR21CA0032.namprd21.prod.outlook.com (2603:10b6:300:129::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.1 via Frontend Transport; Sat, 10 Apr 2021 00:49:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7636373c-3be5-4c54-d96e-08d8fbba7b1e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2520:
X-Microsoft-Antispam-PRVS: <BYAPR15MB252031A63749312BD4E946EEBE729@BYAPR15MB2520.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppzpjC/0OApeEEHpEpmILrhpvearN08HFI2GzzdulMAW4jmw4pt6791udC8bKv9Cd5bansznbnDRFmYE5YdFAP1uxiY9cBtmgLcflt8/Pd192xi2+hD07hnzDad8L4bXISMZuWh2TlRXOBmj6oUddl3PSccCOShZPQl1Ehb5CsG12vozH1tw5A+DWT8yF1xqP8F00XDHSHAuukBQJonRz3kMNzjCMex68Rl5AUngHZ9mhumOPt6eIy8caD+R9Ccebx7Vhzkvldqxuww8Rrg7UgBqPF94TaG/DKYe7M3LXCULoeiRzCCzDvwu8oSvs5NImcqAS/k//t3bZbOCue1/jrZl4ib1wQ8B9o4YpdhnSzs8rFtUT27s0A125WEmIRqdLf0PRagmk8SOLT0mM1eiZ6aeSHI63/KldslAF9ZaUMToy1Y8dbspsNPHWuThPLbo5I7r11GGZlRx6GE1mG6uAG28VeE0/Xq+W5RNcqw0fYLxMk0iQoUSDmMPzXx9at1KRy4P03P8ZIWwdTn/lIsad7BpvYR42IzMpMp1PUIpDoINbN4IQqqNF3BzKQgXuIcVL7gURJzjYa3Fo1I86GBr2flqlVExIxynAvWU28B/pkt5400/Z8Qf32wqlRFxVBM5A/78DXM0spWsuXX86joITA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(396003)(366004)(376002)(9686003)(16526019)(316002)(186003)(55016002)(6916009)(86362001)(7416002)(7696005)(4326008)(83380400001)(2906002)(6506007)(6666004)(52116002)(8936002)(66946007)(8676002)(66476007)(66556008)(478600001)(5660300002)(38100700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?e7mEIPDV4J6dQUGZD4AV0Wc4sK0HMOBW3djPeR9TA3od4EpBD+ZQTme3WefJ?=
 =?us-ascii?Q?B3ZQEWZt9NGa6dLRLP4zRJE2lotr66CzE0qcNcURUURRN04apZhWstmqvHv0?=
 =?us-ascii?Q?gc7V6v3HVGUKDEN9DFuSy8iXvEmNnwaQcIv+wniU+ylZ4InzhF9BXRwPCW4q?=
 =?us-ascii?Q?IBsDlhI4dohUVFohYkMLYsdCKZdT9QCqNwcwrmtpb8WgcJM7kXZhtq9+2H39?=
 =?us-ascii?Q?SIKKj79bOPs9ZrN8UkVess6ygRqd93eZD3Fd1zv2/6eEqLvwsfzXm6FCsa0k?=
 =?us-ascii?Q?bQ0ZenZtP8CkKufQS4BkhLrJ69x/wA86NQE6zpv7MckXQQ41Zc4FRA7BKscI?=
 =?us-ascii?Q?rIEmgrvLbV3CUqK1oUGIcXWcmjrX4ltYc9w/8m4P/a4YD/x9cfDeirGlJblt?=
 =?us-ascii?Q?/pjSGLdiV8DXo9m4tT6dk5Ta88yd6KB8OzxctmCXruaP/deNG2pfxmVxRLCL?=
 =?us-ascii?Q?MUfnHbf/111CF1Na0fVQ+yOWAr69Az5NriczbB9fQsD4gOSaN2mu2kdm+RpF?=
 =?us-ascii?Q?6cLSNVSshft7W/5GX8cXS619tiQySfuF+sji5mcKd3LgfkyZiidIaFMY5iju?=
 =?us-ascii?Q?JxzhW1ufrxKN2bFuiolyA8zxZT3YGQ9zr5jjBUoeGdmdN2gQm6gB11Lpxnez?=
 =?us-ascii?Q?0AHInKN5ZzX+pNbnFf8FHTuxYAXlUKqBjjxzbX64rs75fQYpPbCeDvkc58Ei?=
 =?us-ascii?Q?aZp/VPtXKWfs1OfUfp30F022hu71vMlZ7eOS/RGmujojpBbYOxAh5ge4Uq2v?=
 =?us-ascii?Q?4ebIvESoRoMkdQzT16vDQuq9w5CSr/88BVnE4YNP7CIv9YX3qi6jy/OsuS1a?=
 =?us-ascii?Q?729DpLv6zlFyq2VjD9behLm5CCM3S9/sQbVJQVX5Q7V//BKJsZODS35h0SWj?=
 =?us-ascii?Q?qk7iBM1PyZQZs2LufKP7mMpvVOQPanLuY1uCVWxncXKrui+UOO+TnnpXvgwp?=
 =?us-ascii?Q?5+1ugWxyPWsL7AQXszQljHWFtqa+WSPBVTms8/rPdjKs9u9kwk/n11EJ37GZ?=
 =?us-ascii?Q?gFBCl5vgKNjvlzkTCCjiJISLxn4iYtYFvto+k3lWbAadVIsi4nFaAoAGFhxD?=
 =?us-ascii?Q?uCklYlBzRRFlmMXKpUU+p8FDFXGjRb14+ai9+1ihbt36ZC4vA9qROlunBnL2?=
 =?us-ascii?Q?74XSYrZRlq1u0TBKGFGLcmnftwX3/LbMVZu4zYA2ntxVjMd7DK96kjXtidI9?=
 =?us-ascii?Q?69GypvgeG6+foWACnbKHlOkP48sIi2qVd1sy8g4q1zurhr86OikV3h1Vwt9S?=
 =?us-ascii?Q?h8fKZSKeM30fpRCY8cv967RTUOXTQsLBu/y1qKCN9H/AeQMQ/i71cOKShKh0?=
 =?us-ascii?Q?6FuzvFi1eHJfda1PypsiZE79f3k1mfSbRap3oXXdmSsl3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7636373c-3be5-4c54-d96e-08d8fbba7b1e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 00:49:22.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhkyBIh9mVKEksmcgPX5NbYel/eL93vsDVL79QPKHFjJLRuSPSBwZ5yIeep0nPwr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2520
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: o-H70JavwFhNIeq_r1pfpMk_UuodmTTM
X-Proofpoint-ORIG-GUID: o-H70JavwFhNIeq_r1pfpMk_UuodmTTM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_08:2021-04-09,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104100001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 08:29:50PM +0800, Muchun Song wrote:
> The noinline_for_stack is introduced by commit 666356297ec4 ("vmscan:
> set up pagevec as late as possible in shrink_inactive_list()"), its
> purpose is to delay the allocation of pagevec as late as possible to
> save stack memory. But the commit 2bcf88796381 ("mm: take pagevecs off
> reclaim stack") replace pagevecs by lists of pages_to_free. So we do
> not need noinline_for_stack, just remove it (let the compiler decide
> whether to inline).
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  mm/vmscan.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 64bf07cc20f2..e40b21298d77 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2015,8 +2015,8 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
>   *
>   * Returns the number of pages moved to the given lruvec.
>   */
> -static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> -						     struct list_head *list)
> +static unsigned int move_pages_to_lru(struct lruvec *lruvec,
> +				      struct list_head *list)
>  {
>  	int nr_pages, nr_moved = 0;
>  	LIST_HEAD(pages_to_free);
> @@ -2096,7 +2096,7 @@ static int current_may_throttle(void)
>   * shrink_inactive_list() is a helper for shrink_node().  It returns the number
>   * of reclaimed pages
>   */
> -static noinline_for_stack unsigned long
> +static unsigned long
>  shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  		     struct scan_control *sc, enum lru_list lru)
>  {
> -- 
> 2.11.0
> 
