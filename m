Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D21832A98A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580973AbhCBSc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:32:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:45312 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1575760AbhCBPoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:44:05 -0500
IronPort-SDR: sxGtewkBZfqjaMGSHeKSS6z7FtdQh8dgBlIyHabwPRDEx1HGkBhdJX+eJ1V5lNjQQybbo5JyPC
 +NROOpG4Ttkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="183457955"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="183457955"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:38:16 -0800
IronPort-SDR: t42/PZ4jrGz5dxXWIJGpDdOBP7Y3nto3jy/t28rx/oVdcVQ+CnqbmheaJGiVU7FM0MDBb/mG1R
 vFwLjBHQaxIw==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="406768964"
Received: from bgrewell-mobl3.amr.corp.intel.com (HELO [10.212.242.206]) ([10.212.242.206])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:38:15 -0800
Subject: Re: [PATCH 2/3] soundwire: qcom: add auto enumeration support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210226170250.9067-1-srinivas.kandagatla@linaro.org>
 <20210226170250.9067-3-srinivas.kandagatla@linaro.org>
 <0c551b23-7ed4-59d7-72c2-284bdf8584f1@linux.intel.com>
 <4721dd27-c8ce-f988-3c10-794841390656@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <01e5ea33-1813-069a-1674-042141947323@linux.intel.com>
Date:   Tue, 2 Mar 2021 08:34:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4721dd27-c8ce-f988-3c10-794841390656@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>> +        if (!val1 && !val2)
>>> +            break;
>>> +
>>> +        addr = buf2[1] | (buf2[0] << 8) | (buf1[3] << 16) |
>>> +            ((u64)buf1[2] << 24) | ((u64)buf1[1] << 32) |
>>> +            ((u64)buf1[0] << 40);
>>> +
>>> +        sdw_extract_slave_id(bus, addr, &id);
>>> +        /* Now compare with entries */
>>> +        list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
>>> +            if (sdw_compare_devid(slave, id) == 0) {
>>> +                u32 status = qcom_swrm_get_n_device_status(ctrl, i);
>>> +                if (status == SDW_SLAVE_ATTACHED) {
>>> +                    slave->dev_num = i;
>>> +                    mutex_lock(&bus->bus_lock);
>>> +                    set_bit(i, bus->assigned);
>>> +                    mutex_unlock(&bus->bus_lock);
>>> +
>>> +                }
>>
>> And that part is strange as well. The bus->assigned bit should be set 
>> even if the Slave is not in the list provided by platform firmware. 
>> It's really tracking the state of the hardware, and it should not be 
>> influenced by what software knows to manage.
> 
> Am not 100% sure If I understand the concern here, but In normal (non 
> auto enum) cases this bit is set by the bus code while its doing 
> enumeration to assign a dev number from the assigned bitmap!
> 
> However in this case where auto enumeration happens it makes sense to 
> set this here with matching dev number!
> 
> AFAIU from code, each bit in this bitmap corresponds to slave dev number!

Yes, but the point was "why do you compare with information coming from 
platform firmware"? if the hardware reports the presence of devices on 
the link, why not use the information as is?

You recently added code that helps us deal with devices that are not 
listed in DT or ACPI tables, so why would we filter in this specific loop?

>>> +    complete(&ctrl->enumeration);
>>
>> you have init_completion() and complete() in this patch, but no 
>> wait_for_completion(), so that should be added in a later patch, no?
> 
> make sense, will move that to other patch!

Actually on this one comment that I missed last time is that you are 
using a completion only for the resume() case, and I think it should 
also be used for the regular probe() case, no?

