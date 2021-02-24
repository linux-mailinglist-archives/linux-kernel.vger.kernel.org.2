Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6695C32396B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhBXJ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbhBXJ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:28:15 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CFEC061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:27:34 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e9so852933plh.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9CHIGqRTR4CpVrwPax1Th8sgFV6l7EPgJLkKjNdxhIk=;
        b=xsTA71e4zW4V1lpQyWlmtLwY1axG6YSbNhcPe2bGmyO3GjI0QwMmhQU3a2Fm7blPzM
         zBwPVVS7fihzrB7QcRo+iLgJd8QjBiKkTfJ2cMTcar0mDnOOyWaJvKo8uYNRatn5gowz
         x5KGo9j79hTUywutzBUFuADUAJklwqwgr8nP4Ea8SoAxsLvMaeVY3wprsYfO+Y0JP6qz
         CEvEwQPzwqNjj66qm+6TTnd2B9VQh6aMG3YKI2TiZ1qJLlSwwYaYxpRcizl25a20hbPx
         mU0DxYpgbphfVXMOOawDQ9G73F8SGXHOU+BkFUs9Gs4Ij0B7/LnVkyzKOujKUGbrPZBQ
         fZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9CHIGqRTR4CpVrwPax1Th8sgFV6l7EPgJLkKjNdxhIk=;
        b=oi1eonLJygXsR6jY9ritL9sAK+kXsoTfxvgggbdkT2moWMsEx/aPaOfsZ1yt+eO4R4
         PMlnFFycDBvGllolJEQb7ijzSNNkdTiP32T9WZEEz3pRkSJ6gLz1ctX8NtndW1ojFjq4
         aeF47jqLetN9idS2pAMTzH/fML8fjCsSLSp2xPcqpsPmktO41ZyGuOQw/UKkEvpRTzB/
         lZyiopX8bBy84wp5ydObcdQ6shuz/p3+YhfV8QBG4fwrEoW8ggCMfkHYM/Lojp7IXADV
         nLfalqlZekOZHHwTLAFsvVjZBAy/GHgiRgVi89BeDjw5USVIrMd9LAfdllvrC5XgOtyA
         DGVQ==
X-Gm-Message-State: AOAM533ZP3usQb1rjoVar0aR4iYNlMJMIAxxARD9SzMENyY7mFJZ4qef
        H5clgS7gdQNxSU9tsRJJaV0J
X-Google-Smtp-Source: ABdhPJyQklV/tRNBeP6QeXncSIa5VmyhQnE5PJ3KwX7RX74+N32c1t1kXu2c7QocDTB/U3U54SSepg==
X-Received: by 2002:a17:902:d4cd:b029:e4:1abc:37e3 with SMTP id o13-20020a170902d4cdb02900e41abc37e3mr6873973plg.29.1614158854279;
        Wed, 24 Feb 2021 01:27:34 -0800 (PST)
Received: from work ([103.66.79.25])
        by smtp.gmail.com with ESMTPSA id w2sm1879246pgh.54.2021.02.24.01.27.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Feb 2021 01:27:33 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:57:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, carl.yin@quectel.com,
        naveen.kumar@quectel.com
Subject: Re: [PATCH v3 0/3] Polling for MHI ready
Message-ID: <20210224092729.GM27945@work>
References: <1614138270-2374-1-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614138270-2374-1-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 07:44:27PM -0800, Bhaumik Bhatt wrote:
> v3:
> -Removed config changes that crept in in the first patch
> 
> v2:
> -Addressed review comments
> -Introduce new patch for to use controller defined read_reg() for polling
> -Add usage in RDDM download panic path as well
> 
> Use polling instead of interrupt driven approach to wait for MHI ready state.
> 
> In certain devices, it is likely that there is no incoming MHI
> interrupt for a transition to MHI READY state. One such example
> is the move from Pass Through to an SBL or AMSS execution
> environment. In order to facilitate faster bootup times as there
> is no need to wait until timeout_ms completes, MHI host can poll
> every 25 milliseconds to check if device has entered MHI READY
> until a maximum timeout of twice the timeout_ms is reached.
> 
> This patch series has been tested on an arm64 device.
> 

So this is a spinoff from "Execution environment updates from MHI"?
Please mention it in the cover letter and which one is the latest.

Thanks,
Mani

> Bhaumik Bhatt (3):
>   bus: mhi: core: Introduce internal register poll helper function
>   bus: mhi: core: Move to polling method to wait for MHI ready
>   bus: mhi: core: Use poll register read API for RDDM download
> 
>  drivers/bus/mhi/core/boot.c     | 20 ++++++--------------
>  drivers/bus/mhi/core/internal.h |  3 +++
>  drivers/bus/mhi/core/main.c     | 23 +++++++++++++++++++++++
>  drivers/bus/mhi/core/pm.c       | 31 ++++++++++++++-----------------
>  4 files changed, 46 insertions(+), 31 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
