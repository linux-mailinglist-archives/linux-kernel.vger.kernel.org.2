Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB0D3B33CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhFXQWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:22:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56842 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231432AbhFXQWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:22:48 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 15OGGi3o028082;
        Thu, 24 Jun 2021 09:20:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JA55uHXnkVpYwVy+kNopXSRyR+BccuEOvh7s2tR8vug=;
 b=SwajXZ/n2aRLSGK1Kz3fNYknkvXlc7vWP7p+O92+kdN4WOlhWWHPsGDmgfTvHm4146Fo
 OugUNYxA/2829zFTj+S19S4HANp7BHQfPUzfg9l3ZugqBQYDLF/Fh/iLF7LEFOk30F6T
 8MDLOAvjuLVvr91IC360OutpGNaRZU7WQPI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 39cswhhnsd-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Jun 2021 09:20:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 09:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A27iSRSix2ZEMmoM3bUNKVlFMpV9vk6Jy14iEyMhRuVGr2A3M0gEB3Rd3oZuivUC/1vZpnaPjEtyRf+Ea9LhDxopddbzGZ+LVU8YtxcvWjrBv8znkkdJm4FMtxQDO6Vnqk11pvqUhYcO7VgFjRb0Wk1OJniS+26nWj0/zCWRnV4pHnIOHY5CLqLpkdIP397LU537lwOk+O4WFcrEAqM3q3DztEOKjVXLp24Q/a2Qb+bjdYJD4dnXRTsSIsUeLirphv4EDgr/RJzOtRet7z++rc4XpS9yb35nnPiVJcvC86qJRFIWdkGENZWbl1AFCuPLz47xsXIMcDtxcfwYiReD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA55uHXnkVpYwVy+kNopXSRyR+BccuEOvh7s2tR8vug=;
 b=e3kT51jM0pCwXZVyosMCEggCCcEaf2FnaY8gYMwCOTssXJ0pKFjH1SvQj/UvgfAJpcGWzvemwjaIG7ZBgZfr/Kxq8fdFqzLE0MicB62jdWty1TceTnYN+RQZrnVVsDzMzlCucFsOxodY2k/k59ZHL5Da+2KRowPcDFZdaSFOjB3OBCe6PDY7pK4WKG0h6GIGwoSib70iZOfdjBzFWgUNuS73OijNuSux40seH0GfMqVk9Q4mjJHkEVyTSFtPGrRAVfj4HE39rOsDZMGuBMRHbmGHXuoH9crEimNDNXGyJj3kxDZE71KXdqPEOpGfjCVuRjjVfXUuVX/1h0bpJ7ueeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4245.namprd15.prod.outlook.com (2603:10b6:a03:106::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Thu, 24 Jun
 2021 16:20:07 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a%5]) with mapi id 15.20.4173.038; Thu, 24 Jun 2021
 16:20:07 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/3] perf stat: Enable BPF counter with --for-each-cgroup
Thread-Topic: [PATCH 3/3] perf stat: Enable BPF counter with --for-each-cgroup
Thread-Index: AQHXZzX6p6bVUgsBlEW05HtuW1Dxiasim4OAgAAPYICAALBHAA==
Date:   Thu, 24 Jun 2021 16:20:07 +0000
Message-ID: <D5859F92-8AB6-4327-9D5F-A67DB14CB493@fb.com>
References: <20210622071221.128271-1-namhyung@kernel.org>
 <20210622071221.128271-4-namhyung@kernel.org>
 <C2ABEEDF-04AF-4AB5-BA6C-C8AC5E8579C6@fb.com>
 <CAM9d7ci3kS+=ObL_mfx1Qi2rQ7SYRjdLQLJ5+SVmRUsaUepj_w@mail.gmail.com>
