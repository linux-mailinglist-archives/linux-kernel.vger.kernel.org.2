Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A78339284
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhCLP4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:56:20 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:37312 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232093AbhCLP4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:56:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615564571; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=p1sskyKEE42vrMUWciVQJLhEtL9LmwDBOkKKOVkWZ5g=; b=a5eKIYhbCty3zj0YR44LYfPn4uxkMgy7Ik3SSmrmTBjgTP5xNhTfhJITq+YM+z9NkJc2wr+F
 p9MgplZ37pEa+9lfrMzwiPwxpiwAsBhEkt6jrnYQeD7Gm9POixfnlOuVGgxFc0+mgFzCaqV3
 T1XiEKXqxWNXYO6gedrrCB6cNwc=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 604b8f0de2200c0a0d22d55a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Mar 2021 15:55:57
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28440C433ED; Fri, 12 Mar 2021 15:55:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.29.24] (unknown [49.37.156.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C91B3C43464;
        Fri, 12 Mar 2021 15:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C91B3C43464
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=srivasam@codeaurora.org
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: sc7180-trogdor: Add lpass dai
 link for I2S driver
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     gross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>
References: <20210311164815.14113-1-srivasam@codeaurora.org>
 <20210311164815.14113-2-srivasam@codeaurora.org>
 <CAD=FV=VSnhOSFtLX==DYF1WFszaJwgnbZY-EycP4=SNs6rqajw@mail.gmail.com>
 <7825f825-8b84-fda8-5884-e4f0ea4edf12@codeaurora.org>
Organization: Qualcomm India Private Limited.
Message-ID: <5487aeac-b50c-913b-41d6-bc2aec8f858f@codeaurora.org>
Date:   Fri, 12 Mar 2021 21:25:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <7825f825-8b84-fda8-5884-e4f0ea4edf12@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 3/12/2021 6:32 PM, Srinivasa Rao Mandadapu wrote:
> Hi Doug,
>
> Thanks for your time!!!
>
> On 3/12/2021 1:26 AM, Doug Anderson wrote:
>> Hi,
>>
>> On Thu, Mar 11, 2021 at 8:49 AM Srinivasa Rao Mandadapu
>> <srivasam@codeaurora.org> wrote:
>>> From: Ajit Pandey <ajitp@codeaurora.org>
>>>
>>> Add dai link for supporting lpass I2S driver, which is used
>>> for audio capture and playback.
>>> Add lpass-cpu node with  pin controls and i2s primary
>>> and secondary dai-links
>>>
>>> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
>>> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
>>> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 58 
>>> ++++++++++++++++++++
>>>   1 file changed, 58 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi 
>>> b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>>> index 436582279dad..501e3d4c9097 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>>> @@ -9,6 +9,7 @@
>>>   #include <dt-bindings/input/gpio-keys.h>
>>>   #include <dt-bindings/input/input.h>
>>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>> +#include <dt-bindings/sound/qcom,lpass.h>
>> It seems marginally better to include "sc7180-lpass.h" to get this? I
>> don't really know the difference between the two but since unless
>> we're planning to delete the sc7180 version it seems like you might as
>> well include that one?
>
> Yes, I agree.
>
> Recently, all Quallcomm variant headers are combined and created 
> "qcom,lpass.h".
>
> "sc7180-lpass.h" still includes "qcom,lpass.h". So I will change and 
> repost the patch.
>
>
> Here is the reference commit:
>
>>
>>
>>>   /* PMICs depend on spmi_bus label and so must come after SoC */
>>>   #include "pm6150.dtsi"
>>> @@ -283,6 +284,42 @@ keyboard_backlight: keyboard-backlight {
>>>                          max-brightness = <1023>;
>>>                  };
>>>          };
>>> +
>>> +       sound: sound {
>>> +               compatible = "google,sc7180-trogdor";
>>> +               model = "sc7180-rt5682-max98357a-1mic";
>>> +
>>> +               audio-routing =
>>> +                       "Headphone Jack", "HPOL",
>>> +                       "Headphone Jack", "HPOR";
>>> +
>>> +               #address-cells = <1>;
>>> +               #size-cells = <0>;
>>> +
>>> +               dai-link@0 {
>>> +                       link-name = "MultiMedia0";
>>> +                       reg = <MI2S_PRIMARY>;
>>> +                       cpu {
>>> +                               sound-dai = <&lpass_cpu MI2S_PRIMARY>;
>>> +                       };
>>> +
>>> +                       codec {
>>> +                               sound-dai = <&alc5682 MI2S_PRIMARY>;
>> I'm an audio noob but isn't "MI2S_PRIMARY" something to be used with
>> "lpass_cpu", not with "alc5682" ?
>>
>> I have no idea what the IDs correspond to on "alc5682". Are you sure
>> we even need an extra ID there? The "alc5682" bindings upstream don't
>> talk anything about dai-cells, but maybe they're just wrong...
> Yes. I will change and re-post.
Actually, without dai-cells getting compilation issues. So I think it's 
necessary here.
>>
>> -Doug
>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

