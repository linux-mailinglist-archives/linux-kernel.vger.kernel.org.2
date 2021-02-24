Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D43323A01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhBXJ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhBXJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:56:22 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADFBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:55:41 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u26so995367pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4TKdddbP4LdK/gYI/AwjHYYmn1IykmtmAhjMcrRr+Po=;
        b=KJ2smKxe/5Dvhg8ve2XCqxlHhvjqCze3ARxpnUHm7r4w+VIDo91Fe5Sp+BuAkJcUl+
         OS2KBWT0CBqFq/CfOe981WvVT5lM/9MiRCWZMT2AAkwzmqtAdPKvMg069TjnEPp0IOyT
         /qCZtLnWfGYDgp9m/VU5TtFsBhgGxgAgO6CZOiO+yXqU/91TYPgkG96A/pmJykrSNYqK
         I2lGQfa2kar+fk+tumo939rrIbNMkmrGt98VkVaLRlkLOovK0hb0avdnUt31VA+U8o9g
         E/btfecJCCUpNT1Nu7Hrxrz9ti2sZubyvPwjQ7uRFl9+tApJTDW6kLuuJGMWG8UVrduc
         zNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4TKdddbP4LdK/gYI/AwjHYYmn1IykmtmAhjMcrRr+Po=;
        b=amj3nxHT+C63FYeE2HrT3kfMYgtSVc91he122iiaBA8hNx789LTU0JFLLRS4RfzOnN
         qTtpqVHirrhm5lTMJdPoIQ4hscYpmymvCd8AE0OE9KHRiXKk+ohB0QpjUL6aNY9h3bRP
         V68Rj57yCro23DeX10GQXNkj2vd2yr+rm8vxq2soJzdq0C1bngzlexY5/jgVapZakSs1
         YRZtCd9Hy/kYh3EpUbKDEGgz87FwLdrTRSX2oYcz2fjAKbwfRzra5IM3F3pE/v1YgWQE
         o1Ja0qi2HzZ2+fo1GkrtY5Huqkz154V8SfKOqGMb9UJ/dDcdUYUrLbJRILH7j75TmJ+l
         IngA==
X-Gm-Message-State: AOAM532pf568HPhtNLMoncMJ0O0dhziB0nyrBLViEJ34WO1s/rh7wUVt
        MtecdHQXzLzYtf9jnrOxIpu5
X-Google-Smtp-Source: ABdhPJyhZhk3jS/4Q5hGlZI7UCaEQSVOLx/oNvBhgVk5Kjp4g7Ds4F8yBxQVeEG7Op2MXxzEGQr7hQ==
X-Received: by 2002:a05:6a00:1506:b029:1bc:6f53:8eb8 with SMTP id q6-20020a056a001506b02901bc6f538eb8mr31091255pfu.36.1614160541271;
        Wed, 24 Feb 2021 01:55:41 -0800 (PST)
Received: from work ([103.66.79.25])
        by smtp.gmail.com with ESMTPSA id o3sm1720223pgm.60.2021.02.24.01.55.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Feb 2021 01:55:40 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:25:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fan Wu <wufan@codeaurora.org>
Subject: Re: [PATCH v3] bus: mhi: core: Return EAGAIN if MHI ring is full
Message-ID: <20210224095537.GR27945@work>
References: <1613579209-3675-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613579209-3675-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 09:26:49AM -0700, Jeffrey Hugo wrote:
> From: Fan Wu <wufan@codeaurora.org>
> 
> Currently ENOMEM is returned when MHI ring is full. This error code is
> very misleading. Change to EAGAIN instead.
> 
> Signed-off-by: Fan Wu <wufan@codeaurora.org>
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> 
> v3: Fix subject
> v2: Change from EBUSY to EAGAIN
> 
>  drivers/bus/mhi/core/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index b63f9e6..1eb2fd3 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -1054,7 +1054,7 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
>  
>  	ret = mhi_is_ring_full(mhi_cntrl, tre_ring);
>  	if (unlikely(ret)) {
> -		ret = -ENOMEM;
> +		ret = -EAGAIN;
>  		goto exit_unlock;
>  	}
>  
> -- 
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
