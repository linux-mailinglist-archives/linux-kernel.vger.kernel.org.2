Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1988136F2AE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 00:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhD2WlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 18:41:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14764 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229836AbhD2Wk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 18:40:58 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13TMUWL2004658;
        Thu, 29 Apr 2021 15:40:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nZbW+L1PQ4+VQwbiWrk3NKL82NA5GLz/KkA2RoSM38A=;
 b=fsC+v7CCuDugibOOx5UNh932svT94Ykpm7M/XGPw1rc71cJnANmI2GKA5LgYPCyWvVO8
 PnaDcUHJrZbOgCKMnRLvKgLYd/5aLjlD0i6iIl8L5JrAXKJKyGTx6APZPOKhuz1N0akk
 xVgU6q+FUk176rwamcyq2i6SCqEt1nT5Mag= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3879ae21yr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 15:40:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 15:40:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgG+TVQW3+yM0ic8ZL2AG5Cb9JCYxAhBnBAObEOlmuhj548OUOxd9fpIzWmm9UC1+vbTSrSfcpuO8gW5j5v1WtoiN3p351R5miE51sVpAnbv8YG9KMaH9Rt26Qu5Xqh/bDu45kfkFZ0tiYyivDew+lNmJFso2o1x7xiIwdeum+dzVQzHWMBvJk8U8pwpDKsGQxQyLFpS+mXW/nt4HHnFjJKrTLWH+o/6qOU/u1T0W8gI/orhT2vy7PVa3nic8tO4RD8wAd8wXCJwyaV3GwwpbAesi1FWkZFxinUDSdlSl/8avH5blKjFSHwYNNMpOF3JLMWI347GL9su4bxQEng1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZbW+L1PQ4+VQwbiWrk3NKL82NA5GLz/KkA2RoSM38A=;
 b=VHAiDacHT4LHCI23EHP+Owc4WvvSKM3eXtJwqZaaOY/CoryS1Fk4Df3yYSTJgPB5eCUEfj+T3STGl4E5MLG9gTWGMgQxFCh1MpDR0e9ZYqTkd2HtSeoEPJVIaHvwHA/mZq/CPxbHfm/89xE+xCJoF9ZgbyJnkF4HxGFVc1DnxyhQsLwjjgLNz9DY5jcnqwIAO5NnEDIkwy2GlVijnks16WTzMt/DbXVYw78JRABsycahfxPrXsg+kbzE6oI/qnXhT+pYBLADYor/rbJWidCVRl9y5fO33wK0WYdVbxzLg8rZ1STVKC1Jvzeuv7CxrrF0B1rRPBpbMjYBFLf6z/FELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB2995.namprd15.prod.outlook.com (2603:10b6:408:8a::16)
 by BN8PR15MB3169.namprd15.prod.outlook.com (2603:10b6:408:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 22:40:01 +0000
Received: from BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::e4d6:1c0:16c7:f16e]) by BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::e4d6:1c0:16c7:f16e%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 22:40:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v5 5/5] perf-stat: introduce bpf_counter_ops->disable()
Thread-Topic: [PATCH v5 5/5] perf-stat: introduce bpf_counter_ops->disable()
Thread-Index: AQHXOhwex5gB4i62NU+zgG+lriKiJqrHUbkAgAAOWgCAAO6+AIAAdISAgANZnwA=
Date:   Thu, 29 Apr 2021 22:40:01 +0000
Message-ID: <7DBDECAE-D100-44C0-B5D3-DE48631430B5@fb.com>
References: <20210425214333.1090950-1-song@kernel.org>
 <20210425214333.1090950-6-song@kernel.org> <YIcwRj4WtsZln4SR@krava>
 <CDBE5630-F7F0-494D-BFA8-33742D831C2D@fb.com> <YIgElir6KJCoygX5@krava>
 <5257A59A-CC47-4CA7-9C15-CD6E20DC4BD0@fb.com>
