Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57394351E14
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbhDASed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:34:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:59283 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237572AbhDASNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:13:10 -0400
IronPort-SDR: KsjD3msCVTv4jhYn1X3/ZGzyyPDoCf8Kp62qx/CA0KDR7+rbspDZunmY6MDtYQLsdesdQKgKjj
 oZnOBrixhsIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="191782911"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="191782911"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:07:53 -0700
IronPort-SDR: hUv0QhRJR3t6yfi6jtJlSG5VCcsu/iRVnVk3Au/B+buJVyvvTkXfW/+6kHGR7P2kCaOwB2ItTw
 Kuhyy/IAV1eA==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="439311460"
Received: from vhsalasl-mobl.amr.corp.intel.com (HELO [10.255.229.235]) ([10.255.229.235])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:07:51 -0700
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <81c6b53b-e3fb-32d0-1e99-365d87ab6524@linux.intel.com>
Date:   Thu, 1 Apr 2021 13:07:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGX5AUQi41z52xk8@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +#define sdw_dev_dbg_or_err(dev, is_err, fmt, ...)			\
>>>> +	do {								\
>>>> +		if (is_err)						\
>>>> +			dev_err(dev, fmt, __VA_ARGS__);			\
>>>> +		else							\
>>>> +			dev_dbg(dev, fmt, __VA_ARGS__);			\
>>>> +	} while (0)
>>>
>>> I see a variant in sof code and now here, why not add in a
>>> dev_dbg_or_err() and use everywhere?
>>
>> Good point, I hesitated back and forth on specific v. generic macro.
>>
>> The main reason why I added this macro for SoundWire is that quite a few
>> subsystems have their own debug functions (DRM, ACPI, etc), and I wasn't
>> sure if there was any appetite to add more options in
>> include/linux/dev_printk.h. SOF also uses a different format due to history.
> 
> It is better if those other subsystems move to using the common kernel
> debug functions.  Historically they were all separate, there is no good
> reason for them to be that way today.
> 
> So please do not create custom subsystem debug macros like this just for
> this tiny set of drivers.
> 
> My bigger issue with this is that this macro is crazy.  Why do you need
> debugging here at all for this type of thing?  That's what ftrace is
> for, do not sprinkle code with "we got this return value from here!" all
> over the place like what this does.

We are not sprinkling the code all over the place with any new logs, 
they exist already in the SoundWire code and this patch helps filter 
them out. See e.g. patch 2/2

-			dev_err(&slave->dev,
-				"Clk Stop type =%d failed: %d\n", type, ret);
+			sdw_dev_dbg_or_err(&slave->dev, ret != -ENODATA,
+					   "Clk Stop mode %d type =%d failed: %d\n",
+					   mode, type, ret);

If you see all my recent patches they were precisely trying to avoid 
polluting the console logs with too much information that is irrelevant 
from most users, and making sure that when a log is provided it's 
uniquely identifiable.

There are similar macros where -EPROBE_DEFER is ignored.

This addresses a very SoundWire-specific case where if we see a -ENODATA 
error code (Command Ignored), we ignore it and don't report it by 
default. We still have a rare set of cases where this -ENODATA code 
shows up unexpectedly, possibly due to problematic reset sequences, and 
we want developers to help track them down what causes this sequence 
using dynamic debug.

I am not arguing about ftrace v. dynamic debug, and that's also partly 
why I didn't feel comfortable expanding the generic set of debug functions.


