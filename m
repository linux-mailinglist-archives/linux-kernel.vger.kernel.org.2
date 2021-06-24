Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112463B26A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 06:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhFXE5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 00:57:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40322 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230392AbhFXE4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 00:56:49 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15O4rQBw014567;
        Wed, 23 Jun 2021 21:54:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Vf7Q48AAZ9LwEXSFESWz/6EY+72owziL0QshIlqU46I=;
 b=EJIOBRwuPWex2pjz58XkfnphjvYjFoYCL05ReZAFLyrETkBGgBs+xi3u727lguwc7THA
 1lXHPnMqlfcmSSDAMp8JYbwPUI4VVBfrK5evY2w4LO/jeFrsz1Kj8URPvwMJ0ydTYKv+
 tXPA4nX+JdeIhi+lDjm/hw3siRPSw+GaiR4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39cbpuanw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 23 Jun 2021 21:54:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 21:54:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6KAcnG0L8uv3ZtVw624lPGEFnQndiHig1z3hKuIp/nOPSvUVqt/X3Is0f9Zcn5n+d4VFAYXhj8qjBpHuGmhvD35a+29IZgl5XhD6eqmx+d4TaQKQfawQQYw+k2mqHwhM2W8IEPVZET+/iAmUcnokm0lxbsQnrfSbXMW5954yE+s+r4aZNXB9DoLdc4l5XXlzGwatF9DtfGDvTuewg7KxnbeEIrKrImlK5Lh34gev+JUeGPT0cq1WHkmaYbQeIAUSdycEw+7cIgca5WEG7gRFn0+J99fa+3d6aMcis+RooegLbK2H3ICi3Um5kHhJrpbSpX5FOIKHBahSTThgV3UFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf7Q48AAZ9LwEXSFESWz/6EY+72owziL0QshIlqU46I=;
 b=oW+6goV39lCStf0vAonh6msmz9rHGUhd3qRmoOa5zm/r4J+gMSYjOQZ0mrQ/803O1SuYnuxW5ycNzuZvcpx/6k498Fl/Hj1lEedtE2kj80ZRSqNmDwCOBqYm6XjG/k68/IMIde26BfJfX6ebUxh6OQqtp/ZthpJVw91gLwZ9TYzYJ35rkQMGVGPSQNylnGTmA3LvyC/yyMJ0ka7CEilCfuhZcRNfYgivXNh3vUMTH34AAJcz3RjdZrSD22H2w07ENlui97/5t5MwFmHKs88dbBF5y/r4DFZV2ETYlwYHFPRQZ9o69hYS+sLKQGv+XgpHIoL6PbpOD0Ng8uAv4hJhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Thu, 24 Jun
 2021 04:54:11 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a%5]) with mapi id 15.20.4173.038; Thu, 24 Jun 2021
 04:54:11 +0000
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
Thread-Index: AQHXZzX6p6bVUgsBlEW05HtuW1Dxiasim4OA
Date:   Thu, 24 Jun 2021 04:54:10 +0000
Message-ID: <C2ABEEDF-04AF-4AB5-BA6C-C8AC5E8579C6@fb.com>
References: <20210622071221.128271-1-namhyung@kernel.org>
 <20210622071221.128271-4-namhyung@kernel.org>
