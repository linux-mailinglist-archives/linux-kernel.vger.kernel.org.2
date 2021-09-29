Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F281941CCC0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344142AbhI2TnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:43:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57220 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244887AbhI2TnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:43:12 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18THj2f6011288
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:41:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=O/oKypu89+fZnosQgpOnYnlSHjkr+JG3Wk+Am54IzsE=;
 b=PBZ1iBIQQPToTw+1jscL1sup4qQR7ujvu65WsxT4V/cx2bSPoh2CossDTldoqsyZp5J2
 1enicNM6nyEKzNEr8Ojtb/e7iL1wFHiOKzBRco5g75MVMhDyGD3+GJV3yeQwKY2SzPnM
 v4PTdP3Tt4vd53U7QL3omEGOc7IEe/TSK5k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bcvtk0w7g-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:41:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 29 Sep 2021 12:41:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h66+yDdgkOJ3uevd27WB6iW8R48qy47zXIl8IFY6foJcx36z2BMhchPLmIIclPBANChpiWmUJJnnDrUzzVZqIjnBX2kYaS4nmhELlpOGquuELV2i5dKebL4X7zoRO0QuhBXsmr5KYljDZ96pjCuwa7BXK3Mz9jxB0FqsAXdbW6bw10uWfcMAbpRddplhzT4Sp3OeLtIJYNA233MOuGcTnSd5TLdYf10ev+YUDpybM/PKAgfytNi6SwmUCzxtvxqGy88/h92TiK/QocrFgqHaYcm/Os9hHcfHTt1Xgh6mktyqm2TJRDiFipHhaHjkpSdv+vYp0fatUvIAgx+VuPunTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=O/oKypu89+fZnosQgpOnYnlSHjkr+JG3Wk+Am54IzsE=;
 b=fZKqD4JYubrlgjx87uBhLrK2k68A/hVkq2MXy8XXgJgT33PJSHT+b3zsz/QYxgAWM2OMSHVgD4OT8weUQ3/uh4cIUPmPomV4SKlZYKi7fShvgXv3zwH5cynAjS9WLu8vMIL7xgqIk5cXjaj8L9dicZcEHI7RZfJYqZuRnM9aD2QL1CQITVhMGbj/0qDmvX8QRSzt6TH34IqcWls/5n4NQtwK6dMjT8xGQim8qKzxE2ro5wQEaz0t+aSddX4utT+FQKNh7QRL9WpPxRcJkR5VYuQfLhCOJ1MyNLr5jn7UHirD6pQB6JgmXFPq11MEmhrVUQqMgsWf+V3QFl8ZFIcgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5095.namprd15.prod.outlook.com (2603:10b6:806:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 29 Sep
 2021 19:41:19 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 19:41:19 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Lucian Grijincu <lucian@fb.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v2] perf/core: fix userpage->time_enabled of inactive
 events
Thread-Topic: [PATCH v2] perf/core: fix userpage->time_enabled of inactive
 events
Thread-Index: AQHXsON8cxUzcBLit0S7boefzLsslKu7RmiAgAArwgA=
Date:   Wed, 29 Sep 2021 19:41:19 +0000
Message-ID: <4AB79DA5-A8AF-456D-A009-3F24EEDA20F2@fb.com>
References: <20210924012800.2461781-1-songliubraving@fb.com>
 <EEA8D03E-14A7-4A8B-8C99-B68CACEC25D2@linux.vnet.ibm.com>
