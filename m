Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCA439AD4D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhFCV6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:58:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10753 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhFCV6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:58:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622757405; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=85uDWnmNo6inlorp38hf6id8NLKbX4u0nc6nTll7g+0=;
 b=Guq+dESFF8yQ/mdezUUfge/1ncJuN7QlbdVskr+wD2+iP0YHuVDS5m/tbttqxb1hS/oe0HOF
 AxD9kT6a7rbLyWKHApiN/HaTY5rnHSx0Oja5+xIDzn5LMtVslC65ISA7gJA7Ke8Judumth82
 k+imo3MWIqt3L//9qY+L0Qb7PBI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60b95016e27c0cc77f1ab85b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Jun 2021 21:56:38
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D4CFC4338A; Thu,  3 Jun 2021 21:56:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D4F1C433D3;
        Thu,  3 Jun 2021 21:56:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Jun 2021 14:56:36 -0700
From:   khsieh@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, agross@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/dts/qcom/sc7180: Add Display Port dt node
In-Reply-To: <YLkI/6ItCz+SbbuJ@yoga>
References: <1622736555-15775-1-git-send-email-khsieh@codeaurora.org>
 <YLkI/6ItCz+SbbuJ@yoga>
Message-ID: <ac326ec8689c0babb08b2311e19d52cc@codeaurora.org>
X-Sender: khsieh@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-03 09:53, Bjorn Andersson wrote:
> On Thu 03 Jun 11:09 CDT 2021, Kuogee Hsieh wrote:
> 
>> Add DP device node on sc7180.
>> 
>> Changes in v2:
>> -- replace msm_dp with dp
>> -- replace dp_opp_table with opp_table
>> 
> 
> I'm sorry for those suggestions, I don't like either one of them.
> 
> And for everything but changes to the DRM code the changelog goes below
> the --- line, so it's not part of the git history.
> 
>> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi |  9 ++++
>>  arch/arm64/boot/dts/qcom/sc7180.dtsi         | 78 
>> ++++++++++++++++++++++++++++
>>  2 files changed, 87 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> index 24d293e..40367a2 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> @@ -786,6 +786,15 @@ hp_i2c: &i2c9 {
>>  	status = "okay";
>>  };
>> 
>> +&dp {
>> +        status = "okay";
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&dp_hot_plug_det>;
>> +        data-lanes = <0 1>;
> 
> Is it a limitation of the EC in Trogdor that you can only do 2 lanes?
> 
>> +        vdda-1p2-supply = <&vdda_usb_ss_dp_1p2>;
>> +        vdda-0p9-supply = <&vdda_usb_ss_dp_core>;
>> +};
>> +
>>  &pm6150_adc {
>>  	charger-thermistor@4f {
>>  		reg = <ADC5_AMUX_THM3_100K_PU>;
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index 6228ba2..05a4133 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -3032,6 +3032,13 @@
>>  							remote-endpoint = <&dsi0_in>;
>>  						};
>>  					};
>> +
>> +					port@2 {
>> +						reg = <2>;
>> +						dpu_intf0_out: endpoint {
>> +							remote-endpoint = <&dp_in>;
>> +						};
>> +					};
>>  				};
>> 
>>  				mdp_opp_table: mdp-opp-table {
>> @@ -3148,6 +3155,77 @@
>> 
>>  				status = "disabled";
>>  			};
>> +
>> +			dp: displayport-controller@ae90000 {
> 
> If you label this "mdss_dp", then it will naturally group with other
> mdss properties in trogdor.dtsi (which should be sorted 
> alphabetically).
> 
>> +				compatible = "qcom,sc7180-dp";
>> +				status = "disabled";
>> +
>> +				reg = <0 0x0ae90000 0 0x1400>;
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <12>;
>> +
>> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
>> +				clock-names = "core_iface", "core_aux", "ctrl_link",
>> +					      "ctrl_link_iface", "stream_pixel";
>> +				#clock-cells = <1>;
>> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
>> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
>> +				assigned-clock-parents = <&dp_phy 0>, <&dp_phy 1>;
>> +				phys = <&dp_phy>;
>> +				phy-names = "dp";
>> +
>> +				operating-points-v2 = <&opp_table>;
>> +				power-domains = <&rpmhpd SC7180_CX>;
> 
> Just curious, but isn't the DP block in the MDSS_GDCS? Or do we need to
> mention CX here in order for the opp framework to apply required-opps
> of CX?

yes,
> 
>> +
>> +				#sound-dai-cells = <0>;
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +					port@0 {
>> +						reg = <0>;
>> +						dp_in: endpoint {
>> +							remote-endpoint = <&dpu_intf0_out>;
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +						dp_out: endpoint { };
>> +					};
>> +				};
>> +
>> +				opp_table: dp-opp-table {
> 
> The one and only "opp_table" of the sc7180 :)
> Maybe name it dp_opp_table instead?
> 
> Regards,
> Bjorn
> 
>> +					compatible = "operating-points-v2";
>> +
>> +					opp-160000000 {
>> +						opp-hz = /bits/ 64 <160000000>;
>> +						required-opps = <&rpmhpd_opp_low_svs>;
>> +					};
>> +
>> +					opp-270000000 {
>> +						opp-hz = /bits/ 64 <270000000>;
>> +						required-opps = <&rpmhpd_opp_svs>;
>> +					};
>> +
>> +					opp-540000000 {
>> +						opp-hz = /bits/ 64 <540000000>;
>> +						required-opps = <&rpmhpd_opp_svs_l1>;
>> +					};
>> +
>> +					opp-810000000 {
>> +						opp-hz = /bits/ 64 <810000000>;
>> +						required-opps = <&rpmhpd_opp_nom>;
>> +					};
>> +				};
>> +			};
>> +
>> +
>>  		};
>> 
>>  		dispcc: clock-controller@af00000 {
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
