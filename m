Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BF630C7CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhBBRcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:32:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:7374 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237453AbhBBR3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:29:34 -0500
IronPort-SDR: V+7L+e5PB1pSRQE1BANexJzzHPLt3lffkAqFdW2YmJa8vL1baFNrNGpsqrwbbMDfqCvEF5T2rI
 0gmpEpGqQS+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="242408110"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="242408110"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 09:27:45 -0800
IronPort-SDR: mNqUK6PtHH5g6VYtxaLXDQpljJFz5EpdFWbcv3vZhCzSoAVmLGLf/7QFeT1ATKeVCncVZkE/LL
 BnFYE1DoncAw==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="370798466"
Received: from ncruzgar-mobl.amr.corp.intel.com (HELO [10.212.75.122]) ([10.212.75.122])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 09:27:44 -0800
Subject: Re: [PATCH 1/3] soundwire: bus: clear bus clash interrupt before the
 mask is enabled
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        jank@cadence.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-2-yung-chuan.liao@linux.intel.com>
 <20210201102844.GU2771@vkoul-mobl> <20210201103825.GV2771@vkoul-mobl>
 <7c4e1163-a6b3-2886-1963-7e2847dc2836@linux.intel.com>
 <20210202043909.GG2771@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4117cd57-1643-758f-b59c-ac507a6f5ed2@linux.intel.com>
Date:   Tue, 2 Feb 2021 10:52:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202043909.GG2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/21 10:39 PM, Vinod Koul wrote:
> On 01-02-21, 10:18, Pierre-Louis Bossart wrote:
>> On 2/1/21 4:38 AM, Vinod Koul wrote:
>>> On 01-02-21, 15:58, Vinod Koul wrote:
>>>> On 26-01-21, 16:37, Bard Liao wrote:
>>>
>>>>>    struct sdw_master_prop {
>>>>>    	u32 revision;
>>>>> @@ -421,8 +422,11 @@ struct sdw_master_prop {
>>>>>    	u32 err_threshold;
>>>>>    	u32 mclk_freq;
>>>>>    	bool hw_disabled;
>>>>> +	u32 quirks;
>>>>
>>>> Can we do u64 here please.. I dont know where we would end up.. but
>>>> would hate if we start running out of space ..
>> No objection.
>>
>>> Also, is the sdw_master_prop right place for a 'quirk' property. I think
>>> we can use sdw_master_device or sdw_bus as this seems like a bus
>>> quirk..?
>>
>> It's already part of sdw_bus
> 
> Right, but the point is that the properties were mostly derived from
> DiSco, so am bit skeptical about it adding it there..

Oh, I am planning to contribute such quirks as MIPI DisCo properties for 
the next revision of the document (along with a capability to disable a 
link). This was not intended to remain Linux- or Intel-specific.

>> struct sdw_bus {
>> 	struct device *dev;
>> 	struct sdw_master_device *md;
>> 	unsigned int link_id;
>> 	int id;
>> 	struct list_head slaves;
>> 	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
>> 	struct mutex bus_lock;
>> 	struct mutex msg_lock;
>> 	int (*compute_params)(struct sdw_bus *bus);
>> 	const struct sdw_master_ops *ops;
>> 	const struct sdw_master_port_ops *port_ops;
>> 	struct sdw_bus_params params;
>> 	struct sdw_master_prop prop;
>>
>> The quirks could be set by a firmware property, and it seems logical to add
>> them at the same place where we already have properties defined in firmware,
>> no? That way all the standard, vendor-specific and quirks are read or added
>> in the same place.
> 
> Or they could be set by driver as well based on device id, compatible
> and so on.. It maybe fw property as well, so limiting to property may not
> be best idea IMO.

Not following, sorry. I didn't mean that only firmware can set them.

All of these sdw_master_prop can come from firmware or be hard-coded by 
a driver for a specific implementation. The point is that they need to 
be provided to the bus core so that it knows what to do.

If you look at DisCo today, we ignore the settings for the Slave 
(unfortunately all wrong in BIOS) so the Slave properties are hard-coded 
in drivers, but do use most of the firmware information for the Master, 
so it's really firmware and/or driver that can set these properties.

>> the sdw_master_device isn't a good place for quirks IMHO, it's a very
>> shallow software-only layer without any existing ties to the hardware
>> definition.
> 
> This one I would agree.
> 
