Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADE93489F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhCYHQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:16:13 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50403 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhCYHPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:15:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616656540; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ZF2wEokbtaHkoVJQpXVQZ7oT0+ILgWsy6JEDa7DYhoo=; b=kSWy3JInySWbqwFJl43kRiN6sTbJZaP3v+hH99krznxXBmlq/sKhkfXzr+CdFfrWyN2ucX3N
 kinnm3YsVIECE3MWaUsu4rwgBvkzPIVmnqcKJQGif1wZ1J6Jh84vb8F9uDGGiJXiU1+tG4Xg
 F2jDayXgApBGLLCOhErhBgH2qhI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 605c38964db3bb68015ff305 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Mar 2021 07:15:34
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D252C43462; Thu, 25 Mar 2021 07:15:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.50.0.146] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06DE7C433CA;
        Thu, 25 Mar 2021 07:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06DE7C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] drivers: nvmem: Fix voltage settings for QTI qfprom-efuse
To:     Doug Anderson <dianders@chromium.org>,
        Ravi Kumar Bokka <rbokka@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org
References: <1612524533-3970-1-git-send-email-rbokka@codeaurora.org>
 <CAD=FV=W9YWxVY6cEEXBr1wMcMzEPak3PeyROSvmnOWewL9BiUQ@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <4956f067-4079-84b4-191d-c1036e04c42f@codeaurora.org>
Date:   Thu, 25 Mar 2021 12:45:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=W9YWxVY6cEEXBr1wMcMzEPak3PeyROSvmnOWewL9BiUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/5/2021 8:25 PM, Doug Anderson wrote:
> Hi,
> 
> On Fri, Feb 5, 2021 at 3:29 AM Ravi Kumar Bokka <rbokka@codeaurora.org> wrote:
>>
>> QFPROM controller hardware requires 1.8V min for fuse blowing.
>> So, this change sets the voltage to 1.8V, required to blow the fuse
>> for qfprom-efuse controller.
>>
>> To disable fuse blowing, we set the voltage to 0V since this may
>> be a shared rail and may be able to run at a lower rate when we're
>> not blowing fuses.
>>
>> Fixes: 93b4e49f8c86 ("nvmem: qfprom: Add fuse blowing support")
>> Reported-by: Douglas Anderson <dianders@chromium.org>
>> Suggested-by: Douglas Anderson <dianders@chromium.org>
>> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
>> ---
>>   drivers/nvmem/qfprom.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
>> index 6cace24..100d69d 100644
>> --- a/drivers/nvmem/qfprom.c
>> +++ b/drivers/nvmem/qfprom.c
>> @@ -127,6 +127,16 @@ static void qfprom_disable_fuse_blowing(const struct qfprom_priv *priv,
>>   {
>>          int ret;
>>
>> +       /*
>> +        * This may be a shared rail and may be able to run at a lower rate
>> +        * when we're not blowing fuses.  At the moment, the regulator framework
>> +        * applies voltage constraints even on disabled rails, so remove our
>> +        * constraints and allow the rail to be adjusted by other users.
> 
> Some year maybe I'll try to fix the regulator framework to not count
> voltage constraints for disbled rails, or perhaps have it be optional.
> ;-)  In theory it should be much easier after the patches we already
> landed not to count current requests for disabled rails...
> 
> 
>> +        */
>> +       ret = regulator_set_voltage(priv->vcc, 0, INT_MAX);
>> +       if (ret)
>> +               dev_warn(priv->dev, "Failed to set 0 voltage (ignoring)\n");
>> +
>>          ret = regulator_disable(priv->vcc);
>>          if (ret)
>>                  dev_warn(priv->dev, "Failed to disable regulator (ignoring)\n");
>> @@ -172,6 +182,17 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
>>                  goto err_clk_prepared;
>>          }
>>
>> +       /*
>> +        * Hardware requires 1.8V min for fuse blowing; this may be
>> +        * a rail shared do don't specify a max--regulator constraints
>> +        * will handle.
>> +        */
>> +       ret = regulator_set_voltage(priv->vcc, 1800000, INT_MAX);
>> +       if (ret) {
>> +               dev_err(priv->dev, "Failed to set 1.8 voltage\n");
>> +               goto err_clk_rate_set;
>> +       }
>> +
> 
> Looks right to me.  Assuming that this works.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Srini, any plans to queue this up for merge?  

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