In-Reply-To: <CAM9d7ci3kS+=ObL_mfx1Qi2rQ7SYRjdLQLJ5+SVmRUsaUepj_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:cce7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb9b5625-db96-4df2-8a37-08d9372beea1
x-ms-traffictypediagnostic: BYAPR15MB4245:
x-microsoft-antispam-prvs: <BYAPR15MB4245936761A4ABD076AA9C78B3079@BYAPR15MB4245.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eYkBN/AGncxFC6Cv5ZarhPVKpXak8QmHwuFYMhLp3nAmQ2qgEE6Xe5hHgr8JBUL7fTHn1cTlmW5CUYvSRjInwjz5gfvRR4j3Xnb9H+IzRo1eBFy1p5fYZt093t0NQH4+RNNUVZpd8KmeF/qmsaPJmxj6dSjq0FiXar17h7htd9OeUtuDKoVoSZBLmjT6rJPCuadOF6IWimhud+V88Bni5Y36evtkvlIJiQ/xpx6q6fGv2J4LbV/iMMHF+Si3hCYa4oaSnrlDLIDG3QzHPNORbsPHXfUGhlHaNhMEgMcoofXGxTW6Ed2ZhgtSvAYdXYNMa2JKw2fEQqd7aHFzQJiGWw/S0Vt23V3i4Lpfqp33SIYxBAmaTbAVVxxO9InSX4P1U4TckEqnNdSzLC2XkrB0oaMnM85ojP1VMXU4bqL/krxHfDHQcFHE/+JDuN7Zgil5CzIdyrZbofmRu1b+ftq8j8Sc0LDkjV5+XM6GtoHQU5dW5lTZ9y8/aeRw/ktaP0T/9dyc5G+LX/Y5yMTcoAo8hkpbMvlcRx6U94a6nHHZ/L61tUXP15NucHTZW58yT0ljiRURoLBlV1tBEHcvikLyUfuG6+Iuyj/17HNbK5zWoWU20d2sLGAm6PhKFWefcVyhwfECrcCLwhhAg40MYCEXr2vpfAxyBTSqTiA5GCFCiDM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(83380400001)(122000001)(36756003)(186003)(86362001)(53546011)(6506007)(38100700002)(4326008)(64756008)(8936002)(478600001)(2906002)(76116006)(33656002)(66946007)(54906003)(6486002)(6512007)(6916009)(5660300002)(2616005)(8676002)(66556008)(66446008)(66476007)(316002)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YI2BUmKR+M0htM7iUDQlVQWs/m67f2IYyHIhUIQDpxeLVjZhNrVrvyZy7dB7?=
 =?us-ascii?Q?kKBPK7wHiq3g4CoyPOZjlKe1gRr/u5evKNIWBFOt/AdRQty7ZTPq+0/KiEDK?=
 =?us-ascii?Q?Tt7PljdSaIyBnZFUxyYqvsScOs60VpO5X9DsSS1ii0PjLt0hDz7gD0n/o3al?=
 =?us-ascii?Q?yV+Qc36zZbmxJ2GCjYJiQS/L7uzOeW9TI8Z3chah8weA1FSg4v62GFdB8Cys?=
 =?us-ascii?Q?XMT6rqwswkK/2PGgODCay9nsHGnif50LbCBHRgN4Y82Vmt1j64N7KjsDxMq2?=
 =?us-ascii?Q?6ob52tHDP20znQISF12L9rHGIg0DTg28KIUWtbJ/2IdNuS9oEmKe7PH7e0IW?=
 =?us-ascii?Q?qbtbT7MTO30f9OiqP9sbYa9fBcncq2Thp44JYfcUbAQ820zOnUKbHO3d+A1b?=
 =?us-ascii?Q?C/iS7Qoqy0/MDNXvSUxqoh3Pwq8lNcjfZOfI63R4IH0egaRAr4YhkS/hDKdr?=
 =?us-ascii?Q?werxv2J4cCEpYPsrcqQKqKrOlZkWRV0OmOkzxmAzRXD8as6IyQ7cXZoAK7r8?=
 =?us-ascii?Q?RJfMABZqk+d7IfseayONuDWAas65B9lxzBWb9+5z3CkYA8oPgBgS9n8nccDd?=
 =?us-ascii?Q?bf70RVxwPL8DcR/8cIbTUnduf5/ZLIxcpWtgvc5HmwotGAee3B8y4sZUHhy/?=
 =?us-ascii?Q?d7FleX1gMmT/K6xdKE60l1oY3J52nFP1VaK3wxtgwYrzWEhkv31vTxEnMoX+?=
 =?us-ascii?Q?5YvC1K/M9g1uluCtptUJExc+/xgcAOfqyd5ePAbkfz3D3K0A/+CjNbljW1TS?=
 =?us-ascii?Q?MoEbZCKMGNxhgXcnAi95O4CQqn64Myeg9SzzH11daBgeGVhD8RRoc+pGutkg?=
 =?us-ascii?Q?1U4pdDt2rYquJO0PUotDjftuGEoRF9SSGR1/xWpeU627EFHG/UAtSg4BWFRc?=
 =?us-ascii?Q?zkgGeBAZRnguoHySLgN0IvUEEWGWcuFejFcdw7WSBJK2ICR+XqtI2YzdDtDj?=
 =?us-ascii?Q?AwC5kcjlH5pvkgvaYMasZc8rEh2QNmiuDDV0ej1tcELHaNjuQgLo5KIA4kie?=
 =?us-ascii?Q?y6i7yWVBprZHC42Q/9QzVioqJ/7Gvh7NeSyBl4Oglc1wjJDjACNKmjzYmkVf?=
 =?us-ascii?Q?ZM3MhPAOcOpw/VpZOazfOkPJ5EqZi7Ri+QtxDTQa351UmX7vwSfxd1vbe0/a?=
 =?us-ascii?Q?QS04Ep4//1xTXN8p15z1/K9xaSfwVH87OJOOZlQ+UsNYyTYWgRl2e2A/Yc11?=
 =?us-ascii?Q?D3ao2KGxA4CjEaIXh7/wFjlcZZshJjig7PiyFdUa+lp1eXiREtODIhQEnci0?=
 =?us-ascii?Q?DUVPAQJFK0A/JkLv84+QXo+EayO6SrGGgFibnyGJ5Sa2+G2JRG9GYBOZh0jM?=
 =?us-ascii?Q?WlDzjvfd8XbSGP+GBPvZec0oUTLToVsdZSBqeVI0uAnDIfBJd1A/v3J2D958?=
 =?us-ascii?Q?mupan1o=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF421F0FF51A574A81A921D7D4B642D4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9b5625-db96-4df2-8a37-08d9372beea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 16:20:07.4732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+qGC17smtDQIZYqUWEVsCjytqujg+M8TjHBELWRA2Pqn9uC/xtFs33fF+UlT7aSyoXyR6SV7TwpyQ93Ud/Hng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4245
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: USUPirQ3Ha-p3inTwYz6OpewojoCCE8L
X-Proofpoint-GUID: USUPirQ3Ha-p3inTwYz6OpewojoCCE8L
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_12:2021-06-24,2021-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106240091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 23, 2021, at 10:49 PM, Namhyung Kim <namhyung@kernel.org> wrote:
[...]

