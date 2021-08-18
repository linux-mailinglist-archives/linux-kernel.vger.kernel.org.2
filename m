Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7AE3F071D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbhHROwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:52:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:1553 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239503AbhHROwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:52:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="196596161"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="196596161"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 07:51:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="449785281"
Received: from ksawchu-mobl.amr.corp.intel.com (HELO [10.212.83.236]) ([10.212.83.236])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 07:51:53 -0700
Subject: Re: [RFC PATCH 1/2] driver core: export
 driver_deferred_probe_trigger()
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        vkoul@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com> <20210818115736.GA4177@sirena.org.uk>
 <YR0Ji7DQXoo0z4vP@kroah.com> <20210818134814.GF4177@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
Date:   Wed, 18 Aug 2021 09:51:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818134814.GF4177@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>> The issue is that the driver core is using drivers completing probe as a
>>> proxy for resources becoming available.  That works most of the time
>>> because most probes are fully synchronous but it breaks down if a
>>> resource provider registers resources outside of probe, we might still
>>> be fine if system boot is still happening and something else probes but
>>> only through luck.
> 
>> The driver core is not using that as a proxy, that is up to the driver
>> itself or not.  All probe means is "yes, this driver binds to this
>> device, thank you!" for that specific bus/class type.  That's all, if
>> the driver needs to go off and do real work before it can properly
>> control the device, wonderful, have it go and do that async.
> 
> Right, which is what is happening here - but the deferred probe
> machinery in the core is reading more into the probe succeeding than it
> should.

I think Greg was referring to the use of the PROBE_PREFER_ASYNCHRONOUS
probe type. We tried just that and got a nice WARN_ON because we are
using request_module() to deal with HDaudio codecs. The details are in
[1] but the kernel code is unambiguous...

        /*
	 * We don't allow synchronous module loading from async.  Module
	 * init may invoke async_synchronize_full() which will end up
	 * waiting for this task which already is waiting for the module
	 * loading to complete, leading to a deadlock.
	 */
	WARN_ON_ONCE(wait && current_is_async());


The reason why we use a workqueue is because we are otherwise painted in
a corner by conflicting requirements.

a) we have to use request_module()
b) we cannot use the async probe because of the request_module()
c) we have to avoid blocking on boot

I understand the resistance to exporting this function, no one in our
team was really happy about it, but no one could find an alternate
solution. If there is something better, I am all ears.

Thanks
-Pierre

[1] https://github.com/thesofproject/linux/pull/3079
