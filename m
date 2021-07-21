Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497D23D14B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhGUQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 12:18:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34098 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhGUQSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:18:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626886720; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=w/HMXtzgE+0xI3zDkR795AF2McOV6W/T1YvFy1bK/nk=;
 b=fXFuUJOc/csCFF/p6SED/icl6UKwG+SWwX8t3TxVZWpSzmPxdN5468ZJBgdU3acqnPcLKhBu
 //Au9k3gGyfDmyhYMC7RfjcvEvGjuPTpajaNofYGAolIJaj9B6EU1w+6KpWTMfUymoYVpsb6
 nuuZcj7h1+clmgFCLSwbGABQKlM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60f8523be81205dd0a84a146 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 16:58:35
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E278FC43217; Wed, 21 Jul 2021 16:58:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 146DFC433D3;
        Wed, 21 Jul 2021 16:58:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Jul 2021 22:28:33 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     swboyd@chromium.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, ulf.hansson@linaro.org, rjw@rjwysocki.net,
        agross@kernel.org, ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v4 02/13] dt-bindings: remoteproc: qcom: pas: Add QMP
 property
In-Reply-To: <YPdXz1T89GcIYmJO@google.com>
References: <1626755807-11865-1-git-send-email-sibis@codeaurora.org>
 <1626755807-11865-3-git-send-email-sibis@codeaurora.org>
 <YPdXz1T89GcIYmJO@google.com>
Message-ID: <9ba5feb96fac6486c3f1aa19444864c2@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Matthias,

Thanks for taking time to review
the series.

On 2021-07-21 04:40, Matthias Kaehlcke wrote:
> On Tue, Jul 20, 2021 at 10:06:36AM +0530, Sibi Sankar wrote:
>> The load state power-domain, used by the co-processors to notify the
>> Always on Subsystem (AOSS) that a particular co-processor is up/down,
>> suffers from the side-effect of changing states during suspend/resume.
>> However the co-processors enter low-power modes independent to that of
>> the application processor and their states are expected to remain
>> unaltered across system suspend/resume cycles. To achieve this 
>> behavior
>> let's drop the load state power-domain and replace them with the qmp
>> property for all SoCs supporting low power mode signalling.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>> 
>> v4:
>>  * Commit message change and sc8180x co-processor addition. 
>> [Rob/Bjorn]
>> 
>>  .../devicetree/bindings/remoteproc/qcom,adsp.yaml  | 65 
>> +++++++++++-----------
>>  1 file changed, 33 insertions(+), 32 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
>> index c597ccced623..1182afb5f593 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
>> @@ -78,11 +78,11 @@ properties:
>> 
>>    power-domains:
>>      minItems: 1
>> -    maxItems: 3
>> +    maxItems: 2
>> 
>>    power-domain-names:
>>      minItems: 1
>> -    maxItems: 3
>> +    maxItems: 2
> 
> It seems maxItems should have been 4 in the first place and should 
> remain
> unchanged after removing the load state power domain. With this patch:

sc7180-mpss-pas actually uses only
cx and mss. The mpss-pas compatible
is overridden by the mss-pil compatible
for all the platforms present upstream
for sc7180, that's the reason we probably
haven't run into any binding check failures.
I'll keep the max-items to 2 and fix-up
the sc7180 power-domain requirements
instead.

> 
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - qcom,sc7180-mpss-pas
>     then:
>       properties:
>         power-domains:
>           items:
>             - description: CX power domain
>             - description: MX power domain
>             - description: MSS power domain
>         power-domain-names:
>           items:
>             - const: cx
>             - const: mx
>             - const: mss

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
