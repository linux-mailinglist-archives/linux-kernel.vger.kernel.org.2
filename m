Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18332441BDA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhKANmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:42:33 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:15463 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhKANmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:42:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635773999; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=oCiwHNpAGx+7qf4ko0KtXb5a49/AVJ95iHboNyo0CEo=;
 b=rTVnfd6y1S2+jkheATYPJ1ufg/mDicRJxAxaUil7QFptlvrA7FP0Vt2rUnFQhG+Im1dkePRj
 JKYamBH9auHnYWmOAFqiEKtZpD7HIcSOf//YgWQDQKBJOlT2xqeInBsNFU4P0EJjDvO2SHBq
 Nl3UDVkKotL4O/lPmCtU1C4zGyU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 617fee2d2e144ac4d3ef0af7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Nov 2021 13:39:57
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ED320C43617; Mon,  1 Nov 2021 13:39:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 435E1C4338F;
        Mon,  1 Nov 2021 13:39:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Nov 2021 19:09:56 +0530
From:   okukatla@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     georgi.djakov@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [v8 3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect
 provider
In-Reply-To: <YXsxxd7f/FaDJEMa@ripper>
References: <1634812857-10676-1-git-send-email-okukatla@codeaurora.org>
 <1634812857-10676-4-git-send-email-okukatla@codeaurora.org>
 <YXsxxd7f/FaDJEMa@ripper>
Message-ID: <fc4ef5ecd91401f49411cf138b0da526@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-29 04:57, Bjorn Andersson wrote:
> On Thu 21 Oct 03:40 PDT 2021, Odelu Kukatla wrote:
> 
>> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SC7280
>> SoCs.
>> 
>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index d74a4c8..0b55742 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -3687,6 +3687,14 @@
>>  			};
>>  		};
>> 
>> +		epss_l3: interconnect@18590000 {
>> +			compatible = "qcom,sc7280-epss-l3";
>> +			reg = <0 0x18590000 0 0x1000>;
> 
> This series looks like I would expect, with and without per-core dcvs.
> But can you please explain why this contradict what Sibi says here:
> https://lore.kernel.org/all/1627581885-32165-3-git-send-email-sibis@codeaurora.org/
> 
> Regards,
> Bjorn
> 
Thanks for Review!
Sibi's patch will be dropped, it is not required with my updated patch 
series:
https://lore.kernel.org/all/1627581885-32165-3-git-send-email-sibis@codeaurora.org/
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
>> +			clock-names = "xo", "alternate";
>> +			#interconnect-cells = <1>;
>> +		};
>> +
>>  		cpufreq_hw: cpufreq@18591000 {
>>  			compatible = "qcom,cpufreq-epss";
>>  			reg = <0 0x18591000 0 0x1000>,
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
