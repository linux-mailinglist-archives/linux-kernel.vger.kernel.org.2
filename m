Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DC2377D25
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhEJHc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:32:59 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:60389 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229684AbhEJHcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:32:55 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 56AEBBEF;
        Mon, 10 May 2021 03:31:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 10 May 2021 03:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=f
        MqBYiDYg/jFbDLuifO1eLkWWzSA+lEPMpLkCXSA8Uc=; b=J3jCL0qmOMvWs9Gxh
        ptYzFaAG+kWd9mijFv+mbs4bL6cQiZF3LjV0uLthnu6zflz0Mgg2hyErRT5mz4dh
        4w3A1duL8afsP1mm9qvA+4PKAVdUNjZRc5jRdTNgZtsOjd1l9SwYEfc0nUv8eUM/
        JPz4htRihPBcXSpNS3UV85EcSPiUcjs2IeINwuZ0h9Hzv0y29LrvTi0LVSP96wxA
        qZb+jBRi7gAq8fjDdNrSZdlKbsC/4h7u2jxp8qGNl9YNHlpo4P/Aj4VMYnaVscoy
        oAJw/ud1HvgMXFj6n3Cpfv5XhXS3bVHCSHjwuWmtQlsqDfsTUMXlhvJInT+oqbwU
        rPfxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=fMqBYiDYg/jFbDLuifO1eLkWWzSA+lEPMpLkCXSA8
        Uc=; b=ZUzZuc8yJ7ALiY0Pikso3WfaD1bguKAFf73NREXQjlofTj8qLLPsYJWuw
        of7Wk2j/9uMutEvagxm4G34UGWBvpyhrsOJGrjQfl4GmMzihNy88eOeYC7LZaFgC
        fEzJweqV5TQkyRv78sB+z6J1QuW1eo7u+zc1LoLmQBHDZlaBjtsC0lrgmxPdFEiV
        o85TbWKr2SOLVeLJYBRnVWwKgLaGmbeztIS4+JUge9hhMVJ8Z9XYqm+9SwUKfr97
        sjAUQlV9zfxGVDlnM7h4RoRmnAlD6Bp8ei0ujlSu3DZ85Zm5AHDYxhfCXO4HH7Hu
        4Z1VYTmIN9xA1EvkJ4HR9iJkrnrLQ==
X-ME-Sender: <xms:ZOGYYA1_TOsXIx-93oBsdv1xhfvoHJq079bBZKmFd1qxUWEUqgwzmQ>
    <xme:ZOGYYLHiqZfpwmETRMSW7QDSCw9p2nP81WUiI5c9oYu910F7fWJSfaVX4RmIS9YoM
    nSGK_oza_VTRxVMNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegjedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefvfhfhuffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeegueejueejleeggfduudduleehteelveevheekgfegtdegtdfg
    tdehjeeufeetieenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:ZOGYYI7jjKWglgcFpREQZYY_OAolp_mCWwKlTCWUgtgT8Qi_1Gvl5A>
    <xmx:ZOGYYJ3jOUH6_9Jn2ZxRF6bYOcYuchCCFpTc6SN9aISbI-At6MyfaA>
    <xmx:ZOGYYDG8JP8i5qOI_Mx7qTUZeW5uTe4dKxbEn32Uv9UT2ROXqb_wYw>
    <xmx:ZeGYYJbLk7YV-0Icb-7TIGPcvD5hJ588IFxm5mrQHmgwR38MnZsa53i8Di8>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 10 May 2021 03:31:48 -0400 (EDT)
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210430031912.42252-1-samuel@sholland.org>
 <20210430031912.42252-2-samuel@sholland.org>
 <20210430194437.GA3755541@robh.at.kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Document the Allwinner H6 DWC3
 glue
Message-ID: <570592fb-da7e-70ea-1994-10873ed50c12@sholland.org>
Date:   Mon, 10 May 2021 02:31:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210430194437.GA3755541@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/21 2:44 PM, Rob Herring wrote:
> On Thu, Apr 29, 2021 at 10:19:11PM -0500, Samuel Holland wrote:
>> The RST_BUS_XHCI reset line in the H6 affects both the DWC3 core and the
>> USB3 PHY. This suggests the reset line controls the USB3 IP as a whole.
>> Represent this by attaching the reset line to a glue layer device.
> 
> Does that really mean anything more than a shared reset? Doesn't the 
> reset code support shared resets?

Yes, shared resets are supported.

I don't know exactly what it means -- the hardware's platform
integration is not well documented. The vendor BSP groups the controller
+ PHY together as a single node/device, and enables resources all at
once, so it is not clear which resources belong to which part.

The hardware layout appeared to be similar to other platforms, so it
seemed reasonable that the binding should be similar as well. Only
unipher and hi3660 put the resets property in the snps,dwc3 node itself;
the vast majority of platforms put it one level higher. I don't know
which is more "correct".

The benefit of following the more common binding is that it allows
sharing the glue code. The downside is that it is a bit more
complicated, and the warning for "ranges;", which several other
platforms appear to have as well.

>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  .../usb/allwinner,sun50i-h6-dwc3.yaml         | 75 +++++++++++++++++++
>>  1 file changed, 75 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml b/Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml
>> new file mode 100644
>> index 000000000000..936b5c74043f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml
>> @@ -0,0 +1,75 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/usb/allwinner,sun50i-h6-dwc3.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Allwinner H6 DWC3 USB controller
>> +
>> +maintainers:
>> +  - Chen-Yu Tsai <wens@csie.org>
>> +  - Maxime Ripard <mripard@kernel.org>
>> +
>> +properties:
>> +  compatible:
>> +    const: allwinner,sun50i-h6-dwc3
>> +
>> +  "#address-cells": true
>> +
>> +  "#size-cells": true
>> +
>> +  ranges: true
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +# Required child node:
>> +
>> +patternProperties:
>> +  "^phy@[0-9a-f]+$":
>> +    $ref: ../phy/allwinner,sun50i-h6-usb3-phy.yaml#
>> +
>> +  "^usb@[0-9a-f]+$":
>> +    $ref: snps,dwc3.yaml#
>> +
>> +required:
>> +  - compatible
>> +  - ranges
>> +  - resets
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/sun50i-h6-ccu.h>
>> +    #include <dt-bindings/reset/sun50i-h6-ccu.h>
>> +
>> +    usb3: usb@5200000 {
>> +        compatible = "allwinner,sun50i-h6-dwc3";
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges;
>> +        resets = <&ccu RST_BUS_XHCI>;
>> +
>> +        dwc3: usb@5200000 {
>> +            compatible = "snps,dwc3";
>> +            reg = <0x05200000 0x10000>;
>> +            interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&ccu CLK_BUS_XHCI>,
>> +                     <&ccu CLK_BUS_XHCI>,
>> +                     <&rtc 0>;
>> +            clock-names = "ref", "bus_early", "suspend";
>> +            dr_mode = "host";
>> +            phys = <&usb3phy>;
>> +            phy-names = "usb3-phy";
>> +        };
>> +
>> +        usb3phy: phy@5210000 {
>> +            compatible = "allwinner,sun50i-h6-usb3-phy";
>> +            reg = <0x5210000 0x10000>;
>> +            clocks = <&ccu CLK_USB_PHY1>;
>> +            resets = <&ccu RST_USB_PHY1>;
>> +            #phy-cells = <0>;
>> +        };
>> +    };
>> -- 
>> 2.26.3
>>