In-Reply-To: <EEA8D03E-14A7-4A8B-8C99-B68CACEC25D2@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb161613-8e03-4b1e-1863-08d983811be9
x-ms-traffictypediagnostic: SA1PR15MB5095:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB50951EE187401E90ECB9B422B3A99@SA1PR15MB5095.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZN5PDp76AA4WVV34LYQrD/paD7FHQ8QiS+0ne+2Qv5k7TeQDNzuWNU042jqMbXM+xWXa/QvlhNolOrNy9eoT0R7LNvqGcGoBzeynezkl5bFhrPeYJfQSU3z3TPqYZ/BhdrwQKjJz9X4ssspZQvx7xkO+OE8eNDQ1Xfo6eVw2Je9o4Ko0wsJ1c9Z5GaraOWay3BqlDjddGIIYIwYKVmaL805omTxK/4ZeMcUhcDobgeuYQZSUO2Q2VEwZnuocORK9h0+wDYcfby3d6a8GnB2rpgCoTqU+8cqJA/b7YeR3HUu2XVphYbf0V1jGWNpjbHfjAXHteG1TY03IAJEluHie83LvO0Hy7zCm1Gm6RSjxs/1Yrbe7k5F3Uy01gPCJnbIS8n3oL+6lL7m/u0p/JllUYVM7/M21z0296WracuoYz/kZXFQYSC+AKoetVlYKRDkgtc8Sb1r1yobFJ3mevHNjHa0OFzXkbZnmAWiQ6LLiVvZf9T2fwKQ0tjHarVfiksgBM+jp8gFVyb3RI93r6kbgLTxwBNtv3E+k+nVebous7yQh1DWbC7DUrV50UMFuIS6EOhs3J0AlEDKYvM5S/p4pnpUlGV0j8QkioMm8uXe0gjFWmYHCCkzQF+dmqzSNDLlHpavCvHeQi7tTbDsZh2iCdRBN4JfKSvDBRNwxUVpy6nq2mW2dFaijY27W6kc9k/QlKKBNrxgvfb+xvvN9sMA77+PXNtBDSKdNyLTUHq0SBboctB4vWXUIeSeifQeNj3nKhqxK1iIg/WB+vGLoIn9RNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(122000001)(316002)(38070700005)(54906003)(86362001)(76116006)(8676002)(91956017)(64756008)(83380400001)(6506007)(53546011)(2906002)(36756003)(186003)(2616005)(66946007)(66446008)(6916009)(66476007)(66556008)(71200400001)(6486002)(4326008)(33656002)(5660300002)(8936002)(508600001)(6512007)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pRiDwbxv6mlZ/qlxgqgjLyHKxF0Zv6qfKeF78UdEtE3GWNv/NHXS38hiJqmr?=
 =?us-ascii?Q?EbCeaxtUtTW6Uf5WQRlDRsIPT6adDj9RIRiG0zsWWjdo9AUEU03A8mUYjJGx?=
 =?us-ascii?Q?AJnInJGjudRt/+97Oy5GTck04KkQc317Do3Scv1QbUhsHi7HycnwOk0AHlhh?=
 =?us-ascii?Q?XkwOUUqEc+DuEvprBAMTjBb9B6g5JJ85hqDsUttYAjh6SysH4EN7HrP2HYH5?=
 =?us-ascii?Q?9rPySP4gjwN9rR1v8LrFp1ItvG9WPESq/e9m8wS1twt+hBzunULQBEgS7vGG?=
 =?us-ascii?Q?osOIie2HGNNsCN1MssSpO9fhESVHDVC9YixGiK/tOrX0+yvd2M1Ix877UNj4?=
 =?us-ascii?Q?1InakuWoeCHXGpintsMU6BGHB6RXqk5MGcR0Zz4yHnLb1UHqNyRqBPi9yQYK?=
 =?us-ascii?Q?QEQp3xvoVgSr92L9WZcMCQ7O1ZSSpTRkECHRHKLQU8of9m4vXkOYc+56NQSn?=
 =?us-ascii?Q?g02+KQlDqQmG2jcuV7unIRsDP4lVs1glFMWozOlhdlInh+V3G9RIpiASdYne?=
 =?us-ascii?Q?wKXHJPkpg0M7C4GXR2cusTCMBqVop+VK1aaBB9k5lmI/HDX4HGE4pArBVzFo?=
 =?us-ascii?Q?/FJi6Q8clqzx2pwkVO9XkfIfSn08FOS+nacM8h1Li9uI5SEvn5P2tCU0YKgi?=
 =?us-ascii?Q?QHkOi1KMYSVZWlcFvzKpXrw0y6Y08lmGLUsfDrgHWmD5g3sLvcaVkxN1f4wN?=
 =?us-ascii?Q?DV7hsWE7Zl+DuNTMnalkTcTr2FtMxMQZsLoNmVrFMZCE2V6OpDLn8JIogZaD?=
 =?us-ascii?Q?MSAjDvpxxInSe2O6SynpdXVi9s2o/VvPRS+ZTqJ/T5FcLBgNSayCMReNxeXQ?=
 =?us-ascii?Q?RvopDYaRoJ1UTUFMQ9vv+S3fXACJDBlrmvGI3k+4yKnaj47E6kPhp2em/GEj?=
 =?us-ascii?Q?sSU3ukcElfN8itnDUvF32PhzyLiV/815N/HcrYynVnJcM13wBR1i2uEC9QLj?=
 =?us-ascii?Q?mDJST1Hdcl5wh5S2ZloUqgYTsC6zPhe0AGgCztUYLlHTCuimQlhsde9KAgCE?=
 =?us-ascii?Q?DheTmhVdjDsS6vfWIn1GKveOJb0cljFQ38qnxpLs/DdciiJiOgvzjQthmQec?=
 =?us-ascii?Q?/mCeAyc6UC2Y6A04x3ZlwjdHVfKgZtP1VYZ11Bqnuzhg9VN8ceGeYTadsMcu?=
 =?us-ascii?Q?6g0uerPtzWBCGXX1izGqzqmFhHCuhVzvYqJUj/M+brDrwXLz3r6wX65O8LGx?=
 =?us-ascii?Q?8MF5rwa/uXnBRV+EBqrEsvV3maddMyes4u/z5GnZLPT0m3aFQuR3Lu3fNI/Y?=
 =?us-ascii?Q?uNQg4kKf0EANabuAeg+mPr977rlWFH4OanCUM3z3S/nom0AYJTG+dQsdeEk4?=
 =?us-ascii?Q?F5E1zUmw+fiXJ5F7XVGllC0XI0Qn8T5MdRtztYBBC7YihqZGTzqLoU2xh1tr?=
 =?us-ascii?Q?7sIARIU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2F3BE52D2AD8D47854BEA9BA2F39A92@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb161613-8e03-4b1e-1863-08d983811be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 19:41:19.0622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ug2cYEOMsMwrTXOu7q6mUSL4cCw3Qu0TkafKlfFHt25Q7P1DES70HHDhxVOxZq7BtLtvkvT2AbJnRriE42JY0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5095
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: nggSdQNEWRas7aK59zXiJYxVHQgVIqeX
X-Proofpoint-ORIG-GUID: nggSdQNEWRas7aK59zXiJYxVHQgVIqeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_08,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 29, 2021, at 10:04 AM, Athira Rajeev <atrajeev@linux.vnet.ibm.com> wrote:
> 
> 
> 
>> On 24-Sep-2021, at 6:58 AM, Song Liu <songliubraving@fb.com> wrote:
>> 
>> Users of rdpmc rely on the mmapped user page to calculate accurate
>> time_enabled. Currently, userpage->time_enabled is only updated when the
>> event is added to the pmu. As a result, inactive event (due to counter
>> multiplexing) does not have accurate userpage->time_enabled. This can
>> be reproduced with something like:
>> 
>>  /* open 20 task perf_event "cycles", to create multiplexing */
>> 
>>  fd = perf_event_open();  /* open task perf_event "cycles" */
>>  userpage = mmap(fd);     /* use mmap and rdmpc */
>> 
>>  while (true) {
>>    time_enabled_mmap = xxx; /* use logic in perf_event_mmap_page */
>>    time_enabled_read = read(fd).time_enabled;
>>    if (time_enabled_mmap > time_enabled_read)
>>        BUG();
>>  }
>> 
>> Fix this by updating userpage for inactive events in merge_sched_in.
>> 
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Reported-and-tested-by: Lucian Grijincu <lucian@fb.com>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> include/linux/perf_event.h |  4 +++-
>> kernel/events/core.c       | 49 ++++++++++++++++++++++++++++++++++----
>> 2 files changed, 48 insertions(+), 5 deletions(-)
>> 
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 2d510ad750edc..4aa52f7a48c16 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -683,7 +683,9 @@ struct perf_event {
>> 	/*
>> 	 * timestamp shadows the actual context timing but it can
>> 	 * be safely used in NMI interrupt context. It reflects the
>> -	 * context time as it was when the event was last scheduled in.
>> +	 * context time as it was when the event was last scheduled in,
>> +	 * or when ctx_sched_in failed to schedule the event because we
>> +	 * run out of PMC.
>> 	 *
>> 	 * ctx_time already accounts for ctx->timestamp. Therefore to
>> 	 * compute ctx_time for a sample, simply add perf_clock().
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 1cb1f9b8392e2..d73f986eef7b3 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -3707,6 +3707,46 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
>> 	return 0;
>> }
>> 
>> +static inline bool event_update_userpage(struct perf_event *event)
>> +{
>> +	/*
>> +	 * Checking mmap_count to avoid unnecessary work. This does leave a
>> +	 * corner case: if the event is enabled before mmap(), the first
>> +	 * time the event gets scheduled is via:
>> +	 *
>> +	 *  __perf_event_enable (or __perf_install_in_context)
>> +	 *      -> ctx_resched
>> +	 *         -> perf_event_sched_in
>> +	 *            -> ctx_sched_in
>> +	 *
>> +	 * with mmap_count of 0, so we will skip here. As a result,
>> +	 * userpage->offset is not accurate after mmap and before the
>> +	 * first rotation.
>> +	 *
>> +	 * To avoid the discrepancy of this window, the user space should
>> +	 * mmap the event before enabling it.
>> +	 */
>> +	if (likely(!atomic_read(&event->mmap_count)))
>> +		return false;
>> +
>> +	perf_event_update_time(event);
>> +	perf_set_shadow_time(event, event->ctx);
>> +	perf_event_update_userpage(event);
>> +
>> +	return true;
>> +}
>> +
>> +static inline void group_update_userpage(struct perf_event *group_event)
>> +{
>> +	struct perf_event *event;
>> +
>> +	if (!event_update_userpage(group_event))
>> +		return;
>> +
>> +	for_each_sibling_event(event, group_event)
>> +		event_update_userpage(event);
>> +}
>> +
>> static int merge_sched_in(struct perf_event *event, void *data)
>> {
>> 	struct perf_event_context *ctx = event->ctx;
>> @@ -3725,14 +3765,15 @@ static int merge_sched_in(struct perf_event *event, void *data)
>> 	}
>> 
>> 	if (event->state == PERF_EVENT_STATE_INACTIVE) {
>> +		*can_add_hw = 0;
>> 		if (event->attr.pinned) {
>> 			perf_cgroup_event_disable(event, ctx);
>> 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
>> +		} else {
>> +			ctx->rotate_necessary = 1;
>> +			perf_mux_hrtimer_restart(cpuctx);
>> +			group_update_userpage(event);
>> 		}
>> -
>> -		*can_add_hw = 0;
>> -		ctx->rotate_necessary = 1;
>> -		perf_mux_hrtimer_restart(cpuctx);
>> 	}
> 
> Another optimisation that is possible in merge_sched_in is we can avoid calling "perf_mux_hrtimer_restart" multiple times if already rotate_necessary is set for that context. Even though "perf_mux_hrtimer_restart" will just return if hrtimer is already active, we could avoid the overhead of calling this function multiple times if there are many groups. 
> 
> Something like below:
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 0c000cb01eeb..26eae79bd723 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3731,8 +3731,10 @@ static int merge_sched_in(struct perf_event *event, void *data)
>                }
> 
>                *can_add_hw = 0;
> -               ctx->rotate_necessary = 1;
> -               perf_mux_hrtimer_restart(cpuctx);
> +               if (!ctx->rotate_necessary) {
> +                       ctx->rotate_necessary = 1;
> +                       perf_mux_hrtimer_restart(cpuctx);
> +               }
>        }
> 
>        return 0;

Yeah, this makes sense. Do you plan to send a patch for this? 

Thanks,
Song
