Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A00B458B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbhKVJYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbhKVJYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:24:20 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BADDC061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:21:14 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso16090266wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1r1P3CAQVJMR7iqI1mfq36qxIjfrbAJB49dCsJeHrQc=;
        b=XFYR7Voix/vCKrhxk72LU+Pe1QjOfUmDJHanELv54kHxwnW0d+Zp9UKEgSMeGPY0Tw
         4dCdu3BE5U6uuF0wSPMdW4Siq6LPxPr380Mc7wfrekKhMxrfkCaa0ZIYN9FpNFWeHF+7
         cxrT8u813G/13dKOKd2BjqpFf8EbsY09uCiHpWznUyeUqvSFeJb1J6jZCU/yWpJV7gvg
         rCFBQmGuhPAlgnW7vjz8YxAqAw8+QZV/G8log8ZIpwiYtQIXlYys38HFezmnAmejA5UV
         hBPJBtcJXpbEyCtuXQtTEVN+nTja4bhY6NB3fHRfuNXw+hRc1m36kry7Z4VCoovrSKWX
         G4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1r1P3CAQVJMR7iqI1mfq36qxIjfrbAJB49dCsJeHrQc=;
        b=hjQc+L7Yiaspt71ATpEVJzpb/zb38tKZMpauWQm77uvqWY+uN9ePVxKoSKbp2aDRW3
         oWVaxlYDInQ23lDDrTamsQ4Ab7hiudmZ/yD+InurrJ0lO9JYyz0evrPBR9QJeR3XY4t6
         9oAION23PnapKzDXso+hWDSVWoeb3+NnC5kyq59K5XZMuhH3jxk9X7ru/5Bec9Ypy7Sz
         cq8OlvzXlB9w6CKcUHGeJm3PH6yRm1Z23Q/UCD250O1I3kwhh7IP1l8es5jNgBkEyEWL
         6A+9MODGfUEKcbl03wnVOOzl5KcWENvqp1a9i+1el2T5laPEOfal36MTSF8ysH2RHGT9
         jeZg==
X-Gm-Message-State: AOAM533jSbofVwhYfuy+uDzhSrOiUb5XwfAXU8uD+2Th3+aBBoTDiwPQ
        Ue/5tVJud4o61ThAb4lGaUgoYg==
X-Google-Smtp-Source: ABdhPJzAgAkGcitf6tL+qV9XGDPaOQenjEwCFISt3azUoTKx6X/370/Jy4Dtghj84pOdr6LWuSSa4g==
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr27315815wmh.164.1637572872541;
        Mon, 22 Nov 2021 01:21:12 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id 8sm19977788wmg.24.2021.11.22.01.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 01:21:12 -0800 (PST)
Subject: Re: [PATCH 4/6] dt-bindings: phy: mediatek: tphy: support software
 efuse load
To:     Chen-Yu Tsai <wenst@chromium.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yz Wu <yz.wu@mediatek.com>
References: <20211107075646.4366-1-chunfeng.yun@mediatek.com>
 <20211107075646.4366-4-chunfeng.yun@mediatek.com>
 <71f83770-b12f-2452-d24b-ae1be9b5b075@linaro.org>
 <CAGXv+5GzP1SXi2ihhifK_Ui8Rt04UgeFyjivzHc532yvPFo3OA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8aa7adbf-7367-1b3a-4d63-f9fe83e72117@linaro.org>
Date:   Mon, 22 Nov 2021 09:21:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAGXv+5GzP1SXi2ihhifK_Ui8Rt04UgeFyjivzHc532yvPFo3OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/2021 04:05, Chen-Yu Tsai wrote:
> On Sat, Nov 20, 2021 at 1:19 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> On 07/11/2021 07:56, Chunfeng Yun wrote:
>>> Add optional property nvmem-cells and nvmem-cell-names to support
>>> software efuse load, this helps to fix the efuse bit shift issue
>>> on mt8195 etc.
>>>
>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>
>> Applied thanks,
> 
> This is a PHY DT binding change. Shouldn't it go in with patch 5, the
> phy driver patch, through the PHY tree instead?

That's true, this is dropped from nvmem tree now!

--srini
> 
> ChenYu
> 
>> --srini
>>
>>> ---
>>>    .../devicetree/bindings/phy/mediatek,tphy.yaml | 18 ++++++++++++++++++
>>>    1 file changed, 18 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>>> index 9e6c0f43f1c6..05ee274b4b71 100644
>>> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>>> @@ -160,6 +160,24 @@ patternProperties:
>>>                    - PHY_TYPE_PCIE
>>>                    - PHY_TYPE_SATA
>>>
>>> +      nvmem-cells:
>>> +        items:
>>> +          - description: internal R efuse for U2 PHY or U3/PCIe PHY
>>> +          - description: rx_imp_sel efuse for U3/PCIe PHY
>>> +          - description: tx_imp_sel efuse for U3/PCIe PHY
>>> +        description: |
>>> +          Phandles to nvmem cell that contains the efuse data;
>>> +          Available only for U2 PHY or U3/PCIe PHY of version 2/3, these
>>> +          three items should be provided at the same time for U3/PCIe PHY,
>>> +          when use software to load efuse;
>>> +          If unspecified, will use hardware auto-load efuse.
>>> +
>>> +      nvmem-cell-names:
>>> +        items:
>>> +          - const: intr
>>> +          - const: rx_imp
>>> +          - const: tx_imp
>>> +
>>>          # The following optional vendor properties are only for debug or HQA test
>>>          mediatek,eye-src:
>>>            description:
>>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
