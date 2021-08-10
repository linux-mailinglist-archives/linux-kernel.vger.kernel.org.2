Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5930A3E0CC4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 05:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhHED1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 23:27:41 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54669 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238476AbhHED1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 23:27:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628134046; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=83ejBFxG6PpaqEIAxOQakS7CpkA8CGMBWmlvjt7MCsA=; b=dfQCdwfCH7R9COxYwJ+Lj1oOxwFBbB6B0zudcs1COFvGvDwuja3DTqq8yatBuxa276hFUwKI
 wGSkCvkY1rlp+6JPew2NJmNbnX/6BUgBoDwj1HM+5pNXpKReMUzUHq+8+zXXvqPxjEs8MmsC
 iWkzmw9dVCW7+ZeOyvK6SDLHf4M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 610b5a9e041a739c46268661 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Aug 2021 03:27:26
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5129CC4360C; Thu,  5 Aug 2021 03:27:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.102] (unknown [49.207.220.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62504C433F1;
        Thu,  5 Aug 2021 03:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62504C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc7280-idp: Add device tree
 files for IDP2
To:     Konrad Dybcio <konrad.dybcio@somainline.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, skakit@codeaurora.org,
        swboyd@chromium.org, dianders@chromium.org, mka@chromium.org
References: <1628082199-17002-1-git-send-email-rnayak@codeaurora.org>
 <1628082199-17002-3-git-send-email-rnayak@codeaurora.org>
 <0cb8bf79-697c-ff16-e37e-d1c783f8a207@somainline.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <8aaef1a2-269d-1077-7996-793045a04f7c@codeaurora.org>
Date:   Thu, 5 Aug 2021 08:57:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <0cb8bf79-697c-ff16-e37e-d1c783f8a207@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/5/2021 1:17 AM, Konrad Dybcio wrote:
> 
> On 04.08.2021 15:03, Rajendra Nayak wrote:
>> Move all the common device tree bits for both sc7280 IDPs into a
>> sc7280-idp.dtsi and create 2 different dts files (sc7280-idp.dts
>> and sc7280-idp2.dts) in order to manage differences across the
>> IDP SKU1 and SKU2 Boards.
>> PMR735A is present on IDP board only and is not present on IDP2.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dts            | 328 +--------------------
> 
> I'm still for calling this sc7280-idp-sku1/2.dts, but other than that it looks good.

sure, I'll just wait for others to chime in, and if that's the consensus I would be
happy to re-spin.
  
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
