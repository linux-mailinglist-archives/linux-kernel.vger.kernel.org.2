Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3993521F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhDAWFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:05:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:34268 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhDAWFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:05:04 -0400
IronPort-SDR: oN8roRDRc3VC+30SW0RDcNChcULTqZpvHEafYdwLFcTNdCXa0LYrHbD1tXTIVfb+dXifDbAWaE
 nWuNLbDLgnVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="189083514"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="189083514"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:05:03 -0700
IronPort-SDR: woQjBWDWfplgQxB3qXk7SrzORi4R9iUBUBLYsWqAfe1HPPurufWe5qeXqBto12Z+s9A69g7gjw
 APSsXzA0MO2Q==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="528362669"
Received: from wheiser-mobl.amr.corp.intel.com (HELO [10.209.2.25]) ([10.209.2.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:05:02 -0700
Subject: Re: [PATCH 1/2] soundwire: add macro to selectively change error
 levels
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
 <20210331011355.14313-2-yung-chuan.liao@linux.intel.com>
 <YGV1HYL+XcVmxfQG@vkoul-mobl.Dlink>
 <0834b9fc-9b3a-1184-fed2-6f9c7e66c6fb@linux.intel.com>
 <YGX5AUQi41z52xk8@kroah.com>
 <81c6b53b-e3fb-32d0-1e99-365d87ab6524@linux.intel.com>
 <YGYQIJh8X2C8sW44@kroah.com>
 <28515962-6fb1-511d-fc6b-f1422b11e6ab@linux.intel.com>
 <YGYzjWOz076M3ZUq@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a52b875b-3aa8-2e63-8a17-679dafc31507@linux.intel.com>
Date:   Thu, 1 Apr 2021 17:05:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGYzjWOz076M3ZUq@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/21 3:56 PM, Greg KH wrote:
> On Thu, Apr 01, 2021 at 01:43:53PM -0500, Pierre-Louis Bossart wrote:
>>
>>>>> My bigger issue with this is that this macro is crazy.  Why do you need
>>>>> debugging here at all for this type of thing?  That's what ftrace is
>>>>> for, do not sprinkle code with "we got this return value from here!" all
>>>>> over the place like what this does.
>>>>
>>>> We are not sprinkling the code all over the place with any new logs, they
>>>> exist already in the SoundWire code and this patch helps filter them out.
>>>> See e.g. patch 2/2
>>>>
>>>> -			dev_err(&slave->dev,
>>>> -				"Clk Stop type =%d failed: %d\n", type, ret);
>>>> +			sdw_dev_dbg_or_err(&slave->dev, ret != -ENODATA,
>>>> +					   "Clk Stop mode %d type =%d failed: %d\n",
>>>> +					   mode, type, ret);
>>>
>>> You just added a debug log for no reason.
>>
>> The number of logs is lower when dynamic debug is not enabled, and equal
>> when it is. there's no addition.
>>
>> The previous behavior was unconditional dev_err that everyone sees.
>>
>> Now it's dev_err ONLY when the code is NOT -ENODATA, and dev_dgb otherwise,
>> meaning it will seen ONLY be seen IF dynamic debug is enabled for
>> drivers/soundwire/bus.c
>>
>> Allow me to use another example from patch2:
>>
>> -		if (ret == -ENODATA)
>> -			dev_dbg(bus->dev,
>> -				"ClockStopNow Broadcast msg ignored %d", ret);
>> -		else
>> -			dev_err(bus->dev,
>> -				"ClockStopNow Broadcast msg failed %d", ret);
>> +		sdw_dev_dbg_or_err(bus->dev, ret != -ENODATA,
>> +				   "ClockStopNow Broadcast msg failed %d\n", ret);
>>
>> There's no new log, is there?
> 
> No, but that is not what you showed above which was just an error
> message being replaced with both a debug and an error message.

either debug or error message, not both.

> Just drop the debug messages, they are pointless, right?

That's the primary debug tool used with our friends at RedHat and 
Canonical, and that includes remote debug where we don't have access to 
the plaforms. We also have quite a few Bugzilla or github reports from 
community users who can provide the logs of alsa-info and dmesg, but 
that's about it. Those debug messages is what we get as feedback and 
test reports, so we absolutely need them to be 'to the point'.

Maybe to reassure you on the scope of the changes I am suggesting here, 
there is a total of *13* occurrences of dev_dbg() in the SoundWire bus 
code, and they were added in very specific branches where something goes 
boink to help folks like Bard and I figure out what sequence led to the 
problem. I think it's the same on Qualcomm platforms.

In these examples related to the clock stop/restart, a message will be 
generated during pm_runtime suspend/resume sequences and only when 
unexpected behavior is detected, so the total bandwidth used by these 
messages is minimal. It has to be that way, we are currently debugging 
cases where we see those odd behaviors after thousands of suspend/resume 
cycles, the last thing we want is to be swamped with "pointless" 
messages. It's not at all like we are reporting "hello, i have this 
error code", it's rather "this error code should not happen in this 
sequence". in 99% of the cases, the error code is actually not very 
useful, it's where the error occurs that is priceless for debug.



