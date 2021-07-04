Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE2D3BAD43
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 15:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhGDOBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 10:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhGDOBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 10:01:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A514AC061764
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 06:58:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i94so18716636wri.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 06:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AQp+opcq8gKahHvP9xyG0B5OrrQoXI1GxKEWqLoPG1E=;
        b=FbKISM2e7MQ51yyaYUj98jeO01Q0NDunyeh7W8VVpfZl2ubo2g0zRVYLdbLBCGQ+Xv
         XgW/VGkggmLuozDqQ3DEzlaoutdOVheqyASkjiAHLlxqSnfPUT4smAdUnyXUxErMYMtl
         8Q6jCrMID7CTuExd9ADmdqFWQVCKZ2Xm3M6iLJUaQgiKcstMmB7i4C6q8hFT/urU7MHS
         tCerCqXuLjGYYlyzF75iRw5jNyker3nyw+qpGNc4cpq47UTQy6hM16o7h3mRED0VEcKH
         uiWNDeAsCoS4TQOI3iBbNP8Gpg60LvCCb06t8YFo9QDwkS6Q9n+Cg8SO0mDncWag1QNs
         Opow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AQp+opcq8gKahHvP9xyG0B5OrrQoXI1GxKEWqLoPG1E=;
        b=GFi2oKzjRZQEUybYRbM/pEwaFEGa7Qs8IAZi+KgOca6Xmn4PL1hLl5SFLAxp220O+s
         8c41dK+S6lR6X6ddqI4mxsmc5yAI1ewuusfbex2/+SOoT+N9rW+sfgIPdM8so/+ICClt
         8Atoi9A3CCFEV05AgW0+phSH48MEhv6i0ZLnnySQ1wCbXmwuUiwkFaQH070/p92X37Mo
         lO+bWNN+wuSLwqxybxG7R/axU+/dWBHt2kNDLLUlHta79MwcmGHXnOP/QY4B8WGsRWk3
         GGX/Z8IWR1Bl312U/U8WqJ4bjv76FLSvcWNdCDUFjJd51NPLwpqwRMg6DJxLSjwg90Yy
         REQA==
X-Gm-Message-State: AOAM530TuZIR47RrCR55UghRXd8xvYTcWqV5BcrlLWe8RigvA4t5yWK6
        ENS9F9w2Ay/Y192OHTNVsUxaqA==
X-Google-Smtp-Source: ABdhPJz/t34HslG9IT4Y2TOgh3bGEgA26fcbsJ9fAOTaI/Azfert+18zeswp4GuFFt5o/71bW/6lag==
X-Received: by 2002:a5d:4711:: with SMTP id y17mr10477374wrq.355.1625407133253;
        Sun, 04 Jul 2021 06:58:53 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y66sm9361205wmy.39.2021.07.04.06.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 06:58:52 -0700 (PDT)
Subject: Re: [V3] venus: helper: do not set constrained parameters for UBWC
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, dikshita@codeaurora.org
References: <1625202979-23232-1-git-send-email-mansur@codeaurora.org>
 <3c3051aa-c897-266e-9648-ca6be933fda0@nexus-software.ie>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <f2fd05a9-3aaf-1679-f152-90c30326dadd@linaro.org>
Date:   Sun, 4 Jul 2021 15:00:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3c3051aa-c897-266e-9648-ca6be933fda0@nexus-software.ie>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2021 15:00, Bryan O'Donoghue wrote:
> On 02/07/2021 06:16, Mansur Alisha Shaik wrote:
>> plane constraints firmware interface is to override the default
> 
> nitpick this should be "Plane constraints"
> 
>> alignment for a given color format. By default venus hardware has
>> alignments as 128x32, but NV12 was defined differently to meet
>> various usecases. Compressed NV12 has always been aligned as 128x32,
>> hence not needed to override the default alignment.
>>
>> Fixes: bc28936bbba9 ("media: venus: helpers, hfi, vdec: Set actual 
>> plane constraints to FW")
>> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
>>
>> Changes in V3:
>> - Elaborated commit message as per comments by Bryan
>> - As per Bryan comment alligned fixes in single line.
>> ---
>>   drivers/media/platform/qcom/venus/helpers.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/venus/helpers.c 
>> b/drivers/media/platform/qcom/venus/helpers.c
>> index 1fe6d46..601ee3e 100644
>> --- a/drivers/media/platform/qcom/venus/helpers.c
>> +++ b/drivers/media/platform/qcom/venus/helpers.c
>> @@ -1137,8 +1137,12 @@ int venus_helper_set_format_constraints(struct 
>> venus_inst *inst)
>>       if (!IS_V6(inst->core))
>>           return 0;
>> +    if (inst->opb_fmt == HFI_COLOR_FORMAT_NV12_UBWC)
>> +        return 0;
>> +
>>       pconstraint.buffer_type = HFI_BUFFER_OUTPUT2;
>>       pconstraint.num_planes = 2;
>> +
> 
> zap this newline, its not adding anything to your patch
> 
>>       pconstraint.plane_format[0].stride_multiples = 128;
>>       pconstraint.plane_format[0].max_stride = 8192;
>>       pconstraint.plane_format[0].min_plane_buffer_height_multiple = 32;
>>
> 
> then please add my
> 
> "Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>"
> 
> ---
> bod

Sorry sent from wrong email address

"Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>"
