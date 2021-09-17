Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95D740FC1D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbhIQPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241749AbhIQPWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:22:09 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C371C0613E4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:16:43 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id r26so14398797oij.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/3ZxpeUuB/vl9DBmorUmc8ZV+Xm47ifZ9EKEnAgqH44=;
        b=AAzpchrqmAvROqA1BlIRO/9Vt38/lpzDVY4myOFl2Nw3HzTxSAx7/haQEDJ9+U/5lD
         dPxMZmmIBketNOrFnHVCeSEHfWfwjPCMxTeF4f6e6HogmN19bRVAnjZixO+KQntO/hqe
         JHa5bQDN9sK2L/f4IuKMIqMfGKswFdlUa0UKwp+Y9yi/GUo9yPWiIAqBrsRAeRkC/sn0
         K3w/Yd94kp1K26aa2Cn3BIfLC9+yVwLhNw2oSUqWO8DvxnkJPB/FXmpjgGVG8GYl0W7C
         WB0WPVDNyki2p1qcYC7bwwZZBlgQJb7SIz8ajsG33oXbQqbgcm0CFDzOa9C+6Nnk4k//
         GSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/3ZxpeUuB/vl9DBmorUmc8ZV+Xm47ifZ9EKEnAgqH44=;
        b=7fV6PI0eqsaoQY51f83IYjnBbMa5J/VEcIO12tKg4dlW+Ju251fFmEFKQmsuHyk1Mq
         2YEktMKejqJLKTQwWw1PgyLi4duYMRew1zX8ZJrOAJnoF7DvrMPeG4UfYNITxT8Rn+I/
         GMKEa34nAotc4/UEJPXhtQcuqyOykvubP2h6KC2RtxmdDHAP0FqDkRsLLe5B1H67kOCb
         W3NrBjbYo204Yg7k2jiAFBadmnOKIlxBVXzQmlz3/VpmD5z51JScilnp3tHWtcO81hwa
         aHUFfORnPD1n4aXZyi9BvSqI1fTPp/o0UjXpNaruf++a8X3TNIf+Z57wSVpBLNaxtlMV
         /39Q==
X-Gm-Message-State: AOAM533+H4P+Ao0HbEOH4GsIYLP2zfxQ2bIsPAc99i27ySDjrvhgIsIe
        vQK6dhiEO33h2ISqEBREo5onyrz7cQ3fZL72
X-Google-Smtp-Source: ABdhPJzp1trLSa7nhgEpwBRW/4AxMYCyKtiwCAEIt1jVH+RoANmH8n/6aja8/U5VsL91FoqoOUCO+Q==
X-Received: by 2002:a05:6808:8d2:: with SMTP id k18mr4280963oij.62.1631891802835;
        Fri, 17 Sep 2021 08:16:42 -0700 (PDT)
Received: from MacBook-Pro.hackershack.net (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id x192sm358739oix.9.2021.09.17.08.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 08:16:42 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: qcom: sdm850-yoga: Reshuffle IPA memory
 mappings
To:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Alex Elder <elder@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20210916200554.2434439-1-amit.pundir@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <e72beb6a-10c0-6edb-7a38-a3870285c423@kali.org>
Date:   Fri, 17 Sep 2021 10:16:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916200554.2434439-1-amit.pundir@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/16/21 3:05 PM, Amit Pundir wrote:
> Upstream commit 2e01e0c21459 ("arm64: dts: qcom: sdm850-yoga:
> Enable IPA") shuffled reserved memory regions in sdm845.dtsi
> to make firmware loading succeed and enable the ipa device on
> sdm845-yoga but it broke the other common users of those
> memory regions like Xiaomi Pocophone F1.
>
> So this patch effectively revert those upstream commit changes
> and move all the relevant changes to sdm850-lenovo-yoga-c630.dts
> instead.
>
> Fixes: 2e01e0c21459 ("arm64: dts: qcom: sdm850-yoga: Enable IPA")
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> Smoke tested on PocoF1 and not on Yoga-C630.
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 21 +++++++-----
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 34 +++++++++++++++++++
>  2 files changed, 47 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 6d7172e6f4c3..b3b911926184 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -128,23 +128,28 @@ camera_mem: memory@8bf00000 {
>  			no-map;
>  		};
>  
> -		wlan_msa_mem: memory@8c400000 {
> -			reg = <0 0x8c400000 0 0x100000>;
> +		ipa_fw_mem: memory@8c400000 {
> +			reg = <0 0x8c400000 0 0x10000>;
>  			no-map;
>  		};
>  
> -		gpu_mem: memory@8c515000 {
> -			reg = <0 0x8c515000 0 0x2000>;
> +		ipa_gsi_mem: memory@8c410000 {
> +			reg = <0 0x8c410000 0 0x5000>;
>  			no-map;
>  		};
>  
> -		ipa_fw_mem: memory@8c517000 {
> -			reg = <0 0x8c517000 0 0x5a000>;
> +		gpu_mem: memory@8c415000 {
> +			reg = <0 0x8c415000 0 0x2000>;
>  			no-map;
>  		};
>  
> -		adsp_mem: memory@8c600000 {
> -			reg = <0 0x8c600000 0 0x1a00000>;
> +		adsp_mem: memory@8c500000 {
> +			reg = <0 0x8c500000 0 0x1a00000>;
> +			no-map;
> +		};
> +
> +		wlan_msa_mem: memory@8df00000 {
> +			reg = <0 0x8df00000 0 0x100000>;
>  			no-map;
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index 385e5029437d..2ba23aa582a1 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -16,6 +16,17 @@
>  #include "sdm850.dtsi"
>  #include "pm8998.dtsi"
>  
> +/*
> + * Update following upstream (sdm845.dtsi) reserved
> + * memory mappings for firmware loading to succeed
> + * and enable the IPA device.
> + */
> +/delete-node/ &ipa_fw_mem;
> +/delete-node/ &ipa_gsi_mem;
> +/delete-node/ &gpu_mem;
> +/delete-node/ &adsp_mem;
> +/delete-node/ &wlan_msa_mem;
> +
>  / {
>  	model = "Lenovo Yoga C630";
>  	compatible = "lenovo,yoga-c630", "qcom,sdm845";
> @@ -58,6 +69,29 @@ panel_in_edp: endpoint {
>  		};
>  	};
>  
> +	/* Reserved memory changes for IPA */
> +	reserved-memory {
> +		wlan_msa_mem: memory@8c400000 {
> +			reg = <0 0x8c400000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		gpu_mem: memory@8c515000 {
> +			reg = <0 0x8c515000 0 0x2000>;
> +			no-map;
> +		};
> +
> +		ipa_fw_mem: memory@8c517000 {
> +			reg = <0 0x8c517000 0 0x5a000>;
> +			no-map;
> +		};
> +
> +		adsp_mem: memory@8c600000 {
> +			reg = <0 0x8c600000 0 0x1a00000>;
> +			no-map;
> +		};
> +	};
> +
>  	sn65dsi86_refclk: sn65dsi86-refclk {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;

Tested on the Lenovo Yoga C630 I have.  I get the ipa modem device, so it looks like it does the correct thing.  I don't have a SIM card to test actual connectivity though.

Tested-By: Steev Klimaszewski <steev@kali.org>

