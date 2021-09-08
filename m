Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF2A4032A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 04:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347722AbhIHC1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 22:27:32 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:34177 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347665AbhIHC11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 22:27:27 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 7C98F2B0027C;
        Tue,  7 Sep 2021 22:26:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 07 Sep 2021 22:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=e
        KnyYOS2v782jSePg7xdkP7npAfnDnVRMX0yx7qLjeE=; b=ix6wRrcGWQmnPM2q5
        jPwq1ukeQGIb2k9xJJSZyjp1c9TpGgLBHYfiQKRAUf7MPlnosKsFN7iqxxM3vBJF
        Iab7ePyQsMDFabsabI+/KO0Kp7nhUk2j4GXmiNdWp0y8uPn6MGojc0WkCtX+GjSB
        NCrq39LaFca5OqYUawOzAHNMIrDAs+ejZnP/nbCTLe8oKpo2dXI8MlEDa5s0aT7L
        soUuZySCPHcF3qPLDi67IvfSJFYeh/sgRc8Hw1h7+tx/W62m0qCH9chSfxCpP/Og
        PZnl3RZLUqSLPzehubcIdBQfFQTY0aqXOekm+P5b268l2LN7aNoMja1sJgbW9jj5
        uOTbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=eKnyYOS2v782jSePg7xdkP7npAfnDnVRMX0yx7qLj
        eE=; b=i86/NE/TaKJwB4dmLA8GlS60zzbqRoHFIOh4swDBZ7yjGrvj0OcvMsSTj
        WhZK3Lm/xPAtoXGBIaS7e3dcZbYXbMqpsW+xehauntd1IYsCTHH/0A9+BiN1HwNj
        qkkDGCYKxKaIPk7mIXng1Lo44DggDC6OVewrPM+EiVd6Al704kYm4lqk6Yv7iAhq
        aYKOu+nmjkB5N7bX+tZIiZajePRJmMyXUTH650HPlEA5jedxlbGH02depu+JcPsI
        z5CngEzR8EEYB7mqTefyIFfADtCVZCJPTImG3+D1I9EImolsrb7vZNPtfDfq1WO9
        O13md6cqo6RxcoS5y3HNeck5aNpBQ==
X-ME-Sender: <xms:Rx84YRdhK0A5zQojiQIiPUsZ7gRMeVHU7A1NYtTsl5zAdzyiZx_UkQ>
    <xme:Rx84YfMc3QZk7f98L_lKKgR5Jrrz1N4nbyPPm_JtdU1detyZop8FkdEene6la9vc6
    9MOTrIY_H-8JRZO8g>
X-ME-Received: <xmr:Rx84Yaj9i_WPCvIP3-SPqUrc0jVJQUq-eTA9-XH49mFKO_3AsMwuee_tBAockSP50aV-Uud7_EwCyJBbjsRgFT7C7grdN3nXBrPZVHlX7wCZp_Jkad9SyoG_kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdejieduudfgffevteekffegffeguddtgfefkeduvedukeff
    hedtfeevuedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Rx84Ya9cQx7iRtuj6ysYroa66quK2rVA6kmgAZHua-4Gz1KPo8Bapw>
    <xmx:Rx84Ydt0i9cjqQoeKmhyW7vcOA_u3BCO2vrDGBXyTpsesnb2z4asWg>
    <xmx:Rx84YZEfKDYodQw-iPRmZKG5VGmMjI_BkuN9xwviB-_7SeHMrjEV6A>
    <xmx:SB84YTIHNfI_YzmKdVPAPQlXK2mPQqyKPxQN0x90vos8Viy3jVWjg2kggIk>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Sep 2021 22:26:14 -0400 (EDT)
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210901053951.60952-1-samuel@sholland.org>
 <20210901053951.60952-2-samuel@sholland.org>
 <YTDtelCx5If3J5cM@robh.at.kernel.org>
 <53d6d018-93bf-9bfc-e296-a232105306de@sholland.org>
 <CAL_JsqKQ-9EWLPah2+q0=Y9viES1FSMS2_Mq6Kw-dMkN=rAhyQ@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [RFC PATCH 1/7] dt-bindings: rtc: sun6i: Add H616 and R329
 compatibles
