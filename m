Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD26A33A20D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 01:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhCNA3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 19:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhCNA20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 19:28:26 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451B7C061763
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 16:28:26 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id e7so51434677lft.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 16:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RDiaiHNDOowe5jQki643A3xOuMfqopZF6nzHitRidSU=;
        b=zNin9YFxbn4jP/WSl2Ry7lzo/DqvrI2j61l4QhNtXW7pAzn6XrnsbOhSyjrupqT5HX
         VTLmkMq92u7x5NXEBPuwLzVaR1m/8dYW77F7XKMAm/FEAafcNjhpiUgt84tup+0UE4Fn
         mEHODXtIlDElkQMHRFaI5nBklTUc0T5sugx3LaRUDfyKL+izxuRODkY96rfZDxYQBT/U
         EYguqpw4QMOP6uvqGkbHLBzaumLYwiQudKWS6bkRA9ry6FCV8teiOugwVkXZGzlKxIUx
         z2Q4Ut69nBvKJutKlY+DdBgE6BjQu1cVzjZxKq4MwaFKcyOTUBqsZb2+QPMJo6ExfZzg
         KuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RDiaiHNDOowe5jQki643A3xOuMfqopZF6nzHitRidSU=;
        b=YXO54MIpnZmkfu1PuiJGGwBJ8kftTYzgefj53fAQjUXBtqoKEgjvSJy0hWrAPOoxC7
         T9t8H2pQbu38Qz2xDkINaqsdOgqskJvbUiG6Z5jGEFdzWmJ/xQx6nxp7VNzTAaKF9Ox1
         4gVV6S1ErMJun6SMmIk3hNrDd1oDMTct2xY21SP6UhPbaFoBUp/bjMYLF3BbGcArxCt8
         fTfNQIfUp4olg6C7yR2g+B1Hox3ZPjbNjo0v2Q/ywxqVNJy4qJXAWnitnao15qyrfkwF
         LbQFGwjrBYHEsCbktNWUysh+dDchsar+1vb02xV35gP4lu4c590Xc2aMlsYHccXAOFI5
         Sfmg==
X-Gm-Message-State: AOAM530EOkymeoP20A31zEiAfkKlJGwqwyrZ6ASMwtxQGGHhKg/tqH/8
        Ec9oWf9eeh99lFDx4mzJwVwPf9K8TuI2EA==
X-Google-Smtp-Source: ABdhPJz74igCjmIXuAjJjsquRvfYVB+M/ShX6fidGHxJrhjzSZIv/UIxKuRq5YZWx1oA/kdtsSgGUg==
X-Received: by 2002:a05:6512:ac7:: with SMTP id n7mr3843977lfu.567.1615681704408;
        Sat, 13 Mar 2021 16:28:24 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e11sm2144840lfc.141.2021.03.13.16.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Mar 2021 16:28:24 -0800 (PST)
Subject: Re: [PATCH 01/13] arm64: dts: qcom: sc7180: Update dts for DP phy
 inside QMP phy
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210225221310.1939599-1-dianders@chromium.org>
 <20210225141022.1.Iad06142ceb8426ce5492737bf3d9162ed0dd2b55@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <ee5695bb-a603-0dd5-7a7f-695e919b1af1@linaro.org>
Date:   Sun, 14 Mar 2021 03:28:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225141022.1.Iad06142ceb8426ce5492737bf3d9162ed0dd2b55@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2021 01:12, Douglas Anderson wrote:
> From: Stephen Boyd <swboyd@chromium.org>
> 
> Drop the old node and add the new one in its place.
> 
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
> Cc: Chandan Uddaraju <chandanu@codeaurora.org>
> Cc: Vara Reddy <varar@codeaurora.org>
> Cc: Tanmay Shah <tanmay@codeaurora.org>
> Cc: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> [dianders: Adjusted due to DP not itself not in upstream dts yet]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 1ea3344ab62c..60248a6757d8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -2770,12 +2770,11 @@ usb_1_hsphy: phy@88e3000 {
>   		};
>   
>   		usb_1_qmpphy: phy-wrapper@88e9000 {
> -			compatible = "qcom,sc7180-qmp-usb3-phy";
> +			compatible = "qcom,sc7180-qmp-usb3-dp-phy";
>   			reg = <0 0x088e9000 0 0x18c>,
> -			      <0 0x088e8000 0 0x38>;
> -			reg-names = "reg-base", "dp_com";
> +			      <0 0x088e8000 0 0x38>,

Technically this should be 0x3c. Offset 0x38 is USB3_DP_COM_REVISION_ID3 
(not used by the current driver though).

> +			      <0 0x088ea000 0 0x40>;

I think 0x40 is not enough here.
This is a serdes region and qmp_v3_dp_serdes_tbl contains registers 
0x148 and 0x154.

>   			status = "disabled";
> -			#clock-cells = <1>;
>   			#address-cells = <2>;
>   			#size-cells = <2>;
>   			ranges;
> @@ -2790,7 +2789,7 @@ usb_1_qmpphy: phy-wrapper@88e9000 {
>   				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
>   			reset-names = "phy", "common";
>   
> -			usb_1_ssphy: phy@88e9200 {
> +			usb_1_ssphy: usb3-phy@88e9200 {
>   				reg = <0 0x088e9200 0 0x128>,
>   				      <0 0x088e9400 0 0x200>,
>   				      <0 0x088e9c00 0 0x218>,
> @@ -2803,6 +2802,16 @@ usb_1_ssphy: phy@88e9200 {
>   				clock-names = "pipe0";
>   				clock-output-names = "usb3_phy_pipe_clk_src";
>   			};
> +
> +			dp_phy: dp-phy@88ea200 {
> +				reg = <0 0x088ea200 0 0x200>,
> +				      <0 0x088ea400 0 0x200>,
> +				      <0 0x088eaa00 0 0x200>,
> +				      <0 0x088ea600 0 0x200>,
> +				      <0 0x088ea800 0 0x200>;
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +			};
>   		};
>   
>   		dc_noc: interconnect@9160000 {
> @@ -3166,8 +3175,8 @@ dispcc: clock-controller@af00000 {
>   				 <&gcc GCC_DISP_GPLL0_CLK_SRC>,
>   				 <&dsi_phy 0>,
>   				 <&dsi_phy 1>,
> -				 <0>,
> -				 <0>;
> +				 <&dp_phy 0>,
> +				 <&dp_phy 1>;
>   			clock-names = "bi_tcxo",
>   				      "gcc_disp_gpll0_clk_src",
>   				      "dsi0_phy_pll_out_byteclk",
> 


-- 
With best wishes
Dmitry
