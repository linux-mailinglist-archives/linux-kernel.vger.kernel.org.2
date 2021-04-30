Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A149836F55B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 07:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhD3Fev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 01:34:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:33785 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhD3Feu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 01:34:50 -0400
IronPort-SDR: zsTH57E6kL56eGs5N9aExQ963JYQvxbmc69I0dIQMlsGC5ZdEyA0EYjDSyeekpNsBOfG32t4RM
 UytZggnyxvcg==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="261149254"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="261149254"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 22:34:02 -0700
IronPort-SDR: NThRSyfq+B2eXPSttFzjjTOpmSIxzk5cZuVRR5CwVID8dBXoTNMHFbMNSYc012rlcMg3XSvyjX
 5KwPkxazOq+w==
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="424694985"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.46]) ([10.238.4.46])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 22:33:59 -0700
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by
 too_many_isolated()
To:     Hillf Danton <hdanton@sina.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        tim.c.chen@linux.intel.com, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, yuzhao@google.com,
        wfg@mail.ustc.edu.cn
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <20210422102325.1332-1-hdanton@sina.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <9795a050-12a4-55c6-13e1-969cd4bbf795@linux.intel.com>
Date:   Fri, 30 Apr 2021 13:33:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210422102325.1332-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

On 4/22/2021 6:23 PM, Hillf Danton wrote:
> Hi Zhengjun
> 
> On Thu, 22 Apr 2021 16:36:19 +0800 Zhengjun Xing wrote:
>>      In the system with very few file pages (nr_active_file +
>> nr_inactive_file < 100), it is easy to reproduce "nr_isolated_file >
>> nr_inactive_file",  then too_many_isolated return true,
>> shrink_inactive_list enter "msleep(100)", the long latency will happen.
> 
> We should skip reclaiming page cache in this case.
>>
>> The test case to reproduce it is very simple: allocate many huge
>> pages(near the DRAM size), then do free, repeat the same operation many
>> times.
>> In the test case, the system with very few file pages (nr_active_file +
>> nr_inactive_file < 100), I have dumpped the numbers of
>> active/inactive/isolated file pages during the whole test(see in the
>> attachments) , in shrink_inactive_list "too_many_isolated" is very easy
>> to return true, then enter "msleep(100)",in "too_many_isolated"
>> sc->gfp_mask is 0x342cca ("_GFP_IO" and "__GFP_FS" is masked) , it is
>> also very easy to enter “inactive >>=3”, then “isolated > inactive” will
>> be true.
>>
>> So I  have a proposal to set a threshold number for the total file pages
>> to ignore the system with very few file pages, and then bypass the 100ms
>> sleep.
>> It is hard to set a perfect number for the threshold, so I just give an
>> example of "256" for it.
> 
> Another option seems like we take a nap at the second time of lru tmi
> with some allocators in your case served without the 100ms delay.
> 
> +++ x/mm/vmscan.c
> @@ -118,6 +118,9 @@ struct scan_control {
>   	/* The file pages on the current node are dangerously low */
>   	unsigned int file_is_tiny:1;
>   
> +	unsigned int file_tmi:1; /* too many isolated */
> +	unsigned int anon_tmi:1;
> +
>   	/* Allocation order */
>   	s8 order;
>   
> @@ -1905,6 +1908,21 @@ static int current_may_throttle(void)
>   		bdi_write_congested(current->backing_dev_info);
>   }
>   
> +static void update_sc_tmi(struct scan_control *sc, bool file, int set)
> +{
> +	if (file)
> +		sc->file_tmi = set;
> +	else
> +		sc->anon_tmi = set;
> +}
> +static bool is_sc_tmi(struct scan_control *sc, bool file)
> +{
> +	if (file)
> +		return sc->file_tmi != 0;
> +	else
> +		return sc->anon_tmi != 0;
> +}
> +
>   /*
>    * shrink_inactive_list() is a helper for shrink_node().  It returns the number
>    * of reclaimed pages
> @@ -1927,6 +1945,11 @@ shrink_inactive_list(unsigned long nr_to
>   		if (stalled)
>   			return 0;
>   
> +		if (!is_sc_tmi(sc, file)) {
> +			update_sc_tmi(sc, file, 1);
> +			return 0;
> +		}
> +
>   		/* wait a bit for the reclaimer. */
>   		msleep(100);
>   		stalled = true;
> @@ -1936,6 +1959,9 @@ shrink_inactive_list(unsigned long nr_to
>   			return SWAP_CLUSTER_MAX;
>   	}
>   
> +	if (is_sc_tmi(sc, file))
> +		update_sc_tmi(sc, file, 0);
> +
>   	lru_add_drain();
>   
>   	spin_lock_irq(&lruvec->lru_lock);
> 

I use my compaction test case to test it, 1/10 ratio can reproduce 100ms 
sleep.

  60) @ 103942.6 us |      shrink_node();

  60) @ 103795.8 us |      shrink_node();





-- 
Zhengjun Xing
