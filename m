Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0435233A1D4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 00:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbhCMXD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 18:03:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45920 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231756AbhCMXDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 18:03:47 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12DN0RWk008455;
        Sat, 13 Mar 2021 15:03:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ob+8qUum/UhlPpeIj1xshhO0lZvUfM4KQh3Ld2BL8IE=;
 b=WfFt0EeQrnfuZhMEJiV/X2QMhu4OFELLN/XN3ecHyEx9kFiodkED4gXDms8UnrRiFY+l
 BPk2qNK80Lgtz89DGHdz1IC6BtQJZs0LIXZe1x/uXRUJ6lniL7239oFhoIpND98uE56S
 Z1lDI9VsdQoenTJl7EBDe7Gl+PVkP2QGZXs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 378v0v9w2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 13 Mar 2021 15:03:44 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 13 Mar 2021 15:03:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9a7XBtsc2YgSmH/q6FPe6XgOcDjs1gCpED4AAd/BWp7PH4pO7FFLW2OLl+JVHR00zV6G14oJbA5Dny7/dnf+ZCsHMgrq9whPs3OSsgJJkGUs02XD4pnO6sdbslJ+zFUdabSK4zR7SfeRlfFje7jagt+OQq9t3UCUsLVeJ38JuMANDT/2O4mzqxwC3bb0zXVJDoCq1dyCz5bmnnWZ9E67heCqu7lQDTIqTQN7sddUfUbF23BJT2weB7/lxlfDEj3iYt+5WcxUa3TvcXoHnJv6w1fPMkTomWSlSAz7ZLyJCbFj7qrBBvT6ATKqq/qWmPk4T0YdfACSPS8jqiHXPDn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob+8qUum/UhlPpeIj1xshhO0lZvUfM4KQh3Ld2BL8IE=;
 b=buGrBsFVWJQOMahpxzoVFMBT8zWMe+WbfRa83mSctcl8gbJal6tgCuaXQCIN0G+ETblb22wL/t8vkdVLLt4xvUznT08uxzhzz0713ExrdaGfasQ6OoZg6UWE5QVJ3uvKrPQoKjWH0wu/D9uvN3hckrVZeutrdlBFzFg/RLuIgnGD6Fx+dbScba+T+wp0mFQvxrZTBPiljgCE/YhH61F1WFp+4Q8RVRi47S632u/p7kl5LRwB8/bKuVOlNGFvz9qVTMvNJ7NELueaqlSYBhv9FX7Vw3eYFH5zbKd/5aXdaI5NJxu2OIALoqvGt0q77dAX0WEqQ34bEEF/jIUJK3L9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4757.namprd15.prod.outlook.com (2603:10b6:a03:37a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 13 Mar
 2021 23:03:41 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.032; Sat, 13 Mar 2021
 23:03:41 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Topic: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Index: AQHXFuPifzAWbJ/c0EGfxtA8c/wTpKqAREAAgAA7WYCAAAbkgIAB9duAgAAQFgA=
Date:   Sat, 13 Mar 2021 23:03:41 +0000
Message-ID: <4FD8EC9E-0B89-439C-865C-A245A2F2886F@fb.com>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <YEtawFnompBDKpK0@krava> <45BCAC33-1626-42D1-A170-92DC8D7BAAF8@fb.com>
 <B7934C3F-4414-45AA-BE39-8FE3C64B7E7D@fb.com> <YE03TdSyQz5jXaNA@krava>
In-Reply-To: <YE03TdSyQz5jXaNA@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:17f0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2535304-9236-4266-4f41-08d8e6743ee0
x-ms-traffictypediagnostic: SJ0PR15MB4757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR15MB4757C246FA4E0A41DBF40FB1B36E9@SJ0PR15MB4757.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BPMaZdViwBYSiuSN4ic6R1Tu369hdCFMBBc15oRYgbMhhXuGYqyOe+ccYmT7PZWxskZmM8fq2NGlVsAA2jgtBlK4cORpLwEhRiP61K4IeLrdRXxhPvx7SRkI4S3yci59YSHxuP9y8CfuoqXOi0krg2ws+CMDVey7pZ8hYD3lZM2bZ/swE3xnJTPMrWtBI2KaqCx/t2RbHBlEL7fOUNgHOi9HUCDYdvu6F37c1VMa8mk/iIerMie40iaUl4Cg8CH11xvCEJIpkLXal+s+dwpt83x74CUqCMWbgptNNC1+bkbevn4Dlqx8qJuNWg0/DTFdg6JShyHJWQzo0R+67xuc36ZiNi8996qxkwNLOmjxoaRNzeFPNYK39AAJAEHDf5LkC83Lc1yo/KqAV/nSC4mXKbh54JBImqDeVE2EmE6lKm/Qxtvts67gpBqdoiJTeN1pc1ftilmp5l6TC2zXHtVTIztylJWulYa6f/fd9QWeXjALcHb14plWrXZoPh+4dB26+2CAIONvb8RLcCF5kc/AlTQA4kSyGnL6pTUPqlq8yqc0TWg6i35DqvpSWybacxkEgNZqhStkdePeq0Kqopo+ijJMfNiKaiM9/IqPm3xTJim+heDGCxLolN8+1pI/h8v9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(366004)(39860400002)(91956017)(83380400001)(66946007)(66446008)(71200400001)(76116006)(64756008)(66476007)(66556008)(5660300002)(2616005)(53546011)(6486002)(2906002)(186003)(8676002)(33656002)(54906003)(316002)(86362001)(4326008)(6512007)(8936002)(478600001)(36756003)(6506007)(6916009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2eUmgUVQ6m1NK13F7a4/UMLkWs/lElcX02Yl+TMMlxKUjDteREl8UBD1BbCt?=
 =?us-ascii?Q?zXTc8naMooA2DHHiOt/RwyuB33vaPg+5MAkAb/rV9W0+BllPTV2+7rn6iEm3?=
 =?us-ascii?Q?LNqYrQeKsCv62PywjqC015llL+cidteoztljF6UzfVAcLmLTCEdcKRgewaUf?=
 =?us-ascii?Q?Yz1NOwgAnT+9TeG6hdkK8wrBvJ+6QbTxVgxp8hxdpjXZcNTCdfAHBfFzZl+9?=
 =?us-ascii?Q?PB05z3t239sYrG++G3f8Pjbkw2+BkS/ZX10CXsoUvefRQ1Xefudg/fYOpJri?=
 =?us-ascii?Q?MWIoLu+mjS1ydQT5/qgkE6wrSyWmWhw1JLF5abjm9Addw4Gm3UnPL4Gsa/I/?=
 =?us-ascii?Q?L/MAgoVlgs1dIEVM+5m0Lhj9uq5zycC8/dCq74UA+PK+2Eov6uYIg+AFKmq0?=
 =?us-ascii?Q?RjKesDQ+rSmVBrIuP1DyrcDiQoQkt9qYDczXlRhNcD+voEilA3tyIGKNTwUa?=
 =?us-ascii?Q?vwsnZP7cnyxgsa6s4m+dc5ktc8yocJZaDPvEu8xGGb8dpjfVdmhf+u/d43zg?=
 =?us-ascii?Q?oukfT7KiTJnPX1nDcYLjVTzUakvrewOexe0OqleJwiSIE1qM3U+PGXNRWWod?=
 =?us-ascii?Q?6tGtIvzuTyFzHBHbjXQAnGFVjXmb7IAcuo5w0phaEcH3fvTsukW/kGOAA6sy?=
 =?us-ascii?Q?MwFLIdmg3w4uwAhm4jK4woZFqpyODKno0dFHsJqfZ0E8/1inmjUAJsDEYXaH?=
 =?us-ascii?Q?P10o/0VvRbNIao1hOUkRscme2L9qhLB3oMisGEzOCimJ4olm9qH8IJGnbsJM?=
 =?us-ascii?Q?T4cnTvAQ/VALySJ6v1LtWY/sOBtYEKZJlOwtfB0KDJzOpPDFfhhp3nI8P2Id?=
 =?us-ascii?Q?YYQpJVJuPtuiW+LAmne5+4vkkEgH5PvEJa6t9GSzyewi85cXP9W40jIQqjqC?=
 =?us-ascii?Q?yTudhKCkF2BXJ/QTSrFRqgvWSDuHKtJlqdF5PxtkFnb1WqSz8EOstMo1vADR?=
 =?us-ascii?Q?VJEBcYDNzoHrSGbyWGkY5eRrRff7rvMNoSl3Nty94k+OPFn/FI+mEcsfC1um?=
 =?us-ascii?Q?P4w6Y5xNFgEcZrooR7dR3zROas5/NI6BweIZ96snAsV8EuuQvM1u5Q0Zj4lN?=
 =?us-ascii?Q?qBXvEDAMUXe/frWxj/kUWBWGoDR4L5wGrTvOgK+Lsd7kMRR3ss0eDoWO0QId?=
 =?us-ascii?Q?YDhPZIA/I0L9b2DztJL2bX56/B93vjPAKr4olXdx68n6nhjBWAi3WAtrepnu?=
 =?us-ascii?Q?RSBLL6tIy3nKMpr6x0pioybxxMfFwKKq4dCjQBGBo5hIa6iJH9/WLBoSqmFY?=
 =?us-ascii?Q?tScv0iIHF3DEHpOeMNKwh8FxCT9QWL8LWl8ST2ua9OUa3vmPGOb4fbYlEt7p?=
 =?us-ascii?Q?DB0FMB9H0UQImHZpHGTOIFkwg3VUNTC0a1LpHJ61sY0OmXY7f73MlAWi/SYT?=
 =?us-ascii?Q?rEbtlR0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1DDB6C53B9322141ACFE83815398A77E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2535304-9236-4266-4f41-08d8e6743ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2021 23:03:41.6179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pT/6qqfWF7tyQCn+rwaKdI1mUrcnN4zZh/kJM7i4AOwHkFXsPEifQj5ph5SVA0b6eLfxWJ2VmanKTFNASmKXCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4757
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-13_11:2021-03-12,2021-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103130179
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 13, 2021, at 2:06 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Fri, Mar 12, 2021 at 04:09:53PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Mar 12, 2021, at 7:45 AM, Song Liu <songliubraving@fb.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On Mar 12, 2021, at 4:12 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>>=20
>>>> On Thu, Mar 11, 2021 at 06:02:57PM -0800, Song Liu wrote:
>>>>> perf uses performance monitoring counters (PMCs) to monitor system
>>>>> performance. The PMCs are limited hardware resources. For example,
>>>>> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
>>>>>=20
>>>>> Modern data center systems use these PMCs in many different ways:
>>>>> system level monitoring, (maybe nested) container level monitoring, p=
er
>>>>> process monitoring, profiling (in sample mode), etc. In some cases,
>>>>> there are more active perf_events than available hardware PMCs. To al=
low
>>>>> all perf_events to have a chance to run, it is necessary to do expens=
ive
>>>>> time multiplexing of events.
>>>>>=20
>>>>> On the other hand, many monitoring tools count the common metrics (cy=
cles,
>>>>> instructions). It is a waste to have multiple tools create multiple
>>>>> perf_events of "cycles" and occupy multiple PMCs.
>>>>>=20
>>>>> bperf tries to reduce such wastes by allowing multiple perf_events of
>>>>> "cycles" or "instructions" (at different scopes) to share PMUs. Inste=
ad
>>>>> of having each perf-stat session to read its own perf_events, bperf u=
ses
>>>>> BPF programs to read the perf_events and aggregate readings to BPF ma=
ps.
>>>>> Then, the perf-stat session(s) reads the values from these BPF maps.
>>>>>=20
>>>>> Please refer to the comment before the definition of bperf_ops for th=
e
>>>>> description of bperf architecture.
>>>>>=20
>>>>> bperf is off by default. To enable it, pass --use-bpf option to perf-=
stat.
>>>>> bperf uses a BPF hashmap to share information about BPF programs and =
maps
>>>>> used by bperf. This map is pinned to bpffs. The default address is
>>>>> /sys/fs/bpf/bperf_attr_map. The user could change the address with op=
tion
>>>>> --attr-map.
>>>>=20
>>>> nice, I recall the presentation about that and was wondering
>>>> when this will come up ;-)
>>>=20
>>> The progress is slower than I expected. But I finished some dependencie=
s of=20
>>> this in the last year:=20
>>>=20
>>> 1. BPF_PROG_TEST_RUN for raw_tp event;
>>> 2. perf-stat -b, which introduced skeleton and bpf_counter;
>>> 3. BPF task local storage, I didn't use it in this version, but it coul=
d,
>>>    help optimize bperf in the future.=20
>>>=20
>>>>=20
>>>>>=20
>>>>> ---
>>>>> Known limitations:
>>>>> 1. Do not support per cgroup events;
>>>>> 2. Do not support monitoring of BPF program (perf-stat -b);
>>>>> 3. Do not support event groups.
>>>>>=20
>>>>> The following commands have been tested:
>>>>>=20
>>>>> perf stat --use-bpf -e cycles -a
>>>>> perf stat --use-bpf -e cycles -C 1,3,4
>>>>> perf stat --use-bpf -e cycles -p 123
>>>>> perf stat --use-bpf -e cycles -t 100,101
>>>>=20
>>>> I assume the output is same as standard perf?
>>=20
>> Btw, please give it a try. :)=20
>>=20
>> It worked pretty well in my tests. If it doesn't work for some combinati=
on=20
>> of options, please let me know.=20
>=20
> heya, can't compile
>=20
>  CLANG    /home/jolsa/linux-perf/tools/perf/util/bpf_skel/.tmp/bperf_foll=
ower.bpf.o
> util/bpf_skel/bperf_follower.bpf.c:8:10: fatal error: 'bperf_u.h' file no=
t found
> #include "bperf_u.h"
>         ^~~~~~~~~~~

Oops, I forgot git-add. :(=20

The file is very simple:

tools/perf/util/bpf_skel/bperf_u.h:


// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
// Copyright (c) 2021 Facebook

#ifndef __BPERF_STAT_U_H
#define __BPERF_STAT_U_H

enum bperf_filter_type {
        BPERF_FILTER_GLOBAL =3D 1,
        BPERF_FILTER_CPU,
        BPERF_FILTER_PID,
        BPERF_FILTER_TGID,
};

#endif /* __BPERF_STAT_U_H */

Thanks,
Song

