Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1053D997D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhG1XdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:33:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27168 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232116AbhG1XdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:33:19 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16SNPO1A029163;
        Wed, 28 Jul 2021 16:32:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=a+tuKt3jjyGCR+NqekncyPbiqtC3/hLgvnZfHB0Jgmk=;
 b=lgJtaL7QhUtAwJArvHLtLZiIOJYn1AwMFmkKN5t3yIDJ4RbUHwTJZo1b2Ixy1u9pdpSt
 xJj/uNGy6k789Ln2hxdSMp3DJb+Ao5e7l4MbvXEefhYhWUsPNmNNrLGphXN8IQH+g5Ai
 wEYqgz4kXeQI+IcvVzJNKIzc0+YTBI/dGrk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3a37bf3tex-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 16:32:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:32:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb5IG8ptTnt/h9h6wvzFhpHdAx/9Z7EFetxN4HMlS8N8yfe0w9k59psviHPe9tcpUdwUi8ai2qT+KXZdjHBBCXUQWoGiZV5zALXHobchmNS4uSeYY8iTv+d/hlJl5XUWlnSOXQVNsImLPD5Vay/3Bk96Hx47OUSwSshJYFHOrd+U8rz/9q0qGc96Ka4noTdvRWcacjVfWoZEWumWQhbXnqv9d4tP83W/dMIlR627UOjn36Z1XOOFBxOnCuSRe/fA5b5hIEWHyhwgDPZbweRfgG7HgI9iN7tJyGZ6gowDZUzO5ykBJr1s/6o1DWamkhcIGOWqMsZusbeao74EQ0VMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+tuKt3jjyGCR+NqekncyPbiqtC3/hLgvnZfHB0Jgmk=;
 b=IaC4h/wu97kas9lWQh3lLNk2PiOcDkcYNTg52Ju2JSQm1gOe39s9Cyd9H3IjNd35D3pxa3H0nnLXbgjfDAk6hZ2cKN5v02YFGKELUygzRsNcWMP260E8ksFhvEO0A8bzzelrjcIAk/AxwYKLNtENWlOt3dipTNC6KtcsgB8x2XfXNNqTx4Uvfy+SzgpLvtQlD4wNejhoNXlAXv1bKQj1owHm6CQwZDObo9rcsYDGOotMzdrGUDQZQgYwQLNf7WSvY+9jEMyWuEJBXVtceBUQx86PJag81OFAPltgJTxL8mrAdCrhWS2S+KqUE3jL/KRD9wnWthE3P8eDvtqvq3mLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4598.namprd15.prod.outlook.com (2603:10b6:a03:37b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Wed, 28 Jul
 2021 23:32:43 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 23:32:43 +0000
Date:   Wed, 28 Jul 2021 16:32:41 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Wang Hai <wanghai38@huawei.com>, <cl@linux.com>,
        <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>, <hannes@cmpxchg.org>, <shakeelb@google.com>,
        <ast@kernel.org>, <wangkefeng.wang@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/memcg: fix NULL pointer dereference in
 memcg_slab_free_hook()
Message-ID: <YQHpGYW6s/YKx/0b@carbon.lan>
References: <20210728145655.274476-1-wanghai38@huawei.com>
 <YQGJUz9kKfYR37ce@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YQGJUz9kKfYR37ce@dhcp22.suse.cz>
X-ClientProxiedBy: SJ0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:d9b0) by SJ0PR03CA0204.namprd03.prod.outlook.com (2603:10b6:a03:2ef::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 23:32:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3e16a84-34bb-47d9-066f-08d9521fff8e
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4598:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB45982E1156BFF7409BCC392FBEEA9@SJ0PR15MB4598.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b61kR9EIPbn0QeLYNKLTbabHDlpqr2OFZhKrVebTIBuLtTR9Ga7YWNDyMoyqIJN9Q2jU/t41MAVfodXybl6cUjs796Q4uAjiuxej5vxMUJ5gZMQlWGUqVgk7NioLPbVUsXiCHUCUOlM3caD0qLa+OE1G07CZASszM8N2bc3ni0qC9QaOCzu7cSnw8IqsZsVvQLNcxSyDjeNJx5G7+Djp3qcF1Bnriej8c06DNhSDkMkGJLRmYKktu7EwFnTlcd2D1cc2pei6wGibbbCFm8v3zl4vsughMMBolP3ou5Qsm10t82qB38+f4yJOxYHjCmexTSg5TPN9QKWyH0pkr3OYQ306mS3cRNq7FQneIAFOf7pMDeVVnHpMWZZeUkKm+2+GMMQrhCGMmLug1S0F5QMi4Sx87NgKbJFMg3P6j0c86/ebwE9iYpBUBQtml3zflJD4Q/2PfJwZ2jDkjbFMrGZYh70d8vem6Ievqgu9ocKVMJMvFCCL36pbYMYFjy+URU2KbMppyGrSbGpwoTIo5N+koZ5wsdtHL9JwU/P+pqeElqK8X2t2//CUWFIezBGqC0HWcH4e+RP48bcOYpGC7ZngHqJaQ8b/Z2dP8w1/4cfFojhS8JW9R3PW57x3q/M2DMNelI5WK0Ro+MEtBBhiTDN0+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(52116002)(7696005)(66556008)(66476007)(7416002)(508600001)(38100700002)(8886007)(6506007)(36756003)(4326008)(83380400001)(2906002)(8936002)(86362001)(5660300002)(316002)(6916009)(55016002)(8676002)(9686003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5mEkxSoMIL6RqUrbCs3rHoIe6RXBxD8yDU0eL0DzqIJdtg/9a5L5D/FGPMRK?=
 =?us-ascii?Q?62x/YvTnC4Bm+ojhqClp16QtUX4YYNfcMjbFpJFcIaSNQZug/Ng9kavo0C/p?=
 =?us-ascii?Q?Go3QKehxclxpasG819NfjbhZTrLIe8QufYl6fj6I7GN+SGW1rYdsZLE5q/TC?=
 =?us-ascii?Q?9AyKvf0Noqw/hudWJN5nARK3muKhxk7TuSHobFJWXsceJJ8dcI4rgJfj+2RY?=
 =?us-ascii?Q?Y7bLKvl7piIWIi3ti81cyEPQ7TQ4sEZWrtAmfX7xWIm1Jow97doiPbn3sSKY?=
 =?us-ascii?Q?osaJFa80v0zJYIExcyhGyv4WvIgVVpiW+pU5GIoFMr+CC/taJ5BbSAXYGipG?=
 =?us-ascii?Q?A4/2YfmhPptmm2rhSWr3+GSxEYiwf13RY8dSIrewADAzPKSR3CHQo43fe6mb?=
 =?us-ascii?Q?MrA3ikDOVozKHioviIq6XMawxq3YJs8h48xFKL4v4c4SrpRBp0lcKdSXgzLW?=
 =?us-ascii?Q?f6jJ0v9C4gLX8jLLLfLSUfZZO1CAR/Ols48Qup87Zf2vEUaDob/FRAeSGXmp?=
 =?us-ascii?Q?cFXSXsxxZeJfhoI3R4mqo+laxNW3fu9Xpto2Aq6p6yypcQXb7bHrkFu8LxmL?=
 =?us-ascii?Q?sj+fdY13NaHzb7v+8LdisHY6+KfgTa/rtgJ40MTNCRtesL5mpDK12wPEsuhG?=
 =?us-ascii?Q?NFRN4sdLkpbh2dpk5wi42moyyZGXYTKlN00W/GdjPlCCCtpOC68NB/tUnvgo?=
 =?us-ascii?Q?Uy8KghQsVFA2QjwDlZKuwmvaNjtte13Cgx8dCNHQuvz2VJNjXO40uM+/K/J4?=
 =?us-ascii?Q?h7yLQiVe5msy96FTTDG349PUmyKtRRg2gMvdtLXD1FgmBGWQJTw0NmOtmhBd?=
 =?us-ascii?Q?k+/5mToRBZzWQhtRjD8HnQ6PHz2d0RbeVdzSlHJujEoeP2kZufv6/hW/qnSU?=
 =?us-ascii?Q?YkQ+5wE030LUQhktX3c5i78glSckXbubFnRJqyaQstRvRgDZHU3zfyoUBBrI?=
 =?us-ascii?Q?rpVK/glb14mY9XvSXExDt1Yf+jcx/eHE6AtARa9SwS7eOODZbH7WjeMhKqB4?=
 =?us-ascii?Q?gvHihic4FifwMxXKTcj2IJgTi37pdMHP2bktKSRpxxC+UMNGbHyQUF9ieIe4?=
 =?us-ascii?Q?uLNWUFn9U+0cQIQpAodujdjD9SDSEHn2UZ1DOIIdoNss4KJTPxwJk3uzJ30L?=
 =?us-ascii?Q?mQap9/t8xyKKqueh7sooG3PtuwQ3vLw8mURYpnmzgDeO3fDNqfgtlC7712Y+?=
 =?us-ascii?Q?rBQ/h+DSVmS7kSYJ0dDYINA8hRd7EbkO/U4woSgkugVqPEd8c7ZEaR3TZZk8?=
 =?us-ascii?Q?iCUSbrBH//xN6WtDSSl+o8IPgyDRsPzFawuhIPWxGyZjb8QiNfbbVqO+hKep?=
 =?us-ascii?Q?ixewl2HtNnIz9SJ385kNsyUCuUgjvpSYzlVldlON7H+INw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e16a84-34bb-47d9-066f-08d9521fff8e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 23:32:43.7475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phbVWlTu4nXoxCbdig/H+aqhUQWVMvADy2oGLXUUhYjWuzxok6Z4Py7q8HEP1Dec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4598
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: E9v7Z-Xlzw5gtCnrxhOGToTStm3jfEcc
X-Proofpoint-GUID: E9v7Z-Xlzw5gtCnrxhOGToTStm3jfEcc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_12:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=881 phishscore=0
 clxscore=1011 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 06:44:03PM +0200, Michal Hocko wrote:
> On Wed 28-07-21 22:56:55, Wang Hai wrote:
> > When I use kfree_rcu() to free a large memory allocated by
> > kmalloc_node(), the following dump occurs.
> > 
> > BUG: kernel NULL pointer dereference, address: 0000000000000020
> > [...]
> > Oops: 0000 [#1] SMP
> > [...]
> > Workqueue: events kfree_rcu_work
> > RIP: 0010:__obj_to_index include/linux/slub_def.h:182 [inline]
> > RIP: 0010:obj_to_index include/linux/slub_def.h:191 [inline]
> > RIP: 0010:memcg_slab_free_hook+0x120/0x260 mm/slab.h:363
> > [...]
> > Call Trace:
> >  kmem_cache_free_bulk+0x58/0x630 mm/slub.c:3293
> >  kfree_bulk include/linux/slab.h:413 [inline]
> >  kfree_rcu_work+0x1ab/0x200 kernel/rcu/tree.c:3300
> >  process_one_work+0x207/0x530 kernel/workqueue.c:2276
> >  worker_thread+0x320/0x610 kernel/workqueue.c:2422
> >  kthread+0x13d/0x160 kernel/kthread.c:313
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> > 
> > When kmalloc_node() a large memory, page is allocated, not slab,
> > so when freeing memory via kfree_rcu(), this large memory should not
> > be used by memcg_slab_free_hook(), because memcg_slab_free_hook() is
> > is used for slab.
> > 
> > Using page_objcgs_check() instead of page_objcgs() in
> > memcg_slab_free_hook() to fix this bug.
> > 
> > Fixes: 270c6a71460e ("mm: memcontrol/slab: Use helpers to access slab page's memcg_data")
> > Signed-off-by: Wang Hai <wanghai38@huawei.com>
> 
> This looks like a much better fix. Thanks!

+1

Acked-by: Roman Gushchin <guro@fb.com>

Thank you, Wang!
