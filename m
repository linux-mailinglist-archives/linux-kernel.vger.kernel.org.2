Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE28346662
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCWRad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:30:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:8979 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhCWR36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:29:58 -0400
IronPort-SDR: qCbYdCIbQWoYfRUdewXGxjtU9JJ4I/7qQRB6cg75JggIFmDwwO9d8Q77a2y7Y7QQ4nDCHgwDFc
 +dLrrFoSWymQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="169860625"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="169860625"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 10:29:51 -0700
IronPort-SDR: WRJgxqZXlzflkb8puAOEADTdOczI+anSWdWdPzjNlpSvtCeaTxVLKBpJ8VESbf4Pp4AtC8D5UO
 WSfCxPgUecPg==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="452236263"
Received: from laguitie-mobl.amr.corp.intel.com (HELO [10.252.129.185]) ([10.252.129.185])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 10:29:49 -0700
Subject: Re: [PATCH] soundwire: intel: move to auxiliary bus
To:     Greg KH <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
 <YFmPTkNkX6QPWiCa@vkoul-mobl.Dlink> <YFma1ClahDe2bZhR@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <aa9cfc49-913e-b3ba-1d92-2fab55bf4fa7@linux.intel.com>
Date:   Tue, 23 Mar 2021 12:29:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFma1ClahDe2bZhR@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Greg and Vinod for the reviews

>>> -static int intel_master_probe(struct platform_device *pdev)
>>> +static int intel_link_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
>>>   {
>>> -	struct device *dev = &pdev->dev;
>>> +	struct device *dev = &auxdev->dev;
>>> +	struct sdw_intel_link_dev *ldev = auxiliary_dev_to_sdw_intel_link_dev(auxdev);
>>
>> Do we need another abstractions for resources here, why not aux dev
>> creation set the resources required and we skip this step...

Not sure what resources you are referring to?

this is just a container_of() and the documented way of extending the 
auxbus (see 
https://www.kernel.org/doc/html/latest/driver-api/auxiliary_bus.html#example-usage)


struct sdw_intel_link_dev {
	struct auxiliary_device auxdev;
	struct sdw_intel_link_res link_res;
};

#define auxiliary_dev_to_sdw_intel_link_dev(auxiliary_dev) \
	container_of(auxiliary_dev, struct sdw_intel_link_dev, auxdev)

>>>   	struct sdw_intel *sdw;
>>>   	struct sdw_cdns *cdns;
>>>   	struct sdw_bus *bus;
>>> @@ -1346,14 +1347,14 @@ static int intel_master_probe(struct platform_device *pdev)
>>>   	cdns = &sdw->cdns;
>>>   	bus = &cdns->bus;
>>>   
>>> -	sdw->instance = pdev->id;
>>> -	sdw->link_res = dev_get_platdata(dev);
>>> +	sdw->instance = auxdev->id;
>>
>> so auxdev has id and still we pass id as argument :( Not sure if folks
>> can fix this now
> 
> That's odd, yeah, it should be fixed.

I think we are talking about different things?

this is defined in mod_devicetable.h:

struct auxiliary_device_id {
	char name[AUXILIARY_NAME_SIZE];
	kernel_ulong_t driver_data;
};

and used for the driver probe:

	ret = auxdrv->probe(auxdev, auxiliary_match_id(auxdrv->id_table, auxdev));

but there is a separate id:

struct auxiliary_device {
	struct device dev;
	const char *name;
	u32 id;
};

which is set during the device initialization in intel_init.c

	/* we don't use an IDA since we already have a link ID */
	auxdev->id = link_id;

In the auxiliary bus design, the parent has to take care of managing 
this id, be it with an IDA or as we do here with a physical link ID that 
is unique.

in short, I don't see how I could change the code given the differences 
in concepts?

