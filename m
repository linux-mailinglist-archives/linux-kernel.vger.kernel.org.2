Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA2334861F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbhCYA4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:56:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1366 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232856AbhCYA4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:56:11 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12P0q1eQ013664;
        Wed, 24 Mar 2021 17:55:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NBkTSSNTCSL63YgxwGu7DFFTSw2JEJslCYEOhB/t8f8=;
 b=JttxACtDvILG+7WhFbYRg+ShBwXd89wJq6ejNgqTrfqMfcVkjvvozysQWGrRv2nWdH6c
 d/mQrQCsk9CLHmZSuS23nKMou9npcIrfa1GwdAT4G/rZVkH2B3iSGCC5x7ipvW04G4pT
 SnG6vdGLcyRBXGC5m5IbFjqXwcxrNWX4Ysc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 37g173nhru-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Mar 2021 17:55:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 17:55:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaIopzZh6b1yI6KtPPHyfW0aXN776CpgI84VGuTrXH98PnBpZp1nrlf1Fkf+fAbXMMNf/hCSLp1l3LHSuF1tKiUNbeZlr7PDZuyp2vl/ghLAMS19jd/V/HmYRbDjqg5+UmHrlQOZvGk9AnwK8k6IdCZNz6OBjviKkCAhDUAcJy8Tb50p6fTbroDHbI+S/IasHzAZQUZfxfEamID5Q/pIYzb6yKNRNPTokclnJQ1YWtbq/5ly/DIXLq8lE+lj/nqLhuMkbFqdQDBW0cH+grM3ObHIBnPrToORqWhSln9Q5nHAt+JKQNUDQCcD0eh+HsLfpZ87EekAyjic6G0Cb+zTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBkTSSNTCSL63YgxwGu7DFFTSw2JEJslCYEOhB/t8f8=;
 b=ImcPT48cbLfVs7Gyb0fkMd52dBrnu7EqNWb6iNm1HhDtBSy4LAj2nQy13WKipHps+dDnxS34WdseZI754/BQSAssBuzXJ2SZ7YR2HxzsBYzViNTy0gL2Idrx/AOm0s3HTbL25rDpWzMOCDRSc920eEBk5rzjAxQSjCG1c3YXxhfAxzML2vMJkuMYZhRKYOp3IH1eCbzjgpKeteumntGRvd0krGmcQhE8BCZcB8mg/rez0SSS83iQb0h7zxQUC7IueeLiLK+yhUdrdWd8V6S7XY0+UV2QUBwea1keGOYV/TQhedRBa3Y5307rmuTwDDkwsvI4MwAxKfM+erj0gGptFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2823.namprd15.prod.outlook.com (2603:10b6:a03:15a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 25 Mar
 2021 00:55:51 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.036; Thu, 25 Mar 2021
 00:55:51 +0000
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
Thread-Index: AQHXIACsCyQjF284/Uq+advPGrds7aqT4y+A
Date:   Thu, 25 Mar 2021 00:55:50 +0000
Message-ID: <C0AF9F1F-F525-4047-AD89-F75E3FEFC215@fb.com>
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
x-originating-ip: [2620:10d:c090:400::5:efc5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03283040-068a-449f-bfa6-08d8ef28bc5e
x-ms-traffictypediagnostic: BYAPR15MB2823:
x-microsoft-antispam-prvs: <BYAPR15MB28238F6EE0E0A8BCE6F0358BB3629@BYAPR15MB2823.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gB7S2z/Z/dSBA1eMvTj9G6tOPhroKWQyOotedlUaoXhLoESgUOw9FgQTvndRquKVH+UomTmMiEvNcreH9he4DrOtklv/Csf3T5KcBq+w8h1J+9AdPe9A88Vxpk7imMyw618vrhWQSejAOADW0BsMrtAUZJkgK5RFqXf/sC/8I7H1YgRrLvXc5aHVkeQ/0BK9gCRe1zPQdK/WZ5hZmRwTq339UGc9HAcE6psWkK0TRXTnIh1InZSmx2retUxTIzkjLuWqhsC/IfyKm7LJahGEtw7lIc4mF7OZEcwHj4Uj1NAOAGTYB3EhIO/e8+1o0LC/Wdgw6l5/WAxrPi6W1T8d7FMaQxhpEecZabHxk1SSJ60nrrxJUqM4xY/nqXcE78pbYmo3wZJsBiXk1+yinMQIZyQdlupNxqMlO3q8jooE8VfAxOrC1TuenWyyNML5q6uxNSkQsuofMQtesVRVpVzGH2fjdAlf3Ovpet3Tv8sY1upunfwVH404PrQMMMo8pIoi32qGE8xQYAztMzwbuq629UvdOQ+0cePuOqidnF5KIUhDHK27L1wFAvvqVFEKKFjBKC+T9jsjb+27dNB80+xTj3IIuxAMCzNc9hG5+bXByuS4ii+Y47CHYaUyaWd+XfEBRf8MBvra3DH5FdW1P9m96hxcMhj40iGywaa1NrVRo38KRrxp4xATILmO7paZd+hb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(396003)(346002)(39860400002)(186003)(2616005)(316002)(2906002)(6486002)(54906003)(38100700001)(64756008)(86362001)(83380400001)(36756003)(7416002)(71200400001)(6512007)(6916009)(6506007)(66476007)(478600001)(91956017)(8676002)(5660300002)(53546011)(8936002)(30864003)(4326008)(76116006)(66446008)(66556008)(33656002)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kTuFwgRwLOCptEeqw6uwPppsZ/9DVk9gvrm1uS8gL2k4IKYdYNOsStNzkpd+?=
 =?us-ascii?Q?BgleqkISvcgp8q5sYFrVtxcyt1CoF2K1WxCzu+Jwr2L5Wtaf0FP7o1TV+nWj?=
 =?us-ascii?Q?pWxmM/T6ETzh2G2OZS4tKaOgLnSuTibp2TNyGGdWw5I8q5OCTXraFD6yk4+l?=
 =?us-ascii?Q?8KQDlH22LZ3IoFpdG9X2uKQuVSJidHmIgw5A5kqioA9C8NFRwd13HttSWaiv?=
 =?us-ascii?Q?zoeZ+8J+5D1nR8LMLnooW+fPtx8Q+xjegyqNT13BbxJshAx6vdv9qIbJiWq3?=
 =?us-ascii?Q?JkDR699i2eKPqPDtZbt5COqg7NmIkSMDQ3wuqk8g4loLe0nmRke92TPyr+1E?=
 =?us-ascii?Q?2c8FOvMKDevZzLR8Pr0PDhkJ55+h3zZXXLTs/7TDfBKVhCxVN+EUUEp07Ow2?=
 =?us-ascii?Q?jOxkYYkgdJGGUn0jjQjHL0zP5TeFwKR0+kpVOya779uIi74poDFkOtY4jGY3?=
 =?us-ascii?Q?PHhyihfOyVVmR8JdsL0W8wKESFkL5MO4lKWTjVZaVZ7KQyJVDhIhqdGoFvTw?=
 =?us-ascii?Q?gmBBa4SDV4MhTJQ8ugc74uezqchoaY8Et08Ui9g4sFnJLE6aCpY93qTRFIzE?=
 =?us-ascii?Q?0l+MS/r0fmgYZolXsv2LIRgjBQwuxQfLBzxtVPMO2nEtPinCFUFvA6I8df/1?=
 =?us-ascii?Q?EL0aC+aWr7UiopdBgqvHpvgP75RjlMQqoP+qALIsF5i1RTnysJezoxI/EtTp?=
 =?us-ascii?Q?n1jYQ/hJfFrEGsPukPJjRQRio8Xq8rt3alUOtjE9ht/lRa0KKf0OWxKSc+91?=
 =?us-ascii?Q?tUxPvAduC8DoRXM43A8wX0VCcouFn3u4VFX2T3mx6yTyEstKBKlHei1d03of?=
 =?us-ascii?Q?sP6ltKO2j2Y/pWYa5XdGaiG237aPPCfUay3H/RLKCoSxP9HUBrxg5x50qL7a?=
 =?us-ascii?Q?b8FI/pVDFzMev9Rtp4CJtCmHfAdmGLeopc5HYBB2cm2gbRxw8DKW2Ht9lqz0?=
 =?us-ascii?Q?XWxBLL5huL7hZ4Cv+J8+bKvquC4/L5QICh2qllmXhpLlqB3OlNQzliMzcVew?=
 =?us-ascii?Q?e5cdjR12SvlcA8bNFH0/rYN+qQi99cSFKds915re80YuRubK0sTZHSX6jMiw?=
 =?us-ascii?Q?yzdjkjr1vcPajTYdEHcdVo8D4gh/4p8gH5YGL6x4YiBxdsnczgcfRTeNosFW?=
 =?us-ascii?Q?NoPZFs8TjJCgikt7r5PQ3unwRsOP4xsc60d0FPB5rjrhNYlvJ3VVpndymhX8?=
 =?us-ascii?Q?voPunSMlNUjZjYJsl2BsMKJFHR1UkOkCXIL3i/5cv/4+x4YQxhP7bJMFDmrv?=
 =?us-ascii?Q?9O44AdPZ9U9QN1p6ECUWXzajt8QQfuRwYc+MYTP2X032lfvAzSyRmca+7VuD?=
 =?us-ascii?Q?IVd8rb54mFIATBSZctFA/SstD6x0BhvWtASGpXXdB9iZgX5APTcRoYjKz0m5?=
 =?us-ascii?Q?ZgPRu4Q=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E470787650FF14DBA2A14B183C28848@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03283040-068a-449f-bfa6-08d8ef28bc5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 00:55:50.8592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2ei0daiI92B89I4zU/b9OzfZd+/ZpJNbGkqdDe42xnS/dTv6TRdVDz6CSYGtW+I6xlMjmN2fVm5z3FWcWnLkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2823
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_14:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250002
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
>=20
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 3f7f89ea5e51..2760f3b07534 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -771,6 +771,18 @@ struct perf_event {
>=20
> #ifdef CONFIG_CGROUP_PERF
> 	struct perf_cgroup		*cgrp; /* cgroup event is attach to */
> +
> +	/* to share an event for multiple cgroups */
> +	struct hlist_head		*cgrp_node_hash;
> +	struct perf_cgroup_node		*cgrp_node_entries;
> +	int				nr_cgrp_nodes;
> +	int				cgrp_node_hash_bits;
> +
> +	struct list_head		cgrp_node_entry;
> +
> +	u64				cgrp_node_count;
> +	u64				cgrp_node_time_enabled;
> +	u64				cgrp_node_time_running;

A comment saying the above values are from previous reading would be helpfu=
l.=20

> #endif
>=20
> #ifdef CONFIG_SECURITY
> @@ -780,6 +792,14 @@ struct perf_event {
> #endif /* CONFIG_PERF_EVENTS */
> };
>=20
> +struct perf_cgroup_node {
> +	struct hlist_node		node;
> +	u64				id;
> +	u64				count;
> +	u64				time_enabled;
> +	u64				time_running;
> +	u64				padding[2];

Do we really need the padding? For cache line alignment?=20

> +};
>=20
> struct perf_event_groups {
> 	struct rb_root	tree;
> @@ -843,6 +863,8 @@ struct perf_event_context {
> 	int				pin_count;
> #ifdef CONFIG_CGROUP_PERF
> 	int				nr_cgroups;	 /* cgroup evts */
> +	struct list_head		cgrp_node_list;
> +	struct list_head		cgrp_ctx_entry;
> #endif
> 	void				*task_ctx_data; /* pmu specific data */
> 	struct rcu_head			rcu_head;
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_ev=
ent.h
> index ad15e40d7f5d..06bc7ab13616 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -479,6 +479,8 @@ struct perf_event_query_bpf {
> #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
> #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_=
bpf *)
> #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_=
attr *)
> +#define PERF_EVENT_IOC_ATTACH_CGROUP		_IOW('$', 12, __u64 *)
> +#define PERF_EVENT_IOC_READ_CGROUP		_IOWR('$', 13, __u64 *)
>=20
> enum perf_event_ioc_flags {
> 	PERF_IOC_FLAG_GROUP		=3D 1U << 0,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f07943183041..38c26a23418a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -379,6 +379,7 @@ enum event_type_t {
>  * perf_cgroup_events: >0 per-cpu cgroup events exist on this cpu
>  */
>=20
> +static void perf_sched_enable(void);
> static void perf_sched_delayed(struct work_struct *work);
> DEFINE_STATIC_KEY_FALSE(perf_sched_events);
> static DECLARE_DELAYED_WORK(perf_sched_work, perf_sched_delayed);
> @@ -2124,6 +2125,322 @@ static int perf_get_aux_event(struct perf_event *=
event,
> 	return 1;
> }
>=20
> +#ifdef CONFIG_CGROUP_PERF
> +static DEFINE_PER_CPU(struct list_head, cgroup_ctx_list);
> +
> +static bool event_can_attach_cgroup(struct perf_event *event)
> +{
> +	if (is_sampling_event(event))
> +		return false;
> +	if (event->attach_state & PERF_ATTACH_TASK)
> +		return false;
> +	if (is_cgroup_event(event))
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool event_has_cgroup_node(struct perf_event *event)
> +{
> +	return event->nr_cgrp_nodes > 0;
> +}
> +
> +static struct perf_cgroup_node *
> +find_cgroup_node(struct perf_event *event, u64 cgrp_id)
> +{
> +	struct perf_cgroup_node *cgrp_node;
> +	int key =3D hash_64(cgrp_id, event->cgrp_node_hash_bits);
> +
> +	hlist_for_each_entry(cgrp_node, &event->cgrp_node_hash[key], node) {
> +		if (cgrp_node->id =3D=3D cgrp_id)
> +			return cgrp_node;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void perf_update_cgroup_node(struct perf_event *event, struct cgr=
oup *cgrp)
> +{
> +	u64 delta_count, delta_time_enabled, delta_time_running;
> +	int i;
> +
> +	if (event->cgrp_node_count =3D=3D 0)

Do you mean to use nr_cgrp_nodes above?=20

> +		goto out;
> +
> +	delta_count =3D local64_read(&event->count) - event->cgrp_node_count;
> +	delta_time_enabled =3D event->total_time_enabled - event->cgrp_node_tim=
e_enabled;
> +	delta_time_running =3D event->total_time_running - event->cgrp_node_tim=
e_running;
> +
> +	/* account delta to all ancestor cgroups */
> +	for (i =3D 0; i <=3D cgrp->level; i++) {
> +		struct perf_cgroup_node *node;
> +
> +		node =3D find_cgroup_node(event, cgrp->ancestor_ids[i]);
> +		if (node) {
> +			node->count +=3D delta_count;
> +			node->time_enabled +=3D delta_time_enabled;
> +			node->time_running +=3D delta_time_running;
> +		}
> +	}
> +
> +out:
> +	event->cgrp_node_count =3D local64_read(&event->count);
> +	event->cgrp_node_time_enabled =3D event->total_time_enabled;
> +	event->cgrp_node_time_running =3D event->total_time_running;
> +}
> +
> +static void update_cgroup_node(struct perf_event *event, struct cgroup *=
cgrp)
> +{
> +	if (event->state =3D=3D PERF_EVENT_STATE_ACTIVE)
> +		event->pmu->read(event);
> +
> +	perf_event_update_time(event);
> +	perf_update_cgroup_node(event, cgrp);
> +}
> +
> +/* this is called from context switch */
> +static void update_cgroup_node_events(struct perf_event_context *ctx,
> +				      struct cgroup *cgrp)
> +{
> +	struct perf_event *event;
> +
> +	lockdep_assert_held(&ctx->lock);
> +
> +	if (ctx->is_active & EVENT_TIME)
> +		update_context_time(ctx);
> +
> +	list_for_each_entry(event, &ctx->cgrp_node_list, cgrp_node_entry)
> +		update_cgroup_node(event, cgrp);
> +}
> +
> +static void cgroup_node_sched_out(struct task_struct *task)
> +{
> +	struct list_head *cgrp_ctx_list =3D this_cpu_ptr(&cgroup_ctx_list);
> +	struct perf_cgroup *cgrp =3D perf_cgroup_from_task(task, NULL);
> +	struct perf_event_context *ctx;
> +
> +	list_for_each_entry(ctx, cgrp_ctx_list, cgrp_ctx_entry) {
> +		raw_spin_lock(&ctx->lock);
> +		update_cgroup_node_events(ctx, cgrp->css.cgroup);
> +		raw_spin_unlock(&ctx->lock);
> +	}
> +}
> +
> +/* this is called from the when event is enabled/disabled */

I don't think we call this when the event is disabled.=20

> +static void perf_add_cgrp_node_list(struct perf_event *event,
> +				    struct perf_event_context *ctx)
> +{
> +	struct list_head *cgrp_ctx_list =3D this_cpu_ptr(&cgroup_ctx_list);
> +	struct perf_cgroup *cgrp =3D perf_cgroup_from_task(current, ctx);
> +	bool is_first;
> +
> +	lockdep_assert_irqs_disabled();
> +	lockdep_assert_held(&ctx->lock);
> +
> +	is_first =3D list_empty(&ctx->cgrp_node_list);
> +	list_add_tail(&event->cgrp_node_entry, &ctx->cgrp_node_list);
> +
> +	if (is_first)
> +		list_add_tail(&ctx->cgrp_ctx_entry, cgrp_ctx_list);
> +
> +	update_cgroup_node(event, cgrp->css.cgroup);

Will this add some readings before PERF_EVENT_IOC_ATTACH_CGROUP to the coun=
ters?

> +
> }
> +
> +static void perf_del_cgrp_node_list(struct perf_event *event,
> +				    struct perf_event_context *ctx)
> +{
> +	struct perf_cgroup *cgrp =3D perf_cgroup_from_task(current, ctx);
> +
> +	lockdep_assert_irqs_disabled();
> +	lockdep_assert_held(&ctx->lock);
> +
> +	update_cgroup_node(event, cgrp->css.cgroup);
> +	/* to refresh delta when it's enabled */
> +	event->cgrp_node_count =3D 0;
> +
> +	list_del(&event->cgrp_node_entry);
> +
> +	if (list_empty(&ctx->cgrp_node_list))
> +		list_del(&ctx->cgrp_ctx_entry);
> +}
> +
[...]
> +
> +/* this is called from ioctl */
> +static int perf_event_attach_cgroup_node(struct perf_event *event, u64 n=
r_cgrps,
> +					 u64 *cgroup_ids)
> +{
> +	struct perf_cgroup_node *cgrp_node;
> +	struct perf_event_context *ctx =3D event->ctx;
> +	struct hlist_head *cgrp_node_hash;
> +	int node =3D (event->cpu >=3D 0) ? cpu_to_node(event->cpu) : -1;
> +	unsigned long flags;
> +	bool is_first =3D true;
> +	bool enabled;
> +	int i, nr_hash;
> +	int hash_bits;
> +
> +	if (nr_cgrps < MIN_CGRP_NODE_HASH)
> +		nr_hash =3D MIN_CGRP_NODE_HASH;
> +	else
> +		nr_hash =3D roundup_pow_of_two(nr_cgrps);
> +	hash_bits =3D ilog2(nr_hash);
> +
> +	cgrp_node_hash =3D kcalloc_node(nr_hash, sizeof(*cgrp_node_hash),
> +				      GFP_KERNEL, node);
> +	if (cgrp_node_hash =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	cgrp_node =3D kcalloc_node(nr_cgrps, sizeof(*cgrp_node), GFP_KERNEL, no=
de);
> +	if (cgrp_node =3D=3D NULL) {
> +		kfree(cgrp_node_hash);
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < (int)nr_cgrps; i++) {
> +		int key =3D hash_64(cgroup_ids[i], hash_bits);
> +
> +		cgrp_node[i].id =3D cgroup_ids[i];
> +		hlist_add_head(&cgrp_node[i].node, &cgrp_node_hash[key]);
> +	}
> +
> +	raw_spin_lock_irqsave(&ctx->lock, flags);
> +
> +	enabled =3D event->state >=3D PERF_EVENT_STATE_INACTIVE;
> +
> +	if (event->nr_cgrp_nodes !=3D 0) {
> +		kfree(event->cgrp_node_hash);
> +		kfree(event->cgrp_node_entries);
> +		is_first =3D false;
> +	}

To add another cgroup to the list, we use PERF_EVENT_IOC_ATTACH_CGROUP to=20
do the whole list. So we may lost some readings during this, right?

> +
> +	event->cgrp_node_hash =3D cgrp_node_hash;
> +	event->cgrp_node_entries =3D cgrp_node;
> +	event->cgrp_node_hash_bits =3D hash_bits;
> +	event->nr_cgrp_nodes =3D nr_cgrps;
> +
> +	raw_spin_unlock_irqrestore(&ctx->lock, flags);
> +
> +	if (is_first && enabled)
> +		event_function_call(event, perf_attach_cgroup_node, NULL);
> +
> +	return 0;
> +}

[...]
>=20

