Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED6930AF75
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhBASea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:34:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:7671 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232209AbhBASPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:14 -0500
IronPort-SDR: aOkbtTgHCHpelxw/qMZ66MQVy6FPBhWo5knd3gD7kkSGW58RthZ8DwWHFDYlbBg1u1wrGi6oEe
 YPyorU5Nd+iA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="167833499"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="167833499"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:13:23 -0800
IronPort-SDR: YaexhowrX58cGW5Z/SvbLYYQls9i/sLfs+0sE7by42KAMEA666T5cZYT/LIzdos1aFkFmF+LQE
 txYpvk/Quzmg==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="412516907"
Received: from dkhaldi-mobl1.amr.corp.intel.com (HELO [10.212.126.61]) ([10.212.126.61])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:13:22 -0800
Subject: Re: [PATCH 2/3] soundwire: intel: add
 SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH quirk
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        jank@cadence.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-3-yung-chuan.liao@linux.intel.com>
 <20210201104229.GY2771@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0ed1c91b-09ca-dc6f-39d1-850d12f4f9c4@linux.intel.com>
Date:   Mon, 1 Feb 2021 10:20:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201104229.GY2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/21 4:42 AM, Vinod Koul wrote:
> On 26-01-21, 16:37, Bard Liao wrote:
>> There is nothing we can do to handle the bus clash interrupt before
>> interrupt mask is enabled.
>>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
>> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/intel.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index a2d5cdaa9998..f7ba1a77a1df 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -1286,6 +1286,8 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
>>   	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
>>   		prop->hw_disabled = true;
>>   
>> +	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH;
> 
> Should this not be last 'enabling' the quirk patch in series :)

Sorry, I don't understand the comment. Do you mind clarifying Vinod?
