Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39B5346AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhCWVTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhCWVTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:19:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA30C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:19:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id l123so15673745pfl.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a2tu+rQXLQBkBPl5r6tVNxPeMVSTHAEY4cUdNiCsFkY=;
        b=JTxHq0+HyD+qx6DhFHeAAsVJYZt79B+q9+j5iwg5H7act/ir116G8CbhRzwOW/iM9M
         dhbpR+G0utc+vE+mfPHbsCPevCDnrhDBdFe+7JPncn/WpypQRrdVks/GdZxsl+3hB1GV
         ylBG3aKheJeRpd2nD/Si3h7gSG11CJKV+qzJGqrAiHV3hmCJVhPBWm7opzidvp1zZ456
         Fb23raCtLvnPoP3AV8v/s3UfcX00jCVkLvralKPJaHzfAs7qZeWP4lbEo1VKjWcNCt3s
         iMbDwhzvIqmWG3guO26igN7RwEoHDvhB1eOE+TMhWON+jRevQsZokwdQBE4GOlYF1COf
         3izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a2tu+rQXLQBkBPl5r6tVNxPeMVSTHAEY4cUdNiCsFkY=;
        b=uUXJhiaqTCT6Dty6qGlZDSRstSkNnK9zRiwVfS3ZVio9qTYWUyn50RFhlsQd0gV70L
         E3BfX7UKZSqNPiBvcVnAOX5GPgxmhLj7uvhdOnuR3gKwjpc8NN4kqAlqDF2cm9pKLKYw
         2TaF367NZhPSNMokEQ671qjY7su1yXvqXWxjaaN6c3Einxcv6WTJ81cuOoIJjDAIUEH5
         /489ThGZv5wmKsNFipzQ+m24F4CN42bfEFwwNjlTln+v0kR/aLZz6mrDaM9Yedemdx4B
         Xf02bppjBh/mLA4+yV9D7qP8TaAVOmKqaQKjVT56vbEH4+zyJLNNLtxGUJbFmRMD/LVp
         mYXg==
X-Gm-Message-State: AOAM530FOkk9jLEF/Pm68q3XB88Nk33WvCq+M9OwXyMvaweYW++se8ja
        OW4evURIy73M1RMH0pCkspId9A==
X-Google-Smtp-Source: ABdhPJwqSaOsLZyQqkMB/0If2mEpHTdwvfZzVbmqM3znH/E1rW86PdBpDy/VxxFUeSx5IPxCjrUDtQ==
X-Received: by 2002:aa7:9a95:0:b029:1f3:4169:ccf2 with SMTP id w21-20020aa79a950000b02901f34169ccf2mr253943pfi.14.1616534353979;
        Tue, 23 Mar 2021 14:19:13 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id r10sm114257pfq.216.2021.03.23.14.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 14:19:13 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:19:11 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] remoteproc: stm32: add capability to detach
Message-ID: <20210323211911.GA1714890@xps15>
References: <20210322092651.7381-1-arnaud.pouliquen@foss.st.com>
 <20210322092651.7381-3-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322092651.7381-3-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Arnaud,

On Mon, Mar 22, 2021 at 10:26:51AM +0100, Arnaud Pouliquen wrote:
> From: Arnaud Pouliquen <arnaud.pouliquen@foss-st.com>
> 
> A mechanism similar to the shutdown mailbox signal is implemented to
> detach a remote processor.
> 
> Upon detachment, a signal is sent to the remote firmware, allowing it
> to perform specific actions such as stopping RPMsg communication.
> 
> The Cortex-M hold boot is also disabled to allow the remote processor
> to restart in case of crash.
> 
> Notice that for this feature to be supported, the remote firmware
> resource table must be stored at the beginning of a 1kB section
> (default size provided to the remoteproc core).
> 
> This restriction should be lifted in the future by using a backup
> register to store the actual size of the resource table.

I'm not sure the above two paragraphs add anything valuable to the changelog.
At this time the size of 1kB is fixed and future enhancement are, well, in the
future.  So for now this patch is working with the rest of the current
environment and that is the important part.

> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss-st.com>
> ---
>  drivers/remoteproc/stm32_rproc.c | 38 ++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 3d45f51de4d0..298ef5b19e27 100644
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
> @@ -597,7 +626,11 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
>  	}
>  
>  done:
> -	/* Assuming the resource table fits in 1kB is fair */
> +	/*
> +	 * Assuming the resource table fits in 1kB is fair.
> +	 * Notice for the detach, that this 1 kB memory area has to be reserved in the coprocessor
> +	 * firmware for the resource table. A clean of this whole area is done on detach.
> +	 */

Can you rework the last sentence?  I'm not sure if it means the M4 will clean
the resource table or if that should be the application processor... I'm also
not clear on what you mean by "clean".  Usually it means zero'ing out but in
this case it means a re-initialisation of the original values.


>  	*table_sz = RSC_TBL_SIZE;
>  	return (struct resource_table *)ddata->rsc_va;
>  }
> @@ -607,6 +640,7 @@ static const struct rproc_ops st_rproc_ops = {
>  	.start		= stm32_rproc_start,
>  	.stop		= stm32_rproc_stop,
>  	.attach		= stm32_rproc_attach,
> +	.detach		= stm32_rproc_detach,

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	.kick		= stm32_rproc_kick,
>  	.load		= rproc_elf_load_segments,
>  	.parse_fw	= stm32_rproc_parse_fw,
> -- 
> 2.17.1
> 
