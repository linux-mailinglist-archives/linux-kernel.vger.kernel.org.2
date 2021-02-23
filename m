Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A6D3229A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 12:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhBWLqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 06:46:23 -0500
Received: from z11.mailgun.us ([104.130.96.11]:23119 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232250AbhBWLqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:46:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614080749; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=3l3/dHpV72D6+xo2sb7a2KaT0sNL+NXfU+xxxFq8JjA=; b=CnZ7HvLX7paap+fw1UU+M/DyAOmYrRcvpD+/qOYb0O8r43gNxUDHlBamz7bEgFyUVtAuNRU1
 1ytN7TUD7J/4rO0w1ouHiYWxrgEeaS42o7/D1aLurSJ6UmFy9hT29hAk2e8xZ10JdHI6Cyer
 rRuEaEdtNEwwzxKEwFh/E3o6t6I=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6034eacf2a8ee88ea5fc99c3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Feb 2021 11:45:19
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5EE17C43462; Tue, 23 Feb 2021 11:45:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.102] (unknown [49.207.203.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E17A1C433CA;
        Tue, 23 Feb 2021 11:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E17A1C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 09/13] arm64: dts: qcom: Add reserved memory for fw
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>
References: <1613114930-1661-1-git-send-email-rnayak@codeaurora.org>
 <1613114930-1661-10-git-send-email-rnayak@codeaurora.org>
 <161406631106.1254594.5935934364229452348@swboyd.mtv.corp.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <f8b866aa-9fe4-4845-3223-ae1b1fb52abc@codeaurora.org>
Date:   Tue, 23 Feb 2021 17:15:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <161406631106.1254594.5935934364229452348@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2021 1:15 PM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2021-02-11 23:28:46)
>> From: Maulik Shah <mkshah@codeaurora.org>
>>
>> Add fw reserved memory area for CPUCP and AOP.
> 
> Does CPUCP stand for CPU Content Protection? AOP is Always On Processor.
> It would help if the commit text told us what these acronyms were.

Thanks, I'll expand the acronyms when I re-post.
  
>>
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
