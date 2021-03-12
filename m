Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B843392BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhCLQIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:08:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16474 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229728AbhCLQHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:07:48 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12CG4Ma6024249;
        Fri, 12 Mar 2021 08:07:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=7uo0lWYd+pZ+Z6cOiDXoV/bwfzxLvGiq/3VgnieoULg=;
 b=G4h/dAS7iVNbBLk47UvALlGTw4+O35pFcnGwlVbngXK1JF821nFz/fFsZ98oj435xbNz
 MVVBh2xpkKkhAkRq52Y7buMhE22eDBp3WGsMUiigFxgKNI09z0hd1mCQgoqAMH1updj5
 xjhr8XiXFb1kOc++Euy5BPocz0E4Tpl6t18= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 377rh25e4q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 12 Mar 2021 08:07:44 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 12 Mar 2021 08:07:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPTxJ6Lp8yL7IhsYNNxH0/NzwHY3CYISL/MW/IW1FhI6FnFBzY3mUk2Rl5egox0ziCPUczH5+VwDoRCY3vmh0NMEda1ZXTDNrNMzHoBQW23xQD9+PZ4weSKyvcvDGCs5smbZHL9XYTvWjgxs5xZMCosHoOydBLOQpV62XC6FkFOW83AaLjb4tVdUCZe+9DnH51K70zDnyo3IgfoBm43vV/obrAbKL/CkLK4S9K/wKOfGMbyr+ZS8MBfjCmAsf/CxgTEEK516YRtdhEtscW+3o3e82jQ+oMjuWv5OTnet8eOc9C2c6g6WV60S+aFz+2CZgYPICcOimO46jjoGebWabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uo0lWYd+pZ+Z6cOiDXoV/bwfzxLvGiq/3VgnieoULg=;
 b=eTSgKQf7Xnu2tWb1LyfbglQY0pF7eVlj709P4hi8GzEAVCDYxMYNTwAXeduVZTP9ZhOuUkTM3l5+ciSCHSrhQaQIuOvwqKXV5JX/i356MxoWDX9kDs04f000SKboOdHHi0tNY1hg4iRjS3DAKkGPj8ScB+e0hHZ8bBwMaHDeUoKDz3ITnN73MQeOzkrxx56FKtmYf0CVlzbTSZFn9/8/8YrvN5sb+Oda5KOxyp34CrhCexjzLSm4Tfm/IGiPhaWIVN9yBg5MQiPFX4N76nLcs3NGEH44bjCk4NJO4kDrXKZSI5/bkgRi+qhO/D7fei5a6n9X0BSH7eqh9l7VfpQpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3206.namprd15.prod.outlook.com (2603:10b6:a03:10d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 16:07:42 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 16:07:42 +0000
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
Thread-Index: AQHXFuPifzAWbJ/c0EGfxtA8c/wTpKqAaRKAgAAczwA=
Date:   Fri, 12 Mar 2021 16:07:42 +0000
Message-ID: <C8208C48-2EFE-4186-865D-3E90E4BFCB30@fb.com>
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
x-ms-office365-filtering-correlation-id: 38160894-2077-409a-deff-08d8e570f78e
x-ms-traffictypediagnostic: BYAPR15MB3206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB3206A1186A3596F000924624B36F9@BYAPR15MB3206.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BRGYD9ELNmDJ28ckncGBFP/wB2DFmZ1JcyMwHBdtbdCajb3o2fKwUZOISw7CLTJ2cgTNQC6vZtA08R7Kcr8bk5WnW0JmpLJPgvnrdKwlceFInckFxdHlWo2s0whl147NlvFoPafxT5nPVTxNqhksUlb71R1CCitggHqTctAqOCs3NsFR7d4f/g7ljsUs1fyw3dc+qinepTcDlmxdLhSxTF0Kn6FGh5hYGr/BVBgXXyOkTk8sB1V1wofymiarHO845KNwC8S8fs4SvuuFq9yftKeXjYfNdX1WJLixcD8Y1xroDqFmKPrv148KnToazi7TikhTtMlE4g6jkQ07nFjY5p4E9479X7ry7ygqlDIqA47c8mhb/dfGZNeAMAFxhjd0LwXbdtCoTDEmQHcSdqOqJCmqlPjDxmSQmHIkqsbj92xqwgd2PGd2jNMB2ydUiT76BpDjcaNlmzyIXevSZLaNnp3Bd7nt9OD/DEnU8E86nDtzWVqFtN3urSw3hbW9Uxxo2E52/bEur6BYuQM1uL2VFfg5P5LismhOKzJctzIJxoQWvYIes0v/Nb5W34LrYiBfqsYJJ3WFaa8yfVMTw4xq0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(8936002)(71200400001)(33656002)(186003)(6506007)(53546011)(4326008)(6916009)(6512007)(30864003)(316002)(478600001)(36756003)(66946007)(66446008)(64756008)(83380400001)(2906002)(5660300002)(66476007)(91956017)(54906003)(76116006)(86362001)(2616005)(6486002)(66556008)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3ujo3SvUDND6EwUGPSezqZiNVy15fMd7RqsIJ+LmDw8Ox5XQGjq3+gTn+nGK?=
 =?us-ascii?Q?vtNpYXMgUC1dKr+ASX6hVMQYtJzqyzhCD41yzMoM6IgMNGNqV6lVH5mjqXYl?=
 =?us-ascii?Q?wYgaMsr0+s8R8yMqUyZuy3coa0J6LXJHMpHu7PiLNU9TzFPTGxLT3LSNTm2Y?=
 =?us-ascii?Q?aiUw1LkxAZ1RrEK59yOC2qzINvOCOw/OwntOV87/LVMhppQZ5rwOD0S9lNOr?=
 =?us-ascii?Q?a/KdoTKy2W2pwGuCUCXvWVxuh/eemiwnhR1oYFJI2VSaE9nXRjdkoVttAedP?=
 =?us-ascii?Q?Hw6ilkfU8qs/WxR2WZh/Zms8vPXPVJElKA6dMDSHfyPP0+/Vyrtg86cgX5VP?=
 =?us-ascii?Q?H3B5yAOzaBd+AudkkxKitDrlMDe58pHMroaCmOJbmQ/g5nx0Ybca9yrI/Zud?=
 =?us-ascii?Q?QfaKmzjdnUush5RFPDSnOS8QY7HYyrvTbKkPbbzTz0Qd69YH6/QI475g0F6q?=
 =?us-ascii?Q?Aoc7G+xvhpj1YEYgrO5Vkb9ocQ2xrUuj1uVb6mzQY7SubL3QNvivl3PH9XNW?=
 =?us-ascii?Q?fuNHeuV3tX3p5UtRmSl75FgIxjTqTzwKFKPOsdUjvDyIXz0ZsTmOsT6ej9Uq?=
 =?us-ascii?Q?O86TcpYbvkk34Co9yuBoNz5W+hMPlru9IAQf6+2Bx0aTSW6iTA/LKzPHh4qk?=
 =?us-ascii?Q?cv7Bw6U8M4K3FS2bEUkYIyXAilzqZHTJve3jPyB7Ps9RAlhfZCPJSo5eb8vU?=
 =?us-ascii?Q?4SpxMiMHajwCOgblhy42bZSLt0KCkRmFz41dZTYGeeyj3iPfuqYu4H9Wg9/I?=
 =?us-ascii?Q?GWvGsWjJkX2cbf+fs5jLCfSeXmcZTCwsWM8ptN3ALqYUPoYlqn+OcdUj+ssz?=
 =?us-ascii?Q?Y2AzoL4fVZ4eHy4fEeLtZ0F4IOjjF/1B7QR/GrB0vJDSVBYjGnbkgaZvfIIX?=
 =?us-ascii?Q?N6wr4Jn6sGwKlSdSTv6AsOCmjgowBsRmJFpkvMpJPHk6CjFylk/h91QUG/S8?=
 =?us-ascii?Q?20ARwO/GUmhhQMTKhsnC8H2Wd+l8sKR1NZSGZvoBr9E2yhVdIf0POFprlos8?=
 =?us-ascii?Q?jdsWtz2YHwidfYlGMx355kooGqfu1XmTMF5HOHpvaUSA6PIgq0+gpZMy4a/h?=
 =?us-ascii?Q?xZTIqFy2VciqXh4gaGMW8zuf12b2WhA8CnOw2AlUa29dvAfghNdCloCGJPRg?=
 =?us-ascii?Q?u+05BlpJr3Zv1yeujpZS7FyG8GJcUH3aelRBVpZnaWAaMI9R4u+2MHuwRQqI?=
 =?us-ascii?Q?SlZou5D5+8HLWJLIhbPNKQmh8TqUKqvCmuLs2WpV+yIyLz5LiHWcHmIRkhED?=
 =?us-ascii?Q?TzGX6ELiRqY/UZB5aikno+djn1KNjV8ZNI2OY/ja/DimQdSZizSIvUMoY36G?=
 =?us-ascii?Q?C5ZzAZR2HKFd1niPHWkOPnWppb3Q+Ogv9wilWstK3et0vUKQvnAOkQU0PZ98?=
 =?us-ascii?Q?XiGdBv8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <75BF45C8DD49884593001D197D0F9B34@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38160894-2077-409a-deff-08d8e570f78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 16:07:42.3899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3V/dKA4CJGeaoRQWdt5tRkyUWOPnK6NEcXqvXCgmXeAbsHlJyWdBfKZYF549B2Za5zHVmOs8EtZLxmLk04tXrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3206
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-12_06:2021-03-12,2021-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120115
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

Yes, "perf test" makes sense. Would this be the extension of current=20
perf-test command? Or a new set of tests?

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

Yes, the fallback mechanism will be very helpful. I also have ideas on
setting a list for "common events", and only use BPF for the common=20
events. Not common events should just use the original method.=20

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

Yeah, make sense. I will split them to a separate patch.=20

>=20
>> @@ -1146,6 +1156,10 @@ static struct option stat_options[] =3D {
>> #ifdef HAVE_BPF_SKEL
>> 	OPT_STRING('b', "bpf-prog", &target.bpf_str, "bpf-prog-id",
>> 		   "stat events on existing bpf program id"),
>> +	OPT_BOOLEAN(0, "use-bpf", &target.use_bpf,
>> +		    "use bpf program to count events"),
>> +	OPT_STRING(0, "attr-map", &target.attr_map, "attr-map-path",
>> +		   "path to perf_event_attr map"),
>=20
> These need to be documented in tools/perf/Documentation/perf-stat.txt
>=20
> Also please rename it to:
>=20
>  --bpf-counters
>  --bpf-attr-map
>=20
> Andrii suggested prefixing with --bpf BPF related options in pahole, I
> think this applies here as well.

Will change it in v2.=20

>=20
>> #endif
>> 	OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
>> 		    "system-wide collection from all CPUs"),
>> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter=
.c
>> index 04f89120b3232..d232011ec8f26 100644
>> --- a/tools/perf/util/bpf_counter.c
>> +++ b/tools/perf/util/bpf_counter.c
>> @@ -5,6 +5,7 @@
>> #include <assert.h>
>> #include <limits.h>
>> #include <unistd.h>
>> +#include <sys/file.h>
>> #include <sys/time.h>
>> #include <sys/resource.h>
>> #include <linux/err.h>
>> @@ -18,8 +19,37 @@
>> #include "debug.h"
>> #include "evsel.h"
>> #include "target.h"
>> +#include "cpumap.h"
>> +#include "thread_map.h"
>>=20
>> #include "bpf_skel/bpf_prog_profiler.skel.h"
>> +#include "bpf_skel/bperf_u.h"
>> +#include "bpf_skel/bperf_leader.skel.h"
>> +#include "bpf_skel/bperf_follower.skel.h"
>> +
>> +/*
>> + * bperf uses a hashmap, the attr_map, to track all the leader programs=
.
>> + * The hashmap is pinned in bpffs. flock() on this file is used to ensu=
re
>> + * no concurrent access to the attr_map.  The key of attr_map is struct
>> + * perf_event_attr, and the value is struct bperf_attr_map_entry.
>> + *
>> + * struct bperf_attr_map_entry contains two __u32 IDs, bpf_link of the
>> + * leader prog, and the diff_map. Each perf-stat session holds a refere=
nce
>> + * to the bpf_link to make sure the leader prog is attached to sched_sw=
itch
>> + * tracepoint.
>> + *
>> + * Since the hashmap only contains IDs of the bpf_link and diff_map, it
>> + * does not hold any references to the leader program. Once all perf-st=
at
>> + * sessions of these events exit, the leader prog, its maps, and the
>> + * perf_events will be freed.
>> + */
>> +struct bperf_attr_map_entry {
>> +	__u32 link_id;
>> +	__u32 diff_map_id;
>> +};
>> +
>> +#define DEFAULT_ATTR_MAP_PATH "/sys/fs/bpf/bperf_attr_map"
>=20
> Humm bpf is already in the parent directory, perhaps we can have it as
> just /sys/fs/bpf/perf_attr_map? Here 'counter' isn't applicable, I
> guess, eventually we may want to use this for other purposes? ;-)

