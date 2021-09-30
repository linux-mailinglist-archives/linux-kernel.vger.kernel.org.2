Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BCB41D268
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 06:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347900AbhI3Eez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 00:34:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231286AbhI3Eet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 00:34:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18U4Bhb6021750;
        Thu, 30 Sep 2021 00:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=uMi/wjnfa1AL1IPRslcXw5J47LTkPOGq67QDBhwjJHI=;
 b=cruY2HJZujM93VU7+OeiD5zzrbLM2/FvI/V8DOiWoj76jGf7xZ2AkcI0zn5Vv9Z5TIrq
 Cpc3uCme1CbhdEYRaqGsZ6shHF930ybxyblXt+ZkiGygagCjUZ/B5D+o1Fsv3nPfB2OO
 lR9pWiZ9j2bCnlKrCQoXJcXEVfz59hEPbuK5DvTl8opoZq3rJoIy0GwpQeePgktmq+fc
 twLgxDhM7nuXpzzEn6na3WXRz44aYiOYxi5Un4zpVysg6Lid/yeN+jDbiRJhqBcWwDQT
 FA8ocXkjSOuC9OG4J3yrQZvd4bhauYcnHBG8GArnIL7FVRJbpkh6UWy4ejHtE9O/9JoZ fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bd6090ap9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 00:33:01 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18U4Dmde028778;
        Thu, 30 Sep 2021 00:33:00 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bd6090an3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 00:33:00 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18U4VPm3013603;
        Thu, 30 Sep 2021 04:32:58 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3bc11f19sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 04:32:58 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18U4WuKx65536390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 04:32:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E51A4208E;
        Thu, 30 Sep 2021 04:32:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0B4242063;
        Thu, 30 Sep 2021 04:32:52 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.79.189.109])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 30 Sep 2021 04:32:52 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2] perf/core: fix userpage->time_enabled of inactive
 events
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <4AB79DA5-A8AF-456D-A009-3F24EEDA20F2@fb.com>
Date:   Thu, 30 Sep 2021 10:02:43 +0530
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Lucian Grijincu <lucian@fb.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        kajoljain <kjain@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB5E9E0E-A4C9-432E-8F0D-A6DD2F3915DE@linux.vnet.ibm.com>
References: <20210924012800.2461781-1-songliubraving@fb.com>
 <EEA8D03E-14A7-4A8B-8C99-B68CACEC25D2@linux.vnet.ibm.com>
 <4AB79DA5-A8AF-456D-A009-3F24EEDA20F2@fb.com>
