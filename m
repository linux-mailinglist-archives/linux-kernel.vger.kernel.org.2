Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FED3DEEFC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhHCNUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:20:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:49599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236045AbhHCNUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:20:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="211817657"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="211817657"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 06:20:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="521246523"
Received: from vmustya-mobl1.amr.corp.intel.com (HELO [10.213.171.71]) ([10.213.171.71])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 06:20:19 -0700
Subject: Re: [PATCH v3 2/4] ASoC: codecs: wcd: add multi button Headset
 detection support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20210604115230.23259-1-srinivas.kandagatla@linaro.org>
 <20210604115230.23259-3-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <139e6867-2d29-09e0-d059-399917e5962d@linux.intel.com>
Date:   Mon, 2 Aug 2021 19:03:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210604115230.23259-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,
cppcheck reports an issue with the use of 'hphpa_on' below

> +static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int irq, void *data)
> +{
> +	struct wcd_mbhc *mbhc = data;
> +	unsigned long timeout;
> +	int adc_threshold, output_mv, retry = 0;
> +	bool hphpa_on = false;

assigned here

> +
> +	mutex_lock(&mbhc->lock);
> +	timeout = jiffies + msecs_to_jiffies(WCD_FAKE_REMOVAL_MIN_PERIOD_MS);
> +	adc_threshold = wcd_mbhc_adc_get_hs_thres(mbhc);
> +
> +	do {
> +		retry++;
> +		/*
> +		 * read output_mv every 10ms to look for
> +		 * any change in IN2_P
> +		 */
> +		usleep_range(10000, 10100);
> +		output_mv = wcd_measure_adc_once(mbhc, MUX_CTL_IN2P);
> +
> +		/* Check for fake removal */
> +		if ((output_mv <= adc_threshold) && retry > FAKE_REM_RETRY_ATTEMPTS)
> +			goto exit;
> +	} while (!time_after(jiffies, timeout));
> +
> +	/*
> +	 * ADC COMPLETE and ELEC_REM interrupts are both enabled for
> +	 * HEADPHONE, need to reject the ADC COMPLETE interrupt which
> +	 * follows ELEC_REM one when HEADPHONE is removed.
> +	 */
> +	if (mbhc->current_plug == MBHC_PLUG_TYPE_HEADPHONE)
> +		mbhc->extn_cable_hph_rem = true;
> +
> +	wcd_mbhc_write_field(mbhc, WCD_MBHC_DETECTION_DONE, 0);
> +	wcd_mbhc_write_field(mbhc, WCD_MBHC_ADC_MODE, 0);
> +	wcd_mbhc_write_field(mbhc, WCD_MBHC_ADC_EN, 0);
> +	wcd_mbhc_elec_hs_report_unplug(mbhc);
> +	wcd_mbhc_write_field(mbhc, WCD_MBHC_BTN_ISRC_CTL, 0);

not used, so hphpa_on == false

> +	if (hphpa_on) {
> +		hphpa_on = false;
> +		wcd_mbhc_write_field(mbhc, WCD_MBHC_HPH_PA_EN, 3);
> +	}

And this branch is never taken.

Is there a missing hphpa = true assignment somewhere?


There's an additional issue while I am at it:

sound/soc/codecs/wcd-mbhc-v2.c:1225:17: style: Variable 'clamp_state' is
assigned a value that is never used. [unreadVariable]
 u8 clamp_state = 0;
                ^

-Pierre
