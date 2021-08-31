Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA85B3FCACB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbhHaP3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 11:29:04 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:34269 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbhHaP3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:29:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630423688; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=nmKEbkSuY2RnP7KLT63dJ0C90x1N8qxDPcQ6rziQld4=;
 b=nSLQnW7U9S2fUDrFtQhAmV9wc11iHZDSdKC28BH4UWw5aAkeRzI4iXaKX+D3xKYFAQA2qBTy
 GPVXIrb9IeLrX+s8c3lArzOe2XLabfrS8YQcCrElyESIfPmlKXhAZh5S70Ia/elJzq9XNMbX
 KjLpOHQYoqN9fPBQY+EfoQXxCRA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 612e4a864cd9015037054101 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 31 Aug 2021 15:28:06
 GMT
Sender: rajpat=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 150A0C43619; Tue, 31 Aug 2021 15:28:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rajpat)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 353D9C43616;
        Tue, 31 Aug 2021 15:28:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Aug 2021 20:58:05 +0530
From:   rajpat@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org
Subject: Re: [PATCH V6 3/7] arm64: dts: sc7280: Add QUPv3 wrapper_0 nodes
In-Reply-To: <CAE-0n51BUENLOP2vxg+HTfNyGZ9216tTpSQQot9_aZvJW_s-Ow@mail.gmail.com>
References: <1629983731-10595-1-git-send-email-rajpat@codeaurora.org>
 <1629983731-10595-4-git-send-email-rajpat@codeaurora.org>
 <CAE-0n51BUENLOP2vxg+HTfNyGZ9216tTpSQQot9_aZvJW_s-Ow@mail.gmail.com>
Message-ID: <3705bbd8df5e54b3bd3b9fea18253fc0@codeaurora.org>
X-Sender: rajpat@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-26 23:36, Stephen Boyd wrote:
> Quoting Rajesh Patil (2021-08-26 06:15:27)
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index f8dd5ff..da3cf19 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -434,6 +434,25 @@
>>                 };
>>         };
>> 
>> +       qup_opp_table: qup-opp-table {
> 
> Surely this could be placed under /soc@0/geniqup@9c0000 alongside the
> other devices and the node name could be opp-table?

placed under /soc@0/geniqup@9c0000. No errors/warnings are observed.
We can place it under /soc@0/geniqup@9c0000

> 
>> +               compatible = "operating-points-v2";
>> +
>> +               opp-75000000 {
>> +                       opp-hz = /bits/ 64 <75000000>;
>> +                       required-opps = <&rpmhpd_opp_low_svs>;
>> +               };
>> +
>> +               opp-100000000 {
>> +                       opp-hz = /bits/ 64 <100000000>;
>> +                       required-opps = <&rpmhpd_opp_svs>;
>> +               };
>> +
>> +               opp-128000000 {
>> +                       opp-hz = /bits/ 64 <128000000>;
>> +                       required-opps = <&rpmhpd_opp_nom>;
>> +               };
>> +       };
>> +
>>         soc: soc@0 {
>>                 #address-cells = <2>;
>>                 #size-cells = <2>;
>> @@ -536,24 +555,425 @@
>>                 qupv3_id_0: geniqup@9c0000 {
>>                         compatible = "qcom,geni-se-qup";
>>                         reg = <0 0x009c0000 0 0x2000>;
>> -                       clock-names = "m-ahb", "s-ahb";
>>                         clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>>                                  <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
>> +                       clock-names = "m-ahb", "s-ahb";
>>                         #address-cells = <2>;
>>                         #size-cells = <2>;
>>                         ranges;
>> +                       iommus = <&apps_smmu 0x123 0x0>;
>>                         status = "disabled";
>> 
> [...]
>> @@ -1575,11 +1995,311 @@
>>                                 function = "qspi_data";
>>                         };
>> 
>> +                       qup_i2c0_data_clk:qup-i2c0-data-clk {
> 
> Please unstick the colon from the node name.

Okay

> 
> 	qup_i2c0_data_clk: qup-i2c0-data-clk {
> 
> 	};
> 
>> +                               pins = "gpio0", "gpio1";
>> +                               function = "qup00";
>> +                       };
>> +
>> +                       qup_i2c1_data_clk:qup-i2c1-data-clk {
>> +                               pins = "gpio4", "gpio5";
>> +                               function = "qup01";
>> +                       };
>> +
>> +                       qup_i2c2_data_clk:qup-i2c2-data-clk {
>> +                               pins = "gpio8", "gpio9";
>> +                               function = "qup02";
>> +                       };
>> +
>> +                       qup_i2c3_data_clk:qup-i2c3-data-clk {
>> +                               pins = "gpio12", "gpio13";
>> +                               function = "qup03";
>> +                       };
>> +
>> +                       qup_i2c4_data_clk:qup-i2c4-data-clk {
>> +                               pins = "gpio16", "gpio17";
>> +                               function = "qup04";
>> +                       };
>> +
>> +                       qup_i2c5_data_clk:qup-i2c5-data-clk {
>> +                               pins = "gpio20", "gpio21";
>> +                               function = "qup05";
>> +                       };
>> +
>> +                       qup_i2c6_data_clk:qup-i2c6-data-clk {
>> +                               pins = "gpio24", "gpio25";
>> +                               function = "qup06";
>> +                       };
>> +
>> +                       qup_i2c7_data_clk:qup-i2c7-data-clk {
>> +                               pins = "gpio28", "gpio29";
>> +                               function = "qup07";
>> +                       };
>> +
> 
> For all of these.
