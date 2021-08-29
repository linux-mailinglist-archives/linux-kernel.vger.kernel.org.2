Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0413FAC3C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhH2O3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 10:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhH2O3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 10:29:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1143C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 07:28:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 2so10067712pfo.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qOZleRD8pCzJyM10JVouBjLRKaJx/Dr3UENRm/FbtnA=;
        b=BS30odEtgM4ZIUyd4SzRHypP8CAs70ZQrHf2PcAgQD2VuIRE9quIVFx90p9n6sKa1l
         or1b+3yNRrflvFOaUeCAybNZl/Bgtdvtb2nM8pguUN73BzH7o+boz9KRE79dDhfXxOre
         82Zr7sILiq6lP426960l550AEwRqr2NoXD5LazSPlVCoPwrteLkxVmyjRY7gR6B9MbEq
         UIzVXHU1II8/F11M2E4cGgqr8IK9Omnww7NXpwThFqimZPcyleW2/58iXvAdqsZDNtWT
         o7G8HEgi5q3dWh5MEAlgrH9c3c0/HuqAFKNFdotSJTgRr6rkVyXkpX2aH5rwuTYiwxB9
         o/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qOZleRD8pCzJyM10JVouBjLRKaJx/Dr3UENRm/FbtnA=;
        b=hBTs4eFn8LX7xZ/xxdr1qwrvl+5xzPjTksC6VoCYXwulGQ01eh1QJhVQORo0D8J8uO
         0jXO1epM+JSlbMk2PeQmQMcHv4mR5pOTLmVWfulwpE//CJgbb+Csuj3QJHqBAiEXh1kz
         2MIdJ4CYrIezFmpz28FeJsl5zBzcv3Po4VACerokC7LMr3LwVPt2LFJWCcJKE+Q3MiWg
         +wyQ4q8hiWALcf8IhVlSbQ/B/WCyoOVGrofrEe6lFyySOL4NNUquVM4AnGLGa0sGjmpM
         Rt7V2FBBN/tOjcnwNTU5ySAl4J4lt9wK97KYIaoFC1jDZwZb+ZZ2kUbf96AuDpPOLQx7
         RWoA==
X-Gm-Message-State: AOAM530u436XSP8TUzTnti9su9bLqr3Mqa22YmmOnmdgrb/8Fkp0gDl5
        7GC9IP11xj8xvT6+TsaAMYcgBQ==
X-Google-Smtp-Source: ABdhPJwizvyf802+JtqxkB4pHwYNMDzQeajZ0wsosunlo6KatX/rEBVWDJmbeJ5Ldm6grKGeh2+ubA==
X-Received: by 2002:a65:6487:: with SMTP id e7mr17088629pgv.27.1630247288979;
        Sun, 29 Aug 2021 07:28:08 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id t28sm12818428pfe.144.2021.08.29.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 07:28:08 -0700 (PDT)
Date:   Sun, 29 Aug 2021 22:28:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
Subject: Re: [PATCH] coresight: cti: Correct the parameter for pm_runtime_put
Message-ID: <20210829142802.GA186881@leoy-ThinkPad-X240s>
References: <1629365377-5937-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629365377-5937-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

On Thu, Aug 19, 2021 at 05:29:37PM +0800, Tao Zhang wrote:
> The input parameter of the function pm_runtime_put should be the
> same in the function cti_enable_hw and cti_disable_hw. The correct
> parameter to use here should be dev->parent.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>  drivers/hwtracing/coresight/coresight-cti-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index e2a3620..8988b2e 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -175,7 +175,7 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
>  	coresight_disclaim_device_unlocked(csdev);
>  	CS_LOCK(drvdata->base);
>  	spin_unlock(&drvdata->spinlock);
> -	pm_runtime_put(dev);
> +	pm_runtime_put(dev->parent);

coresight_register() allocates data structure 'coresight_device' and
assigns probed device to the field 'coresight_device::dev::parent';
thus afterwards we need to pass 'coresight_device::dev::parent' for
pm_runtime_xxx() functions.  It's not directive for understanding, so
log the info at here.

For the patch:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

We could wait for Mike to review as well.

Thanks,
Leo

>  	return 0;
>  
>  	/* not disabled this call */
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
