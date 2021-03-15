Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FF733C65C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhCOTGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:06:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22944 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232926AbhCOTGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:06:21 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FJ048h000488;
        Mon, 15 Mar 2021 12:05:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=GAIggI3TEM15jV9ShOSIT0T/Vdb/l41961eOHDJcSRQ=;
 b=Rcn2adK4wmV1OG4oJ1jv9yBkfyQ7s5Z1vv9xV6Mbvr1VioPZY7G/QrstlqWAcI4g671m
 i6J5nPnblRAPBRgDdziMRVvVnuMWbyZWSwlGG5+qbfUATajjIO0YVJmSL3qy41kchlaH
 DvRNswvE3aZ6OVTrUhrOaTl6kJb4ua8Ddcs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 379ebty0e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Mar 2021 12:05:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 15 Mar 2021 12:05:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eW3OH9OKTxdjM4cLTJ8bAAgz6D/Ifr3RitQyw8OPYWjTl1yYJY6cx4WwTChRTmDZ6wRb0cfY9gAV8uuA8XhxLudB0ZbVLIvoG4Kfoo9pxDpe+r2qApQ2kkdbDenKE/CLhVPDK59gNpphmQHO4bZ6HQ6ann7EIvG2JaELC+tSTgkyKc/eczJwMz0dZbawA0dz8zSyAEatJz8ZPIeFIhEH+pA0k/sOdwiBv8vgZQwAhwY1+PiikqfMp2y0JC/tPp76uvkqXyCoa+vK8fi3OFN4ofHSKclVnRcdoIjdIR9Zu22Ot9zrZuwpxnXQ1lB5x2Q26qlLLRnvm+/ZU6iAcI1Bgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAIggI3TEM15jV9ShOSIT0T/Vdb/l41961eOHDJcSRQ=;
 b=GlYKtaJQzkP2J0gdVorjrwNIALE6M/thQYPMdyoGmprMPaP3eTexcpaTZxemP5pa5KO2B7zE3CPgiii5uPQ0EPRC6CwFIOlKy5cr+wBMfZAhgcO28QJ3mQiFLwktWbNR0Ek8EEYOFTlve/ngs5Hg+dH6UqcoCHQWGUMBhtaHVTTy4K2ZStzCL8b2yTKKLHLaf6yI9lbbnV4KXhccyQqFEm1OR4EkSpkIrdcwR5Vc8qVdlwmmjjq5UfeM+aCAjviQj4nDs28m2fnlJKc+LuCyy4TzzYL9rjuF6Ej0ByXlSprB6aatPWGwJ/o2DIcC9ruLPuZT19pWC/j31vbJ5Ko2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2598.namprd15.prod.outlook.com (2603:10b6:a03:14d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 19:05:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 19:05:45 +0000
Date:   Mon, 15 Mar 2021 12:05:40 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shu Ming <sming56@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 0/4] mm/slub: Fix count_partial() problem
Message-ID: <YE+wBMuX1Q0rhPQj@carbon.dhcp.thefacebook.com>
References: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
 <793c884a-9d60-baaf-fab8-3e5f4a024124@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <793c884a-9d60-baaf-fab8-3e5f4a024124@suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:5760]
