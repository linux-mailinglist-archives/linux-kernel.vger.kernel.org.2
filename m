Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E542C3C59AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356420AbhGLJHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359281AbhGLI0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 04:26:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FBAC04FB37
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 01:20:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k4so18061338wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QHlXmzgYCLaFP1mLbFA9jYRGoFSwRmofbpKvixQG/EI=;
        b=yMbiRrkK9/p9xrQb7LoiVYsjj5zamGuNpJL7hkzXR9PRv/PUPitBCo++JtpQmmd/ka
         6qHtckH08lUFQSMSHh3dAIHIAhkr6AmICHeSISiWigsFjtxk00z0rCEiT9B54Bp9VwuD
         bB/lI+v+JXFE5zi10vUQ+vl254Sb88K4amHRiChE4IvI7FJr5dogbHAGJZFBv+qUlery
         crUa7mjG/txRYUi8qXATkeKsJ6TAIWifROmMeJgJPZ+JL9FuNHHlr4YxJYWA+FWJyGCq
         K1mYySgLKsrQohHHKztgKDa+wIQ1hnDTNSBpNMlR2F93lpjWz9uYcvYxXU36gNzk16jM
         9nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QHlXmzgYCLaFP1mLbFA9jYRGoFSwRmofbpKvixQG/EI=;
        b=LC5Z5Tg9uhkqzDIWjCJOrlkvHOfSFVVNZ/a6+pFn4jue2CIdsfUun/5iHNbIaW57G5
         yt0FRjpz4faar+MWnPhepliG4CU5iBaoDYWxq0A5wFlN/0CExNWllwze8tVl6K8Jyfv3
         JJDzFwRypgNFJjAjO/OQoYGvprYI32cggR7IqpncYMnz8DqndsdV4qu0/4H380elr/mx
         Ux6z5rhzG0vOOY8P3X64m6ZCZ+5sp7/KARZeBkXKg1KbVik+NX4fwDT++b9JZDnGn30B
         +4ylMbDT4kfzcUMp4J7wIW1Yf8mShDe+gYlAmBvTWQAq1zuW41LKFlfAQWr+Deid+Ll+
         vUMw==
X-Gm-Message-State: AOAM533IzYhgX50O90X09/pAphLvNcSOcgPsQmO0oprDxPVFNhptsXbA
        49nXoUTx6IL/1Yarz0LJUcS8ow==
X-Google-Smtp-Source: ABdhPJwXbve+EIZD2sZS7vVy/bCi0g4V0ei7/8Nc18Ft9JjOtidUjF8kMuubnSPz+I1noFhLENLjOw==
X-Received: by 2002:a5d:48ca:: with SMTP id p10mr57074091wrs.87.1626078014116;
        Mon, 12 Jul 2021 01:20:14 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id 11sm2767584wmo.10.2021.07.12.01.20.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jul 2021 01:20:13 -0700 (PDT)
Subject: Re: [RFC PATCH 03/13] ASoC: qcom: dt-bindings: add bindings Audio
 Processing manager
To:     Rob Herring <robh@kernel.org>
Cc:     bjorn.andersson@linaro.org, broonie@kernel.org,
        plai@codeaurora.org, tiwai@suse.de, devicetree@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org
References: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
 <20210607152836.17154-4-srinivas.kandagatla@linaro.org>
 <20210618201621.GA2801502@robh.at.kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1a152ccf-f51c-a59c-c530-f3f51f3cc75c@linaro.org>
Date:   Mon, 12 Jul 2021 09:20:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210618201621.GA2801502@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/06/2021 21:16, Rob Herring wrote:
> On Mon, Jun 07, 2021 at 04:28:26PM +0100, Srinivas Kandagatla wrote:
>> This patch adds bindings support for Qualcomm Audio Processing Manager
>> service in Audio DSP.
>>
>> Audio Process Manager is one of the static service in DSP which is
>> responsible for Command/response handling, graph Management
>> and Control/Event management between modules.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/sound/qcom,q6apm.yaml | 72 +++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
>> new file mode 100644
>> index 000000000000..9906ef935206
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/sound/qcom,q6apm.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Qualcomm Audio Process Manager binding
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +
>> +description: |
>> +  This binding describes the Qualcomm Audio Process Manager service in DSP
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,q6apm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +#APM Services
>> +patternProperties:
>> +  "^.*@[0-9a-f]+$":
> 
> You can drop '^.*'.

Thanks Rob for review,

will fix this along other comments in next spin.

--srini

> 
>> +    type: object
>> +    description:
>> +      APM devices use subnodes for services.
>> +
>> +    properties:
>> +      compatible:
>> +        enum:
>> +          - qcom,q6apm-dai
>> +          - qcom,q6apm-bedai
>> +
>> +      iommus:
>> +        maxItems: 1
>> +
>> +      "#sound-dai-cels":
> 
> cells?
> 
> How is this optional?
> 
>> +        const: 1
>> +
>> +    required:
>> +      - compatible
>> +      - reg
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: true
> 
> This needs to be false and fix whatever is missing.
> 
>> +
>> +examples:
>> +  - |
>> +    gpr {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        gprservice@1 {
>> +          compatible = "qcom,q6apm";
>> +          reg = <1>;
>> +
>> +          q6apm-dai {
> 
> This doesn't match what you have in the schema at all.
> 
>> +            compatible = "qcom,q6apm-dai";
>> +            #sound-dai-cels = <1>;
>> +          };
>> +
>> +          q6apm-bedai {
>> +            compatible = "qcom,q6apm-bedai";
>> +            #sound-dai-cels = <1>;
>> +          };
>> +        };
>> +    };
>> -- 
>> 2.21.0
>>
>>