Do you mean sharing PMCs with sampling events? Well, I do have it on my
list for 2022. ;-)

>=20
>> +#define ATTR_MAP_SIZE 16
>>=20
>> static inline void *u64_to_ptr(__u64 ptr)
>> {
>> @@ -274,17 +304,529 @@ struct bpf_counter_ops bpf_program_profiler_ops =
=3D {
>> 	.install_pe =3D bpf_program_profiler__install_pe,
>> };
>>=20
>> +static __u32 bpf_link_get_id(int fd)
>> +{
>> +	struct bpf_link_info link_info;
>> +	__u32 link_info_len;
>> +
>> +	link_info_len =3D sizeof(link_info);
>=20
> Can you combine declaration with attribution to make the code more
> compact? i.e.:
>=20
> 	__u32 link_info_len =3D sizeof(link_info);
>=20
>=20
>> +	memset(&link_info, 0, link_info_len);
>> +	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
>> +	return link_info.id;
>> +}
>> +
>> +static __u32 bpf_link_get_prog_id(int fd)
>> +{
>> +	struct bpf_link_info link_info;
>> +	__u32 link_info_len;
>> +
>> +	link_info_len =3D sizeof(link_info);
>=20
> Ditto
>=20
>> +	memset(&link_info, 0, link_info_len);
>> +	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
>> +	return link_info.prog_id;
>> +}
>> +
>> +static __u32 bpf_map_get_id(int fd)
>> +{
>> +	struct bpf_map_info map_info;
>> +	__u32 map_info_len;
>=20
> Ditto.
>=20
>> +	map_info_len =3D sizeof(map_info);
>> +	memset(&map_info, 0, map_info_len);
>> +	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
>> +	return map_info.id;
>> +}
>> +
>> +static int bperf_lock_attr_map(struct target *target)
>> +{
>> +	const char *path =3D target->attr_map ? : DEFAULT_ATTR_MAP_PATH;
>> +	int map_fd, err;
>> +
>> +	if (access(path, F_OK)) {
>> +		map_fd =3D bpf_create_map(BPF_MAP_TYPE_HASH,
>> +					sizeof(struct perf_event_attr),
>> +					sizeof(struct bperf_attr_map_entry),
>=20
> Also naming it as perf_event_attr_map_entry should make the equivalence
> more explicit if albeit a bit longer, i.e.:
>=20
> +		map_fd =3D bpf_create_map(BPF_MAP_TYPE_HASH,
> +					sizeof(struct perf_event_attr),
> +					sizeof(struct perf_event_attr_map_entry),
>=20
>> +					ATTR_MAP_SIZE, 0);
>> +		if (map_fd < 0)
>> +			return -1;
>> +
>> +		err =3D bpf_obj_pin(map_fd, path);
>> +		if (err) {
>> +			/* someone pinned the map in parallel? */
>> +			close(map_fd);
>> +			map_fd =3D bpf_obj_get(path);
>> +			if (map_fd < 0)
>> +				return -1;
>> +		}
>> +	} else {
>> +		map_fd =3D bpf_obj_get(path);
>> +		if (map_fd < 0)
>> +			return -1;
>> +	}
>> +
>> +	err =3D flock(map_fd, LOCK_EX);
>> +	if (err) {
>> +		close(map_fd);
>> +		return -1;
>> +	}
>> +	return map_fd;
>> +}
>> +
>> +/* trigger the leader program on a cpu */
>> +static int bperf_trigger_reading(int prog_fd, int cpu)
>> +{
>> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
>> +			    .ctx_in =3D NULL,
>> +			    .ctx_size_in =3D 0,
>> +			    .flags =3D BPF_F_TEST_RUN_ON_CPU,
>> +			    .cpu =3D cpu,
>> +			    .retval =3D 0,
>> +		);
>> +
>> +	return bpf_prog_test_run_opts(prog_fd, &opts);
>> +}
>> +
>> +static int bperf_check_target(struct evsel *evsel,
>> +			      struct target *target,
>> +			      enum bperf_filter_type *filter_type,
>> +			      __u32 *filter_entry_cnt)
>> +{
>> +	if (evsel->leader->core.nr_members > 1) {
>> +		pr_err("bpf managed perf events do not yet support groups.\n");
>> +		return -1;
>> +	}
>> +
>> +	/* determine filter type based on target */
>> +	if (target->system_wide) {
>> +		*filter_type =3D BPERF_FILTER_GLOBAL;
>> +		*filter_entry_cnt =3D 1;
>> +	} else if (target->cpu_list) {
>> +		*filter_type =3D BPERF_FILTER_CPU;
>> +		*filter_entry_cnt =3D perf_cpu_map__nr(evsel__cpus(evsel));
>> +	} else if (target->tid) {
>> +		*filter_type =3D BPERF_FILTER_PID;
>> +		*filter_entry_cnt =3D perf_thread_map__nr(evsel->core.threads);
>> +	} else if (target->pid) {
>> +		*filter_type =3D BPERF_FILTER_TGID;
>> +		*filter_entry_cnt =3D perf_thread_map__nr(evsel->core.threads);
>> +	} else {
>> +		pr_err("bpf managed perf events do not yet support these targets.\n")=
;
>> +		return -1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int bperf_reload_leader_program(struct evsel *evsel, int attr_ma=
p_fd,
>> +				       struct bperf_attr_map_entry *entry)
>> +{
>> +	struct bperf_leader_bpf *skel =3D NULL;
>=20
> Init it to NULL to then right away set it to the return of
> bperf_leader_bpf__open?
>=20
> see below
>=20
>> +	struct perf_cpu_map *all_cpus;
>> +	int link_fd, diff_map_fd, err;
>> +	struct bpf_link *link =3D NULL;
>> +
>> +	skel =3D bperf_leader_bpf__open();
>=20
> 	struct bperf_leader_bpf *skel =3D bperf_leader_bpf__open();
>=20
>> +	if (!skel) {
>> +		pr_err("Failed to open leader skeleton\n");
>> +		return -1;
>> +	}
>> +
>> +	bpf_map__resize(skel->maps.events, libbpf_num_possible_cpus());
>> +	err =3D bperf_leader_bpf__load(skel);
>> +	if (err) {
>> +		pr_err("Failed to load leader skeleton\n");
>> +		goto out;
>> +	}
>> +
>> +	err =3D -1;
>> +	link =3D bpf_program__attach(skel->progs.on_switch);
>> +	if (!link) {
>> +		pr_err("Failed to attach leader program\n");
>> +		goto out;
>> +	}
>> +
>> +	all_cpus =3D perf_cpu_map__new(NULL);
>> +	if (!all_cpus) {
>> +		pr_err("Failed to open cpu_map for all cpus\n");
>> +		goto out;
>> +	}
>=20
> If you reorder things maybe you can determine the number of possible
> cpus from all_cpus?

I tried to optimize the use of "all_cpus". But it we still call
perf_cpu_map__new(NULL) on each interval. Maybe we should just save=20
num_possible_cpu to evsel?=20

I will address the other feedbacks in v2.=20

Thanks,
Song


