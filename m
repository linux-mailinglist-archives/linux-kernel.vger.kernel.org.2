Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F86422D62
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhJEQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbhJEQJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:09:16 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299EDC06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 09:07:26 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id c6-20020a9d2786000000b005471981d559so26440711otb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J7AnnRzpMQWfrS8w+7C/LsU/pHKQTZK1/Px5Rn9pGIM=;
        b=K7nSGfOJWjz0aRycOOJK+XB0XKb7dHpRY0YmZVFSLmFlPayA2r4Xs/3OpD2rMOlVd3
         N0KdjQOmyJ0l++sBQLpJZBs5aSPY0mCH1XhI2Sd4u2kIUbdXtqEAh2qeClR88PFPdE0i
         W2Lkb3qjFA7+XO/OgoTsM9/OQD2hkaYBKRj4cA9Bl476BqPQEMN5Ib6qEGFyxpKeBwzf
         m8bIHf04ylTAvz0YgetHfF/1H6verxoYbQkYeF7XL2myyxyDoks9u5tHQLknJse80E4+
         8TVBJd3C2tX4DznXyKMTV+Bo2bEOeJvTc3sjJMVtaFK1tDLzhYVVleDllWQdUrhWGl0Y
         j+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J7AnnRzpMQWfrS8w+7C/LsU/pHKQTZK1/Px5Rn9pGIM=;
        b=KWYTwMnJPO4vqCrzSaANfRVr32c1yj+YL5HUAkLF9j13tdbC8FOSv7xmPdJrD67twm
         SlkEEPPufVGKfq1S0cNqM5xoXsosRNwACJlX+/oUQvDXaqUcqKSCS75vYxDSIr69SUzX
         w9G3Se2X5ixm4LnXPXfg99Auszfxh7o6ELXUTuICG6xeHwrgUAFy8vBVq9o916/mU6HR
         v1AVo4vkYhGRu/l5TuN5sEEbBx++oDhPexwPdE9AikowoDjkCSbnMGZPER+1Tz9wwGFn
         NxYOsz7Cudnf/mEHQ/izdMwa1r2bowxPQmqLYTgwjqSxNONxS7EMghcAmHBupoeRKUhO
         9/Og==
X-Gm-Message-State: AOAM530s1De3521VbeqB1CF4/RG/nBoX1b19m/426Gz7h5zdotGfI0Oa
        2C2Cr6uZuXjMj3kLHYMdzHKU0A==
X-Google-Smtp-Source: ABdhPJzolzQvstN0cY1puPuhcdj9tBT45kpfMSiZeSljPQfJk8IffOEBG6PO0wXpehzgWD0rPHyQvA==
X-Received: by 2002:a9d:5a8e:: with SMTP id w14mr15440953oth.322.1633450045516;
        Tue, 05 Oct 2021 09:07:25 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id p15sm275641oto.23.2021.10.05.09.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:07:25 -0700 (PDT)
Date:   Tue, 5 Oct 2021 09:09:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, linux@roeck-us.net,
        rnayak@codeaurora.org, lsrao@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v10 5/5] arm64: dts: qcom: sc7280: Enable SoC sleep stats
Message-ID: <YVx4o8mfmFjKW5ng@ripper>
References: <1633425065-7927-1-git-send-email-mkshah@codeaurora.org>
 <1633425065-7927-6-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633425065-7927-6-git-send-email-mkshah@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Oct 02:11 PDT 2021, Maulik Shah wrote:

> Add device node for SoC sleep stats driver which provides various
> low power mode stats.
> 
> Also update the reg size of aoss_qmp device to 0x400.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

Can you please follow up with patches for the other upstream platforms
as well.

Thanks,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 39635da..f8622ae 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2637,7 +2637,7 @@
>  
>  		aoss_qmp: power-controller@c300000 {
>  			compatible = "qcom,sc7280-aoss-qmp";
> -			reg = <0 0x0c300000 0 0x100000>;
> +			reg = <0 0x0c300000 0 0x400>;
>  			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
>  						     IPCC_MPROC_SIGNAL_GLINK_QMP
>  						     IRQ_TYPE_EDGE_RISING>;
> @@ -2647,6 +2647,11 @@
>  			#clock-cells = <0>;
>  		};
>  
> +		memory@c3f0000 {
> +			compatible = "qcom,rpmh-sleep-stats";
> +			reg = <0 0x0c3f0000 0 0x400>;
> +		};
> +
>  		spmi_bus: spmi@c440000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0 0x0c440000 0 0x1100>,
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
