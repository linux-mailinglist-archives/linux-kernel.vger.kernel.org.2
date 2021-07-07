Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1083BEC5A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhGGQie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:38:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:55274 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhGGQib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:38:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="189718254"
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="189718254"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 09:35:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="645442799"
Received: from cmcarran-mobl.amr.corp.intel.com (HELO [10.213.189.140]) ([10.213.189.140])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 09:35:37 -0700
Subject: Re: [PATCH 10/12] ASoC: amd: add vangogh pci driver pm ops
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Alexander.Deucher@amd.com
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-11-vijendar.mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ce03f4b3-874f-a286-5523-7793722a6ee7@linux.intel.com>
Date:   Wed, 7 Jul 2021 11:34:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707055623.27371-11-vijendar.mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int snd_acp5x_suspend(struct device *dev)
> +{
> +	int ret;
> +	struct acp5x_dev_data *adata;
> +
> +	adata = dev_get_drvdata(dev);
> +	ret = acp5x_deinit(adata->acp5x_base);
> +	if (ret)
> +		dev_err(dev, "ACP de-init failed\n");
> +	else
> +		dev_dbg(dev, "ACP de-initialized\n");
> +
> +	return ret;
> +}
> +
> +static int snd_acp5x_resume(struct device *dev)
> +{
> +	int ret;
> +	struct acp5x_dev_data *adata;
> +
> +	adata = dev_get_drvdata(dev);
> +	ret = acp5x_init(adata->acp5x_base);
> +	if (ret) {
> +		dev_err(dev, "ACP init failed\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops acp5x_pm = {
> +	.runtime_suspend = snd_acp5x_suspend,
> +	.runtime_resume =  snd_acp5x_resume,
> +	.resume =	snd_acp5x_resume,

use SET_SYSTEM_SLEEP_PM_OPS and SET_RUNTIME_PM_OPS?

also not clear why you don't have a .suspend here?

And to avoid warnings use __maybe_unused for those callbacks when PM is disabled?


