Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5907E3E507B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 03:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhHJBCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 21:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbhHJBCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:02:38 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FF4C061798
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 18:02:17 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m18so15145964ljo.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 18:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=haFDSk96QJYNOFsZMcENBLbn99PoDmddH3/hzh7or5M=;
        b=jhNo8XwfkfwkZCFM86MMJamwZjCPjvEUccp+hbtfiTawBFeIgjsUpKGn4VAjvaUp0C
         YVgdFpTfAPa32YzRD9mY7/DSWUd2gclAKL7tzzYT9RLaQJNc3AHSCNkc71Vb1cJFZGiD
         KF6cf/wqBdULsNtvh7K4lflR6zq3DGuj2vj0C572evl4cyjGbXKXmAt9ZWWM4NXmgqKw
         WVZfr8IM3Imlru2iA/dCxej69eTKOdK1FQnRDN1pGTyXkTONR1yXXD2GP6GFat+xiDLz
         rSzbZ9fwYzYi5BrU1uF4TlDxNjetzxBSSdKDQblVzBwcKMfBjDIMEuiy4jwY6WjO1/ad
         eBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=haFDSk96QJYNOFsZMcENBLbn99PoDmddH3/hzh7or5M=;
        b=VEoG20UvjORh3S6tpeKUiH9j8OySIsUdGXPBjnrVXAaDPzxyKyewNv/GM3lii5bvz3
         1sk8k0+MXnWH/J8J4VR01GWU7jH4ZQMs82WYhIEniMWiQG1NqzPdt3oWeK4Q66uFHh2O
         jWmkMdWN6O/vkWLMifLKql6HU+fpjEy/flH9i5bKHdJEcwrL2GTK6f8GozOOA8enJ+P3
         OPvGznFJz9ZE5XEwoxl14sgPH20YMw/+DeRlnq7BCD3l+GN4q0z/KoegQ7h4ikN28MLY
         VNnFon+kKpPvP67cwKv3ZZy/ymyvP/etWG45nij9DMpr3PAPx6KsnYBNK61re7I8VyBu
         cxmw==
X-Gm-Message-State: AOAM533m16P/NmrcTTFDptfyqthohJFu3kA27+TZ4ictdlmHgCtwlch+
        zDU4PgDtV6n44TRgxa70yxwRzTHb3ID7lg==
X-Google-Smtp-Source: ABdhPJyU1PkpiTwGAizbTed4i3D9037Qc+lr88u6kN3dUwI8kvnPTqvDmuRUooCv2y0I+DM32qFypg==
X-Received: by 2002:a2e:900c:: with SMTP id h12mr16829735ljg.240.1628557335404;
        Mon, 09 Aug 2021 18:02:15 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x16sm603601ljc.29.2021.08.09.18.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 18:02:14 -0700 (PDT)
Subject: Re: [PATCH 04/39] arm64: dts: qcom: sdm630: Add interconnect provider
 nodes
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210728222542.54269-1-konrad.dybcio@somainline.org>
 <20210728222542.54269-5-konrad.dybcio@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <f25b75bc-edaf-e7d3-93dd-7be07380a3f0@linaro.org>
Date:   Tue, 10 Aug 2021 04:02:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728222542.54269-5-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2021 01:25, Konrad Dybcio wrote:
> Add interconnect provider nodes to allow for NoC bus scaling.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm630.dtsi | 59 ++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index e2cbe210048e..c46b7327afbe 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <dt-bindings/clock/qcom,gcc-sdm660.h>
> +#include <dt-bindings/clock/qcom,mmcc-sdm660.h>
>   #include <dt-bindings/clock/qcom,rpmcc.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dt-bindings/gpio/gpio.h>
> @@ -516,11 +517,38 @@ rng: rng@793000 {
>   			clock-names = "core";
>   		};
>   
> +		bimc: interconnect@1008000 {
> +			compatible = "qcom,sdm660-bimc";
> +			reg = <0x01008000 0x78000>;
> 
+			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +		};
> +
>   		restart@10ac000 {
>   			compatible = "qcom,pshold";
>   			reg = <0x010ac000 0x4>;
>   		};
>   
> +		cnoc: interconnect@1500000 {
> +			compatible = "qcom,sdm660-cnoc";
> +			reg = <0x01500000 0x10000>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
> +				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
> +		};
> +
> +		snoc: interconnect@1626000 {
> +			compatible = "qcom,sdm660-snoc";
> +			reg = <0x01626000 0x7090>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +		};

Interesting, this disagrees with the downstream dts. It looks like you 
are including offset to QoS registers into start address. Although we do 
not use other registers from the NoC, I think it would be better to use 
correct device address and adjust register offset in the interconnect 
driver.

> +
>   		anoc2_smmu: iommu@16c0000 {
>   			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
>   			reg = <0x016c0000 0x40000>;
> @@ -564,6 +592,25 @@ anoc2_smmu: iommu@16c0000 {
>   			status = "disabled";
>   		};
>   
> +		a2noc: interconnect@1704000 {
> +			compatible = "qcom,sdm660-a2noc";
> +			reg = <0x01704000 0xc100>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
> +				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
> +		};
> +
> +		mnoc: interconnect@1745000 {
> +			compatible = "qcom,sdm660-mnoc";
> +			reg = <0x01745000 0xA010>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a", "iface";
> +			clocks = <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
> +				 <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK_A>,
> +				 <&mmcc AHB_CLK_SRC>;
> +		};
> +
>   		tcsr_mutex_regs: syscon@1f40000 {
>   			compatible = "syscon";
>   			reg = <0x01f40000 0x20000>;
> @@ -1156,6 +1203,18 @@ mmss_smmu: iommu@cd00000 {
>   			status = "disabled";
>   		};
>   
> +		gnoc: interconnect@17900000 {
> +			compatible = "qcom,sdm660-gnoc";
> +			reg = <0x17900000 0xe000>;
> +			#interconnect-cells = <1>;
> +			/*
> +			 * This one apparently features no clocks,
> +			 * so let's not mess with the driver needlessly
> +			 */
> +			clock-names = "bus", "bus_a";
> +			clocks = <&xo_board>, <&xo_board>;
> +		};
> +
>   		apcs_glb: mailbox@17911000 {
>   			compatible = "qcom,sdm660-apcs-hmss-global";
>   			reg = <0x17911000 0x1000>;
> 


-- 
With best wishes
Dmitry
