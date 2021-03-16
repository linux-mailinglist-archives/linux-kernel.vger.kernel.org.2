Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55ECE33D753
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhCPP0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:26:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:13297 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236553AbhCPP0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:26:09 -0400
IronPort-SDR: rUF9XKy77fHPoHUi11zS+RNRZCV5vF1XgR9VBK0JTNqmVggQVBJ1ldkebDN8WZaPGsjauJw/KO
 jVm/7XumMaQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="253294335"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="253294335"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 08:26:08 -0700
IronPort-SDR: T1tvaQwjJrhj/w5sG9FACKGib5o9ePzpPZ5JOsPPqCIzE2c9DiWw/37sGBEZCNvTJ2u4sLpXb4
 4a4xa5UDbAjg==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="405574234"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.154.190]) ([10.249.154.190])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 08:26:05 -0700
Subject: Re: [PATCH 01/10] tick/nohz: Prevent tick_nohz_get_sleep_length()
 from returning negative value
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
References: <20210311123708.23501-1-frederic@kernel.org>
 <20210311123708.23501-2-frederic@kernel.org>
 <YFCiycIaViYCy3GH@hirez.programming.kicks-ass.net>
 <20210316133703.GC639918@lothringen>
 <YFDCOYstnDWPSWRU@hirez.programming.kicks-ass.net>
 <20210316145352.GE639918@lothringen>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <ab753f1f-b03d-2a26-a552-b91f98708353@intel.com>
Date:   Tue, 16 Mar 2021 16:26:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316145352.GE639918@lothringen>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/2021 3:53 PM, Frederic Weisbecker wrote:
> On Tue, Mar 16, 2021 at 03:35:37PM +0100, Peter Zijlstra wrote:
>> On Tue, Mar 16, 2021 at 02:37:03PM +0100, Frederic Weisbecker wrote:
>>> On Tue, Mar 16, 2021 at 01:21:29PM +0100, Peter Zijlstra wrote:
>>>> On Thu, Mar 11, 2021 at 01:36:59PM +0100, Frederic Weisbecker wrote:
>>>>> From: "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
>>>>>
>>>>> If the hardware clock happens to fire its interrupts late, two possible
>>>>> issues can happen while calling tick_nohz_get_sleep_length(). Either:
>>>>>
>>>>> 1) The next clockevent device event is due past the last idle entry time.
>>>>>
>>>>> or:
>>>>>
>>>>> 2) The last timekeeping update happened before the last idle entry time
>>>>>     and the next timer callback expires before the last idle entry time.
>>>>>
>>>>> Make sure that both cases are handled to avoid returning a negative
>>>>> duration to the cpuidle governors.
>>>> Why? ... and wouldn't it be cheaper the fix the caller to
>>>> check negative once, instead of adding two branches here?
>>> There are already two callers and potentially two return values to check
>>> for each because the function returns two values.
>>>
>>> I'd rather make the API more robust instead of fixing each callers and worrying
>>> about future ones.
>> But what's the actual problem? The Changelog doesn't say why returning a
>> negative value is a problem, and in fact the return value is explicitly
>> signed.
>>
>> Anyway, I don't terribly mind the patch, I was just confused by the lack
>> of actual justification.
> And you're right, the motivation is pure FUD: I don't know exactly
> how the cpuidle governors may react to such negative values and so this
> is just to prevent from potential accident.
>
> Rafael, does that look harmless to you?

No, this is a problem now.  Both governors using this assign the return 
value of it to a u64 var and so negative values confuse them.

That said I think it's better to deal with the issue in the callers.

I can send a patch for that if needed.


