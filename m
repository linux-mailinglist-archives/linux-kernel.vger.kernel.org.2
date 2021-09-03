Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09037400270
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349576AbhICPhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:37:51 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:44357 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235573AbhICPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:37:50 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 509545809F9;
        Fri,  3 Sep 2021 11:36:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 03 Sep 2021 11:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=a
        QLvRR/fiUJqgX0rYqFHgMRYPMwNMN67OshWLPC1Frw=; b=URMwXHuiDwHgByI9G
        6iG+TNyWUzFoHK9jB+eUV65RC70CYhesVT6+vPEqcODCB/rVqDuVo2jYv7GxFmLZ
        vvsDECVMHI4lJ05Krm+aURy9T3pQNzzYhS3Isu9juovvmrnYRH0gq0luEFnXyCVB
        SW68roAzQbCP1EXR7HPfVKdVLZ5wsilWITj/TKA/gmsIOS/aSLNItutyOF+FmtDT
        A64DV8aLYurnplcYYpE2YxkKOMdlFiYTsWME96yFGsQs8R+bMTn3WmSmuf902G+q
        j1lgs2kyW0n4+Q/g8SAmbv0T9eoRBMLh2sZSCZcQXSOG0guz8D9EylJAqKzKIssO
        fETPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=aQLvRR/fiUJqgX0rYqFHgMRYPMwNMN67OshWLPC1F
        rw=; b=bj+oMLzHp9lSNLSC+g3Uq7yr0Ni1rNyb27Vxu7IXkdmjGJBrrDbvnlytX
        AvSw9lgbMF7+I4vROvNdPGnQuLGoy+3qEhFaZtpW7L/Wp2mA1IihXukPutfWjc35
        5qWPIGsdkgExFHtSgQBsRRBwB7KzHPdb8kNFqmHoIXTeSQh6bR51892hO/zJKPt3
        CzKsux0V3HnQ2Esu4FixwwEedvUfY9PArecyw7FmoFa62WWRqfiUh9IHfPjiFCZb
        qb4omAeAuG4d5cTWsqFPo5HmxvNRoAEIpvWld5kcvqQx44b2+bIS4e+bHmPCOdI8
        SB2EuCCMW3dPB5YN2hC+XvmH80Zqg==
X-ME-Sender: <xms:EUEyYVEJkcXQh9dFVQ_sjnO0Pk9_laUqRBYqh7D9b1YIopMAtEuouQ>
    <xme:EUEyYaXZwYm5lcZFGxRosluQ881FkwDBjYxFLw1DIhyL4asp8uSzEvUe8itabc2M8
    A963OJdjdW7fXAoUw>
X-ME-Received: <xmr:EUEyYXJBkII6BERpfQE7mSnbgwCKcw-PVwIM_vFD08xxLZiykDSWdPZ1SOCXbJvUsmT1dJOqB1-uSP5QhgQ4TG-YUsSGwoeU6c5GgWt2t8UX1q3YDE0cbYcCTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdejieduudfgffevteekffegffeguddtgfefkeduvedukeff
    hedtfeevuedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:EUEyYbG1M6hNibyTnSHryU-ZDUq_qUHZ8tNrXW1v9RbujjV4K5hVNQ>
    <xmx:EUEyYbUmsUwTnzwpaF8-Dipad3D23IhCpL-HZFrIbxzTFy8VfJKwvg>
    <xmx:EUEyYWO19vU5i6Zv9mwT29oB8gya2VkOmM-aNrRslX3qTrcOHvfsZw>
    <xmx:EkEyYbSk1e22sntW7La6DZvvGgt4P7y-su6BoCsq5GT1b78buBmyDQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 11:36:48 -0400 (EDT)
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210901053951.60952-1-samuel@sholland.org>
 <20210901053951.60952-2-samuel@sholland.org>
 <YTDtelCx5If3J5cM@robh.at.kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [RFC PATCH 1/7] dt-bindings: rtc: sun6i: Add H616 and R329
 compatibles
Message-ID: <53d6d018-93bf-9bfc-e296-a232105306de@sholland.org>
Date:   Fri, 3 Sep 2021 10:36:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YTDtelCx5If3J5cM@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 10:27 AM, Rob Herring wrote:
> On Wed, Sep 01, 2021 at 12:39:45AM -0500, Samuel Holland wrote:
>> For these new SoCs, start requiring a complete list of input clocks.
>>
>> For H616, this means bus, hosc, and pll-32k. For R329, this means ahb,
>> bus, and hosc; and optionally ext-osc32k.
>>
>> I'm not sure how to best represent this in the binding...
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml | 55 +++++++++++++++++--
>>  include/dt-bindings/clock/sun50i-rtc.h        | 12 ++++
>>  2 files changed, 61 insertions(+), 6 deletions(-)
>>  create mode 100644 include/dt-bindings/clock/sun50i-rtc.h
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
>> index beeb90e55727..3e085db1294f 100644
>> --- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
>> +++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
>> @@ -26,6 +26,8 @@ properties:
>>            - const: allwinner,sun50i-a64-rtc
>>            - const: allwinner,sun8i-h3-rtc
>>        - const: allwinner,sun50i-h6-rtc
>> +      - const: allwinner,sun50i-h616-rtc
>> +      - const: allwinner,sun50i-r329-rtc
> 
> Can you please make all the single entry cases a single 'enum'.
> 
>>  
>>    reg:
>>      maxItems: 1
>> @@ -37,7 +39,24 @@ properties:
>>        - description: RTC Alarm 1
>>  
>>    clocks:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 4
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    maxItems: 4
>> +    items:
>> +      - anyOf:
> 
> This says the first entry is any of these. What about the rest of them?

