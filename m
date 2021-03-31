Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7887B34FF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhCaLRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhCaLQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:16:49 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C23C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:16:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f10so13969390pgl.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RgCZPHUwv958dBeV30UQOqhSoe3Lgk0n+l1EWY8sEdM=;
        b=AGEh0K4JiqUMeXHjW8bBvgW0aCYbfFuDrq7Hgg0hvVj7q3cOX0zoxUT4gJZ3+n3z1n
         2NMsdBUb/f54sNX12UAhAI8ZKPn2y31ubYLAR/TvfZQ3wnaLY6ltgfItyhJmsHPwB3yY
         BbCrwAMgSUkc2fBlYPOOeZU/PYBZNdQX9yUCepkbKNImZ+TPoSrooBQMU0qUyFA4sKue
         oQj/vHhxEahkRTTiNNj7AWVbr9M89TAC56wc7SETjU5x+FrXfCNjMMjntKmJGxE9KqrD
         imDkOAG/M5WVlruLLcL1BpJfNeD6BUoJsw6T6ww0LUw0p8pPHi3TCFP7hTi8s9Q3byTk
         lATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RgCZPHUwv958dBeV30UQOqhSoe3Lgk0n+l1EWY8sEdM=;
        b=Ueukfp0rHGWyso1uHEzpeOj9iFpWyZTasNqvsdC099VTb04o1K6QahCuh/m68zqC+U
         WbFtHRzLNntYiKNNaOFq8Iwlgro0ACnaJvIWKerABPbkcN7g5GWHQm0/ojNXuXfyJusX
         0ykTdmO6vgTu8EVYumMtu7OmtZYofKNdUFJWRUPO90R91Xfl7exmxHZBtenwwiHXeqRA
         wsAsa0yWTEn1Oi9nYRqbR15de3ZTc8a+gRkBatCzLLN2XCsZjn2ZhSKt+CLIhxhI3IVu
         Q++61PfkrO6X8C3c4o979EqCKijGJ+G3B9i/9yXKlF9yElcItO2iawdXU10dnQ9BoxBs
         Tlxw==
X-Gm-Message-State: AOAM530tiQkYs0ComkDRtCmHaGMPOzDpBO0nPzt7d3C64xkWzMBY83ak
        ohFkeMMv5EvWD+z173Ji5UqY
X-Google-Smtp-Source: ABdhPJxVadqFwZRj6oyAqiMrm8WAA+oPMe4+xL24Ro7/USN5J9ffDo+TJLFtTjOnf4dfkNxKO2RQfg==
X-Received: by 2002:a63:f506:: with SMTP id w6mr2737302pgh.367.1617189408600;
        Wed, 31 Mar 2021 04:16:48 -0700 (PDT)
Received: from work ([103.77.37.129])
        by smtp.gmail.com with ESMTPSA id 67sm2191459pfb.148.2021.03.31.04.16.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Mar 2021 04:16:48 -0700 (PDT)
Date:   Wed, 31 Mar 2021 16:46:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org, abickett@codeaurora.org
Subject: Re: [PATCH v1 0/7] MHI Emergency download and flash programmer
 support
Message-ID: <20210331111644.GE15610@work>
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

These patches were part of a different series before. It is good that
you splitted the patches but you should mention that here.

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
