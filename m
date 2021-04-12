Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864D835B7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 03:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbhDLBOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 21:14:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:13526 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235391AbhDLBOi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 21:14:38 -0400
IronPort-SDR: 9UfcqH5JSWNwhyJbYI/IW5MQpWXTEhz3puG0uNyN2ztWPtOv2CQuK/oOU5C9vL5WOZsIkO0TL6
 vbU4Q5/eAEZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="194200583"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="194200583"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 18:14:21 -0700
IronPort-SDR: h9P6aMusHIfcsZBfzlT4G5OhV11bc/YyqDIzm2el1plkuW+MnKGtI9WY7xf3R9w487qlcOPiRA
 bhhXZJs1D/Kw==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="451215331"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 18:14:18 -0700
Subject: Re: [PATCH v3 10/27] perf parse-events: Create two hybrid raw events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-11-yao.jin@linux.intel.com> <YHBbVMNSCsu/bbii@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <7e4842f3-e758-b932-2ce2-fe1c0c891897@linux.intel.com>
Date:   Mon, 12 Apr 2021 09:14:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHBbVMNSCsu/bbii@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/9/2021 9:49 PM, Jiri Olsa wrote:
> On Mon, Mar 29, 2021 at 03:00:29PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +					      name, config_terms, pmu);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
>>   				     struct list_head *list,
>>   				     struct perf_event_attr *attr,
>> @@ -91,6 +126,9 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
>>   	if (attr->type != PERF_TYPE_RAW) {
>>   		return add_hw_hybrid(parse_state, list, attr, name,
>>   				     config_terms);
>> +	} else {
>> +		return add_raw_hybrid(parse_state, list, attr, name,
>> +				      config_terms);
>>   	}
>>   
>>   	return -1;
> 
> no need for the return -1
> 
> jirka
> 

Yes, no need return -1 here.

if (attr->type != PERF_TYPE_RAW) {
	return add_hw_hybrid(parse_state, list, attr, name,
			     config_terms);
}

return add_raw_hybrid(parse_state, list, attr, name,
		      config_terms);

Thanks
Jin Yao

>> -- 
>> 2.17.1
>>
> 
