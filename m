Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70E9351EE3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbhDAStc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:49:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:38667 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240124AbhDAS3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:29:22 -0400
IronPort-SDR: U8juh3sFqI/MiMgcyvi6hlGlRlGSNh6q+Wj+GWvcnstVgwG1EM66L0dyAQv6q35PxO5g6UlD2c
 zluZT2cp6C+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179810968"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179810968"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 09:03:16 -0700
IronPort-SDR: cAR40v7d018XsTBUAdMQukLsb5kSh2+85FiTEUz4GVp+oAEcO4KTJuhBah1nX5eXJAzrL1GdHx
 Ve/OjK3d+C0w==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="439265744"
Received: from mooreale-mobl.amr.corp.intel.com (HELO [10.255.229.43]) ([10.255.229.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 09:03:14 -0700
Subject: Re: [PATCH 1/2] soundwire: add macro to selectively change error
 levels
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, hui.wang@canonical.com,
        sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
        bard.liao@intel.com
References: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
 <20210331011355.14313-2-yung-chuan.liao@linux.intel.com>
 <YGV1HYL+XcVmxfQG@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0834b9fc-9b3a-1184-fed2-6f9c7e66c6fb@linux.intel.com>
Date:   Thu, 1 Apr 2021 09:30:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGV1HYL+XcVmxfQG@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/21 2:24 AM, Vinod Koul wrote:
> On 31-03-21, 09:13, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> We sometimes discard -ENODATA when reporting errors and lose all
>> traces of issues in the console log, add a macro to add use dev_dbg()
>> in such cases.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Rander Wang <rander.wang@intel.com>
>> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> ---
>>   drivers/soundwire/bus.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
>> index 40354469860a..8370216f95d4 100644
>> --- a/drivers/soundwire/bus.h
>> +++ b/drivers/soundwire/bus.h
>> @@ -227,4 +227,12 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
>>   void sdw_clear_slave_status(struct sdw_bus *bus, u32 request);
>>   int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
>>   
>> +#define sdw_dev_dbg_or_err(dev, is_err, fmt, ...)			\
>> +	do {								\
>> +		if (is_err)						\
>> +			dev_err(dev, fmt, __VA_ARGS__);			\
>> +		else							\
>> +			dev_dbg(dev, fmt, __VA_ARGS__);			\
>> +	} while (0)
> 
> I see a variant in sof code and now here, why not add in a
> dev_dbg_or_err() and use everywhere?

Good point, I hesitated back and forth on specific v. generic macro.

The main reason why I added this macro for SoundWire is that quite a few 
subsystems have their own debug functions (DRM, ACPI, etc), and I wasn't 
sure if there was any appetite to add more options in 
include/linux/dev_printk.h. SOF also uses a different format due to history.

If at the end of the day SoundWire and SOF are the only users the value 
of a common macro is limited.

But it's true that the macro could be used by others.

I really have no opinion here and will follow the consensus.
