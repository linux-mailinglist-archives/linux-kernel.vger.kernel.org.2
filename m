Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1374A36B6F6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhDZQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:38:41 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:48933 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbhDZQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:38:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619455077; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=MwZtQZwxYVMfvcMJM/LAQDKQUnmrTA2FuuaM3k/nD5U=; b=na7U4kHWilP8hbFXnw1Rv2zkrV9jiiN7upjMOeISH/4LmFeCRqHmlLCuYE/x+SlaPSJdWxbh
 YM6IS2/I5HG7UgT9qjEVUYJZzkWihWfBsYgOHc50PVW0tCyfZJwc1Xehknkx/4SihqdsfuRi
 FX/JSdGBuN5GCZ7qgufFJaUP6z4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6086ec56853c0a2c4692ff95 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Apr 2021 16:37:42
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 69833C4360C; Mon, 26 Apr 2021 16:37:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.50.4.30] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8FE48C433D3;
        Mon, 26 Apr 2021 16:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FE48C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] dt-bindings: watchdog: Add compatible for SC7280 SoC
To:     Guenter Roeck <linux@roeck-us.net>, wim@linux-watchdog.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
References: <1615788301-29891-1-git-send-email-rnayak@codeaurora.org>
 <9f28f60b-379b-c384-6049-e5e5294b80b0@roeck-us.net>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <89e34607-0b58-add7-7825-d85f32ab2cb2@codeaurora.org>
Date:   Mon, 26 Apr 2021 22:07:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <9f28f60b-379b-c384-6049-e5e5294b80b0@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/15/2021 8:25 PM, Guenter Roeck wrote:
> On 3/14/21 11:05 PM, Rajendra Nayak wrote:
>> From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>
>> Add compatible for watchdog timer on SC7280 SoC.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I don;t see this in linux-next, any plans to pull this one in?

> 
>> ---
>> This was earlier posted as part of the entire DT series for sc7280 [1]
>> Rest of the patches are now picked, posting this separately so it can
>> be picked up via the WDT tree.
>>
>> [1] https://lore.kernel.org/patchwork/project/lkml/list/?series=488871
>>
>>   Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>> index b8e4118..ba60bdf 100644
>> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>> @@ -17,6 +17,7 @@ properties:
>>       enum:
>>         - qcom,apss-wdt-qcs404
>>         - qcom,apss-wdt-sc7180
>> +      - qcom,apss-wdt-sc7280
>>         - qcom,apss-wdt-sdm845
>>         - qcom,apss-wdt-sdx55
>>         - qcom,apss-wdt-sm8150
>>
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
