Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B793347CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbhCXPcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:32:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:6267 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236605AbhCXPcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:32:00 -0400
IronPort-SDR: kNo4EsdNAWcf2VkGpWWzipDzoTc/e2+cGyXmZAYtZ3MUSsXEanjg/VUQqXAe+j44ZyJlMyoZX/
 eaIOAoVXa3YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="252087117"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="252087117"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 08:31:59 -0700
IronPort-SDR: KvDCAb661kRGCW3L7DcBK0x4sJ9Z947z1JgdkPE/knlly8SVix+WP2nrSKT0N8y1p1ErDT4s3i
 lw4TePEghKPA==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608143679"
Received: from mailunda-mobl.amr.corp.intel.com (HELO [10.209.33.48]) ([10.209.33.48])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 08:31:57 -0700
Subject: Re: [PATCH] soundwire: intel: move to auxiliary bus
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, vinod.koul@linaro.org,
        linux-kernel@vger.kernel.org, hui.wang@canonical.com,
        vkoul@kernel.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
 <YFmatyAoMZmBmkuZ@kroah.com>
 <777b4ca6-0d51-285d-549f-6ef768f2a523@linux.intel.com>
 <YFo0WW8hOsHesSFC@kroah.com>
 <35cc8d35-a778-d8b2-bee3-bb53f8a6c51e@linux.intel.com>
 <YFsG00+iDV/A4i3y@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <357d9576-f79a-0ea6-eee4-292e27597565@linux.intel.com>
Date:   Wed, 24 Mar 2021 09:55:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFsG00+iDV/A4i3y@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>>> Note that the auxiliary bus API has separate init and add steps, which
>>>>>> requires more attention in the error unwinding paths. The main loop
>>>>>> needs to deal with kfree() and auxiliary_device_uninit() for the
>>>>>> current iteration before jumping to the common label which releases
>>>>>> everything allocated in prior iterations.
>>>>>
>>>>> The init/add steps can be moved together in the aux bus code if that
>>>>> makes this usage simpler.  Please do that instead.
>>>>
>>>> IIRC the two steps were separated during the auxbus reviews to allow the
>>>> parent to call kfree() on an init failure, and auxiliary_device_uninit()
>>>> afterwards.
>>>>
>>>> https://www.kernel.org/doc/html/latest/driver-api/auxiliary_bus.html#auxiliary-device
>>>>
>>>> With a single auxbus_register(), the parent wouldn't know whether to use
>>>> kfree() or auxiliary_device_uinit() when an error is returned, would it?
>>>>
>>>
>>> It should, you know the difference when you call device_register() vs.
>>> device_initialize()/device_add(), for what to do, right?
>>>
>>> Should be no difference here either :)
>>
>> sorry, not following.
>>
>> with the regular devices, the errors can only happen on the second "add"
>> stage.
>>
>> int device_register(struct device *dev)
>> {
>> 	device_initialize(dev);
>> 	return device_add(dev);
>> }
>>
>> that's not what is currently implemented for the auxiliary bus
>>
>> the current flow is
>>
>> ldev = kzalloc(..)
>> some inits
>> ret = auxiliary_device_init(&ldev->auxdev)
>> if (ret < 0) {
>>      kfree(ldev);
>>      goto err1;
>> }
>>
>> ret = auxiliary_device_add(&ldev->auxdev)
>> if (ret < 0)
>>      auxiliary_device_uninit(&ldev->auxdev)
>>      goto err2;
>> }
>> ...
>> err2:
>> err1:
>>
>> How would I convert this to
>>
>> ldev = kzalloc(..)
>> some inits
>> ret = auxiliary_device_register()
>> if (ret) {
>>     kfree(ldev) or not?
>>     unit or not?
>> }
>>
>> IIRC during reviews there was an ask that the parent and name be checked,
>> and that's why the code added the two checks below:
>>
>> int auxiliary_device_init(struct auxiliary_device *auxdev)
>> {
>> 	struct device *dev = &auxdev->dev;
>>
>> 	if (!dev->parent) {
>> 		pr_err("auxiliary_device has a NULL dev->parent\n");
>> 		return -EINVAL;
>> 	}
>>
>> 	if (!auxdev->name) {
>> 		pr_err("auxiliary_device has a NULL name\n");
>> 		return -EINVAL;
>> 	}
>>
>> 	dev->bus = &auxiliary_bus_type;
>> 	device_initialize(&auxdev->dev);
>> 	return 0;
>> }
>>
>> does this clarify the sequence?
> 
> Yes, thanks, but I don't know the answer to your question, sorry.  This
> feels more complex than it should be, but I do not have the time at the
> moment to look into it, sorry.
> 
> Try getting the authors of this code to fix it up :)

We can try to check why those two tests were added before initialize(), 
I don't fully recall these details

If we could move these tests after device_initialize() then we could add 
a _register function.

Note at this point it would mean an API change and impact the existing 
Nvidia/Mellanox code, we are using the same sequence as them

https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/mellanox/mlx5/core/dev.c#L262

