Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006CF3396F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhCLSxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:53:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25236 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233581AbhCLSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:52:49 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12CIhk5H014108;
        Fri, 12 Mar 2021 10:52:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=KXpSitlXQ0C/axxjImSYDegV+S7qX0XiH6T9hVX5XKs=;
 b=RxtuibPkI8kjpRlx/Nr4q42estEKaNWBLyE25CuUmsyqQUA1doRhxjn5dvHM29DOLhXR
 1ArazQR8hlYEpt6nI9Hk2IQ1TWSVHkr+tMOI+41/MSN9kM9ffuUOaVXFE32bnV22syfV
 NJ+4xhm9Zzeh07aQaqe0WVvvCdg9PH30+FY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 377p5fqjda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 12 Mar 2021 10:52:45 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 12 Mar 2021 10:52:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXs/YUYpaMFpv2zSUKiS9a7cO7dvu9wgSWr7EDZmNvqd0/Q0ZdrUNAWWL+IkHZ6cOsIYK8Zhhp/e0u0QVWUAmDXVqOs7Vwjjk+N5XX+wdZBLvfJL90TUO8R81SqLAPDfasFlEujNn2UJX8f/W+rkwYtz7Ay8BIR/3bLuYLRR/1eJIyiQAA/9j7uF42k+A1XHYpf4pPDQl4eG+zOevoxD9mfdY5JhsLWonuIwxbXXkbEumefQt268XVby7FtckdYayvbwWZk1hzKGA5IWDxAm86v8qxW3nLrOnSuUryYNZ6YQO2Caw35HMrIkfv+xfhAo3pI7LUPcZhGtGdU53ghfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXpSitlXQ0C/axxjImSYDegV+S7qX0XiH6T9hVX5XKs=;
 b=RZAGZ3hftFgymrEC/nsc1YVgn2e7x8ZQacMQ53nQgFCqtoyhMD6ChC2nsvXAKdLuDeAFggIHYOC7Hj81tIRPFGy7rMlM52z4icOc0VwTsMuWahRVjsPLAm9jHmwqVHmzIj0S8BnaNa+sLMPJBy7R1kx13SE1Bo+qZgyuD39lbNOroCUml2QsXHK0/YzS4IRUkuvxmfgomxGHp96j1w/J1eKIJwmMX880V6iULUfl9MP+MUVaPcGyyq2EF9WhOo/mjhQ1XYyrNQFhkcnBSXMCBljsUV0tVcHz2NAcd4u9RMnPKOwu/5hkfl33FRBjiww2qiJ2dFMjuXkVMJ2UyqoAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3415.namprd15.prod.outlook.com (2603:10b6:a03:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Fri, 12 Mar
 2021 18:52:40 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 18:52:40 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "linux-perf-users@ghostprotocols.net" 
        <linux-perf-users@ghostprotocols.net>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Topic: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Index: AQHXFuPifzAWbJ/c0EGfxtA8c/wTpKqAaRKAgABK5YA=
Date:   Fri, 12 Mar 2021 18:52:39 +0000
Message-ID: <F55800AC-73A5-46A4-9E08-1DD00691267C@fb.com>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <YEt5o7pSTleymwy1@kernel.org>
In-Reply-To: <YEt5o7pSTleymwy1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:17f0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ccb148c-df56-42bb-d713-08d8e58802ec
x-ms-traffictypediagnostic: BYAPR15MB3415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB341581B5AC158DBF16AC0604B36F9@BYAPR15MB3415.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: il+aTsBgizRkevQ1wnp9fAwd49nj1ubGIBtSx79CC6XhQiDs69w/9OykFbyZr6Y4SX1RKXgfiao7BbbDFK9dHHxkLYx7yt3iC8/rQlE2JVin1r4tzGlvzWZYOxXCmUHGCwaT28Wiksnd3gTVENJzvnESQXCfEUbMrJs5UP9qwrgOeAx5iRX4liuK/2xMfeUjfo8vLJm6GBlp8aVU0TkJU6YFzn5mzq67P6Dj6JuVGS5uil1H8jU8fXYEvge3oB0W9ZRZbJdhG/Tj/4nm3n8fIrxmrv+X4qCR+oMOHfO8mTKaBBYeB/8K4f/iMfyDZ6joiRn2VxAoEHkqF5ArkPSn5L3GGnM7B7/2kkpE7q4VEM8obrVVsfJ8o4q6UYBzxV6CzigFHxxbEfuQtX8C8H4FU1FJF86Jp7KYiD/FJ6g/odLDXh15EUBs2nxuEwbjJFcvfz5OgqK5wLgxiEajrqZSqwIeybLTN841BJR1dhYEdU7suIl589iJVaORRVnM6ZtWcF+uZo0xXZC6i+LnL/UauGMZLCrW5Hk3lM3eMoXlf1L9KGkTqzOFG/b5mDR2Oyeey2QRR9RG+DX2QepwY28h6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(346002)(366004)(376002)(6486002)(83380400001)(8676002)(6506007)(4326008)(2616005)(316002)(8936002)(186003)(36756003)(71200400001)(33656002)(86362001)(91956017)(76116006)(54906003)(6916009)(66476007)(2906002)(53546011)(5660300002)(66946007)(64756008)(66556008)(66446008)(478600001)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?D8SmTx6fmKsDmtnaY1xqTy2g7g1gqbzVOaQTPQDxemCyb1Q5R/cmPwlWeCci?=
 =?us-ascii?Q?bm8yidhXm8t7ZyeHY1aPilK+ucMc1jOYjzdyILOlTOVQSM4qBx0FC6LMkZmI?=
 =?us-ascii?Q?5MvGliQoZMnWYOyaTntTGwrhuMySzG8WFDfA0vYP1GeNmUQlGw8P19SIidXf?=
 =?us-ascii?Q?uqGjlTvd31tmVCp/0dO7TEYYLSjFcly8abssoTnvEUCkeAeBmxNzKQP+8NBV?=
 =?us-ascii?Q?fcdZN+AMfdgXiU6YAbIk6zEPt5uiG1DIesoshLzGTcM+Q75SjVxmb0LMdyBp?=
 =?us-ascii?Q?+7NzvJDLOfGQC4MqwVGTC2G6aeNuWdU5zGQvLQKpzKuzVQQo+2jnbysx5TuO?=
 =?us-ascii?Q?Iq95krHNvm0XHojFK58gabXXpDXHUypiZZSn8qokf1KWErW96023KRGvgktg?=
 =?us-ascii?Q?6poi8uRASo5tKSuLZlfbLbfYJk/7L5J6LCQxEwWWivAloFz4RDJRo13n7foo?=
 =?us-ascii?Q?e26HkC98Ab1ESfEkh6yLuov8dp7m6ZhfS0fgxH/moXwIXobP7ACdYRrMbkMc?=
 =?us-ascii?Q?wkJf56GCsf4HIH5kJ/UHex5adXjbsTfzkNPusDpybdMf40pMpJ+6AP66ztoN?=
 =?us-ascii?Q?l0A80Sv2ZFPPqJqzSNyMl5CUlRV2v2v0SSS4lt4t+QXqhw9vQ110d/SSQLtw?=
 =?us-ascii?Q?YGQikHnV/nv7x3ny95N4fAdgLklLiIGF0xdtOWi10y+GGwEcIWA5MK6lXm0c?=
 =?us-ascii?Q?XP/8BOkQUhT1c7RqMia0hvPcGSRiD1Jau3YxJYSZ7MvOEOpvO8FiyMPUZeQZ?=
 =?us-ascii?Q?/uZfCTncvnSSmnPZfTiJm1ljKr5GQj55C2isICfPaMJWTx8GM/Z1FluEDeR1?=
 =?us-ascii?Q?UrYAMe9lBFYvzQ1TqZ6zkrk1flCqAc1Jfd5zd4Er4XEF9nIsl1gDdNDATrYW?=
 =?us-ascii?Q?SQdJ4L2Baw9yfJC4DpPcEOsrAFYcWiHpYcqWLBH0jWMeoxWsCnDvw3UJpLQA?=
 =?us-ascii?Q?impx9uDYq5giCzkYNhlYWCISeL9poQIQfVzCuIGcM7h5Iz0CbObf2yhZ+SZx?=
 =?us-ascii?Q?dukx38Qh2LWPmI//LyTP5BrSgmZHNuGBL2qRF4RW+eyaMfAygD/OrmRzghkW?=
 =?us-ascii?Q?itcV9qBHAsXw3aEtNeI5GVX7uFqjiyUZHrnZrZb6GsbU9UCUlIUjap+NYL6W?=
 =?us-ascii?Q?7cNUzEf+sI+ofGzquMZiZEFdUFNNtpaGceI9SFYI+f/nljS7faldvBnkAstZ?=
 =?us-ascii?Q?xjZ7FA05hrdd8VmWkTWJMX+ZUFBH0af3tfllVHDI/D9GZD/sHffY81joDPTy?=
 =?us-ascii?Q?Mw15/sgcp3xXdPhOMcqTvOBgBa6UUmVkNsHPjnBfQ/jl8LWV8zFTx978z8Ac?=
 =?us-ascii?Q?WCYsSIA1fp5d5699Bw8d7LXwKAzdY6dZMUfq463jqSUrEdNyHUAObXPeY5T8?=
 =?us-ascii?Q?LKtCGwg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C77E86004B4D9C40B10B9E3D34489C93@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccb148c-df56-42bb-d713-08d8e58802ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 18:52:39.9294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PhFbgQXYzs0fVG+UElgQMiXD5Fri6HEau414rjvRTlprrm3tidMNjrmoPcCSrH/qXOpeEfW+z2VK/R5UNG3Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3415
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-12_09:2021-03-12,2021-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 12, 2021, at 6:24 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Thu, Mar 11, 2021 at 06:02:57PM -0800, Song Liu escreveu:
>> perf uses performance monitoring counters (PMCs) to monitor system
>> performance. The PMCs are limited hardware resources. For example,
>> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
>>=20
>> Modern data center systems use these PMCs in many different ways:
>> system level monitoring, (maybe nested) container level monitoring, per
>> process monitoring, profiling (in sample mode), etc. In some cases,
>> there are more active perf_events than available hardware PMCs. To allow
>> all perf_events to have a chance to run, it is necessary to do expensive
>> time multiplexing of events.
>>=20
>> On the other hand, many monitoring tools count the common metrics (cycle=
s,
>> instructions). It is a waste to have multiple tools create multiple
>> perf_events of "cycles" and occupy multiple PMCs.
>>=20
>> bperf tries to reduce such wastes by allowing multiple perf_events of
>> "cycles" or "instructions" (at different scopes) to share PMUs. Instead
>> of having each perf-stat session to read its own perf_events, bperf uses
>> BPF programs to read the perf_events and aggregate readings to BPF maps.
>> Then, the perf-stat session(s) reads the values from these BPF maps.
>>=20
>> Please refer to the comment before the definition of bperf_ops for the
>> description of bperf architecture.
>>=20
>> bperf is off by default. To enable it, pass --use-bpf option to perf-sta=
t.
>> bperf uses a BPF hashmap to share information about BPF programs and map=
s
>> used by bperf. This map is pinned to bpffs. The default address is
>> /sys/fs/bpf/bperf_attr_map. The user could change the address with optio=
n
>> --attr-map.
>>=20
>> ---
>> Known limitations:
>> 1. Do not support per cgroup events;
>> 2. Do not support monitoring of BPF program (perf-stat -b);
>> 3. Do not support event groups.
>=20
> Cool stuff, but I think you can break this up into more self contained
> patches, see below.
>=20
> Apart from that, some suggestions/requests:
>=20
> We need a shell 'perf test' that uses some synthetic workload so that we
> can count events with/without --use-bpf (--bpf-counters is my
> alternative name, see below), and then compare if the difference is
> under some acceptable range.
>=20
> As a followup patch we could have something like:
>=20
> perf config stat.bpf-counters=3Dyes
>=20
> That would make 'perf stat' use BPF counters for what it can, using the
> default method for the non-supported targets, emitting some 'perf stat
> -v' visible warning (i.e. a debug message), i.e. make it opt-in that the
> user wants to use BPF counters for all that is possible at that point in
> time.o
>=20
> Thanks for working on this,
>=20
> - Arnaldo
>=20
>> The following commands have been tested:
>>=20
>>   perf stat --use-bpf -e cycles -a
>>   perf stat --use-bpf -e cycles -C 1,3,4
>>   perf stat --use-bpf -e cycles -p 123
>>   perf stat --use-bpf -e cycles -t 100,101
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/Makefile.perf                      |   1 +
>> tools/perf/builtin-stat.c                     |  20 +-
>> tools/perf/util/bpf_counter.c                 | 552 +++++++++++++++++-
>> tools/perf/util/bpf_skel/bperf.h              |  14 +
>> tools/perf/util/bpf_skel/bperf_follower.bpf.c |  65 +++
>> tools/perf/util/bpf_skel/bperf_leader.bpf.c   |  46 ++
>> tools/perf/util/evsel.h                       |  20 +-
>> tools/perf/util/target.h                      |   4 +-
>> 8 files changed, 712 insertions(+), 10 deletions(-)
>> create mode 100644 tools/perf/util/bpf_skel/bperf.h
>> create mode 100644 tools/perf/util/bpf_skel/bperf_follower.bpf.c
>> create mode 100644 tools/perf/util/bpf_skel/bperf_leader.bpf.c
>>=20
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index f6e609673de2b..ca9aa08e85a1f 100644
>> --- a/tools/perf/Makefile.perf
>> +++ b/tools/perf/Makefile.perf
>> @@ -1007,6 +1007,7 @@ python-clean:
>> SKEL_OUT :=3D $(abspath $(OUTPUT)util/bpf_skel)
>> SKEL_TMP_OUT :=3D $(abspath $(SKEL_OUT)/.tmp)
>> SKELETONS :=3D $(SKEL_OUT)/bpf_prog_profiler.skel.h
>> +SKELETONS +=3D $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follow=
er.skel.h
>>=20
>> ifdef BUILD_BPF_SKEL
>> BPFTOOL :=3D $(SKEL_TMP_OUT)/bootstrap/bpftool
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 2e2e4a8345ea2..34df713a8eea9 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -792,6 +792,12 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>> 	}
>>=20
>> 	evlist__for_each_cpu (evsel_list, i, cpu) {
>> +		/*
>> +		 * bperf calls evsel__open_per_cpu() in bperf__load(), so
>> +		 * no need to call it again here.
>> +		 */
>> +		if (target.use_bpf)
>> +			break;
>> 		affinity__set(&affinity, cpu);
>>=20
>> 		evlist__for_each_entry(evsel_list, counter) {
>> @@ -925,15 +931,15 @@ static int __run_perf_stat(int argc, const char **=
argv, int run_idx)
>> 	/*
>> 	 * Enable counters and exec the command:
>> 	 */
>> -	t0 =3D rdclock();
>> -	clock_gettime(CLOCK_MONOTONIC, &ref_time);
>> -
>> 	if (forks) {
>> 		evlist__start_workload(evsel_list);
>> 		err =3D enable_counters();
>> 		if (err)
>> 			return -1;
>>=20
>> +		t0 =3D rdclock();
>> +		clock_gettime(CLOCK_MONOTONIC, &ref_time);
>> +
>> 		if (interval || timeout || evlist__ctlfd_initialized(evsel_list))
>> 			status =3D dispatch_events(forks, timeout, interval, &times);
>> 		if (child_pid !=3D -1) {
>> @@ -954,6 +960,10 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>> 		err =3D enable_counters();
>> 		if (err)
>> 			return -1;
>> +
>> +		t0 =3D rdclock();
>> +		clock_gettime(CLOCK_MONOTONIC, &ref_time);
>> +
>> 		status =3D dispatch_events(forks, timeout, interval, &times);
>> 	}
>>=20
>=20
> The above two hunks seems out of place, i.e. can they go to a different
> patch and with an explanation about why this is needed?

Actually, I am still debating whether we want the above change in a separat=
e=20
patch. It is related to the following change.=20

[...]

>> +	/*
>> +	 * Attahcing the skeleton takes non-trivial time (0.2s+ on a kernel
>> +	 * with some debug options enabled). This shows as a longer first
>> +	 * interval:
>> +	 *
>> +	 * # perf stat -e cycles -a -I 1000
>> +	 * #           time             counts unit events
>> +	 *      1.267634674     26,259,166,523      cycles
>> +	 *      2.271637827     22,550,822,286      cycles
>> +	 *      3.275406553     22,852,583,744      cycles
>> +	 *
>> +	 * Fix this by zeroing accum_readings after attaching the program.
>> +	 */
>> +	bperf_sync_counters(evsel);
>> +	entry_cnt =3D bpf_map__max_entries(skel->maps.accum_readings);
>> +	memset(values, 0, sizeof(struct bpf_perf_event_value) * num_cpu_bpf);
>> +
>> +	for (i =3D 0; i < entry_cnt; i++) {
>> +		bpf_map_update_elem(bpf_map__fd(skel->maps.accum_readings),
>> +				    &i, values, BPF_ANY);
>> +	}
>> +	return 0;
>> +}

Attaching the skeleton takes non-trivial time, so that we get a bigger firs=
t=20
interval (1.26s in the example above). To fix this, in __run_perf_stat(), w=
e=20
get t0 and ref_time after enable_counters().=20

Maybe a comment in __run_perf_stat() is better than a separate patch?

Thanks,
Song=
