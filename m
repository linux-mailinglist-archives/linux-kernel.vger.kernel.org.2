Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A883DBE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 20:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhG3SBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 14:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhG3SBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 14:01:36 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39A8C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 11:01:28 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so10386604oth.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Evxari8pyz24e9FIUREJeCKN2EWIhSQAii1TFXJzCCY=;
        b=pWmzybgP2uH6Xct/bn8VKXPNUZiel+66+a10yMo9Yn/cJ8M0EQS7jwwnAuhvGX2G9X
         ggGe847SFyPYasmJjqKZix0adboS+6nuToqhqGcvC14+ewLIIpQUNuPdeScqX0Xy84yi
         6GRQbGoC6lIPpYPJZjNUTUSd9plIKZgoUVnPDSLLh6k9HFCPbYraqFY3fIsdlMbZw1zQ
         HmOQgqQX8faAM6L/wj+BfpvqDZtOE8qKWWMxJk3oyLeAGMEORlCnc2+wnAhi3Eak0SWr
         KOJKRniimkig2YGVO2tFLkhUYKfQzQC+a27Xr79FyQpzyodqCoqoKDCxB3//ISBu+OV/
         bDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Evxari8pyz24e9FIUREJeCKN2EWIhSQAii1TFXJzCCY=;
        b=hS7kvKPfcMi0GNlfD50IsDNJjiEKosRErkOcIo/jOVW6dL6c79GFuBGu1QorgG6yV3
         SsM+wEvV+JZDgI+1UxHRNkvEZ9c5+32fRfzpOaBgAkNBz0p9UI2mK9Ma9tdUgBeNs13K
         GAf6hFdTDyuzthZNRALlqlptFiC95X/5C588o3yRd0Y1eXpO6wbIy/gcRB5nChPA0OB+
         8xlkbdDax+DVUV3fThcJqTdQE/1ZRx9KLn/AN5vGAmttjHMcXEziyvuZ9vFt+kpJWRJs
         /Atp/JjyhBeNFZO/qQKb5KJA19ffdko/c55T2ra7XlrBYdLeOzEzRnzCMCzrBNuvxkfO
         cbZA==
X-Gm-Message-State: AOAM53305G/IEKerIB0+bqQuK6ThKNeQJRbIOTtAgUIqYmxqi9kgPO9R
        PigbVYxdmNJj6m1rOIQy8Ufs9Q==
X-Google-Smtp-Source: ABdhPJyM20sXYUTWFCFT41x2cBXeSIY5u5HP5ptz2I1dplE37EBEWz2jsC/Tk56mQfPv4HM9TdjBpg==
X-Received: by 2002:a9d:67c8:: with SMTP id c8mr2937898otn.80.1627668088370;
        Fri, 30 Jul 2021 11:01:28 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b21sm343431oov.26.2021.07.30.11.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 11:01:27 -0700 (PDT)
Date:   Fri, 30 Jul 2021 13:01:25 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, will@kernel.org,
        saiprakash.ranjan@codeaurora.org, ohad@wizery.com,
        agross@kernel.org, mathieu.poirier@linaro.org,
        robin.murphy@arm.com, joro@8bytes.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, evgreen@chromium.org,
        dianders@chromium.org, swboyd@chromium.org
Subject: Re: [PATCH 8/9] arm64: dts: qcom: sc7280: Add Q6V5 MSS node
Message-ID: <YQQ+dV08CBERVTEK@builder.lan>
References: <1624564058-24095-1-git-send-email-sibis@codeaurora.org>
 <1624564058-24095-9-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624564058-24095-9-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 Jun 14:47 CDT 2021, Sibi Sankar wrote:

> This patch adds Q6V5 MSS PAS remoteproc node for SC7280 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 40 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 3fb6a6ef39f8..56ea172f641f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -584,6 +584,46 @@
>  			#power-domain-cells = <1>;
>  		};
>  
> +		remoteproc_mpss: remoteproc@4080000 {
> +			compatible = "qcom,sc7280-mpss-pas";
> +			reg = <0 0x04080000 0 0x10000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
> +					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
> +					      <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready", "handover",
> +					  "stop-ack", "shutdown-ack";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "xo";
> +
> +			power-domains = <&rpmhpd SC7280_CX>,
> +					<&rpmhpd SC7280_MSS>;
> +			power-domain-names = "cx", "mss";
> +
> +			memory-region = <&mpss_mem>;
> +
> +			qcom,qmp = <&aoss_qmp>;
> +
> +			qcom,smem-states = <&modem_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			glink-edge {
> +				interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
> +							     IRQ_TYPE_EDGE_RISING>;
> +				mboxes = <&ipcc IPCC_CLIENT_MPSS
> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +				label = "modem";
> +				qcom,remote-pid = <1>;
> +			};
> +		};
> +
>  		stm@6002000 {
>  			compatible = "arm,coresight-stm", "arm,primecell";
>  			reg = <0 0x06002000 0 0x1000>,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
