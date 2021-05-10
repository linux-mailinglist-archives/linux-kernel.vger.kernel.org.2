Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E65377D96
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhEJIER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:04:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:21280 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhEJIER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:04:17 -0400
IronPort-SDR: lhL791BgKZA9wrFKbNQPFDAh86yKZhCFP3GPXT+rxWaWdRDAzwNxrxEyEnd5S1+3wzsfdo+bo6
 6j+L2L4NFWZQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="196042810"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="196042810"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 01:03:12 -0700
IronPort-SDR: AN/y3RejuPlCqM6tUe4aYI6QY++WmxRRK9R505lkXc1IHP4TrsL3gOYKKXisCHC3CygmspOFLi
 GLFHwYqOCDXA==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="433704819"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.87]) ([10.238.4.87])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 01:03:08 -0700
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
 <20210430064319.2189-1-hdanton@sina.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <e6dc0c7b-47eb-bad6-016b-73642930a68d@linux.intel.com>
Date:   Mon, 10 May 2021 16:03:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210430064319.2189-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

On 4/30/2021 2:43 PM, Hillf Danton wrote:
> On Fri, 30 Apr 2021 13:33:57 +0800 Xing Zhengjun wrote:
>>
>> I use my compaction test case to test it, 1/10 ratio can reproduce 100ms
>> sleep.
>>
>>   60) @ 103942.6 us |      shrink_node();
>>
>>   60) @ 103795.8 us |      shrink_node();
> 
> Thanks for your test.
> 
> In bid to cut the number of 100ms sleepers further down, add another place
> for them to nap by flushing lru cache before falling in sleep, instead of
> mulling why 50ms or 10ms is more adequate.
> 
> Alternatively, and simpler IMHO, take a 5ms nap one time until !tmi.
> 
> --- y/mm/vmscan.c
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
> @@ -2092,6 +2095,22 @@ static int current_may_throttle(void)
>   		bdi_write_congested(current->backing_dev_info);
>   }
>   
> +static void set_sc_tmi(struct scan_control *sc, bool file, int tmi)
> +{
> +	if (file)
> +		sc->file_tmi = tmi;
> +	else
> +		sc->anon_tmi = tmi;
> +}
> +
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
> @@ -2109,11 +2128,23 @@ shrink_inactive_list(unsigned long nr_to
>   	enum vm_event_item item;
>   	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>   	bool stalled = false;
> +	bool drained = false;
>   
>   	while (unlikely(too_many_isolated(pgdat, file, sc))) {
>   		if (stalled)
>   			return 0;
>   
> +		if (!is_sc_tmi(sc, file)) {
> +			set_sc_tmi(sc, file, 1);
> +			return 0;
> +		}
> +
> +		if (!drained) {
> +			drained = true;
> +			lru_add_drain_all();
> +			continue;
> +		}
> +
>   		/* wait a bit for the reclaimer. */
>   		msleep(100);
>   		stalled = true;
> @@ -2123,6 +2154,9 @@ shrink_inactive_list(unsigned long nr_to
>   			return SWAP_CLUSTER_MAX;
>   	}
>   
> +	if (is_sc_tmi(sc, file))
> +		set_sc_tmi(sc, file, 0);
> +
>   	lru_add_drain();
>   
>   	spin_lock_irq(&lruvec->lru_lock);
> 

I tried the patch, it still can reproduce the 100ms sleep.

52) @ 103829.8 us |      shrink_lruvec();

-- 
Zhengjun Xing
