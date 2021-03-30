Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3465034F3FC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 00:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhC3WG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 18:06:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35488 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232848AbhC3WFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:05:55 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UM4iHH019900;
        Tue, 30 Mar 2021 15:05:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=8H7KDghmnkpG22XSifZmzvWAq/+ByjNZ4ttflbVhwGw=;
 b=WBLaKXPwdEvKbJQmNzZeELqCznyhxuznjKfdAAJM8t3azwfPOgR7crD+IOJVkjrdqe0H
 F7ZdB/lOZLkQnsEQSQvnIShslQmTrhvniemSvd+/5vPjrFsXNhGvDDu2U1etsk6S5X8Z
 jVAc1NTsTt9K3oz27gbJgim2qaCjTLWYeI8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37ma9rrpt8-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Mar 2021 15:05:49 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 15:05:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mESBE2PYJ7NUuKfRguXgZEDGORsJ1tHf4qykQ9nhPmNWGTqADaa78LQ5Uhp82zVyb0rHtQ2bjfx8Ggc234siijWQTx2hPNW+A4CsgvLONpohm6mCHEMzj6lGOBRCYZDSbXaNA3iiGlxl+Q0X30/T44nNuh1aT/SDZowHEfEDcSE0DysBLxnglEPh9o6f1N6E7xv1T1rTs2W2yxRWsy8u28u1z2hqr8dTSZSBiFTAGxhG9+nJw+acO53eBsJtzmGArnErJfTxj3PNy6FZ68z+sBDKWbGmnqB1CKfNo5TAriKG8xQm+i+W0p4aYEw6DwwIVU16rZgSDi7Zn8UdDts/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H7KDghmnkpG22XSifZmzvWAq/+ByjNZ4ttflbVhwGw=;
 b=VFT2OPGJ/yM29bWCMUU/ja+uzcleIIby/56uYUs8J2tfFGP/KVTqwt3RZsS3/WveJktzKIWba5bHtWmgP1vvRmO6pz+Bsgg6h6bOfUgx/hWdUmau71uiWdoZtXT+f/hwJcw6l+oLZN0rqq152ANwqoMEw4Qs3aYvzWZYbdshiPgoNi2DIurGO67zT/bWB5hjzKa7t1eNEvxQptPVxX7NnWTMSgnY9RCgWzxJjcY9OMrK6vLO9BbI66cUE+jlmtSkkm/7qcq3hPG8PmNtB/hBQQuaezR80fXkTuVHeolvdnKOsTABND9nMgCApYTvhcBQGaMaTrKOLBoUpCj3aZUVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4327.namprd15.prod.outlook.com (2603:10b6:a03:358::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 22:05:46 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 22:05:46 +0000
Date:   Tue, 30 Mar 2021 15:05:42 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Subject: Re: [RFC PATCH 00/15] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YGOgth4IUflVE/Me@carbon.dhcp.thefacebook.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <CALvZod4xHNmTQMd+zg71s7uyXUHEfwnQ-zqRXSWphwi9RogeNg@mail.gmail.com>
 <YGN0141iu5HTGiNJ@carbon.dhcp.thefacebook.com>
 <YGOYYgWbwiYlKmzV@cmpxchg.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YGOYYgWbwiYlKmzV@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:ae92]
