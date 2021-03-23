Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BF03467A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhCWSay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:30:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:38839 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbhCWSan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:30:43 -0400
IronPort-SDR: 8OhegiBb5bf9gyWkWtZ39AL4fgOgaIBGuW5Br1pRTTTxzfAj7A9lXGjEgZSEQh9jfbRwgLqAc5
 bT6WMZNPeTbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="190639488"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="190639488"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 11:30:42 -0700
IronPort-SDR: T9JJiSqyx5OMhoPwEFUsCZlg205hFE47iisvdkawz5cR6nRBRuMAVjrQAbMEN1GFdizjHo2fuC
 ZHan+M8izCBw==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="452262070"
Received: from laguitie-mobl.amr.corp.intel.com (HELO [10.252.129.185]) ([10.252.129.185])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 11:30:40 -0700
Subject: Re: [PATCH] soundwire: add slave device to linked list after
 device_register()
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, hui.wang@canonical.com,
        srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20210323022529.21915-1-yung-chuan.liao@linux.intel.com>
 <YFmRcPUxxFxkuMkr@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <82d579ca-5021-341c-1fcd-5c85c54c637b@linux.intel.com>
Date:   Tue, 23 Mar 2021 13:30:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFmRcPUxxFxkuMkr@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

>> We currently add the slave device to a linked list before
>> device_register(), and then remove it if device_register() fails.
>>
>> It's not clear why this sequence was necessary, this patch moves the
>> linked list management to after the device_register().
> 
> Maybe add a comment :-)
> 
> The reason here is that before calling device_register() we need to be
> ready and completely initialized. device_register is absolutely the last
> step in the flow, always.
> 
> The probe of the device can happen and before you get a chance to
> add to list, many number of things can happen.. So adding after is not a
> very good idea :)

Can you describe that 'many number of things' in the SoundWire context?

While you are correct in general on the use of device_register(), in 
this specific case the device registration and the possible Slave driver 
probe if there's a match doesn't seem to use this linked list.

This sdw_slave_add() routine is called while parsing ACPI/DT tables and 
at this point the bus isn't functional. This sequence only deals with 
device registration and driver probe, the actual activation and 
enumeration happen much later. What does matter is that by the time all 
ACPI/DT devices have been scanned all initialization is complete. The 
last part of the flow is not the device_register() at the individual 
peripheral level.

Even for the Qualcomm case, the steps are different:

	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
	if (ret) {
		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
			ret);
		goto err_clk;
	}

	qcom_swrm_init(ctrl); <<< that's where the bus is functional

Note that we are not going to lay on the tracks for this, this sequence 
was tagged by static analysis tools who don't understand that 
put_device() actually frees memory by way of the .release callback, but 
that led us to ask ourselves whether this sequence was actually necessary.
