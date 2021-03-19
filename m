Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE28342192
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhCSQOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:14:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27810 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230140AbhCSQOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:14:47 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12JFwE3M024601;
        Fri, 19 Mar 2021 09:14:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OKJNX59rRe79m0jukG6C1blIXBm5q/rWnynk34x4k+U=;
 b=eeXH75Jm/9Y/g4xQt1o1wdkoooZwZ7ZkAsJ8dskV1y0gmREhc85iYv1sYynMMnu/Rz36
 UAfM88bjs5bJLdF7jnvza9i13evJSm5DIYCiskKQNcIfoiUifvv145J5XKlhNOWkABwZ
 GPtxL1L8gknTIBo/gUzBQ2CYh8Zx0LIq4nM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37cefucq7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Mar 2021 09:14:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 19 Mar 2021 09:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FU6Hg9GXyQeC/8l0ifFBZhefknaOmxr8uBJ9+KuW9gnIO8CGd7J4a1xCo54ODEhQ8/E8CIb+gCm8/indSiM8mDzoMIKhcqJ7r1FlWChdLgju/Is9H7mUMS4GMRZpSmbflDxjFhJ5DJ9f8vOj/ksmbF+APy+CYMCHPWkGzONYTOJki097Vq/+TgJe3I6uG376U9sxmf5cT2mZTsTv3dUdKwPV0Zl7hU1JbTEnt8YsZhAV0PQhLvWf0UqTz+w82TsUAy42OJotwjr+v/J3P192IJWLpzez70z7njz/EGcg3GmC1btpZguexIgPnx4sRDzUJtxzpW5qnR6JEXbd+TUC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKJNX59rRe79m0jukG6C1blIXBm5q/rWnynk34x4k+U=;
 b=WI/nnnjsa6MrR6q6RsioMN4svR1NLuyWcRGSj7f5x8Spnh0zZnrUpNITJdcNWpcyisVY5SgE5szhJGMOizToQ4kjWQTeMzbDdzvlY9JJZuBOodmnYmC7WRlzZdzwKGIZvrtzm4nSNjUtsjf86aNLSlnn94QobDPeOY3XOgX2/2SCVw3+nejes322u9vd89G7WON4IEGtnWYobc0o3TgFUE6RouDgA4bbpCZ2Ze6zsF5ipgirvmUhe6GJEI4OPPHESPoto7F1MjFjNj+sWydxgtl9b5hfvtrqCeJqPVHvGtItTjMqfggaqYnYOAQfFIdxiSbP7OQOHbMZPWyamaknXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4390.namprd15.prod.outlook.com (2603:10b6:a03:35b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 16:14:43 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.033; Fri, 19 Mar 2021
 16:14:43 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Thread-Topic: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Thread-Index: AQHXGqn3m2pRtlCATE6KZ0qUM3kt26qHp6sAgACBEACAAPZFAIABIw8AgAAwyYCAAAOcAIAACTCAgAD17gCAAAZrAIAABJ8A
Date:   Fri, 19 Mar 2021 16:14:42 +0000
Message-ID: <EC00E37D-8587-4662-8E30-7AD5F874FA84@fb.com>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
 <YFH//FRPvrPswhld@kernel.org> <7D48A756-C253-48DE-B536-826314778404@fb.com>
 <YFPCul51MjrlY65P@krava> <388AF530-5176-4DB9-93C4-6C302432CE12@gmail.com>
 <3E65B60E-B120-4E1A-BAF2-2FAEF136A4CD@fb.com>
 <CAM9d7ch_axD_4E0W7MEx8ueeq9QsvhxNWaJ0J3AtVgeKqKQmbA@mail.gmail.com>
 <YFTEsOhbx4Il1nji@kernel.org>
 <CAM9d7cgoP28V_ONk2AJeu=Y7RQ8vzovzW=pGVYtERe97+ZH0Aw@mail.gmail.com>
In-Reply-To: <CAM9d7cgoP28V_ONk2AJeu=Y7RQ8vzovzW=pGVYtERe97+ZH0Aw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ab65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7310148c-a655-4be8-e4b1-08d8eaf21b27
x-ms-traffictypediagnostic: SJ0PR15MB4390:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR15MB4390AB9A08BEA26A7EFA2017B3689@SJ0PR15MB4390.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Tq4nKGkEs35dkHMuLxuKwGqi33joVbQ7tGH45shb9/l8N0gWevabbrQgxUa0/jJbebeyPjUMshphC7+DpnS7EAz8irf99u/JBtUo326OS+Psdo4o0yMAkVW0pHUnFxgCrERoj4NLq1fxp/1pRcjivxL60aspmNhkGqjoUTHzIjwIRjEwBQhUPiv/wAdjxSWOeZp29jqTn5/BdaJYzlXZBf9hP4p6aY8rFp7+auUqEm6aLAjPd28uVbAfGer40+atsGNwhk5BBlVoriOSWH8WQXFaRGdfw1BP54w1EbQunn3IfCFiOaUS01thdskYoCNl6Yo97zealyGfobkqydVjhkzM4Z4JsPvoQ+AyoEmDUY3Gdu9+emjeVjCgipJX0jF//UHiCR/eg/FxjJmF+UhsxSyOZUfL8WyeChpwwJ8b9c94ZzEoWUc/PCAc5965qhlBk2RbhTBQqHih/lUnfvGqeh7/yTOOReTZz40GLbwiN0M6jEOjC0PCDEx5/x6LIHWdfGEeDkv7IcH6BDB/O6xdcJx9J9dJu/2F9W/zp9u++AfDgPN9cHvOAnwhmSVwAFsZ0WgaGuwWRJbQm3MGyJuttXJd3ZXzrWthiQyJR/Cd+U84jNyRRbFG4mQym0An7PkD8wYO24uWrPXlIq4hvI8buZnMsBuWwqm3mAJchwHMJ1fTJPsE0UcYBYfd+Yi1PCkoD9jguBw+X7/vvr3yuSJA/SvGfQdUyNG/5MXY13DDHkgPXPMona2o8RflwkTJeF1+cbne4sq1vO42tQc8Ji5Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(376002)(136003)(39860400002)(36756003)(66476007)(6916009)(33656002)(66556008)(966005)(66946007)(76116006)(66446008)(6512007)(8936002)(86362001)(53546011)(2616005)(6506007)(64756008)(478600001)(5660300002)(186003)(38100700001)(71200400001)(83380400001)(6486002)(4326008)(54906003)(2906002)(316002)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?L04zp9feQqipBi/8d4Q6MmRXCgs/xeHTOtMp5cEuW5ztpFfL0C/zkI/zuXPU?=
 =?us-ascii?Q?WAwpsJb7GIiQh6IiYKGqXvgkPzyIizeUZ5KafWAdspC4oHVSsX8RtNuTss2m?=
 =?us-ascii?Q?GTR+FiDN1PaIH4ozUmgENofWbA6gRMMSBvMWyfrJsdhSLPqsMoK9KDSx/4iI?=
 =?us-ascii?Q?pdL5k6AEljiIWEO3D72TwOzMANTPsiiDwoOk+1S8Qwha6vYdOdvjWMHtyPTy?=
 =?us-ascii?Q?cyTyGxNHnAqQBAzNt11rnuzQO+Cd5PSk0oXGM/5SrMZg+w9HJA7BAYf9mheH?=
 =?us-ascii?Q?3d3ltjuedIhyEPB+4jgrhy/WteBgdQbLD3rtuYX7RcKh+bcSL3+Qb98+2f/1?=
 =?us-ascii?Q?i3QfzTqg8fdk/wyfJQQLMizhcLp0uJqgGBJwshtlaLZbthprIbSQYHmLOFJF?=
 =?us-ascii?Q?VaffbxonBvu5lBoI39pOEXGV2K3i4evzIDbRsVQAZ8X9IAQxzVFs0yoopo1S?=
 =?us-ascii?Q?0G4c4qYzsjK2SHMWgiDRIPtHNC1enaBPavYGOQSPNDN50BGYUvpmna6c+mNS?=
 =?us-ascii?Q?VIzD3UhZ1pkSRFgyDQG47UoJZ6624hS1hIZCfX4I8gyB1Mt1HJCadPw1sReZ?=
 =?us-ascii?Q?s8hyAEltZW4VKOkSe97+UWdwstG5lrGIktdcrRdhsWHLEnEmCh4Rf7bt14nd?=
 =?us-ascii?Q?jM4/G3vpeXTnthjb9k4pAJB4uw7UzitzP9ylhOmlj/UnjunN94VqoTr/xuO6?=
 =?us-ascii?Q?iqxejyZ1n0tkfminIAUA0yi8TBw5BpvVjaFRDX3Qfth32wBDv+krBKtMX0i1?=
 =?us-ascii?Q?ssHVtS9HlQh+UmbBwLe4pXhiN5mcseKe0XF6cvWoJ1a2weS2CppEsBo8ywWu?=
 =?us-ascii?Q?mRM4TPOSNucvvoKrg3ni9hOGGStclP+VztJfco8vJTAV26ubDfdxJDp4RI3c?=
 =?us-ascii?Q?pEJLPTiE4VYA3pTndbAeVcy6dj/OO5+QqxUK8ixwJt0YXCfh319sQl8FVzQi?=
 =?us-ascii?Q?HglOJHROuvRQAC95R2cKZ1V9GsTLbiy52/OwWCD5EMzE2e0Ei4czL4rDYanM?=
 =?us-ascii?Q?tNR3kpnTWTko6aaNuMlYKruK4AWvx/JfseMUlfAIVTASzR0h+Mi6S7GGoPDS?=
 =?us-ascii?Q?uWcrUswnUDIs92RUtf7rz/9icMAx5RfBH8fl0yKk5E/e4YPLux4L/dL+tqZD?=
 =?us-ascii?Q?X/kJl/A5a+w4DApXvV1Y7r6lLJUOETGUlivrZByfiXU9un9GLxY8yhjIp5+I?=
 =?us-ascii?Q?GldLzRQE5ZMhSdKF8QWU2okjBV8pjianUtxoQfb7q5NWZ5WWg0hs9W5PVKba?=
 =?us-ascii?Q?pimomDyjABre28WKI5Xg+UGbrWr02mQ7rFhp/IWPgALvArvDais8RA4cuGk/?=
 =?us-ascii?Q?Nel/I5khd/Rd7X7QJr9TnG/IQmmrCEOpMo2Vjl4Im0CvpNVu8TCO1Lg6WzCf?=
 =?us-ascii?Q?pZqzKGA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E7857EEBE9DAD74BA01376B5EAE3011C@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7310148c-a655-4be8-e4b1-08d8eaf21b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 16:14:42.9450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYO4TERihQaTQrgX/L7og94JQ8UKJvKrvSvsjNFO9EJ2DvTKh0Lhu4Gq0S2nkYev3Q03AJuD79KcP1pdCO4o6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4390
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_06:2021-03-19,2021-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103190111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 19, 2021, at 8:58 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Hi Arnaldo,
>=20
> On Sat, Mar 20, 2021 at 12:35 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>=20
>> Em Fri, Mar 19, 2021 at 09:54:59AM +0900, Namhyung Kim escreveu:
>>> On Fri, Mar 19, 2021 at 9:22 AM Song Liu <songliubraving@fb.com> wrote:
>>>>> On Mar 18, 2021, at 5:09 PM, Arnaldo <arnaldo.melo@gmail.com> wrote:
>>>>> On March 18, 2021 6:14:34 PM GMT-03:00, Jiri Olsa <jolsa@redhat.com> =
wrote:
>>>>>> On Thu, Mar 18, 2021 at 03:52:51AM +0000, Song Liu wrote:
>>>>>>> perf stat -C 1,3,5                  107.063 [sec]
>>>>>>> perf stat -C 1,3,5 --bpf-counters   106.406 [sec]
>>=20
>>>>>> I can't see why it's actualy faster than normal perf ;-)
>>>>>> would be worth to find out
>>=20
>>>>> Isn't this all about contended cases?
>>=20
>>>> Yeah, the normal perf is doing time multiplexing; while --bpf-counters
>>>> doesn't need it.
>>=20
>>> Yep, so for uncontended cases, normal perf should be the same as the
>>> baseline (faster than the bperf).  But for contended cases, the bperf
>>> works faster.
>>=20
>> The difference should be small enough that for people that use this in a
>> machine where contention happens most of the time, setting a
>> ~/.perfconfig to use it by default should be advantageous, i.e. no need
>> to use --bpf-counters on the command line all the time.
>>=20
>> So, Namhyung, can I take that as an Acked-by or a Reviewed-by? I'll take
>> a look again now but I want to have this merged on perf/core so that I
>> can work on a new BPF SKEL to use this:
>=20
> I have a concern for the per cpu target, but it can be done later, so
>=20
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>=20
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=3D=
tmp.bpf/bpf_perf_enable
>=20
> Interesting!  Actually I was thinking about the similar too. :)

