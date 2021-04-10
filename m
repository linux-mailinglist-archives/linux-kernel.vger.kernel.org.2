Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3DC35A9F1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhDJBaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:30:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50610 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235201AbhDJBaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:30:19 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13A1SrOO004052;
        Fri, 9 Apr 2021 18:29:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=/JoKhyFCj+JC3B0Vu8rC3IL8rPgCCCBjD3ruQ/6nmnk=;
 b=oV4u1G2NSSGz7xJXF+ZrzYBuU24zJDaaAvmTJHlqRbaU37gPcaIrFbeFpiVgNDrvEgqx
 VSiEuqRZ95v+vxbv2+BquERZy5mEH7iazT62DiVIEe4g/nIjY3uDVR0bmYdEbJ53QH9o
 yGXrsrW6v400UW0lX9LBySKKXoN2vaFfUEw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37tcgbfamd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 09 Apr 2021 18:29:53 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 18:29:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzW8/AOFdYEC/jksvzbXZTE1T9+oIyi/agt79zlzaV1suz3g4r3wsa0z/kQXiMKsbkxk/iqtBRqI8Zb+d+SNKft8rb2FJrvVhdRECNeUEvFdXGGrKmdvkC6rPTOhJGc6F60smO6W5Cc/q6LrpIeUqvdArCLW4z9X/9m2eG46GHq8i4tjNWnav0RRYw8n4Ka1z/wUK2/G6PrNyS1p8PzyxjPVByu4vvhP68rzQotrJ3HP6dkstXP8UTJS8HIyFhFngNRCaLze84mc5IxnLW/AL4SYkAcOvWLeGCwxRnPDol0bKafxBHJ29G/iS/R5ufdphW0vSP3s2LViJJxEFzLYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JoKhyFCj+JC3B0Vu8rC3IL8rPgCCCBjD3ruQ/6nmnk=;
 b=UG4X2ySUaH2lyC9M8072juUETerYX6YySsx+p1qFcOyWsZJN0kG2+IKswMaC+K6o0cOKBzCov0XIxPCNzKsNGmNP7fuEFOKnQPcm/87QA2mMBjQzBdbvQ7lEMaoDxGV01cGYVU+S3YYDvCELexW3MwJiUtlqdfOCsG33mkc5MJuLvLbmd87JTjPFHJmcmAekD8zwUgRoWwUsP1Amy4Q/F6amZEEfi3Wk4gxG0AAoZ1iDkhHuzrPu2illmIKivtCVdBWAe7tG2Rgre2nJZ4pnGuWo3IxUSj2RiPQLX95TWzEoWAZflJf+n6CkIwAF5f0LVzC2EeGfqQXJNUZTVhWqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2710.namprd15.prod.outlook.com (2603:10b6:a03:153::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Sat, 10 Apr
 2021 01:29:50 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.021; Sat, 10 Apr 2021
 01:29:50 +0000
Date:   Fri, 9 Apr 2021 18:29:46 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>, <bsingharora@gmail.com>,
        <shy828301@gmail.com>, <alex.shi@linux.alibaba.com>
Subject: Re: [RFC PATCH v2 00/18] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YHD/itVJlgzE2uXm@carbon.dhcp.thefacebook.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:76d]
X-ClientProxiedBy: MWHPR1401CA0020.namprd14.prod.outlook.com
 (2603:10b6:301:4b::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:76d) by MWHPR1401CA0020.namprd14.prod.outlook.com (2603:10b6:301:4b::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 01:29:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3492c00-828f-4a43-6816-08d8fbc02261
X-MS-TrafficTypeDiagnostic: BYAPR15MB2710:
X-Microsoft-Antispam-PRVS: <BYAPR15MB271034325BDEEDCED0B18C8EBE729@BYAPR15MB2710.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qc06qlO/Pae7FxbH9LD/SM04fnS1KYDjAaPvOFmAnlw7igAcN0J3JEYWQPi9SuMqvOGCaGXX+UVUZY2b3BwN2Yfy9ipvVcsPzUnyAZZbnw7umBSeRGC2mshum88BMN/7Dk2jRfKzmtRtkyFOMkwRfy38SxmwRl1Db3H5a+6zNsmWGEUJp4kLpkdKeCt7BswCBW8b00EZ7E78nSRCJb/+/n264CZPOWtewg0XO+oMLKIhpYLJ+eMEgRccCzJb/xcwfdMYYYjCHiE5QK/UGFLLae/1pBS6LhuPEiRLFZTMF//BUvysENmab4CDq2z6zXXbS8aQzY2I1j9YJJOhn6CzonIJiqk6z/U4VoE2P0RCfgq3bNJuNXSNf4rJ5/557xGTZflzr9rqYdUGt1F/US6q36JzLBh479OluIFOImSAMsThWGR1AzDCePYbsy159ocHf74cadAKeNmDxxMssOgMM2dbVFajoILFy/hFNMpFMPl1Uis8D9ioXoIUnHpKcfCACvPiv3M7QTDfTH0GMk8kofK/0bOnVzAiGEl3zUPuNk8BscwtRc/Xa6uC2H6JpGa7kvAV88LJXx9odV5PL/eSJPSZ0X0IFldhgMKfSwG3kws9N+tUFL/vjrGHj0CkTzb2ZuC1dxnhrmmrWs7IQebkdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(346002)(136003)(6666004)(2906002)(6506007)(4326008)(83380400001)(7696005)(316002)(52116002)(5660300002)(38100700001)(7416002)(9686003)(8676002)(6916009)(8936002)(16526019)(55016002)(66946007)(66556008)(66476007)(478600001)(86362001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mDAqPDAntWAgl/zoEpaQ1l/Lo4I4RSiQxUFtbqCstHeOgF5DS20sjNBg7VPO?=
 =?us-ascii?Q?gslaL0adJiuHgY7RhNB00pmlyQ2y3yGY0akyynSwTUVGqR44KthXOm+pkPCX?=
 =?us-ascii?Q?fFQZYRby+RssdT65YWokOaCXTlFunM5hZA82kCipDqPhrz4xcuoozUq5uipI?=
 =?us-ascii?Q?+UAazkqr9q07xt0SzOeMjlPQRLi/Lqx0OLDZ5NPLVmSNjqqo0meTRdiDMhaw?=
 =?us-ascii?Q?q6o3wzX9FhKlOISUMyWXQCT1+PovUim/eYc3ETLhBQFGmyFvl/QdLGrjMxcT?=
 =?us-ascii?Q?jIV1ClfDSvR+6nokvt/tHTGbhTPnx7Z4a/sEh1Y4+D6lJzatw2QXdR6h4Dlj?=
 =?us-ascii?Q?dM+d/qnllAZROOlXMBIWG/amZ0TnXKXchTWqzEbnK30U2bg4WitdKr7C9+yg?=
 =?us-ascii?Q?Yy5Zlb2ztxun+U5rVt3bxvPsR98BjSGjBna8vdAk6ST4TZ9TnA86wLwI6p2C?=
 =?us-ascii?Q?enB70SvHbJSMEmU6iq3gQzS50b5Eo9xMlBs4uL8ogjA6o6hrXKsveLdhJ7PG?=
 =?us-ascii?Q?KAPildsOEi/SLAZse6SRkf3/KBtFfiqjRFu0SxwhANoWmv42TID/dYkrSaVa?=
 =?us-ascii?Q?Izt4IrTSQq+gPoRYvgLjpNHQ8gjZkolIJNqeG/nPjwAFfAWD/4o++mSHmT4v?=
 =?us-ascii?Q?CdRAiTotS+k3pUJRRWjeKf+otbohlVSlDi1J/ODPhpq3bO11BIDK+fdoK887?=
 =?us-ascii?Q?g9j9WlAfyZ+DqWGLxXQsMtrYQnxzo/+XUCBX5nx+uQ/AK9vzZBGz4Hkx2BJ5?=
 =?us-ascii?Q?WJJ5qtvxcwm7xHPvr4p56FQC3wo5NaA9ssaYp1wVWvi1Nak5WjomLMtraNjo?=
 =?us-ascii?Q?j6TE4In3GDenZtS8Cw0YKpojBQlqHqiW8zxwyrGBEcoaNZAc+DQ6DWoQCUy0?=
 =?us-ascii?Q?u1PRWlcwz/O2cOMJZ/ywsITj9iEdrut6XVELf1ASLPbH6+vvTUtuRzKbWKNL?=
 =?us-ascii?Q?EOLRjNzKqq09Ds3o6KGKUDLpB2OQg6p33ggsMl/LW98Biqw2URzwcMhz7OpR?=
 =?us-ascii?Q?pyic7OdZWsP/qgz9S4kLdslMmf/raWg1H7xtii+ouQn56KXz0IkH+S0QVt1d?=
 =?us-ascii?Q?MDaOOrqdJPNizlVznrxIVDAfeAvcQXcJmHN0u/W3ZOmQXhuJAhWSXVN4vygk?=
 =?us-ascii?Q?Lk3rMtQfgnKhG7da8I46mJh0ihYcw60fOYH9OZ54SHLW+sADMkeW5YgB/PTX?=
 =?us-ascii?Q?3MKE/MIRtNsox93KH9edXyFo0oOhb0VTZhYqUt/ArzlUss63kZzBT+89aK6V?=
 =?us-ascii?Q?b36RvB1aR5AReVXx2bUu/Wyvfp2hpeZ/2UFWBIAjIcPy9rFuTU4MI7H5vwXj?=
 =?us-ascii?Q?dShJL++oZNJUHlAWKThY791bSeKqS8yRtX6RJgqovErRdA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3492c00-828f-4a43-6816-08d8fbc02261
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 01:29:50.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMMwS5XRxBW35j8vfRcB0yu2KBKTGdEcyHYQoa5E1XKbPdvkALKINa6s4U4OHfYX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2710
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: tg8lWNeF-mdneiwYlXTZy8YTWRGXMseF
X-Proofpoint-ORIG-GUID: tg8lWNeF-mdneiwYlXTZy8YTWRGXMseF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_08:2021-04-09,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104100007
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 08:29:41PM +0800, Muchun Song wrote:
> Since the following patchsets applied. All the kernel memory are charged
> with the new APIs of obj_cgroup.
> 
> 	[v17,00/19] The new cgroup slab memory controller
> 	[v5,0/7] Use obj_cgroup APIs to charge kmem pages
> 
> But user memory allocations (LRU pages) pinning memcgs for a long time -
> it exists at a larger scale and is causing recurring problems in the real
> world: page cache doesn't get reclaimed for a long time, or is used by the
> second, third, fourth, ... instance of the same job that was restarted into
> a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> and make page reclaim very inefficient.
> 
> We can convert LRU pages and most other raw memcg pins to the objcg direction
> to fix this problem, and then the LRU pages will not pin the memcgs.
> 
> This patchset aims to make the LRU pages to drop the reference to memory
> cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> of the dying cgroups will not increase if we run the following test script.
> 
> ```bash
> #!/bin/bash
> 
> cat /proc/cgroups | grep memory
> 
> cd /sys/fs/cgroup/memory
> 
> for i in range{1..500}
> do
> 	mkdir test
> 	echo $$ > test/cgroup.procs
> 	sleep 60 &
> 	echo $$ > cgroup.procs
> 	echo `cat test/cgroup.procs` > cgroup.procs
> 	rmdir test
> done
> 
> cat /proc/cgroups | grep memory
> ```
> 
> Patch 1 aims to fix page charging in page replacement.
> Patch 2-5 are code cleanup and simplification.
> Patch 6-18 convert LRU pages pin to the objcg direction.
> 
> Any comments are welcome. Thanks.

Indeed the problem exists for a long time and it would be nice to fix it.
However I'm against merging the patchset in the current form (there are some
nice fixes/clean-ups, which can/must be applied independently). Let me explain
my concerns:

Back to the new slab controller discussion obj_cgroup was suggested by Johannes
as a union of two concepts:
1) reparenting (basically an auto-pointer to a memcg in c++ terms)
2) byte-sized accounting

I was initially against this union because I anticipated that the reparenting
part will be useful separately. And the time told it was true.

I still think obj_cgroup API must be significantly reworked before being
applied outside of the kmem area: reparenting part must be separated
and moved to the cgroup core level to be used not only in the memcg
context but also for other controllers, which are facing similar problems.
Spilling obj_cgroup API in the current form over all memcg code will
make it more complicated and will delay it, given the amount of changes
and the number of potential code conflicts.

I'm working on the generalization of obj_cgroup API (as described above)
and expect to have some patches next week.

Thanks!
