Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9831541B4A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbhI1RDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 13:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbhI1RDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:03:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DADFC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:01:40 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j15so13196602plh.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ye3IGx3xsyiPYn6ctob/HWeGLeGpvxCIcL+FYuNuPPA=;
        b=LGQz2aR5Qglk96plkagtj2jQh2a0LjCDeJKbwVlhTkR+X4SZycmVFCQ16wFqIEoo7S
         wOpaf6R3zbpNIrRLUbPwbem98y/KI2Lth8RrWz0g4tSiqSOij+8lJayubzpFlK+Q5yWB
         APLw+AedWNLKwUbdHhgoDGscHvnndefjbPP6VJa0k51MMOGYgFv4tYhCP/d3SVPfDFBI
         FToUIQdpPMwgcleakt5ZCgWRHC8LXadHnJMuaoi8FbvAmQxkZsNqlqAVpdlRVN+89Aur
         2aEZbQksiVegP1yquNZ2Viivj61WJ5yv0KRrZNMm1iXq22XaIR5ok9COAaPGTFOdJXq5
         Pp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ye3IGx3xsyiPYn6ctob/HWeGLeGpvxCIcL+FYuNuPPA=;
        b=IgUCLhin1y0zchzmoui5C2Tm5kdWI38Z3hwQTcnsVSu9l56WykNH7IrqfiY6SvaQhA
         7YzzbCMR9d8HCWezQwLPyukqbLkCyL0bao3pfEcLlrU48QAcj2KsqaV6NyK0DMTM6ClT
         RwUbcGI2CQm116oYppGepy2qQZehwobtt21okhCkxDTrkwCWTYIgZBHiEv043a1qw4zq
         ty4EsDviWFpWKzALaqrH89j0qDMdM5LSeMPknCTPPynNJSpO2bHFMgY065Ii01h90V7q
         CVYhauu4xKo2wlxOfe9pLMgcwl2x1hr7ENy1o8u1Nycplz5PJTi/+sxRFMepeI1wldYF
         vC+Q==
X-Gm-Message-State: AOAM530m/OLnul/kKvNrn2htWs+t3MMvkw3UajKBpk12VcKGq9Wf9bRS
        GY7d1R6Jgkd+sE1scy2U7CX7tw==
X-Google-Smtp-Source: ABdhPJwRg03fFzrBFDgTkieTJe+NXE4t/k9GhJlIoLPzBuFj0laLtbEAiVbUsTkeZAai4w90EtAZFQ==
X-Received: by 2002:a17:903:1d2:b0:13d:c967:c14 with SMTP id e18-20020a17090301d200b0013dc9670c14mr5648919plh.52.1632848498155;
        Tue, 28 Sep 2021 10:01:38 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w1sm3043595pjy.49.2021.09.28.10.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 10:01:36 -0700 (PDT)
Date:   Tue, 28 Sep 2021 11:01:30 -0600
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
Subject: Re: [PATCH] coresight: etm4x: avoid build failure with unrolled loops
Message-ID: <20210928170130.GA2918258@p14s>
References: <1632652550-26048-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632652550-26048-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

On Sun, Sep 26, 2021 at 06:35:50PM +0800, Tao Zhang wrote:
> clang-12 fails to build the etm4x driver with -fsanitize=array-bounds,
> where it decides to unroll certain loops in a way that result in a
> C variable getting put into an inline assembly.
> 
> Search this build failure and find this is a known issue and there
> has been a mail thread discussing it.
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210429145752.3218324-1-arnd@kernel.org/
> According to the modification suggestions of this mail thread,
> coresight infrastucture has already provided another API that
> can replace the function that caused the error.
> 
> Used here "csdev_access_read32" to replace the original API
> "etm4x_relaxed_read32".
> 
> This patch applies to coresight/next
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index f58afbab6e6d..0bca8e2be070 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -797,7 +797,7 @@ static void etm4_disable_hw(void *info)
>  	/* read back the current counter values */
>  	for (i = 0; i < drvdata->nr_cntr; i++) {
>  		config->cntr_val[i] =
> -			etm4x_relaxed_read32(csa, TRCCNTVRn(i));
> +			csdev_access_read32(csa, TRCCNTVRn(i));

It seems like the patch you are referencing above was never applied...  So the
question is, how is it that only this instance is giving you trouble when there
are many more instances of the same pattern in the file?

Thanks,
Mathieu

>  	}
>  
>  	coresight_disclaim_device_unlocked(csdev);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
