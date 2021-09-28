Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2D41B5C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 20:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbhI1SRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:17:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:9111 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241547AbhI1SRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:17:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="224843734"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="224843734"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 11:15:35 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="438174376"
Received: from ppahwa-mobl1.amr.corp.intel.com (HELO [10.212.48.236]) ([10.212.48.236])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 11:15:34 -0700
Subject: Re: [EXTERNAL] Re: [PATCH] ASoC: max98373: Mark cache dirty before
 entering sleep
To:     Ryan Lee <RyanS.Lee@maximintegrated.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "guennadi.liakhovetski@linux.intel.com" 
        <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathya.prakash.m.r@intel.com" <sathya.prakash.m.r@intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>
References: <20210924221305.17886-1-ryans.lee@maximintegrated.com>
 <1b21bbf1-12c7-726d-bff8-76ec88ff8635@linux.intel.com>
 <SJ0PR11MB566107A6AB3D18ABDEDCF245E7A79@SJ0PR11MB5661.namprd11.prod.outlook.com>
 <20210927160622.GE4199@sirena.org.uk>
 <7b8c3875-3f12-f3cb-7da8-4e850e59ee2b@linux.intel.com>
 <20210927171033.GF4199@sirena.org.uk>
 <0af258d4-e33c-15ec-5dcc-a1c9961c0740@linux.intel.com>
 <SJ0PR11MB56618B8B6DE3922613E83C15E7A89@SJ0PR11MB5661.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a8d2f176-df63-f81b-e47a-73b1c436b612@linux.intel.com>
Date:   Tue, 28 Sep 2021 13:15:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <SJ0PR11MB56618B8B6DE3922613E83C15E7A89@SJ0PR11MB5661.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>>>> Instead of changing the suspend sequence, can we please try to modify
>>>> the max98373_io_init() routine to unconditionally flag the cache as
>>>> dirty, maybe this points to a problem with the management of the
>>>> max98373->first_hw_init flag.
>>>
>>> A quick survey of other drivers suggests that this pattern should be
>>> factored out into some helpers as it looks like there's several ways
>>> of implementing it that look very similar but not quite the same...
>>
>> No disagreement here, we tried really hard to enforce a common pattern for
>> suspend-resume, but i just noticed that the maxim amp driver is different on
>> suspend (resume is consistent with the rest).
> 
> OK. I believe it was similar before. But it looks like 'regcache_mark_dirty' is being
> disappeared on suspend function.

Not sure what you are trying to say?

> static int __maybe_unused rt5682_dev_suspend(struct device *dev)
> {
> 	struct rt5682_priv *rt5682 = dev_get_drvdata(dev);
> 
> 	if (!rt5682->hw_init)
> 		return 0;
> 
> 	cancel_delayed_work_sync(&rt5682->jack_detect_work);
> 
> 	regcache_cache_only(rt5682->regmap, true);
> 	regcache_mark_dirty(rt5682->regmap);
> 
> 	return 0;
> }

That last line is also not needed. If you look at rt5682-sdw.c, you'll
see a regcache_mark_dirty() when the device is re-initialized.

But now I am starting to wonder if this is due to Chrome kernel
differences and possibly a missing backport patch? I no longer believe
in coincidences, these two devices are ONLY used in Chromebooks so far...