To:     Song Liu <songliubraving@fb.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kp0CuDGqF7_Cpi9au1BLD5oPoLToXV3J
X-Proofpoint-GUID: aJkCWI5cJC9uQ0KbKaiF96zrZzmprdlz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_01,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 adultscore=0 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 30-Sep-2021, at 1:11 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Sep 29, 2021, at 10:04 AM, Athira Rajeev =
<atrajeev@linux.vnet.ibm.com> wrote:
>>=20
>>=20
>>=20
>>> On 24-Sep-2021, at 6:58 AM, Song Liu <songliubraving@fb.com> wrote:
>>>=20
>>> Users of rdpmc rely on the mmapped user page to calculate accurate
>>> time_enabled. Currently, userpage->time_enabled is only updated when =
the
>>> event is added to the pmu. As a result, inactive event (due to =
counter
>>> multiplexing) does not have accurate userpage->time_enabled. This =
can
>>> be reproduced with something like:
>>>=20
>>> /* open 20 task perf_event "cycles", to create multiplexing */
>>>=20
>>> fd =3D perf_event_open();  /* open task perf_event "cycles" */
>>> userpage =3D mmap(fd);     /* use mmap and rdmpc */
>>>=20
>>> while (true) {
>>>   time_enabled_mmap =3D xxx; /* use logic in perf_event_mmap_page */
>>>   time_enabled_read =3D read(fd).time_enabled;
>>>   if (time_enabled_mmap > time_enabled_read)
>>>       BUG();
>>> }
>>>=20
>>> Fix this by updating userpage for inactive events in merge_sched_in.
>>>=20
>>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Reported-and-tested-by: Lucian Grijincu <lucian@fb.com>
>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>> ---
>>> include/linux/perf_event.h |  4 +++-
>>> kernel/events/core.c       | 49 =
++++++++++++++++++++++++++++++++++----
>>> 2 files changed, 48 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>> index 2d510ad750edc..4aa52f7a48c16 100644
>>> --- a/include/linux/perf_event.h
>>> +++ b/include/linux/perf_event.h
>>> @@ -683,7 +683,9 @@ struct perf_event {
>>> 	/*
>>> 	 * timestamp shadows the actual context timing but it can
>>> 	 * be safely used in NMI interrupt context. It reflects the
>>> -	 * context time as it was when the event was last scheduled in.
>>> +	 * context time as it was when the event was last scheduled in,
>>> +	 * or when ctx_sched_in failed to schedule the event because we
>>> +	 * run out of PMC.
>>> 	 *
>>> 	 * ctx_time already accounts for ctx->timestamp. Therefore to
>>> 	 * compute ctx_time for a sample, simply add perf_clock().
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 1cb1f9b8392e2..d73f986eef7b3 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -3707,6 +3707,46 @@ static noinline int visit_groups_merge(struct =
perf_cpu_context *cpuctx,
>>> 	return 0;
>>> }
>>>=20
>>> +static inline bool event_update_userpage(struct perf_event *event)
>>> +{
>>> +	/*
>>> +	 * Checking mmap_count to avoid unnecessary work. This does =
leave a
>>> +	 * corner case: if the event is enabled before mmap(), the first
>>> +	 * time the event gets scheduled is via:
>>> +	 *
>>> +	 *  __perf_event_enable (or __perf_install_in_context)
>>> +	 *      -> ctx_resched
>>> +	 *         -> perf_event_sched_in
>>> +	 *            -> ctx_sched_in
>>> +	 *
>>> +	 * with mmap_count of 0, so we will skip here. As a result,
>>> +	 * userpage->offset is not accurate after mmap and before the
>>> +	 * first rotation.
>>> +	 *
>>> +	 * To avoid the discrepancy of this window, the user space =
should
>>> +	 * mmap the event before enabling it.
>>> +	 */
>>> +	if (likely(!atomic_read(&event->mmap_count)))
>>> +		return false;
>>> +
>>> +	perf_event_update_time(event);
>>> +	perf_set_shadow_time(event, event->ctx);
>>> +	perf_event_update_userpage(event);
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +static inline void group_update_userpage(struct perf_event =
*group_event)
>>> +{
>>> +	struct perf_event *event;
>>> +
>>> +	if (!event_update_userpage(group_event))
>>> +		return;
>>> +
>>> +	for_each_sibling_event(event, group_event)
>>> +		event_update_userpage(event);
>>> +}
>>> +
>>> static int merge_sched_in(struct perf_event *event, void *data)
>>> {
>>> 	struct perf_event_context *ctx =3D event->ctx;
>>> @@ -3725,14 +3765,15 @@ static int merge_sched_in(struct perf_event =
*event, void *data)
>>> 	}
>>>=20
>>> 	if (event->state =3D=3D PERF_EVENT_STATE_INACTIVE) {
>>> +		*can_add_hw =3D 0;
>>> 		if (event->attr.pinned) {
>>> 			perf_cgroup_event_disable(event, ctx);
>>> 			perf_event_set_state(event, =
PERF_EVENT_STATE_ERROR);
>>> +		} else {
>>> +			ctx->rotate_necessary =3D 1;
>>> +			perf_mux_hrtimer_restart(cpuctx);
>>> +			group_update_userpage(event);
>>> 		}
>>> -
>>> -		*can_add_hw =3D 0;
>>> -		ctx->rotate_necessary =3D 1;
>>> -		perf_mux_hrtimer_restart(cpuctx);
>>> 	}
>>=20
>> Another optimisation that is possible in merge_sched_in is we can =
avoid calling "perf_mux_hrtimer_restart" multiple times if already =
rotate_necessary is set for that context. Even though =
"perf_mux_hrtimer_restart" will just return if hrtimer is already =
active, we could avoid the overhead of calling this function multiple =
times if there are many groups.=20
>>=20
>> Something like below:
>>=20
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 0c000cb01eeb..26eae79bd723 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -3731,8 +3731,10 @@ static int merge_sched_in(struct perf_event =
*event, void *data)
>>               }
>>=20
>>               *can_add_hw =3D 0;
>> -               ctx->rotate_necessary =3D 1;
>> -               perf_mux_hrtimer_restart(cpuctx);
>> +               if (!ctx->rotate_necessary) {
>> +                       ctx->rotate_necessary =3D 1;
>> +                       perf_mux_hrtimer_restart(cpuctx);
>> +               }
>>       }
>>=20
>>       return 0;
>=20
> Yeah, this makes sense. Do you plan to send a patch for this?=20

Yes, I will send a separate patch for this change right away.

Thanks
Athira
>=20
> Thanks,
> Song