X-ClientProxiedBy: CO2PR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:104:3::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5760) by CO2PR06CA0060.namprd06.prod.outlook.com (2603:10b6:104:3::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 19:05:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d7fd125-be35-44d8-103e-08d8e7e555ec
X-MS-TrafficTypeDiagnostic: BYAPR15MB2598:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2598311A32F826F59B1B291CBE6C9@BYAPR15MB2598.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TxtA/ksNgDirZK4sdrltavnO66KsCoMrYDMgN2I7azP5ahyc1oQ74xetybkcBqOKyBwmxIEki7wpSd9G3LvXGRFRz5+HtdKoRn+XldEuzsPiYzIZlqrqZyViB2EEZQ5K2E+Fn1o+a1MZ+UO72OC+m0xQm5UA3N9cJpGWFI1Oxwy87iWQgcyeDLzSAJnBzmdHfu9+3LqdCZbvF0c2p+59YuFz61mzGpfcTNr2XLTkrRkXKK8tODSeqL0WLWn6kYUDHopW+L1YRA8L8R8arBl70qI5gMwPNkqE4BrhrPQxA0SvQgQ9QHKEI6ThOTowfbMVL7ZM4q20sbU7zHWWwa5pbXKMOeXO3Ee5oIy8E+Z1t03KjBPjtwDZ56vvyKeOn8ExdOMH/9bYi+Fmw3SXcbk/YBhN7aLflWSOltfcu+Gv9gTFm6WhmEZcRb8SLQ2bfyZTbdkwW0lO6mNnS04fjPiVNRp8WPeDgWNASgEypNwupeAXc9S5dC+Tf5w3m5OWt6PBCYoCVFOFaJJDOogz4xSiCwk3vbwyhb8/o1gmKg/qfOpJn96ZmSG/G8Uq41cJ8YCHRMj9KvFbgqdpLcF8ulPYQxbbfT2sWNMdjd5wADo2kXH5gBS3tMv3cbekDjgP0vjk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(346002)(366004)(376002)(8676002)(6506007)(2906002)(4326008)(66476007)(52116002)(8936002)(53546011)(6916009)(316002)(5660300002)(478600001)(7696005)(7416002)(186003)(54906003)(9686003)(86362001)(83380400001)(66556008)(16526019)(55016002)(66946007)(219204002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c6yPOnpDh9lyBN5ceHwOsScVSwtj8BR0XxOkTVWNjwOqY/uLAEvGiJBCINyb?=
 =?us-ascii?Q?SpSOsjD51QlU1kYdYRCuv4cTFbkKukQ6Ao994kXRhcmz987fkhHGCU4fUxDe?=
 =?us-ascii?Q?hfI2VAFbDSJJG9Pyh7NKzIj/JLQSPiM0m4LEaRoNkbQ3ZPN5K4b5XHGI23hd?=
 =?us-ascii?Q?baSthj3HzLuiuwHO8x9/DaO7vyke44gFTxJIBHEgt+Sypu2nVqmtTXCG0Xx/?=
 =?us-ascii?Q?sLDz/yQqt0fbMqNdm1LDpqcwtpve6BsvPQteoI8gb9TiqPtb8eZ97tDbgFFj?=
 =?us-ascii?Q?/l1c07hYKbOc+s2lhEe81D/43VxlTISOt0Fb+MunaRGhKf1vQpv55a+WIMUy?=
 =?us-ascii?Q?jN6WDTsKNoCc93lEgcHlqwpXnb8b0HX8uAECaWNZQXBmvjW0mJyWVd4m56Ml?=
 =?us-ascii?Q?wGRPNBGnKbd+vNpeHruL/R3Mbd2W0w3aZ4s2jv1gepOQTyvYS7gSnWVg9Nt6?=
 =?us-ascii?Q?fygQ9YVoZRUGqpzZRd/N6G8kAK5+aDjdJ0/d3YW0vvYXDgY6FhaVKNF4dxIV?=
 =?us-ascii?Q?I/5EnqRwdveUFQVJwF/Kgfo/dno4a7ou/UbycReZRcOvy8joevbRceMAbj0q?=
 =?us-ascii?Q?JazXndIdh3oD0cJn7svDZ64HeGqD0GOy0ubbcplzLcYePNoEAd2EFOB6Je+H?=
 =?us-ascii?Q?GBU/I1d0+oYzDKnZAvyEZzxIJ0Mes/3viPq1XVl8iLMPlO8VhMHRBU0yjZ2T?=
 =?us-ascii?Q?0HR3zRjLM3zu+lr1aFJmZLwybFFErUeEXVJLW7DpnTq+3RH5h/G5DMyk/1fV?=
 =?us-ascii?Q?el+FZiWx8Ly6M2hcg4IT+hPc8L5+ZyfkCEAfCKEVOr546zLabd2q2xbVgl76?=
 =?us-ascii?Q?fC0VZx28xMPQ1xKUa36znp/NqsQZOKqUEs4WY5RqN9RKe+OVjnuIoqqNFr5h?=
 =?us-ascii?Q?iawmJkdp+kqb9CBMJFjJkhcSxAA5RFdZOrqehCUyYbDa0OtjUDFoZNlQg8ft?=
 =?us-ascii?Q?9rMQtP34Jl98Q7n9AB4tu0BvV7e4aI//utOXLe1nY9g4OcUZMbpg9CqtxICS?=
 =?us-ascii?Q?Nrpy0Nd3gan1+eSXioe8V0XeT0swlkFkWNzgu3Hvr8wwJdr8Zzufxw++rUB4?=
 =?us-ascii?Q?Z6qgvQ0eTL+BDNRaxnu0jxVkSGH/adIA4+eWGH8FAYRSTshsntOmEXQHj3Du?=
 =?us-ascii?Q?83Qe+gVNZB/FfpqiP0lKuxoZAEoJcVJ+2PV+5EGhIOZbwsZ8ByHte+C2G/wS?=
 =?us-ascii?Q?9fZgow/gaoBWQYc1zp9XdqkPJFMwZSDoiXGwrECts+se70dvRPElUgPLiGsQ?=
 =?us-ascii?Q?X2GgMghNA/LR3TT25hApeAwy7L8Qes9OxqZC8LVc/SqwKaYzI7VwMpiI/ghe?=
 =?us-ascii?Q?xoqrj/8HQ1i2vNcqVhdV5w2wR8EW4uYMJa1hDKvftKg6hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7fd125-be35-44d8-103e-08d8e7e555ec
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 19:05:45.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dv3Ca8AYuOzEioOJVlrEQrEa8XS3EdwuxOhP7lzGRumJNmIRbOVi156enq5Evx9N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2598
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_11:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=669 suspectscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Mar 15, 2021 at 07:49:57PM +0100, Vlastimil Babka wrote:
> On 3/9/21 4:25 PM, Xunlei Pang wrote:
> > count_partial() can hold n->list_lock spinlock for quite long, which
> > makes much trouble to the system. This series eliminate this problem.
> 
> Before I check the details, I have two high-level comments:
> 
> - patch 1 introduces some counting scheme that patch 4 then changes, could we do
> this in one step to avoid the churn?
> 
> - the series addresses the concern that spinlock is being held, but doesn't
> address the fact that counting partial per-node slabs is not nearly enough if we
> want accurate <active_objs> in /proc/slabinfo because there are also percpu
> slabs and per-cpu partial slabs, where we don't track the free objects at all.
> So after this series while the readers of /proc/slabinfo won't block the
> spinlock, they will get the same garbage data as before. So Christoph is not
> wrong to say that we can just report active_objs == num_objs and it won't
> actually break any ABI.
> At the same time somebody might actually want accurate object statistics at the
> expense of peak performance, and it would be nice to give them such option in
> SLUB. Right now we don't provide this accuracy even with CONFIG_SLUB_STATS,
> although that option provides many additional tuning stats, with additional
> overhead.
> So my proposal would be a new config for "accurate active objects" (or just tie
> it to CONFIG_SLUB_DEBUG?) that would extend the approach of percpu counters in
> patch 4 to all alloc/free, so that it includes percpu slabs. Without this config
> enabled, let's just report active_objs == num_objs.

It sounds really good to me! The only thing, I'd avoid introducing a new option
and use CONFIG_SLUB_STATS instead.

It seems like CONFIG_SLUB_DEBUG is a more popular option than CONFIG_SLUB_STATS.
CONFIG_SLUB_DEBUG is enabled on my Fedora workstation, CONFIG_SLUB_STATS is off.
I doubt an average user needs this data, so I'd go with CONFIG_SLUB_STATS.

Thanks!

> 
> Vlastimil
> 
> > v1->v2:
> > - Improved changelog and variable naming for PATCH 1~2.
> > - PATCH3 adds per-cpu counter to avoid performance regression
> >   in concurrent __slab_free().
> > 
> > v2->v3:
> > - Changed "page->inuse" to the safe "new.inuse", etc.
> > - Used CONFIG_SLUB_DEBUG and CONFIG_SYSFS condition for new counters.
> > - atomic_long_t -> unsigned long
> > 
> > [Testing]
> > There seems might be a little performance impact under extreme
> > __slab_free() concurrent calls according to my tests.
> > 
> > On my 32-cpu 2-socket physical machine:
> > Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
> > 
> > 1) perf stat --null --repeat 10 -- hackbench 20 thread 20000
> > 
> > == original, no patched
> > Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> > 
> >       24.536050899 seconds time elapsed                                          ( +-  0.24% )
> > 
> > 
> > Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> > 
> >       24.588049142 seconds time elapsed                                          ( +-  0.35% )
> > 
> > 
> > == patched with patch1~4
> > Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> > 
> >       24.670892273 seconds time elapsed                                          ( +-  0.29% )
> > 
> > 
> > Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> > 
> >       24.746755689 seconds time elapsed                                          ( +-  0.21% )
> > 
> > 
> > 2) perf stat --null --repeat 10 -- hackbench 32 thread 20000
> > 
> > == original, no patched
> >  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
> > 
> >       39.784911855 seconds time elapsed                                          ( +-  0.14% )
> > 
> >  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
> > 
> >       39.868687608 seconds time elapsed                                          ( +-  0.19% )
> > 
> > == patched with patch1~4
> >  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
> > 
> >       39.681273015 seconds time elapsed                                          ( +-  0.21% )
> > 
> >  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
> > 
> >       39.681238459 seconds time elapsed                                          ( +-  0.09% )
> > 
> > 
> > Xunlei Pang (4):
> >   mm/slub: Introduce two counters for partial objects
> >   mm/slub: Get rid of count_partial()
> >   percpu: Export per_cpu_sum()
> >   mm/slub: Use percpu partial free counter
> > 
> >  include/linux/percpu-defs.h   |  10 ++++
> >  kernel/locking/percpu-rwsem.c |  10 ----
> >  mm/slab.h                     |   4 ++
> >  mm/slub.c                     | 120 +++++++++++++++++++++++++++++-------------
> >  4 files changed, 97 insertions(+), 47 deletions(-)
> > 
> 