Hi Namhyung, Jiri, and Arnaldo,

Thanks a lot for your kind review.=20

Here is updated 3/3, where we use perf-bench instead of stressapptest.

Thanks,
Song


From cc79d161be9c9d24198f7e35b50058a6e15076fd Mon Sep 17 00:00:00 2001
From: Song Liu <songliubraving@fb.com>
Date: Tue, 16 Mar 2021 00:19:53 -0700
Subject: [PATCH v3 3/3] perf-test: add a test for perf-stat --bpf-counters
 option

Add a test to compare the output of perf-stat with and without option
--bpf-counters. If the difference is more than 10%, the test is considered
as failed.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 31 +++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_bpf_counters.sh

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests=
/shell/stat_bpf_counters.sh
new file mode 100755
index 0000000000000..7aabf177ce8d1
--- /dev/null
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# perf stat --bpf-counters test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# check whether $2 is within +/- 10% of $1
+compare_number()
+{
+       first_num=3D$1
+       second_num=3D$2
+
+       # upper bound is first_num * 110%
+       upper=3D$(( $first_num + $first_num / 10 ))
+       # lower bound is first_num * 90%
+       lower=3D$(( $first_num - $first_num / 10 ))
+
+       if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
+               echo "The difference between $first_num and $second_num are=
 greater than 10%."
+               exit 1
+       fi
+}
+
+# skip if --bpf-counters is not supported
+perf stat --bpf-counters true > /dev/null 2>&1 || exit 2
+
+base_cycles=3D$(perf stat --no-big-num -e cycles -- perf bench sched messa=
ging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
+bpf_cycles=3D$(perf stat --no-big-num --bpf-counters -e cycles -- perf ben=
ch sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
+
+compare_number $base_cycles $bpf_cycles
+exit 0
--
2.30.2


