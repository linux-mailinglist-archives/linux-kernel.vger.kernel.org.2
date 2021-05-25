Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABC3390AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 22:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhEYUzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 16:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbhEYUzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 16:55:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FE9C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 13:53:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v12so16991004plo.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tIAv9q4qLMF9mMN+ph7ydFzOpO0QgW0WRe87Hw6QYDQ=;
        b=hkAlWTTJk4/FJ/yKAHYsGNz0qU64nirtMh9NWBLf0lT0/dc+l6icLZoNqPDeYodsqf
         8y/GvAm4J6WytmJay2Tq/QUGw4FBlUjt3LAjbF4u+rUxsz0ZwN8xLPIgsrfDjTgzE/Gs
         Map/nJp8UibwrjhII2/vp73zt0TklL9KYX+V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tIAv9q4qLMF9mMN+ph7ydFzOpO0QgW0WRe87Hw6QYDQ=;
        b=HcAvEH3eOZqToq9Xp+OaRx1OCZmrn/rvp5ax+oZcBt3Xsq4yET0zMBf8ukkBMcMYK/
         WC87gz/BeXlODfj2B3BX5pWqiTm7u8uJqZ/5PGELouwTfUKqVrN9BEvIRXG2HAkhrpNf
         1Xj7WTMwcDiTtMOTAsje7Jfhi361AzPjI/mcEwbRdvIJxAPv84PDJedgE8VNVb2wp0WX
         /KCAaohKfpM8/idQxxJ4g+RE77Zr9UZwm/gYrBr9aZrUNi88rnMWurkoR4OpD8OXOLQq
         mWL4lut5cyVW+kAKGzxP3uI9Z7XRQSN8rBRLwf2zAkX7gcKxEs/a8fsqR5YVRSF48OtU
         wWbA==
X-Gm-Message-State: AOAM532GoTRB6/jti4BMP4cKHQAR9iXUywbK7PuHp7lGxt7cXvdSWUqr
        9EfLJAmNWwN8ft/KfqF+CkZfEgzuaLKGJA==
X-Google-Smtp-Source: ABdhPJxa3klkCfxmqKIpzVxFM+qftyX2CphZ0FS1Hzri9Xnq0gJD9IThjTpIMEkzc6oYQZzgO3ARYA==
X-Received: by 2002:a17:90b:19c2:: with SMTP id nm2mr258043pjb.18.1621976017018;
        Tue, 25 May 2021 13:53:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:ab0:bbc9:a71:2916])
        by smtp.gmail.com with UTF8SMTPSA id p19sm11980116pgi.59.2021.05.25.13.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 13:53:36 -0700 (PDT)
Date:   Tue, 25 May 2021 13:53:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH V5 04/11] arm64: dts: qcom: pm8350c: Correct the GPIO node
Message-ID: <YK1jz+h39OIZRH5F@google.com>
References: <1621937466-1502-1-git-send-email-skakit@codeaurora.org>
 <1621937466-1502-5-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1621937466-1502-5-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 03:40:59PM +0530, satya priya wrote:
> Add gpio ranges and correct the compatible to add
> "qcom,spmi-gpio" as this pmic is on spmi bus.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Changes in V5:
>  - This is split from patch [3/11] and added newly in V5.

isn't the split from patch [4/8]?

https://patchwork.kernel.org/project/linux-arm-msm/patch/1621318822-29332-5-git-send-email-skakit@codeaurora.org/

>  arch/arm64/boot/dts/qcom/pm8350c.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8350c.dtsi b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> index f926508..e1b75ae 100644
> --- a/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> @@ -21,9 +21,10 @@
>  		};
>  
>  		pm8350c_gpios: gpio@8800 {
> -			compatible = "qcom,pm8350c-gpio";
> +			compatible = "qcom,pm8350c-gpio", "qcom,spmi-gpio";
>  			reg = <0x8800>;
>  			gpio-controller;
> +			gpio-ranges = <&pm8350c_gpios 0 0 9>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
