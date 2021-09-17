Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F1B40EEB9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 03:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242231AbhIQBa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 21:30:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19796 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232222AbhIQBa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 21:30:28 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18H0wSgd018859;
        Thu, 16 Sep 2021 18:28:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=srFs+3sVxeF10p2HpqJ0kddcmduUTQmZfBMOA1jnndk=;
 b=OjriTdZLWh3e/uwKvLyjJY5Jf6BSKQseWgasGHN6SKCr28H7dioPhsNAwNL5lpeFYluX
 bhXD80nKWJ/z3kMdP8Mn7+KBdVX7YAPcHZsI7LzvNFNAb/KdWpC4X0GsIUfPBxG+bnHA
 2zVGEEn/qdA3cLF/N2oXUXQlaWNIVxp10ng= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3b4gxhr41r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Sep 2021 18:28:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 18:28:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0ovZHVkYN074KzsEi7cQdZuNh5trn68aU4+S7u9Id1gr4VqE8EsxQGib+JOy1NX+iL9EgO37xvbcPhdN4tZvEW/L67jk1Mz2dGfFYLUKBphCou0TwQpN307E/jlfQsE3yhg1pxbViK+zYci2aWexN2fr/J9kw8Zm52GXfjRIwZPJTQDZwiyp4nrEMwVl2aVYZYsmibcxMZPv8I6uUZKmmKV/CZFK2vcnOF0INrDgL/a8EkY6Ts5wNKTPylC0DcPctV80UJd+TnhZmO25CRhVgkdUktZ0LKed2zX5blqDgKBgWIYSvkun83pTUzwenU0oxN3DLPIFcRdsDPbQpjGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=srFs+3sVxeF10p2HpqJ0kddcmduUTQmZfBMOA1jnndk=;
 b=E0HBbcc9IVtp9MYbt3YeUSba2uq7rmJNoup7VHBlcNZB4b+G5prEHK2J5yaqac34FQtOhvCMCs09p9octnkvH6VNblL1IfGHgPR+7R6Z+RREYLOb2MzDaVD/lpyftHGGjRogYDZjk2VriMpelTiQHhmVuMlxNtjKPjZAaxtyEHOoOBKm33sFIOdPvIIwym16rhOdSR/g9a8ZF/x2DBt11HCRzg6YR1ogZICM8PMsPP9YdlKr3kUiBQAkESJTABFPsGiNdO09RjM5HsyKmPDo0gKQt4og1di7aQJCAgu1M+b+T4t/N22w323RkYD39+J39RBEhFkPcV890FdHP4uVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3349.namprd15.prod.outlook.com (2603:10b6:a03:110::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 01:28:56 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4500.019; Fri, 17 Sep 2021
 01:28:56 +0000
Date:   Thu, 16 Sep 2021 18:28:53 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>, <bsingharora@gmail.com>,
        <shy828301@gmail.com>, <alexs@kernel.org>, <smuchun@gmail.com>,
        <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/13] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YUPvVYFyBR/qwy2X@carbon.DHCP.thefacebook.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210916134748.67712-1-songmuchun@bytedance.com>
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:e8bb) by SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.7 via Frontend Transport; Fri, 17 Sep 2021 01:28:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccafbf99-9c73-4e01-2052-08d9797a841d
X-MS-TrafficTypeDiagnostic: BYAPR15MB3349:
X-Microsoft-Antispam-PRVS: <BYAPR15MB334944093F73D82DDE49B961BEDD9@BYAPR15MB3349.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSUBbbQJrfBTCskyUG3uVcG7oTZjgamMmNRKzOyA1NXyDi8KDdp0RSgAnuc4jTnicGcZJ3Nw9y60Kbn5d4RiEY+M8ftdfy/Kp0VgBcwCJkL1q1SZjlQqpFEM1CmXYmg16C3lO42A1/UsLOANjUYKeL3J68aYbDlud/qZyyOyWVos1nSuWb/2c/aNNCp+wPnbdmx5GwDVT4f9FFviB8How5rH47VDZy+yFGF0yil3fZcVJV5ZR5Bh4C9H8puraSHdTVuNDWeWkH5tSMLOz/O+gLewr7EUoRXzqiNuKjfNhtjXT4Ae5aSdr3JRhTEhCRW6/vb2tKlNeWJv8edwhh3iFwZunp6cKn3vZSlbklJoh7JxuYgWrFCj+y+w3MuCQCFgipAYi6GB6+Gy4PNtAoGJGBDUOUQNdwkwIh75/Xsk9/fNxrUn9WBzO9dxFeue8NJLck0zS9Bp8JWqAv/BaS822YdBTNoPXCL6lqBlNPscQaVLpgO6kBoh6CFcwgzQPDtq5LRjGhy+GfbtdlJIOjzg+EqiAui2zMbiJXkZZMZsv/QGtW1tgBQF+ECUFUj7rz6vroUklf9Gm0HWwMm1xl9wo3elKLlyPnDhYyi5TAtZg8leuFYBvoGOoL8BGHy89IRtY+AyF+TXkR7KjTNY22+lmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(8676002)(66556008)(478600001)(8936002)(5660300002)(4326008)(9686003)(38100700002)(6916009)(55016002)(66946007)(86362001)(66476007)(316002)(52116002)(6506007)(7696005)(83380400001)(186003)(2906002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u5H9oOF5H/xudC7DExZfyQp0B7QL1tftk7Gtc0SMSIYd+5tfPDcufSCk/hQW?=
 =?us-ascii?Q?rhuXVi7PwmZYMYjO5/7jkFr4rDxaL15CuzzaN+IUPp4opyv3i+Iyqc4TL7E0?=
 =?us-ascii?Q?gmpN8kIsIeA7II/hk6O7bl+JdSetCkt4Cm65Vd4OiBgSTyPvcfgDM1oU7U9R?=
 =?us-ascii?Q?APQsG1huRofYrDaZAXiU5Ve4gcVyPqSphpF/JXIn5X8T2KJ29q2gCAZJfdRZ?=
 =?us-ascii?Q?YHT+8n+1dXFuN99lgHCtY3ccu3magVERjDQI/bTNRvMiC1grF4wTYOXEBS+I?=
 =?us-ascii?Q?RcM8U6deCHk+e52xb43UK6y8+6OX7qIq2+ZJBFrzUnLFR1G+usVVh/uMNevB?=
 =?us-ascii?Q?SPsr/IMgpZk02kWaqx+4KoXPP4C8Iy9JD1VnjVQnLYqb5ucPZSRMfQPF/vsa?=
 =?us-ascii?Q?XpHOSOFU1x/yq7N3Sx7pImxg5Cyu/MXUvHUhBHdFwVyEY5BUrJwFibzv+Nyz?=
 =?us-ascii?Q?O+UoM3QqeajGelnaLIk87rp0JkkTz5oyf/8cRdkkObfU8GEakJygG2nbz3NC?=
 =?us-ascii?Q?12zhrvHaV34EtrImF6TP6GOGMBriSsfENPjhq1wJdov5kS9R3gkfu8Wu+S/A?=
 =?us-ascii?Q?Jd1qo1GMNUBLp2WoQ8Xgtqn6ci13p3IIL7seCvK+SB5HUNMYdrtkKJifwxK5?=
 =?us-ascii?Q?DzqmSsSL8wTqJg6DxJ5mhgoA8MjCk2K0K2aV7v6LCud+sVkQRpOfHaSWKq4z?=
 =?us-ascii?Q?6reka56zGyEit72UAOZfilqeSJHXzpuDZO8KfuULTwSQOaTfXfW7byH5IfbP?=
 =?us-ascii?Q?JaP2csleu/mFKhXkKpked6bmDfpZtjjs5sGF+dXYO5gRaa2ncfrMw1GGSKQI?=
 =?us-ascii?Q?/AuOX3k62Z9KeK1zbefOAvZl0oPMMBX8xT2Kqvj8/qbaJD6ic3P5+8Y0BQm0?=
 =?us-ascii?Q?7W39UUguQpXdIV9maxoF2PCf5x3P0TBuWkBie0GJyrpETtFUCQW6/ywj+Uql?=
 =?us-ascii?Q?beNefiAjy8ZvOWii3bx7G50dW8uy7ydEzAjPmllcLjhuk7iSuwm8LkpqR0GQ?=
 =?us-ascii?Q?dOUbmvL/K/dC0cP2IZcP0DTIG6O/64/7TKtWNEX6g4fNvOoCn20WxPPCQVDz?=
 =?us-ascii?Q?Ss+Zs/X3a9uQ1VgdRZaBtp3VmgXFjIXAOZ42MnasfwooOxcpUC+C/IeckmQi?=
 =?us-ascii?Q?ye48nRLTirjfU3rHVohB7DKE87yz/F7A6DDjPPuH7BPPFalLVkV2nradt6qo?=
 =?us-ascii?Q?RxaW591+p3WsmpQ4J2BTRkkLlGd/7H6o/7/DLvcIztdsHLC1DEOf22I/0HxH?=
 =?us-ascii?Q?wt0bf54Udr1udtuaWR+CEjJThgi3UdvL7SneaDcp2qpxOzqv7IZZfZOFBiY0?=
 =?us-ascii?Q?tXbLecHagXsGojylOrkOKFnzpgwR64lHxQ3dHGIP1nHPdw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccafbf99-9c73-4e01-2052-08d9797a841d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 01:28:56.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: feqQbuSPIDfC3ojHmuaKH0ubD9sRolPpqwrgYoiD6/CYryDOFyoEkMW2GMyiwmYb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3349
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: UcU2frKQpoe-dg686BtIZE3xpCOIpqKW
X-Proofpoint-GUID: UcU2frKQpoe-dg686BtIZE3xpCOIpqKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_07,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170007
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muchun!

On Thu, Sep 16, 2021 at 09:47:35PM +0800, Muchun Song wrote:
> This version is rebased over linux 5.15-rc1, because Shakeel has asked me
> if I could do that. I rework some code suggested by Roman as well in this
> version. I have not removed the Acked-by tags which are from Roman, because
> this version is not based on the folio relevant. If Roman wants me to
> do this, please let me know, thanks.

I'm fine with this, thanks for clarifying.

> 
> Since the following patchsets applied. All the kernel memory are charged
> with the new APIs of obj_cgroup.
> 
> 	[v17,00/19] The new cgroup slab memory controller[1]
> 	[v5,0/7] Use obj_cgroup APIs to charge kmem pages[2]
> 
> But user memory allocations (LRU pages) pinning memcgs for a long time -
> it exists at a larger scale and is causing recurring problems in the real
> world: page cache doesn't get reclaimed for a long time, or is used by the
> second, third, fourth, ... instance of the same job that was restarted into
> a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> and make page reclaim very inefficient.

I've an idea: what if we use struct list_lru_memcg as an intermediate object
between an individual page and struct mem_cgroup?

It could contain a pointer to a memory cgroup structure (not even sure if a
reference is needed), and a lru page can contain a pointer to the lruvec instead
of memcg/objcg.

This approach can probably simplify the locking scheme. But what's more
important, it can dramatically reduce the number of css_get()/put() calls.
The latter are not particularly cheap after the deletion of a cgroup:
they are atomic_dec()'s. As a result, the reclaim efficiency could be much
better. The downside: we will need to update page->lruvec_memcg pointers on
reparenting pages during the cgroup removal.

This is a rough idea, maybe there are significant reasons why it's not possible
or will be way worse. But I think it's worth discussing. What do you think?

Thanks!
