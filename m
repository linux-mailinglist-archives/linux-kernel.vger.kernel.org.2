Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD14D419F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 21:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhI0Tfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 15:35:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:50871 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhI0Tfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 15:35:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="224617615"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="224617615"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 12:34:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="486263448"
Received: from asen4-mobl2.amr.corp.intel.com (HELO [10.212.27.2]) ([10.212.27.2])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 12:34:11 -0700
Subject: Re: [EXTERNAL] Re: [PATCH] ASoC: max98373: Mark cache dirty before
 entering sleep
To:     Ryan Lee <RyanS.Lee@maximintegrated.com>,
        Mark Brown <broonie@kernel.org>
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
 <7b8c3875-3f12-f3cb-7da8-4e850e59ee2b@linux.intel.com>
 <SJ0PR11MB5661814BCC6B79EDE1B0967AE7A79@SJ0PR11MB5661.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c5031731-dd58-ff7a-857e-b9e1b748d3b2@linux.intel.com>
Date:   Mon, 27 Sep 2021 14:34:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <SJ0PR11MB5661814BCC6B79EDE1B0967AE7A79@SJ0PR11MB5661.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Instead of changing the suspend sequence, can we please try to modify the
>> max98373_io_init() routine to unconditionally flag the cache as dirty, maybe
>> this points to a problem with the management of the
>> max98373->first_hw_init flag.
> 
> max98373_io_init() is not called because ' sdw_slave_status' remains
> ' SDW_SLAVE_ATTACHED' and 'max98373->hw_init' is already true.
> Removing 'if (max98373->hw_init || status != SDW_SLAVE_ATTACHED)'
> condition in max98373_update_status() function instead of adding
> regcache_mark_dirty() into max98373_suspend() can be an alternative way.
> I think it is all about where regcache_mark_dirty() is called from.
> The difference is that max98373_io_init() really do the software reset and
> do amp initialization again which could be an overhead.

that description is aligned with my analysis that there's something very
wrong happening here, it's not just a simple miss in the regmap handling
but a major conceptual bug or misunderstanding in the way reset is handled.

First, there's the spec: on a reset initiated by the host or if the
device loses sync for ANY reason, its status cannot remain ATTACHED.
There's got to be a 16-frame period at least where the device has to
monitor the sync pattern and cannot drive anything on the bus.

Then there's the hardware behavior on resume: on resume by default the
Intel host will toggle the data pin for at least 4096 frames, which by
spec means severe reset.

And last, there's the software init: we also force the status as
UNATTACHED in drivers/soundwire/intel.c:

	/*
	 * make sure all Slaves are tagged as UNATTACHED and provide
	 * reason for reinitialization
	 */
	sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);

But we've also seen the opposite effect of an amplifier reporting
attached but losing sync immediately after the end of enumeration and
never coming back on the bus, see issue
https://github.com/thesofproject/linux/issues/3063

In other words, we need to check what really happens on resume and why
the amplifier keeps reporting its status as ATTACHED despite the spec
requirements and software init, or loses this status after
enumeration....Something really does not add-up, again it's not just a
regmap management issue.




