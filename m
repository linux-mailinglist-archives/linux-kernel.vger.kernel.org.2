Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C928135E85F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 23:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343824AbhDMVfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 17:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhDMVfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 17:35:10 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EDBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 14:34:49 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id t140-20020a4a3e920000b02901e5c1add773so2915824oot.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FOllnPXHllv++nMeKGcRp72HvHtuzEorYNDS+7csQnc=;
        b=p9sK5bIAOVE/cIygFsqF2n3RJ/Zvp7PrybYGikPgpMOukszsWN9yMqWh8+kqno3Ps7
         R5ebKFToe6e8f8vRJt+jFwyNSobdRLprqZt+Hsy887uwEIDEh6os48OkyTvqg6KFbrTP
         jNL6QUiU4Rc5uLuSb1WybpZuII9c1Yb36cOEHHl/S7qAvxsO68SBHZ+55PNfbasDQmiu
         W91v0TctoRIZvmnh98wnCGVnNCQJXXSUiPNmu20LG3w3/U+ZW7DulFM/vQshw0YGIWmh
         uixtKVdjPVdfb1wadaScaxQgzx02kG0G2U8YM/5ChAY+cFFOF0YO3h3vFTbzbp3k+5ae
         kwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FOllnPXHllv++nMeKGcRp72HvHtuzEorYNDS+7csQnc=;
        b=YVcgpN9PisEx0fZ2D2oTJ/rFNLa/8+yQ6oMx4lPkdeSHsJnK4zTRuRMoUfqXNSXtAN
         s3Zg9esv7it6kGtq5GpWAT+iFDxlosMvZ1tQXotxWeTjpZYKOskQvfFpH2EC0c6JSZ9p
         hYKOL9PEt3J8WXqsGEYd7+Xf9DsqCrdbqZK1bL9zuey0fGQTHJzWQ0ABYjLajFLGaQ8V
         1MM8A6gQQuw1C2Pn++5dRSA8C4H6aK+cDy19xOC0GKyF6dAVZae0oCqbb8D9aDBjvDW/
         KFEDRbBYkDFzCPrcVn/OZ+NMDMcDFMVTf9wHivlGDZ2y+xBeG5bBG4Li4hCiOd/ecsOG
         HRZA==
X-Gm-Message-State: AOAM532rMJ4mrmqlWff5ZoJsVPKL3Wpj9s1jXFrH+LbEO7v4E/K7u8iB
        Uf3Y1M82wbP20R/brfWbrO1rEA==
X-Google-Smtp-Source: ABdhPJybcirmWf+UYoMFRkeUspQ4uHJRg55y+2KDoXOvGcKDZk1c3JAxpGR9+mLppviL0Pg0WFWg5A==
X-Received: by 2002:a4a:9533:: with SMTP id m48mr28384650ooi.34.1618349689308;
        Tue, 13 Apr 2021 14:34:49 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m127sm3098859oib.32.2021.04.13.14.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 14:34:48 -0700 (PDT)
Date:   Tue, 13 Apr 2021 16:34:47 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] remoteproc: stm32: add capability to detach
Message-ID: <YHYOd/vqeZCiqkpJ@builder.lan>
References: <20210331073347.8293-1-arnaud.pouliquen@foss.st.com>
 <20210331073347.8293-3-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331073347.8293-3-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31 Mar 02:33 CDT 2021, Arnaud Pouliquen wrote:

> A mechanism similar to the shutdown mailbox signal is implemented to
> detach a remote processor.
> 
> Upon detachment, a signal is sent to the remote firmware, allowing it
> to perform specific actions such as stopping rpmsg communication.
> 
> The Cortex-M hold boot is also disabled to allow the remote processor
> to restart in case of crash.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/stm32_rproc.c | 39 ++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 3d45f51de4d0..7353f9e7e7af 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -28,7 +28,7 @@
>  #define RELEASE_BOOT		1
>  
>  #define MBOX_NB_VQ		2
> -#define MBOX_NB_MBX		3
> +#define MBOX_NB_MBX		4
>  
>  #define STM32_SMC_RCC		0x82001000
>  #define STM32_SMC_REG_WRITE	0x1
> @@ -38,6 +38,7 @@
>  #define STM32_MBX_VQ1		"vq1"
>  #define STM32_MBX_VQ1_ID	1
>  #define STM32_MBX_SHUTDOWN	"shutdown"
> +#define STM32_MBX_DETACH	"detach"
>  
>  #define RSC_TBL_SIZE		1024
>  
> @@ -336,6 +337,15 @@ static const struct stm32_mbox stm32_rproc_mbox[MBOX_NB_MBX] = {
>  			.tx_done = NULL,
>  			.tx_tout = 500, /* 500 ms time out */
>  		},
> +	},
> +	{
> +		.name = STM32_MBX_DETACH,
> +		.vq_id = -1,
> +		.client = {
> +			.tx_block = true,
> +			.tx_done = NULL,
> +			.tx_tout = 200, /* 200 ms time out to detach should be fair enough */
> +		},
>  	}
>  };
>  
> @@ -461,6 +471,25 @@ static int stm32_rproc_attach(struct rproc *rproc)
>  	return stm32_rproc_set_hold_boot(rproc, true);
>  }
>  
> +static int stm32_rproc_detach(struct rproc *rproc)
> +{
> +	struct stm32_rproc *ddata = rproc->priv;
> +	int err, dummy_data, idx;
> +
> +	/* Inform the remote processor of the detach */
> +	idx = stm32_rproc_mbox_idx(rproc, STM32_MBX_DETACH);
> +	if (idx >= 0 && ddata->mb[idx].chan) {
> +		/* A dummy data is sent to allow to block on transmit */
> +		err = mbox_send_message(ddata->mb[idx].chan,
> +					&dummy_data);

Seems I posted my comment on v1, rather than this latest version. Please
let me know if we should do anything about this dummy_data.

Regards,
Bjorn

> +		if (err < 0)
> +			dev_warn(&rproc->dev, "warning: remote FW detach without ack\n");
> +	}
> +
> +	/* Allow remote processor to auto-reboot */
> +	return stm32_rproc_set_hold_boot(rproc, false);
> +}
> +
>  static int stm32_rproc_stop(struct rproc *rproc)
>  {
>  	struct stm32_rproc *ddata = rproc->priv;
> @@ -597,7 +626,12 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
>  	}
>  
>  done:
> -	/* Assuming the resource table fits in 1kB is fair */
> +	/*
> +	 * Assuming the resource table fits in 1kB is fair.
> +	 * Notice for the detach, that this 1 kB memory area has to be reserved in the coprocessor
> +	 * firmware for the resource table. On detach, the remoteproc core re-initializes this
> +	 * entire area by overwriting it with the initial values stored in rproc->clean_table.
> +	 */
>  	*table_sz = RSC_TBL_SIZE;
>  	return (struct resource_table *)ddata->rsc_va;
>  }
> @@ -607,6 +641,7 @@ static const struct rproc_ops st_rproc_ops = {
>  	.start		= stm32_rproc_start,
>  	.stop		= stm32_rproc_stop,
>  	.attach		= stm32_rproc_attach,
> +	.detach		= stm32_rproc_detach,
>  	.kick		= stm32_rproc_kick,
>  	.load		= rproc_elf_load_segments,
>  	.parse_fw	= stm32_rproc_parse_fw,
> -- 
> 2.17.1
> 
