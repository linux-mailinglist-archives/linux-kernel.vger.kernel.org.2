Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C083422AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCSQ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:59:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:37207 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230237AbhCSQ61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:58:27 -0400
IronPort-SDR: wugCp0PS/OoVo4qOg17TN3wCSgpN+Z+oEbvfhuFf4N7OuDJdQpRIOKFbKcLDsewmkppZy86mCe
 G5E6toIinZ8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="177060417"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="177060417"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 09:58:27 -0700
IronPort-SDR: pjJcDIgtNb7uxOqD0EZyz8mYL6SZYEd4pOG1xWucYDEkNF0Gz0IN5P9YYBDx4sN6QsbZkQs3lG
 Vwv2y5Nseeaw==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="406867423"
Received: from dgerstma-mobl.amr.corp.intel.com (HELO [10.212.157.39]) ([10.212.157.39])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 09:58:26 -0700
Subject: Re: [PATCH v3 7/7] ASoC: codecs: wcd938x: add audio routing
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20210319092919.21218-1-srinivas.kandagatla@linaro.org>
 <20210319092919.21218-8-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d2ee1841-4634-25e5-2473-422a1015acec@linux.intel.com>
Date:   Fri, 19 Mar 2021 11:06:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210319092919.21218-8-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/21 4:29 AM, Srinivas Kandagatla wrote:
> This patch adds audio routing for both playback and capture.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/codecs/wcd938x.c | 97 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 97 insertions(+)
> 
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index 31e3cf729568..0f801920ebac 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -3153,6 +3153,99 @@ static const struct snd_soc_dapm_widget wcd938x_rx_dapm_widgets[] = {
>   
>   };
>   
> +static const struct snd_soc_dapm_route wcd938x_rx_audio_map[] = {
> +	{"IN1_HPHL", NULL, "VDD_BUCK"},
> +	{"IN1_HPHL", NULL, "CLS_H_PORT"},
> +
> +	{"RX1", NULL, "IN1_HPHL"},
> +	{"RX1", NULL, "RXCLK"},
> +	{"RDAC1", NULL, "RX1"},
> +	{"HPHL_RDAC", "Switch", "RDAC1"},
> +	{"HPHL PGA", NULL, "HPHL_RDAC"},
> +	{"HPHL", NULL, "HPHL PGA"},
> +
> +	{"IN2_HPHR", NULL, "VDD_BUCK"},
> +	{"IN2_HPHR", NULL, "CLS_H_PORT"},
> +	{"RX2", NULL, "IN2_HPHR"},
> +	{"RDAC2", NULL, "RX2"},
> +	{"RX2", NULL, "RXCLK"},
> +	{"HPHR_RDAC", "Switch", "RDAC2"},
> +	{"HPHR PGA", NULL, "HPHR_RDAC"},
> +	{"HPHR", NULL, "HPHR PGA"},
> +
> +	{"IN3_AUX", NULL, "VDD_BUCK"},
> +	{"IN3_AUX", NULL, "CLS_H_PORT"},
> +	{"RX3", NULL, "IN3_AUX"},
> +	{"RDAC4", NULL, "RX3"},
> +	{"RX3", NULL, "RXCLK"},
> +	{"AUX_RDAC", "Switch", "RDAC4"},
> +	{"AUX PGA", NULL, "AUX_RDAC"},
> +	{"AUX", NULL, "AUX PGA"},
> +
> +	{"RDAC3_MUX", "RX3", "RX3"},
> +	{"RDAC3_MUX", "RX1", "RX1"},
> +	{"RDAC3", NULL, "RDAC3_MUX"},
> +	{"EAR_RDAC", "Switch", "RDAC3"},
> +	{"EAR PGA", NULL, "EAR_RDAC"},
> +	{"EAR", NULL, "EAR PGA"},
> +};
> +
> +static const struct snd_soc_dapm_route wcd938x_audio_map[] = {
> +	{"ADC1_OUTPUT", NULL, "ADC1_MIXER"},
> +	{"ADC1_MIXER", "Switch", "ADC1 REQ"},
> +	{"ADC1 REQ", NULL, "ADC1"},
> +	{"ADC1", NULL, "AMIC1"},
> +
> +	{"ADC2_OUTPUT", NULL, "ADC2_MIXER"},
> +	{"ADC2_MIXER", "Switch", "ADC2 REQ"},
> +	{"ADC2 REQ", NULL, "ADC2"},
> +	{"ADC2", NULL, "HDR12 MUX"},
> +	{"HDR12 MUX", "NO_HDR12", "ADC2 MUX"},
> +	{"HDR12 MUX", "HDR12", "AMIC1"},
> +	{"ADC2 MUX", "INP3", "AMIC3"},
> +	{"ADC2 MUX", "INP2", "AMIC2"},
> +
> +	{"ADC3_OUTPUT", NULL, "ADC3_MIXER"},
> +	{"ADC3_MIXER", "Switch", "ADC3 REQ"},
> +	{"ADC3 REQ", NULL, "ADC3"},
> +	{"ADC3", NULL, "HDR34 MUX"},
> +	{"HDR34 MUX", "NO_HDR34", "ADC3 MUX"},
> +	{"HDR34 MUX", "HDR34", "AMIC5"},
> +	{"ADC3 MUX", "INP4", "AMIC4"},
> +	{"ADC3 MUX", "INP6", "AMIC6"},
> +
> +	{"ADC4_OUTPUT", NULL, "ADC4_MIXER"},
> +	{"ADC4_MIXER", "Switch", "ADC4 REQ"},
> +	{"ADC4 REQ", NULL, "ADC4"},
> +	{"ADC4", NULL, "ADC4 MUX"},
> +	{"ADC4 MUX", "INP5", "AMIC5"},
> +	{"ADC4 MUX", "INP7", "AMIC7"},
> +
> +	{"DMIC1_OUTPUT", NULL, "DMIC1_MIXER"},
> +	{"DMIC1_MIXER", "Switch", "DMIC1"},
> +
> +	{"DMIC2_OUTPUT", NULL, "DMIC2_MIXER"},
> +	{"DMIC2_MIXER", "Switch", "DMIC2"},
> +
> +	{"DMIC3_OUTPUT", NULL, "DMIC3_MIXER"},
> +	{"DMIC3_MIXER", "Switch", "DMIC3"},
> +
> +	{"DMIC4_OUTPUT", NULL, "DMIC4_MIXER"},
> +	{"DMIC4_MIXER", "Switch", "DMIC4"},
> +
> +	{"DMIC5_OUTPUT", NULL, "DMIC5_MIXER"},
> +	{"DMIC5_MIXER", "Switch", "DMIC5"},
> +
> +	{"DMIC6_OUTPUT", NULL, "DMIC6_MIXER"},
> +	{"DMIC6_MIXER", "Switch", "DMIC6"},
> +
> +	{"DMIC7_OUTPUT", NULL, "DMIC7_MIXER"},
> +	{"DMIC7_MIXER", "Switch", "DMIC7"},
> +
> +	{"DMIC8_OUTPUT", NULL, "DMIC8_MIXER"},
> +	{"DMIC8_MIXER", "Switch", "DMIC8"},
> +};

