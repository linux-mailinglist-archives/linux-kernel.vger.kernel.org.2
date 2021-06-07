Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDF139E8B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhFGUvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:51:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:59204 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhFGUvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:51:09 -0400
IronPort-SDR: cT4B0MMYdB/TLmFZw/UFx3ts5963gGBQxbentGRfITEneCBL5htyA2QWTXqaagFrmJ2bZzucan
 HKfFLbiN8Zhw==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="201688961"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="201688961"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 13:49:16 -0700
IronPort-SDR: UsKfiU/1QAnHdi+YVwq3nCcSR3l3GUOwA62aXB7mfPS3hJkqEt0uOBxN6F49wOEyL1vupLWw8U
 yCnLCyVEoQZA==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="401804394"
Received: from mbragatx-mobl.amr.corp.intel.com (HELO [10.212.46.134]) ([10.212.46.134])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 13:49:12 -0700
Subject: Re: [PATCH 1/4] ASoC: Intel: sof_cs42l42: support JSL DAI link
 sequence
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "M, Naveen" <naveen.m@intel.com>, "Zhi, Yong" <yong.zhi@intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>
References: <20210606004102.26190-1-brent.lu@intel.com>
 <20210606004102.26190-2-brent.lu@intel.com>
 <2ccdffb1-e905-420e-5144-ebb8356b5518@linux.intel.com>
 <DM6PR11MB36429F4E8A6F077F8D2374F997389@DM6PR11MB3642.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a3b5d6be-17eb-088f-197c-8a0b30c2f32d@linux.intel.com>
Date:   Mon, 7 Jun 2021 15:49:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB36429F4E8A6F077F8D2374F997389@DM6PR11MB3642.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Cs42l42 is sharing topology with DA7219's topology source file sof-glk-da7219.m4
> on GLK platform. The configuration is:
> 
> dai link id 0 is for spk
> #SSP 1 (ID: 0) with 19.2 MHz mclk with MCLK_ID 1 (unused), 1.536 MHz blck
> DAI_CONFIG(SSP, 1, 0, SSP1-Codec,
> 
> dai link id 1 is for headphone
> #SSP 2 (ID: 1) with 19.2 MHz mclk with MCLK_ID 1, 1.92 MHz bclk
> DAI_CONFIG(SSP, 2, 1, SSP2-Codec,
> 
> dai link id 2 is for dmic
> DAI_CONFIG(DMIC, 0, 2, dmic01,
> 
> dai link id 3/4/5 is for hdmi
> DAI_CONFIG(HDA, 3, 3, iDisp1,
> DAI_CONFIG(HDA, 4, 4, iDisp2,
> DAI_CONFIG(HDA, 5, 5, iDisp3,
> 
> When on JSL, we plan to share topology with rt5682 which has different dai link
> sequence:
> sof-jsl-rt5682.m4:
> 
> dai link id 0 is for headphone
> DAI_CONFIG(SSP, 0, 0, SSP0-Codec,
> 
> dai link id 6 is for spk
> # SSP 1 (ID: 6)
> DAI_CONFIG(SSP, SPK_INDEX, 6, SPK_NAME,
> 	SET_SSP_CONFIG)
> 
> dai link id 3/4/5 is for hdmi
> # 4 HDMI/DP outputs (ID: 3,4,5)
> DAI_CONFIG(HDA, 0, 3, iDisp1,
> DAI_CONFIG(HDA, 1, 4, iDisp2,
> DAI_CONFIG(HDA, 2, 5, iDisp3,
> 
> I'm not sure if there is convention about the sequence to follow?

ok, now I get what you are trying to do.

Unfortunately there are no conventions so far, and since we have to be 
backwards-compatible with topology files already released we will need 
to deal with the different configurations in this machine driver, you're 
right about this.

The code you suggested is fine, but we can future-proof it a bit.

Instead of assuming any order depending on GLK or !GLK, we can add a BE 
'base' for headphone, amp, DMIC and DMIC each (represented as a constant 
structure) and point to different configurations depending on a quirk. 
That way we can deal with other permutations such as HP - SPK - HDMI - DMIC


