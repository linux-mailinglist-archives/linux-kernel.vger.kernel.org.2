Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB593C8985
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbhGNRRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:17:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:35631 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239635AbhGNRRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:17:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="232208078"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="232208078"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="413353810"
Received: from alpinagh-mobl1.amr.corp.intel.com (HELO [10.212.71.223]) ([10.212.71.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:37 -0700
Subject: Re: [PATCH v2 16/16] ASoC: qcom: sm8250: Add audioreach support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
        plai@codeaurora.org, linux-kernel@vger.kernel.org
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-17-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <67e19b85-7f97-c965-04ea-6a46eaf19f3f@linux.intel.com>
Date:   Wed, 14 Jul 2021 12:12:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714153039.28373-17-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/21 10:30 AM, Srinivas Kandagatla wrote:
> This patch adds support for parsing dt for AudioReach based soundcards
> which only have backend DAI links in DT.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/sm8250.c | 144 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 143 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
> index fe8fd7367e21..421f9d1d2bed 100644
> --- a/sound/soc/qcom/sm8250.c
> +++ b/sound/soc/qcom/sm8250.c
> @@ -20,6 +20,141 @@ struct sm8250_snd_data {
>  	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
>  };
>  
> +static int qcom_audioreach_snd_parse_of(struct snd_soc_card *card)
> +{
> +	struct device_node *np;
> +	struct device_node *codec = NULL;
> +	struct device_node *platform = NULL;
> +	struct device_node *cpu = NULL;
> +	struct device *dev = card->dev;
> +	struct snd_soc_dai_link *link;
> +	struct of_phandle_args args;
> +	struct snd_soc_dai_link_component *dlc;
> +	int ret, num_links;
> +
> +	ret = snd_soc_of_parse_card_name(card, "model");
> +	if (ret) {
> +		dev_err(dev, "Error parsing card name: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* DAPM routes */
> +	if (of_property_read_bool(dev->of_node, "audio-routing")) {
> +		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Populate links */
> +	num_links = of_get_child_count(dev->of_node);
> +
> +	/* Allocate the DAI link array */
> +	card->dai_link = devm_kcalloc(dev, num_links, sizeof(*link), GFP_KERNEL);
> +	if (!card->dai_link)
> +		return -ENOMEM;
> +
> +	card->num_links = num_links;
> +	link = card->dai_link;
> +
> +	for_each_child_of_node(dev->of_node, np) {
> +
> +		dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
> +		if (!dlc) {
> +			ret = -ENOMEM;
> +			goto err_put_np;
> +		}
> +
> +		link->cpus	= &dlc[0];
> +		link->platforms	= &dlc[1];
> +
> +		link->num_cpus		= 1;
> +		link->num_platforms	= 1;
> +
> +
> +		ret = of_property_read_string(np, "link-name", &link->name);
> +		if (ret) {
> +			dev_err(card->dev, "error getting codec dai_link name\n");
> +			goto err_put_np;
> +		}
> +
> +		cpu = of_get_child_by_name(np, "cpu");
> +		platform = of_get_child_by_name(np, "platform");
> +		codec = of_get_child_by_name(np, "codec");
> +		if (!cpu) {
> +			dev_err(dev, "%s: Can't find cpu DT node\n", link->name);
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		if (!platform) {
> +			dev_err(dev, "%s: Can't find platform DT node\n", link->name);
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		if (!codec) {
> +			dev_err(dev, "%s: Can't find codec DT node\n", link->name);
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		ret = of_parse_phandle_with_args(cpu, "sound-dai", "#sound-dai-cells", 0, &args);
> +		if (ret) {
> +			dev_err(card->dev, "%s: error getting cpu phandle\n", link->name);
> +			goto err;
> +		}
> +
> +		link->cpus->of_node = args.np;
> +		link->id = args.args[0];
> +
> +		ret = snd_soc_of_get_dai_name(cpu, &link->cpus->dai_name);
> +		if (ret) {
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(card->dev, "%s: error getting cpu dai name: %d\n",
> +					link->name, ret);
> +			goto err;
> +		}
> +
> +		link->platforms->of_node = of_parse_phandle(platform, "sound-dai", 0);
> +		if (!link->platforms->of_node) {
> +			dev_err(card->dev, "%s: platform dai not found\n", link->name);
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
> +		if (ret < 0) {
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(card->dev, "%s: codec dai not found: %d\n",
> +					link->name, ret);
> +			goto err;
> +		}
> +
> +		/* DPCM backend */
> +		link->no_pcm = 1;
> +		link->ignore_pmdown_time = 1;
> +		link->ignore_suspend = 1;

why are those two fields set unconditionally?

If you parse information from DT shouldn't those links be explicitly tagged as requiring those fields to be set?

It's a recurring battle for me to ask why people set them in Intel machine drivers, I find it really odd that you would set them since they aren't without side effect on clocks and suspend.

> +
> +		link->stream_name = link->name;
> +		snd_soc_dai_link_set_capabilities(link);
> +		link++;
> +
> +		of_node_put(cpu);
> +		of_node_put(codec);
> +		of_node_put(platform);
> +
> +	}
> +
> +	return 0;
> +err:
> +	of_node_put(cpu);
> +	of_node_put(codec);
> +	of_node_put(platform);
> +err_put_np:
> +	of_node_put(np);
> +	return ret;
> +}
> +

