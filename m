Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F2B3BEC56
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhGGQiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:38:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:55247 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhGGQiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:38:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="189718230"
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="189718230"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 09:35:30 -0700
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="645442761"
Received: from cmcarran-mobl.amr.corp.intel.com (HELO [10.213.189.140]) ([10.213.189.140])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 09:35:29 -0700
Subject: Re: [PATCH 05/12] ASoC: amd: add ACP5x PCM platform driver
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Alexander.Deucher@amd.com
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-6-vijendar.mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2cac4b49-62f1-83a8-84c1-08add69535d3@linux.intel.com>
Date:   Wed, 7 Jul 2021 11:17:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707055623.27371-6-vijendar.mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int acp5x_audio_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

can this be removed here and...
> +
> +static struct platform_driver acp5x_dma_driver = {
> +	.probe = acp5x_audio_probe,
> +	.remove = acp5x_audio_remove,

... here?

> +	.driver = {
> +		.name = "acp5x_i2s_dma",
> +	},
> +};