X-ClientProxiedBy: MWHPR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:300:ae::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ae92) by MWHPR14CA0005.namprd14.prod.outlook.com (2603:10b6:300:ae::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.28 via Frontend Transport; Tue, 30 Mar 2021 22:05:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46fbc82b-a311-4203-40d8-08d8f3c7f85d
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4327:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4327A9EE7EA24F68190285F6BE7D9@SJ0PR15MB4327.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ko3DYV2f82Nf9HHFHexmuUtg15mVNYuVicljJ3ZO++SKsnV4H2S1tdRpFidGDe83bymFEjWJd/CZEQrfgQJW5LO5+bm5W7WvPlBwlUOi3fnQW7rzwdqu8LKYieO1NThGakyS3CWvkfDJSPkAacga777WeNSwP0Zxm2fdjGGzhmNenOYxIgrmOz9fFGpe5xCt5vESTYzb79lgggmI1XdORYAfXXzsFX4AygD4JgXvFk/4LzdcAuXPgeaDFTGhHV7XBvF4wwd0yB805adAhDYO2/Q/Ot8wVUobMQy1aDfy69um6S1O9mmrFb+sIyDkk2H9iyj2ozMMIJxpvRbwibXbVxckwKmK05CkbhSjR6npUutZ4tj9iiFzoJz3YhXPHh4qHW/KwpooPvcexhhaf+IfzpFkE9i65pkaO11EuIBZjHSsj8yB/qXf5J5ALVqMBgNsV4q6zwOIERoNMH6tkEzK8GAyJDcatTSV4+P44JE4aksjcLpiwgg5FsDn6qa9aT+pikp/DlCH8m0i6/uD8yk3I0RLO4UzuHi4D1a2+NRtHn3KiVMOHRDdTb9HIj0cMYBnfzQOGsjGmTUdgn/jy3iZXAdjw40UG0+KovlqLsGNH5RXqWWzUYq42Zl0ZPe4DnmXleM6ZXiHoW6JBtT9W5IZ4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(39860400002)(366004)(6506007)(8936002)(53546011)(86362001)(7416002)(8676002)(52116002)(7696005)(66556008)(54906003)(5660300002)(66476007)(66946007)(55016002)(83380400001)(6916009)(9686003)(478600001)(6666004)(45080400002)(186003)(16526019)(4326008)(38100700001)(2906002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lEA97SFNfMA/+EYqFqYJiBNtPpeaFE1BxCFjauZc0vJzJF8jQtUPNyQ5+wwV?=
 =?us-ascii?Q?+nuN6q21vFEJB3+AQYk5IgyO9t6yknNOtW+cMUqydNZ+lbAqTuStP0El7+M5?=
 =?us-ascii?Q?k1Zjg2jowOY1ws5zKoJ47WU8CMHzKHhy0NJK3j3MDMwkt2WpA7jgh8hcpj80?=
 =?us-ascii?Q?5mXJITwyyUIPtWS3FZMP/HFiG0p98FBi+CHntNRMGSLccfH2NBUwobmZgpn2?=
 =?us-ascii?Q?vVVyUD4CXX9cuw6DW/6tW/cxJKFMnxKin5sg17lSPi3WzQJHZpLzw7wzOCNZ?=
 =?us-ascii?Q?frKbcbUjZSj0a1r7uYaSbWeDfowV+njS8Tz13S1infS8sL6BDESYK8xtazwh?=
 =?us-ascii?Q?bTAUP6PM04pjd9dkzv0f0ISaMqM69sh+qw5BQBWCGAKTkwnLKAEUBCNDAI+f?=
 =?us-ascii?Q?Og0Y17piCp5TVn1aSmG0I0jsSjA0hp7LTskYQH0+EyYCSCr7jwuGUCbPfoGr?=
 =?us-ascii?Q?j13tw+KDLsg1zs17StU4A4iBclVPp7H5/uwzp3hFTGQ2IWxH4Uh8/oErDN+L?=
 =?us-ascii?Q?RPLmPQ4OBuF9zeUKvgA9W4XGGUrjryUTZOwR1XgTtO2mqgjCA23b10Dvz0C2?=
 =?us-ascii?Q?8SGMc5lQf8ps25n32X6EoO0s5+GOGICIk2rArqqYQT3iuCF8ZHoIvWxUKyhK?=
 =?us-ascii?Q?MkAA8UYgZT9aLRqXCwpGpO6BJgNLZp/NQzldBqH36WnaIad3PYjQGp/LZn8u?=
 =?us-ascii?Q?FvhPSDYhsWPHFvDFKdBlHlkAJaP3iaACIuZMXKaq6LMHyuCr1SiBW88ZBM3u?=
 =?us-ascii?Q?2c1jvr8bM7LGxpDEhsMmnEjQeXZfLPU7SSTMTOrOqht9pcuYU8aTMU+Dp1uZ?=
 =?us-ascii?Q?rWOqbFZlA5R6l0Y3kIhiOB/qD/4yCUgf/ghhcc5HCPXZifbvVZLSVwJWoYa2?=
 =?us-ascii?Q?CFEyD8xUG7qMAn+2m45wZ0CKkyxCBoXOI/RvCvyRGy/ikXIgxRjburfQ7G80?=
 =?us-ascii?Q?vUwNeS6tvYxpx6R0CtOPDHEsg6sFuTiedP5JCiY1/qiJ9Bmc5vPICp4W4HcK?=
 =?us-ascii?Q?9puRxxKfLXgvrQ4UFzo68hB9qgXip2P9OGdDk2fvUGdUC5ildliputianWfI?=
 =?us-ascii?Q?4wpL3QIMJbzRVimjPqWTzy6M/dPsaXrGHQi5D1t/NXYPc42LvZiyXeEmednE?=
 =?us-ascii?Q?xgtxZ4mYIziyZdYpxgAeWkwN5ouZVUnfHIauU5CtNuQo/22hL5jzepp/6cmb?=
 =?us-ascii?Q?WMT89G7HZSg9Xw9aDPNYiazpjm7CJrL7QT9eGG0pECGXZtXQepZg/k4lgDsY?=
 =?us-ascii?Q?LtFqOLmWgB3OmuB0FQxAUNG2U1johFuM+OPpgpHgA/Z3ZASUXHobmrAmOtdf?=
 =?us-ascii?Q?DeKn9C5nW7CmqNQeMmvaVmDQf7KZ7pnP+WBGGEzZqMMVuQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fbc82b-a311-4203-40d8-08d8f3c7f85d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 22:05:46.6193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tjz+zNm0RFzVxikj8AgpALCHEyhSal/SqkMXZZtbOiUkz4HbOUpHvh7PatYonkQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4327
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 4nn38-A2Cn_aKgxh0q26CRxPv3IllOgA
X-Proofpoint-GUID: 4nn38-A2Cn_aKgxh0q26CRxPv3IllOgA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_12:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300160
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 05:30:10PM -0400, Johannes Weiner wrote:
> On Tue, Mar 30, 2021 at 11:58:31AM -0700, Roman Gushchin wrote:
> > On Tue, Mar 30, 2021 at 11:34:11AM -0700, Shakeel Butt wrote:
> > > On Tue, Mar 30, 2021 at 3:20 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > Since the following patchsets applied. All the kernel memory are charged
> > > > with the new APIs of obj_cgroup.
> > > >
> > > >         [v17,00/19] The new cgroup slab memory controller
> > > >         [v5,0/7] Use obj_cgroup APIs to charge kmem pages
> > > >
> > > > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > > > it exists at a larger scale and is causing recurring problems in the real
> > > > world: page cache doesn't get reclaimed for a long time, or is used by the
> > > > second, third, fourth, ... instance of the same job that was restarted into
> > > > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > > > and make page reclaim very inefficient.
> > > >
> > > > We can convert LRU pages and most other raw memcg pins to the objcg direction
> > > > to fix this problem, and then the LRU pages will not pin the memcgs.
> > > >
> > > > This patchset aims to make the LRU pages to drop the reference to memory
> > > > cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> > > > of the dying cgroups will not increase if we run the following test script.
> > > >
> > > > ```bash
> > > > #!/bin/bash
> > > >
> > > > cat /proc/cgroups | grep memory
> > > >
> > > > cd /sys/fs/cgroup/memory
> > > >
> > > > for i in range{1..500}
> > > > do
> > > >         mkdir test
> > > >         echo $$ > test/cgroup.procs
> > > >         sleep 60 &
> > > >         echo $$ > cgroup.procs
> > > >         echo `cat test/cgroup.procs` > cgroup.procs
> > > >         rmdir test
> > > > done
> > > >
> > > > cat /proc/cgroups | grep memory
> > > > ```
> > > >
> > > > Patch 1 aims to fix page charging in page replacement.
> > > > Patch 2-5 are code cleanup and simplification.
> > > > Patch 6-15 convert LRU pages pin to the objcg direction.
> > > 
> > > The main concern I have with *just* reparenting LRU pages is that for
> > > the long running systems, the root memcg will become a dumping ground.
> > > In addition a job running multiple times on a machine will see
> > > inconsistent memory usage if it re-accesses the file pages which were
> > > reparented to the root memcg.
> > 
> > I agree, but also the reparenting is not the perfect thing in a combination
> > with any memory protections (e.g. memory.low).
> > 
> > Imagine the following configuration:
> > workload.slice
> > - workload_gen_1.service   memory.min = 30G
> > - workload_gen_2.service   memory.min = 30G
> > - workload_gen_3.service   memory.min = 30G
> >   ...
> > 
> > Parent cgroup and several generations of the child cgroup, protected by a memory.low.
> > Once the memory is getting reparented, it's not protected anymore.
> 
> That doesn't sound right.
> 
> A deleted cgroup today exerts no control over its abandoned
> pages. css_reset() will blow out any control settings.

I know. Currently it works in the following way: once cgroup gen_1 is deleted,
it's memory is not protected anymore, so eventually it's getting evicted and
re-faulted as gen_2 (or gen_N) memory. Muchun's patchset doesn't change this,
of course. But long-term we likely wanna re-charge such pages to new cgroups
and avoid unnecessary evictions and re-faults. Switching to obj_cgroups doesn't
help and likely will complicate this change. So I'm a bit skeptical here.

Also, in my experience the pagecache is not the main/worst memcg reference
holder (writeback structures are way worse). Pages are relatively large
(in comparison to some slab objects), and rarely there is only one page pinning
a separate memcg. And switching to obj_cgroup doesn't completely eliminate
the problem: we just switch from accumulating larger mem_cgroups to accumulating
smaller obj_cgroups.

With all this said, I'm not necessarily opposing the patchset, but it's
necessary to discuss how it fits into the long-term picture.
E.g. if we're going to use obj_cgroup API for page-sized objects, shouldn't
we split it back into the reparenting and bytes-sized accounting parts,
as I initially suggested. And shouldn't we move the reparenting part to
the cgroup core level, so we could use it for other controllers
(e.g. to fix the writeback problem).

> 
> If you're talking about protection previously inherited by
> workload.slice, that continues to apply as it always has.
> 
> None of this is really accidental. Per definition the workload.slice
> control domain includes workload_gen_1.service. And per definition,
> the workload_gen_1.service domain ceases to exist when you delete it.
> 
> There are no (or shouldn't be any!) semantic changes from the physical
> unlinking from a dead control domain.
> 
> > Also, I'm somewhat concerned about the interaction of the reparenting
> > with the writeback and dirty throttling. How does it work together?
> 
> What interaction specifically?
> 
> When you delete a cgroup that had both the block and the memory
> controller enabled, the control domain of both goes away and it
> becomes subject to whatever control domain is above it (if any).
> 
> A higher control domain in turn takes a recursive view of the subtree,
> see mem_cgroup_wb_stats(), so when control is exerted, it applies
> regardless of how and where pages are physically linked in children.
> 
> It's also already possible to enable e.g. block control only at a very
> high level and memory control down to a lower level. Per design this
> code can live with different domain sizes for memory and block.

I'm totally happy if it's safe, I just don't know this code well enough
to be sure without taking a closer look.
