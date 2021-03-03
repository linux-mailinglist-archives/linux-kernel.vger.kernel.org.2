Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3520D32C3EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354467AbhCDAJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:09:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:62816 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1390634AbhCCWKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:10:20 -0500
IronPort-SDR: HAPFkFcY+7Ytx537Xqqyf5T++B7kdRQ+I+WYTpZmQZxksr4/hNUGBBPymg1AleLRd0J+1uw6oh
 mthdFKTXISMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="174925429"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="174925429"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 13:59:16 -0800
IronPort-SDR: 6dZauLo0rkIiwJ4EHv9A3wROd4/CtGYrMteQot/EYZlf/lmoBAzjGek5ybEj9M1pnTsQqx/R1z
 pNW2c6n6IvoA==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="586487028"
Received: from srcook1-mobl1.amr.corp.intel.com (HELO [10.209.143.11]) ([10.209.143.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 13:59:15 -0800
Subject: Re: [PATCH 2/3] soundwire: qcom: add auto enumeration support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210226170250.9067-1-srinivas.kandagatla@linaro.org>
 <20210226170250.9067-3-srinivas.kandagatla@linaro.org>
 <0c551b23-7ed4-59d7-72c2-284bdf8584f1@linux.intel.com>
 <4721dd27-c8ce-f988-3c10-794841390656@linaro.org>
 <01e5ea33-1813-069a-1674-042141947323@linux.intel.com>
 <601b585e-c3e3-4006-b078-d54c3fd36438@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c5fe182d-1769-73ed-0268-5353fd030521@linux.intel.com>
Date:   Wed, 3 Mar 2021 10:35:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <601b585e-c3e3-4006-b078-d54c3fd36438@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/21 3:38 AM, Srinivas Kandagatla wrote:
> 
> 
> On 02/03/2021 14:34, Pierre-Louis Bossart wrote:
>>
>>
>>>>> +        if (!val1 && !val2)
>>>>> +            break;
>>>>> +
>>>>> +        addr = buf2[1] | (buf2[0] << 8) | (buf1[3] << 16) |
>>>>> +            ((u64)buf1[2] << 24) | ((u64)buf1[1] << 32) |
>>>>> +            ((u64)buf1[0] << 40);
>>>>> +
>>>>> +        sdw_extract_slave_id(bus, addr, &id);
>>>>> +        /* Now compare with entries */
>>>>> +        list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
>>>>> +            if (sdw_compare_devid(slave, id) == 0) {
>>>>> +                u32 status = qcom_swrm_get_n_device_status(ctrl, i);
>>>>> +                if (status == SDW_SLAVE_ATTACHED) {
>>>>> +                    slave->dev_num = i;
>>>>> +                    mutex_lock(&bus->bus_lock);
>>>>> +                    set_bit(i, bus->assigned);
>>>>> +                    mutex_unlock(&bus->bus_lock);
>>>>> +
>>>>> +                }
>>>>
>>>> And that part is strange as well. The bus->assigned bit should be 
>>>> set even if the Slave is not in the list provided by platform 
>>>> firmware. It's really tracking the state of the hardware, and it 
>>>> should not be influenced by what software knows to manage.
>>>
>>> Am not 100% sure If I understand the concern here, but In normal (non 
>>> auto enum) cases this bit is set by the bus code while its doing 
>>> enumeration to assign a dev number from the assigned bitmap!
>>>
>>> However in this case where auto enumeration happens it makes sense to 
>>> set this here with matching dev number!
>>>
>>> AFAIU from code, each bit in this bitmap corresponds to slave dev 
>>> number!
>>
>> Yes, but the point was "why do you compare with information coming 
>> from platform firmware"? if the hardware reports the presence of 
>> devices on 
> 
> This is the logic that hardware IP document suggests to use to get get 
> the correct the device number associated with the slave!
> 
> 
>> the link, why not use the information as is?
>>
>> You recently added code that helps us deal with devices that are not 
>> listed in DT or ACPI tables, so why would we filter in this specific 
>> loop?

I don't think my point was understood, so let me try to explain it 
differently.

it's my understanding that the hardware reads the DevID registers and 
writes a Device Number - so that the entire enumeration sequence started 
by reading DevID0 and finished by a successful write to SCP_DevNum is 
handled in hardware.

The question is: what happens if that device is NOT described in the 
Device Tree data? The loop over bus->slaves will not find this device by 
comparing with known devID values, so the set_bit(i, bus->assigned) will 
not happen.


