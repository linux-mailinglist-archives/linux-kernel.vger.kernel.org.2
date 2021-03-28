Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EB634BD82
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 19:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhC1RRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 13:17:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38698 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230092AbhC1RR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 13:17:28 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12SHCpGM031746;
        Sun, 28 Mar 2021 10:17:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=8Dd7JZdpE/767WTUY7qrAgpc3RjexTblKH4kqRdulKE=;
 b=k4A0flyYXCKDQTc7RZB1udkobQh+7O/rYr9GFG6xxmmchPVq55ZMU1qipeGjIVYqw7D0
 FtUN7zo4qUwy/QS4kGrz0PEmeuRRQ0P99t9H76G+sSyg4ykP+7xRcqNHKyUP/ijGblsg
 Cg9BTwuf6BEJiFIdFKmbRWmvPctGZirL/CM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37j0cpmra3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Mar 2021 10:17:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 28 Mar 2021 10:17:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQtYNChmcToyyYAYw+5XN/wzYv8mdfU6N36Bfn2QWwyBciEb297KfsuC8/Qq2dALbzDkbviCW3LiREgy+CF4pcBMHTkkerCo6aDP9/3dRuRzstmTGPvEaQNrrQxcopSmb1hbhauLenZMpCyc+sup1QpGjHQff8meu6CboxFMk/hhxJunmE17KwyK66T3J7/HpUxrKotL7imy51jO5/QAjALOSk9I/I9rS+ZLFEZjQLXGFpcX1nnO2hGfdtZpIelM55vJEaCwYPSM7aYp4gaJ3c3TxjnWv/vBKFqEVRQHU6+2HOrXAgGdFvX1L/zvbxrKVl6VVtT0tV47YFblNTAVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Dd7JZdpE/767WTUY7qrAgpc3RjexTblKH4kqRdulKE=;
 b=FQNq030LT9XVz2YeLydw7XsZucaOunLvKAFyGvZV2nKYSCH/YC+fa/W02avsY44X34keDLeXhOBfyilqoX6Reluyl31/5R0ynpP4uIzUVeHMjTjMFBJuKrwuVfUKXjvMAZsyHZS7DtV4YJ844KhoaKvRaiX/7j56o6KkyStpQnw64/A4wvbxWot/4jZsGMItr7HCnbCkFJ+cn5/u7Kfz9CHuc5WQNVM11nAxjYHwakCsZJnFbIc4emXrYdITj+wOTaNXsnTQnhUVbkLb5Q8qRq70eez7poAM56YuDQwRbr68al8yElQZfEEH+UaehKJ1OOryvsdST1EzESrx8I1kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sun, 28 Mar
 2021 17:17:03 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Sun, 28 Mar 2021
 17:17:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Ian Rogers" <irogers@google.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] perf/core: Share an event with multiple cgroups
Thread-Topic: [PATCH 1/2] perf/core: Share an event with multiple cgroups
Thread-Index: AQHXIACsCyQjF284/Uq+advPGrds7aqZrFQA
Date:   Sun, 28 Mar 2021 17:17:03 +0000
Message-ID: <180E871A-7C5E-4DB2-80F4-643237A7FA69@fb.com>
References: <20210323162156.1340260-1-namhyung@kernel.org>
 <20210323162156.1340260-2-namhyung@kernel.org>