And last comment that shows I am at a loss on how this is supposed to 
work: how would sidetone be handled? This is functionality that needs 
both playback and capture to be working, but if they are split into two 
separate spaces with only the TX handling commands then what happens?


> +
>   static int wcd938x_get_micb_vout_ctl_val(u32 micb_mv)
>   {
>   	/* min micbias voltage is 1V and maximum is 2.85V */
> @@ -3332,6 +3425,8 @@ static const struct snd_soc_component_driver soc_codec_dev_wcd938x_sdw_rx = {
>   	.num_controls = ARRAY_SIZE(wcd938x_rx_snd_controls),
>   	.dapm_widgets = wcd938x_rx_dapm_widgets,
>   	.num_dapm_widgets = ARRAY_SIZE(wcd938x_rx_dapm_widgets),
> +	.dapm_routes = wcd938x_rx_audio_map,
> +	.num_dapm_routes = ARRAY_SIZE(wcd938x_rx_audio_map),
>   };
>   
>   static const struct snd_soc_component_driver soc_codec_dev_wcd938x_sdw_tx = {
> @@ -3341,6 +3436,8 @@ static const struct snd_soc_component_driver soc_codec_dev_wcd938x_sdw_tx = {
>   	.num_controls = ARRAY_SIZE(wcd938x_snd_controls),
>   	.dapm_widgets = wcd938x_dapm_widgets,
>   	.num_dapm_widgets = ARRAY_SIZE(wcd938x_dapm_widgets),
> +	.dapm_routes = wcd938x_audio_map,
> +	.num_dapm_routes = ARRAY_SIZE(wcd938x_audio_map),
>   };
>   
>   static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_priv *wcd)
> 
