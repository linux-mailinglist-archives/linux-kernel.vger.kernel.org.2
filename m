Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E786F3ACCC0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhFRNxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhFRNxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:53:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A297C061574;
        Fri, 18 Jun 2021 06:50:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n23so5726799wms.2;
        Fri, 18 Jun 2021 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dtovv/K8yfnYJqOxDgzB30UQELk3d/5XWOox6hnEDLs=;
        b=OANY3fHjjNRTHesTx7eEJ2yCXhvqLh87yoeuA9tuGDeMyIjcYjWrwKohJdhcIMSotC
         ntV80jttyIgF+UPVSR2Kj/6KjCNVDtbA6ewIsYpKwYxG+WwRFNUy+dnIwwKTnwYlZpXL
         /0N5bPyINXIrCWRjeG7ww8E0XSCtm5ySomovkrZfLgv1KYM0N0F/FfJbh+e9DkQ+yZky
         B32TSuhbVQXm22LVvvpLVPN9lhyZ6sdDC2aALH72ZpPOXRUG2+lTA+mX8el4YyZtTO21
         iT6JNAkv82bf7AF/pzsvSAg0XKtJeJfAHkz4EEKEHRihT8ImRLwIVAKpi5ptk+p11Nbm
         PU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dtovv/K8yfnYJqOxDgzB30UQELk3d/5XWOox6hnEDLs=;
        b=FMgCPqHGY5eybSSw7eTQK1ynT5wCxoFn4a7n/Nrbp0FfTcKHj14G35kYDPaos5BPU+
         4S7PYIWKbWe4/Cp19TfvnAEyBSo7msbNclv3dSgpv3qCpZ/QJ7BgQLr+DwhOvGTHFr15
         DUVoHDtM/HCITisnmWZzgbIGiavmdcJ3aMsX1ZAZVVso70IgHam+YUGiHiszwhcUfqrX
         y9tQujjHYk1pJZzdVJ4zhYnignlzlrDgLo1vU8O0MeK6+jAQx0PL3wz6/lHX3Nispjvk
         OFa/YEPzUsmUhXExQ++MXk3GupUktHRDvNDPyCQWYdvFlu4PalrrxYg+4OuwpHTtD3sd
         8Q3g==
X-Gm-Message-State: AOAM532/Us7gowOpzjnGzyQ0AwFP2mN2kz2qF1HNvceKYwBeXFwzqQ7k
        ppo25rI+Ualcp1GDxn67se4=
X-Google-Smtp-Source: ABdhPJzZl84wUFGxHgDS72TiTUz7fnPfBKmWjvV/GpBzDDa8v0y6BvkqlGsDIMkcKmEOni1iHfohBA==
X-Received: by 2002:a1c:f60f:: with SMTP id w15mr11678131wmc.71.1624024254592;
        Fri, 18 Jun 2021 06:50:54 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id l9sm7753655wme.21.2021.06.18.06.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 06:50:54 -0700 (PDT)
Subject: Re: [PATCH v9 01/22] dt-bindings: ARM: Mediatek: Add new document
 bindings of imp i2c wrapper controller
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>
References: <20210524122053.17155-1-chun-jie.chen@mediatek.com>
 <20210524122053.17155-2-chun-jie.chen@mediatek.com>
 <20210602171201.GA3566462@robh.at.kernel.org>
 <66e017401ab93aa02c5d2bbf11be9589b36649ac.camel@mediatek.com>
 <1f59ed31-4a0e-9719-bf84-1fe4cdd6c57d@gmail.com>
 <162334689784.9598.2709970788186333494@swboyd.mtv.corp.google.com>
 <de082c64-ace3-30b5-7404-1f4b607a83e1@gmail.com>
 <c8e8535cef67adeaefcfe943bbd8287806921e03.camel@mediatek.com>
 <CAGXv+5HcV6jbyDdZGzRX-2NHMztSONBKxmLxLQX6k+aQrwJ1ww@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <5c0a88c7-7f64-fd00-4e0c-2b3163926f71@gmail.com>
