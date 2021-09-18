Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078F441025D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 02:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbhIRAP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 20:15:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23920 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231902AbhIRAPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 20:15:25 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HMbdK8018090;
        Fri, 17 Sep 2021 17:13:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=z6xNrVYSnyusHLOq9fTkXp0Y9LaTgCP3ABBR7cBR++4=;
 b=lOME095Q3xxAqaGlHp4Si4j8qIC2p3MjaBvHNH8zij/MuAWkjJrCToQDi2+JjoadRRHm
 GovzJPVoWIFQM049Vqx/Xl3p8EHVTI/paFO1iZm2DuKhpmH3MkjDm74RIpPrxU5Fto46
 uz6Hihn6aySym6h0S0fUDiLxAOtTLVCmwew= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b4v76ktk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Sep 2021 17:13:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 17 Sep 2021 17:13:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKGKUJNtQBZv8yacItj1mzedwpPvXCGfwQTrqRACB5qUuiA9SBVYOoOIb4a11WaMQnE3PKDmD1jk7GWsB9dgEsJYuDYwA/4ahRjYN1UXI+ltVqoEMEOGdTs+TjXMrfqDUgCuC+3FEFM+YK3pcJq6K0LgS41XUsTj7bgMbYdKG1EnM7eMIu4HMatVMM92pUw72Z9PR8to9J2rJLSvxt0+nRrrGZSZmUEfbAONBNBAGqJy9s6tjTsN3I4va0GxVuQ1dAf8RLPf6dvPLBx5GkiqUOXDG77agrPNvkWFc+S8TEE8gtusPuMSPn45xI0K3jHTJcvPYO5Wv38xXm2gYxLOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=z6xNrVYSnyusHLOq9fTkXp0Y9LaTgCP3ABBR7cBR++4=;
 b=I1CWMaBLMvKG4kfUJJp3JT3Jgv4/r5ByqPo/bI/Wxjka8sWFjpDvOOw78UDNSiqvU5novWIixNYVSXoson9rr1hu4RKrgWbESDoefsg0K8NIGFR9ZJIF7HLVq2BjZhs/otnWfFjkzi8mzmtdERkR3RDVW2Mdrw6df74f/VmqrrMcL7zSiUabiY+lMgUPPoaqvk3sffbgxdHP6R0lQQ6bGRCQ8aAIIS3RCQmycPoX4PtT11rRJsaAR1S8yRO4akOzyWrYLkTXv0V/2GV4oHvs9jiS6wdHFviuD8kzvb+LYYwy3USuL9WxoOXeMFIguNMkb5DGaQROI7mk1sSU+8MVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3554.namprd15.prod.outlook.com (2603:10b6:a03:1b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sat, 18 Sep
 2021 00:13:49 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4523.017; Sat, 18 Sep 2021
 00:13:49 +0000
Date:   Fri, 17 Sep 2021 17:13:46 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>, "Singh, Balbir" <bsingharora@gmail.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/13] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YUUvOhX4Yk2xuGTu@carbon.dhcp.thefacebook.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
 <YUPvVYFyBR/qwy2X@carbon.DHCP.thefacebook.com>
 <CAMZfGtU42K0O+_KuuQ2untdYTiQet=W8K0m4+eh1CosJ96QL1Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMZfGtU42K0O+_KuuQ2untdYTiQet=W8K0m4+eh1CosJ96QL1Q@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5232) by BYAPR07CA0007.namprd07.prod.outlook.com (2603:10b6:a02:bc::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Sat, 18 Sep 2021 00:13:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77db259e-06c7-4ec6-e089-08d97a39306d
X-MS-TrafficTypeDiagnostic: BY5PR15MB3554:
X-Microsoft-Antispam-PRVS: <BY5PR15MB35542825AA14DD0DFB511B29BEDE9@BY5PR15MB3554.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QR+Rv01maQBe5L7x9z5Geg9npcEdbXVyid01EIja7DDbBWXaSsX/4DVRbZMoyqtrt5diGSxQh34ijimsDU6JDFMAoqKvV1vmI6GDCcekS0s78P7aPdM+S2V+zdAA5cpPkqc3OBxch4Ceq3M4mr0o4h9BgtXK051i9cgWqdlXf74VfatBixRs5mFGGzu4BSBsCLs4/41dV9a2FNCHi0F1K1YmYNBBKUlUdQwfF91DRfRP7FyuoafusMeStGajQ9KpZypl2dsRO4iYdM3CGmmt8Yur2/ghdZcs5c7+m29YvRnJ1tZNfxyrGBNsy+VPRgSYF8Xckt7vvStv5Wq683l0SBsfDBaH07YiiB19E/RImvQEaPWxy/XKiqz33+8rxrM0lgCQSxg/ls/qJ6USWg+pIjriWke2JOg3v4Vs4b2TBZXbvgvT43cPTa3/Ijit1t0WzKy4veEc/WiLSbMsT2WDw1bKkxKY9TmG+PcA662G6rt3+9Dym3UVM3DZ3h7m5stKjtWtnrKXyRNaixOXja0FFtRXJDwFE37CcglqC+40x2M2LSM5Z7QeYDQu9Z22u6PCyguh4ifPSMZ2g3IzR4UMhVYvMWuEiiyoOIv39VBx3xGKUJU4LH7QVCPkYAydOgrilIuxl/CA2voRsmG3L0C3eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(83380400001)(86362001)(316002)(54906003)(8676002)(66556008)(66476007)(8936002)(6506007)(53546011)(5660300002)(6666004)(186003)(2906002)(52116002)(7696005)(38100700002)(9686003)(66946007)(55016002)(508600001)(7416002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0AirNCGt2eDdnlGNQcuQWBMr+XfqDqj+9jnR34ltilA+MDNCXGGIzi0ajdJL?=
 =?us-ascii?Q?H2PrzaqDBWrXG/6lQiuNfxfh9NyZz2pKVryiyCj5aPPkGYrJDsTuvEaTsBHj?=
 =?us-ascii?Q?KQ9nDxIIyhRSUGWI/1b6nYTd6jW9C6swuOXVgUudkarvaFUELEiAxbXkj73B?=
 =?us-ascii?Q?0rNVPUQZC5bcgpTO6koDveIFolcSFXoSobkrJRCqChkzkUOu+5J8ptnP2SX1?=
 =?us-ascii?Q?LBvCK0zXcz6Yjs28JCVngeh3zW3NhbgWRBGc17ZvUnUPDczf6PQkWhNTHTET?=
 =?us-ascii?Q?JfT8xaHdpLRXTJAFWOY7lr4r7Yw7RTysLcj3Ki7QUv7sC6yJjXvalZvtEHso?=
 =?us-ascii?Q?bJnjvbi/E8NsmfOI9tBc5KViTuwXBr66v8z9E2ASy+3lHKs+OAv5MsWaxkzY?=
 =?us-ascii?Q?k0dMZBgAeXmW2dEKhwx2KPnI8rX5o6LRhy1uKE0+/t0ArXOdIpEUrW+icqEO?=
 =?us-ascii?Q?LKMStV0mFvqvpdx3Zz8qo64RcK60Q63EgSdEVlA0xPeDil7ZvdOKgPI6p+ah?=
 =?us-ascii?Q?YHTYJL3INeLwtBSqzsj5KT4Twg69NMjTgOY1LNd1v7032RYYBOMy5EXJ6Rw/?=
 =?us-ascii?Q?beutY5MkE9hNp2Eb/fkucmxnPQExWtZAKqmvuROe5o6al8toAgT6GZhxkphi?=
 =?us-ascii?Q?eMMcXU/TkwdG3iK3Vwe17vtasdkugq5RbYOl1uI5nM8GKvonLlA5wSMB68Fi?=
 =?us-ascii?Q?z2NtEunIrXqc9CDvP2BZJM8n45X10mtMhu9CNGPVfVeK9aiI8zz8F0WE2zhR?=
 =?us-ascii?Q?nYaHCEJwEmxADYPb4jSvhalC9JY3PZ8QXLgIyX3/lWbcFinEsTF3/pDAIn4J?=
 =?us-ascii?Q?P0UvSS/kglTpr/tt+94FWb6AQqh3BkQe4GBh7M3iLCLBb3HI+aGCrG2PATgq?=
 =?us-ascii?Q?N5Hfge3xeBoCVasVYuBhdqcPwdbGoYMKBYw/xPdz4a264ZxKVqQNG5N3WwYZ?=
 =?us-ascii?Q?tTjkvxPfoWXTJlK5yVarJHyVT12HtSvfIcousB5LB14iDJ8LpXvlxzjZr8uF?=
 =?us-ascii?Q?cueofS3tguJfyTpFdjcDsyIeZDBFOpsCaVlEgI+59rpzbtyIpQpz5DwozGlS?=
 =?us-ascii?Q?0SHJcV0hUQE6u0cNfOrOnFLfgst160WdiNgW2W7Z8ZFV1VjObdBWeMMsolBw?=
 =?us-ascii?Q?yvG50LCQsd8AYOKTLt4hPOlxbMZxbkOo6oBTbBwryYNw5McHDECChGFVIMdN?=
 =?us-ascii?Q?4lwZS9NvdxJ7iRTjw3jAn43goTCAnHMwkQ7aa/sBSFAymPIlNDR4juGzn7DT?=
 =?us-ascii?Q?WBLImfNzNN6Rcj6MWmAmlV++7AU8RLjgeX83/3RXQL92OXR0zqIeNDSUzDz6?=
 =?us-ascii?Q?AZFg9rpUV/upDErXUxb5/UuvZYGe3oZMCA/ZyV14Xkfr1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77db259e-06c7-4ec6-e089-08d97a39306d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2021 00:13:49.6226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e73EeE3xWlIZ0UZmteSMt26AoUxfXLHcZUDchumu03HfYmVLXzPB2ZrinYO8C78K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3554
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: GwGSTIX1e8vpDGux7MSHJPZTbJqwH4cY
X-Proofpoint-GUID: GwGSTIX1e8vpDGux7MSHJPZTbJqwH4cY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_09,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 mlxlogscore=811 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109180000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 06:49:21PM +0800, Muchun Song wrote:
> On Fri, Sep 17, 2021 at 9:29 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > Hi Muchun!
> >
> > On Thu, Sep 16, 2021 at 09:47:35PM +0800, Muchun Song wrote:
> > > This version is rebased over linux 5.15-rc1, because Shakeel has asked me
> > > if I could do that. I rework some code suggested by Roman as well in this
> > > version. I have not removed the Acked-by tags which are from Roman, because
> > > this version is not based on the folio relevant. If Roman wants me to
> > > do this, please let me know, thanks.
> >
> > I'm fine with this, thanks for clarifying.
> >
> > >
> > > Since the following patchsets applied. All the kernel memory are charged
> > > with the new APIs of obj_cgroup.
> > >
> > >       [v17,00/19] The new cgroup slab memory controller[1]
> > >       [v5,0/7] Use obj_cgroup APIs to charge kmem pages[2]
> > >
> > > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > > it exists at a larger scale and is causing recurring problems in the real
> > > world: page cache doesn't get reclaimed for a long time, or is used by the
> > > second, third, fourth, ... instance of the same job that was restarted into
> > > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > > and make page reclaim very inefficient.
> >
> > I've an idea: what if we use struct list_lru_memcg as an intermediate object
> > between an individual page and struct mem_cgroup?
> >
> > It could contain a pointer to a memory cgroup structure (not even sure if a
> > reference is needed), and a lru page can contain a pointer to the lruvec instead
> > of memcg/objcg.

lruvec_memcg I mean.

> 
> Hi Roman,
> 
> If I understand properly, here you mean the struct page has a pointer
> to the struct lruvec not struct list_lru_memcg. What's the functionality
> of the struct list_lru_memcg? Would you mind exposing more details?

So the basic idea is simple: a lru page charged to a memcg is associated with
a per-memcg lruvec (list_lru_memcg), which is associated with a memory cgroup.
And after your patches there is a second link of associations: page to objcg
to memcg:

1) page->objcg->memcg
2) page->list_lru_memcg->memcg

(those are not necessarily direct pointers, but generally speaking, relations).

My gut feeling is that if we can merge them into just 2) and use list_lru_memcg
as an intermediate object between pages and memory cgroups, the whole thing can
be more efficient and beautiful.

Yes, on reparenting we'd need to scan over all pages in the lru list, but
hopefully we can do it from a worker context. And it's not such a big deal as
with slab objects, where we simple had no list of all objects.

Again, I'm not 100% sure if it's possible and worth it, so it shouldn't block
your patchset if everybody else like it.

Thanks