In-Reply-To: <20210323162156.1340260-2-namhyung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:4e3b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39622fb9-9635-4076-87f5-08d8f20d4e4d
x-ms-traffictypediagnostic: BYAPR15MB2999:
x-microsoft-antispam-prvs: <BYAPR15MB29994983200063A36F2F2409B37F9@BYAPR15MB2999.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4XgTID89TDjqRhGNynep89f33HZnfzJREsK2BQHY9m/4BCqTUJxCjHyDwbiOSweXYaQeLaaE0X0b0M44+dSBYvvCuGonMknKkvQAUE4ufVpMm4Y4oT2V16QmeGCoFpRkhW02iwc+h4N8PeiRgY+kI2WF/0H567c9U+DPaevUDv8Wso3RNLievzRsg/WVJrgO92SzT3LIefDguaCWf0PD50z5NRa/AvCFFIXU3ueNYOaFMLYFNhzh+b9rm/7+nN1uS3tJdY3W4rUKxMJv/kjtX/Vpg2771QP9zacfXH9eU/hzNJhSfKtNIf50Qa9+pw6pJvSK2tJ+XB8bl9841Kij5rQyeZP06Bd+GcJgeUa59uBwAE62K+uLNnnL/z68sGtK1RRuqbbbKEMYbAbktAmfrlunNb88vyl8I9edYjyHEAx0n5PxLBnFyZ334qLbUC5R0I4LWHeDS1krHf6RAjIvWQRztjKz8V2MJ88LBTCv9yK5V1+RafARK1gidVaWlVxo+Uxq9iN6B8zaSWDU0Rtvt/uidR7xZNQdzDGA2DlS2xk1NNrGFyxojV7j1aftQjqvIwSmZVpzjsCiUXHtux1ARddDsbJ4MvZO1Kep67akDELwtcdnT7pNBYpKVDQxVxgFd7+0QDhiVo7x2jPPBEnGpmp3TjUXi+URtHO7KXkYQsorTfbf3By6VYbD6OBBs/Ja
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(478600001)(33656002)(6486002)(53546011)(4326008)(6506007)(83380400001)(66476007)(66556008)(54906003)(66946007)(91956017)(6916009)(186003)(36756003)(6512007)(5660300002)(86362001)(76116006)(2616005)(7416002)(2906002)(8676002)(316002)(71200400001)(8936002)(38100700001)(64756008)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ibPGhkvOoj6mW8Rond6fNo43jgCX/gc0Q9hIe2BzOlUT7oiDlUvx82Z1W6Yw?=
 =?us-ascii?Q?irRu5YGOjO6Ewcfbq/pmN1tOIhG5xKRYD639AZthsKFMu4HdxLds8bRP/Ain?=
 =?us-ascii?Q?3fGXqCzC1gqf1ZHia2Uh1QNdAWY9tbYqIbCR8bVj0M8mIu86952BRctSpCs7?=
 =?us-ascii?Q?EZjtqWkQLrS9RTCWb/KZ5h0bk5Dwg+MS76tGjtmjvZBzHc1x1xbbaulARtiB?=
 =?us-ascii?Q?WB9bjp5KkhWTDvN+cL67JsMn/OPwbWCzRlItOAqYcS32m4FlwLLkrcuMkuiy?=
 =?us-ascii?Q?lDxQTAGW0pttpmjt2kmsR82T2dYxbwTqGkzbPkyr0KdV9fxRRKbliN4MFD/A?=
 =?us-ascii?Q?XGoyjl5SkFjQrz88jOAdWC0eT6w05LQxALQHORzqX2eApdD7iiJOvUynRW8C?=
 =?us-ascii?Q?MSxbUztvA0+1nQu2EqFfjXRIh1oa0vxoO8b0330+a968ljcjPBRUQGkV+Qrg?=
 =?us-ascii?Q?jcoi6ATeRH3nc/2/+GUXEZXIiSKiDDHoS3nUv5DFy5L+iYNEiRjv49XD0oJw?=
 =?us-ascii?Q?8sV83cpVwM7aCS7DCiopbcsh3T2xjH90DfivYho85UudGHUKttQM5Pe0JHOd?=
 =?us-ascii?Q?7imcDm/r+60egIcUUcksECXlHLci2jG+04uYzx0gFGf2C2O5KMXJw6U0yI8f?=
 =?us-ascii?Q?ULzLzXAk9/3FrroC0uGYpciWiIvUoRIqhVkFgLxWWe+g/ovTVEAD0rrolrhz?=
 =?us-ascii?Q?/587lVNy7qsp9SrOo+4wLHti2L9dyfIMNgmiR1x5/2I3efTjoGlDvL1FOLGd?=
 =?us-ascii?Q?LblyeG3uWX9yfuxa7ShLg5E5MpQ46rWQLW9OshFXUpeXMclvQxu1y94f4O3E?=
 =?us-ascii?Q?aIowrIkgy8m18qnBdzhtB4Xp6teZZKEndvGvshjxr1gawe5oHw5zyBk/AvUa?=
 =?us-ascii?Q?tIW5QW3fbF2SSvqdZGia7CWm8rV5TmcE2Bbqe+qps5gPHc/8MAGQnUos8j8N?=
 =?us-ascii?Q?ccZkczlDfI4b3qZgv2E/LBuCD3yVcoQpKV2sDeahF7pUtTw+eorar5DT3Ef+?=
 =?us-ascii?Q?LE6iqdjCNw5f6hGf9Nd3RWgYZYz0o4hcJ27BvAMCFYcYwq+JeToZL5czlJ3x?=
 =?us-ascii?Q?c/hurAP8/mn4n8OGFr25R1ZKILDsv4+f9Bl8vnN0xnyJgEnNyirCPj0lY+23?=
 =?us-ascii?Q?e1WsCIvfjDxy6XtxbA4FsReZq72Ol47awpnd7gz7CaLN4Mnt0kUfwF180SgE?=
 =?us-ascii?Q?Y8Cg3hTdFKBjk8GYgaZG9OzZg302u08NB7d5Q6pfcvbN7yuiJxQJD/QgYakK?=
 =?us-ascii?Q?BkcDGu72ASsuPZqwn/RPNECXBIGv+FaFXobsA61Jh9qiqBE3NEpOkOAuv4kU?=
 =?us-ascii?Q?YB03BzTWeKIr7avBmBzzEZI025/HmLnPmLv+mXLD0PO2EbHXdUac+nTOOZOW?=
 =?us-ascii?Q?y7PQxTs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C457B32BD4D7224180E9188A83B87A71@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39622fb9-9635-4076-87f5-08d8f20d4e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2021 17:17:03.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oy3yXh8eVkfRYoilqrgk5RwRaWR5pbPeA5tp/Wub7rgw4odquLaz/X5zwcR3JTRwuIplqOSepSJ0B3VA2Y8PRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2999
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: yxHEzJa1QTn9A8mT09_Chw_9uBGJ3ztr
X-Proofpoint-ORIG-GUID: yxHEzJa1QTn9A8mT09_Chw_9uBGJ3ztr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_08:2021-03-26,2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 23, 2021, at 9:21 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> As we can run many jobs (in container) on a big machine, we want to
> measure each job's performance during the run.  To do that, the
> perf_event can be associated to a cgroup to measure it only.
>=20
> However such cgroup events need to be opened separately and it causes
> significant overhead in event multiplexing during the context switch
> as well as resource consumption like in file descriptors and memory
> footprint.
>=20
> As a cgroup event is basically a cpu event, we can share a single cpu
> event for multiple cgroups.  All we need is a separate counter (and
> two timing variables) for each cgroup.  I added a hash table to map
> from cgroup id to the attached cgroups.
>=20
> With this change, the cpu event needs to calculate a delta of event
> counter values when the cgroups of current and the next task are
> different.  And it attributes the delta to the current task's cgroup.
>=20
> This patch adds two new ioctl commands to perf_event for light-weight
> cgroup event counting (i.e. perf stat).
>=20
> * PERF_EVENT_IOC_ATTACH_CGROUP - it takes a buffer consists of a
>     64-bit array to attach given cgroups.  The first element is a
>     number of cgroups in the buffer, and the rest is a list of cgroup
>     ids to add a cgroup info to the given event.
>=20
> * PERF_EVENT_IOC_READ_CGROUP - it takes a buffer consists of a 64-bit
>     array to get the event counter values.  The first element is size
>     of the array in byte, and the second element is a cgroup id to
>     read.  The rest is to save the counter value and timings.
>=20
> This attaches all cgroups in a single syscall and I didn't add the
> DETACH command deliberately to make the implementation simple.  The
> attached cgroup nodes would be deleted when the file descriptor of the
> perf_event is closed.
>=20
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> include/linux/perf_event.h      |  22 ++
> include/uapi/linux/perf_event.h |   2 +
> kernel/events/core.c            | 474 ++++++++++++++++++++++++++++++--
> 3 files changed, 471 insertions(+), 27 deletions(-)

