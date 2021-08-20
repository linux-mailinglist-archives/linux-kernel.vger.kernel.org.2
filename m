Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1443F2DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbhHTOKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:10:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29895 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240308AbhHTOKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:10:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629468579; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=fVCSE7hz6ko9DvjFHxEH90YGtVAG7qCFoGVMBJSP10E=;
 b=Y3F3waGpo6yWRskGWQCu4Ygrx4/+jX1h1LTk7vYDZRBSUarKTiH2d/guQbF8/bXFReV0cxFN
 9tUygJzjYo8AnQhJ3yJ7yZdlKRR8KzZzO9w7bhl9MwCgQS7KHd0jv2rNRtN13/m7VJyYQe6l
 4IcW5E1UgC/qD5Jo0IqT+7wke5w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 611fb7912b9e91b688427465 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Aug 2021 14:09:21
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 78CEBC4361B; Fri, 20 Aug 2021 14:09:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E786C4338F;
        Fri, 20 Aug 2021 14:09:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Aug 2021 19:39:20 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org, will@kernel.org,
        saiprakash.ranjan@codeaurora.org, swboyd@chromium.org,
        mka@chromium.org, ohad@wizery.com, agross@kernel.org,
        mathieu.poirier@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        evgreen@chromium.org, dianders@chromium.org
Subject: Re: [PATCH v3 06/10] arm64: dts: qcom: sc7280: Update reserved memory
 map
In-Reply-To: <YR3gAD68xRtNJRhi@matsya>
References: <1629344185-27368-1-git-send-email-sibis@codeaurora.org>
 <1629344185-27368-7-git-send-email-sibis@codeaurora.org>
 <YR3gAD68xRtNJRhi@matsya>
Message-ID: <39da02506af192de14d346cdf80d0e4c@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-19 10:07, Vinod Koul wrote:
> Hi Sibi,
> 
> On 19-08-21, 09:06, Sibi Sankar wrote:
> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 5e4f4f3b738a..894106efadfe 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -48,6 +48,16 @@
>>  		#size-cells = <2>;
>>  		ranges;
>> 
>> +		hyp_mem: memory@80000000 {
>> +			reg = <0x0 0x80000000 0x0 0x600000>;
>> +			no-map;
> 
> This should conflict with the memory defined in this file:
> 
>         memory@80000000 {
>                 device_type = "memory";
>                 /* We expect the bootloader to fill in the size */
>                 reg = <0 0x80000000 0 0>;
>         };
> 
> I think this should be updated?

Vinod,

I prefer we leave ^^ node untouched.
For platforms using hyp_mem, the
regions defined in the memory map
are valid and for the other platforms
not using hyp_mem we would just delete
them in the board files anyway.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
