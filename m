Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CB7410E03
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 02:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhITAYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 20:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhITAYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 20:24:15 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A24C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 17:22:49 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r26so22489846oij.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 17:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JA2O0tqf7sL9eIuWtE+kSmSgHrEDnom7oC3gmz/7Xyk=;
        b=CJWxhZzIgbfuNcH22lzV1pX6+nRj7JkMlNggF+YKgTkCueUdH79pDLMurmh0xCpEst
         RwQzyuRRMlh7iQ4GLy5ODiSGH75G5MzWIBzGZMjEBMXIhapkBHccy3HEl7Fyqw/PeCou
         4AXTb7TFZRCQrlBcL9sMIx8+9WXjcMNmypZrLm/Tc1oVLv3qZEoI5k7hcA9pi1k7Aw6d
         I6Bj3axtU9d4+CDWGsoHIsrq8un32WHhRdcKNoSXAgAYGVoMZSaHPZKdq9Vy52t4v+r2
         jrHTCC5VVFlTPcrHbHmF+4APkOfb0K/a8vlIV2X/3MeqtIAxICFfjpoKCiBz7GIk1ENI
         C+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JA2O0tqf7sL9eIuWtE+kSmSgHrEDnom7oC3gmz/7Xyk=;
        b=Z6dpe4zOY5QEI5btxaaZBlS+GSGldLR+0TU7RWKtazlrrlZXP7ebLExF4CFdtsrzMO
         +7PQGEou+g31+0m7bD/azxgWBxmTXaRrH6lp/vuv8/6LO5/pRfnR6LHSsMiQ9AIbTKaF
         uCCrZsQBDur0sGyZyfUbkxM1tyOfmbCvkBh6SXc1Qfm6k4wnMrIUsy852MYKVZUce2JJ
         KFUrM+7OhSpuMUaRWU4HuMp4W4cq6Dik3Mj6qeyOtH93tsrvsef06CYpY9qvSBhaiSZw
         uyHauynE7+lpNZSz0hUbIREsegYQkReN6FP2qkKIiIROMcPSRWVe6oplmQvJyZUfTZlu
         hNMg==
X-Gm-Message-State: AOAM532sTNimPJKU8AeXbPMUGlcdkYWcgKQOgIGfJBvXaCFS0qkAO1/I
        pBS3LvJYOdRuwhePQvEc3Mm0WQ==
X-Google-Smtp-Source: ABdhPJzQedi3f92lIYBEL8kfICVGlImMKFL2gHXZze+USeuXgcJtLMo3OkGfKdV4KGSYx0BVN4j3Ug==
X-Received: by 2002:aca:7c5:: with SMTP id 188mr11630121oih.60.1632097368754;
        Sun, 19 Sep 2021 17:22:48 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y18sm3227048ooy.7.2021.09.19.17.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 17:22:48 -0700 (PDT)
Date:   Sun, 19 Sep 2021 17:23:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Alex Elder <elder@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm850-yoga: Reshuffle IPA memory
 mappings
Message-ID: <YUfUhSypxpq1PbA1@ripper>
References: <20210916200554.2434439-1-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916200554.2434439-1-amit.pundir@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Sep 13:05 PDT 2021, Amit Pundir wrote:

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

Thanks for the report and fix Amit, I verified that this works fine on
my Yoga as well.

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

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
> -- 
> 2.25.1
> 
