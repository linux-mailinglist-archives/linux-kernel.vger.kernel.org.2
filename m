Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4592A3B544D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 18:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhF0QdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 12:33:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:34180 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhF0QdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="194998871"
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="scan'208";a="194998871"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 09:30:54 -0700
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="scan'208";a="624998023"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.138.183]) ([10.212.138.183])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 09:30:54 -0700
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
To:     Greg KH <greg@kroah.com>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
References: <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
 <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
 <29d5f315-578f-103c-9523-ae890e29c7e7@linux.intel.com>
 <YNVneO6exCS4ETRt@kroah.com>
 <540d8a38-da12-56c8-8306-8d3d61ae1d6b@linux.intel.com>
 <YNXqXwq1+o09eHox@kroah.com>
 <e670abe2-67b9-a602-410a-0c4170796ec7@linux.intel.com>
 <YNhauAgaUxMfTa+c@kroah.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <bdeb80ea-99dd-d9ea-d508-9cb8d2c6fbf4@linux.intel.com>
Date:   Sun, 27 Jun 2021 09:30:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNhauAgaUxMfTa+c@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Then do not break things by renaming the device name, as you all have
> now stated that this name is part of the user/kernel api.

The renaming comes from the fallback mode on future systems. In the 
fallback mode the driver doesn't know the true name, so it has to use  
the numeric name. If you don't use the fallback mode and have the full 
driver then yes you'll get the same names as always (or at least as they 
make sense for the hardware).

But we would like to have the fallback mode too to allow more people use 
uncore monitoring, and that's where the need to for the second name 
comes in.

>
> But really, I do not see why this is an issue, why isn't userspace just
> properly walking the list of devices and picking the one on this
> specific system that they want to look at?

perf is not an fully automated tool that knows what it wants to look at. 
It's not like udev etc.

It's a tool to let the user specify what they want to measure on the 
command line. And that specification is through the pmu name.

Of course it walks the list to find the name, but it can only chose 
based on the name the user specified.

It's like the ftrace tool doesn't know what trace points to measure on 
its own, it just knows what is specified on the command line. Or the ip 
tool doesn't know on its own what network device names to use for some 
network configuration, it has to get the information from the command line.


>
>>>> Anyways thinking about it if Greg doesn't want symlinks (even though sysfs
>>>> already has symlinks elsewhere), maybe we could just create two devices
>>>> without symlinks. Kan, do you think that would work?
>>> Do not have 2 different structures represent the same hardware device,
>>> that too is a shortcut to madness.
>>>
>>> What prevents userspace from handling device names changing today?  Why
>>> are you forcing userspace to pick a specific device name at all?
>> The way the perf tool works is that you have to specify the names on the
>> command line:
>>
>> perf stat -a -e uncore_cha/event=1/ ...
>>
>> With the numeric identifiers it would be
>>
>> perf stat -a -e uncore_type_X_Y/event=1/
>>
>> The tool handles it all abstractly.
> Great, and that device name is something that is unique per machine.
> And per boot.

No it's not unique and per boot. It's always the same on a given 
platform, it's specified by firmware. I would expect the names to be 
stable over all systems of a given chip.


>   So why are you suddenly thinking that this name has to be
> "stable"?
It's about as stable as the existing names. The existing names change 
sometimes too when the hardware changes (for example before Skylake we 
had "uncore_cbo", since Skylake there is "uncore_cha"). The numeric 
identifier should have similar stability (doesn't change as long as the 
hardware doesn't change significantly)


>
> If you think it does have to be stable, that was your choice, so now you
> must keep it stable.  Don't try to mess with symlinks and the like
> please, as again, that way lies madness and unmaintainability for the
> next 20+ years.

We keep it as stable as possible, but in the fallback mode only the 
numeric IDs are possible. In the "driver knows full hardware" mode it 
keeps the existing names, as possible.


>
>> So yes the user tools itself can handle it. But the problem is that it is
>> directly exposed to the users, so the users would need to change all their
>> scripts when switching between the two cases. That is what we're trying to
>> avoid -- provide them a way that works on both.
> But these are different systems!  Why would anyone expect that the
> device name is the same on different systems?

The scenario is that you run the same system but with two different kernels.

Kernel 1 doesn't know the model number and can only operate in fallback 
mode:

It only shows numeric IDs and that's what you have to use

Kernel 2 knows the model number and has a full driver which supports the 
full Linux standard naming.

You can use the standard names (like uncore_cha)

But the problem is that it would be impossible to write a script that 
works on both Kernel 1 and Kernel 2 on the same system without the 
symlink or equivalent.


>   If you insist on keeping
> the name identical for newer kernel versions, then again, that was your
> choice and now you have to do that.  Do not try to work around your own
> requirement by using a symlink.

Are you suggesting to only use numerical names everywhere?

That would be a big change for existing users. The idea was that people 
who use the fully enabled driver can use the much nicer symbolic names. 
But people who care about writing scripts that work everywhere can use 
the more difficult to use numeric names.

Anyways it looks like we're setting on using the "name" method suggested 
by Kan. I must say I'm not a big fan of it though, it's just another 
incompatible break in the perf ABI that would be totally avoidable.

-Andi

