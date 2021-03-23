Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4EC3468B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhCWTO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:14:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:48530 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhCWTOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:14:23 -0400
IronPort-SDR: cQjUnhOMCCXuXx12BL1Uy8CehyLQBdlIVEfChUJfbUMSraHRwGCM3X6xmXYqSBZKJ5oNISFhv8
 mRoUtSHGw/6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="177671199"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="177671199"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 12:14:21 -0700
IronPort-SDR: LrlxJMmlWHeXpmw4l3JwHxWZYy2E6m+cwtx6PxY3N63PBQoecCG22sZ8zTZW0otLKrYbc7VVWu
 YtY0ZYP+JNAg==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="452277659"
Received: from laguitie-mobl.amr.corp.intel.com (HELO [10.252.129.185]) ([10.252.129.185])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 12:14:20 -0700
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <35cc8d35-a778-d8b2-bee3-bb53f8a6c51e@linux.intel.com>
Date:   Tue, 23 Mar 2021 14:14:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFo0WW8hOsHesSFC@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/21 1:32 PM, Greg KH wrote:
> On Tue, Mar 23, 2021 at 01:04:49PM -0500, Pierre-Louis Bossart wrote:
>>
>>>> Note that the auxiliary bus API has separate init and add steps, which
>>>> requires more attention in the error unwinding paths. The main loop
>>>> needs to deal with kfree() and auxiliary_device_uninit() for the
>>>> current iteration before jumping to the common label which releases
>>>> everything allocated in prior iterations.
>>>
>>> The init/add steps can be moved together in the aux bus code if that
>>> makes this usage simpler.  Please do that instead.
>>
>> IIRC the two steps were separated during the auxbus reviews to allow the
>> parent to call kfree() on an init failure, and auxiliary_device_uninit()
>> afterwards.
>>
>> https://www.kernel.org/doc/html/latest/driver-api/auxiliary_bus.html#auxiliary-device
>>
>> With a single auxbus_register(), the parent wouldn't know whether to use
>> kfree() or auxiliary_device_uinit() when an error is returned, would it?
>>
> 
> It should, you know the difference when you call device_register() vs.
> device_initialize()/device_add(), for what to do, right?
> 
> Should be no difference here either :)

sorry, not following.

with the regular devices, the errors can only happen on the second "add" 
stage.

int device_register(struct device *dev)
{
	device_initialize(dev);
	return device_add(dev);
}

that's not what is currently implemented for the auxiliary bus

the current flow is

ldev = kzalloc(..)
some inits
ret = auxiliary_device_init(&ldev->auxdev)
if (ret < 0) {
     kfree(ldev);
     goto err1;
}

ret = auxiliary_device_add(&ldev->auxdev)
if (ret < 0)
     auxiliary_device_uninit(&ldev->auxdev)
     goto err2;
}
...
err2:
err1:

How would I convert this to

ldev = kzalloc(..)
some inits
ret = auxiliary_device_register()
if (ret) {
    kfree(ldev) or not?
    unit or not?
}

IIRC during reviews there was an ask that the parent and name be 
checked, and that's why the code added the two checks below:

int auxiliary_device_init(struct auxiliary_device *auxdev)
{
	struct device *dev = &auxdev->dev;

	if (!dev->parent) {
		pr_err("auxiliary_device has a NULL dev->parent\n");
		return -EINVAL;
	}

	if (!auxdev->name) {
		pr_err("auxiliary_device has a NULL name\n");
		return -EINVAL;
	}

	dev->bus = &auxiliary_bus_type;
	device_initialize(&auxdev->dev);
	return 0;
}

does this clarify the sequence?







