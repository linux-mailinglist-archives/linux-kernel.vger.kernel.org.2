Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B333726C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhEDHqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhEDHqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:46:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260E6C061574;
        Tue,  4 May 2021 00:45:25 -0700 (PDT)
Received: from [IPv6:2a01:e0a:4cb:a870:3951:839d:24c0:e20d] (unknown [IPv6:2a01:e0a:4cb:a870:3951:839d:24c0:e20d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6BE641F420E7;
        Tue,  4 May 2021 08:45:21 +0100 (BST)
Subject: Re: [PATCH v2 1/4] dt-bindings: iommu: rockchip: Convert IOMMU to DT
 schema
To:     Rob Herring <robh@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Cc:     joro@8bytes.org, will@kernel.org, heiko@sntech.de,
        xxm@rock-chips.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Kever Yang <kever.yang@rock-chips.com>
References: <20210422141602.350746-1-benjamin.gaignard@collabora.com>
 <20210422141602.350746-2-benjamin.gaignard@collabora.com>
 <7557bc8aaaa1924ad39676b32ba6a3f6474a3722.camel@collabora.com>
 <20210430221442.GA3970483@robh.at.kernel.org>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <28edc185-6aa9-a657-0f2d-4ed2e3b9ddd4@collabora.com>
Date:   Tue, 4 May 2021 09:45:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210430221442.GA3970483@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 01/05/2021 à 00:14, Rob Herring a écrit :
> On Thu, Apr 22, 2021 at 02:16:53PM -0300, Ezequiel Garcia wrote:
>> (Adding Kever)
>>
>> Hi Benjamin,
>>
>> Thanks a lot for working on this, it looks amazing. Together with the great work
>> that Rockchip is doing, it seems RK3566/RK3568 will have decent support very soon.
>>
>> One comment here:
>>
>> On Thu, 2021-04-22 at 16:15 +0200, Benjamin Gaignard wrote:
>>> Convert Rockchip IOMMU to DT schema
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>> version 2:
>>>   - Change maintainer
>>>   - Change reg maxItems
>>>   - Change interrupt maxItems
>>>
>>>   .../bindings/iommu/rockchip,iommu.txt         | 38 ---------
>>>   .../bindings/iommu/rockchip,iommu.yaml        | 79 +++++++++++++++++++
>>>   2 files changed, 79 insertions(+), 38 deletions(-)
>>>   delete mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>>   create mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>> deleted file mode 100644
>>> index 6ecefea1c6f9..000000000000
>>> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>> +++ /dev/null
>>> @@ -1,38 +0,0 @@
>>> -Rockchip IOMMU
>>> -==============
>>> -
>>> -A Rockchip DRM iommu translates io virtual addresses to physical addresses for
>>> -its master device.  Each slave device is bound to a single master device, and
>>> -shares its clocks, power domain and irq.
>>> -
>>> -Required properties:
>>> -- compatible      : Should be "rockchip,iommu"
>>> -- reg             : Address space for the configuration registers
>>> -- interrupts      : Interrupt specifier for the IOMMU instance
>>> -- interrupt-names : Interrupt name for the IOMMU instance
>>> -- #iommu-cells    : Should be <0>.  This indicates the iommu is a
>>> -                    "single-master" device, and needs no additional information
>>> -                    to associate with its master device.  See:
>>> -                    Documentation/devicetree/bindings/iommu/iommu.txt
>>> -- clocks          : A list of clocks required for the IOMMU to be accessible by
>>> -                    the host CPU.
>>> -- clock-names     : Should contain the following:
>>> -       "iface" - Main peripheral bus clock (PCLK/HCL) (required)
>>> -       "aclk"  - AXI bus clock (required)
>>> -
>>> -Optional properties:
>>> -- rockchip,disable-mmu-reset : Don't use the mmu reset operation.
>>> -                              Some mmu instances may produce unexpected results
>>> -                              when the reset operation is used.
>>> -
>>> -Example:
>>> -
>>> -       vopl_mmu: iommu@ff940300 {
>>> -               compatible = "rockchip,iommu";
>>> -               reg = <0xff940300 0x100>;
>>> -               interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>>> -               interrupt-names = "vopl_mmu";
>>> -               clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
>>> -               clock-names = "aclk", "iface";
>>> -               #iommu-cells = <0>;
>>> -       };
>>> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
>>> new file mode 100644
>>> index 000000000000..0db208cf724a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
>>> @@ -0,0 +1,79 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iommu/rockchip,iommu.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Rockchip IOMMU
>>> +
>>> +maintainers:
>>> +  - Heiko Stuebner <heiko@sntech.de>
>>> +
>>> +description: |+
>>> +  A Rockchip DRM iommu translates io virtual addresses to physical addresses for
>>> +  its master device. Each slave device is bound to a single master device and
>>> +  shares its clocks, power domain and irq.
>>> +
>>> +  For information on assigning IOMMU controller to its peripheral devices,
>>> +  see generic IOMMU bindings.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: rockchip,iommu
>>> +
>>> +  reg:
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +
>>> +  interrupts:
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +
>>> +  interrupt-names:
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +
>> AFAICS, the driver supports handling multiple MMUs, and there's one reg and
>> interrupt cell for each MMU. IOW, there's no requirement that maxItems is 2.
>>
>> Is there any way we can describe that? Or maybe just allow a bigger maximum?
> With #iommu-cells == 0, how would one distinguish which IOMMU is
> associated with a device? IOW, is more that 1 really usable?
>
> If you need more just pick a maxItems value that's either the most seen
> or 'should be enough'TM. If the entries are just multiple instances of
> the same thing, please note that here.

In current dts files it is up to two interruptions per IOMMU hardware blocks
so I will keep it to this value.

Benjamin

>
> Rob
>
