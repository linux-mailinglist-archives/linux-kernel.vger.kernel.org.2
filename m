Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8C3422AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhCSQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:58:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:37207 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhCSQ6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:58:25 -0400
IronPort-SDR: 5lnZWHpj/5S6hi6Pd/Ke1o84mtOCSSC2E312vrOXXwhLk+PyBo5ARL2ARNMGYZpKsm+qtZJaIx
 xu6fJ8WSOk8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="177060411"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="177060411"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 09:58:25 -0700
IronPort-SDR: OypGK9KIn31ZMdErlzFgEXoDKNOZKDx3pLwhMuIctAi4gM8MkfrF/X/tZmyHiGNCchEEZttLWF
 Ok5/kN8O/ZyA==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="406867357"
Received: from dgerstma-mobl.amr.corp.intel.com (HELO [10.212.157.39]) ([10.212.157.39])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 09:58:23 -0700
Subject: Re: [PATCH v3 4/7] ASoC: codecs: wcd938x: add basic controls
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20210319092919.21218-1-srinivas.kandagatla@linaro.org>
 <20210319092919.21218-5-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fe430019-783c-d5ba-e79d-d48944c01f04@linux.intel.com>
Date:   Fri, 19 Mar 2021 11:03:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210319092919.21218-5-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int wcd938x_ear_pa_put_gain(struct snd_kcontrol *kcontrol,
> +				   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
> +	struct wcd938x_priv *wcd938x = wcd->wcd938x;
> +
> +	if (wcd938x->comp1_enable) {
> +		dev_err(component->dev, "Can not set EAR PA Gain, compander1 is enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	snd_soc_component_write_field(component, WCD938X_ANA_EAR_COMPANDER_CTL,
> +				      WCD938X_EAR_GAIN_MASK,
> +				      ucontrol->value.integer.value[0]);
> +
> +	return 0;

that goes back to my other comments, the earpiece is connected to the RX 
interface, so what component would be used to set the gain here? the TX 
one? But what tells you this component is active and ready to support 
commands?

