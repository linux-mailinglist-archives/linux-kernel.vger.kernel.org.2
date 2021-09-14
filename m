Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6B540B2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhINPXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbhINPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:23:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5C5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:22:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t4so2840380plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hwrgRNDZea6xEfRAcl0LOxvRZnBwZyVcfDyv4G1rDvU=;
        b=MKPPPUb8R6SozLFUnfvgjdbSqr8FGDyrmKUsUwAM0q4uQRz/CiWa5Ow/YdYAak5akG
         WYoPNGRz/IRQMXVuMHcT8qaQNwHfxoJrEPfSaoJP2zCBf3rWKA0MfMb+yh6O7zAuqydb
         2CE2rPcuPimdo9yRP/ffvFVbOi/jdyQ1bQzuLjvlFvFmyZiMnEQOOQOjDAJl1yl2GXic
         YuACwIe7US6JJ0hHIh7OXg+/Yn2OFS7fe7VlaQkiqQiTymktUxhiWGY2y7niZz8cztCf
         NBXTYLvxwutrGGT3DlKPJJKZ+f4Wl2nsmz1wlQQLMAyUDn1PBfB1SWOVNuHbKH2gULKb
         FnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hwrgRNDZea6xEfRAcl0LOxvRZnBwZyVcfDyv4G1rDvU=;
        b=Z5sPPKFVLUmM6nCj82gwPy2RRWuEGieHzhpUkJhW31TBSyjKO9smO9dZCSxB/cRYUs
         5he6JrK91GgayYRQEVAdnpMupN7QJ8I+jFlxM95H+a4voHHB1FrA6RcLY4c+rWdXmoek
         d/En5FEvDayrqIJAGR49hkAHLSCcEzZfY7pUfXSJXt2e+tUPZnarDZNePeZRbBnmCH7+
         dTglyy/yF+LCmR5RhXHc0AEU8vTDdeY1H12GawCnTW5lwqHPJJFcbOFqvbGYh6SkVC1R
         NZLNem4+amTPP6BO93qRq0cVYE/acsj7vxoo2dGw2rrADk3yN/Nx8w0GflUjtfBjpU9q
         UO/Q==
X-Gm-Message-State: AOAM532Rf3/LNSh6FKtrBT45hZIQgt54NR1yK1At/s+Aq3c2siTaK713
        SnQvTxRRmNf0g2+e1Wlw/as+tA==
X-Google-Smtp-Source: ABdhPJx/FPlAfxp/MrxCMOnK3QdspiXWdNxpnGpqbVRQnVxu6I45lBfdyBDhyy4Fw7msSW639yZT1g==
X-Received: by 2002:a17:902:9887:b0:13b:9892:860b with SMTP id s7-20020a170902988700b0013b9892860bmr8624475plp.65.1631632949570;
        Tue, 14 Sep 2021 08:22:29 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id d18sm12247146pgk.24.2021.09.14.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:22:28 -0700 (PDT)
Date:   Tue, 14 Sep 2021 09:22:25 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] coresight: tmc-etr: Speed up for bounce buffer in
 flat mode