>>> +
>>> +     skel->rodata->num_cpus =3D nr_cpus;
>>> +     skel->rodata->num_events =3D evlist->core.nr_entries / nr_cgroups=
;
>>> +
>>> +     BUG_ON(evlist->core.nr_entries % nr_cgroups !=3D 0);
>>> +
>>> +     /* we need one copy of events per cpu for reading */
>>> +     map_size =3D nr_cpus * evlist->core.nr_entries / nr_cgroups;
>>> +     bpf_map__resize(skel->maps.events, map_size);
>>> +     bpf_map__resize(skel->maps.cpu_idx, nr_cpus);
>>> +     bpf_map__resize(skel->maps.cgrp_idx, nr_cgroups);
>>> +     /* previous result is saved in a per-cpu array */
>>> +     map_size =3D evlist->core.nr_entries / nr_cgroups;
>>> +     bpf_map__resize(skel->maps.prev_readings, map_size);
>>> +     /* cgroup result needs all events */
>>> +     map_size =3D nr_cpus * evlist->core.nr_entries;
>>> +     bpf_map__resize(skel->maps.cgrp_readings, map_size);
>>=20
>> We are setting map_size back and forth here.
>=20
> But they are all different sizes.

Right. I misread the code.=20

>=20
>>=20
>> [...]
>>=20
>>=20
>>> diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/u=
til/bpf_skel/bperf_cgroup.bpf.c
>>> new file mode 100644
>>> index 000000000000..6d74e93dd1f5
>>> --- /dev/null
>>> +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
>>> @@ -0,0 +1,207 @@
>>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +// Copyright (c) 2021 Facebook
>>> +// Copyright (c) 2021 Google
>>> +#include "vmlinux.h"
>>> +#include <bpf/bpf_helpers.h>
>>> +#include <bpf/bpf_tracing.h>
>>> +#include <bpf/bpf_core_read.h>
>>> +
>>> +#define MAX_LEVELS  10  // max cgroup hierarchy level: arbitrary
>>> +#define MAX_EVENTS  32  // max events per cgroup: arbitrary
>>> +
>>> +// NOTE: many of map and global data will be modified before loading
>>> +//       from the userspace (perf tool) using the skeleton helpers.
>>> +
>>> +// single set of global perf events to measure
>>> +struct {
>>> +     __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>>> +     __uint(key_size, sizeof(__u32));
>>> +     __uint(value_size, sizeof(int));
>>> +     __uint(max_entries, 1);
>>> +} events SEC(".maps");
>>> +
>>> +// from logical cpu number to event index
>>> +// useful when user wants to count subset of cpus
>>> +struct {
>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>> +     __uint(key_size, sizeof(__u32));
>>> +     __uint(value_size, sizeof(__u32));
>>> +     __uint(max_entries, 1);
>>> +} cpu_idx SEC(".maps");
>>=20
>> How about we make cpu_idx a percpu array and use 0,1 for
>> disable/enable profiling on this cpu?
>=20
> No, it's to calculate an index to the cgrp_readings map which
> has the event x cpu x cgroup number of elements.
>=20
> It controls enabling events with a global (bss) variable.