[...]

> @@ -4461,6 +4787,8 @@ static void __perf_event_init_context(struct perf_e=
vent_context *ctx)
> 	INIT_LIST_HEAD(&ctx->event_list);
> 	INIT_LIST_HEAD(&ctx->pinned_active);
> 	INIT_LIST_HEAD(&ctx->flexible_active);
> +	INIT_LIST_HEAD(&ctx->cgrp_ctx_entry);
> +	INIT_LIST_HEAD(&ctx->cgrp_node_list);

I guess we need ifdef CONFIG_CGROUP_PERF here?

> 	refcount_set(&ctx->refcount, 1);
> }
>=20
> @@ -4851,6 +5179,8 @@ static void _free_event(struct perf_event *event)
> 	if (is_cgroup_event(event))
> 		perf_detach_cgroup(event);
>=20
> +	perf_event_destroy_cgroup_nodes(event);
> +
> 	if (!event->parent) {
> 		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> 			put_callchain_buffers();

[...]

> +static void perf_sched_enable(void)
> +{
> +	/*
> +	 * We need the mutex here because static_branch_enable()
> +	 * must complete *before* the perf_sched_count increment
> +	 * becomes visible.
> +	 */
> +	if (atomic_inc_not_zero(&perf_sched_count))
> +		return;

Why don't we use perf_cgroup_events for the new use case?=20

> +
> +	mutex_lock(&perf_sched_mutex);
> +	if (!atomic_read(&perf_sched_count)) {
> +		static_branch_enable(&perf_sched_events);
> +		/*
> +		 * Guarantee that all CPUs observe they key change and
> +		 * call the perf scheduling hooks before proceeding to
> +		 * install events that need them.
> +		 */
> +		synchronize_rcu();
> +	}
> +	/*
> +	 * Now that we have waited for the sync_sched(), allow further
> +	 * increments to by-pass the mutex.
> +	 */
> +	atomic_inc(&perf_sched_count);
> +	mutex_unlock(&perf_sched_mutex);
> +}
> +
> static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long=
 arg)
