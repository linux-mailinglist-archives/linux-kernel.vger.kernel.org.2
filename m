Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5419B398F91
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhFBQG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:06:57 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:40649 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFBQG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:06:56 -0400
Received: by mail-pf1-f169.google.com with SMTP id q25so2544255pfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XKxsJlne+LArk5awxmh1nwPa7SN5h9s/re93Xtt4ka8=;
        b=FjEfvrJD0PcwRixn9+ipYc2UVI2BVVXxHzEBpdpdib/cTv5yJ75wIJx+OrYoVpxajD
         wj2ZV3OQxeN8Ily3fsGw06aAiUR198DJqYG8plUdI8K6LKjkv1/qHgqmSxSvjh1UWK0k
         k9/x+DtgsGZ9BrtzsjvfIAoDHHEcn550Qs0pUuddetVdM8fXClwxuZzWD9fdbZALjHUr
         xAfvKcoYYg8i1UdPItt4lObs+J5rspbn9XCEXmwH/YynjaMQ1BxeVXzJNirYDqGu6x2y
         wCjDJVYA44ppLpbjwsY5H6PTzRYZCgIzA2aU+0I2PBrftmIxDK/eICpD3WtVJgFYjqu2
         g73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XKxsJlne+LArk5awxmh1nwPa7SN5h9s/re93Xtt4ka8=;
        b=o2AGiePe4OYt8h5NlaPLtWHyWx+t6f4eRFL+f7GWrclfQB9dS1vcOAi3oiGLnETQFV
         xzTlfIp7Eh+TqA+/gVBOBiaB9E7ggyUWcJzyMZsH2TF426G3DidPFaWXSOaQ8a3mlkVy
         oWgROoxQS1g2w+xTgJeKZP/DCp+0QQTBd7+hZhmJfwhRz9vMSk68PZaZUCo1TNbNF4AW
         pxSlQWHye74vFz8oxWaGuTvcGdzs1wz7z8Kh4Efksf47DHuJz1U+nZbD+B7BrnmR4bop
         lqqbFs+wmK1CwuWziMoHvzJtDW0lZVaq45yby2NOQgqB8uDrR7c2l867gaEXhG/dAUx0
         ZhjQ==
X-Gm-Message-State: AOAM530bMFqhuUTPOBRzrERGrfxiWKzp2gRGvfBkhaMtFIn++2dlddTh
        ePne+PHk+F3B4NAsMrb4eNSXBA==
X-Google-Smtp-Source: ABdhPJwMUb2pY+sg5TfsR33k8PDKyPC3ae62iZt5DGmYIGl1OkmztCpjP4ArzfBhi8o7V/STIGWjTA==
X-Received: by 2002:a05:6a00:c86:b029:2e9:3041:162f with SMTP id a6-20020a056a000c86b02902e93041162fmr27619121pfv.78.1622649853558;
        Wed, 02 Jun 2021 09:04:13 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c130sm103715pfc.51.2021.06.02.09.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 09:04:12 -0700 (PDT)
Date:   Wed, 2 Jun 2021 10:04:10 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] remoteproc: k3-dsp: Refactor mbox request code in
 start
Message-ID: <20210602160410.GA1797307@xps15>
References: <20210522000309.26134-1-s-anna@ti.com>
 <20210522000309.26134-6-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522000309.26134-6-s-anna@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 07:03:08PM -0500, Suman Anna wrote:
> Refactor out the mailbox request and associated ping logic code
> from k3_dsp_rproc_start() function into its own separate function
> so that it can be re-used in the soon to be added .attach() ops
> callback.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c | 65 ++++++++++++++---------
>  1 file changed, 39 insertions(+), 26 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> index fd4eb67a6681..faf60a274e8d 100644
> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> @@ -216,6 +216,43 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
>  	return ret;
>  }
>  
> +static int k3_dsp_rproc_request_mbox(struct rproc *rproc)
> +{
> +	struct k3_dsp_rproc *kproc = rproc->priv;
> +	struct mbox_client *client = &kproc->client;
> +	struct device *dev = kproc->dev;
> +	int ret;
> +
> +	client->dev = dev;
> +	client->tx_done = NULL;
> +	client->rx_callback = k3_dsp_rproc_mbox_callback;
> +	client->tx_block = false;
> +	client->knows_txdone = false;
> +
> +	kproc->mbox = mbox_request_channel(client, 0);
> +	if (IS_ERR(kproc->mbox)) {
> +		ret = -EBUSY;
> +		dev_err(dev, "mbox_request_channel failed: %ld\n",
> +			PTR_ERR(kproc->mbox));
> +		return ret;
> +	}
> +
> +	/*
> +	 * Ping the remote processor, this is only for sanity-sake for now;
> +	 * there is no functional effect whatsoever.
> +	 *
> +	 * Note that the reply will _not_ arrive immediately: this message
> +	 * will wait in the mailbox fifo until the remote processor is booted.
> +	 */
> +	ret = mbox_send_message(kproc->mbox, (void *)RP_MBOX_ECHO_REQUEST);
> +	if (ret < 0) {
> +		dev_err(dev, "mbox_send_message failed: %d\n", ret);
> +		mbox_free_channel(kproc->mbox);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
>  /*
>   * The C66x DSP cores have a local reset that affects only the CPU, and a
>   * generic module reset that powers on the device and allows the DSP internal
> @@ -273,37 +310,13 @@ static int k3_dsp_rproc_unprepare(struct rproc *rproc)
>  static int k3_dsp_rproc_start(struct rproc *rproc)
>  {
>  	struct k3_dsp_rproc *kproc = rproc->priv;
> -	struct mbox_client *client = &kproc->client;
>  	struct device *dev = kproc->dev;
>  	u32 boot_addr;
>  	int ret;
>  
> -	client->dev = dev;
> -	client->tx_done = NULL;
> -	client->rx_callback = k3_dsp_rproc_mbox_callback;
> -	client->tx_block = false;
> -	client->knows_txdone = false;
> -
> -	kproc->mbox = mbox_request_channel(client, 0);
> -	if (IS_ERR(kproc->mbox)) {
> -		ret = -EBUSY;
> -		dev_err(dev, "mbox_request_channel failed: %ld\n",
> -			PTR_ERR(kproc->mbox));
> +	ret = k3_dsp_rproc_request_mbox(rproc);
> +	if (ret)
>  		return ret;
> -	}
> -
> -	/*
> -	 * Ping the remote processor, this is only for sanity-sake for now;
> -	 * there is no functional effect whatsoever.
> -	 *
> -	 * Note that the reply will _not_ arrive immediately: this message
> -	 * will wait in the mailbox fifo until the remote processor is booted.
> -	 */
> -	ret = mbox_send_message(kproc->mbox, (void *)RP_MBOX_ECHO_REQUEST);
> -	if (ret < 0) {
> -		dev_err(dev, "mbox_send_message failed: %d\n", ret);
> -		goto put_mbox;
> -	}
>  
>  	boot_addr = rproc->bootaddr;
>  	if (boot_addr & (kproc->data->boot_align_addr - 1)) {
> -- 
> 2.30.1
> 
