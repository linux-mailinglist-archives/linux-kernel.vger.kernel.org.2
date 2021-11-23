Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF39145A754
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhKWQRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhKWQRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:17:11 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2852C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 08:14:03 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b13so17514502plg.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 08:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8inpYltOn+CuOSRy1TzQ0Ih132g9z81+D5QmyV6ts9Y=;
        b=i9rVupQl92AqsGZLGbAOub7zhj7/6WU2T4Pko8hrZl+IA44g+22VPUoU63MjKamPOx
         EHUzvltfq2WdgtS5LQBEMIGi21/vWiEau8TliotzO6fF7bNhY5S3tCaumCmUW+FrWHhz
         gb3X4g4L/SaQNGJBiJsxy92tlcqsfy3MpeS70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8inpYltOn+CuOSRy1TzQ0Ih132g9z81+D5QmyV6ts9Y=;
        b=T1lUbLUamkrmhv6vH3VyBRnS0e7SjsBdczoo+aTf93WKH4vetaRnxl0gPDbh8/rL3F
         XNIyjmDVCMaX82BmgQbST5owYtnU+t3qwirdObOvizO67LRsDSTIDBZzVdLzzrCJdesM
         91Jq64ScNdPbNhLD7cAIUqJ+X7NKh5bMmeztJt0C0TW9m2hubVxtdA1MhutUilF8zO4B
         huI0Qzq6MH6Xefq77rbKhuF2WHTiHQNieLdRfS517TAIMIETSeonmauLTF2NCSW31qhr
         8WhnOsJdQwUgg4UvUswDP22lhslGmsqZSp/aLeywQ+Mebyra/wSKrH7wdIbA7ftOdyNv
         jxYg==
X-Gm-Message-State: AOAM5333OiBXWh4NZeB1Q2r4KCFvPH35WLvSE4jy5aX6YamR0s2LoF6P
        qzi6E/UML5v5AZvEr5mqrqVUupwPMbqgIw==
X-Google-Smtp-Source: ABdhPJwMfxC2wTbN/wG3x9FjFcU7i8b+6ZPx2ERHXd9Jk5kD6A1sd4h6hQVvjeYdILoZg1ualPJaSw==
X-Received: by 2002:a17:90a:e40f:: with SMTP id hv15mr4231148pjb.5.1637684043171;
        Tue, 23 Nov 2021 08:14:03 -0800 (PST)
Received: from localhost ([2620:15c:202:201:5fa5:d920:9d68:9c16])
        by smtp.gmail.com with UTF8SMTPSA id s2sm14576950pfg.124.2021.11.23.08.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 08:14:02 -0800 (PST)
Date:   Tue, 23 Nov 2021 08:14:01 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@codeaurora.org,
        dianders@chromium.org, kgodara@codeaurora.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc7280-crd: Add device tree files
 for CRD
Message-ID: <YZ0TSeXddm+qGJ0/@google.com>
References: <1637650813-16654-1-git-send-email-rnayak@codeaurora.org>
 <1637650813-16654-3-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1637650813-16654-3-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:30:11PM +0530, Rajendra Nayak wrote:
> CRD (Compute Reference Design) is a sc7280 based board, largely
> derived from the existing IDP board design with some key deltas
> 1. has EC and H1 over SPI similar to IDP2
> 2. touchscreen and trackpad support
> 3. eDP display
> 
> We just add the barebones dts file here, subsequent patches will
> add support for EC/H1 and other components.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |  1 +
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-crd.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 6b816eb..b18708c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -78,6 +78,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> new file mode 100644
> index 0000000..09d02c2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * sc7280 CRD board device tree source
> + *
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7280-idp.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. sc7280 CRD platform";
> +	compatible = "qcom,sc7280-crd", "google,hoglin-rev0", "qcom,sc7280";

As per my comment on the binding there should also be a "google,hoglin"
without a revision suffix, also it seems there are already CRDs with higher
rev numbers.

> +
> +	aliases {
> +		serial0 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&nvme_pwren {
> +	pins = "gpio51";
> +};
> +
> +&nvme_3v3_regulator {
> +	gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
> +};

uber-nit: 'nvme_3v3_regulator' should be before 'nvme_pwren', assuming
alphabetical/ASCII ordering is used.
