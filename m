Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5E730F7B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbhBDQ0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbhBDPEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:04:13 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A788C0613D6;
        Thu,  4 Feb 2021 07:03:33 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c6so4562391ede.0;
        Thu, 04 Feb 2021 07:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CsMggE1T6Db0Mf+4aVw1lDImMHCALtp0EmDWSQ+hzjk=;
        b=AV1kUnKE/1+RMYTR27ymKOGjWJ6qOgNNUsA2hMtOHnHaUEtE1CKdU0Moc6ack+GDc5
         fue56MImdLXqCDC6ZoQDfxRX5mUUYemTjEtws1sqlhilKMBnNieFsZDkdF9E3xPXf4it
         jz+loR9sBN1Do/SpxALFE7Wka7GQ5XuYpjETDjTDDKAIjhY9DAr3ivoY2JAS0MOBFk1a
         NWhk5g4pgpy/GzAXwtgb4dA3XdDirjhcVvKabilP8VgCjkawiPMqF3MYpYXTd5/mjHH8
         gPPqxsSR9iHgBYbhMFWI4Of/FCIFIatYjXTvZ4B+5UGl3psrzRKXZ0KYL4rE0mIjm5q/
         snxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CsMggE1T6Db0Mf+4aVw1lDImMHCALtp0EmDWSQ+hzjk=;
        b=p+KJLnun+3ptVFHWwwHAuvPN3+iC5T/QCPAsWQPeBfSC3fALyOMY0LtKnqw13A37sY
         q2ipEGUjGPvlGSAbsM/Wt66Hif1kpY6WAD89TLRywi5+/YE2oMUov6wqvaLqZeOyHe5O
         FFx6WsK6j51ebYHFLKeHfyhD3fixccftCicheC6rpUJp5OubS4QEJOfZTfTCbfidKwhq
         7PNqPwD3QmvOhax4+Ac+sypeOg8vfoNLMBmSJxV8iyCRjGMHpgGM+PaO+c9K8UjCPMFa
         Mqq3UI6dqbuDTubnsWSckzuTbxmMWDWnbH1tTKiPQuRgQbKHdw4NNNmRvfXHG2mSe3Zc
         VJ5Q==
X-Gm-Message-State: AOAM531eE4f6/LnBVNvpQE79bC0NMh22/RqT+rrbTMLoLh1tqeO8PKry
        KrKgiosB/AwD0wRZ2MU6aExgrAhN8KM=
X-Google-Smtp-Source: ABdhPJxckEbUUMlxgF12SnhiHhLcZ9kucmRnh6hK8Pd16exBTu9Xyc0U9OpGDyGKzc7fLpT3LTn3og==
X-Received: by 2002:a50:b746:: with SMTP id g64mr8325992ede.33.1612451008450;
        Thu, 04 Feb 2021 07:03:28 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u21sm2601234ejj.120.2021.02.04.07.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 07:03:27 -0800 (PST)
Subject: Re: [PATCH v2 1/7] dt-bindings: usb: convert rockchip,dwc3.txt to
 yaml
To:     Robin Murphy <robin.murphy@arm.com>, heiko@sntech.de,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     devicetree@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210203165233.22177-1-jbx6244@gmail.com>
 <41efd28c-ff64-2b9f-2cdc-ac4aaaeb4611@arm.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <bc44860d-57e4-4717-739c-7bbac1d2f56e@gmail.com>
Date:   Thu, 4 Feb 2021 16:03:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <41efd28c-ff64-2b9f-2cdc-ac4aaaeb4611@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thank you for your comments.
The old binding txt is not so up to date.
The question is now what do we add or not..

On 2/4/21 12:35 PM, Robin Murphy wrote:
> On 2021-02-03 16:52, Johan Jonker wrote:
>> In the past Rockchip dwc3 usb nodes were manually checked.
>> With the conversion of snps,dwc3.yaml as common document
>> we now can convert rockchip,dwc3.txt to yaml as well.
>> Remove node wrapper.
>>
>> Added properties for rk3399 are:
>>    power-domains
>>    resets
>>    reset-names
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>   .../devicetree/bindings/usb/rockchip,dwc3.txt      |  56 -----------
>>   .../devicetree/bindings/usb/rockchip,dwc3.yaml     | 103
>> +++++++++++++++++++++
>>   2 files changed, 103 insertions(+), 56 deletions(-)
>>   delete mode 100644
>> Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
>>   create mode 100644
>> Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
>> b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
>> deleted file mode 100644
>> index 945204932..000000000
>> --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
>> +++ /dev/null
>> @@ -1,56 +0,0 @@
>> -Rockchip SuperSpeed DWC3 USB SoC controller
>> -
>> -Required properties:
>> -- compatible:    should contain "rockchip,rk3399-dwc3" for rk3399 SoC
>> -- clocks:    A list of phandle + clock-specifier pairs for the
>> -        clocks listed in clock-names
>> -- clock-names:    Should contain the following:
>> -  "ref_clk"    Controller reference clk, have to be 24 MHz
>> -  "suspend_clk"    Controller suspend clk, have to be 24 MHz or 32 KHz
>> -  "bus_clk"    Master/Core clock, have to be >= 62.5 MHz for SS
>> -        operation and >= 30MHz for HS operation
>> -  "grf_clk"    Controller grf clk
>> -
>> -Required child node:
>> -A child node must exist to represent the core DWC3 IP block. The name of
>> -the node is not important. The content of the node is defined in
>> dwc3.txt.
>> -
>> -Phy documentation is provided in the following places:
>> -Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml -
>> USB2.0 PHY
>> -Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt     -
>> Type-C PHY
>> -
>> -Example device nodes:
>> -
>> -    usbdrd3_0: usb@fe800000 {
>> -        compatible = "rockchip,rk3399-dwc3";
>> -        clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
>> -             <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
>> -        clock-names = "ref_clk", "suspend_clk",
>> -                  "bus_clk", "grf_clk";
>> -        #address-cells = <2>;
>> -        #size-cells = <2>;
>> -        ranges;
>> -        usbdrd_dwc3_0: dwc3@fe800000 {
>> -            compatible = "snps,dwc3";
>> -            reg = <0x0 0xfe800000 0x0 0x100000>;
>> -            interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
>> -            dr_mode = "otg";
>> -        };
>> -    };
>> -
>> -    usbdrd3_1: usb@fe900000 {
>> -        compatible = "rockchip,rk3399-dwc3";
>> -        clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
>> -             <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_GRF>;
>> -        clock-names = "ref_clk", "suspend_clk",
>> -                  "bus_clk", "grf_clk";
>> -        #address-cells = <2>;
>> -        #size-cells = <2>;
>> -        ranges;
>> -        usbdrd_dwc3_1: dwc3@fe900000 {
>> -            compatible = "snps,dwc3";
>> -            reg = <0x0 0xfe900000 0x0 0x100000>;
>> -            interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
>> -            dr_mode = "otg";
>> -        };
>> -    };
>> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
>> b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
>> new file mode 100644
>> index 000000000..fdf9497bc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
>> @@ -0,0 +1,103 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/usb/rockchip,dwc3.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip SuperSpeed DWC3 USB SoC controller
>> +
>> +maintainers:
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +description:
>> +      The common content of the node is defined in snps,dwc3.yaml.
>> +
>> +      Phy documentation is provided in the following places.
>> +
>> +      USB2.0 PHY
>> +      Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
>> +
>> +      Type-C PHY
>> +      Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> +
>> +allOf:

>> +  - $ref: snps,dwc3.yaml#

Could Rob advise here? Is this OK or not?

>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - rockchip,rk3399-dwc3
>> +      - const: snps,dwc3
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description:
>> +          Controller reference clock, must to be 24 MHz
>> +      - description:
>> +          Controller suspend clock, must to be 24 MHz or 32 KHz
>> +      - description:
>> +          Master/Core clock, must to be >= 62.5 MHz for SS
>> +          operation and >= 30MHz for HS operation
>> +      - description:
>> +          Controller aclk_usb3_rksoc_axi_perf clock
> 

> I'm pretty sure these last 3 don't belong to the controller itself,
> hence why they were in the glue layer node to being with.

New proposal:

		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
		clock-names = "ref_clk", "suspend_clk",
			      "bus_clk", "grf_clk";

Clocks seem to be enabled in bulk.

	ret = clk_bulk_get_all(simple->dev, &simple->clks);

With dt checks no longer able to add "@" in the nodename without reg
property in the node.
Given only clocks left in parent node and Rob's comment I've combined
all in 1 node.

> 
>> +      - description:
>> +          Controller aclk_usb3 clock
> 

> Does anything in the USB3 block actually consume this clock directly? If
> not, then I don't think it needs to be specified since it's already the
> parent of the controller's required bus_clk.

The patch from the manufacturer tree in the link below seems to confirm
this.

////

From manufacturer tree:

arm64: dts: rockchip: optimize clks for rk3399 dwc3

https://github.com/rockchip-linux/kernel/commit/1948bffacbc7a893d550141a63664b596717623a

remove unnecessary clocks, refer to rk3399 TRM, aclk_usb3 is the
parent of aclk_usb3otg0/1 and aclk_usb3_grf, and we will enable
aclk_usb3otg0/1 and aclk_usb3_grf, so don't need to enable aclk_usb3
again. In addition, the aclk_usb3_rksoc_axi_perf clk is used for usb3
performance monitor module which we don't use now, so don't need to
enable it.

////
> 
> I'm similarly suspicious of ACLK_USB3_NOC which is currently marked as
> CLK_IGNORE_UNUSED - if that's necessary for USB3 to function then it
> probably *should* be specified as part of the glue layer binding here.

Don't know about ACLK_USB3_NOC. I leave it as it is for now.

> 
> Robin.
> 
>> +      - description:
>> +          Controller grf clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: ref_clk
>> +      - const: suspend_clk
>> +      - const: bus_clk

>> +      - const: aclk_usb3_rksoc_axi_perf
>> +      - const: aclk_usb3

Remove these ??

>> +      - const: grf_clk
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +

>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    const: usb3-otg

From manufacturer tree:

arm64: dts: rockchip: move resets to the subnode of dwc3 for rk3399

https://github.com/rockchip-linux/kernel/commit/966da4dbacab847825f50a70036baacd74b2358d

////

In mainline:

	/*
	 * Some controllers need to toggle the usb3-otg reset before trying to
	 * initialize the PHY, otherwise the PHY times out.
	 */
	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
		simple->need_reset = true;
	simple->resets = of_reset_control_array_get(np, false, true,
						    true);
////

Do we still need "reset-names" here??


>> +
>> +unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/rk3399-cru.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    bus {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +
>> +      usbdrd3_0: usb@fe800000 {
>> +        compatible = "rockchip,rk3399-dwc3", "snps,dwc3";
>> +        reg = <0x0 0xfe800000 0x0 0x100000>;
>> +        interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
>> +                 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
>> +                 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
>> +        clock-names = "ref_clk", "suspend_clk",
>> +                      "bus_clk", "aclk_usb3_rksoc_axi_perf",
>> +                      "aclk_usb3", "grf_clk";
>> +        dr_mode = "otg";
>> +      };
>> +    };
>>

