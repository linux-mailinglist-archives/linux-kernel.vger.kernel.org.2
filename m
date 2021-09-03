Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B073FFE9B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348470AbhICLDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:03:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:49871 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348467AbhICLDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:03:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630666936; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=KH+12GLEC44YL4JM6wENp19/gWL340T07kKx0In4XTA=;
 b=xHdJWVYNDHms4U7MgbEZVnP7cwmcInh2tcqprzm4KcOVgM4QcXlsX0A0vd0sR09G2qCOmcyS
 0Fl0va8Cq+ldG2lChLVPoxxaYMn3PJtF0tDSDbW30NdizbqUfrrfoTdWU1QHXPqYpQc48fF7
 doyLqnKwGKK/gxwlC+5jAwzw1AU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 613200aa89cdb6206174d9be (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Sep 2021 11:02:02
 GMT
Sender: dikshita=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9BE95C43617; Fri,  3 Sep 2021 11:02:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: dikshita)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBC9EC4338F;
        Fri,  3 Sep 2021 11:02:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Sep 2021 16:32:01 +0530
From:   dikshita@codeaurora.org
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, stanimir.varbanov@linaro.org
Subject: Re: [PATCH v5] arm64: dts: qcom: sc7280: Add venus DT node
In-Reply-To: <1628669090-15648-1-git-send-email-dikshita@codeaurora.org>
References: <1628669090-15648-1-git-send-email-dikshita@codeaurora.org>
Message-ID: <1a61344a33782c3b80f30e86efce2c95@codeaurora.org>
X-Sender: dikshita@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A gentle reminder for review.

Thanks,
Dikshita

On 2021-08-11 13:34, Dikshita Agarwal wrote:
> Add DT entries for the sc7280 venus encoder/decoder.
> 
> Change since v4:
> 	rebased on latest linux-next tree.
> 
> this patch depends on [1].
> 
> [1] 
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=529463
> 
> Co-developed-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 75 
> ++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 3e96604..88de534 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -73,6 +73,11 @@
>  			reg = <0x0 0x80b00000 0x0 0x100000>;
>  		};
> 
> +		video_mem: memory@8b200000 {
> +			reg = <0x0 0x8b200000 0x0 0x500000>;
> +			no-map;
> +		};
> +
>  		ipa_fw_mem: memory@8b700000 {
>  			reg = <0 0x8b700000 0 0x10000>;
>  			no-map;
> @@ -1398,6 +1403,76 @@
>  			};
>  		};
> 
> +		venus: video-codec@aa00000 {
> +			compatible = "qcom,sc7280-venus";
> +			reg = <0 0x0aa00000 0 0xd0600>;
> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&videocc VIDEO_CC_MVSC_CORE_CLK>,
> +				 <&videocc VIDEO_CC_MVSC_CTL_AXI_CLK>,
> +				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
> +				 <&videocc VIDEO_CC_MVS0_CORE_CLK>,
> +				 <&videocc VIDEO_CC_MVS0_AXI_CLK>;
> +			clock-names = "core", "bus", "iface",
> +				      "vcodec_core", "vcodec_bus";
> +
> +			power-domains = <&videocc MVSC_GDSC>,
> +					<&videocc MVS0_GDSC>,
> +					<&rpmhpd SC7280_CX>;
> +			power-domain-names = "venus", "vcodec0", "cx";
> +			operating-points-v2 = <&venus_opp_table>;
> +
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 0 &cnoc2 
> SLAVE_VENUS_CFG 0>,
> +					<&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>;
> +			interconnect-names = "cpu-cfg", "video-mem";
> +
> +			iommus = <&apps_smmu 0x2180 0x20>,
> +				 <&apps_smmu 0x2184 0x20>;
> +			memory-region = <&video_mem>;
> +
> +			video-decoder {
> +				compatible = "venus-decoder";
> +			};
> +
> +			video-encoder {
> +				compatible = "venus-encoder";
> +			};
> +
> +			video-firmware {
> +				iommus = <&apps_smmu 0x21a2 0x0>;
> +			};
> +
> +			venus_opp_table: venus-opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-133330000 {
> +					opp-hz = /bits/ 64 <133330000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-240000000 {
> +					opp-hz = /bits/ 64 <240000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +				};
> +
> +				opp-335000000 {
> +					opp-hz = /bits/ 64 <335000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +				};
> +
> +				opp-424000000 {
> +					opp-hz = /bits/ 64 <424000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +				};
> +
> +				opp-460000000 {
> +					opp-hz = /bits/ 64 <460000000>;
> +					required-opps = <&rpmhpd_opp_turbo>;
> +				};
> +			};
> +
> +		};
> +
>  		videocc: clock-controller@aaf0000 {
>  			compatible = "qcom,sc7280-videocc";
>  			reg = <0 0xaaf0000 0 0x10000>;
