Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B35426FC6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhJHR4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhJHR4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:56:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09017C061762
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 10:54:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t11so6616816plq.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=375qw9HEG1zeGWnh05aU0MtkYE91fpb3mTQ4zx4UO9E=;
        b=YH+ZNiYawAnxu0lRHakpiZFKCiAOXHCcdwcFSxDBzu/fPu5Rhu523cQ/QxX5iuOIq6
         vcBWyCBgSuAhPlzcvDDNSQn9ZZ8pIiC6gCOFTvIJkHtP6Rnhd7ZRnmuWaCCOPMyFuS6r
         x6KbX/vvxqHkmnx6JRhU+LwY7/8T57DrFoKBY+AhiMPvfZVHUwORjUQrnECqmeyPgrGy
         sUBu8quofrHLqgVElK9orjQI9AhWhnpofECsZAobyY8FRjwVkOFRTtcdyS/HEcuSAhkU
         SqwQ5wc+NJO9AzZEbkpAEdHrSt03ThRodDaPG8AqSwnXCE4FRK+EBVV5d5EzjivqLtVH
         gkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=375qw9HEG1zeGWnh05aU0MtkYE91fpb3mTQ4zx4UO9E=;
        b=OnWpWLgSwB49YYxa0iyPcaU2AEZVKBXt5JE+nXUQYAmWGXwGu1gLBja1uvA/r86qWT
         Rz0jghjOFQtjoiryKQ+HCZLYUah5l+ZHvV+RcZKGsooBiswz61tfD/SQUYNCYB6Lf7FK
         oz+S/oXeMv086czuH+txe655TcfgNfbM7QImnMw5+zRdBKTZeJRETFSy/tRlSJWqngIq
         2FMcb+dukF388J0CbkT/j/QturLzSGI/UElHhavLW96b5gUDkTQ7niZI2npBurHJncsn
         iuJfp9u52D7M74yA46Pymjwp8PI/eJtE+RAORsZT9xPsoRiT16TfnwHX3CZ5c9ihMM39
         J7Ww==
X-Gm-Message-State: AOAM530k3M00ZgYjQbzy/zHF6mp9C+LBaFZCj/gkHNwzgcNakVO4M9HI
        ic1wWjQaU90tCzrkik2OjECXnw==
X-Google-Smtp-Source: ABdhPJyGFRepbYfMRdvCwKHA+/CTcojukfMWZRbMkJ7WM5XQglqrst+WuLl14+Mxu3PdByg2aTU1Hw==
X-Received: by 2002:a17:90a:d58b:: with SMTP id v11mr13155906pju.207.1633715693383;
        Fri, 08 Oct 2021 10:54:53 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g9sm31425pfv.80.2021.10.08.10.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 10:54:51 -0700 (PDT)
Date:   Fri, 8 Oct 2021 11:54:49 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Deepak Kumar Singh <deesin@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, swboyd@chromium.org,
        clew@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH V1 0/3] rpmsg and glink signaling api support
Message-ID: <20211008175449.GA3620020@p14s>
References: <1633015924-881-1-git-send-email-deesin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633015924-881-1-git-send-email-deesin@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deepak,

On Thu, Sep 30, 2021 at 09:02:00PM +0530, Deepak Kumar Singh wrote:
> This patch series provides support for serial like signals (DTR, RTS etc)
> over glink. Clients on local host can use this interface for sending and 
> receiving these signals to and from modem for flow control purpose.
> 
> Deepak Kumar Singh (3):
>   rpmsg: core: Add signal API support
>   rpmsg: glink: Add support to handle signals command
>   rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
> 
>  drivers/rpmsg/qcom_glink_native.c | 75 +++++++++++++++++++++++++++++++++++++++
>  drivers/rpmsg/rpmsg_char.c        | 43 ++++++++++++++++++++++
>  drivers/rpmsg/rpmsg_core.c        | 21 +++++++++++
>  drivers/rpmsg/rpmsg_internal.h    |  2 ++
>  include/linux/rpmsg.h             | 15 ++++++++
>  5 files changed, 156 insertions(+)
> 

I have started to review this set - comments to follow next weeks.

Thanks,
Mathieu

> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
