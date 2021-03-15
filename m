Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DAD33C0F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhCOQB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:01:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:37432 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhCOQBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:01:04 -0400
IronPort-SDR: u9gPrp9t/nv6+kxkvW3yqZ2GOeEErAOX1vNHQcSA9yDW5OdiMuW9Nr/ZhehcH0neBy0urUxxhD
 zaCncdlSWjOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="176706421"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="176706421"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 09:01:02 -0700
IronPort-SDR: m9ETXf/nEQZHp8nYkD9kuWRV0/8Z8hI++ehov3DbAvfsv3E+44H7W9hzDC/gyNM34GWsbdiuZE
 U9Mqbij/d5XQ==
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="432704589"
Received: from kdaxer-mobl1.amr.corp.intel.com (HELO [10.212.25.124]) ([10.212.25.124])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 09:00:58 -0700
Subject: Re: [PATCH v3] ASoC: amd: add support for rt5682 codec in machine
 driver
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Alexander.Deucher@amd.com, Murali-krishna.Vemuri@amd.com,
        Virendra-Pratap.Arya@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1615824133-21553-1-git-send-email-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <efa02319-2abf-4fb9-efec-13b6279f3d78@linux.intel.com>
Date:   Mon, 15 Mar 2021 11:00:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1615824133-21553-1-git-send-email-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int rt5682_clk_enable(struct snd_pcm_substream *substream)
> +{
> +	int ret;
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +
> +	/*
> +	 * Set wclk to 48000 because the rate constraint of this driver is
> +	 * 48000. ADAU7002 spec: "The ADAU7002 requires a BCLK rate that is
> +	 * minimum of 64x the LRCLK sample rate." RT5682 is the only clk
> +	 * source so for all codecs we have to limit bclk to 64X lrclk.
> +	 */
> +	clk_set_rate(rt5682_dai_wclk, 48000);
> +	clk_set_rate(rt5682_dai_bclk, 48000 * 64);
> +	ret = clk_prepare_enable(rt5682_dai_bclk);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't enable master clock %d\n", ret);
> +		return ret;
> +	}
> +	return ret;
> +}

Out of curiosity, is there a reason why you use clk_prepare_enable() for 
the bclk but not for the wclk?
