Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EC3360D32
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhDOO6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:58:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:36971 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233748AbhDOOyg (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:54:36 -0400
IronPort-SDR: vZDLbAKeqqsPM9HLaMwdVp50GbQwbINP5+Efgvt5nv2HVuvfd/4nXE+cfvr23lFZXauTQeeNGb
 vkEXObKT3ovg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="181989749"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="181989749"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 07:53:40 -0700
IronPort-SDR: ig9MHfsn5Yaoy3u3jnMnXyMnb/VdkwyL/jLqR9lux64xu0TaLGeheku9IHh11QHaH2g8anoGye
 Z9KUyZbeVa0w==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="461642160"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.249.171.192]) ([10.249.171.192])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 07:53:36 -0700
Subject: Re: [PATCH v3 12/27] perf parse-events: Support no alias assigned
 event inside hybrid PMU
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-13-yao.jin@linux.intel.com> <YHgdixeqOu2NarkC@krava>
 <132fc848-7252-0d7f-4a5f-020e8f79012e@linux.intel.com>
 <YHhJeuYMA/0Jof55@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <7773d38a-4e1a-a610-367d-094f099d209d@linux.intel.com>
Date:   Thu, 15 Apr 2021 22:53:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YHhJeuYMA/0Jof55@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/15/2021 10:11 PM, Jiri Olsa wrote:
> On Thu, Apr 15, 2021 at 09:36:16PM +0800, Jin, Yao wrote:
> 
> SNIP
> 
>>>> +	int n = 0;
>>>> +
>>>> +	list_for_each(pos, list)
>>>> +		n++;
>>>> +
>>>> +	return n;
>>>> +}
>>>> +
>>>> +static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
>>>> +					 const char *str, char *pmu_name,
>>>> +					 bool *found, struct list_head *list)
>>>> +{
>>>> +	struct parse_events_state ps = {
>>>> +		.list           = LIST_HEAD_INIT(ps.list),
>>>> +		.stoken         = PE_START_EVENTS,
>>>> +		.pmu_name       = pmu_name,
>>>> +		.idx            = parse_state->idx,
>>>> +	};
>>>
>>> could we add this pmu_name directly to __parse_events?
>>>
>>
>> Do you suggest we directly call __parse_events()?
>>
>> int __parse_events(struct evlist *evlist, const char *str,
>> 		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
>>
>> 	struct parse_events_state parse_state = {
>> 		.list	  = LIST_HEAD_INIT(parse_state.list),
>> 		.idx	  = evlist->core.nr_entries,
>> 		.error	  = err,
>> 		.evlist	  = evlist,
>> 		.stoken	  = PE_START_EVENTS,
>> 		.fake_pmu = fake_pmu,
>> 	};
>>
>> But for parse_events__with_hybrid_pmu, we don't have valid evlist. So if we
>> switch to __parse_events, evlist processing may be a problem.
> 
> you should use parse_state->evlist no? but we can chec/make this
> change in next itaration.. it's already lot of changes
> 
> jirka
> 

With my current code,

static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
					 const char *str, char *pmu_name,
					 struct list_head *list)
{
	struct parse_events_state ps = {
		.list           = LIST_HEAD_INIT(ps.list),
		.stoken         = PE_START_EVENTS,
		.pmu_name       = pmu_name,
		.idx            = parse_state->idx,
	};
	int ret;

	ret = parse_events__scanner(str, &ps);
	perf_pmu__parse_cleanup();

	if (!ret) {
		if (!list_empty(&ps.list)) {
			list_splice(&ps.list, list);
			parse_state->idx = ps.idx;
		}
	}

	return ret;
}

The new created evsels are added to the tail of list (ps.list) and ps.list is joined to the list 
(the parameter 'list').

If we want to reuse the __parse_events(), we may need to:

struct evlist *evlist = evlist__new();

__parse_events(evlist, str, NULL, NULL);
Add the evsels in evlist to the tail of list (the parameter 'list')
evlist__delete(evlist);

Is my understanding correct?

Yes, we have to change the interface of __parse_events() by adding a new parameter 'pmu_name', which 
will bring much more changes. I agree to make this change in follow-up patches.

Thanks
Jin Yao
