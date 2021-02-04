Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC9D30CF6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbhBBWxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbhBBWxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:53:18 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D796BC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 14:52:37 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id m13so24619529oig.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 14:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pNHGdQEaVulKLdur3mjFN7uexHDN43kmskAHi1/+zFQ=;
        b=vx3xy7M7W49bwfASPWL/L07EpcKrPO21vevHAK6m2umHBS0ZyUTODZpSpBmtT0fPTt
         4Lj/9sxxi+FfzYtjRg12f9Oq6J8cWTFNjgZTY5sYrI6zibG7seKEOmgPrH/9aQqzBFtx
         aklLmA3rqnMRNAb1wm0IZVIuNpvW+0ZcfyjHXHDUpAAkpNXWTBe7Ozsln2Ks5Spen5ok
         cWJpa4o0G6c+mwrs/OjssBUvIdQJi1jFp8d7TjLZfUug0eHmoM6SFqXphJ2/mZis5TAy
         kI4Ys8mEC9MfUFxc/cPKtbyGYePwuvox9ibIT9u6GPHbfq0hqZEefJimipRToC6xdhpb
         CYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pNHGdQEaVulKLdur3mjFN7uexHDN43kmskAHi1/+zFQ=;
        b=inKVBgQjOIN09MbR4UB+/AKv5+yTFG3+653FlB2AR50Kbj8B6vuUPLBum774bhJkJ3
         psAp7oYeYsW6aK2RiwGkcVn+O/1vkhgMhXVEKmChIBVpqh1JDWdyXBLSDg/XAeBR1ktb
         SFT95AhTibNI7Cqvu9iWC5AME4dQuNVZ/o4US8kU2hgDlRl7YXaCknAsotVL2yVnmLbD
         qATZPrqefU3OkYi3h/Gu6Y471+wxGkQf4jvq9FYsUbR6p41WrSFyziIaT/h5avG9nL/L
         9yYdPUF3s3Hru9cP0gGN2Iq+KjTHhuSRNmz0yVpIcVnf/9soMeTV7rk4q319p9N6zaTq
         qSTg==
X-Gm-Message-State: AOAM532LctKolwf++6Xn117rIq3YjaZxYg+gf7LIO7D6AXkv3fH6F7lI
        ezEEO/Kh6IT3cTwvhkwYYRsJFg==
X-Google-Smtp-Source: ABdhPJzOuTSR3c8QMeugNJGnaTsE04C3G6eyUc0ji1QK8vTBm3Acse8JcdjUyPcvpuGXlwSnU6Nq5Q==
X-Received: by 2002:aca:4454:: with SMTP id r81mr57784oia.129.1612306357220;
        Tue, 02 Feb 2021 14:52:37 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b7sm75747oib.53.2021.02.02.14.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 14:52:36 -0800 (PST)
Date:   Tue, 2 Feb 2021 16:52:34 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Akhil P Oommen <akhilpo@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, dri-devel@freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jcrouse@codeaurora.org,
        robdclark@gmail.com, mka@chromium.org
Subject: Re: [PATCH v4 2/2] arm: dts: sc7180: Add support for gpu fuse
Message-ID: <YBnXshYzJmNpmuEW@builder.lan>
References: <1610129731-4875-1-git-send-email-akhilpo@codeaurora.org>
 <1610129731-4875-2-git-send-email-akhilpo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610129731-4875-2-git-send-email-akhilpo@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 Jan 12:15 CST 2021, Akhil P Oommen wrote:

Please align the $subject prefix with other changes in the same file.
I fixed it up while picking up the patch this time.

Regards,
Bjorn

> Add support for gpu fuse to help identify the supported opps.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 6678f1e..8cae3eb 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -675,6 +675,11 @@
>  				reg = <0x25b 0x1>;
>  				bits = <1 3>;
>  			};
> +
> +			gpu_speed_bin: gpu_speed_bin@1d2 {
> +				reg = <0x1d2 0x2>;
> +				bits = <5 8>;
> +			};
>  		};
>  
>  		sdhc_1: sdhci@7c4000 {
> @@ -1907,52 +1912,69 @@
>  			operating-points-v2 = <&gpu_opp_table>;
>  			qcom,gmu = <&gmu>;
>  
> +			nvmem-cells = <&gpu_speed_bin>;
> +			nvmem-cell-names = "speed_bin";
> +
>  			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
>  			interconnect-names = "gfx-mem";
>  
>  			gpu_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
> +				opp-825000000 {
> +					opp-hz = /bits/ 64 <825000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +					opp-peak-kBps = <8532000>;
> +					opp-supported-hw = <0x04>;
> +				};
> +
>  				opp-800000000 {
>  					opp-hz = /bits/ 64 <800000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
>  					opp-peak-kBps = <8532000>;
> +					opp-supported-hw = <0x07>;
>  				};
>  
>  				opp-650000000 {
>  					opp-hz = /bits/ 64 <650000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
>  					opp-peak-kBps = <7216000>;
> +					opp-supported-hw = <0x07>;
>  				};
>  
>  				opp-565000000 {
>  					opp-hz = /bits/ 64 <565000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
>  					opp-peak-kBps = <5412000>;
> +					opp-supported-hw = <0x07>;
>  				};
>  
>  				opp-430000000 {
>  					opp-hz = /bits/ 64 <430000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>  					opp-peak-kBps = <5412000>;
> +					opp-supported-hw = <0x07>;
>  				};
>  
>  				opp-355000000 {
>  					opp-hz = /bits/ 64 <355000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
>  					opp-peak-kBps = <3072000>;
> +					opp-supported-hw = <0x07>;
>  				};
>  
>  				opp-267000000 {
>  					opp-hz = /bits/ 64 <267000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>  					opp-peak-kBps = <3072000>;
> +					opp-supported-hw = <0x07>;
>  				};
>  
>  				opp-180000000 {
>  					opp-hz = /bits/ 64 <180000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
>  					opp-peak-kBps = <1804000>;
> +					opp-supported-hw = <0x07>;
>  				};
>  			};
>  		};
> -- 
> 2.7.4
> 
