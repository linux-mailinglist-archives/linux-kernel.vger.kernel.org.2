Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC272417988
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 19:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbhIXRQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 13:16:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10602 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244773AbhIXRQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:16:41 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18OGZCUT010777
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 10:15:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=L1gFZbLIocGkc8NcVDE9rn2okNQRN7wkLm+dWXYJbSI=;
 b=pRP4cpR96xQ4YqfGyGNX3UrJ7HTbxPhLkxR1c/MJDhr1kJ2kO7bBSkxxWrecM/SjWrRR
 MjAkdugx/Vh1lPk0bNBto7mz5KOXcjrQ3CgqWE1Q1ceHXRLGoeZFSYzlsHvmSzuiGf+u
 fcTTuKCKTThPQ2zHB2WsSCDZusAsdAGGQq8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3b9hntgmgf-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 10:15:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 24 Sep 2021 10:15:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rbr/pSOHRjUdK8i3qiS8oFL7aMoFtBQwNnlbq/PUscDz6GKQePcjMRx7m4M9HinPU47vDnMjUPz/mIN4gkge5yQjx4lVC7tN332dhb5ZnvFkhk4qZrBn4nXueEQvC016JXOkrs/cX3v8lIkzf9Vtu18jfFYD8l3NmnGeRpeL9GxqooBERPfifzcWayH8PCOvgfYcjxv8oP9rPNgD8Ze7gj7HmMsFOC4qwK+gIJP4DXoKDmfxXifVaVwSAqHPT0NGfpU2Bz9iRFghCDBRuRcPkfiydWtkvwCNZuQs7fcUP/apWGJQFw0JknzVJVqQpmRzcKjw3ydIQFyIpLA/fdqIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=L1gFZbLIocGkc8NcVDE9rn2okNQRN7wkLm+dWXYJbSI=;
 b=O7234cGh+q/jRuG5R9i/dNlAG/ib1iREae9WFfmXdVRHj9j1n8+yLn4PCaW55nR7uFVMKm4JdrYygCpuxOCQaL0o1t7mLHeW5HxzbWzFVBD/dh3lLBKmFYVgMsPRcPL6QcrM9lMKBbMa9HtbtU2iXJXOVpOZw3fWe7Xo332tSlZ38m7Js2SPI2OENFoIZAS7Uct1m9jat4dZ/hiZHMYa1X40CifSM+JgQjYQAXo/f4AwRsO3f6DAp4buSLFXHQtLU0xrj7Ikxq7TI1+puDgo1CuZhes/tbZy1fnvvMhdIaSuoMRRfSz6HvOJsvMaexNa5lCPF0dAPqgawd+cNkZKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5096.namprd15.prod.outlook.com (2603:10b6:806:1df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 17:15:01 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 17:15:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andriin@fb.com>,
        "KP Singh" <kpsingh@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Topic: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Index: AQHWM6ViVS5deg/n5kWgZSYX+yJPDqi65OeAgAACB4CAAAIsgIAAAuWAgA+1r4CAAAEBAILrxW8A
Date:   Fri, 24 Sep 2021 17:15:01 +0000
Message-ID: <2FD32097-2557-46F7-B197-EAD864E5738C@fb.com>
References: <20200526212826.4097888-1-songliubraving@fb.com>
 <20200526213913.GG2483@worktop.programming.kicks-ass.net>
 <A9B20D93-748B-4789-801E-91720E2D4F28@fb.com>
 <20200526215415.GH2483@worktop.programming.kicks-ass.net>
 <20200526180437.45aed950@gandalf.local.home>
 <595AB855-8E84-4367-AEEC-C140F035C9B4@fb.com>
 <20200605180222.6cc3b34c@oasis.local.home>
In-Reply-To: <20200605180222.6cc3b34c@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 381990c0-b2d1-4327-ec46-08d97f7ed80a
x-ms-traffictypediagnostic: SA1PR15MB5096:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5096A553C60F8C9240D1304AB3A49@SA1PR15MB5096.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2lbVi1aFFEa6sSpx+PCx+msJAn9cyD2QaFFhoUzPZBZc95RhgULa+NmCqNwHbppFrdu00xGAJe9Syo7mRi9Bwd85ifhtNnoV7JfdzicSzWsmPnnzy993TgUTR48An6mfoSJ2Xxuwt+Woa+SyDN+cOH0Ai/gOs6GlaDBsJqe4oGyAPvEyGs7BbdgLVjkmYpm+y9RsOwo3xg6tzXAV2otX8kIO90WiFoj0Y8oi5ulBTijjTB2VpD9T8wXlXwEQtLa/YH2iNRtXZgXUNUpns0S2+on8Cmpn079FgJu/6y2Wc6zijSPM1c//qZd1JsmklN4ZgwCuggVeyXanlvQk9R+Wx/C+OU1N4se6+WVJSVUPWYIw2gS9EeZuDFYhQBOxh4CxEB7dzCE6v4PsntUx6jR9pkCLx3slb7hn45WbFTc6HoFv99FJ77uGJLtxKOF6hNVlXaka4MtNLzQDHu2XQ5avBk5noucM09MmvSjCFvIS+SWWn28YjGGt3+K5Y4F9CkXkgB63FLFariKxc5X24FJmyGevVOeB6C3J2/RAvV/mE7WKSJAmwpBxGBYco4gQJx7aoIVsFvIm0bEVyWkQ9FKmmtODjJe4geS7uQV5OovBL8TNt81oyDyqK7GeSTTuJPMQKbHZd1v3aHDMgknvCYovz6xkbRT/L+6/HZK9UgEe4ddafKkHbKlFIyTRIZ6YkAc6T4BLl2Jj/WxErP9EnktsXXQdb8bGbZjNco0e2HzUJa2JErkg7SPxpbFNLoD2iVgzdjekP17NQusaY39H4QgL+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(110136005)(64756008)(2906002)(6512007)(122000001)(186003)(8676002)(83380400001)(8936002)(2616005)(91956017)(71200400001)(66946007)(66476007)(66556008)(54906003)(316002)(66446008)(38100700002)(33656002)(6506007)(6486002)(76116006)(86362001)(36756003)(38070700005)(53546011)(5660300002)(508600001)(7416002)(45980500001)(299355004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HRMVzFeXTs6aW8K3r9w0th5lY5hxm35U9mNZkhEPlrjwGsp3/tYxebcLslaN?=
 =?us-ascii?Q?MUzkfslwOrcGxHosAGyp2cpST5uwilu8+9fzsQWkGcSZUkwO/PHyB9KJR22H?=
 =?us-ascii?Q?ST23WdWxTS+JDM6pP7I0kbt8lseqp7yk86MvuQaVQyppay+Q4RBrOcNFz99R?=
 =?us-ascii?Q?ruAKtYU/nNW4YajsV0X+Z3nIYX9YLbvxaGcLE6hghCKRbBxd0tRmzn3ftF6F?=
 =?us-ascii?Q?zbDG9298/XBvsTnDHPLQorVaS2AgveNxcQRQWl6e3nEsWews6+p+XAbfCfFo?=
 =?us-ascii?Q?IVzQOh0V/vSFPaRCwNAhQU7X0y9hTKCM3YHfY/U4w6x9XsX8iNcjwD02L/ed?=
 =?us-ascii?Q?uqvr/SDdjydRqaeHx4KK7bvZX99CL/pN8jVNALHORlVAXjUa6XujlJvGiB+E?=
 =?us-ascii?Q?cwYMuL4Er9LhlC5tX7iy0Kqta6RS201vojL8E/NW797uTd4NE++2BVDQsMIw?=
 =?us-ascii?Q?0uiQfkMudW4VvNfS4OVs8rbTBdBfc4eYZ31VW1kgakjJzjHOPtsizx2Dlv+i?=
 =?us-ascii?Q?J3zCLLpSL1mjwA/5M/hQo1u26VaH1LyUdc4Nsaz0RKZy14A9nDfutgRSnpsk?=
 =?us-ascii?Q?KB7cV0mEWj5Vu33+0g8Qz/yaB4M0kQD8Q1suTUFhiKt3MtnVw3N0tFRVU2qF?=
 =?us-ascii?Q?UxTiGNdqfecqNkYWEzAUQmL71wDH/wDU55XhDkPnweEad45pFyUR/ivjWqSn?=
 =?us-ascii?Q?43IC0HbTR+a3vLw+2Fcwlq+nY1tdQHyWfCT+rJ+kqhPHfs8jHfkmmnSDKKr8?=
 =?us-ascii?Q?/5x9dm1qXF3MFlY19YYhKRL6Da42SCFjp2XE6R+R4GgpPOtONyUYZfjmHi/G?=
 =?us-ascii?Q?H5SC44eA3SzEzWe/ijluQmfmFiUndkZfWW2or3ulkanwRP8IYFFHABAjVGvB?=
 =?us-ascii?Q?xstnJ6L8KRkWizwQ+3+MdYGLvsl1IUNvk9YQYA/XZwbsQTggv0gp4nGelV+3?=
 =?us-ascii?Q?h58sj093HQHWffOIfJr+mgO18F+cUZOm0yVbkt4GcYRTUNl9rcpA0/w4MmMP?=
 =?us-ascii?Q?KnQ6wZsAQ2GB0oWdR/AX04DxBOYwuHBcUSwWpvZXwPBvopGJ5couk5CZrmNQ?=
 =?us-ascii?Q?zwA31jyKtIvCzb3lo7QXXZWJAYdhn13qJv4KlqyM6PbQlvnA8Rl+p5iVTI/0?=
 =?us-ascii?Q?ddedvaaCDip7yQY7e5ImFSo6Opb8dgX393hH5D+CtlAgUJczNSAELJ816Mbv?=
 =?us-ascii?Q?wpzfUhgWPc2XM0qXtwOPYE5H9MsPxhwnWDPtLsX+kA/W5U0PGBgxDGr4/Zt5?=
 =?us-ascii?Q?YaHK9LryLIladJ9lWoHlhgmvdUiMdHlErO74C1a1Pb/4EcbutoAsQFYJ+2ew?=
 =?us-ascii?Q?4yJgtM70Cm+XP/TUgF8+KhqgY8z3tbcz6vgZw0lY7tibPROzDHETn/dK4ALN?=
 =?us-ascii?Q?wo8/8xA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A652F4CACC62C44EA955C7058919500C@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381990c0-b2d1-4327-ec46-08d97f7ed80a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 17:15:01.5423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUT9IiIyYKBdKlBdf3H6Oz3cqUI/XWB6wLiWSKjo7xnCoezLhoTMDG1EYnhsxH1xZCfCfWcT4MK9sZyVHdvhnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5096
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: I-UcM2v1eP258tyNYz2hpZPMqqUsfupl
X-Proofpoint-ORIG-GUID: I-UcM2v1eP258tyNYz2hpZPMqqUsfupl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_05,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=941
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109240109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 5, 2020, at 3:02 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> On Fri, 5 Jun 2020 21:58:48 +0000
> Song Liu <songliubraving@fb.com> wrote:
> 
>> 
>> How does this work in your tests? 
> 
> I started it, but got distracted by other work. It did not crash with
> the little testing I did do. I wanted to also look at my patch that
> adds tracing to the ftrace directory too.
> 
> I'll try to remember to address this some more next week. Feel free to
> ping me again then.

It looks like we dropped the ball more than a year ago. 

Adding Andrii and KP, who both hit this limitation in their recent work. 
I also hit this again recently. I was trying to use kernel live patch to 
fix a perf issue, but realized the whole kernel/events directory is not
ftrace-able. :(


Hi Steven, 

I am not sure whether you have got chance to test it more thoroughly. 
Optimistically assuming it didn't crash easily :-) , what would you 
suggest for our next steps? 

Thanks,
Song



Attaching the original RFC/PATCH below. 

From: Song Liu <songliubraving@fb.com>
Subject: [RFC] perf/core: allow ftrace for functions in kernel/event/core.c

It is useful to trace functions in kernel/event/core.c. Allow ftrace for
them by removing $(CC_FLAGS_FTRACE) from Makefile.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/events/Makefile b/kernel/events/Makefile
index 3c022e33c109..8591c180b52b 100644
--- a/kernel/events/Makefile
+++ b/kernel/events/Makefile
@@ -1,10 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_core.o =3D $(CC_FLAGS_FTRACE)
-endif
-
 obj-y :=3D core.o ring_buffer.o callchain.o
=20
 obj-$(CONFIG_HAVE_HW_BREAKPOINT) +=3D hw_breakpoint.o
 obj-$(CONFIG_UPROBES) +=3D uprobes.o
-
--=20
2.24.1
