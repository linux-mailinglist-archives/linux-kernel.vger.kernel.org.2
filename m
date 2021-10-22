Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83E4373AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhJVIdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhJVIdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:33:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C8DC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:31:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 5so927724edw.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+s3RKjcGG+MOOi5e3FStCyMo3mus4CdAelMYmF9XjNI=;
        b=XA6b/fmmHaNPaJQ3RWZTTghGLmKtShh6KbyR2G7KJhw/Dx2kZN+ehZcl1lgX9u/iPM
         3jf1s1h/0pRoiNYq7JNYf4RHU4Ew5+3dKl+rddx82JmMj887Yd0Qvhejhf/JTty8tIEV
         655GZsYB1eyWoOPS9rEr7vTrFCdt6myHuW+zwyt2bYlIWSErX2wEDuiFkSxDNemfy5/p
         7XwCzABaOuK0O1+c6vsIHnaH0YBrwdo7CukTK9IvEquCe3tVlpqi2NisDNYrOzddI71c
         F9Y/Dj0y1vw4P1gOLHkcY1+VFIFk2Rt5OSt0fZBlUmPagryhXyWfxo01DiTtVzXL9hR/
         2EEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+s3RKjcGG+MOOi5e3FStCyMo3mus4CdAelMYmF9XjNI=;
        b=oP8VEa4dRExDgEJH5s2Y6XMKDdvSE7m0wcurJfiSr9gRS3lvoqv6Q5+1LAXoTxTitF
         nM0s7aumcsi9p6EalDTlwEurLjBDk99MoRCGNznhyvhIgfRy1A0og0uW2FVV+5RnwpM/
         TaQtvrjEVJFo0B1cHmXxOF5OhmfXyNezkPfZ0SgJsI79dldJPGnrNQ38CpiTurbiXPyR
         dLU6qEqihMVIwXz1kMMvFE6Rr22O1nWS/FBCV/4JctRCJ4W4fU7f7PdaoxU2LUiHTj9U
         hTFMvDs45J12+274wfNqgD9GSEZPY8nI3BddxRyAT3nA9xOVvIWTpF1iCIB9xdv7+gwc
         9/jA==
X-Gm-Message-State: AOAM531YfTcDrt8WQ+LoEJf0vo6ch2Q60+E4lS4LdJbuS4EypM7Ddj7Y
        43Q81LPBfRPjhYejY6bJH1ZvHlrsQaE1GQ==
X-Google-Smtp-Source: ABdhPJyjALlIYBx258q1rME3+PI/RUJSvPoCUA5pHFn2TnQwq1Dol04vdP1h5OJqKSklFppy+EzwbQ==
X-Received: by 2002:a17:906:5805:: with SMTP id m5mr13683921ejq.221.1634891464458;
        Fri, 22 Oct 2021 01:31:04 -0700 (PDT)
Received: from [192.168.1.15] (hst-221-79.medicom.bg. [84.238.221.79])
        by smtp.googlemail.com with ESMTPSA id e7sm4448621edk.3.2021.10.22.01.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 01:31:03 -0700 (PDT)
Subject: Re: [RESEND PATCH v6] arm64: dts: qcom: sc7280: Add venus DT node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, stanimir.varbanov@linaro.org,
        Mansur Alisha Shaik <mansur@codeaurora.org>
References: <1632199829-25686-1-git-send-email-dikshita@codeaurora.org>
 <YUpZaQ42ldzEKtV/@builder.lan>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <68a9da44-b568-85e9-6ec4-28fc8d95633f@linaro.org>
Date:   Fri, 22 Oct 2021 11:31:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUpZaQ42ldzEKtV/@builder.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dikshita,

On 9/22/21 1:15 AM, Bjorn Andersson wrote:
> On Mon 20 Sep 23:50 CDT 2021, Dikshita Agarwal wrote:
> 
>> Add DT entries for the sc7280 venus encoder/decoder.
>>
>> this patch depends on [1].
>>
>> [1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=529463

Please drop those two lines above.

> 
> The stuff you write here will be forever imprinted in the git history
> and it's already unnecessary, given that the patch you reference here is
> available in linux-next.
> 
> Things you want to mention, but shouldn't go into the git history, put
> those below the '---' line.
> 
>>
>> Co-developed-by: Mansur Alisha Shaik <mansur@codeaurora.org>
>> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
>> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>

I guess this should be :

Co-developed-by: Mansur Alisha Shaik <mansur@codeaurora.org>
Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>

but checkpatch --strict should complain about this, no?

>> ---
>>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 75 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 75 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index a8c274a..f171ababc 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -63,6 +63,11 @@
>>  			no-map;
>>  			reg = <0x0 0x80b00000 0x0 0x100000>;
>>  		};
>> +
>> +		video_mem: memory@8b200000 {
>> +			reg = <0x0 0x8b200000 0x0 0x500000>;
>> +			no-map;
>> +		};
>>  	};
>>  
>>  	cpus {
>> @@ -1063,6 +1068,76 @@
>>  			qcom,bcm-voters = <&apps_bcm_voter>;
>>  		};
>>  
>> +		venus: video-codec@aa00000 {
>> +			compatible = "qcom,sc7280-venus";
> 
> I do however now see this compatible defined in a binding in linux-next,
> so you definitely should have listed that patch as a dependency - and
> preferably held off sending me 6 versions (plus resend) of a patch that
> I can't merge.
> 
> Please ping me once the binding is merged, so that I know when I can
> merge this patch.
Bjorn, the binding is in linux-next now.

-- 
-- 
regards,
Stan
