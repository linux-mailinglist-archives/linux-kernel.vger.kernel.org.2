Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AF2409B53
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245580AbhIMR54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbhIMR5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:57:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E84C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:56:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t4so761873plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vm48QzVnlg64N4CDLfhKjY3I262QdEzPwX/kCmzJ/mI=;
        b=P8wDHk/53e8BOgh+Xkq0oe0cys/JU7emQx4SzvFhTxEJNVsMwJq4ccOR7g7bwPzSR6
         HMh6I6fcLR3jH7Cn0zRMIQE/Qnj0efPjAfdNtwzXawhW110ipbzwLbfX9X28p8L/Oemw
         RPBx7ScWPafJK3mnuWCKiEP2MkZNHxbw3x9dLpeejSiV/CNjUHkqMkjunOabESq1S6lO
         nzR4XC03TXqL6KtHqkuBhZr0MPKYyvWujQIkCRnQ1gM/GEj4WV/n768Vxh99mCpU0FSW
         99/Kbekp5BDikm7YWt53IwRBNgZ6oxn1pUZ5pK7Ub6j6UU9CcmlsON8MQKc276vvLELe
         gZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vm48QzVnlg64N4CDLfhKjY3I262QdEzPwX/kCmzJ/mI=;
        b=Dux/5MsqCzZHWiv5RjmXWVpv7hwuWXPCpJeoMUiqcMzjgB+OuhdYqKjQTNk3p+xUqd
         T+y9KJyrzS3q6EcJ6cTOiGrjlcC+2fhSV6qPtLd7nZQeKSn398f6qBUOx9oR6kRdFeLR
         3NpnXguRJqHMv+nP3uHhRY/18MeTQpD0Kw5mBja3PFgJ5ro2+5W22sSmU4dKyjhXBm9t
         vpBTkwgaSi1uDd5exOnL2ya+55krEdw4XeV+shmRUl78/jJ5HNjrOdI8Seur0RamcpPG
         4Sf1lKEtWiUztaKp44kZtW/VOzG0fbeCvGV78wbe1gfKMAmFAYyWhAY2c0cbatAuI3ID
         bzRA==
X-Gm-Message-State: AOAM531DWPAZg01FS9ejjjVUFoDRjASgWayga2PNtC0rp4CEa9bQsjiY
        Pytqzw+HZAGJDH4+NhQomgp1pplY4u8wag==
X-Google-Smtp-Source: ABdhPJyGwHaVpOVAHmi9y7dL1NNyewR0YKSE+++ZPJE8YHzmgNN46i1J9uCG16ikssPKf4MoEmnofw==
X-Received: by 2002:a17:90a:3f8d:: with SMTP id m13mr717742pjc.199.1631555798581;
        Mon, 13 Sep 2021 10:56:38 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b20sm7646156pfo.3.2021.09.13.10.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 10:56:37 -0700 (PDT)
Date:   Mon, 13 Sep 2021 11:56:35 -0600
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
Message-ID: <20210913175635.GA1676953@p14s>
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

Suzuki and Robin - are you guys good with this new revision?  

Thanks,
Mathieu

PS: Suzuki - I know you've already provided your RB on this but with the change
in API I want to make sure before merging.

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
