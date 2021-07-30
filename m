Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D913DBE09
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 20:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhG3SAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 14:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhG3SAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 14:00:53 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38797C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 11:00:48 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id z6-20020a9d24860000b02904d14e47202cso1650535ota.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wKcp94SXlzIL+rKCJfhPFUl8LwJ46IN+eIJM4QxPZ7Y=;
        b=EIHXCA0v5HstLP8hONQu8hfyiem8F2OPnEU12vCIXh/sEG7ViYP2/eNlFr4qce/DvY
         opBMGdlt5DgiSconUiX4fUNfVtnhFxxMOeOtk0D16LIjqHr3WAjtOBtXaPpk7qlHlZvy
         Zl7NKWloBgA6t0FMJK4jJTMo4Q5KycaUkVVsNqPi5VsysqdtP3UEroZANW3nEVYgWb0v
         EEVcZ5k+y11FysJUAJJLjiP68P0SNdVYMm2note2FhgLoUDg0TH4mihG8Z+NDW6GiyKP
         7m2kbVSWI0zKYntLcB+qREW5oqPt1wdQKHthhZ0cdvMiJs8gjEQI59q1so2vyNrsofRP
         Zy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wKcp94SXlzIL+rKCJfhPFUl8LwJ46IN+eIJM4QxPZ7Y=;
        b=MLIhPz2iRFLUmE4lcQbZMUfeXBi/RA9jRTFT/5fJXLHgqiZAeTa9H1g2UsQIZ4ICqX
         7zCA0eTPrxa7lzgUkmjv/ginTLeMne6EdcYSlM2KPCIb5HMSoEyZvFQ/fl+fNixetxNP
         s341vKr9g54ua4aGIa8e1SSVmWt2e12f8a1nvRZjCy4TkNfVlcIGfLNW8lS3B2J4udj5
         BkhBas4Hq5Jo9i8vOjNlOEQM/R6r1FZnc3noR0QsiV3Gnjx8fqToXHzq4VPb6TUfO+dx
         0QscOV+Ho95Wn4iP6JSmYRR9Knl1eeks7Ai2ApfJ3+0pgn0lFkXlhU2cK/Kwt2DdfVe2
         t5rg==
X-Gm-Message-State: AOAM531iuMnw4SV5H1fVR5aAhuNVefqDfUt/2MqsYuDSE6ZURUMfI96w
        HZHU0vIK9zPWkz5GbIfOSs50Rg==
X-Google-Smtp-Source: ABdhPJyXm3/c/DZWJx3M2wBcbj3susmf4EJpEeDHUy1dhDVv4ayHUWMRlCgXopkCSWt+HrWBQd08cg==
X-Received: by 2002:a05:6830:114f:: with SMTP id x15mr2924468otq.356.1627668047529;
        Fri, 30 Jul 2021 11:00:47 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b16sm402742otl.59.2021.07.30.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 11:00:46 -0700 (PDT)
Date:   Fri, 30 Jul 2021 13:00:44 -0500
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
Subject: Re: [PATCH 7/9] arm64: dts: qcom: sc7280: Add nodes to boot modem
Message-ID: <YQQ+TIpB6zQYrzBq@builder.lan>
References: <1624564058-24095-1-git-send-email-sibis@codeaurora.org>
 <1624564058-24095-8-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624564058-24095-8-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 Jun 14:47 CDT 2021, Sibi Sankar wrote:

> Add miscellaneous nodes to boot the modem and support post-mortem debug
> on SC7280 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 5ed7a511bfc9..3fb6a6ef39f8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -547,6 +547,11 @@
>  			#hwlock-cells = <1>;
>  		};
>  
> +		tcsr_regs: syscon@1fc0000 {

Is there a different "tcsr"? Does the "_regs" suffix add any value?

> +			compatible = "syscon";

Rob has pointed out a few times that a lone "syscon" isn't going to be
accepted going forward. Could you also add a qualifying
"qcom,sc7280-tcsr" or something like that?

> +			reg = <0 0x01fc0000 0 0x30000>;
> +		};
> +
>  		lpasscc: lpasscc@3000000 {
>  			compatible = "qcom,sc7280-lpasscc";
>  			reg = <0 0x03000000 0 0x40>,
> @@ -1219,6 +1224,21 @@
>  			};
>  		};
>  
> +		imem@146aa000 {
> +			compatible = "syscon", "simple-mfd";

As above "qcom,sc7280-imem"?

I presume we need some new binding documents for these two though,
perhaps you can add the specific compatibles and we agree that one of us
will write these two bindings soon?

Regards,
Bjorn

> +			reg = <0 0x146aa000 0 0x2000>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +
> +			ranges = <0 0x0 0 0x146aa000 0 0x2000>;
> +
> +			pil-reloc@94c {
> +				compatible = "qcom,pil-reloc-info";
> +				reg = <0 0x94c 0 0xc8>;
> +			};
> +		};
> +
>  		apps_smmu: iommu@15000000 {
>  			compatible = "qcom,sc7280-smmu-500", "arm,mmu-500";
>  			reg = <0 0x15000000 0 0x100000>;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
