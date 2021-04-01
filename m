Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63658351F32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbhDASzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:55:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:38588 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235500AbhDASsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:48:04 -0400
IronPort-SDR: bGFiFkXNchjmRtbdE8J4hk4X+Nw3NcRM5ym7McRO/dyw6UX8HOlHrbo8Rad5a6HJvDtftOb+Ox
 JMUUuHxcjSVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179441590"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179441590"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:43:55 -0700
IronPort-SDR: XJBnaXm9h/BWh45aFK0GTo2R4IxM5/A3Xo6knAgunzHIBxvkdZt8F2zLF4Z/kJc3P5M0pneP18
 dCqZmHCspH7g==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="439323382"
Received: from vhsalasl-mobl.amr.corp.intel.com (HELO [10.255.229.235]) ([10.255.229.235])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:43:54 -0700
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <28515962-6fb1-511d-fc6b-f1422b11e6ab@linux.intel.com>
Date:   Thu, 1 Apr 2021 13:43:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGYQIJh8X2C8sW44@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> My bigger issue with this is that this macro is crazy.  Why do you need
>>> debugging here at all for this type of thing?  That's what ftrace is
>>> for, do not sprinkle code with "we got this return value from here!" all
>>> over the place like what this does.
>>
>> We are not sprinkling the code all over the place with any new logs, they
>> exist already in the SoundWire code and this patch helps filter them out.
>> See e.g. patch 2/2
>>
>> -			dev_err(&slave->dev,
>> -				"Clk Stop type =%d failed: %d\n", type, ret);
>> +			sdw_dev_dbg_or_err(&slave->dev, ret != -ENODATA,
>> +					   "Clk Stop mode %d type =%d failed: %d\n",
>> +					   mode, type, ret);
> 
> You just added a debug log for no reason.

The number of logs is lower when dynamic debug is not enabled, and equal 
when it is. there's no addition.

The previous behavior was unconditional dev_err that everyone sees.

Now it's dev_err ONLY when the code is NOT -ENODATA, and dev_dgb 
otherwise, meaning it will seen ONLY be seen IF dynamic debug is enabled 
for drivers/soundwire/bus.c

Allow me to use another example from patch2:

-		if (ret == -ENODATA)
-			dev_dbg(bus->dev,
-				"ClockStopNow Broadcast msg ignored %d", ret);
-		else
-			dev_err(bus->dev,
-				"ClockStopNow Broadcast msg failed %d", ret);
+		sdw_dev_dbg_or_err(bus->dev, ret != -ENODATA,
+				   "ClockStopNow Broadcast msg failed %d\n", ret);

There's no new log, is there?

If that still gives you a heartburn, I would still like a macro that 
filters out dev_err so that we don't report an error when it's 
recoverable or harmless, and don't have spaghetti code as above.