In-Reply-To: <5257A59A-CC47-4CA7-9C15-CD6E20DC4BD0@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.80.0.2.43)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:c8dc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ef9b241-ccfd-452d-b269-08d90b5fb98e
x-ms-traffictypediagnostic: BN8PR15MB3169:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB316915BA2597F1AC7CFE1304B35F9@BN8PR15MB3169.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eIp7m2WegDXi14+LqPYl0BX+K5TXQL2Qd/dqVkyekZqHQBFsVVvzIAkwuitAE3sRr5vN5+GF5sted20BqIPUyAhZie4YNFZaR3oAyYwpsP/tF2NesBMVv11bCHmtlhRTPyByzgbUIOPBH1D2LNekpD34MuijRUgbsklQxedkLR5WS0kNyRDOJaNStIXTUPA7i2ItvVTLu4dfJj2EyHBu4XiSEZx3nmJx+Zfge13DIRfv1KLoJsqdzXd4F6fufr3Y8fs4Vt0oOnpJ7hXWU7bbj/GyLL47Gv/t8jMltP4MSxlxUzTaA2BiecfS/Yy1vMm9QXF2ec5RlWXNQiit9mp5ThKxXCc/L9Ye860Yf1+IrsnNHIlqqTj0TPwMn9lUtVm9nwS+A3pljMI4uH2Uz7HRydsju7eamTLVK0yhKHZ2ZXd6eM12uiKvO5tEcewrCckjFvUDzChL7Kn9jHKarm/D3UhzUpRF+ScDumeO/bxycW6lETGMsZduosCEu4dHlX/OE9TOsjJ7ZGUG90Ol0BxnhG8fB2HH/laTW0sXd96BJqqpPP7ets2OGkNSptubYDdPsYNi4KdAtIDtmwf7nae7y2njWoll/Aj0fHHMZXBib93FYii/re/ErdXKnJdSy2N1n6CjxvpNUwds6cNb8fgHzi14jHjhlmu9IPdZSOrETGU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2995.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(6486002)(478600001)(54906003)(71200400001)(86362001)(6916009)(316002)(5660300002)(38100700002)(53546011)(6506007)(2906002)(36756003)(83380400001)(33656002)(122000001)(8676002)(2616005)(91956017)(6512007)(186003)(76116006)(66946007)(4326008)(8936002)(66556008)(66476007)(66446008)(64756008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FRAcFNra7muFYcru2ngAGy7TVPn6QQ5/nB2iXkb047qn7ek+h/CePzdyXq8t?=
 =?us-ascii?Q?KfLvLzzorp2CtdbCeDO3cS2QBORtaF0SJYpvcl54Y1jP47AQF29jFwmT3uk9?=
 =?us-ascii?Q?OmNa+aOpYmEHR/5lWL/GeLHdMeSKl3X42Zr/2w0zmhXP3jEjMmKG/UaK0JCp?=
 =?us-ascii?Q?P9UYZQfmwcENzWhnYgisSdF7ahnzitgDqwp0b3Hm6D4vkQ2UYL0e0Hle3KWh?=
 =?us-ascii?Q?4D2zK2MrR7TZ+Zx0KdBtvMolIUe6oDoACuRgxtjTFy/O7ut0VbfSbjGmjV4g?=
 =?us-ascii?Q?KnuTgdIPN3oG3p+gvsoqkzTSYfJeXN0pfEy3XaKXQ1oU16otcd9EyKUMc3Uo?=
 =?us-ascii?Q?C39jTBwijFkrJ2/URd8J2mJZ8nc4AUyvgx6Gm2LCReG2vKyk2HF2PWqebKt8?=
 =?us-ascii?Q?Yk/gzkDyopcP5/qWykGbW1ilSNzvlSu5FBso+ZaRPIsFwlXFYzXmdueza2Bf?=
 =?us-ascii?Q?YE6WbngY1zfHqfi20AXO2g4wVlae+UQYm14ICsyujOQkv1uytaaC1LK+WSJ7?=
 =?us-ascii?Q?6mTC8Hqdkl1mSx9IcvKqzH2ZCfL3HCyHAO4n6mNEF1zUdEa1tKzrtGGGMDbZ?=
 =?us-ascii?Q?mzQVObV4XJjDzNXkE7+GE9bPirIDNijPPLYd27GgaS9zqdhO8E6jY20C94Cc?=
 =?us-ascii?Q?9/3kuotsMa3jPgK7m3ewLn9IV3JT7X3X847afK52yobjiQRpXUBuhLq7mt8W?=
 =?us-ascii?Q?MIJgD05e52RywyM7tfIuiiP78HboruR0blYFWbNqXuEsRzRHWvrNUWvCBazr?=
 =?us-ascii?Q?QqDrq/SPi7v/dlxADxl0H+NiAI9RTsUQ+IQr/eREW2ntU/BixYmJlp+sBbAM?=
 =?us-ascii?Q?+L9KbGznRSGq8bwWcc6r2JOnX1CQqAQ/NyMUzmyMtzEFdjwj2nKAlZDFGVAI?=
 =?us-ascii?Q?4OvgVQskon4xgBevoZDz8u0IPFR8HRAtLd7XLSldtt/6BnPyWdXrHl2+S13I?=
 =?us-ascii?Q?/1AbiMWZpY6TAgXHc//X3sFUXv+vQ8pTiXWAh4Lduv6mvDBsw8jfQ+9b1k5M?=
 =?us-ascii?Q?RhFWx0vB7p/gXcNrJdfHRPCzguBV0Ie7ebK5GBdBo0kmqntTUSLiYZGW82KW?=
 =?us-ascii?Q?sZZaxRhTLLnoh34vkY/FCft7F6cCz2rNcORg9bGvFg2WWmiK0R5fuRY8CosT?=
 =?us-ascii?Q?yi/x03QI6l/xcV9OJ1g8LHsVJeB+RlNAFFzV4IH90PbMRuKGqpswaotPKYSO?=
 =?us-ascii?Q?IAcU6sXKSzG39T+fwmPONfncRUUuEo998qP+TWD42MWbqjTZ8NxACfbJRR7X?=
 =?us-ascii?Q?sTA3EsMfvq8qXpFtUyR/+fZ/Bm0WuG9wuDW0gzVYbr1p716RK/dKrdzHrusx?=
 =?us-ascii?Q?MGpvHwNL3tRVqj9aaVgP+b8Tq4fok1eE8fx6YaVgLr6zPPUiyh8Fj1A4UZSz?=
 =?us-ascii?Q?E8twxK0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D467AC954697C948B5210CAF609838BB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2995.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef9b241-ccfd-452d-b269-08d90b5fb98e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 22:40:01.1341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6FhNU24YHoUnf00AbDEH1eAcNZc+v0OseqhSgQBCBcmMQomRPA68U9xkklQ+QHQMx6hADUuXLk6e1y8EkRB9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3169
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: L054yL6uRi_11SuLHaPKf63aIr3AabqX
X-Proofpoint-GUID: L054yL6uRi_11SuLHaPKf63aIr3AabqX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_13:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104290143
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 27, 2021, at 12:30 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Apr 27, 2021, at 5:33 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>=20
>> On Mon, Apr 26, 2021 at 10:18:57PM +0000, Song Liu wrote:
>>>=20
>>>=20
>>>> On Apr 26, 2021, at 2:27 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>>=20
>>>> On Sun, Apr 25, 2021 at 02:43:33PM -0700, Song Liu wrote:
>>>>=20
>>>> SNIP
>>>>=20
>>>>> +static inline int bpf_counter__disable(struct evsel *evsel __maybe_u=
nused)
>>>>> +{
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> static inline int bpf_counter__read(struct evsel *evsel __maybe_unuse=
d)
>>>>> {
>>>>> 	return -EAGAIN;
>>>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>>>>> index d29a8a118973c..e71041c890102 100644
>>>>> --- a/tools/perf/util/evlist.c
>>>>> +++ b/tools/perf/util/evlist.c
>>>>> @@ -17,6 +17,7 @@
>>>>> #include "evsel.h"
>>>>> #include "debug.h"
>>>>> #include "units.h"
>>>>> +#include "bpf_counter.h"
>>>>> #include <internal/lib.h> // page_size
>>>>> #include "affinity.h"
>>>>> #include "../perf.h"
>>>>> @@ -421,6 +422,9 @@ static void __evlist__disable(struct evlist *evli=
st, char *evsel_name)
>>>>> 	if (affinity__setup(&affinity) < 0)
>>>>> 		return;
>>>>>=20
>>>>> +	evlist__for_each_entry(evlist, pos)
>>>>> +		bpf_counter__disable(pos);
>>>>=20
>>>> I was wondering why you don't check evsel__is_bpf like
>>>> for the enable case.. and realized that we don't skip
>>>> bpf evsels in __evlist__enable and __evlist__disable
>>>> like we do in read_affinity_counters
>>>>=20
>>>> so I guess there's extra affinity setup and bunch of
>>>> wrong ioctls being called?
>>>=20
>>> We actually didn't do wrong ioctls because the following check:
>>>=20
>>>      if (... || !pos->core.fd)
>>>               continue;
>>>=20
>>> in __evlist__enable and __evlist__disable. That we don't allocate=20
>>> core.fd for is_bpf events.=20
>>>=20
>>> It is probably good to be more safe with an extra check of=20
>>> evsel__is_bpf(). But it is not required with current code.=20
>>=20
>> hum, but it will do all the affinity setup no? for no reason,
>> if there's no non-bpb event
>=20
> Yes, it will do the affinity setup. Let me see how to get something
> like all_counters_use_bpf here (or within builtin-stat.c).
>=20

Would something like the following work? It is not clean (skipping some=20
useful logic in __evlist__[enable|disable]). But it seems to work in the
tests.

Thanks,
Song



From ecb75a1fa747ca5521bcda972840df1e97c09b11 Mon Sep 17 00:00:00 2001
From: Song Liu <song@kernel.org>
Date: Wed, 28 Apr 2021 17:41:28 -0700
Subject: [PATCH] perf-stat: skip evlist__[enable|disable] when all events u=
ses
 BPF

When all events of a perf-stat session use BPF, it is not necessary to
call evlist__enable() and evlist__disable(). Skip them when
all_counters_use_bpf is true.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/perf/builtin-stat.c | 12 +++++++++---
 tools/perf/util/evlist.c  |  3 ---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5a830ae09418e..44459e0352fda 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -572,7 +572,8 @@ static int enable_counters(void)
         * - we have initial delay configured
         */
        if (!target__none(&target) || stat_config.initial_delay) {
-               evlist__enable(evsel_list);
+               if (!all_counters_use_bpf)
+                       evlist__enable(evsel_list);
                if (stat_config.initial_delay > 0)
                        pr_info(EVLIST_ENABLED_MSG);
        }
@@ -581,13 +582,18 @@ static int enable_counters(void)

 static void disable_counters(void)
 {
+       struct evsel *counter;
        /*
         * If we don't have tracee (attaching to task or cpu), counters may
         * still be running. To get accurate group ratios, we must stop gro=
ups
         * from counting before reading their constituent counters.
         */
-       if (!target__none(&target))
-               evlist__disable(evsel_list);
+       if (!target__none(&target)) {
+               evlist__for_each_entry(evsel_list, counter)
+                       bpf_counter__disable(counter);
+               if (!all_counters_use_bpf)
+                       evlist__disable(evsel_list);
+       }
 }

 static volatile int workload_exec_errno;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6e5c41528c7d0..6ea3e677dc1e7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -425,9 +425,6 @@ static void __evlist__disable(struct evlist *evlist, ch=
ar *evsel_name)
        if (affinity__setup(&affinity) < 0)
                return;

-       evlist__for_each_entry(evlist, pos)
-               bpf_counter__disable(pos);
-
        /* Disable 'immediate' events last */
        for (imm =3D 0; imm <=3D 1; imm++) {
                evlist__for_each_cpu(evlist, i, cpu) {
--
2.30.2

=20

