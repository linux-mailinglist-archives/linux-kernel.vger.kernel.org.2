Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780403D01E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhGTSHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 14:07:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:2800 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhGTSGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 14:06:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="296869500"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="296869500"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 11:47:31 -0700
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="462146678"
Received: from aremenni-mobl.amr.corp.intel.com (HELO [10.209.130.10]) ([10.209.130.10])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 11:47:30 -0700
Subject: Re: [PATCH v4 09/12] ASoC: amd: add vangogh i2s dai driver ops
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
        krisman@collabora.com
References: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
 <20210720163732.23003-10-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6983b9cf-d270-1033-5481-f8aa5bb378d9@linux.intel.com>
Date:   Tue, 20 Jul 2021 13:30:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720163732.23003-10-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
> index 2300e63534e7..c94ed8795b9c 100644
> --- a/sound/soc/amd/vangogh/acp5x.h
> +++ b/sound/soc/amd/vangogh/acp5x.h
> @@ -74,9 +74,20 @@
>  #define I2S_MASTER_MODE_ENABLE 0x01
>  #define I2S_MASTER_MODE_DISABLE 0x00
>  
> +#define SLOT_WIDTH_8 0x08
> +#define SLOT_WIDTH_16 0x10
> +#define SLOT_WIDTH_24 0x18
> +#define SLOT_WIDTH_32 0x20

nit-pick: it's not incorrect but is the hex notation necessary?

> +#define TDM_ENABLE 1
> +#define TDM_DISABLE 0
> +#define ACP5x_ITER_IRER_SAMP_LEN_MASK	0x38
