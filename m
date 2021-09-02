Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB93FF22B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346546AbhIBRUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242982AbhIBRUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:20:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B54C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:19:01 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m26so2190354pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=necS4VUpe4t7hOX5NZ6mXxMU8h8wBvfjay7U9C07eQQ=;
        b=VJLDdqzk3qgXNuXYDr1ZSorcfVQ3xeVIK8eVgKzfW+ov5t5VVcrbXTNquA/KMLDwsK
         q9GrsDuRDs/GxmQh0UrshO6ONiRcJOm0gUfRD28EBJL6JiifFpJLolnUhUGtFVkJdD0C
         0GTeHI0FgfIZ8p4ITsXEZRNdnYBhTULje1nDYYgfMUxSL/zo/oJxDogSBZ6UtNt1E7q+
         TmBwv8q+RubCc5JZKskX2ukB5Rb4u4zxFvP+bO9NN9aEn22197h7JlfIQW+Mp9xhoA2H
         1otIcgNe5u+u5r6+WWAq46kO0vVrBXz3VovtGj4wrAmQ8qtHLZX1jlI9VYF8hT742n9V
         7BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=necS4VUpe4t7hOX5NZ6mXxMU8h8wBvfjay7U9C07eQQ=;
        b=MSm+q8iyiBlLeTO2spmS+CUJ8fS34AvKK3lEqSYfwpTfmPAxkknBjI95BnSJzlEFoc
         0SsfxYmK1acme1cRr24b2fH3JQSnTV1c8DFl2ukoiyAix6uwkErEo3jdSBfAENfw3FOl
         QcbuekLPlkh3DsFIiJiWnTk3+L6Nh8olLiouFlL9Q6dpcsjZ9BOBCJODvYDa+ZsooTdn
         XvhhRb4u5p370CTqIBeK6bgLpzV1/9i170B/WJ/Wd/yTSvYHYxroA6JYG52B1OfBPFU5
         85IcvYu6yEEsfCmvqdKFxOnjyYCASjhdSQdsA+AH0UU8QWDdDaf9WqMNzX/QvP2ztBVC
         KxPQ==
X-Gm-Message-State: AOAM5328Fb/KPj86Et9LsnqewRZWzucyNG9oKzGyPlXQS7EQ1tsJ8jl4
        GWdlfIvGzs21/o7Ytn3Kfvhu3w==
X-Google-Smtp-Source: ABdhPJw6m0R3eeCOVwfyAds9HNp2lYE8IdVFXoztsykKcDM4eZDfaWpyCE+rO2hwcXIfstyHDVA7rg==
X-Received: by 2002:aa7:938c:0:b0:3b2:87fe:a598 with SMTP id t12-20020aa7938c000000b003b287fea598mr4258210pfe.74.1630603141401;
        Thu, 02 Sep 2021 10:19:01 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a11sm3083215pgj.75.2021.09.02.10.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 10:18:59 -0700 (PDT)
Date:   Thu, 2 Sep 2021 11:18:56 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
Subject: Re: [PATCH] coresight: cti: Correct the parameter for pm_runtime_put
Message-ID: <20210902171856.GA1078000@p14s>
References: <1629365377-5937-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629365377-5937-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

Apologies for the late reply - this patch fell through the cracks.

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

You are correct - I have added this patch to my next tree.

Thanks,
Mathieu

>  	return 0;
>  
>  	/* not disabled this call */
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
