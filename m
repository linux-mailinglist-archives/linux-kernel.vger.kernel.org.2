Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533543F0801
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhHRP2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:28:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:58543 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhHRP2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:28:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="216076477"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="216076477"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 08:25:28 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="449796910"
Received: from ksawchu-mobl.amr.corp.intel.com (HELO [10.212.83.236]) ([10.212.83.236])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 08:25:26 -0700
Subject: Re: [RFC PATCH 2/2] ASoC: SOF: trigger re-probing of deferred devices
 from workqueue
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, tiwai@suse.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        liam.r.girdwood@linux.intel.com, vkoul@kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Christoph Hellwig <hch@lst.de>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-3-pierre-louis.bossart@linux.intel.com>
 <20210818120700.GB4177@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3985f754-a0a2-92f7-1585-3b177c172664@linux.intel.com>
Date:   Wed, 18 Aug 2021 10:25:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818120700.GB4177@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/21 7:07 AM, Mark Brown wrote:
> On Tue, Aug 17, 2021 at 02:00:57PM -0500, Pierre-Louis Bossart wrote:
> 
>> +++ b/sound/soc/sof/core.c
>> @@ -251,6 +251,9 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
>>  
>>  	sdev->probe_completed = true;
>>  
>> +	/* kick-off re-probing of deferred devices */
>> +	driver_deferred_probe_trigger();
>> +
> 
> I think we should move this into snd_soc_register_component() - the same
> issue could occur with any other component, the only other thing I can
> see kicking in here is the machine driver registration but that ought to
> kick probe itself anyway.  Or is there some other case here?

Thanks for the suggestion Mark, it would be more consistent indeed to
kick a re-evaluation of the deferred probe list when ASoC components are
successfully registered with something like this:

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c830e96afba2..9d6feea7719c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2677,7 +2677,14 @@ int snd_soc_register_component(struct device *dev,
        if (ret < 0)
                return ret;

-       return snd_soc_add_component(component, dai_drv, num_dai);
+       ret = snd_soc_add_component(component, dai_drv, num_dai);
+       if (ret < 0)
+               return ret;
+
+       /* kick-off re-probing of deferred devices */
+       driver_deferred_probe_trigger();
+
+       return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_component);

In the case of this SOF driver, it'd be completely equivalent to what
this patch suggested, the snd_soc_register_component() is what we do
last in the workqueue.

In the case of 'regular' drivers, the component registration is
typically done last as well before the end of the probe. This would
result in 2 evaluations (one on successful ASoC component registration
and one on successful probe), and maybe on the second evaluation there's
nothing to do.

I can't think of any negative side-effects.
