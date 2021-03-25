Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0401348947
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 07:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhCYGmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 02:42:06 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:50606 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCYGlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:41:55 -0400
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 4BED41E83;
        Thu, 25 Mar 2021 14:41:13 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1826T139670310491904S1616654470337483_;
        Thu, 25 Mar 2021 14:41:11 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <14a48bc4bc562a7d38fc8615f5c964a6>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: finley.xiao@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v4 2/4] dt-bindings: power: rockchip: Convert to
 json-schema
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        robh+dt@kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com
References: <20210324071609.7531-1-zhangqing@rock-chips.com>
 <40a7fad3-17bb-9275-ed4a-2e3d526d05a1@collabora.com>
 <f1323618-7990-9bb7-a8c2-a7321a4034f8@collabora.com>
 <2066097.irdbgypaU6@diego>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <6da85755-276d-1f4d-cfa8-2d0e4d836c6b@rock-chips.com>
Date:   Thu, 25 Mar 2021 14:41:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2066097.irdbgypaU6@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Heiko:

在 2021/3/24 下午9:31, Heiko Stübner 写道:
> Am Mittwoch, 24. März 2021, 11:32:42 CET schrieb Enric Balletbo i Serra:
>> On 24/3/21 11:25, Enric Balletbo i Serra wrote:
>>> Hi Elaine,
>>>
>>> On 24/3/21 11:18, elaine.zhang wrote:
>>>> Hi,  Enric
>>>>
>>>> 在 2021/3/24 下午5:56, Enric Balletbo i Serra 写道:
>>>>> Hi Elaine,
>>>>>
>>>>> This is not the exact version I sent, and you reintroduced a "problem" that were
>>>>> already solved/discussed on previous versions. See below:
>>>>>
>>>>> On 24/3/21 8:16, Elaine Zhang wrote:
>>>>>> Convert the soc/rockchip/power_domain.txt binding document to
>>>>>> json-schema and move to the power bindings directory.
>>>>>>
>>>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>>> If you do significant is a good practice shortly describe them within [] here.
>>>>>
>>>>>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>>>>> Note that my last version already had the
>>>>>
>>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>>
>>>>> Which should be fine for merging (with probably only minor changes) and you
>>>>> could maintain if you don't do significant changes, but that's not the case, as
>>>>> I said, you are reintroducing one problem. Please review the comments already
>>>>> received on this patchset or similar patchsets to avoid this.
>>>>>
>>>>>> ---
>>>>>>    .../power/rockchip,power-controller.yaml      | 284 ++++++++++++++++++
>>>>>>    .../bindings/soc/rockchip/power_domain.txt    | 136 ---------
>>>>>>    2 files changed, 284 insertions(+), 136 deletions(-)
>>>>>>    create mode 100644
>>>>>> Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>>>>>>    delete mode 100644
>>>>>> Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>>>>>> b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..a220322c5139
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>>>>>> @@ -0,0 +1,284 @@
>>>>>> +# SPDX-License-Identifier: GPL-2.0-only
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Rockchip Power Domains
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Elaine Zhang <zhangqing@rock-chips.com>
>>>>>> +  - Rob Herring <robh+dt@kernel.org>
>>>>> Up to Rob, but I don't think Rob would like to be the maintainer. I think you
>>>>> can only include yourself and Heiko.
>>>>>
>>>>>
>>>>>> +  - Heiko Stuebner <heiko@sntech.de>
>>>>>> +
>>>>>> +description: |
>>>>>> +  Rockchip processors include support for multiple power domains which can be
>>>>>> +  powered up/down by software based on different application scenarios to
>>>>>> save power.
>>>>>> +
>>>>>> +  Power domains contained within power-controller node are generic power domain
>>>>>> +  providers documented in
>>>>>> Documentation/devicetree/bindings/power/power-domain.yaml.
>>>>>> +
>>>>>> +  IP cores belonging to a power domain should contain a "power-domains"
>>>>>> +  property that is a phandle for the power domain node representing the domain.
>>>>>> +
>>>>>> +properties:
>>>>>> +  $nodename:
>>>>>> +    const: power-controller
>>>>>> +
>>>>>> +  compatible:
>>>>>> +    enum:
>>>>>> +      - rockchip,px30-power-controller
>>>>>> +      - rockchip,rk3036-power-controller
>>>>>> +      - rockchip,rk3066-power-controller
>>>>>> +      - rockchip,rk3128-power-controller
>>>>>> +      - rockchip,rk3188-power-controller
>>>>>> +      - rockchip,rk3228-power-controller
>>>>>> +      - rockchip,rk3288-power-controller
>>>>>> +      - rockchip,rk3328-power-controller
>>>>>> +      - rockchip,rk3366-power-controller
>>>>>> +      - rockchip,rk3368-power-controller
>>>>>> +      - rockchip,rk3399-power-controller
>>>>>> +
>>>>>> +  "#power-domain-cells":
>>>>>> +    const: 1
>>>>>> +
>>>>>> +  "#address-cells":
>>>>>> +    const: 1
>>>>>> +
>>>>>> +  "#size-cells":
>>>>>> +    const: 0
>>>>>> +
>>>>>> +patternProperties:
>>>>>> +  "^pd_[0-9a-z_]{2,10}@[0-9a-f]+$":
>>>>>> +    type: object
>>>>>> +    description: |
>>>>>> +      Represents the power domains within the power controller node as
>>>>>> documented
>>>>>> +      in Documentation/devicetree/bindings/power/power-domain.yaml.
>>>>>> +
>>>>> The node names must be generic, as this is power-domain must be in the form:
>>>>>
>>>>> +patternProperties:
>>>>> +  "^power-domain@[0-9a-f]+$":
>>>> In this way, dtbs_check cannot be passed, and all the usage methods in dts of
>>>> Rockchip need to be corrected, which I think is a bigger change.
>>> Well, the problem is in the Rockchip dtbs, so needs to be fixed there. The
>>> bindings must describe hardware in a generic way, not describe the actual dtbs
>>> to not report errors.
>>>
>> FWIW I remember I did something regarding this but never sent to upstream, feel
>> free to pick if you find useful.
>>
>> *
>> https://gitlab.collabora.com/eballetbo/linux/-/commit/12499f223e3d33602449b9102404fe573fb804f5
>> *
>> https://gitlab.collabora.com/eballetbo/linux/-/commit/12499f223e3d33602449b9102404fe573fb804f5
>> *
>> https://gitlab.collabora.com/eballetbo/linux/-/commit/492bf2213c341152a1c2423242c5634b9e53ff27
> looks good that way. I did look at the power-domain driver and
> we're (of course) not doing anything with the name in front of the @ :-) .
>
> So I'd be happy to get these.
>
> Heiko

