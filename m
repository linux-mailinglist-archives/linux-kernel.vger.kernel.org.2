Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2924198ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbhI0Qf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:35:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14198 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235450AbhI0QfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:24 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18REfLiL004459
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:33:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=gHxr+IMz1pHp0y+iCqwGx+9b/7u9SFFHDp/hmWsuSjs=;
 b=D/LnETNG5l1g05JQkR3+hwbJCECb/rlGdMTBXRgFSoJ4QKLXbVBjFw9Act/gVAMeji54
 IbcH/jXpYSCciMDOLKmHaYtK42cCW9iA5ZZ8EfHEQPxjvvcGBnusClya4pHtYgtzicqN
 arzT0LEyJMWssnWBFiC4iDiwycUI9xqGjFI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bb43dmkpk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:33:46 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 27 Sep 2021 09:33:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW9beaSYoeEb0I4xRR5NyA+XJXeRZvK0dqsxh3q/2pEvEuKBdp7UcwMl+0nhAgJJA7rVzLBeVsccQOg3LvimFedbY/dbzl0hQ8AblKnsmyh7XdJQOVsEqn1inMBoexvtRjwr3kqFcWDZrgY5ApCaCHeqjaqIQbcOlaQy3VACicUSgn6Cz1+NpxfG8FtnnLKk/RflsW9hJkGpmej0lLrUvUJ8zX2hhekf3CdBKRUs9O4tNXw3iawrLUrOsFq0snGfq7kjAmlQFpG6ryJ+TkrQ5rVTS39Uwqevi9H5j3TEC11RpaW7LX+zyzHEr8+9TDisfGLnjM4uJfr14B90HCepVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gHxr+IMz1pHp0y+iCqwGx+9b/7u9SFFHDp/hmWsuSjs=;
 b=Xzs6AXKjKSfZL1b99cEVnMbe9gtr/1ToYJr2BgkgPAyfn5pIsiPJaG7KRdsD1gyIXFi2Jk911usMQf3qIiKehM80AZf+1z7B0k9J1UJBPV1HG0HMhQAFGhwSpHHi6VV4De3DUMTgeARyoT2L/ZVjL8XiqIYxTwZZgo4xdv2nd4vuFGEgy6JDywuB0BNerkqJUbmcl+OdiVYo2DmD6WauzHDcLfTuw87av3aKxR5HSdOdMfAQzWhMu9RPilHCDdSiLC0NHmGJLK268zt1T9AdQ+AnjHkVRQQ/f7TqAReYWDkdsAM9mEsutZwduvzb7OxqUbQOhumm0qH8ML5jtwBPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5064.namprd15.prod.outlook.com (2603:10b6:806:1df::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 16:33:43 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 16:33:43 +0000
From:   Song Liu <songliubraving@fb.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Lucian Grijincu <lucian@fb.com>
Subject: Re: [PATCH v2] perf/core: fix userpage->time_enabled of inactive
 events
Thread-Topic: [PATCH v2] perf/core: fix userpage->time_enabled of inactive
 events
Thread-Index: AQHXsON8cxUzcBLit0S7boefzLsslKu4GRYA
Date:   Mon, 27 Sep 2021 16:33:43 +0000
Message-ID: <A38DD9FF-E142-4BD0-89C4-2B1B699812D7@fb.com>
References: <20210924012800.2461781-1-songliubraving@fb.com>
In-Reply-To: <20210924012800.2461781-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89b12a4b-7214-4749-ad1d-08d981d4920f
x-ms-traffictypediagnostic: SA1PR15MB5064:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB506423664F9FE098789C7E6BB3A79@SA1PR15MB5064.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MYjckOiwKN+/GsvCQHMNV+v4gGHQy5eshIO0+fil2DUvRqiH6FWjYsl8wkfypji+6RcIV885RFLoU4Ss1QwUV9Zu+WKbouXb8pE5+f0l56B6MaKCuGvUQ9L3OpAfrpkb2KrZJodtypaKrbyQ/9L3EVA1dQuaW+oYqmcZvx7rgMRQApZipvhWEM5wKDLhH/idV2Zn2dWXGweQNy/qBofMPzMiNc1xRRAcG0bNP41ZnQ9ho9XbPYMBYmTBnJexj6NbYHC8lFLh8d6yz96rKPnmMyRjbLV8rCC0Ib+PyhxAR+MYvajPnFhrzBkWylpupCxK08qSgD2OUy++nWky5HwK2DdahMZG3gu4aPVrig+F/yXbsm751km9TVGx58mJACT4GX/ZYas/xDq8U3G4ZDUstvnB4LsTo4WQoqypBzANE+cdFphPgqNQyTL3Bti+kS3R9pUMeo+Do0WVMJkgLUTEDF6Rtr1kU2+OFU/9jnzU7kfnSYE9YKTanpbur7FLxYY+E4H3evulZSJ0G738ROkL6ke8+BUJfT0+xdwLtB7Zk5ETfAbOn/s0IMAvbBPKu1X3wVSpYNOi3c9/Kv+KnLj1z+do7fInuZZkZZrulIqYxEooy0oWvkel+5iJShQrrX3AcCQ40gH1MHKt/lIyFMhaNTwThtNb8z3apTvoXuod1uEAGk8waOkOkQjqJcODqzOceTWb9LR01urPlsODZpRLiD73PTLu/SFCOZvpC9yoNNrFbegQZvbVeqk2ox2b3jed63LcHP06ZIflZLbuVCTYXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(122000001)(33656002)(186003)(71200400001)(38100700002)(8936002)(6506007)(38070700005)(83380400001)(508600001)(53546011)(8676002)(316002)(6512007)(91956017)(4326008)(76116006)(86362001)(110136005)(5660300002)(54906003)(66946007)(66446008)(64756008)(66556008)(6486002)(66476007)(36756003)(2616005)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+XcFdy61nneR3Pr71uqGB3ijULyyu3EuufPql5KKmPO2ZnMiFPMMGlOjUfso?=
 =?us-ascii?Q?x+vMO2QKouwNGOvjm2fHaTVTB1QV7a03MFHfilEopN/SiOLPWoYRJ2rSeaH1?=
 =?us-ascii?Q?Ur3W0Q1E1joTV0k2zuV6aEuZj7IVnVVtJpbfU2bXeQTEdRge7FCV606Xcipn?=
 =?us-ascii?Q?XmVQbChGpS668CkoZNlXQpldjAFMZWy5pf7uyd3w0tQtWlzhAiM7Ws9Xp13K?=
 =?us-ascii?Q?g0Q4la+ffZlIEGROu/HI+cA1VXMKfRVgE1wo7KQcCXenl/7zvXVb8QAU0x3Z?=
 =?us-ascii?Q?sHMDzTh0x0l1pJzPlxXFQVCDcUU6lBtXUogIU/VLAx4C8A8APurSkRUp02g6?=
 =?us-ascii?Q?zJC0YkEkMw97f0IdljkN3EfJqbN5S5EqhEQ0watjAXerwdtQewdR66QXPyDV?=
 =?us-ascii?Q?Ghapd5o5zWflg9IAdmzIF6O8ZapPc54QQxg5hTK8okl7TQzBYzSq/EzVgOr7?=
 =?us-ascii?Q?hiM2JpMaufrAUdqan8hL+sWdb9TathsVWEn8wmwp6B+y/ROyVgMYBPi3DHtF?=
 =?us-ascii?Q?SLnpOFIVQBRPb8chYEz+DV7m0ChYgb3DwLqtrua08KiqyP3x4owQSQF6Ccbl?=
 =?us-ascii?Q?oARESCTl31zLir7DF7FKA8EkdzSmhJeERIWzyE+LpA23qJ1xrH1z9u6bIDys?=
 =?us-ascii?Q?MHQwfSfGl+TUIO2YFhuPsuAbCKgoi6TAbL5/cTvS/aUr54QGIDeqpkk5NB8T?=
 =?us-ascii?Q?DDuHXcFFp976JKoVbHXdhszIu5Uo8FFDu+zcefMCtmDEG7QlXBIk7kBo3cA6?=
 =?us-ascii?Q?WUJtv/EyNoU8SedzNCJ/3S9lJwbMmv1vNMIGjvwFHBxXawHeA6bU+pnOGY9S?=
 =?us-ascii?Q?nW6KZoFVYrvO7hbMf2Z0lAyhGbvI1iYkHdFnuyQpNdG2HDERDsCm8Ux5CTlN?=
 =?us-ascii?Q?BD24A0fJdP08tDVWc68cjXis7IuluwjxL1YpCh0NJ9aUdFKn7gSahyi6OKEz?=
 =?us-ascii?Q?SJZx/DCDdopPKDib2Rc5gCuH278D3XdjR9R/j0C2cAP28Wlsd3iHRCbvufbE?=
 =?us-ascii?Q?0xEBgIslBGg9hDLLu1aSGyocyvNjtptQdCGYv0nH6ltqGQmVbzMGSyBKhJ0I?=
 =?us-ascii?Q?qapfJDIJzvxnFvZzgMt0ueVXF+g9GPwwMX96gFgBUxLcmVRrTW2F8Z7EP/oF?=
 =?us-ascii?Q?PxTNo1YOCG5gubxsJmCDdtzcTVm4JrTFhlcfeBQ9tkNRCu6/lR8cmhMbU1jn?=
 =?us-ascii?Q?qIQ+sZbWKSNBIZ/KKtcACbj/Va2CfcgDTbtV/YkOJZWvNty3MAB/m+dVlys8?=
 =?us-ascii?Q?TsbdmuNBNFU5WbwCHXIjWw30WVftxnM3149xJWFPYS/796Yq4aORTyMJ7yVH?=
 =?us-ascii?Q?sKGROwrJyshm9/cmtVapTiJO+fAzxHAVumBcIlHAMXbHo0I/RSHgpBtj8K3v?=
 =?us-ascii?Q?gViYMqU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B6BC0625B037C4FB98E06E1D382958B@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b12a4b-7214-4749-ad1d-08d981d4920f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 16:33:43.2499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVti+mBS536FWZpWrJuP7YP+vvPcwfAxtmxXJ/yrvJfVpeed0kEmUfGpBEidnbvvuHt6TUD61bmaScgLg81VhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5064
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: EsEvqxRSDKiLL7JH72V8pBAqlnxQVXH4
X-Proofpoint-ORIG-GUID: EsEvqxRSDKiLL7JH72V8pBAqlnxQVXH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_06,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2109270112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, 

> On Sep 23, 2021, at 6:28 PM, Song Liu <songliubraving@fb.com> wrote:
> 
> Users of rdpmc rely on the mmapped user page to calculate accurate
> time_enabled. Currently, userpage->time_enabled is only updated when the
> event is added to the pmu. As a result, inactive event (due to counter
> multiplexing) does not have accurate userpage->time_enabled. This can
> be reproduced with something like:
> 
>   /* open 20 task perf_event "cycles", to create multiplexing */
> 
>   fd = perf_event_open();  /* open task perf_event "cycles" */
>   userpage = mmap(fd);     /* use mmap and rdmpc */
> 
>   while (true) {
>     time_enabled_mmap = xxx; /* use logic in perf_event_mmap_page */
>     time_enabled_read = read(fd).time_enabled;
>     if (time_enabled_mmap > time_enabled_read)
>         BUG();
>   }
> 
> Fix this by updating userpage for inactive events in merge_sched_in.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reported-and-tested-by: Lucian Grijincu <lucian@fb.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Could you please share your comments on this version?

Thanks,
Song

> ---
> include/linux/perf_event.h |  4 +++-
> kernel/events/core.c       | 49 ++++++++++++++++++++++++++++++++++----
> 2 files changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 2d510ad750edc..4aa52f7a48c16 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -683,7 +683,9 @@ struct perf_event {
> 	/*
> 	 * timestamp shadows the actual context timing but it can
> 	 * be safely used in NMI interrupt context. It reflects the
> -	 * context time as it was when the event was last scheduled in.
> +	 * context time as it was when the event was last scheduled in,
> +	 * or when ctx_sched_in failed to schedule the event because we
> +	 * run out of PMC.
> 	 *
> 	 * ctx_time already accounts for ctx->timestamp. Therefore to
> 	 * compute ctx_time for a sample, simply add perf_clock().
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1cb1f9b8392e2..d73f986eef7b3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3707,6 +3707,46 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
> 	return 0;
> }
> 
> +static inline bool event_update_userpage(struct perf_event *event)
> +{
> +	/*
> +	 * Checking mmap_count to avoid unnecessary work. This does leave a
> +	 * corner case: if the event is enabled before mmap(), the first
> +	 * time the event gets scheduled is via:
> +	 *
> +	 *  __perf_event_enable (or __perf_install_in_context)
> +	 *      -> ctx_resched
> +	 *         -> perf_event_sched_in
> +	 *            -> ctx_sched_in
> +	 *
> +	 * with mmap_count of 0, so we will skip here. As a result,
> +	 * userpage->offset is not accurate after mmap and before the
> +	 * first rotation.
> +	 *
> +	 * To avoid the discrepancy of this window, the user space should
> +	 * mmap the event before enabling it.
> +	 */
> +	if (likely(!atomic_read(&event->mmap_count)))
> +		return false;
> +
> +	perf_event_update_time(event);
> +	perf_set_shadow_time(event, event->ctx);
> +	perf_event_update_userpage(event);
> +
> +	return true;
> +}
> +
> +static inline void group_update_userpage(struct perf_event *group_event)
> +{
> +	struct perf_event *event;
> +
> +	if (!event_update_userpage(group_event))
> +		return;
> +
> +	for_each_sibling_event(event, group_event)
> +		event_update_userpage(event);
> +}
> +
> static int merge_sched_in(struct perf_event *event, void *data)
> {
> 	struct perf_event_context *ctx = event->ctx;
> @@ -3725,14 +3765,15 @@ static int merge_sched_in(struct perf_event *event, void *data)
> 	}
> 
> 	if (event->state == PERF_EVENT_STATE_INACTIVE) {
> +		*can_add_hw = 0;
> 		if (event->attr.pinned) {
> 			perf_cgroup_event_disable(event, ctx);
> 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> +		} else {
> +			ctx->rotate_necessary = 1;
> +			perf_mux_hrtimer_restart(cpuctx);
> +			group_update_userpage(event);
> 		}
> -
> -		*can_add_hw = 0;
> -		ctx->rotate_necessary = 1;
> -		perf_mux_hrtimer_restart(cpuctx);
> 	}
> 
> 	return 0;
> -- 
> 2.30.2
> 

