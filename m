Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B626830AEF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhBASSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:18:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:7666 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232208AbhBASPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:14 -0500
IronPort-SDR: gYmzzTCOXInQz9w0W9ZGOuO5HSpTip0kZLnybGdLsZt+cWafk1QK+M87PB0SCUB85LE4tXpw0n
 xs5vuN+aVKWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="167833497"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="167833497"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:13:21 -0800
IronPort-SDR: GhejXAFevh58ldyZmFLRdCBJ1GI5sKz2A0q9xIOWgmDmIhM+m5E1DC1qWm+ecEpW5SWFb1q3/q
 nryH6bHsZecQ==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="412516898"
Received: from dkhaldi-mobl1.amr.corp.intel.com (HELO [10.212.126.61]) ([10.212.126.61])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:13:20 -0800
Subject: Re: [PATCH 1/3] soundwire: bus: clear bus clash interrupt before the
 mask is enabled
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        jank@cadence.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-2-yung-chuan.liao@linux.intel.com>
 <20210201102844.GU2771@vkoul-mobl> <20210201103825.GV2771@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7c4e1163-a6b3-2886-1963-7e2847dc2836@linux.intel.com>
Date:   Mon, 1 Feb 2021 10:18:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201103825.GV2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/21 4:38 AM, Vinod Koul wrote:
> On 01-02-21, 15:58, Vinod Koul wrote:
>> On 26-01-21, 16:37, Bard Liao wrote:
> 
>>>   struct sdw_master_prop {
>>>   	u32 revision;
>>> @@ -421,8 +422,11 @@ struct sdw_master_prop {
>>>   	u32 err_threshold;
>>>   	u32 mclk_freq;
>>>   	bool hw_disabled;
>>> +	u32 quirks;
>>
>> Can we do u64 here please.. I dont know where we would end up.. but
>> would hate if we start running out of space ..
No objection.

> Also, is the sdw_master_prop right place for a 'quirk' property. I think
> we can use sdw_master_device or sdw_bus as this seems like a bus
> quirk..?

It's already part of sdw_bus

struct sdw_bus {
	struct device *dev;
	struct sdw_master_device *md;
	unsigned int link_id;
	int id;
	struct list_head slaves;
	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
	struct mutex bus_lock;
	struct mutex msg_lock;
	int (*compute_params)(struct sdw_bus *bus);
	const struct sdw_master_ops *ops;
	const struct sdw_master_port_ops *port_ops;
	struct sdw_bus_params params;
	struct sdw_master_prop prop;

The quirks could be set by a firmware property, and it seems logical to 
add them at the same place where we already have properties defined in 
firmware, no? That way all the standard, vendor-specific and quirks are 
read or added in the same place.

the sdw_master_device isn't a good place for quirks IMHO, it's a very 
shallow software-only layer without any existing ties to the hardware 
definition.

