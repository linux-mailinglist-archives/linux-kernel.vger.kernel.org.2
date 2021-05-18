Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D1C3881F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352114AbhERVR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbhERVR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:17:27 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE394C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:16:07 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w4so13120339ljw.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cvtZ6ckUlmE+gpWNrBbw9zxXMPT5gh65PGrIYRqcK5Y=;
        b=iLl0ogtDiHXNumD0oddnV4kaw9Ev2AwKFeUmc2FjyS+1M6VOsapRKaqm7p2BglvgxI
         T6dmZ/sUaHraMvyjpXwbpGnJb+kLpKcmvfMepzi9aH2S8ld/vgsm91XDqtfJmh8xlAwM
         dAdfTX4DzekHupKNC7n1eYCOMU98eToddA/jxOtwmGQ1IlM17Dsg01JnAzLmsMIpf791
         Myf2aXgx3l84KQt4Jo9VHjzcvWiD7/VQ02tVsUP6zOzYpWhK65la6QKwCMuNZVS9mLy0
         cPR2YFgDBwfLkGBDPwmHudjJXoaZHyF5/RWTljNuCUZWR8dkqteiMUoBh4j4hTjoQ6Uw
         Rykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cvtZ6ckUlmE+gpWNrBbw9zxXMPT5gh65PGrIYRqcK5Y=;
        b=Ehk7WxPjBrCyugvLYhSxTT1ZFGQ4nFYG02ur8jca4dtzLAZtqKWdcgh1wnSQNJV8pe
         eOMUIaeuK1SjexP9fuTQ1xNYE2IjRgSt8hG1aM4M00eDHWrPxh+0uSUuh7JId6J4o1sz
         btSnm4+JtGmyL9VOlJRiIyv0PHCT430V/+0dNG+/nT/BspCQsOHnieBEwP8+O1LFi61t
         eerWM+kSz9SXMewZFwF2CzdWG2O3KDIej6y8bH9eLZtjFnvTeTnDbhGO6H18FYYVkD3p
         5FOR2LTFzN3gFW76OlO0/tmF//aKnXNAFlhRfXy5px+9nhSpjOpyE26HguPhQeNm3hgl
         OYFg==
X-Gm-Message-State: AOAM531CjE/AAokkrwZAmmm3LxLW8H0rJqitVMrlc6B2YY03AZVh7nIK
        TRxDtlaONsDjZSl5MMRjnKCQFg==
X-Google-Smtp-Source: ABdhPJwdgDivEG21hAH7jNDs5nhwwFl04oy+clqY5EDKhnLQf9OSj189KQKsWbxE+tXrlXFlPH8ilg==
X-Received: by 2002:a2e:808f:: with SMTP id i15mr5579846ljg.376.1621372566177;
        Tue, 18 May 2021 14:16:06 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v66sm546415lfa.222.2021.05.18.14.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 14:16:05 -0700 (PDT)
Subject: Re: [RESEND PATCH V4 2/8] arm64: dts: qcom: sc7280: Add thermal-zones
 node
To:     Matthias Kaehlcke <mka@chromium.org>, Vinod Koul <vkoul@kernel.org>
Cc:     satya priya <skakit@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
References: <1621318822-29332-1-git-send-email-skakit@codeaurora.org>
 <1621318822-29332-3-git-send-email-skakit@codeaurora.org>
 <YKOog43JZghth3Np@vkoul-mobl.Dlink> <YKPq84r7soE0yjMA@google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <2b1e0927-5521-1a6d-eedb-27f420bf2cb2@linaro.org>
Date:   Wed, 19 May 2021 00:16:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YKPq84r7soE0yjMA@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2021 19:27, Matthias Kaehlcke wrote:
> On Tue, May 18, 2021 at 05:14:03PM +0530, Vinod Koul wrote:
>> On 18-05-21, 11:50, satya priya wrote:
>>> Add thermal-zones node for SC7280 SoC.
>>>
>>> Signed-off-by: satya priya <skakit@codeaurora.org>
>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>> Changes in RESEND V4:
>>>   - No Changes.
>>>
>>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>> index 2cc4785..2a7d488 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>> @@ -1125,4 +1125,7 @@
>>>   			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>>>   			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>>>   	};
>>> +
>>> +	thermal_zones: thermal-zones {
>>> +	};
>>
>> Empty node..? what am i missing here...
> 
> The 'thermal-zones' node with the SoC thermal zones is usually created
> in the <soc>.dtsi, however it doesn't exist yet. The 'Add DT bindings
> and device tree nodes for TSENS in SC7280' series
> (https://patchwork.kernel.org/project/linux-arm-msm/list/?series=478225)
> is creating it, but the series hasn't landed yet.
> 
> The node is needed by other patches in this series that add non-SoC
> thermal zones. Hence either an empty node needs to be added (for now)
> or this series should 'officially' depend on the TSENS series mentioned
> above.

You can reference the TZ node as /thermal-zones/ even from non-SoC 
includes. See pm8150.dtsi for example.


-- 
With best wishes
Dmitry
