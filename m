Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8C419CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbhI0Rgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:36:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:15583 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238857AbhI0ReO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:34:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="211609107"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="211609107"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 10:23:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="486218694"
Received: from asen4-mobl2.amr.corp.intel.com (HELO [10.212.27.2]) ([10.212.27.2])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 10:23:08 -0700
Subject: Re: [EXTERNAL] Re: [PATCH] ASoC: max98373: Mark cache dirty before
 entering sleep
To:     Mark Brown <broonie@kernel.org>
Cc:     "guennadi.liakhovetski@linux.intel.com" 
        <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "sathya.prakash.m.r@intel.com" <sathya.prakash.m.r@intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>
References: <20210924221305.17886-1-ryans.lee@maximintegrated.com>
 <1b21bbf1-12c7-726d-bff8-76ec88ff8635@linux.intel.com>
 <SJ0PR11MB566107A6AB3D18ABDEDCF245E7A79@SJ0PR11MB5661.namprd11.prod.outlook.com>
 <20210927160622.GE4199@sirena.org.uk>
 <7b8c3875-3f12-f3cb-7da8-4e850e59ee2b@linux.intel.com>
 <20210927171033.GF4199@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0af258d4-e33c-15ec-5dcc-a1c9961c0740@linux.intel.com>
Date:   Mon, 27 Sep 2021 12:23:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927171033.GF4199@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/21 12:10 PM, Mark Brown wrote:
> On Mon, Sep 27, 2021 at 11:48:56AM -0500, Pierre-Louis Bossart wrote:
>> On 9/27/21 11:06 AM, Mark Brown wrote:
> 
>>> More specifically what it does is make the invalidation of the register
>>> cache unconditional.  It doesn't really matter if the invalidation is
>>> done on suspend or resume, so long as it happens before we attempt to
>>> resync - this could also be done by deleting the first_hw_init check.
> 
>> Mark, that's exactly my point: if the amp rejoins the bus, we will
>> *always* mark the cache as dirty, before the resync is done in the
>> resume sequence.
> 
> Ah, yes - I see.
> 
>> I am really trying to figure out if we have a major flaw in the resume
>> sequence and why things are different in the case of the Maxim amp.
> 
>> Instead of changing the suspend sequence, can we please try to modify
>> the max98373_io_init() routine to unconditionally flag the cache as
>> dirty, maybe this points to a problem with the management of the
>> max98373->first_hw_init flag.
> 
> A quick survey of other drivers suggests that this pattern should be
> factored out into some helpers as it looks like there's several ways of
> implementing it that look very similar but not quite the same...

No disagreement here, we tried really hard to enforce a common pattern
for suspend-resume, but i just noticed that the maxim amp driver is
different on suspend (resume is consistent with the rest).


static int __maybe_unused rt711_dev_suspend(struct device *dev)
{
	struct rt711_priv *rt711 = dev_get_drvdata(dev);

	if (!rt711->hw_init)
		return 0;

	cancel_delayed_work_sync(&rt711->jack_detect_work);
	cancel_delayed_work_sync(&rt711->jack_btn_check_work);
	cancel_work_sync(&rt711->calibration_work);

	regcache_cache_only(rt711->regmap, true);

	return 0;
}

static int __maybe_unused rt1308_dev_suspend(struct device *dev)
{
	struct rt1308_sdw_priv *rt1308 = dev_get_drvdata(dev);

	if (!rt1308->hw_init)
		return 0;

	regcache_cache_only(rt1308->regmap, true);

	return 0;
}

static __maybe_unused int max98373_suspend(struct device *dev)
{
	struct max98373_priv *max98373 = dev_get_drvdata(dev);
	int i;

<<<< missing test

	/* cache feedback register values before suspend */
	for (i = 0; i < max98373->cache_num; i++)
		regmap_read(max98373->regmap, max98373->cache[i].reg,
&max98373->cache[i].val);

<<<< why is this needed???

	regcache_cache_only(max98373->regmap, true);

	return 0;
}



