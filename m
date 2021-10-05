Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61742320E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhJEUcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbhJEUct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:32:49 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C44C061755
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:30:58 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id z23so356487qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZyooK385UPa/hejgXrvQ3R8D7J/IvgX2J1+dY+z5Tfw=;
        b=dq8RULmqd/pqVqtZm6l3zrjAcWOiMybIlP1ptQScoFB8gpWrSQ8JidbN23s38m6K75
         5JgEoQurQtd2GoBxSHNmZM4ISkx5owMoAEl2w3xHjqn230lrazOB1eTJ1QJAx8LVWXyy
         SS2NweOIXmW9f3SvFpWPIPSumSt/q0bl6wzVijpo7KjXmzf29sYxvpU/kZMQHSU4PeQQ
         228E10Ocp8fdk/G/Bw3Q5ZMXagGDLvrEyBEdNiPfO5ibORVbo1tYC82Cu6BWDfl2OfSM
         N+/H9K77hetRTmTbDuW8vJXji/7ePhCXQ+6Bokf9XT/Zh0Yf2N7/7jEeOpvfm2uEPlCY
         /9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZyooK385UPa/hejgXrvQ3R8D7J/IvgX2J1+dY+z5Tfw=;
        b=V8LgkNpBU+kIm7acoklI4zQN8nzOAfAONZrA7Kpl94qBl5uu06fqzxi8ywwH3C/P4i
         UNt0UW+W8EJ9n+yZJDbIhxJaEja0BJP5GJoyHFzAriHxH9e6auGEUqhNkTq+qcId+9Un
         XrepcrFxurE/Z9HOdlqKz/w94rwrxWm861hs9fz5uC5lSAUTZIZoWrpX39iqB3u+KemO
         wgEBttnH9/+2L4vgU8/wkDmEOiaHrs3SupHNMsjH7V9o+iv63ODtMwE8kfjU40bGYsqQ
         xzli9YMJo4ZtE4AHYhJOvBDC37CkEDAG4mObuZSDeXG8qrq+9LbZV7e8DTiDcKezpqjq
         7T4Q==
X-Gm-Message-State: AOAM5304uHy6SVz9iEYQ6FuJMWHTPZ68TyAHcva8BfIdV8s/pAoq51tE
        uyabQV/DnVJSSmJ1DQxBsYS0co0BrH2H2g==
X-Google-Smtp-Source: ABdhPJyJTQZ6xwp9tKG3Wq5zR4ov03NpNo29GGIUs+asJd7aPHY+RE1U7VfkCrNe/bnaaGZu3xl8lA==
X-Received: by 2002:ac8:51d7:: with SMTP id d23mr22813497qtn.332.1633465857492;
        Tue, 05 Oct 2021 13:30:57 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id n16sm11924195qta.51.2021.10.05.13.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 13:30:56 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sdm845: mtp: Add vadc channels
 and thermal zones
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
 <20210923212311.2877048-5-bjorn.andersson@linaro.org>
 <YVSzJZ8G43CLml3L@google.com> <YVtg3lcR1HMqVdAJ@ripper>
 <CAA8EJprYij6pWD1A17yr1+5-n5fKPW=YDA_-2+f8h6JnEh4myw@mail.gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <f136fbb0-be3e-aee8-7a68-1d16148c80ff@linaro.org>
