Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B5233ACC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 08:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhCOHvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 03:51:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230486AbhCOHvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:51:17 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12F7mlx8011234;
        Mon, 15 Mar 2021 00:51:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2RPTfbJSwd7ci3uFaXga+EaGG94RCWbfjd8Jd+DW6kM=;
 b=MfKKckInH75QCg0igUmKYAExpeT2fOsOqBWkys22gsTuu2IHdjAokmTZJsQ2gjFKLiUc
 NCMiBTQmk/pUYRBU1KxNJ9+v44nTjxvsweQieAC7gqmNbFgp1qVq0W9buEJUQCKxBC6C
 +bsuVGpMiqI1NsRyiOGMjHXSmOvs83HR7oY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 378sxtpvv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Mar 2021 00:51:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 15 Mar 2021 00:51:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al5sgU1LJDfMboxPYk5HrNkTIvdxLEVApJX1XHbMgCaGwX2SlMHb33aqPeVeTNbNWX0JnNRWHbqTz5fPK4Oz572mdH+6WwOYcksPlCdILEo4kWRFXaz1wto3k92JH4fcUkbpEa3+QmnATWVZ94whZEIPoS6EXkU4XD5Buumm1ZgBoICKKHwsa3lenPX/xU958ZickZnM8AXqcsX2yMxIYdfYnmTGLb4bX8OHELr5Peg7XCBHGwOE5S1rAlH4Lb6rHngg5emKyb5qKNolxpxb1KxxCwXR1u6nNYlbG5VP8O1YPR1Pki3SSwMNPAtq6wtcJx+9Lvy6puRkonQJ1rIncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RPTfbJSwd7ci3uFaXga+EaGG94RCWbfjd8Jd+DW6kM=;
 b=ZkXlGKGs9TDNEXhLhZSwDWVgTVIzIPxPHWiR7wk6ezNvYYRLmsPiBZjT1EmDdDhyod96Jr2XtiLx1chm54f0YrPSNKmPrRW6McMkdSBXdvG06FVGFr+qP7Gx1dTE8x8zhDAhbV+9OE7atL0m9H0At109+mXx8I1+Jf+IgSNJWcETV4yo+Dx9Ae7oYj3mGlARLWRVfACh7HWiq/cnW+K6KW9aiNp/ncdE8WoPpalJ1Jcn928ODot2Ej5GiQQ031eSBGcLwUfgzFiQV40ZcKCRNwcnaiKOZRHU2hfKMqKCAdMVc3JC1L61mPeQdiEtWQo0GeEq+/qXkjzdvQwkOEkdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4233.namprd15.prod.outlook.com (2603:10b6:a03:2ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 07:51:12 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 07:51:12 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Topic: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Index: AQHXFuPifzAWbJ/c0EGfxtA8c/wTpKqEGnCAgACXtQA=
Date:   Mon, 15 Mar 2021 07:51:11 +0000
Message-ID: <95CDB411-4F73-4C56-8CA5-48C002F03ACF@fb.com>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <YE6Sq78CRmr/JsHl@krava>
In-Reply-To: <YE6Sq78CRmr/JsHl@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:17f0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c6ecab9-2a08-4faa-8e8f-08d8e7871a43
x-ms-traffictypediagnostic: SJ0PR15MB4233:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR15MB42338DEF39D6932323183B0FB36C9@SJ0PR15MB4233.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Ch0wennNBp5XFT7KqRmz7F4HJn9+15I1T4O32srZihFxAU0Y8QJ7r8yKWKQhJd+2WxNxnAtLqEes8znmQgzSPrVaqhHiyuth+6kCzbseex5OgCloZ6DaltgB+Vd5XzPTrRGh9Ni32D0ExZDPqTvQUp3to0ZaXt/HgrtmuyAdx3wlUJ5iTNmwykfH9GuBA0+SCpsipfjNi61ERPesPH4crhC/qJqMHQltjWsuKKuvFgyY/5rGzcbPEpWVDYxcpYoK9HcWgPlWvg8HYzlZnUZsXba1W9+N8KLpyARgZnS1iSi+XBrxAZ4jygIlewaNWJTCjgMBiogn5Ee9rSU/hUS6RWf+wW+I4TGFdsio256mbQNvY84iy/T3E8gspDEA8YbHsL0EIQv+9/TiPDCiFQ0eqv5wwr0+et7uCOoCeJH7B1nmIyVo16iVWUdwSVfkOySDb5Hfhdoye9ZFPbjaUErjoe0rhw7Y6mKgLoZ/S2h+PSBUAmfztB0X/dfjz2ae4d/DQdNW/XuRbhqZi3+ounfNu0o/E0nUjGBFtW5cPQg+JC6EnYDM/pnyGYzcCwaUxDFLMmDNHQ6Rud/fcZGe1MJ/etTHXitRPqHDtxFEw15QAYv0RdrNIq92f9sLH4PmQA0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(376002)(396003)(186003)(71200400001)(2906002)(91956017)(83380400001)(66476007)(6512007)(5660300002)(86362001)(2616005)(64756008)(8676002)(66446008)(6916009)(8936002)(6506007)(76116006)(36756003)(316002)(478600001)(54906003)(53546011)(4326008)(33656002)(6486002)(66556008)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QFoDuKnfMkpkC3pZiPdk+OEqQcGPdmxOLLI1afgWGBTm7kAlqkNdbblErIz0?=
 =?us-ascii?Q?6+ve4MPgNCDuZ+xndgGeGwhlOqrLhYmpA2SUgIaA+njUqcGK9QC0XSNSnFao?=
 =?us-ascii?Q?oFMXSntM9B+OHD9+TQYcLjtn+K9C0EaTlXsoyKyl5i7ts8rGzQhG7u06JQs8?=
 =?us-ascii?Q?Sz8AZNZUMuPyoKKfXqxmw+7V9BjcoPqL7oQ+8bg3ZPBanJSlWrHLd3kA9upB?=
 =?us-ascii?Q?B3EmtCrjVwFhuey3qp5tEyjDsGn6/HwY43AxqxUSszAzj1/3MPiaCy4m3IjO?=
 =?us-ascii?Q?uyPE5lejr5ivw/i3coq98p70qoO8zu8Tb2V7ur/hGPB0XXN0u+oEbTYSYneF?=
 =?us-ascii?Q?PX5qCfyQIo3ivCy/Bs26pt3w3s0UQutqWq2Y4CSA2qnxrKhKE0D9Ygu0Sr62?=
 =?us-ascii?Q?S8gKh9zLv5NlhL7+TYAnNWWAWl0gWDDQzypIMm6lnTD1IuuwPyuL3Mw8dTJK?=
 =?us-ascii?Q?czHub3EQXXLGr3GLOhS1ZIJLn5dRUhf1AR8TNHaINS7GB64w4QirmfYQjedA?=
 =?us-ascii?Q?4TRoSKQUxxYuLbbgahL+qgcOGvmCVKnpL3PTMkFrX6DGJlUkBUvSeRT5Rwf9?=
 =?us-ascii?Q?UEsVQzwFpaAeDVtLkzdAqpwLFchvGV0H+6621qugdxunbdV+9Iqjy6A8kLXX?=
 =?us-ascii?Q?CuQ6UP4aX29c4HHDBCJmYSaM+lY+PMU3uS4clQbR5JFWLpQlMHX2fLNRcKWq?=
 =?us-ascii?Q?g7ToUISH9026uhBRKDxfpJs/0EjIVCLXG1HhnzRIYaWIcgffKH+wLXK4jlwW?=
 =?us-ascii?Q?cLFcV9ZN4RikuCkO7m3RIOHKdW51gNfTxjPE+Je8LP2x8TixqBROXz32lm5k?=
 =?us-ascii?Q?aqJjv6+A808VaE2pzBc1cIMBgRbAVK9lWjTrZOJmvyU/PlLc0MllK8EPdEM/?=
 =?us-ascii?Q?9GTLN05vnjrifFEjeVMdVaZn4NH/KB6u2rbUE6q9jT0f+eQ3mGVJeJ/wXB7l?=
 =?us-ascii?Q?Lc8vuVuMHJnaFNyLOAx3kbBx8lji4opY8zHlNtGGCWVL2KmgSXleCCkz8cq2?=
 =?us-ascii?Q?EcHJfMya3+blHfIJNzc9qSLTqgy1ou0z3s4wEYHcS0xf5+etnPUG679RvIgd?=
 =?us-ascii?Q?MNeI9ITv3WioAihbajjNDV/04lsw6TUujFc7uKkbT4NFmbxonJQ2LWMv+X3h?=
 =?us-ascii?Q?hHlpjnWf62i0lIf9zHGZzSthsH+W5kFPP9tGw4YMVzd69b1vrJwV4UFIiUrb?=
 =?us-ascii?Q?5GaWdbpvfOqeAktwHGD2zQRuZsCURoFnKY6dHK/64YtppwUr19yAtmAtGSDn?=
 =?us-ascii?Q?WJJxek1vpd3t4QRwpu9nUmsrZ/e9g4HpvLfkotntJMlWysnF+DwnT5IUXNek?=
 =?us-ascii?Q?Pp2gHLysOq3PSpIUXvTwVvcOobW9NoYNBvkhRxmyuztrj+hQ4r1TVq67m2oq?=
 =?us-ascii?Q?lOO2wPg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E76CE951F1E6D44961DF06C7AB7172C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6ecab9-2a08-4faa-8e8f-08d8e7871a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 07:51:11.9571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f20rNYcB5cYHwXN2mjAsF1H0JsnoTsPC0tHRrBbSS19mOTl5qFqxt4gfiiU6L364TH5oSskgPANDhalUEhwcMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4233
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_03:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150053
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 14, 2021, at 3:48 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Mar 11, 2021 at 06:02:57PM -0800, Song Liu wrote:
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
>=20
> isn't that another filter via bpf_get_current_cgroup_id ?

This is tricky with nested cgroups. We also have bpf_get_current_ancestor_c=
group_id,
but that's not the exact same we need either. We may need a new helper.=20

Also, we are limited by 38 follower programs for the leader program, which=
=20
might be too few for Namhyung's use case. We can use some logic in the=20
follower program to count events for many cgroups in one fexit program.=20

>=20
>> 2. Do not support monitoring of BPF program (perf-stat -b);
>=20
> we'd need to call the leadr on fentry/fexit of the monitored bpf
> program, right?

My current plan is to let perf-stat -b share the same perf_event map with
bperf, but not the leader program.=20

>=20
>> 3. Do not support event groups.
>=20
> I guess for group support you'll need to load 'leaders' for each group me=
mber

I am not sure how this would work. Say the user started the following in=20
parallel:

    #1  perf stat --bpf-counters -e cycles -a &
    #2  perf stat --bpf-counters -e instructions -C 1,2,3 &
    #3  perf stat --bpf-counters -e {cycles,instructions} -p 123=20

Event "cycles" is loaded by #1; while event "instruction" is loaded by #2.
If #3 reuses these events, it is tricky (or impossible?) to make sure the
event group works as expected, right?

>=20
>>=20
>> The following commands have been tested:
>>=20
>>   perf stat --use-bpf -e cycles -a
>>   perf stat --use-bpf -e cycles -C 1,3,4
>>   perf stat --use-bpf -e cycles -p 123
>>   perf stat --use-bpf -e cycles -t 100,101
>=20
> works good with that file you sent.. I'll check/test more,
> so far some quick comments below
>=20
> thanks,
> jirka
>=20
>=20
>=20
> SNIP
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
> what's the point of allowing another name? just debug purpose?

It is mostly to cover corner cases, like something else used the same=20
name.=20

>=20
> SNIP
>=20
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
> we should make that with sysfs__mountpoint

Sounds great!

>=20
> SNIP
>=20
>> +static int bperf_reload_leader_program(struct evsel *evsel, int attr_ma=
p_fd,
>> +				       struct bperf_attr_map_entry *entry)
>> +{
>> +	struct bperf_leader_bpf *skel =3D NULL;
>> +	struct perf_cpu_map *all_cpus;
>> +	int link_fd, diff_map_fd, err;
>> +	struct bpf_link *link =3D NULL;
>> +
>> +	skel =3D bperf_leader_bpf__open();
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
>> +
>> +	link_fd =3D bpf_link__fd(link);
>> +	diff_map_fd =3D bpf_map__fd(skel->maps.diff_readings);
>> +	entry->link_id =3D bpf_link_get_id(link_fd);
>> +	entry->diff_map_id =3D bpf_map_get_id(diff_map_fd);
>> +	err =3D bpf_map_update_elem(attr_map_fd, &evsel->core.attr, entry, BPF=
_ANY);
>> +	assert(err =3D=3D 0);
>> +
>> +	evsel->bperf_leader_link_fd =3D bpf_link_get_fd_by_id(entry->link_id);
>> +	assert(evsel->bperf_leader_link_fd >=3D 0);
>> +
>> +	/* save leader_skel for install_pe */
>=20
> please add to the comment: ', which is called within following evsel__ope=
n_per_cpu call'
> or something like that..=20

Will add it in v2.=20

>=20
> SNIP
>=20
>> +static int bperf_sync_counters(struct evsel *evsel)
>> +{
>> +	struct perf_cpu_map *all_cpus =3D perf_cpu_map__new(NULL);
>> +	int num_cpu, i, cpu;
>> +
>> +	if (!all_cpus)
>> +		return -1;
>> +
>> +	num_cpu =3D all_cpus->nr;
>> +	for (i =3D 0; i < num_cpu; i++) {
>> +		cpu =3D all_cpus->map[i];
>> +		bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int bperf__enable(struct evsel *evsel)
>> +{
>> +	struct bperf_follower_bpf *skel =3D evsel->follower_skel;
>> +	__u32 num_cpu_bpf =3D libbpf_num_possible_cpus();
>=20
> we have cpu__max_cpu for that

libbpf calls for percpu array use libbpf_num_possible_cpus. So I guess it=20
is better to use the same here. The two are identical at the moment though.

>=20
>> +	struct bpf_perf_event_value values[num_cpu_bpf];
>> +	int err, i, entry_cnt;
>> +
>> +	err =3D bperf_follower_bpf__attach(evsel->follower_skel);
>> +	if (err)
>> +		return -1;
>=20
> could we attach it in load callback and have the some map
> value be checked in follower program and 'if value !=3D 0'
> it would let the program to continue.. I used/saw this
> in few bcc programs

Yeah, that's another way to eliminate the __attach() latency. Let me try it=
.=20

>=20
>> +
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

[...]

