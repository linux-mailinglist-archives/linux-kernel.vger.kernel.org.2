Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE383A6600
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbhFNLsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:48:15 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:62713 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbhFNLrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:47:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623671113; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=VXWfaVYANDFX04xazAUANgMt/zKygU+c1glIF9BKnto=;
 b=CJHiqdVlqTY7l64oBdjIOI2RjmvEE0TggLCFWfyqWmzeIQroG9pGc5u9esNPvYzJgUq5H76F
 2rXjNoV8WgPceJiQGaRiT1cBVvc1H5Vk/V8dlk6NG5Onh5S77+yBadDn6sLsh/YbBKPWvPkZ
 sGpFELX8V+vqVRZNtk5yf9fGvs8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60c7413ab6ccaab75349076a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Jun 2021 11:44:58
 GMT
Sender: sbhanu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64D36C433D3; Mon, 14 Jun 2021 11:44:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sbhanu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF012C433F1;
        Mon, 14 Jun 2021 11:44:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Jun 2021 17:14:57 +0530
From:   sbhanu@codeaurora.org
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        rampraka@codeaurora.org, sayalil@codeaurora.org,
        sartgarg@codeaurora.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, sibis@codeaurora.org,
        okukatla@codeaurora.org, djakov@kernel.org, cang@codeaurora.org,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH V1] arm64: dts: qcom: sc7180: Added xo clock for eMMC and
 Sd card
In-Reply-To: <dd685abc-c332-cd0c-af6a-d2f1116cef05@somainline.org>
References: <1623309107-27833-1-git-send-email-sbhanu@codeaurora.org>
 <dd685abc-c332-cd0c-af6a-d2f1116cef05@somainline.org>
Message-ID: <b37cd4429600383619e4a1375802aeb6@codeaurora.org>
X-Sender: sbhanu@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-10 13:24, Konrad Dybcio wrote:
> Hi,
> 
> 
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -701,8 +701,9 @@
>>  			interrupt-names = "hc_irq", "pwr_irq";
>> 
>>  			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
>> -					<&gcc GCC_SDCC1_AHB_CLK>;
>> -			clock-names = "core", "iface";
>> +					<&gcc GCC_SDCC1_AHB_CLK>,
>> +					<&rpmhcc RPMH_CXO_CLK>;
> 
> Don't these clocks fit in 100 chars?
These two clocks can fit in 100 chars but we have 3 clocks they don't 
fit in 100 chars.
> 
> 
> 
>> +			clock-names = "core", "iface","xo";
> 
> A space is missing before "xo".
Sure
> 
> 
> 
>>  			interconnects = <&aggre1_noc MASTER_EMMC 0 &mc_virt SLAVE_EBI1 0>,
>>  					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_EMMC_CFG 0>;
>>  			interconnect-names = "sdhc-ddr","cpu-sdhc";
>> @@ -2666,8 +2667,9 @@
>>  			interrupt-names = "hc_irq", "pwr_irq";
>> 
>>  			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
>> -					<&gcc GCC_SDCC2_AHB_CLK>;
>> -			clock-names = "core", "iface";
>> +					<&gcc GCC_SDCC2_AHB_CLK>,
>> +					<&rpmhcc RPMH_CXO_CLK>;
> 
> Ditto
Same as above
> 
> 
> 
> Konrad