In-Reply-To: <20210622071221.128271-4-namhyung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:cce7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79b1cfa3-3218-47de-f9a0-08d936cc1b79
x-ms-traffictypediagnostic: BYAPR15MB4119:
x-microsoft-antispam-prvs: <BYAPR15MB41194F2B265D296873CFE658B3079@BYAPR15MB4119.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kAxSnWaGtQYcm+s4trb8SaxBtd8t/ED2ZSYAt4dqQaP3gOM8jFf/g+iVl1tYe2Yo9JehX5EPFER5SILEce5oVlJvbHU4S19l7IX5pD7a/HY1ofvq7SdWP6WsGWCk0fqVpclYeiHITHUpzR2+ETa0GNG7BFRN0OlndIbKJA2pdj7WCQzuGX4dI/7wn7JMFcfTZwwmT/dFoW0JtDSxiHM4c7Uul5se/h+nnkM2gSGp7kVEkcADD5HmKeD48O77KHhOrD2zqjE5zFze82SaEEhxdBCltXQXTSgB5z8IMuTyjeeT1SH+UsF+9FSR5F5XzCM3uHTqedgZ9I97TekmmFRCT2T6Q8rjlPPwMK6V3eI8kBe614jJCfFzrAfYSNVs0NX8L8airg49fd4nTrC3VBztZzpN3zB4wx04bUZSS7eY4BvbQhjhe61MxHlt/DNSAgciP1iiIZM8luzQoeI4G+TESg7WJwY0I1kaC961WBQ+Pk+MDWORjooyDAKAHypyt7RqcpA0Z+7rvymJvp6u95o0m+3Qindzr6oyHdW7d6cPxaZ1/EmLeuuYrqhRhNcVUFGHn+uYR7Ceq+991+LniFPEAuH4v/ljA75yNXJarqkJk+lZZg9Q58Yvab2Uk1i7i20JZ9aSocCVN9xx1wn4E1COdpewCDpQtQwymAvMhc9BXaA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(33656002)(122000001)(2906002)(8676002)(64756008)(38100700002)(316002)(6486002)(53546011)(8936002)(83380400001)(186003)(6506007)(4326008)(71200400001)(66556008)(478600001)(66946007)(2616005)(66476007)(5660300002)(86362001)(6512007)(36756003)(6916009)(54906003)(66446008)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VbPTSwiqZIvV4J/OwQTDfCc4W4rbr0FquWYP7HSCgtE1+qbeEHQEwGEJ/hws?=
 =?us-ascii?Q?cpNpIM6LpS744VIKbaNh6xGLuHJG5b7WYxEKhhg/Lf+BSo5ZgJGk2QchkCX0?=
 =?us-ascii?Q?XPWJjMxObnmRhpjavl/bNs+Q+iBYC37Z6UaHvr6SdivctwYem1+cjKnF238m?=
 =?us-ascii?Q?zQq7B8F48m25Bg2nG8LuGcDutwcyKJ8K358leKVm9AEjsFEpXnnKnhkE0pHt?=
 =?us-ascii?Q?ooCAiMnEqtX4+aMgUbfr/Ib4v0MdwyscWr0wLgwro7dIko5bxWI+PkngUIag?=
 =?us-ascii?Q?2ffa5gcL4eVg+zTNlyt47n6doMAqqrYu8c55XY7xr7Bwibvy1YNb+yn1ajqd?=
 =?us-ascii?Q?m17Nh1MpIrj1Zzn/9muD3Brv9WiOL0DNeGoxQ61hBAqCr+h5SHPVzuu50KKX?=
 =?us-ascii?Q?HGgLhKznX3kapQNFPAV9mcbyLWdpML4AtWf2Siy55jzsiVAEor3q/WV6G85x?=
 =?us-ascii?Q?V7faaca3kLyh7MU5VGUR2lABZRIG0A5D50l8KJ8rytRa/wihMNQkL7Ikh+S0?=
 =?us-ascii?Q?qnK5Hz8RgNWl9JzkaCt+JdlL7EpHf+E6+J3bpiQOWOZ8F16e9Z5jiWrm2D8P?=
 =?us-ascii?Q?rXuZ5Lo1OAk5tAGCp+BBPr2aj9Pe6m4dglE6W+SfbItYy0pC9yRr1VPsrhRN?=
 =?us-ascii?Q?Ha8Pcbcb5Md9+tZ5Cnu6wqhDLCx9D6+74W4Cl9iXvXT50twoiz7PfMsustjm?=
 =?us-ascii?Q?Bxw+PDN8+fkKHssHry1b4AtndSAuvA85Yl6BpUqTuX/WCJZ5DWIKOWQS/14N?=
 =?us-ascii?Q?uer5uWYXatWfV1c34IW0Gh9tLsFQc9v0lRgyeig+RzpivY7R31zCtQXKs9wb?=
 =?us-ascii?Q?8RR8LL77WSaOGZJXM5MqsPFsJDt7R8opi2myKYgLlM/p58OqAgIu/kPJuj6c?=
 =?us-ascii?Q?edhh4nLMS1v2aEIDfcZhmz21tGWBAdfmZVqR0ttTGC8obGuacFPj1iZXQeKd?=
 =?us-ascii?Q?pi4OLSRibRuDwm4H6Rj0SAc6di4H8MD6oHTKrgU4IJmvWAMufKFFlJzx48ZG?=
 =?us-ascii?Q?9f1xEaZrt1eoP4qAXciI1DqfCZEhYrFFm6pxT5Vl4VuUQ7cdHAHzHi9QO1pm?=
 =?us-ascii?Q?JqOKhiDMRiEmCw0ed3n9x61j7m2ngKra3FZaFgLLfR/gabjEQRYk2GsYDqlC?=
 =?us-ascii?Q?b8Ou0rysQ+Pbfo+EuR0VdlOwC4i0jtAafk0C7ACxpLmsWhJY5l1ZWWDUX+OP?=
 =?us-ascii?Q?vZU10ADO7FjdimEh6lySv8o7RzYAKQ+xajGmnjMXUjD3+etRaaHpOII7j58D?=
 =?us-ascii?Q?FEYpFHdn0I6Sj99M7kUYEBj3CO2rzfS9qCIb7UTP3FVC3svgpB4kGL7MUtqS?=
 =?us-ascii?Q?Hi1SesBD84fyL18I9KCJo9/dcGiOAWIhn8y9K4tmMYlKPbjh6AeXcf0/fZxv?=
 =?us-ascii?Q?SQBsgzw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2B7CE2AB57E3D445B60D75895BDB4CFE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b1cfa3-3218-47de-f9a0-08d936cc1b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 04:54:11.0083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sWlJm9nEcRAtxJ7kVucyyXROlbnQNZPcL5bTlpBcIct+rnS6aywLmmb4TlacheX3TJh1akTBK3qoganXiKu9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4119
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: K5LPpaWNzGBKls8PqCsK9TTdqmk3Dz_T
X-Proofpoint-GUID: K5LPpaWNzGBKls8PqCsK9TTdqmk3Dz_T
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_03:2021-06-23,2021-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106240026
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 22, 2021, at 12:12 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Recently bperf was added to use BPF to count perf events for various
> purposes.  This is an extension for the approach and targetting to
> cgroup usages.
>=20
> Unlike the other bperf, it doesn't share the events with other
> processes but it'd reduce unnecessary events (and the overhead of
> multiplexing) for each monitored cgroup within the perf session.
>=20
> When --for-each-cgroup is used with --bpf-counters, it will open
> cgroup-switches event per cpu internally and attach the new BPF
> program to read given perf_events and to aggregate the results for
> cgroups.  It's only called when task is switched to a task in a
> different cgroup.
>=20
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> tools/perf/Makefile.perf                    |   7 +-
> tools/perf/util/Build                       |   1 +
> tools/perf/util/bpf_counter.c               |   5 +
> tools/perf/util/bpf_counter_cgroup.c        | 337 ++++++++++++++++++++
> tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 207 ++++++++++++
> tools/perf/util/cgroup.c                    |   2 +
> tools/perf/util/cgroup.h                    |   1 +
> 7 files changed, 559 insertions(+), 1 deletion(-)
> create mode 100644 tools/perf/util/bpf_counter_cgroup.c
> create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
>=20
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index e47f04e5b51e..786cba8f3798 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1015,6 +1015,7 @@ SKEL_OUT :=3D $(abspath $(OUTPUT)util/bpf_skel)
> SKEL_TMP_OUT :=3D $(abspath $(SKEL_OUT)/.tmp)
> SKELETONS :=3D $(SKEL_OUT)/bpf_prog_profiler.skel.h
> SKELETONS +=3D $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower=
.skel.h
> +SKELETONS +=3D $(SKEL_OUT)/bperf_cgroup.skel.h
>=20
> ifdef BUILD_BPF_SKEL
> BPFTOOL :=3D $(SKEL_TMP_OUT)/bootstrap/bpftool
> @@ -1032,7 +1033,11 @@ $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(L=
IBBPF) | $(SKEL_TMP_OUT)
> 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) \
> 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && $(LLVM_STRIP) -g $@
>=20
> -$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
> +$(SKEL_OUT)/vmlinux.h:
> +	$(MAKE) -C ../bpf/bpftool OUTPUT=3D$(SKEL_TMP_OUT)/ $(SKEL_TMP_OUT)/vml=
inux.h

