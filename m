Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3292241644F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbhIWRYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242530AbhIWRYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:24:52 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A545CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:23:20 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id n4-20020a4aa7c4000000b002adb4997965so707216oom.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4psaqAqkYBsHRJZIhz8Kb0YzLqDuMmJCURun1+ui80c=;
        b=rxWR5F/BNcX1AMMGW6CfMfwuPwVeziorWJSn1rXPDf614kbk1wRlLqPEo02VJO54lL
         B7BtY7sSJiw6McPc6ugF/+nqiooHzgI9N4RNHcR2w5BBigSYWw4NGrH8XiRd58qBuDOH
         1jNGmlLjPNTpxwUuPH8Jj6L81wRKiFWITqZfMcH2L4cKM3FD6QeSq7J0o00CCzWed9DM
         Wj/rC0Sk7Fky5vowF1QGzdNGrKqmrNyi1Kkc0uWkYh8X+BAThNCF0fySjskWgfWvF3Pw
         rGeVp5DRlUpn1YExuJpXSNOXkCtOAbHP5OCK9zj2GFO7SHsTZpBJQKTGBo84rusobP1t
         fsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4psaqAqkYBsHRJZIhz8Kb0YzLqDuMmJCURun1+ui80c=;
        b=ij4gxNg684zOjcaxajSbI8JhY6trKsBwG1cL2Ucfj4H9aiewvibxgojNTuWZDHlzd1
         zCEJFh5i18Zc3FmmG9Lj9G90ndI1i9jGaTvaAkhk2PrbYOdTh6C1L9GZJSfziP+2ltqL
         1lJX91xeZkXOAPYFZKi0TWfA16Oc1lLXko4lW+WARf6i7sgyrYG6uji+/rxiee0QXlI6
         Aef6jQNPk7aYmyqRUMbeoC6F3RYdqCE94poRfwZckL/z2OqThw8kJxOhDAoj/GJzwMPK
         pAUzE/9es6NMXNarmJe4jIiGXaVObLg6rs8Oq9NBtrn1kRkREbKFB0j2Pzsr2u8f68Kr
         h0SA==
X-Gm-Message-State: AOAM533X8KYoImnkD1gRzWjGOTXxE+BU8Yat0xbwsjfz9GdLb4oPi7s0
        M/IV43A9r1JeCWXZyshUAVygOg==
X-Google-Smtp-Source: ABdhPJxgLEGgR52wqQW/bWd22UfJUy7hTkj4NwRbgYrtrinHMTAItyhkVol5Ujk0AZ//YeqfMUwm5g==
X-Received: by 2002:a4a:ea84:: with SMTP id r4mr4787465ooh.92.1632417799967;
        Thu, 23 Sep 2021 10:23:19 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j23sm1467347oih.30.2021.09.23.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 10:23:19 -0700 (PDT)
Date:   Thu, 23 Sep 2021 12:23:17 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: qcom: sc7280: Add PM suspend callbacks
Message-ID: <YUy4BQ7BW1LgBipv@builder.lan>
References: <1632389487-11283-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632389487-11283-1-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23 Sep 04:31 CDT 2021, Rajendra Nayak wrote:

> Use PM suspend callbacks from msm core, without this the hog_sleep
> pins don't change state in suspend.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> v2: removed some stale diffstat
> 
>  drivers/pinctrl/qcom/pinctrl-sc7280.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280.c b/drivers/pinctrl/qcom/pinctrl-sc7280.c
> index 607d459..1cbf2cc 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sc7280.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280.c
> @@ -1498,6 +1498,7 @@ static const struct of_device_id sc7280_pinctrl_of_match[] = {
>  static struct platform_driver sc7280_pinctrl_driver = {
>  	.driver = {
>  		.name = "sc7280-pinctrl",
> +		.pm = &msm_pinctrl_dev_pm_ops,
>  		.of_match_table = sc7280_pinctrl_of_match,
>  	},
>  	.probe = sc7280_pinctrl_probe,
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