I still don't want to modify this,  I think the PD summary will become 
less intuitive.

Now:

domain                          status          slaves
     /device                                             runtime status
----------------------------------------------------------------------
pd_pipe                         on
     /devices/platform/3c0800000.pcie unsupported
     /devices/platform/fc800000.sata                     active
     /devices/platform/usbdrd/fcc00000.dwc3              active
     /devices/platform/usbhost/fd000000.dwc3             active
pd_rkvenc                       off-0
     /devices/platform/fdf40f00.iommu                    suspended
     /devices/platform/fdf40000.rkvenc                   suspended
pd_rkvdec                       off-0
     /devices/platform/fdf80800.iommu                    suspended
     /devices/platform/fdf80200.rkvdec                   suspended
pd_vpu                          off-0
     /devices/platform/fdea0800.iommu                    suspended
     /devices/platform/fdea0400.vdpu                     suspended
pd_rga                          off-0
     /devices/platform/fded0480.iommu                    suspended
     /devices/platform/fdee0800.iommu                    suspended
     /devices/platform/fdef0800.iommu                    suspended
     /devices/platform/fdee0000.vepu                     suspended
     /devices/platform/fdef0000.iep                      suspended
     /devices/platform/fded0000.jpegd                    suspended
     /devices/platform/fdeb0000.rk_rga                   suspended
pd_vo                           on
     /devices/platform/fe850000.mipi-dphy                suspended
     /devices/platform/fe040000.vop                      active
     /devices/platform/fe0c0000.edp                      suspended
     /devices/platform/fe0a0000.hdmi                     active
     /devices/platform/fe060000.dsi                      active
pd_vi                           off-0
     /devices/platform/fdff1a00.iommu                    suspended
     /devices/platform/fdff0000.rkisp                    suspended
pd_gpu                          on
     /devices/platform/fde60000.gpu                      active
pd_npu                          off-0

If modify to power-domain@:

domain                          status          slaves
     /device                                             runtime status
----------------------------------------------------------------------
power-domain                    on
     /devices/platform/3c0800000.pcie unsupported
     /devices/platform/fc800000.sata                     active
     /devices/platform/usbdrd/fcc00000.dwc3              active
     /devices/platform/usbhost/fd000000.dwc3             active
power-domain                    off-0
     /devices/platform/fdf40f00.iommu                    suspended
     /devices/platform/fdf40000.rkvenc                   suspended
power-domain                    off-0
     /devices/platform/fdf80800.iommu                    suspended
     /devices/platform/fdf80200.rkvdec                   suspended
power-domain                    off-0
     /devices/platform/fdea0800.iommu                    suspended
     /devices/platform/fdea0400.vdpu                     suspended
power-domain                    off-0
     /devices/platform/fded0480.iommu                    suspended
     /devices/platform/fdee0800.iommu                    suspended
     /devices/platform/fdef0800.iommu                    suspended
     /devices/platform/fdee0000.vepu                     suspended
     /devices/platform/fdef0000.iep                      suspended
     /devices/platform/fded0000.jpegd                    suspended
     /devices/platform/fdeb0000.rk_rga                   suspended
power-domain                    on
     /devices/platform/fe850000.mipi-dphy                suspended
     /devices/platform/fe040000.vop                      active
     /devices/platform/fe0c0000.edp                      suspended
     /devices/platform/fe0a0000.hdmi                     active
     /devices/platform/fe060000.dsi                      active
power-domain                    off-0
     /devices/platform/fdff1a00.iommu                    suspended
     /devices/platform/fdff0000.rkisp                    suspended
power-domain                    on
     /devices/platform/fde60000.gpu                      active
power-domain                    off-0
console:/ #

I think the now one is more intuitive, so I don't want to fix it.

>
>
>
>


