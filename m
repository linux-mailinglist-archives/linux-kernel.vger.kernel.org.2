Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCAD3A8CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhFOXlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhFOXls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:41:48 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9E0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:39:42 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t140so518541oih.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ul/bka2jdtYOr+6+mrjnF59qa6vN2c7evd5ICsLCQTY=;
        b=k90rWATbXwMXpvZDjiDnSOm/OONvvKm1J+Frq6NYtOguQ5A9cHqRup9vYFd3s/Eg3X
         7MEpMnZqPE7FUk87YQS2IYqIPebW9ccEEhnx3l4/cDYVfHeHxO0Ji3YMrK6+Yb9hqPpR
         4j+LC7OI6Ic2m9P4DkH+bRkm5Wm+0q7BYtaYKhFtza3xYZAKa8lw4CtpT+wHzlQ6qD3z
         rCt55BBaEKG8LX0ipDridUsoQnpGMrLRnfP5Ok5PuDBf2+fwWCQb4OCLhCyKfhCWkAb0
         Id+PUAsXCSE7hDJrCxjyyDJbAhXtbw1FNGvUwXaK782FHmq9IpmIePIDVkr2ukQqfWYS
         iuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ul/bka2jdtYOr+6+mrjnF59qa6vN2c7evd5ICsLCQTY=;
        b=eO8NHs/f6FFGU+Pl9ZSIe0+urabq2iRJ9xE7IX1PJCItZl6G7j9GcMjoF4TlD6AOr0
         RqFQevP+TElb4cUB9n814Vswv0IJsYq6qbqIQesS2qJksjhuXDoEwns2sesyOp6mrl/m
         KaMuaddOv2K5hl1t05L74IKu21KmwfKUF8uUpA5OsvGc96qUT8GAxBIqZUz/E7k3GyJC
         AwXOhrz01+yIstHwsEJK37bdllWPqrsN9YSHENCiMuzWnuQASZEf81K+Z05gpdAnCixt
         Q6hCAbRCrvKh9gbdT+HYqb0STHnwR6dcHNI9tWQdfS/Q/x9o5pEDWMQIYEtrB7u1GAbW
         FTaw==
X-Gm-Message-State: AOAM533rHHZ/qxwsVwHvFXAUkM+kSxYxZqL779+PYuChvUqOFf7rYGmf
        hOyqEnKbkRuOuSnxy4mCvF4dQA==
X-Google-Smtp-Source: ABdhPJzDIW4lkQu/ywpISJIZTM6b/WRNsbdsG07oLqrkILQLbtGE/mwsdjzwqygLzfu76nKMwciakw==
X-Received: by 2002:a05:6808:10a:: with SMTP id b10mr4823404oie.65.1623800381917;
        Tue, 15 Jun 2021 16:39:41 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l12sm92506oig.49.2021.06.15.16.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 16:39:41 -0700 (PDT)
Date:   Tue, 15 Jun 2021 18:39:39 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8250: Add SDHCI2 pinctrl
Message-ID: <YMk6O1HVRfVvX79/@builder.lan>
References: <20210612192358.62602-1-konrad.dybcio@somainline.org>
 <20210612192358.62602-2-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612192358.62602-2-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 12 Jun 14:23 CDT 2021, Konrad Dybcio wrote:

> Add required pins for SDHCI2, so that the interface can work reliably.
> The configuration comes from a MTP board, which conveniently means it's
> going to be correct for the vast majority of phones (and other devices).
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v1:
> - Separate this into its own patch
> 
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 32 ++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index fc1049c2bb11..fe858abbff5d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/clock/qcom,gcc-sm8250.h>
>  #include <dt-bindings/clock/qcom,gpucc-sm8250.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>  #include <dt-bindings/interconnect/qcom,sm8250.h>
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
> @@ -2157,6 +2158,10 @@ sdhc_2: sdhci@8804000 {
>  			power-domains = <&rpmhpd SM8250_CX>;
>  			operating-points-v2 = <&sdhc2_opp_table>;
>  
> +			cd-gpios = <&tlmm 77 GPIO_ACTIVE_HIGH>;
> +			pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
> +			pinctrl-names = "default";
> +
>  			status = "disabled";
>  
>  			sdhc2_opp_table: sdhc2-opp-table {
> @@ -3401,6 +3406,33 @@ ws {
>  					output-high;
>  				};
>  			};
> +
> +			sdc2_default_state: sdc2-default {
> +				clk {
> +					pins = "sdc2_clk";
> +					drive-strength = <16>;

The fact that RB5 has these as 16/10/10 seems to show that these should
be board-specific (as we typically have them). So please follow that.


(The sleep state on other hand is not going to change, so that I'm okay
with you define here for all boards to use).

Regards,
Bjorn

> +					bias-disable;
> +				};
> +
> +				cmd {
> +					pins = "sdc2_cmd";
> +					drive-strength = <16>;
> +					bias-pull-up;
> +				};
> +
> +				data {
> +					pins = "sdc2_data";
> +					drive-strength = <16>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			sdc2_card_det_n: sd-card-det-n {
> +				pins = "gpio77";
> +				function = "gpio";
> +				bias-pull-up;
> +				drive-strength = <2>;
> +			};
>  		};
>  
>  		apps_smmu: iommu@15000000 {
> -- 
> 2.32.0
> 
