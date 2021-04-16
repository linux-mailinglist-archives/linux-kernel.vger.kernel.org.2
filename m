Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F0361743
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 03:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbhDPB6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 21:58:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:49597 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235043AbhDPB6V (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 21:58:21 -0400
IronPort-SDR: JZ1mDsJUbB0K+0WAGmev8DtB94ZVt0cZfp2qcNBV6Sddo74I/tnX/Pa38vgWxO6oW8vG6byNeL
 Io8yjUyGzV1g==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="175082909"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="175082909"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 18:57:55 -0700
IronPort-SDR: SDgojf8CaZd2LrTpdIhvbKReJAfwSite5mO4S5ZoHzggMfEENB74EiNJIGdor4iDTRgwN+3idN
 BJtuAtZ6NJvw==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="425410740"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 18:57:52 -0700
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
 <7773d38a-4e1a-a610-367d-094f099d209d@linux.intel.com>
 <YHiWaDYzC9xEwLcp@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <e62a2ae3-5703-75dc-3382-b46bce099c26@linux.intel.com>
Date:   Fri, 16 Apr 2021 09:57:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YHiWaDYzC9xEwLcp@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/16/2021 3:39 AM, Jiri Olsa wrote:
> On Thu, Apr 15, 2021 at 10:53:33PM +0800, Jin, Yao wrote:
> 
> SNIP
> 
>>
>> With my current code,
>>
>> static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
>> 					 const char *str, char *pmu_name,
>> 					 struct list_head *list)
>> {
>> 	struct parse_events_state ps = {
>> 		.list           = LIST_HEAD_INIT(ps.list),
>> 		.stoken         = PE_START_EVENTS,
>> 		.pmu_name       = pmu_name,
>> 		.idx            = parse_state->idx,
>> 	};
>> 	int ret;
>>
>> 	ret = parse_events__scanner(str, &ps);
>> 	perf_pmu__parse_cleanup();
>>
>> 	if (!ret) {
>> 		if (!list_empty(&ps.list)) {
>> 			list_splice(&ps.list, list);
>> 			parse_state->idx = ps.idx;
>> 		}
>> 	}
>>
>> 	return ret;
>> }
>>
>> The new created evsels are added to the tail of list (ps.list) and ps.list
>> is joined to the list (the parameter 'list').
>>
>> If we want to reuse the __parse_events(), we may need to:
>>
>> struct evlist *evlist = evlist__new();
> 
> there's the original evlist pointer passed to the initial parser
> that we should use no?
>

Unfortunately the answer is no. :(

For "cpu_core/LLC-loads/", if we do the parser twice by just calling __parse_events, actually the 
__parse_events will be called two times.

int __parse_events(struct evlist *evlist, const char *str,
		   struct parse_events_error *err, struct perf_pmu *fake_pmu,
		   char *pmu_name)
{
	struct parse_events_state parse_state = {
		.list	  = LIST_HEAD_INIT(parse_state.list),
		...
	};

	ret = parse_events__scanner(str, &parse_state);
	perf_pmu__parse_cleanup();

	if (!ret && list_empty(&parse_state.list)) {
		WARN_ONCE(true, "WARNING: event parser found nothing\n");
		return -1;
	}
	...
}

When returning to the first __parse_events,'parse_state.list' is an empty list so it would return 
"WARNING: event parser found nothing".

So in my patch, I pass a list pointer in and the new created evsels will be added to this list.

>>
>> __parse_events(evlist, str, NULL, NULL);
>> Add the evsels in evlist to the tail of list (the parameter 'list')
>> evlist__delete(evlist);
>>
>> Is my understanding correct?
>>
>> Yes, we have to change the interface of __parse_events() by adding a new
>> parameter 'pmu_name', which will bring much more changes. I agree to make
>> this change in follow-up patches.
> 
> let's check on this over the next version
>

That's fine, thanks.

Thanks
Jin Yao

> thanks,
> jirka
> 