Date:   Fri, 18 Jun 2021 15:50:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAGXv+5HcV6jbyDdZGzRX-2NHMztSONBKxmLxLQX6k+aQrwJ1ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/06/2021 08:32, Chen-Yu Tsai wrote:
> On Wed, Jun 16, 2021 at 2:34 AM Chun-Jie Chen
> <chun-jie.chen@mediatek.com> wrote:
>>
>> On Fri, 2021-06-11 at 11:56 +0200, Matthias Brugger wrote:
>>>
>>> On 10/06/2021 19:41, Stephen Boyd wrote:
>>>> Quoting Matthias Brugger (2021-06-08 07:45:49)
>>>>>
>>>>>
>>>>> On 07/06/2021 07:20, Chun-Jie Chen wrote:
>>>>>> On Wed, 2021-06-02 at 12:12 -0500, Rob Herring wrote:
>>>>>>>> +
>>>>>>>> +description:
>>>>>>>> +  The Mediatek imp i2c wrapper controller provides
>>>>>>>> functional
>>>>>>>> configurations and clocks to the system.
>>>>>>>> +
>>>>>>>> +properties:
>>>>>>>> +  compatible:
>>>>>>>> +    items:
>>>>>>>> +      - enum:
>>>>>>>> +          - mediatek,mt8192-imp_iic_wrap_c
>>>>>>>> +          - mediatek,mt8192-imp_iic_wrap_e
>>>>>>>> +          - mediatek,mt8192-imp_iic_wrap_s
>>>>>>>> +          - mediatek,mt8192-imp_iic_wrap_ws
>>>>>>>> +          - mediatek,mt8192-imp_iic_wrap_w
>>>>>>>> +          - mediatek,mt8192-imp_iic_wrap_n
>>>>>>>
>>>>>>> Looks to me like these are all the same h/w, but just have
>>>>>>> differing
>>>>>>> sets of clocks. That's not really a reason to have different
>>>>>>> compatibles.
>>>>>>>
>>>>>>> If you need to know what clocks are present, you can walk the
>>>>>>> DT for
>>>>>>> all 'clocks' properties matching this clock controller
>>>>>>> instance. Or
>>>>>>> use
>>>>>>> 'clock-indices' to define which ones are present.
>>>>
>>>> Is the idea to use clock-indices and then list all the clock ids in
>>>> there and match them up at driver probe time to register the clocks
>>>> provided by the IO region? Feels like we'll do a lot of parsing at
>>>> each
>>>> boot to match up structures and register clks with the clk
>>>> framework.
>>>>
>>>> If it's like other SoCs then the clk id maps to a hard macro for a
>>>> type
>>>> of clk, and those hard macros have been glued together with other
>>>> clks
>>>> and then partitioned into different IO regions to make up a clock
>>>> controller. Or maybe in this case, those clk hard macros have been
>>>> scattered into each IP block like SPI, i2c, uart, etc. so that the
>>>> clock
>>>> controller doesn't really exist and merely the gates and rate
>>>> control
>>>> (mux/divider) for the clk that's clocking some particular IP block
>>>> all
>>>> live inside the IP wrapper. If it's this case then I hope there are
>>>> a
>>>> bunch of PLLs that are fixed rate so that the i2c clk doesn't have
>>>> to go
>>>> outside the wrapper to change frequency (of which there should be
>>>> two
>>>> "standard" frequencies anyway).
>>>>
>>>>>>>
>>>>>>> Rob
>>>>>>
>>>>>> Some module is divided to sub-modules which are designed in
>>>>>> different
>>>>>> h/w blocks for different usage, and if we want to use the same
>>>>>> compatible to present these h/w blocks, we need to move the
>>>>>> clock data
>>>>>> provided by these h/w blocks to dts, but we usually use
>>>>>> different
>>>>>> compatible to get the h/w blocks data in
>>>>>> Mediatek's clock driver, so do you suggest to register clock
>>>>>> provided
>>>>>> by different h/w blocks using same compatible?
>>>>>>
>>>>>
>>>>> The mapping of them is as following:
>>>>> imp_iic_wrap_c:  11007000
>>>>> imp_iic_wrap_e:  11cb1000
>>>>> imp_iic_wrap_s:  11d03000
>>>>> imp_iic_wrap_ws: 11d23000
>>>>> imp_iic_wrap_w:  11e01000
>>>>> imp_iic_wrap_n:  11f02000
>>>>>
>>>>
>>>> Sure. What is their purpose though? Are they simply a bunch of
>>>> different
>>>> i2c clks?
>>>>
>>>
>>> That would be need to be answered by MediaTek as I don't have access
>>> to any
>>> documentation.
>>>
>>> Regards,
>>> Matthias
>>
>> We describe which clock controllers are exist in dts and
>> get the clock data provided by clock controller in driver data
>> by matching device compatible.
>>
>> The clock data contains several clocks which includes the clock index,
>> parent clock source and the details of reg control inside the IP block
>> of clock controller.
>>
>> In MT8192 platform, some IP block is divide to several sub-blocks and
>> each sub-block provides clock control by itself.
> 
> Some more information:
> 
> Based on what I read in the datasheets, I'm guessing that MediaTek groups
> the I2C controllers into several groups and places them in different parts
> of the die. The suffix of imp_iic_wrap_XXX is likely pointing to the
> placement of the group. And the imp_iic_wrap_XXX is what the name suggests
> a wrapper around the group of I2C controllers. The wrapper contains clock
> and reset controls, as well as other things that I can't make out.
> 

Thanks for the clarification. If the wrapper contains more then just clocks,
then probably we will need a solution as done by MMSYS subsystem. Would be good
if you could work with MediaTek to find out what exactly this wrappers contain,
to get a better picture of if we need an additional driver or not.

Regards,
Matthias
