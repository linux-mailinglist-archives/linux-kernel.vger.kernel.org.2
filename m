Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A93085A5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhA2GWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:22:17 -0500
Received: from mga05.intel.com ([192.55.52.43]:16617 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231865AbhA2GWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:22:15 -0500
IronPort-SDR: Y9xzKSUZy/2YtgeHANJhrVWILabBAq0jKQDZ3hOB3G6n6+WLXCv24e2gVXGawmJqDNXQkfF8ZB
 PwiJScUVwAgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="265205820"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="265205820"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 22:20:26 -0800
IronPort-SDR: PTvcyZV7VwjFvWOZ32vekl7hEPMTxba1TDt8Ys39mWCvzz6H9sqmFpByvqUSBqaBvsxMhxeBX3
 aOZ0fFIrHsMw==
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="364181083"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.6.97]) ([10.238.6.97])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 22:20:23 -0800
Subject: Re: [workqueue] d5bff968ea:
 WARNING:at_kernel/workqueue.c:#process_one_work
To:     paulmck@kernel.org, Hillf Danton <hdanton@sina.com>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@intel.com,
        lkp <lkp@lists.01.org>
References: <20210126073925.1962-1-hdanton@sina.com>
 <20210127092128.2299-1-hdanton@sina.com>
 <20210128090905.1596-1-hdanton@sina.com>
 <20210128180821.GA24510@paulmck-ThinkPad-P72>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <bfb8370e-43e4-7f72-a71f-8481eb66f6ed@linux.intel.com>
Date:   Fri, 29 Jan 2021 14:20:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210128180821.GA24510@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/2021 2:08 AM, Paul E. McKenney wrote:
> On Thu, Jan 28, 2021 at 05:09:05PM +0800, Hillf Danton wrote:
>> On Thu, 28 Jan 2021 15:52:40 +0800 Xing Zhengjun wrote:
> 
> [ . . . ]
> 
>>> I test the patch 4 times, no warning appears in the kernel log.
>>
>> Thank you so much Zhengjun!
>>
>> And the overall brain dump so far is
>>
>> 1/ before and after d5bff968ea, changing the allowed ptr at online time
>> is the key to quiesce the warning in process_one_work().
>>
>> 2/ marking pcpu before changing aptr in rebind_workers() is mandatory in
>> regards to cutting the risk of triggering such a warning.
>>
>> 3/ we canot maintain such an order without quiescing the 508 warning for
>> kworkers. And we have a couple of excuses to do so, a) the number of
>> allowed CPUs is no longer checked in is_per_cpu_kthread() instead of
>> PF_NO_SETAFFINITY, b) there is always a followup act to change the aptr
>> in order to fix the number of aCPUs.
>>
>> 4/ same order is maintained also at rescue time.
> 
> Just out of curiosity, does this test still fail on current mainline?
> 
> 							Thanx, Paul
> 
I test mainline v5.11-rc5, it has no issue. The issue is only for 
d5bff968ea which is in 
https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git 
dev.2021.01.11b.

-- 
Zhengjun Xing
