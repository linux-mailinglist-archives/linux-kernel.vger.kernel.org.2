Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FD234FF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhCaLZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbhCaLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:24:19 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8468FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:24:09 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v10so13968853pgs.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sJBaCHwwIuvtPkiNIiI44cG7FfU3ForiEr6IkmHZGUA=;
        b=FUCoXc+xa03mNs8QiV77/Vvcp94qGkwKJICyMNwfKrNKZdC7Nbp3cSKX3nZJhUWbvS
         VH7IQrHaSxYqbkr9/HGzDZWAImxkQsTNuZBauEUZwwohdbhAZw2RDWnmGetzSzAewopi
         P2+OEVe3dCboKX8MwJ7wg0TEdHRuESbD8c/kR0IYEwzZui1Jojsk62BQ3oFQh7w4Unij
         KuObXu1+A+IPvGhcmjzPow9MlFkxwwIa6R7VKWLkFztyGaB3CMOiUL0b1ID2H66LWqNO
         h0TkK8ZEpu9FGafCwLwWxLC99ceBkNkuibWRntUhePkh4tiIanbs0BPjpZ5rngrWiyLE
         WHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sJBaCHwwIuvtPkiNIiI44cG7FfU3ForiEr6IkmHZGUA=;
        b=Z2h0bWazT5lfVQ9TAyexRL+2gCUITQXrUwFFO/DTasi89FmI8yk5ly+QEwi0aWzGVf
         si3v5xsZIDFTa2ee5VI3MkmDMkZJ6kvZdcPtblmESGEZvt1tbAym99iN0Lj29dTGmOeU
         wV2TOivieTDKWrkQqG3Sbcocu8ngHF62odretQEda4fVD73g1xwydrtT6SRnkprAuZdq
         p8E0o2xMxpsHLF2aNVw/lXz9cnzUjKxC1uj0zuNDapl/cYbPG8lIoXH1J51ymewlm5HS
         ON2hZ1Jvd8ussa01QntpyqxbVLp94BvQHFPy9nmDhden01E+hn76yeI6TflVvRLKq7w3
         gUZA==
X-Gm-Message-State: AOAM531noz3sFQLri6jRlvR1kWHUnxXIjodFSEzc8bBX/yguivL3Qal2
        mbHVSXnf4e4x2gl+Oh0Y61Li
X-Google-Smtp-Source: ABdhPJzr2k3zeeARoVMh7VMjADub05kwf4UnlJAfpGS5drrVveiOb4csqKWwpEKz8SPvgdG7GhvzHA==
X-Received: by 2002:a62:3847:0:b029:202:ad05:4476 with SMTP id f68-20020a6238470000b0290202ad054476mr2437271pfa.67.1617189848843;
        Wed, 31 Mar 2021 04:24:08 -0700 (PDT)
Received: from work ([103.77.37.129])
        by smtp.gmail.com with ESMTPSA id t1sm2140094pfc.173.2021.03.31.04.24.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Mar 2021 04:24:08 -0700 (PDT)
Date:   Wed, 31 Mar 2021 16:54:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org, abickett@codeaurora.org
Subject: Re: [PATCH v1 0/7] MHI Emergency download and flash programmer
 support
Message-ID: <20210331112404.GF15610@work>
References: <1617067704-28850-1-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617067704-28850-1-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 06:28:17PM -0700, Bhaumik Bhatt wrote:
> Allow handling EDL mode after SYS_ERROR occurs by reading the execution
> environment post handling and move to power on reset state to accommodate the
> scenario.
> Handle EDL mode properly and wait for ready instead of just exiting from the
> firmware load.
> Allow use of the Flash Programmer execution environment as a mission mode
> use case for a blank NAND power up scenario.
> Always attempt a wait for MHI ready state as device could be waiting for the
> host to do so after pass through execution environment is seen.
> Introduce patch to improve state awareness and aid in debugging.
> 
> This patch series was tested on x86_64 architecture.
> 

Applied to mhi-next!

Thanks,
Mani

> Bhaumik Bhatt (6):
>   bus: mhi: core: Rely on accurate method to determine EDL mode
>   bus: mhi: core: Wait for ready after an EDL firmware download
>   bus: mhi: core: Handle EDL mode entry appropriately
>   bus: mhi: core: Identify Flash Programmer as a mission mode use case
>   bus: mhi: core: Wait for MHI READY state in most scenarios
>   bus: mhi: core: Improve state strings for debug messages
> 
> Carl Yin (1):
>   bus: mhi: core: Add support for Flash Programmer execution environment
> 
>  drivers/bus/mhi/core/boot.c     | 13 +++++++------
>  drivers/bus/mhi/core/init.c     | 34 ++++++++++++++++++----------------
>  drivers/bus/mhi/core/internal.h |  4 +++-
>  drivers/bus/mhi/core/main.c     |  3 +++
>  drivers/bus/mhi/core/pm.c       | 28 +++++++++++++++++++++++++---
>  include/linux/mhi.h             |  4 +++-
>  6 files changed, 59 insertions(+), 27 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
