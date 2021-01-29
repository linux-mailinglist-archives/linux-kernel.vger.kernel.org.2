Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33EF30829C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhA2Aou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:44:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:35076 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231533AbhA2AoK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:44:10 -0500
IronPort-SDR: bVLX24bwN/PvoR24bXTzbdcgeB3zwhnh8A8nY3pAI99a7ZcnMsjbFPY2RGuxMn2sh84iSMoOki
 zlLQY+/ieisA==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="179557028"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="179557028"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 16:42:25 -0800
IronPort-SDR: YSzXX9YougShau0JeA9nx89CDwaqOvjb5PtTjeD+2L1qV1bjCkKZ6e15fxIw58GfIJkQY7dIrr
 ukg/PPfo+ezw==
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="389076993"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 16:42:22 -0800
Subject: Re: [PATCH 1/2] perf script: Support filtering by hex address
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20210124232750.19170-1-yao.jin@linux.intel.com>
 <20210127222905.GD284633@krava>
 <60d102fa-d98a-6182-0a1d-b78122fed574@linux.intel.com>
 <20210128124310.GC775562@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <fd4b4b53-a871-bb24-7923-abe965111273@linux.intel.com>
Date:   Fri, 29 Jan 2021 08:42:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210128124310.GC775562@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/2021 8:43 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 28, 2021 at 11:31:26AM +0800, Jin, Yao escreveu:
>> On 1/28/2021 7:13 AM, Jiri Olsa wrote:
>>>> @@ -709,6 +725,26 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>>>>    			ret = strlist__has_entry(symbol_conf.sym_list, al_addr_str);
>>>>    		}
>>>> +		if (!ret && al->map) {
>>>> +			snprintf(al_addr_str, sz, "0x%"PRIx64,
>>>> +				al->map->unmap_ip(al->map, al->addr));
>>>> +			ret = strlist__has_entry(symbol_conf.sym_list,
>>>> +						 al_addr_str);
>>>> +			if (!ret) {
>>>> +				/* Check for hex without "0x" prefix */
>>>> +				snprintf(al_addr_str, sz, "%"PRIx64,
>>>> +					al->map->unmap_ip(al->map, al->addr));
>>>> +				ret = strlist__has_entry(symbol_conf.sym_list,
>>>> +							 al_addr_str);
>>>> +			}
>>> that seems tricky.. what if user specify more leading zeros,
>>> I think it'd be better to search intlist instead
> 
>>> we could move all 'address' entries from sym_list to
>>> new intlist (in symbol__init) and use it for this search
> 
>> intlist now only supports 'int' type.
> 
>> I'm considering to use 'long' to replace original 'int' in struct int_node.
> 
>> struct int_node {
>> 	struct rb_node rb_node;
>> -	int i;
>> +	long i;
>> 	void *priv;
>> };
> 
>> On 32 bits platform, sizeof(long) is 4, and on 64 bits platform,
>> sizeof(long) is 8. So that should be OK for storing the values such as
>> pid/tid and address.
> 
>> I'm not very clear why currently it uses 'int' for i in struct int_node,
>> maybe something I don't understand correctly. Please correct me if my
>> understanding is wrong.
> 
> I think its ok to make it a long, it won't even enlarge the struct
> because:
> 
> [acme@quaco pahole]$ pahole -C int_node ~/bin/perf
> struct int_node {
> 	struct rb_node             rb_node __attribute__((__aligned__(8))); /*     0    24 */
> 	int                        i;                                       /*    24     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	void *                     priv;                                    /*    32     8 */
> 
> 	/* size: 40, cachelines: 1, members: 3 */
> 	/* sum members: 36, holes: 1, sum holes: 4 */
> 	/* forced alignments: 1 */
> 	/* last cacheline: 40 bytes */
> } __attribute__((__aligned__(8)));
> [acme@quaco pahole]$
> 
> :-)
> 
> - Arnaldo
> 

Thanks Arnaldo!

OK, let me try to improve the intlist.

Thanks
Jin Yao

