Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC5A3BEC55
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhGGQiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:38:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:55247 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhGGQiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:38:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="189718222"
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="189718222"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 09:35:28 -0700
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="645442731"
Received: from cmcarran-mobl.amr.corp.intel.com (HELO [10.213.189.140]) ([10.213.189.140])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 09:35:27 -0700
Subject: Re: [PATCH 03/12] add acp5x init/de-init functions
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Alexander.Deucher@amd.com
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-4-vijendar.mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <dca2f367-59a3-6ea6-7abc-c9817442eb86@linux.intel.com>
Date:   Wed, 7 Jul 2021 11:15:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707055623.27371-4-vijendar.mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missing 'ASoC: amd' prefix in commit subject?


> +static int acp5x_power_on(void __iomem *acp5x_base)
> +{
> +	u32 val;
> +	int timeout;
> +
> +	val = acp_readl(acp5x_base + ACP_PGFSM_STATUS);
> +
> +	if (val == 0)
> +		return val;
> +
> +	if ((val & ACP_PGFSM_STATUS_MASK) !=
> +				ACP_POWER_ON_IN_PROGRESS)
> +		acp_writel(ACP_PGFSM_CNTL_POWER_ON_MASK,
> +			   acp5x_base + ACP_PGFSM_CONTROL);
> +	timeout = 0;
> +	while (++timeout < 500) {
> +		val = acp_readl(acp5x_base + ACP_PGFSM_STATUS);
> +		if (!val)

Shouldn't you use something like 
if ((val & ACP_PGFSM_STATUS_MASK) == ACP_POWERED_ON)
for symmetry with the power-off case?

> +			return 0;
> +		udelay(1);
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +static int acp5x_power_off(void __iomem *acp5x_base)
> +{
> +	u32 val;
> +	int timeout;
> +
> +	acp_writel(ACP_PGFSM_CNTL_POWER_OFF_MASK,
> +		   acp5x_base + ACP_PGFSM_CONTROL);
> +	timeout = 0;
> +	while (++timeout < 500) {
> +		val = acp_readl(acp5x_base + ACP_PGFSM_STATUS);
> +		if ((val & ACP_PGFSM_STATUS_MASK) == ACP_POWERED_OFF)
> +			return 0;
> +		udelay(1);
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +static int acp5x_reset(void __iomem *acp5x_base)
> +{
> +	u32 val;
> +	int timeout;
> +
> +	acp_writel(1, acp5x_base + ACP_SOFT_RESET);
> +	timeout = 0;
> +	while (++timeout < 500) {
> +		val = acp_readl(acp5x_base + ACP_SOFT_RESET);
> +		if (val & ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK)
> +			break;
> +		cpu_relax();
> +	}
> +	acp_writel(0, acp5x_base + ACP_SOFT_RESET);
> +	timeout = 0;
> +	while (++timeout < 500) {
> +		val = acp_readl(acp5x_base + ACP_SOFT_RESET);
> +		if (!val)
> +			return 0;
> +		cpu_relax();
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +static void acp5x_enable_interrupts(void __iomem *acp5x_base)
> +{
> +	acp_writel(0x01, acp5x_base + ACP_EXTERNAL_INTR_ENB);
> +}
> +
> +static void acp5x_disable_interrupts(void __iomem *acp5x_base)
> +{
> +	acp_writel(ACP_EXT_INTR_STAT_CLEAR_MASK, acp5x_base +
> +		   ACP_EXTERNAL_INTR_STAT);
> +	acp_writel(0x00, acp5x_base + ACP_EXTERNAL_INTR_CNTL);
> +	acp_writel(0x00, acp5x_base + ACP_EXTERNAL_INTR_ENB);
> +}
> +
> +static int acp5x_init(void __iomem *acp5x_base)
> +{
> +	int ret;
> +
> +	/* power on */
> +	ret = acp5x_power_on(acp5x_base);
> +	if (ret) {
> +		pr_err("ACP5x power on failed\n");
> +		return ret;
> +	}
> +	/* Reset */
> +	ret = acp5x_reset(acp5x_base);
> +	if (ret) {
> +		pr_err("ACP5x reset failed\n");
> +		return ret;
> +	}
> +	acp5x_enable_interrupts(acp5x_base);
> +	return 0;
> +}
> +
> +static int acp5x_deinit(void __iomem *acp5x_base)
> +{
> +	int ret;
> +
> +	acp5x_disable_interrupts(acp5x_base);
> +	/* Reset */
> +	ret = acp5x_reset(acp5x_base);
> +	if (ret) {
> +		pr_err("ACP5x reset failed\n");
> +		return ret;
> +	}
> +	/* power off */
> +	if (acp_power_gating) {
> +		ret = acp5x_power_off(acp5x_base);
> +		if (ret) {
> +			pr_err("ACP5x power off failed\n");
> +			return ret;
> +		}
> +	}
> +	return 0;

shouldn't you have a sequence for shutdown that ignores the acp_power_gating parameter?

