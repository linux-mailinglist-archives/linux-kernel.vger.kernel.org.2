Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C6B355FB1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 01:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344682AbhDFXr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 19:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241342AbhDFXr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 19:47:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E577CC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 16:47:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m11so8966991pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 16:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w1w9BnWr6erKI9BR6dcUfTmLNzR1DW7N43lvKpHfkLY=;
        b=YmUtDS+FvlpKx8GfAnfcDAH4SCyYkR6b9/3znDUQPxrKdM7pbBoejpN8ZK6k1RNfvC
         n8y8phsZcskCEJ5tMBcvDerxleTnKGI4gEDxup3OZMeMDjCUDC5NykN0+EZcB4TByDDx
         6s9rwAgHsLIzJn/iumqMwZNlW/UTSEIUFEpOkCh/qv2mmSZKccu7YBdQov9lz6TrtwgT
         FzE6YqDym3tY6/VLaX5tInER8x5sTeXCe2qsuMJfQWaVexkHT6j5tgvGcqpsckj8rY6M
         UuU8QwfBf7IPTlYUx7xiA9WRgaHYSCnq0FuXPxIKh+fLsj0ibm9rO/5LuKNJA0J8ILrs
         SZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w1w9BnWr6erKI9BR6dcUfTmLNzR1DW7N43lvKpHfkLY=;
        b=mm4DWzv9yg/m8vRLPvIy8lpxqBX+hmbB0bFxMRFs7FRm85amEGC4LXI560wk9Zy3zp
         eQj9SS4UVs2RzjDpOlNo+odhCijmGEA7ALP2Cwn1xvBMeXFTQaNBV8kspRsXgyYuuks8
         jKft85YMjg2c4QU5fFx+VpzaRIm4rzDphycuKC48xZhgQSI5KhjewS2qfNgAfaH6WE1O
         bfrZdtHOgNtD358MKNomxkDyIYdsLh/yjcEBC3XYEqRFj4idVbFkndHQl6I0xcGLxy4D
         LOwcipHOYVgooPYQaMbhfIsw2+LRwUxiauD4UbBVx6Lvs84BD4UBv9fmcZgqOLzEIruI
         SWCA==
X-Gm-Message-State: AOAM533o74tAFhhm7QVEPtkzoWA4DhhzWjoe75xufGGfbyeU8ae7ipbZ
        PopspBb3q2UI/11XkE/s7lugGw==
X-Google-Smtp-Source: ABdhPJwVIMUI8S6uyHBJXA3K51BGuSoFVKynLjQHNLQgpXZUCpY/GWcjWxHT7PypLRpC88L/Q8MS2A==
X-Received: by 2002:a05:6a00:b86:b029:207:8ac9:85de with SMTP id g6-20020a056a000b86b02902078ac985demr466853pfj.66.1617752870275;
        Tue, 06 Apr 2021 16:47:50 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id n52sm435888pfv.13.2021.04.06.16.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 16:47:49 -0700 (PDT)
Date:   Tue, 6 Apr 2021 17:47:47 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] remoteproc: pru: Fix and cleanup firmware interrupt
 mapping logic
Message-ID: <20210406234747.GC330882@xps15>
References: <20210323223839.17464-1-s-anna@ti.com>
 <20210323223839.17464-4-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323223839.17464-4-s-anna@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 05:38:39PM -0500, Suman Anna wrote:
> The PRU firmware interrupt mappings are configured and unconfigured in
> .start() and .stop() callbacks respectively using the variables 'evt_count'
> and a 'mapped_irq' pointer. These variables are modified only during these
> callbacks but are not re-initialized/reset properly during unwind or
> failure paths. These stale values caused a kernel crash while stopping a
> PRU remoteproc running a different firmware with no events on a subsequent
> run after a previous run that was running a firmware with events.
> 
> Fix this crash by ensuring that the evt_count is 0 and the mapped_irq
> pointer is set to NULL in pru_dispose_irq_mapping(). Also, reset these
> variables properly during any failures in the .start() callback. While
> at this, the pru_dispose_irq_mapping() callsites are all made to look
> the same, moving any conditional logic to inside the function.
> 
> Fixes: c75c9fdac66e ("remoteproc: pru: Add support for PRU specific interrupt configuration")
> Reported-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/remoteproc/pru_rproc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 87b43976c51b..5df19acb90ed 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -266,12 +266,17 @@ static void pru_rproc_create_debug_entries(struct rproc *rproc)
>  
>  static void pru_dispose_irq_mapping(struct pru_rproc *pru)
>  {
> -	while (pru->evt_count--) {
> +	if (!pru->mapped_irq)
> +		return;
> +
> +	while (pru->evt_count) {
> +		pru->evt_count--;
>  		if (pru->mapped_irq[pru->evt_count] > 0)
>  			irq_dispose_mapping(pru->mapped_irq[pru->evt_count]);
>  	}
>  
>  	kfree(pru->mapped_irq);
> +	pru->mapped_irq = NULL;
>  }
>  
>  /*
> @@ -324,6 +329,8 @@ static int pru_handle_intrmap(struct rproc *rproc)
>  	of_node_put(parent);
>  	if (!irq_parent) {
>  		kfree(pru->mapped_irq);
> +		pru->mapped_irq = NULL;
> +		pru->evt_count = 0;

Patch 1/3 introduced a check on @parent that doesn't free pru->mapped_irq.  I
would also expect that error path to do the same has what is done here.  And
looking further up I see the error path for !pru->mapped_irq doesn't set
pru->evt_count to zero.

Thanks,
Mathieu

>  		return -ENODEV;
>  	}
>  
> @@ -398,8 +405,7 @@ static int pru_rproc_stop(struct rproc *rproc)
>  	pru_control_write_reg(pru, PRU_CTRL_CTRL, val);
>  
>  	/* dispose irq mapping - new firmware can provide new mapping */
> -	if (pru->mapped_irq)
> -		pru_dispose_irq_mapping(pru);
> +	pru_dispose_irq_mapping(pru);
>  
>  	return 0;
>  }
> -- 
> 2.30.1
> 