> {
> 	struct perf_event *event =3D file->private_data;
> 	struct perf_event_context *ctx;
> +	bool do_sched_enable =3D false;
> 	long ret;
>=20
> 	/* Treat ioctl like writes as it is likely a mutating operation. */
> @@ -5595,9 +6006,19 @@ static long perf_ioctl(struct file *file, unsigned=
 int cmd, unsigned long arg)
> 		return ret;
>=20
> 	ctx =3D perf_event_ctx_lock(event);
> +	/* ATTACH_CGROUP requires context switch callback */
> +	if (cmd =3D=3D PERF_EVENT_IOC_ATTACH_CGROUP && !event_has_cgroup_node(e=
vent))
> +		do_sched_enable =3D true;
> 	ret =3D _perf_ioctl(event, cmd, arg);
> 	perf_event_ctx_unlock(event, ctx);
>=20
> +	/*
> +	 * Due to the circular lock dependency, it cannot call
> +	 * static_branch_enable() under the ctx->mutex.
> +	 */
> +	if (do_sched_enable && ret >=3D 0)
> +		perf_sched_enable();
> +
> 	return ret;
> }
>=20
> @@ -11240,33 +11661,8 @@ static void account_event(struct perf_event *eve=
nt)
> 	if (event->attr.text_poke)
> 		atomic_inc(&nr_text_poke_events);
>=20
> -	if (inc) {
> -		/*
> -		 * We need the mutex here because static_branch_enable()
> -		 * must complete *before* the perf_sched_count increment
> -		 * becomes visible.
> -		 */
> -		if (atomic_inc_not_zero(&perf_sched_count))
> -			goto enabled;
> -
> -		mutex_lock(&perf_sched_mutex);
> -		if (!atomic_read(&perf_sched_count)) {
> -			static_branch_enable(&perf_sched_events);
> -			/*
> -			 * Guarantee that all CPUs observe they key change and
> -			 * call the perf scheduling hooks before proceeding to
> -			 * install events that need them.
> -			 */
> -			synchronize_rcu();
> -		}
> -		/*
> -		 * Now that we have waited for the sync_sched(), allow further
> -		 * increments to by-pass the mutex.
> -		 */
> -		atomic_inc(&perf_sched_count);
> -		mutex_unlock(&perf_sched_mutex);
> -	}
> -enabled:
> +	if (inc)
> +		perf_sched_enable();
>=20
> 	account_event_cpu(event, event->cpu);
>=20
> @@ -13008,6 +13404,7 @@ static void __init perf_event_init_all_cpus(void)
>=20
> #ifdef CONFIG_CGROUP_PERF
> 		INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
> +		INIT_LIST_HEAD(&per_cpu(cgroup_ctx_list, cpu));
> #endif
> 		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
> 	}
> @@ -13218,6 +13615,28 @@ static int perf_cgroup_css_online(struct cgroup_=
subsys_state *css)
> 	return 0;
> }
>=20
> +static int __perf_cgroup_update_node(void *info)
> +{
> +	struct task_struct *task =3D info;
> +
> +	rcu_read_lock();
> +	cgroup_node_sched_out(task);
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +
> +static int perf_cgroup_can_attach(struct cgroup_taskset *tset)
> +{
> +	struct task_struct *task;
> +	struct cgroup_subsys_state *css;
> +
> +	cgroup_taskset_for_each(task, css, tset)
> +		task_function_call(task, __perf_cgroup_update_node, task);
> +
> +	return 0;
> +}

Could you please explain why we need this logic in can_attach?=20

Thanks,
Song=
