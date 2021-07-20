Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2783D01DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 20:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhGTSGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 14:06:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:2800 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhGTSGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 14:06:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="296869487"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="296869487"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 11:47:28 -0700
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="462146668"
Received: from aremenni-mobl.amr.corp.intel.com (HELO [10.209.130.10]) ([10.209.130.10])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 11:47:25 -0700
Subject: Re: [PATCH v4 05/12] ASoC: amd: add ACP5x PCM platform driver
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
        krisman@collabora.com
References: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
 <20210720163732.23003-6-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <106fa9e8-1d22-dd6a-8301-20761a212e4f@linux.intel.com>
Date:   Tue, 20 Jul 2021 13:12:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720163732.23003-6-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int acp5x_audio_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct i2s_dev_data *adata;
> +	int status;
> +
> +	if (!pdev->dev.platform_data) {
> +		dev_err(&pdev->dev, "platform_data not retrieved\n");
> +		return -ENODEV;
> +	}
> +	irqflags = *((unsigned int *)(pdev->dev.platform_data));
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
> +			return -ENODEV;

indentation is off?

> +	}
> +
> +	adata = devm_kzalloc(&pdev->dev, sizeof(*adata), GFP_KERNEL);
> +	if (!adata)
> +		return -ENOMEM;
> +
> +	adata->acp5x_base = devm_ioremap(&pdev->dev, res->start,
> +					 resource_size(res));
> +	if (!adata->acp5x_base)
> +		return -ENOMEM;
> +	dev_set_drvdata(&pdev->dev, adata);
> +	status = devm_snd_soc_register_component(&pdev->dev,
> +						 &acp5x_i2s_component,
> +						 NULL, 0);
> +	if (status)
> +		dev_err(&pdev->dev, "Fail to register acp i2s component\n");
> +
> +	return status;
> +}
