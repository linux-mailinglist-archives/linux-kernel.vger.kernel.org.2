Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF70841999E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhI0Qup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:50:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:47020 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235645AbhI0Qun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:50:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="222622266"
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; 
   d="scan'208";a="222622266"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 09:49:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; 
   d="scan'208";a="486204709"
Received: from asen4-mobl2.amr.corp.intel.com (HELO [10.212.27.2]) ([10.212.27.2])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 09:49:00 -0700
Subject: Re: [EXTERNAL] Re: [PATCH] ASoC: max98373: Mark cache dirty before
 entering sleep
To:     Mark Brown <broonie@kernel.org>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "guennadi.liakhovetski@linux.intel.com" 
        <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathya.prakash.m.r@intel.com" <sathya.prakash.m.r@intel.com>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
References: <20210924221305.17886-1-ryans.lee@maximintegrated.com>
 <1b21bbf1-12c7-726d-bff8-76ec88ff8635@linux.intel.com>
 <SJ0PR11MB566107A6AB3D18ABDEDCF245E7A79@SJ0PR11MB5661.namprd11.prod.outlook.com>
 <20210927160622.GE4199@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7b8c3875-3f12-f3cb-7da8-4e850e59ee2b@linux.intel.com>
Date:   Mon, 27 Sep 2021 11:48:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927160622.GE4199@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/21 11:06 AM, Mark Brown wrote:
> On Mon, Sep 27, 2021 at 04:01:25PM +0000, Ryan Lee wrote:
> 
>>>>       regcache_cache_only(max98373->regmap, true);
>>>> +     regcache_mark_dirty(max98373->regmap);
> 
>>> We already do the following sequence in max98373_io_init() when the
>>> amplifier re-attaches:
> 
>>>         if (max98373->first_hw_init) {
>>>                 regcache_cache_bypass(max98373->regmap, false);
>>>                 regcache_mark_dirty(max98373->regmap);
>>>         }
> 
>>> I don't see what marking the cache as dirty on suspend might do, we will do a
>>> sync only in the resume step.
> 
>>> IIRC this is a patch that we've seen before and removed since it wasn't
>>> aligned with any other codec driver.
> 
>> Yes, it does. There was an mute problem report due to amp register reset
>> during suspend/resume. and we confirmed that the modification 
>> is effective. (https://partnerissuetracker.corp.google.com/issues/194472331)
>> The added code helps to re-write valid values in cache to the amp hardware
>> when audio resume. Same code was there on i2c driver, but not on Soundwire
>> driver.

Ryan, we removed this in f184892613dd ('ASoC: codecs: max98373-sdw:
align regmap use with other codecs'), so even if this was needed you'd
need a mention that this is a revert and why this sequence is better.
You are suggesting a change based on an analogy with I2C which is
questionable: when a SoundWire device regains sync on the bus, it will
be re-initialized using a callback, and the resume waits for the
initialization to complete.

> More specifically what it does is make the invalidation of the register
> cache unconditional.  It doesn't really matter if the invalidation is
> done on suspend or resume, so long as it happens before we attempt to
> resync - this could also be done by deleting the first_hw_init check.

Mark, that's exactly my point: if the amp rejoins the bus, we will
*always* mark the cache as dirty, before the resync is done in the
resume sequence.

I am really trying to figure out if we have a major flaw in the resume
sequence and why things are different in the case of the Maxim amp.

Instead of changing the suspend sequence, can we please try to modify
the max98373_io_init() routine to unconditionally flag the cache as
dirty, maybe this points to a problem with the management of the
max98373->first_hw_init flag.
