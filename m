Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74905418F42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 08:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhI0Gth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 02:49:37 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:24365 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhI0Gta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 02:49:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632725273; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bkmmAT/PYJf9tgrBIaq+U6iMVFmoceMJO/CB/WHLr8I=;
 b=k75PIZZgKIFA94Lu2QtwW3uUaSD1DhXqxD4gO70FxruaE5+exxRrwLVH8/QtE7sBP2qf9hMe
 75AG9pfmDYDerA4I5d0Nt1/+RZ2Q9ePuROwVkRuwrPkXIlkTCUY2G6Hvi0sQHraDjIRnJ8XU
 BA3FFruhL1cslPRma0T0MRz9O3M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 61516913519bd8dcf0aa334e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Sep 2021 06:47:47
 GMT
Sender: rajpat=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C64F1C43616; Mon, 27 Sep 2021 06:47:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rajpat)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 096B2C4338F;
        Mon, 27 Sep 2021 06:47:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Sep 2021 12:17:45 +0530
From:   rajpat@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, sboyd@kernel.org, mka@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH V10 1/8] dt-bindings: spi: Add sc7280 support
In-Reply-To: <YU5VbmVdSuFE9syi@builder.lan>
References: <1632399378-12229-1-git-send-email-rajpat@codeaurora.org>
 <1632399378-12229-2-git-send-email-rajpat@codeaurora.org>
 <YU5VbmVdSuFE9syi@builder.lan>
Message-ID: <6ddcf763af213e5d1dbdf3ada1e30888@codeaurora.org>
X-Sender: rajpat@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-25 04:17, Bjorn Andersson wrote:
> On Thu 23 Sep 07:16 CDT 2021, Rajesh Patil wrote:
> 
>> Add compatible for sc7280 SoC.
>> 
>> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> Can you please pick up Rob's review tag and send this patch out again,
> this time including the SPI maintainer (Mark Brown 
> <broonie@kernel.org>)
> among the recipients.
> 
> Thanks,
> Bjorn

Okay.

> 
>> ---
>> Change in V10:
>>  - As per Stephen's comments,
>>    sorted compatible names in alphabet order
>> 
>> Changes in V9:
>>  - No changes
>> 
>> Changes in V8:
>>  - As per Doug's comments, added "qcom,sc7280-qspi" compatible
>> 
>>  Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 5 
>> ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml 
>> b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
>> index ef5698f..09aa955 100644
>> --- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
>> @@ -21,7 +21,10 @@ allOf:
>>  properties:
>>    compatible:
>>      items:
>> -      - const: qcom,sdm845-qspi
>> +      - enum:
>> +          - qcom,sc7280-qspi
>> +          - qcom,sdm845-qspi
>> +
>>        - const: qcom,qspi-v1
>> 
>>    reg:
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
>> member
>> of Code Aurora Forum, hosted by The Linux Foundation
>> 
