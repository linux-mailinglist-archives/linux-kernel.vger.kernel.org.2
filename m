Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109FB3DE571
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 06:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhHCEgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 00:36:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59142 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233836AbhHCEeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 00:34:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627965247; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=wrdeL63EpfiHuLivTRuqRl1jTMPJRFK0P49w0g47988=; b=qzHGSVpPLzT86gZbRjBhx13F3bd0Tn7zMH8+4xibCIu/rz4xGJcA3O25Np8V/STAEdhidoEm
 eY/IBxC3K72fVts9mxFtq1NuivJF4YyfdYIy5A0dtGiJtpk2hdpMMSERGAqExTMC+STEgeeH
 +RMT8jCphIQ6Re2rZu2cL0XkwHU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6108c71317c2b4047d6eb790 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Aug 2021 04:33:23
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5E780C4360C; Tue,  3 Aug 2021 04:33:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [49.207.203.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49604C4338A;
        Tue,  3 Aug 2021 04:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49604C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280-idp: Add device tree files
 for IDP2
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, skakit@codeaurora.org
References: <1627897145-28020-1-git-send-email-rnayak@codeaurora.org>
 <1627897145-28020-3-git-send-email-rnayak@codeaurora.org>
 <aedc1f03-59ef-ca17-59e6-a6464367990d@somainline.org>
 <bb608936-65e0-ed68-9410-44a40faf2f61@codeaurora.org>
Message-ID: <029e9d59-ced7-af14-3e9e-2c7a62671abf@codeaurora.org>
Date:   Tue, 3 Aug 2021 10:03:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <bb608936-65e0-ed68-9410-44a40faf2f61@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2021 6:06 PM, Rajendra Nayak wrote:
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
>>> index 73225e3..f014cda 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
>>> @@ -7,19 +7,12 @@
>>>   /dts-v1/;
>>> -#include <dt-bindings/gpio/gpio.h>
>>> -#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
  
I re-read your comment and I guess you meant this ^^^ header include
should stay too, and that's right, I seem to have wrongly moved it
to the common dtsi, will fix when I respost. thanks.

>>> -#include <dt-bindings/iio/qcom,spmi-adc7-pmr735b.h>
>>
>> Don't you want pmr735a include to stay here in SKU1 and not be included in the common one, as the hw is not present on sku2?
> []..
>>>   #include "pmr735a.dtsi"
> 
> Right, that's why this ^^^ include stays here and is not part of the common dtsi.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
