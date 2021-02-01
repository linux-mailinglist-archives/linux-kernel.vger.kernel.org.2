Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AFA30AF5A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhBAScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:32:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:7675 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232196AbhBASPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:15 -0500
IronPort-SDR: 2hGfrMXC3zKZ4yBL2Qv3JKXgYOuVKPevhlie3OOdbyxzIK0N2SCLY8fKBdPP8u25agXckf7xcF
 JYUdWCtVAjXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="167833502"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="167833502"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:13:25 -0800
IronPort-SDR: F1OCSwCWMWWO8ZfuC0+dHytr+ZVp45YovOdB931iHaVBxxH4bG2VO6cOjrP59hwiAQVpvxkJcg
 G5D0zWmlXLJg==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="412516918"
Received: from dkhaldi-mobl1.amr.corp.intel.com (HELO [10.212.126.61]) ([10.212.126.61])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:13:24 -0800
Subject: Re: [PATCH 3/3] soundwire: bus: clear parity interrupt before the
 mask is enabled
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-4-yung-chuan.liao@linux.intel.com>
 <20210201110921.GZ2771@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f5ef9a07-73df-c2b6-3e03-001f53700c5b@linux.intel.com>
Date:   Mon, 1 Feb 2021 10:29:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201110921.GZ2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>   	 * Set SCP_INT1_MASK register, typically bus clash and
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index f7ba1a77a1df..c1fdc85d0a74 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -1286,7 +1286,8 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
>>   	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
>>   		prop->hw_disabled = true;
>>   
>> -	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH;
>> +	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
>> +		SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
> 
> move this to intel patch please..
> 
>>   
>>   	return 0;
>>   }
>> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
>> index a2766c3b603d..30415354d419 100644
>> --- a/include/linux/soundwire/sdw.h
>> +++ b/include/linux/soundwire/sdw.h
>> @@ -426,6 +426,7 @@ struct sdw_master_prop {
>>   };
>>   
>>   #define SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH	BIT(0)
>> +#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY	BIT(1)
> 
> Why not add this quirk in patch 1..?

There is an element of history here. We first found out about the bus 
clash on multiple devices and dealt with a specific bug number. Then we 
spend weeks on the parity issue on a new platform and ultimately showed 
we needed a similar work-around.

All these problems are not typical from a user perspective; they appear 
when loading/unloading modules in loops, at some point it seems some 
hardware devices don't always reset properly or there's something 
problematic in power delivery.

I don't think it's an issue if we refactor the code to add the quirks 
first, and add the intel.c patches later. We probably want 2 intel 
changes to keep the references to the bugs though and the detailed 
explanations.

> Also add comments about each quirk, hopefully it wont be a big table

Sounds fine.
