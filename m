Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A4D31223A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 08:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhBGHaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 02:30:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:23368 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhBGH37 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 02:29:59 -0500
IronPort-SDR: 6xCcoN+EQdZ8XcnHfiC/HYsXRBjRNlPW6Q0FNbYrT0jR+WvEDJYjs8mr94NvNy/904ca+L/mxG
 p+3PWbp9YhUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9887"; a="200626444"
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="200626444"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 23:28:12 -0800
IronPort-SDR: z4MyDx1MepWdMl/sEpwFBW2dPbiL0gSPt/C0+Pm/pL/th+UXcarKHm1cuxJhoRKqYMLA72NmgS
 g6tJIZTriDtg==
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="435199352"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 23:28:09 -0800
Subject: Re: [PATCH v2 2/2] perf script: Support filtering by hex address
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210129070854.29312-1-yao.jin@linux.intel.com>
 <20210129070854.29312-2-yao.jin@linux.intel.com> <YB0UvM6t+BSqQkkk@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <275089b5-f69c-1ebd-ea69-634785844421@linux.intel.com>
Date:   Sun, 7 Feb 2021 15:28:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YB0UvM6t+BSqQkkk@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 2/5/2021 5:49 PM, Jiri Olsa wrote:
> On Fri, Jan 29, 2021 at 03:08:54PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +			}
>> +		}
>> +
>>   		if (!ret)
>>   			al->filtered |= (1 << HIST_FILTER__SYMBOL);
>>   	}
>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>> index 64a039cbba1b..2c13f6acda7f 100644
>> --- a/tools/perf/util/symbol.c
>> +++ b/tools/perf/util/symbol.c
>> @@ -2406,6 +2406,39 @@ int setup_intlist(struct intlist **list, const char *list_str,
>>   	return 0;
>>   }
>>   
>> +static int setup_addrlist(struct intlist **addr_list, struct strlist *sym_list)
>> +{
>> +	struct str_node *pos, *tmp;
>> +	unsigned long val;
>> +	char *sep;
>> +	int err = 0, i = 0;
>> +
>> +	*addr_list = intlist__new(NULL);
>> +	if (!*addr_list)
>> +		return -1;
>> +
>> +	strlist__for_each_entry_safe(pos, tmp, sym_list) {
>> +		val = strtoul(pos->s, &sep, 16);
>> +		if (*sep != ',' && *sep != '\0')
>> +			continue;
> 
> I think you also need to check that val is valid and errno
> (check other strtoul we call in perf)
> because above could pass for:
> 
> 	$ ./perf script -S ",7fd0f1b69a13"
> 	ls 651468 410180.795577:      90098 cycles:u:      7fd0f1b69a13 __GI___tunables_init+0x73 (/usr/lib64/ld-2.32.so)
> 
> 

Now I think this may be OK because that's not the pattern matching. It just matches the 7fd0f1b69a13 
in address list.

And we also need to support the address + symbol combination, such as,

$ ./perf script -S "ffffffff9a51de2a,put_cmsg"
          swapper     0 [007] 347304.359521:      44937   cycles:  ffffffff9a51de2a rcu_core+0x29a 
([kernel.kallsyms])
     avahi-daemon   580 [007] 347304.468122:      57176   cycles:  ffffffff9af4764e put_cmsg+0xde 
([kernel.kallsyms])

So the idea is when we can get a valid address from -S list, we add the address to intlist for 
address comparison otherwise we still leave it to symbol list for symbol comparison.

Anyway, I will post v3 patch for review.

Thanks
Jin Yao

> plus check for " " so we could do:
> 
> 	$ ./perf script -S "7fd0f1b69a13 ,7fd0f1b5e189"
> 	ls 651468 410180.796055:     190731 cycles:u:      7fd0f1b5e189 _dl_relocate_object+0x4b9 (/usr/lib64/ld-2.32.so)
> 
> 	$ ./perf script -S "7fd0f1b69a13,7fd0f1b5e189"
> 	ls 651468 410180.795577:      90098 cycles:u:      7fd0f1b69a13 __GI___tunables_init+0x73 (/usr/lib64/ld-2.32.so)
> 	ls 651468 410180.796055:     190731 cycles:u:      7fd0f1b5e189 _dl_relocate_object+0x4b9 (/usr/lib64/ld-2.32.so)
> 
> 
> thanks,
> jirka
> 