Message-ID: <80fb6869-4955-25a1-ed1c-118dbf61b206@sholland.org>
Date:   Tue, 7 Sep 2021 21:26:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKQ-9EWLPah2+q0=Y9viES1FSMS2_Mq6Kw-dMkN=rAhyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 9:44 AM, Rob Herring wrote:
> On Fri, Sep 3, 2021 at 10:36 AM Samuel Holland <samuel@sholland.org> wrote:
>>
>> On 9/2/21 10:27 AM, Rob Herring wrote:
>>> On Wed, Sep 01, 2021 at 12:39:45AM -0500, Samuel Holland wrote:
>>>> For these new SoCs, start requiring a complete list of input clocks.
>>>>
>>>> For H616, this means bus, hosc, and pll-32k. For R329, this means ahb,
>>>> bus, and hosc; and optionally ext-osc32k.
>>>>
>>>> I'm not sure how to best represent this in the binding...
>>>>
>>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>>> ---
>>>>  .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml | 55 +++++++++++++++++--
>>>>  include/dt-bindings/clock/sun50i-rtc.h        | 12 ++++
>>>>  2 files changed, 61 insertions(+), 6 deletions(-)
>>>>  create mode 100644 include/dt-bindings/clock/sun50i-rtc.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
>>>> index beeb90e55727..3e085db1294f 100644
>>>> --- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
>>>> +++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
>>>> @@ -26,6 +26,8 @@ properties:
>>>>            - const: allwinner,sun50i-a64-rtc
>>>>            - const: allwinner,sun8i-h3-rtc
>>>>        - const: allwinner,sun50i-h6-rtc
>>>> +      - const: allwinner,sun50i-h616-rtc
>>>> +      - const: allwinner,sun50i-r329-rtc
>>>
>>> Can you please make all the single entry cases a single 'enum'.
>>>
>>>>
>>>>    reg:
>>>>      maxItems: 1
>>>> @@ -37,7 +39,24 @@ properties:
>>>>        - description: RTC Alarm 1
>>>>
>>>>    clocks:
>>>> -    maxItems: 1
>>>> +    minItems: 1
>>>> +    maxItems: 4
>>>> +
>>>> +  clock-names:
>>>> +    minItems: 1
>>>> +    maxItems: 4
>>>> +    items:
>>>> +      - anyOf:
>>>
>>> This says the first entry is any of these. What about the rest of them?
>>
>> Oh, right. The list below is the list of all possible clocks.
>>
>>>> +          - const: ahb
>>>> +            description: AHB parent for SPI bus clock
>>>
>>> The description should go in 'clocks'.
>>
>> Will do for v2.
>>
>>> The order should be defined as well with the first clock being the
>>> one that existed previously.
>>
>> The only way I know how to further refine the list is with
>> minItems/maxItems. My problem is that 1) some clocks are only valid for
>> certain SoCs, and 2) some clocks are optional, depending on how the
>> board is wired. So there is no single order where the "valid"
>> combinations are prefixes of the "possible" combinations of clocks.
>>
>> Or in other words, how can I say "clocks #1 and #2 from this list are
>> required, and #4 is optional, but #3 is not allowed"?
> 
> This says you have up to 4 clocks, but only defines the 1st 2:
> 
> maxItems: 4
> items:
>   - description: 1st clock
>   - description: 2nd clock
> 
> But I think you will be better off with just defining the range
> (minItems/maxItems) at the top level and then use if/then schemas.

Ah, thanks for the suggestions.

>>
>> Some concrete examples, with the always-required clocks moved to the
>> beginning:
>>
>> H6:
>>  - bus: required
>>  - hosc: required
>>  - ahb: not allowed
>>  - ext-osc32k: optional
>>  - pll-32k: not allowed
> 
> Is this really 2 different 32k clock inputs to the h/w block? Doesn't
> seem like it given both are never valid.

Yes, there are two separate 32k inputs. Both are valid at the same time
on some SoCs like T5 (patch 7), but not on any of those I listed here.

Regards,
Samuel

>>
>> H616:
>>  - bus: required
>>  - hosc: required
>>  - ahb: not allowed
>>  - ext-osc32k: not allowed
>>  - pll-32k: required
>>
>> R329:
>>  - bus: required
>>  - hosc: required
>>  - ahb: required
>>  - ext-osc32k: optional
>>  - pll-32k: not allowed
>>
>> Should I just move the entire clocks/clock-items properties to if/then
>> blocks based on the compatible?
> 
> Probably so.
> 
> Rob
> 