Oh, right. The list below is the list of all possible clocks.

>> +          - const: ahb
>> +            description: AHB parent for SPI bus clock
> 
> The description should go in 'clocks'.

Will do for v2.

> The order should be defined as well with the first clock being the
> one that existed previously.

The only way I know how to further refine the list is with
minItems/maxItems. My problem is that 1) some clocks are only valid for
certain SoCs, and 2) some clocks are optional, depending on how the
board is wired. So there is no single order where the "valid"
combinations are prefixes of the "possible" combinations of clocks.

Or in other words, how can I say "clocks #1 and #2 from this list are
required, and #4 is optional, but #3 is not allowed"?

Some concrete examples, with the always-required clocks moved to the
beginning:

H6:
 - bus: required
 - hosc: required
 - ahb: not allowed
 - ext-osc32k: optional
 - pll-32k: not allowed

H616:
 - bus: required
 - hosc: required
 - ahb: not allowed
 - ext-osc32k: not allowed
 - pll-32k: required

R329:
 - bus: required
 - hosc: required
 - ahb: required
 - ext-osc32k: optional
 - pll-32k: not allowed

Should I just move the entire clocks/clock-items properties to if/then
blocks based on the compatible?

>> +          - const: bus
>> +            description: AHB/APB bus clock for register access
>> +          - const: ext-osc32k
>> +            description: External 32768 Hz oscillator input
>> +          - const: hosc
>> +            description: 24 MHz oscillator input
>> +          - const: pll-32k
>> +            description: 32 kHz clock divided from a PLL
>>  
>>    clock-output-names:
>>      minItems: 1
>> @@ -85,6 +104,9 @@ allOf:
>>              enum:
>>                - allwinner,sun8i-h3-rtc
>>                - allwinner,sun50i-h5-rtc
>> +              - allwinner,sun50i-h6-rtc
>> +              - allwinner,sun50i-h616-rtc
>> +              - allwinner,sun50i-r329-rtc
>>  
>>      then:
>>        properties:
>> @@ -96,13 +118,35 @@ allOf:
>>        properties:
>>          compatible:
>>            contains:
>> -            const: allwinner,sun50i-h6-rtc
>> +            enum:
>> +              - allwinner,sun50i-h616-rtc
>> +              - allwinner,sun50i-r329-rtc
>>  
>>      then:
>> +      clocks:
>> +        minItems: 3 # bus, hosc, and (pll-32k [H616] or ahb [R329])
>> +
>> +      clock-names:
>> +        minItems: 3
>> +
>> +      required:
>> +        - clock-names
>> +
>> +    else:
>> +      required:
>> +        - clock-output-names
>> +
>> +  - if:
>> +      properties: clock-names
>> +
>> +    then:
>> +      required:
>> +        - clocks # hosc is required
>> +
>> +    else:
>>        properties:
>> -        clock-output-names:
>> -          minItems: 3
>> -          maxItems: 3
>> +        clocks:
>> +          maxItems: 1 # only ext-osc32k is allowed
>>  
>>    - if:
>>        properties:
>> @@ -127,7 +171,6 @@ required:
>>    - compatible
>>    - reg
>>    - interrupts
>> -  - clock-output-names
>>  
>>  additionalProperties: false
>>  
>> diff --git a/include/dt-bindings/clock/sun50i-rtc.h b/include/dt-bindings/clock/sun50i-rtc.h
>> new file mode 100644
>> index 000000000000..d45e3ff4e105
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/sun50i-rtc.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> Dual license please.

Will do for v2.

Regards,
Samuel

>> +
>> +#ifndef _DT_BINDINGS_CLK_SUN50I_RTC_CCU_H_
>> +#define _DT_BINDINGS_CLK_SUN50I_RTC_CCU_H_
>> +
>> +#define CLK_OSC32K		0
>> +#define CLK_OSC32K_FANOUT	1
>> +#define CLK_IOSC		2
>> +
>> +#define CLK_RTC_SPI		8
>> +
>> +#endif /* _DT_BINDINGS_CLK_SUN50I_RTC_CCU_H_ */
>> -- 
>> 2.31.1
>>
>>

