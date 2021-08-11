Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2923E97DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhHKSqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhHKSqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:46:09 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDE0C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 11:45:45 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id i7so4960954iow.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jKIOXVh7+eESemNLtQSRNpB524Jx1AZ4uxhD6wSNKkg=;
        b=UjezlaSJWKlTOr/SQLO1c53eLD+F60ya71qLCLvWlcb9bmJ0hmhLcP4AGwYvYn5q+T
         d2eMc3vifaUrVMD9biJOi801gPNZYfDV1N5GjPeGSLB5WtrTKke01fzqNtcYBFT8G76D
         upQIos8bl7Hey1cfNits0D7tYe2LQjpJcwAApjyDknw9W1cZ1Rm+N/rWs16MkIaqq39u
         Pzi5fVV4rzKnGy8L27DhoEIHAIaW5QOb6eQ2UGK5h4fL7u2jOogjJKI5czj4bH1r+742
         qSO+UKFVYJH13BPlXWwPaGiofs5ukfiEs/WT4EPj7zhzp2Z+MLX0Z+OB+LmHU2XdYpPm
         MEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jKIOXVh7+eESemNLtQSRNpB524Jx1AZ4uxhD6wSNKkg=;
        b=tKQZNQA8x6bmGae7narCLN77DQ/ph056SSXaD+Y67M6xwc0zVJXUseXSQahotrYqCG
         1pqRgGdmeqb5hPF93s6DIwj627q17/RuNca1P+l2B1iOd/eyD6d49xQAla2wK54fJ9JL
         9lql+6111c4/Uxex7Y1lHxJMpkoI1Jwu5e7Z+Vhf8AwDcMezfBTRZb9O+T6HOkOellHM
         7wp8VkO6aPJ7LTTOnqAnVeW3t8zuElnMjNmuXTbPSsLIFFi9Z9wQcmqxP7Mk9YpX3UTm
         zV4+vje/dyYzK9uDP8rVn3ui6/fTmuqCkNXITkB41iUPBA59y/rzqoLTKDWM8tKwuXmq
         2n3g==
X-Gm-Message-State: AOAM530XTsg5Vr7ZARyuBq1ykdr67rZfP5/eKcLUCKKjX3o9HrgB4AkX
        vf4H42yNkloFReZfT0KqvV0Vsw==
X-Google-Smtp-Source: ABdhPJzCfjqw3nET9av/BovTeZX6jG03KpWASohmf3ylUNBHFKol1cBMyw/P4hFXe5v3xnu6eKGAxg==
X-Received: by 2002:a05:6602:1d4:: with SMTP id w20mr11465iot.121.1628707544300;
        Wed, 11 Aug 2021 11:45:44 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id j2sm40205ilr.80.2021.08.11.11.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 11:45:43 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Use GIC_SPI for intc cells
To:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
References: <20210811181904.779316-1-swboyd@chromium.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <b504e53c-6f04-b749-ff95-d686539e9d70@linaro.org>
Date:   Wed, 11 Aug 2021 13:45:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811181904.779316-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 1:19 PM, Stephen Boyd wrote:
> Let's use the GIC_SPI macro instead of a plain 0 here to match other
> uses of the primary interrupt controller on sc7280.
> 
> Suggested-by: Matthias Kaehlcke <mka@chromium.org>
> Cc: Alex Elder <elder@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Looks good, thanks.  It's done that way for IPA on other
platforms too, or at least that's the intention...

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index f70ab3c5d08b..569802536321 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -598,8 +598,8 @@ ipa: ipa@1e40000 {
>   				    "ipa-shared",
>   				    "gsi";
>   
> -			interrupts-extended = <&intc 0 654 IRQ_TYPE_EDGE_RISING>,
> -					      <&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
> +			interrupts-extended = <&intc GIC_SPI 654 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
>   					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>   					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
>   			interrupt-names = "ipa",
> 
> base-commit: 97ec669dfcfa22f8a595356ceb6ce46e7b4a82e9
> 