Message-ID: <20210914152225.GA1719994@p14s>
References: <20210905032144.966766-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210905032144.966766-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2021 at 11:21:44AM +0800, Leo Yan wrote:
> The AUX bounce buffer is allocated with API dma_alloc_coherent(), in the
> low level's architecture code, e.g. for Arm64, it maps the memory with
> the attribution "Normal non-cacheable"; this can be concluded from the
> definition for pgprot_dmacoherent() in arch/arm64/include/asm/pgtable.h.
> 
> Later when access the AUX bounce buffer, since the memory mapping is
> non-cacheable, it's low efficiency due to every load instruction must
> reach out DRAM.
> 
> This patch changes to allocate pages with dma_alloc_noncoherent(), the
> driver can access the memory via cacheable mapping; therefore, load
> instructions can fetch data from cache lines rather than always read
> data from DRAM, the driver can boost memory performance.  After using
> the cacheable mapping, the driver uses dma_sync_single_for_cpu() to
> invalidate cacheline prior to read bounce buffer so can avoid read stale
> trace data.
> 
> By measurement the duration for function tmc_update_etr_buffer() with
> ftrace function_graph tracer, it shows the performance significant
> improvement for copying 4MiB data from bounce buffer:
> 
>   # echo tmc_etr_get_data_flat_buf > set_graph_notrace // avoid noise
>   # echo tmc_update_etr_buffer > set_graph_function
>   # echo function_graph > current_tracer
> 
>   before:
> 
>   # CPU  DURATION                  FUNCTION CALLS
>   # |     |   |                     |   |   |   |
>   2)               |    tmc_update_etr_buffer() {
>   ...
>   2) # 8148.320 us |    }
> 
>   after:
> 
>   # CPU  DURATION                  FUNCTION CALLS
>   # |     |   |                     |   |   |   |
>   2)               |  tmc_update_etr_buffer() {
>   ...
>   2) # 2525.420 us |  }
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

I have merged this patch.

Thanks,
Mathieu

> ---
> 
> Changes from v3:
> Refined change to use dma_alloc_noncoherent()/dma_free_noncoherent()
> (Robin Murphy);
> Retested functionality and performance on Juno-r2 board.
> 
> Changes from v2:
> Sync the entire buffer in one go when the tracing is wrap around
> (Suzuki);
> Add Suzuki's review tage.
> 
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 26 ++++++++++++++++---
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index acdb59e0e661..a049b525a274 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -609,8 +609,9 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
>  	if (!flat_buf)
>  		return -ENOMEM;
>  
> -	flat_buf->vaddr = dma_alloc_coherent(real_dev, etr_buf->size,
> -					     &flat_buf->daddr, GFP_KERNEL);
> +	flat_buf->vaddr = dma_alloc_noncoherent(real_dev, etr_buf->size,
> +						&flat_buf->daddr,
> +						DMA_FROM_DEVICE, GFP_KERNEL);
>  	if (!flat_buf->vaddr) {
>  		kfree(flat_buf);
>  		return -ENOMEM;
> @@ -631,14 +632,18 @@ static void tmc_etr_free_flat_buf(struct etr_buf *etr_buf)
>  	if (flat_buf && flat_buf->daddr) {
>  		struct device *real_dev = flat_buf->dev->parent;
>  
> -		dma_free_coherent(real_dev, flat_buf->size,
> -				  flat_buf->vaddr, flat_buf->daddr);
> +		dma_free_noncoherent(real_dev, etr_buf->size,
> +				     flat_buf->vaddr, flat_buf->daddr,
> +				     DMA_FROM_DEVICE);
>  	}
>  	kfree(flat_buf);
>  }
>  
>  static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
>  {
> +	struct etr_flat_buf *flat_buf = etr_buf->private;
> +	struct device *real_dev = flat_buf->dev->parent;
> +
>  	/*
>  	 * Adjust the buffer to point to the beginning of the trace data
>  	 * and update the available trace data.
> @@ -648,6 +653,19 @@ static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
>  		etr_buf->len = etr_buf->size;
>  	else
>  		etr_buf->len = rwp - rrp;
> +
> +	/*
> +	 * The driver always starts tracing at the beginning of the buffer,
> +	 * the only reason why we would get a wrap around is when the buffer
> +	 * is full.  Sync the entire buffer in one go for this case.
> +	 */
> +	if (etr_buf->offset + etr_buf->len > etr_buf->size)
> +		dma_sync_single_for_cpu(real_dev, flat_buf->daddr,
> +					etr_buf->size, DMA_FROM_DEVICE);
> +	else
> +		dma_sync_single_for_cpu(real_dev,
> +					flat_buf->daddr + etr_buf->offset,
> +					etr_buf->len, DMA_FROM_DEVICE);
>  }
>  
>  static ssize_t tmc_etr_get_data_flat_buf(struct etr_buf *etr_buf,
> -- 
> 2.25.1
> 
