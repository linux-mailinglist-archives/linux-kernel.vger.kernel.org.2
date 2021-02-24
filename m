Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEB9323A33
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhBXKJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbhBXKJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:09:42 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE04C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 02:09:01 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t25so1144262pga.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 02:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uPXscLcyfyVsxrnqs2HdXqHqNGoSBPkUbecbeKUJjeI=;
        b=tjr8mdhSTEeRax/w3lp/cQ3BlpgZ/vQPpztFtgfuxFGf73HHgjv9geXTs10Ly8iz2q
         a6bAHW8LpfYIF+dbPI5cewfRLW4F0jPI4R/he25kZEBnerNVGpYsm2WhZK89/80EAV3i
         W0gg5xKX+acyNiBNBPwaOzhoDWSP6cmE9PPITQQdlMV0/ypv+DqlB/0ia7ynf6hQpc8Q
         d7iqNxLwr+3oOr2gVyVibPdSyFj6NsoYoHvj1lUITzbHjgzdf/CfwoYsUrYAk2QT6vkv
         ebvA68uFL/xI5i7veQqkzJyCMfqe/PU+GpDa5hLXhXWFehouBTnWeqF0Fuux9yn41nMZ
         5VvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uPXscLcyfyVsxrnqs2HdXqHqNGoSBPkUbecbeKUJjeI=;
        b=MzgiGyNRUzHyz4mBaE0bCAec4yfdA9G/gpcqont0PunK9dySlg3v9Q4UnZyeT24E4R
         XULQ4PRDYH7h2gt/79at0ykbSd/ezD3rZ6MAZB6uNA2B5ZnVfyGXIiyeaRe1Xaz06kJq
         jNLapWJt0qq6tzzuUlmSAJtT9Yv0HynEQWTsjjZ8hSPVc830z/z5ZKsQKV6+TauS7Tc0
         y8g1zcrdMHsPjxBlIxoeL2ca1Dqcf4gyYy14qqyH42y9ECKpvdcYvt+5C5X1vKHsj2Ex
         O57C1h7gjKfK1yHSdq9OADpadHz5wLz+koySJnPzeYZ7k7+1WL/SMrPydCDj9Gc6XbDy
         N6wg==
X-Gm-Message-State: AOAM532BK9pk23rFMExcmpU0k6UWnWv5h9EyWb+/4o+uXJ5seC0B38gE
        eKD5+Gulk61eWHs1RVPFzRvJ
X-Google-Smtp-Source: ABdhPJzw+6I5tNyEFnzM+xgiEabq2OQxcTX7cKAEVu5R/jvJAFbCqPriYxQeiguWiblQMGnBo+roRw==
X-Received: by 2002:a63:225d:: with SMTP id t29mr3577234pgm.318.1614161341173;
        Wed, 24 Feb 2021 02:09:01 -0800 (PST)
Received: from work ([103.66.79.25])
        by smtp.gmail.com with ESMTPSA id 4sm2364794pjc.23.2021.02.24.02.08.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Feb 2021 02:09:00 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:38:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v6 7/8] bus: mhi: Improve documentation on channel
 transfer setup APIs
Message-ID: <20210224100857.GU27945@work>
References: <1612470486-10440-1-git-send-email-bbhatt@codeaurora.org>
 <1612470486-10440-8-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612470486-10440-8-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 12:28:05PM -0800, Bhaumik Bhatt wrote:
> The mhi_prepare_for_transfer() and mhi_unprepare_from_transfer()
> APIs could use better explanation. Add details on what MHI does
> when these APIs are used.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  include/linux/mhi.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index d26acc8..56c4c52 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -712,13 +712,27 @@ int mhi_device_get_sync(struct mhi_device *mhi_dev);
>  void mhi_device_put(struct mhi_device *mhi_dev);
>  
>  /**
> - * mhi_prepare_for_transfer - Setup channel for data transfer
> + * mhi_prepare_for_transfer - Setup UL and DL channels for data transfer.
> + *                            Allocate and initialize the channel context and
> + *                            also issue the START channel command to both
> + *                            channels. Channels can be started only if both
> + *                            host and device execution environments match and
> + *                            channels are in a DISABLED state.
>   * @mhi_dev: Device associated with the channels
>   */
>  int mhi_prepare_for_transfer(struct mhi_device *mhi_dev);
>  
>  /**
> - * mhi_unprepare_from_transfer - Unprepare the channels
> + * mhi_unprepare_from_transfer - Reset UL and DL channels for data transfer.
> + *                               Issue the RESET channel command and let the
> + *                               device clean-up the context so no incoming
> + *                               transfers are seen on the host. Free memory
> + *                               associated with the context on host. If device
> + *                               is unresponsive, only perform a host side
> + *                               clean-up. Channels can be reset only if both
> + *                               host and device execution environments match
> + *                               and channels are in an ENABLED, STOPPED or
> + *                               SUSPENDED state.
>   * @mhi_dev: Device associated with the channels
>   */
>  void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
