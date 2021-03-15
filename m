Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C2833BFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhCOPbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:31:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:10830 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhCOPa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:30:57 -0400
IronPort-SDR: N6o0m2sOJzghXxPsRwFNezTGI95aNzVY9p2EIthpa6TDsSd2KQXjN/ZQGg9MT4uOgZKM2U6zBJ
 OeZOVAUOcx/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="186727487"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="186727487"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 08:30:57 -0700
IronPort-SDR: ksQMXxgBd1/KPGFHSWoFnZ+Jw1Vfoft0O4FYpHstsLrpcB1q0foW7/ElsiFD2O2rxyC8nKnRON
 yQQaQ+Y46+tg==
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="449399290"
Received: from gbean-mobl.amr.corp.intel.com (HELO [10.212.247.133]) ([10.212.247.133])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 08:30:55 -0700
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: Add rt1015p speaker amp support
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Libin Yang <libin.yang@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>
References: <20210313134038.5577-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7ec5763b-29cb-4846-6ff8-3899c2ff1248@linux.intel.com>
Date:   Mon, 15 Mar 2021 09:26:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210313134038.5577-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am not a big fan of the code partition you've selected.

> +void sof_rt1015p_set_share_en_spk(void)
> +{
> +	/* Two amps share one en pin so there is only one device in acpi
> +	 * table
> +	 */
> +	rt1015p_quirk |= RT1015P_SHARE_EN_SPK;
> +}

This is a function now used in the machine driver, see below [1]
This adds a new interface between machine and realtek common code, which 
we are trying to move to a module with well-defined APIs.

> +void sof_rt1015p_dai_link(struct snd_soc_dai_link *link)
> +{
> +	link->codecs = rt1015p_dai_link_components;
> +	if (rt1015p_quirk & RT1015P_SHARE_EN_SPK)
> +		link->num_codecs = 1;
> +	else
> +		link->num_codecs = ARRAY_SIZE(rt1015p_dai_link_components);
> +	link->init = rt1015p_init;
> +	link->ops = &rt1015p_ops;
> +}
> +
> +void sof_rt1015p_codec_conf(struct snd_soc_card *card)
> +{
> +	if (rt1015p_quirk & RT1015P_SHARE_EN_SPK)
> +		return;
> +
> +	card->codec_conf = rt1015p_codec_confs;
> +	card->num_configs = ARRAY_SIZE(rt1015p_codec_confs);
> +}

could we not handle this quirk inside one of the two dai_link or 
codec_conf functions above?
The machine driver does not care about this RT1015P_SHARE_EN_SPK quirk, 
it's only used in those two functions so should be set in this scope. 
There's no need to make it visible to the machine driver, is there?

> +	/* setup amp quirk if any */
> +	if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT) {
> +		/* There may be only one device instance if two amps
> +		 * sharing one en pin
> +		 */
> +		if (!acpi_dev_present("RTL1015", "1", -1)) {
> +			dev_dbg(&pdev->dev, "Device %s not exist\n",
> +				RT1015P_DEV1_NAME);
> +			sof_rt1015p_set_share_en_spk();
> +		}
> +	}
> +

[1]

I see no problem using the _UID (Unique ID) to check if a second 
amplifier is present or not. This seems to follow the ACPI spec Section 
6.1.12, as long as "the _UID must be unique across all devices with 
either a common _HID or _CID"


> +	else if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT)
> +		sof_rt1015p_codec_conf(&sof_audio_card_rt5682);
