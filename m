Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5831CCB3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhBPPLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:11:43 -0500
Received: from foss.arm.com ([217.140.110.172]:37116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhBPPLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:11:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23AB831B;
        Tue, 16 Feb 2021 07:10:34 -0800 (PST)
Received: from [10.57.48.219] (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6293C3F694;
        Tue, 16 Feb 2021 07:10:32 -0800 (PST)
Subject: Re: [PATCH v3 1/2] dt-bindings: iommu: add bindings for sprd iommu
To:     Rob Herring <robh@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
References: <20210203090727.789939-1-zhang.lyra@gmail.com>
 <20210203090727.789939-2-zhang.lyra@gmail.com>
 <20210204232549.GA1305874@robh.at.kernel.org>
 <CAAfSe-tQ+7GuO1PgYa=9wqrpVf3N4br=bn8gJcaEJmnYpc1sxA@mail.gmail.com>
 <CAL_JsqLi3vJ2tDrwa3YL1rdxtAYWnA72rxCRNPtz_EzvWhTn7w@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4b88182c-f3fb-20d5-de6f-7fd6eddbcba7@arm.com>
Date:   Tue, 16 Feb 2021 15:10:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLi3vJ2tDrwa3YL1rdxtAYWnA72rxCRNPtz_EzvWhTn7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-10 19:21, Rob Herring wrote:
> On Fri, Feb 5, 2021 at 1:21 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>>
>> Hi Rob,
>>
>> On Fri, 5 Feb 2021 at 07:25, Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Wed, Feb 03, 2021 at 05:07:26PM +0800, Chunyan Zhang wrote:
>>>> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>>>>
>>>> This iommu module can be used by Unisoc's multimedia devices, such as
>>>> display, Image codec(jpeg) and a few signal processors, including
>>>> VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.
>>>>
>>>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
>>>> ---
>>>>   .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
>>>>   1 file changed, 72 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
>>>> new file mode 100644
>>>> index 000000000000..4fc99e81fa66
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
>>>> @@ -0,0 +1,72 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +# Copyright 2020 Unisoc Inc.
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Unisoc IOMMU and Multi-media MMU
>>>> +
>>>> +maintainers:
>>>> +  - Chunyan Zhang <zhang.lyra@gmail.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - sprd,iommu-v1
>>>> +
>>>> +  "#iommu-cells":
>>>> +    const: 0
>>>> +    description:
>>>> +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
>>>> +      additional information needs to associate with its master device.
>>>> +      Please refer to the generic bindings document for more details,
>>>> +      Documentation/devicetree/bindings/iommu/iommu.txt
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +    description:
>>>> +      Not required if 'sprd,iommu-regs' is defined.
>>>> +
>>>> +  clocks:
>>>> +    description:
>>>> +      Reference to a gate clock phandle, since access to some of IOMMUs are
>>>> +      controlled by gate clock, but this is not required.
>>>> +
>>>> +  sprd,iommu-regs:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +    description:
>>>> +      Reference to a syscon phandle plus 1 cell, the syscon defines the
>>>> +      register range used by the iommu and the media device, the cell
>>>> +      defines the offset for iommu registers. Since iommu module shares
>>>> +      the same register range with the media device which uses it.
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - "#iommu-cells"

OK, so apparently the hardware is not quite as trivial as my initial 
impression, and you should have interrupts as well.

>>>> +
>>>> +oneOf:
>>>> +  - required:
>>>> +      - reg
>>>> +  - required:
>>>> +      - sprd,iommu-regs
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    iommu_disp: iommu-disp {
>>>> +      compatible = "sprd,iommu-v1";
>>>> +      sprd,iommu-regs = <&dpu_regs 0x800>;
>>>
>>> If the IOMMU is contained within another device, then it should just be
>>> a child node of that device.
>>
>> Yes, actually IOMMU can be seen as a child of multimedia devices, I
>> considered moving IOMMU under into multimedia device node, but
>> multimedia devices need IOMMU when probe[1], so I dropped that idea.
> 
> Don't design your binding around working-around linux issues.

Having stumbled across the DRM driver patches the other day, I now see 
where this is coming from, and it's even worse than that - this whole 
binding seems to be largely working around bad driver design.

>> And they share the same register base, e.g.
>>
>> +               mm {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <2>;
>> +                       #size-cells = <2>;
>> +                       ranges;
>> +
>> +                       dpu_regs: syscon@63000000 {
> 
> Drop this node.
> 
>> +                               compatible = "sprd,sc9863a-dpuregs", "syscon";
>> +                               reg = <0 0x63000000 0 0x1000>;
>> +                       };
>> +
>> +                       dpu: dpu@63000000 {
>> +                               compatible = "sprd,sharkl3-dpu";
>> +                               sprd,disp-regs = <&dpu_regs>;
> 
> reg = <0 0x63000000 0 0x800>;

In fact judging by the other driver it looks like the length only needs 
to be 0x200 here (but maybe there's more to come in future).

>> +                               iommus = <&iommu_dispc>;
>> +                       };
>> +
>> +                       iommu_dispc: iommu@63000000 {
>> +                               compatible = "sprd,iommu-v1";
>> +                               sprd,iommu-regs = <&dpu_regs 0x800>;
> 
> reg = <0 0x63000800 0 0x800>;

...and this one looks to need less than 0x80, even :)

> 
>> +                               #iommu-cells = <0>;
> 
> Though given it seems there is only 1 client and this might really be
> just 1 h/w block, you don't really need to use the iommu binding at
> all. The DPU should be able to instantiate it's own IOMMU device.
> There's other examples of this such as mali GPU though that is all one
> driver, but that's a Linux implementation detail.

FWIW that's really a very different situation - the MMUs in a Mali GPU 
are fundamental parts of its internal pipelines and would never make 
sense to handle as separate devices (if it were even feasible to try). 
An IOMMU like this one is typically a logically-distinct block stuck to 
the external bus interface of any old device, rewriting transactions 
that said device has already issued - it's telling that it needs to 
allocate the prot_page scratchpad for "faulting" transactions to still 
flow somewhere, implying that it's not even involved enough to be able 
to terminate them.

As such I think it *does* make complete sense to describe even 
"dedicated" IOMMUs like this one, Rockchip, Exynos, etc. in DT. 
Otherwise you'd be effectively forcing OSes to turn half their 
display/media drivers into mini board files with secret knowledge of 
which blocks are integrated with IOMMUs on which SoCs.

Robin.
