Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0735034FF93
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbhCaLhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbhCaLg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:36:28 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183FFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:36:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x126so14300947pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yvlwdL3ZPkvvrj1RN4wqfe16ineNedYVa7ju1Basd6I=;
        b=Lmx9Xaww4AmYYOfPMKHEPBCKWQYnQgsUFoFQA/BeSlfECFnYBHJw+kIOBgu6ZKv+lE
         xcJdQt6ceFAL+0iYhpTr7tUii6837+9sOhouzMcEeiBQXYNfuJ0uE+LrEYjGzrtGwlae
         OG9jAJP/iNKmGPV5d8HviLFStPzk83RtJZDFXYiUkOj2DPi2Q8dvMw+LjbWMXBBiOtku
         W3ocog88ZVTOGSSWoxebqSbfJ1p3a6+pU9TaEq8qr7FTWhWzzRdMcwm/J2I3T955B/L2
         SKeLjyurZhvaD4UOEr62NO8k6ZROAtvkKBigrolYIrdE+w0hdHh2KIj4TW4d2TjhYpQ7
         IS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yvlwdL3ZPkvvrj1RN4wqfe16ineNedYVa7ju1Basd6I=;
        b=NYuYyOCAXYFI7NcJ6Nt+/0lbE9duIt6OLCj4soL5yK2XpHyHhvjhNX4L1I6Zyvfhiy
         Gg/+OrwLYQnMRv8bYlJxerdQIupdGwhRnko2YdcoZvyuEbx7oOUXwBb26WPEFNdvDnhn
         15VvQ9dHnPRX+R4n0IABedrN+1NpFO4bHTSlNHPUi9uqh3A07/CxPC3iXhnzGZo6g4h+
         s7DqY38Y1pDZZ95bsALm9zFTdcQurXJs0x08pw0aCbvxr0jMRlwuW+vEBnwzm6Z4z/cD
         oyYUXaz8dmwc5g+XWnOIqFmRTueLNyk3GVe5pCDeRlPME8Z0fdTgAuQTdgwhFrQCNyG/
         L8+A==
X-Gm-Message-State: AOAM531XLNa2rhJxh4KANduJu6x5UaZ6XRY6KzQGI2UkWk09ULQPs4SU
        KmqEk2tu0odIVOuxWpGE1oc+
X-Google-Smtp-Source: ABdhPJwuUU6CrhvS2Bh59Vt/Mwk7+tbkdJKe/zj2ra0FFwqutCWeqWI5vpD+7DucRP6epuosA1HdTQ==
X-Received: by 2002:a63:c54b:: with SMTP id g11mr2834133pgd.205.1617190587406;
        Wed, 31 Mar 2021 04:36:27 -0700 (PDT)
Received: from work ([103.77.37.129])
        by smtp.gmail.com with ESMTPSA id q5sm1913664pfk.219.2021.03.31.04.36.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Mar 2021 04:36:26 -0700 (PDT)
Date:   Wed, 31 Mar 2021 17:06:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org
Subject: Re: [PATCH v7 0/7] Updates to MHI channel handling
Message-ID: <20210331113623.GH15610@work>
References: <1617070307-5775-1-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617070307-5775-1-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 07:11:40PM -0700, Bhaumik Bhatt wrote:
> MHI specification shows a state machine with support for STOP channel command
> and the validity of certain state transitions. MHI host currently does not
> provide any mechanism to stop a channel and restart it without resetting it.
> There are also times when the device moves on to a different execution
> environment while client drivers on the host are unaware of it and still
> attempt to reset the channels facing unnecessary timeouts.
> 
> This series addresses the above areas to provide support for stopping an MHI
> channel, resuming it back, improved documentation and improving upon channel
> state machine handling in general.
> 
> This set of patches was tested on arm64 and x86_64 architecture.
> 

Please rebase this series on top of mhi-next as some of the patches
doesn't apply cleanly.

Thanks,
Mani

> v7:
> -Tested on x86_64 architecture
> -Drop the patch "Do not clear channel context more than once" as issue is fixed
> differently using "bus: mhi: core: Fix double dma free()"
> -Update the commit text to better reflect changes on state machine improvements
> 
> v6:
> -Dropped the patch which introduced start/stop transfer APIs for lack of users
> -Updated error handling and debug prints on channel handling improvements patch
> -Improved commit text to better explain certain patches based on review comments
> -Removed references to new APIs from the documentation improvement patch
> 
> v5:
> -Added reviewed-by tags from Hemant I missed earlier
> -Added patch to prevent kernel warnings on clearing channel context twice
> 
> v4:
> -Updated commit text/descriptions and addressed checkpatch checks
> -Added context validity check before starting/stopping channels from new API
> -Added patch to clear channel context configuration after reset/unprepare
> 
> v3:
> -Updated documentation for channel transfer APIs to highlight differences
> -Create separate patch for "allowing channel to be disabled from stopped state"
> 
> v2:
> -Renamed the newly introduced APIs to mhi_start_transfer() / mhi_stop_transfer()
> -Added improved documentation to avoid confusion with the new APIs
> -Removed the __ prefix from mhi_unprepare_channel() API for consistency.
> 
> Bhaumik Bhatt (7):
>   bus: mhi: core: Allow sending the STOP channel command
>   bus: mhi: core: Clear context for stopped channels from remove()
>   bus: mhi: core: Improvements to the channel handling state machine
>   bus: mhi: core: Clear configuration from channel context during reset
>   bus: mhi: core: Check channel execution environment before issuing
>     reset
>   bus: mhi: core: Remove __ prefix for MHI channel unprepare function
>   bus: mhi: Improve documentation on channel transfer setup APIs
> 
>  drivers/bus/mhi/core/init.c     |  22 ++++-
>  drivers/bus/mhi/core/internal.h |  12 +++
>  drivers/bus/mhi/core/main.c     | 192 ++++++++++++++++++++++++----------------
>  include/linux/mhi.h             |  18 +++-
>  4 files changed, 163 insertions(+), 81 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