If we make cgrp_idx a per cpu array, we probably don't need the
cpu_idx map?=20

>=20
>>=20
>>> +
>>> +// from cgroup id to event index
>>> +struct {
>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>> +     __uint(key_size, sizeof(__u64));
>>> +     __uint(value_size, sizeof(__u32));
>>> +     __uint(max_entries, 1);
>>> +} cgrp_idx SEC(".maps");
>>> +
>>> +// per-cpu event snapshots to calculate delta
>>> +struct {
>>> +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>>> +     __uint(key_size, sizeof(__u32));
>>> +     __uint(value_size, sizeof(struct bpf_perf_event_value));
>>> +} prev_readings SEC(".maps");
>>> +
>>> +// aggregated event values for each cgroup
>>> +// will be read from the user-space
>>> +struct {
>>> +     __uint(type, BPF_MAP_TYPE_ARRAY);
>>> +     __uint(key_size, sizeof(__u32));
>>> +     __uint(value_size, sizeof(struct bpf_perf_event_value));
>>> +} cgrp_readings SEC(".maps");
>>=20
>> Maybe also make this a percpu array? This should make the BPF program
>> faster.
>=20
> Maybe.  But I don't know how to access the elements
> in a per-cpu map from userspace.

Please refer to bperf__read() reading accum_readings. Basically, we read
one index of all CPUs with one bpf_map_lookup_elem().=20

Thanks,
Song=