We build bpftool with $(BPFTOOL), which is a few lines above.=20
Can we reuse some of that?=20

> +	$(Q)mv $(SKEL_TMP_OUT)/vmlinux.h $(SKEL_OUT)/vmlinux.h
> +
> +$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o $(SKEL_OUT)/vmlinux.h | $(=
BPFTOOL)
> 	$(QUIET_GENSKEL)$(BPFTOOL) gen skeleton $< > $@
>=20
> bpf-skel: $(SKELETONS)
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 95e15d1035ab..700d635448ff 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -140,6 +140,7 @@ perf-y +=3D clockid.o
> perf-$(CONFIG_LIBBPF) +=3D bpf-loader.o
> perf-$(CONFIG_LIBBPF) +=3D bpf_map.o
> perf-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_counter.o
> +perf-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_counter_cgroup.o
> perf-$(CONFIG_BPF_PROLOGUE) +=3D bpf-prologue.o
> perf-$(CONFIG_LIBELF) +=3D symbol-elf.o
> perf-$(CONFIG_LIBELF) +=3D probe-file.o
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.=
c
> index 974f10e356f0..7812c5d9b826 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -22,6 +22,7 @@
> #include "evsel.h"
> #include "evlist.h"
> #include "target.h"
> +#include "cgroup.h"
> #include "cpumap.h"
> #include "thread_map.h"
>=20
> @@ -792,6 +793,8 @@ struct bpf_counter_ops bperf_ops =3D {
> 	.destroy    =3D bperf__destroy,
> };
>=20
> +extern struct bpf_counter_ops bperf_cgrp_ops;
> +
> static inline bool bpf_counter_skip(struct evsel *evsel)
> {
> 	return list_empty(&evsel->bpf_counter_list) &&
> @@ -809,6 +812,8 @@ int bpf_counter__load(struct evsel *evsel, struct tar=
get *target)
> {
> 	if (target->bpf_str)
> 		evsel->bpf_counter_ops =3D &bpf_program_profiler_ops;
> +	else if (cgrp_event_expanded && target->use_bpf)
> +		evsel->bpf_counter_ops =3D &bperf_cgrp_ops;
> 	else if (target->use_bpf || evsel->bpf_counter ||
> 		 evsel__match_bpf_counter_events(evsel->name))
> 		evsel->bpf_counter_ops =3D &bperf_ops;

[...]


> +
> +#include "bpf_skel/bperf_cgroup.skel.h"
> +
> +static struct perf_event_attr cgrp_switch_attr =3D {
> +	.type =3D PERF_TYPE_SOFTWARE,
> +	.config =3D PERF_COUNT_SW_CGROUP_SWITCHES,
> +	.size =3D sizeof(cgrp_switch_attr),
> +	.sample_period =3D 1,
> +	.disabled =3D 1,
> +};
> +
> +static struct evsel *cgrp_switch;
> +static struct xyarray *cgrp_prog_fds;
> +static struct bperf_cgroup_bpf *skel;
> +
> +#define FD(evt, cpu) (*(int *)xyarray__entry(evt->core.fd, cpu, 0))
> +#define PROG(cpu)    (*(int *)xyarray__entry(cgrp_prog_fds, cpu, 0))
> +
> +static void set_max_rlimit(void)
> +{
> +	struct rlimit rinf =3D { RLIM_INFINITY, RLIM_INFINITY };
> +
> +	setrlimit(RLIMIT_MEMLOCK, &rinf);
> +}
> +
> +static __u32 bpf_link_get_prog_id(int fd)
> +{
> +	struct bpf_link_info link_info =3D {0};
> +	__u32 link_info_len =3D sizeof(link_info);
> +
> +	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> +	return link_info.prog_id;
> +}

How about we move set_max_rlimit() and bpf_link_get_prog_id() to=20
a header so we don't have to duplicate it?

> +
> +static int bperf_load_program(struct evlist *evlist)
> +{
> +	struct bpf_link *link;
> +	struct evsel *evsel;
> +	struct cgroup *cgrp, *leader_cgrp;
> +	__u32 i, cpu, prog_id;
> +	int nr_cpus =3D evlist->core.all_cpus->nr;
> +	int map_size, map_fd;
> +	int prog_fd, err;
> +
> +	skel =3D bperf_cgroup_bpf__open();
> +	if (!skel) {
> +		pr_err("Failed to open cgroup skeleton\n");
> +		return -1;
> +	}
> +
> +	skel->rodata->num_cpus =3D nr_cpus;
> +	skel->rodata->num_events =3D evlist->core.nr_entries / nr_cgroups;
> +
> +	BUG_ON(evlist->core.nr_entries % nr_cgroups !=3D 0);
> +
> +	/* we need one copy of events per cpu for reading */
> +	map_size =3D nr_cpus * evlist->core.nr_entries / nr_cgroups;
> +	bpf_map__resize(skel->maps.events, map_size);
> +	bpf_map__resize(skel->maps.cpu_idx, nr_cpus);
> +	bpf_map__resize(skel->maps.cgrp_idx, nr_cgroups);
> +	/* previous result is saved in a per-cpu array */
> +	map_size =3D evlist->core.nr_entries / nr_cgroups;
> +	bpf_map__resize(skel->maps.prev_readings, map_size);
> +	/* cgroup result needs all events */
> +	map_size =3D nr_cpus * evlist->core.nr_entries;
> +	bpf_map__resize(skel->maps.cgrp_readings, map_size);

We are setting map_size back and forth here.=20

[...]


> diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/uti=
l/bpf_skel/bperf_cgroup.bpf.c
> new file mode 100644
> index 000000000000..6d74e93dd1f5
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +// Copyright (c) 2021 Facebook
> +// Copyright (c) 2021 Google
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +#define MAX_LEVELS  10  // max cgroup hierarchy level: arbitrary
> +#define MAX_EVENTS  32  // max events per cgroup: arbitrary
> +
> +// NOTE: many of map and global data will be modified before loading
> +//       from the userspace (perf tool) using the skeleton helpers.
> +
> +// single set of global perf events to measure
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(int));
> +	__uint(max_entries, 1);
> +} events SEC(".maps");
> +
> +// from logical cpu number to event index
> +// useful when user wants to count subset of cpus
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +	__uint(max_entries, 1);
> +} cpu_idx SEC(".maps");

How about we make cpu_idx a percpu array and use 0,1 for=20
disable/enable profiling on this cpu?=20

> +
> +// from cgroup id to event index
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(__u64));
> +	__uint(value_size, sizeof(__u32));
> +	__uint(max_entries, 1);
> +} cgrp_idx SEC(".maps");
> +
> +// per-cpu event snapshots to calculate delta
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(struct bpf_perf_event_value));
> +} prev_readings SEC(".maps");
> +
> +// aggregated event values for each cgroup
> +// will be read from the user-space
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(struct bpf_perf_event_value));
> +} cgrp_readings SEC(".maps");

Maybe also make this a percpu array? This should make the BPF program
faster.=20

> +
> +const volatile __u32 num_events =3D 1;
> +const volatile __u32 num_cpus =3D 1;
> +
> +int enabled =3D 0;
> +int use_cgroup_v2 =3D 0;
> +
[...]