Date:   Tue, 5 Oct 2021 16:30:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAA8EJprYij6pWD1A17yr1+5-n5fKPW=YDA_-2+f8h6JnEh4myw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/21 4:56 PM, Dmitry Baryshkov wrote:
> On Mon, 4 Oct 2021 at 23:13, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>>
>> On Wed 29 Sep 11:40 PDT 2021, Matthias Kaehlcke wrote:
>>
>>> On Thu, Sep 23, 2021 at 02:23:11PM -0700, Bjorn Andersson wrote:
>>>> Downstream defines four ADC channels related to thermal sensors external
>>>> to the PM8998 and two channels for internal voltage measurements.
>>>>
>>>> Add these to the upstream SDM845 MTP, describe the thermal monitor
>>>> channels and add thermal_zones for these.
>>>>
>>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>> ---
>>>>
>>>> In addition to the iio channels exposed by v1, Daniel wanted thermal_zones...
>>>>
>>>> Changes since v1:
>>>> - Enable the pm8998_adc_tm and describe the ADC channels
>>>> - Add thermal-zones for the new channels
>>>>
>>>>   arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 128 ++++++++++++++++++++++++
>>>>   1 file changed, 128 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> [..]
>>>> +&pm8998_adc {
>>>> +   adc-chan@4c {
>>>> +           reg = <ADC5_XO_THERM_100K_PU>;
>>>> +           label = "xo_therm";
>>>> +   };
>>>> +
>>>> +   adc-chan@4d {
>>>> +           reg = <ADC5_AMUX_THM1_100K_PU>;
>>>> +           label = "msm_therm";
>>>> +   };
>>>> +
>>>> +   adc-chan@4f {
>>>> +           reg = <ADC5_AMUX_THM3_100K_PU>;
>>>> +           label = "pa_therm1";
>>>> +   };
>>>> +
>>>> +   adc-chan@51 {
>>>> +           reg = <ADC5_AMUX_THM5_100K_PU>;
>>>> +           label = "quiet_therm";
>>>> +   };
>>>> +
>>>> +   adc-chan@83 {
>>>> +           reg = <ADC5_VPH_PWR>;
>>>> +           label = "vph_pwr";
>>>> +   };
>>>> +
>>>> +   adc-chan@85 {
>>>> +           reg = <ADC5_VCOIN>;
>>>> +           label = "vcoin";
>>>> +   };
>>>> +};
>>>> +
>>>> +&pm8998_adc_tm {
>>>> +   status = "okay";
>>>> +
>>>> +   xo-thermistor@1 {
>>>> +           reg = <1>;
>>>> +           io-channels = <&pm8998_adc ADC5_XO_THERM_100K_PU>;
>>>> +           qcom,ratiometric;
>>>> +           qcom,hw-settle-time-us = <200>;
>>>> +   };
>>>> +
>>>> +   msm-thermistor@2 {
>>>> +           reg = <2>;
>>>> +           io-channels = <&pm8998_adc ADC5_AMUX_THM1_100K_PU>;
>>>> +           qcom,ratiometric;
>>>> +           qcom,hw-settle-time-us = <200>;
>>>> +   };
>>>> +
>>>> +   pa-thermistor@3 {
>>>> +           reg = <3>;
>>>> +           io-channels = <&pm8998_adc ADC5_AMUX_THM3_100K_PU>;
>>>> +           qcom,ratiometric;
>>>> +           qcom,hw-settle-time-us = <200>;
>>>> +   };
>>>> +
>>>> +   quiet-thermistor@4 {
>>>> +           reg = <4>;
>>>> +           io-channels = <&pm8998_adc ADC5_AMUX_THM5_100K_PU>;
>>>> +           qcom,ratiometric;
>>>> +           qcom,hw-settle-time-us = <200>;
>>>> +   };
>>>> +};
>>>> +
>>>
>>> The example in the 'qcom,spmi-adc-tm5' binding specifies 'qcom,ratiometric'
>>> and 'qcom,hw-settle-time-us' for both the ADC and the thermal monitor, so do
>>> several board files (e.g. sm8250-mtp.dts and qrb5165-rb5.dts). This apparent
>>> redundancy bothered me earlier, it's not really clear to me whether it's
>>> needed/recommended or not. Do you happen to have any insights on this?
>>
>> Hmm, you're right and I missed this in defining my channels. I've not
>> looked at this detail, just got reasonable readings from my thermal
>> zones and was happy about that.
>>
>> Dmitry, do you have any further insights why these properties are
>> supposed to be duplicated between the adc channel and the thermal zones?
> 
> Because both ADC channel and thermal zone registers should be
> programmed accordingly.
> 
> One not-so-perfect approach would be to use io-channels property to
> locate the adc's adc-chan node and to parse it. However this way
> thermal driver would have to know the exact structure of adc's device
> tree nodes.
> Another (even worse) solution would be to introduce qcom-specific API
> to query these properties from the IIO channel.
> 
> Selecting between these two options I decided to follow the downstream
> path and just to duplicate these few properties.

I know I am joining late to this party, since v3 is out. But before I 
send my acked-by, wanted to check/state a few things.
To me, the not-so-perfect approach that you mention here is actually not 
so bad, considering the thermal sensor driver already is aware of 
internals of the adc device. The duplicating of node is kind of confusing.
Also did you explore using one of _channel_write apis in iio framework 
to move all the writes into the adc device instead of thermal sensor 
driver ?

> 

-- 
Warm Regards
Thara (She/Her/Hers)
