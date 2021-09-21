Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD44412A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhIUBmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhIUBjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:39:23 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B53C03D754
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:45:35 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p80so17153917iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N7n5x8sXHuAzu3+RIwr9lpXQmI9SOiXEYfpRq5wrut4=;
        b=JqgTQlIWTovRoLk+BvUsk/awete9Lsf3s0uK7GhVO+TH3Rz+iie+EYRFU9ptMoSeF0
         7fQGY9Qx/OamC+mP6z1l3HAkHTlNILXb4L2qCmoRVpYQqmUojC4uzBY7vK8nBxegThA3
         goZovTiD2pJjGIKrjXjWlb9aTpF++C6Uxyir1hNZ8RKjN9o3GO/7XkqZpGhcltmPjzjQ
         V10YpC5pWiLDeqbwO45upnu8RuA+od5MLhW062DiXWANTEWpnytIsh+pmrEGEaRLZU+b
         Gr8Jw4Wa5OxeqIfjDm8ugaUeoZTn5f3HXu27Szv4txUKCZcb2AquCZ65bzsE7S7Og2w1
         HUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N7n5x8sXHuAzu3+RIwr9lpXQmI9SOiXEYfpRq5wrut4=;
        b=OHDRSJoJpBjNzn6Jd9a0BvaO3okjIRnq0lkt21hkA7L38tKWFuEfmG2rYoSK/MKTeP
         YU0YqfqA9KJMAqo1bTe/krEOKDOLLGcyuU1CCHsJIIQYBGSdoG+BpPqKviJ0rDOWCuKb
         T3vxnniTMnDMEq4/V/pl4Zlwvq7UXQf8b7NOvLJ8W0mjcU1eOk4+r0myt7CJjwK8xZNy
         lpk9+mS4aM7qdrhRu0CIMHJXMy9R2uNtqafmdi2dbsRHGV262TkHikDdZhQYay8nzYER
         3lKUfcDx60EbylWd6fsXr8MBOeFC3Ea29oW4OSF9UTgKJCGadw6riaKZO238UYk2cxQR
         hk7Q==
X-Gm-Message-State: AOAM532ZZJ4eHCSlSKzJIF50BtCp2J2Qqn9yxS+ifjwfap1sJg2WP8nC
        lm3k48P29C9gbxiDxIdXQh4gAJSNxaeyPQ==
X-Google-Smtp-Source: ABdhPJypcjxV8kGKDIjn8BoxxMAFqbAhAglu2GGK/YeLbTIaWJLrqtR6Wu+A2QH/uxXLXLc8WtLthw==
X-Received: by 2002:a02:19c9:: with SMTP id b192mr21061667jab.67.1632167134657;
        Mon, 20 Sep 2021 12:45:34 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id e13sm8942241iod.36.2021.09.20.12.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 12:45:34 -0700 (PDT)
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7180-trogdor: Enable IPA on LTE
 only SKUs
To:     Sujit Kautkar <sujitka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     swboyd@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210920113220.v1.1.I904da9664f294fcf222f6f378d37eaadd72ca92e@changeid>
From:   Alex Elder <elder@linaro.org>
Message-ID: <9f94de2e-eb1b-225e-937d-55855d95a4ac@linaro.org>
Date:   Mon, 20 Sep 2021 14:45:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210920113220.v1.1.I904da9664f294fcf222f6f378d37eaadd72ca92e@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 1:32 PM, Sujit Kautkar wrote:
> Enable the IPA node for LTE and skip for wifi-only SKUs
> 
> Signed-off-by: Sujit Kautkar <sujitka@chromium.org>

Looks good to me.  Thanks Sujit.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
> 
>   arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi | 11 +++++++++++
>   arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi         | 11 -----------
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> index 469aad4e5948c..fd4b712037542 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> @@ -17,3 +17,14 @@ &remoteproc_mpss {
>   	firmware-name = "qcom/sc7180-trogdor/modem/mba.mbn",
>   			"qcom/sc7180-trogdor/modem/qdsp6sw.mbn";
>   };
> +
> +&ipa {
> +	status = "okay";
> +
> +	/*
> +	 * Trogdor doesn't have QHEE (Qualcomm's EL2 blob), so the
> +	 * modem needs to cover certain init steps (GSI init), and
> +	 * the AP needs to wait for it.
> +	 */
> +	modem-init;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 6e96024a487cd..3d8b9c6b21a85 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -754,17 +754,6 @@ alc5682: codec@1a {
>   	};
>   };
>   
> -&ipa {
> -	status = "okay";
> -
> -	/*
> -	 * Trogdor doesn't have QHEE (Qualcomm's EL2 blob), so the
> -	 * modem needs to cover certain init steps (GSI init), and
> -	 * the AP needs to wait for it.
> -	 */
> -	modem-init;
> -};
> -
>   &lpass_cpu {
>   	status = "okay";
>   
> 

