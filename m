Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5BC323A37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhBXKLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbhBXKK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:10:58 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DE0C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 02:10:18 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n10so1123867pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 02:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9YJ3fv4DIhf+dmFK1cZYEzwZ16SjiP4XgJB2uFC+ykQ=;
        b=V4HYfIAbvVmSHyxKn/OqibLlvvjqMwmWrV0Xtsn0zjBlHXvjoxhNjVZOs5eFSeELl0
         QUH508yPSaJn3XAnJZHZ/58lNaM/W3sWBzVRH3Jr5Fq04E37sjXOqH4O850rbkRVlqeP
         w3B6DaJnzaPjN3KNfm1+CpvbY8jobN7jK6p7AYNtXbpYEP6+3foGvkRu+fy/VWg5FnX1
         k/iv+S0HDWp6yzzx9ji9NwCcjxn8J349cnjU6xPBAUfHkPbMzTu3UrJnw9GggmUkUbrw
         Wi2IpYO3BTRvGUVoupl9kE/9Ob5vpVQqrmrh9lueYFkUXgGFPddJs4nAC2hVnwNO2T1D
         8vXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9YJ3fv4DIhf+dmFK1cZYEzwZ16SjiP4XgJB2uFC+ykQ=;
        b=drADLUHeIN2t1Vs60t23scmd1YlHhsU4JNF3HzGu7dPfZVGXT0+d4Jhs2hw35E7/f0
         6Q8/IztMBFgQffSgo1MqatzUEiEhQ+VlE5lH28sJP9ATrXsVuCaqfYx6EroOo+287liv
         X90jSuv1o8v7eG0XSZFFylwWI3YaCKAwR8deuPKcCZ0D1RejSOySIp7F6HAoDG9dqsRw
         42f4vSeiz1745YuSkheZcr7JEHeiG/0MnX65BJDgRT2dHt+IfeYnG5InMoGf/pmT9erh
         BElgRbyxbJWr02eAWmp4JcfmmcAHW7Ffkp9T6sWkXR59AZwd4dHnKobWFfIUljcwOe+m
         TYgQ==
X-Gm-Message-State: AOAM531FMu2leGsjCxFSxE40s7logBvV2JYf1z9mQdVsRe0Qhzm23nyB
        TYNXYM462qH2CujXIAWrOkK4
X-Google-Smtp-Source: ABdhPJygjeXUmvxAXN3YsvU1B4V8sMnmhKEIypGCwt1MPEY151nIVcunis2SGNs8JvW7qcoikkbkbA==
X-Received: by 2002:aa7:9571:0:b029:1e6:5f49:24a0 with SMTP id x17-20020aa795710000b02901e65f4924a0mr30793401pfq.25.1614161417831;
        Wed, 24 Feb 2021 02:10:17 -0800 (PST)
Received: from work ([103.66.79.25])
        by smtp.gmail.com with ESMTPSA id b10sm1790911pgm.76.2021.02.24.02.10.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Feb 2021 02:10:17 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:40:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v6 8/8] bus: mhi: core: Do not clear channel context more
 than once
Message-ID: <20210224101013.GV27945@work>
References: <1612470486-10440-1-git-send-email-bbhatt@codeaurora.org>
 <1612470486-10440-9-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612470486-10440-9-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 12:28:06PM -0800, Bhaumik Bhatt wrote:
> Clearing a channel context can happen twice if the client driver
> unprepares and reset the channels from the remove() callback from
> a controller requested MHI power down sequence. If there are
> multiple attempts at calling the mhi_free_coherent() API, we see
> kernel warnings such as "trying to free invalid coherent area".
> Example for one such client is the QRTR MHI driver. Avoid these
> warnings by skipping mhi_deinit_chan_ctxt() API call and prevent
> extra work from MHI as the channels are already disabled.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Is this patch still valid? We merged a similar fix from Loic for v5.11.

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 30eef19..272f350 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -1314,6 +1314,7 @@ static int mhi_driver_remove(struct device *dev)
>  
>  		if ((ch_state[dir] == MHI_CH_STATE_ENABLED ||
>  		     ch_state[dir] == MHI_CH_STATE_STOP) &&
> +		    mhi_chan->ch_state != MHI_CH_STATE_DISABLED &&
>  		    !mhi_chan->offload_ch)
>  			mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
