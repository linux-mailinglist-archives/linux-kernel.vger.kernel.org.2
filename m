Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB9F3A3FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhFKJ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:57:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:22313 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhFKJ5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:57:49 -0400
IronPort-SDR: Ih0UJKlIcT70ve0x2Vdy4UAeNvErPBn8Fb8n6xQ1qw0FPJ3ZjbJmOAR+LD2E9vXnRHaiDOmDcf
 2lRFFHKIo9iA==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="226919043"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="226919043"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 02:55:50 -0700
IronPort-SDR: qUa36L2aaKIGMlL5OUZWSUUgvFYp/PFy1rMhhXH0ucrC2Eexf9ntJ3hB/7BYKkvDQIVU7JJdSZ
 7+L1Zi0c/Ygw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="441519661"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by orsmga007.jf.intel.com with ESMTP; 11 Jun 2021 02:55:48 -0700
Subject: Re: [PATCH] mmc: sdhci: Clear unused bounce buffer at DMA mmap error
 path
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210611090330.13039-1-tiwai@suse.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <98f90fcb-1134-f90b-db42-29f9505de046@intel.com>
Date:   Fri, 11 Jun 2021 12:56:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611090330.13039-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/21 12:03 pm, Takashi Iwai wrote:
> When DMA-mapping of the bounce buffer fails, the driver tries to fall
> back, but it leaves the allocated host->bounce_buffer although its
> size is zero.  Later on, the driver checks the use of bounce buffer
> with host->bounce_buffer pointer, and it tries to use the buffer
> incorrectly, resulting in Oops.
> 
> This patch clears the release the unused buffer and clears the
> bounce_buffer pointer for addressing the problem.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

One minor comment below, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bf238ade1602..5f467b98ca88 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4072,9 +4072,13 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>  					   bounce_size,
>  					   DMA_BIDIRECTIONAL);
>  	ret = dma_mapping_error(mmc_dev(mmc), host->bounce_addr);
> -	if (ret)
> +	if (ret) {
> +		devm_kfree(mmc->parent, host->bounce_buffer);

Everywhere else in this function mmc_dev(mmc) is used, so maybe
use it here too instead of mmc->parent.

> +		host->bounce_buffer = NULL;
>  		/* Again fall back to max_segs == 1 */
>  		return;
> +	}
> +
>  	host->bounce_buffer_size = bounce_size;
>  
>  	/* Lie about this since we're bouncing */
> 

