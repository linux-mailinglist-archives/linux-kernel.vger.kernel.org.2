Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19CB3422AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCSQ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:58:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:37207 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230228AbhCSQ6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:58:24 -0400
IronPort-SDR: BN8lBplDZ/D+09BYgbjARzTeyRXp46zk0/9qjhGB2jnR5ays1FXl1RHmmJ9AOq9TX+YZzbxSUC
 mRtGEXw75VDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="177060399"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="177060399"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 09:58:20 -0700
IronPort-SDR: bxccxDNtBkOJpcorS5wqvftK5TV/i55eDdPQi+c3EWHe9/wNSNyiwB/hm0baidLvTSc1l/rSz0
 IUe7soNxlBGw==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="406867257"
Received: from dgerstma-mobl.amr.corp.intel.com (HELO [10.212.157.39]) ([10.212.157.39])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 09:58:19 -0700
Subject: Re: [PATCH v3 2/7] ASoC: codecs: wcd-clsh: add new version support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20210319092919.21218-1-srinivas.kandagatla@linaro.org>
 <20210319092919.21218-3-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <26038ba1-e8f6-08e3-bee5-673d69d7decd@linux.intel.com>
Date:   Fri, 19 Mar 2021 10:23:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210319092919.21218-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static void wcd_clsh_v3_set_hph_mode(struct snd_soc_component *component,
> +				  int mode)
> +{
> +	u8 val = 0;

initialization not needed.

> +
> +	switch (mode) {
> +	case CLS_H_NORMAL:
> +		val = 0x00;
> +		break;
> +	case CLS_AB:
> +	case CLS_H_ULP:
> +		val = 0x0C;
> +		break;
> +	case CLS_AB_HIFI:
> +	case CLS_H_HIFI:
> +		val = 0x08;
> +		break;
> +	case CLS_H_LP:
> +	case CLS_H_LOHIFI:
> +	case CLS_AB_LP:
> +	case CLS_AB_LOHIFI:
> +		val = 0x04;
> +		break;
> +	default:
> +		dev_err(component->dev, "%s:Invalid mode %d\n", __func__, mode);
> +		return;
> +	};
> +
> +	snd_soc_component_update_bits(component, WCD9XXX_ANA_HPH, 0x0C, val);
> +}
> +
> +

extra line

> +void wcd_clsh_set_hph_mode(struct wcd_clsh_ctrl *ctrl, int mode)
> +{
> +	struct snd_soc_component *comp = ctrl->comp;
> +
> +	if (ctrl->codec_version >= WCD937X)
> +		wcd_clsh_v3_set_hph_mode(comp, mode);
> +	else
> +		wcd_clsh_v2_set_hph_mode(comp, mode);
> +
> +}
> +
>   static void wcd_clsh_set_flyback_current(struct snd_soc_component *comp,
>   					 int mode)
>   {
> @@ -289,6 +388,130 @@ static void wcd_clsh_set_buck_regulator_mode(struct snd_soc_component *comp,
>   					WCD9XXX_A_ANA_RX_REGULATOR_MODE_CLS_H);
>   }
>   
> +static void wcd_clsh_v3_set_buck_regulator_mode(struct snd_soc_component *component,
> +						int mode)
> +{
> +	snd_soc_component_update_bits(component, WCD9XXX_ANA_RX_SUPPLIES,
> +			    0x02, 0x00);
> +}
> +
> +static inline void wcd_clsh_v3_set_flyback_mode(struct snd_soc_component *component,
> +						int mode)
> +{
> +	if (mode == CLS_H_HIFI || mode == CLS_H_LOHIFI ||
> +	    mode == CLS_AB_HIFI || mode == CLS_AB_LOHIFI) {
> +		snd_soc_component_update_bits(component,
> +				WCD9XXX_ANA_RX_SUPPLIES,
> +				0x04, 0x04);
> +		snd_soc_component_update_bits(component,
> +				WCD9XXX_FLYBACK_VNEG_CTRL_4,
> +				0xF0, 0x80);
> +	} else {
> +		snd_soc_component_update_bits(component,
> +				WCD9XXX_ANA_RX_SUPPLIES,
> +				0x04, 0x00); /* set to Default */
> +		snd_soc_component_update_bits(component,
> +				WCD9XXX_FLYBACK_VNEG_CTRL_4,
> +				0xF0, 0x70);
> +	}
> +}
> +
> +static inline void wcd_clsh_v3_force_iq_ctl(struct snd_soc_component *component,
> +					 int mode, bool enable)
> +{
> +	if (enable) {
> +		snd_soc_component_update_bits(component,
> +				WCD9XXX_FLYBACK_VNEGDAC_CTRL_2,
> +				0xE0, 0xA0);
> +		/* 100usec delay is needed as per HW requirement */
> +		usleep_range(100, 110);
> +		snd_soc_component_update_bits(component,
> +				WCD9XXX_CLASSH_MODE_3,
> +				0x02, 0x02);
> +		snd_soc_component_update_bits(component,
> +				WCD9XXX_CLASSH_MODE_2,
> +				0xFF, 0x1C);
> +		if (mode == CLS_H_LOHIFI || mode == CLS_AB_LOHIFI) {
> +			snd_soc_component_update_bits(component,
> +					WCD9XXX_HPH_NEW_INT_PA_MISC2,
> +					0x20, 0x20);
> +			snd_soc_component_update_bits(component,
> +					WCD9XXX_RX_BIAS_HPH_LOWPOWER,
> +					0xF0, 0xC0);
> +			snd_soc_component_update_bits(component,
> +					WCD9XXX_HPH_PA_CTL1,
> +					0x0E, 0x02);
> +		}
> +	} else {
> +		snd_soc_component_update_bits(component,
> +				WCD9XXX_HPH_NEW_INT_PA_MISC2,
> +				0x20, 0x00);
> +		snd_soc_component_update_bits(component,
> +				WCD9XXX_RX_BIAS_HPH_LOWPOWER,
> +				0xF0, 0x80);
> +		snd_soc_component_update_bits(component,
> +				WCD9XXX_HPH_PA_CTL1,
> +				0x0E, 0x06);
> +	}
> +}

do you need the inline for the two functions above?


