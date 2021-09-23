Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB884164A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242074AbhIWRtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:49:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20106 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233669AbhIWRtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:49:14 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NFwoEi000400
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:47:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=hkOEVMBzPbSHCcaytkgrtNTUVNPi1Gz9m4+N6bCWH88=;
 b=YIlVzo8UGHVxMi2qeIvqF8br3OqS+t0XiueP8LVh81GKy1LmlLMDhTffd1++Eq0Ym+J/
 J8Y/Ku4JDhw0eNme3vuPLLq9lf+eTBtPyrO67oiXcMp6Knwt1+QweRhoG4b0UubnGqZz
 Hu1vB3UBz6eiBUGTl4wSMX2MVCJNhkLEN1w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b8h6d575v-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:47:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 23 Sep 2021 10:47:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT8aZtjcjCat+jIRXDEFsyWKzKKNgR63tH4x5F2QymtcmvWdulTFDY3hlpYbrKHdG70U4GUokO+AP3rWUcHI6BzUii/0aJIO55PhLMe5hyevvTAvzNwBkbm7ULaCuCfQ6QTbkkYXrqu1tbNwPT4hQMzc0HsMyTaA7HmNfIA7ySibZo8m6OFcCJV7nc/HGDdlIGREI1MVVdH6J1m2hmbvjgKkUNIO+N3rXYAtTcrRzca5edZDjWLGZubnnLDkVuJ2b2lcjMqrRsSn/sXVuefMSsnVBu1E+WYe3LGS/jf+1Xvo4pmx/9gYO9mPEyaNsOEw6Jcpl2OTaoYInyt6YaTCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hkOEVMBzPbSHCcaytkgrtNTUVNPi1Gz9m4+N6bCWH88=;
 b=n9XuWFHZg60ClKFu/RNC4mq1k+qOoAQWrXrktfrO8ofjUvkVkrTHyy/HNKkLWdYRLbEaYfcyCoPwc/bXwpTF5v96EsDzTia7gmcrCy1SSVfljb+t52q/xPiin9xxXtAEj4FAmjnmcJRlI8FOjUHnmCCYXpcMk5leTgUjJqYal/Suat1j356h4ThBKcwf4gt/Qrc+nLuRiSgGHIPvM6M6k4Qs9WCLAcrx/XMARftWlisQmgXTlNBn3QoRfq1pdMOwGOvt/7KzMURWDQWGyEX598gx5ILJM5/VhCzX9MImMkYLi83vQphtjucv5Nem0dPRT2ZBuCFyTZah4XtRVic8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5063.namprd15.prod.outlook.com (2603:10b6:806:1de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 17:47:40 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4544.018; Thu, 23 Sep 2021
 17:47:40 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Lucian Grijincu <lucian@fb.com>
Subject: Re: [PATCH] perf/core: fix userpage->time_enabled of inactive events
Thread-Topic: [PATCH] perf/core: fix userpage->time_enabled of inactive events
Thread-Index: AQHXr0+haQJZyLrcUUCZvKZzjJ4lwquxZ2MAgACAMYA=
Date:   Thu, 23 Sep 2021 17:47:40 +0000
Message-ID: <4F8CB003-C047-41DB-85D7-233369D23E31@fb.com>
References: <20210922011715.4154119-1-songliubraving@fb.com>
 <YUxSMqrJK/rKPZS3@hirez.programming.kicks-ass.net>
In-Reply-To: <YUxSMqrJK/rKPZS3@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d2ba3c5-7516-4144-cf2c-08d97eba3d4a
x-ms-traffictypediagnostic: SA1PR15MB5063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB50630E578AC19E667C36D9E9B3A39@SA1PR15MB5063.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YIpJZvz3xzTV3qvQwaFFHzkRG7qg1UYS0FJlI1PRcwQrprjinGtqcFmDnE3pibsctnUAPBmXRLFsPmI/+dMRGiFIt1ErnaogtGmOz3fH3pGzRZczGLraN0A435b221d2VpKYi+TUh4GStF6GkgpXSTql/KruX0PNGENIClNWvXRsSkpi0QVJRfVide8PQ+y7l/FDHZ1X0N7fApzLPj/jNTFrPt3rijJF4AQn7C1lqk/yA9Y6RgIpt6KFdF9bPQ8z2K/5IxvGk0mmsTZzc7XCMv39ZtAkWYKx0/VuDAPqGqbChvx42RZiTA3I+UooZaxmqyAU5Gu4qRwtFua5WQaRGkAjWprq1uG9MtKNe1hLIiBbRoytgMjUJRsc3ouAZO05vhbLFQidInPngO/AjAFzBZF0vR4XVSlA6lq8GDRH25TVjg/JH7aJ5AXxRFDiW88ceUts9n+XTO38L7HI5+qZOwY+MiCjbwRJJDj0z72KOwCXt4WnO4rxFyw6NJZUFowH1a0dQ8N7fn4I205N4SZJeugbCtXdQs7taYtkp35MV7i7wkhAL7xdztB1udoC7HDB+1ajbpyBy8CHxHSrtbaacfjvKApGfo+Ws54CDM7O/l4fpvXYNMeEz/iZ9myTQWRFMLJTwcbLcYJ9AlEIxQKpq6aIneTerMnjolvNz7b4BtFrZ1f8pZo5HHGQ9EzfxWCArFu83yPMfeQ2+FZC0fOLjeMcx9wBL0sOLpaRcunHSmIxzUFLqqLDXaz5bOY7LmKJCEs4nquIT/xqCZMFq9uvTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(186003)(6486002)(8676002)(6506007)(53546011)(91956017)(122000001)(64756008)(66446008)(38070700005)(2906002)(36756003)(6512007)(86362001)(4326008)(2616005)(6916009)(5660300002)(83380400001)(76116006)(38100700002)(508600001)(33656002)(54906003)(71200400001)(66556008)(66476007)(66946007)(316002)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bmJGxzBKAoMWxAcXuSlMetUBxbN0PKNPB8ByWxLfNrsQ07PpPzjkfTH/3qnH?=
 =?us-ascii?Q?sPBAvadSDq/c28+pZ6mmwUvn920G/5er7278OSCd/+KehX8W94aqmUt1Tmjk?=
 =?us-ascii?Q?CAms5FhQmYTEp29WeZiiFn0klrzeDT5oTenl5flKnJVeTkR7GYgDk4dSjehn?=
 =?us-ascii?Q?aTQWvKfvExDXQvLPDXxOOwtrPtvZuDvD079r5Qb30N3l9SbHfOD/p4OA1IrN?=
 =?us-ascii?Q?0sRHo37NGEziRwVDXN5Lp1Ij45CGfr/9wuIeNlzYamFB6KeWd7JicHqEFn5v?=
 =?us-ascii?Q?5Kxaa7ZIcPMI+Q7F857VW2CD9pFtzd1NiH55FASdUha0CxNIQ9glh12gbwDn?=
 =?us-ascii?Q?q4PpQIE2gCQ8jmTYENMce8m2gyWH49f5LkJq4UxMyeSA1rZIMhzcg59dbZXI?=
 =?us-ascii?Q?rhZTqN+bF5QSllm5v+I/nADy3cOCgTyqwaPPs/9nYVll+iSkyGa8IttxNOKI?=
 =?us-ascii?Q?TfQONA2uhn1l5okXj8d+wt9xE9PdYNpAKgg2m+Mzo1bUSyXx48K4zlPXQ+Xu?=
 =?us-ascii?Q?aFmW/YJRfrjYVPNXx7KCQzuUtVk2oAX4aQTnACD9SXXDmv6k4tUUBoP8zrYY?=
 =?us-ascii?Q?12b+fguivxQfviZ2+890QBEa1rHzEp2nUTCDltqhnsXa9WCMOQ2QuMs2nigC?=
 =?us-ascii?Q?X7az3h/nX7PruuymTAu3Hfzqr7r/2k3BRBlFlV0wE14U2s+NtBHaUTFUOljC?=
 =?us-ascii?Q?zolVZoengs3xBfZ9Qr88/VWcqiGjNJ+5DIHAbtvxTNvagc/nh9yQOm3CdCYd?=
 =?us-ascii?Q?kdfiBi5Su4PxZQWvHr+qWgO3iD+thYnNYBKV3xrCV/kT62HfhRzUo3hg5/jI?=
 =?us-ascii?Q?m/bIPCk9fNgTKAgKR+fMbyJZocMdeZec/DiLJ4iQcc+8vimyjHPIWikSVaam?=
 =?us-ascii?Q?zIqV07bWA6XRjN/Sj+SPlGaan9Xv7P2HNcTgTZBPofR+tbBxQWlMgrydl4gT?=
 =?us-ascii?Q?333+C50hP5JUV9boxOePszHLO4lJIlj7klQ+nw3q9lmf/XSDwcW5+xpd+t0Q?=
 =?us-ascii?Q?zUh5ZOW4aR6fxkGy2d5Qbn8EheRx38umQy03PobVjWmH4E4u/bZBvhVoUAnB?=
 =?us-ascii?Q?xkOYQyhD7eShCC0s1yHOJQhDNAumkha52qUFLm3l1UP+YZlrmYlm4kdA4XJs?=
 =?us-ascii?Q?cVDDnukOY30x3vv4v5eGbBaf/p2HIVVKaEpZy979fgOWLPCHuKpK9e6E0Zq2?=
 =?us-ascii?Q?ZNU9Y7iHNbbK50iOEreYnjqb5d+1AH9RN0Tl65fDsSp3JIPK0srRsZCqBNDO?=
 =?us-ascii?Q?XO4vv1OlFftMzaL318ExwtqMj89cEh6YGjl/N6HqxFifENutE58licGr3kFx?=
 =?us-ascii?Q?daJxWej+EfmutNm3IYFLVmJ5fFQIGaJBqkmIDY8MREQoYcRVK6OdI2TcMQbo?=
 =?us-ascii?Q?Wn4GO9U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <458744433447914C92AFA5680E06BE44@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2ba3c5-7516-4144-cf2c-08d97eba3d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 17:47:40.5850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hj9C4pFYo7df8lZjuY14BZzGg+KGC9e7lNNOYXhTq9KqrF1mTCd+6POpboId4KW2nA9BPjLWs6sW3/2u1z7xrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5063
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 8UWaLAeGWecrhPPXO5IGvsdAlW6bp6yZ
X-Proofpoint-ORIG-GUID: 8UWaLAeGWecrhPPXO5IGvsdAlW6bp6yZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_05,2021-09-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 23, 2021, at 3:08 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Tue, Sep 21, 2021 at 06:17:15PM -0700, Song Liu wrote:
>> Users of rdpmc rely on the mmapped user page to calculate accurate
>> time_enabled. Currently, userpage->time_enabled is only updated when the
>> event is added to the pmu. As a result, inactive event (due to counter
>> multiplexing) does not have accurate userpage->time_enabled. This can
>> be reproduced with something like:
>> 
>>   /* open 20 task perf_event "cycles", to create multiplexing */
>> 
>>   fd = perf_event_open();  /* open task perf_event "cycles" */
>>   userpage = mmap(fd);     /* use mmap and rdmpc */
>> 
>>   while (true) {
>>     time_enabled_mmap = xxx; /* use logic in perf_event_mmap_page */
>>     time_enabled_read = read(fd).time_enabled;
>>     if (time_enabled_mmap > time_enabled_read)
>>         BUG();
>>   }
> 
> *groan*, yes I fear you're right.
> 
>> @@ -3807,6 +3816,23 @@ ctx_sched_in(struct perf_event_context *ctx,
>> 	/* Then walk through the lower prio flexible groups */
>> 	if (is_active & EVENT_FLEXIBLE)
>> 		ctx_flexible_sched_in(ctx, cpuctx);
>> +
>> +	/*
>> +	 * Update userpage for inactive events. This is needed for accurate
>> +	 * time_enabled.
>> +	 */
>> +	if (unlikely(ctx->rotate_necessary)) {
>> +		struct perf_event *event;
>> +
>> +		perf_event_groups_for_each(event, &ctx->pinned_groups) {
>> +			if (event->state == PERF_EVENT_STATE_INACTIVE)
>> +				perf_event_update_inactive_userpage(event, ctx);
>> +		}
> 
> That's a straight up error, if a pinned event doesn't get scheduled,
> it's game over.
> 
>> +		perf_event_groups_for_each(event, &ctx->flexible_groups) {
>> +			if (event->state == PERF_EVENT_STATE_INACTIVE)
>> +				perf_event_update_inactive_userpage(event, ctx);
>> +		}
>> +	}
>> }
> 
> That's terrible though, and also wrong I think.
> 
> It's wrong because:
> 
> - you should only do this for (is_active & EVENT_TIME)
> - you should only consider the events visit_groups_merge() would have
> - you miss updating group-siling events
> 
> (I also think it's possible to try harder to avoid the work)
> 
> Now, looking at visit_groups_merge() we only terminate the iteration
> when func returns !0, which is merge_sched_in(), and that *never*
> returns !0.
> 
> So we already iterate all the right events. So I'm thinking we can do
> something like the below, hmm?
> 
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 0c000cb01eeb..4d1e962c2ebe 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3707,6 +3712,28 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
> 	return 0;
> }
> 
> +static inline bool event_update_userpage(struct perf_event *event)
> +{
> +	if (!atomic_read(&event->mmap_count))
> +		return false;

Technically, the user could mmap a sibling but not the group leader, right?
It is weird though. 

There is also a corner case we didn't cover. If the user enable the event
before mmap it. The event is first scheduled in via:

__perf_event_enable (or __perf_install_in_context)
   -> ctx_resched
      -> perf_event_sched_in
          -> ctx_sched_in

but it doesn't have mmap_count yet. And we won't call perf_event_update_userpage
for it before the first rotation after mmap. As a result, the user page will
contain garbage data before the first rotation. 

I haven't figured out a good fix for this. Maybe we just require the user to 
do mmap before enabling it? If not, the user should expect some garbage data
before the first rotation?

Other than this corner case, this version works well in my tests. Shall I send 
v2 in this version?

Thanks,
Song




> +
> +	perf_event_update_time(event);
> +	perf_set_shadow_time(event, event->ctx);
> +	perf_event_update_userpage(event);
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
> @@ -3725,14 +3752,18 @@ static int merge_sched_in(struct perf_event *event, void *data)
> 	}
> 
> 	if (event->state == PERF_EVENT_STATE_INACTIVE) {
> +		*can_add_hw = 0;
> +
> 		if (event->attr.pinned) {
> 			perf_cgroup_event_disable(event, ctx);
> 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> -		}
> 
> -		*can_add_hw = 0;
> -		ctx->rotate_necessary = 1;
> -		perf_mux_hrtimer_restart(cpuctx);
> +		} else {
> +			ctx->rotate_necessary = 1;
> +			perf_mux_hrtimer_restart(cpuctx);
> +
> +			group_update_userpage(event);
> +		}
> 	}
> 
> 	return 0;


