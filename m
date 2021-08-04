Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3623E0AA6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 00:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhHDW7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 18:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHDW7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 18:59:20 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A668C061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 15:59:07 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v9-20020a9d60490000b02904f06fc590dbso3230026otj.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 15:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p25eSLQlVjyRc2NZ0Izc6Hdj6o33HTjBNdPpz6h3kcg=;
        b=NFhEaKerz15qkkVoAe3XrnzZP4xOcO9yx05s/WdF2UYcxeE7lvK30id62xqjJ88D1b
         4JkWVy0tYOrVXMt/gslUyrOkFQkdWTpmBoDC5EvgBBAmTzTnzCTRswLIE7JB2QTB95nY
         qlVAooPBbF8QXi4aufOGQ7VcV+Mz5diSEorMiFi0RU+1AC/UafmbYfqwT+YRH1Jzc7YD
         H+eRCe2DbMbSy547mks3U3NoEIj4OygK1Q9KgPk9OnAqC835uHxFtuhfS2GWrgj9cVbM
         5yQ3yOzQv+bZRf/NihBmm+mcGNddzdWGIDugTQZwnGfKwBI5Ry5Ft2cj9S5/O5tT8/Q2
         dfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p25eSLQlVjyRc2NZ0Izc6Hdj6o33HTjBNdPpz6h3kcg=;
        b=ZRfl+i5HDsaRrpkxluQxCilMc5rNayCEwXgxXN7mydSsVkKA+O02sDd2kr9VFdE/40
         7ge631eIQGonBaeA5hni9hiRzV0lmgM002jougMvMf6UiJgXNIVv1H/dJvPrU0lGWtaP
         WBoP0153dGDZVEZrF0p9MPFDcLpMfq+2iSTQ22EFyErGbtp5OSwD1TfCut5DKPshNHr1
         fdKI23iRmCw/PJOYYU4V89U4J229CYuFsAY7StxilXXPQWteZzH0ZQ6AmGqgOkXa4bC3
         gtVndzVBAaZdl+mihYiMgFcxMKkWW7RYh+TqTL8y4rRceUSLyji7vjKmlUgP0ixKZjC0
         nDOQ==
X-Gm-Message-State: AOAM530H0cQxRuYtnfE7mhUDzHHaSW3PlZf2CAX7K6he019VZpKtWvm6
        AjMzWRahUtXG3XooTXZ3o0aK0Q==
X-Google-Smtp-Source: ABdhPJwhJi3GMY+mER3yqcICMoFsOJG8itB6UE9pbw2isGaQgQDBcvY36EFueGX9HR7DUFsTGqaeSg==
X-Received: by 2002:a05:6830:4186:: with SMTP id r6mr1411307otu.136.1628117946685;
        Wed, 04 Aug 2021 15:59:06 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r137sm11334oie.17.2021.08.04.15.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 15:59:06 -0700 (PDT)
Date:   Wed, 4 Aug 2021 17:59:04 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, mka@chromium.org,
        viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, tdas@codeaurora.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8350: Fixup the cpufreq node
Message-ID: <YQsbuN1xyAlCYRqK@builder.lan>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
 <1627581885-32165-5-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627581885-32165-5-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29 Jul 13:04 CDT 2021, Sibi Sankar wrote:

> Fixup the register regions used by the cpufreq node on SM8350 SoC to
> support per core L3 DCVS.
> 

That sounds good, but why are you dropping the platform-specific
compatible?

Regards,
Bjorn

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index a631d58166b1..d0a5a5568602 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -967,11 +967,10 @@
>  		};
>  
>  		cpufreq_hw: cpufreq@18591000 {
> -			compatible = "qcom,sm8350-cpufreq-epss", "qcom,cpufreq-epss";
> -			reg = <0 0x18591000 0 0x1000>,
> -			      <0 0x18592000 0 0x1000>,
> -			      <0 0x18593000 0 0x1000>;
> -			reg-names = "freq-domain0", "freq-domain1", "freq-domain2";
> +			compatible = "qcom,cpufreq-epss";
> +			reg = <0 0x18591100 0 0x900>,
> +			      <0 0x18592100 0 0x900>,
> +			      <0 0x18593100 0 0x900>;
>  
>  			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
>  			clock-names = "xo", "alternate";
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
