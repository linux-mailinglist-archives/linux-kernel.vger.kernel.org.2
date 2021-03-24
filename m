Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05F33479AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhCXNcM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Mar 2021 09:32:12 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34288 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235048AbhCXNbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:31:39 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lP3ba-0000T8-Q0; Wed, 24 Mar 2021 14:31:26 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     "elaine.zhang" <zhangqing@rock-chips.com>, robh+dt@kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com
Subject: Re: [PATCH v4 2/4] dt-bindings: power: rockchip: Convert to json-schema
Date:   Wed, 24 Mar 2021 14:31:25 +0100
Message-ID: <2066097.irdbgypaU6@diego>
In-Reply-To: <f1323618-7990-9bb7-a8c2-a7321a4034f8@collabora.com>
References: <20210324071609.7531-1-zhangqing@rock-chips.com> <40a7fad3-17bb-9275-ed4a-2e3d526d05a1@collabora.com> <f1323618-7990-9bb7-a8c2-a7321a4034f8@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 24. März 2021, 11:32:42 CET schrieb Enric Balletbo i Serra:
> 
> On 24/3/21 11:25, Enric Balletbo i Serra wrote:
> > Hi Elaine,
> > 
> > On 24/3/21 11:18, elaine.zhang wrote:
> >> Hi,  Enric
> >>
> >> 在 2021/3/24 下午5:56, Enric Balletbo i Serra 写道:
> >>> Hi Elaine,
> >>>
> >>> This is not the exact version I sent, and you reintroduced a "problem" that were
> >>> already solved/discussed on previous versions. See below:
> >>>
> >>> On 24/3/21 8:16, Elaine Zhang wrote:
> >>>> Convert the soc/rockchip/power_domain.txt binding document to
> >>>> json-schema and move to the power bindings directory.
> >>>>
> >>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>> If you do significant is a good practice shortly describe them within [] here.
> >>>
> >>>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> >>> Note that my last version already had the
> >>>
> >>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>>
> >>> Which should be fine for merging (with probably only minor changes) and you
> >>> could maintain if you don't do significant changes, but that's not the case, as
> >>> I said, you are reintroducing one problem. Please review the comments already
> >>> received on this patchset or similar patchsets to avoid this.
> >>>
> >>>> ---
> >>>>   .../power/rockchip,power-controller.yaml      | 284 ++++++++++++++++++
> >>>>   .../bindings/soc/rockchip/power_domain.txt    | 136 ---------
> >>>>   2 files changed, 284 insertions(+), 136 deletions(-)
> >>>>   create mode 100644
> >>>> Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> >>>>   delete mode 100644
> >>>> Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> >>>>
> >>>> diff --git
> >>>> a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> >>>> b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..a220322c5139
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> >>>> @@ -0,0 +1,284 @@
> >>>> +# SPDX-License-Identifier: GPL-2.0-only
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: Rockchip Power Domains
> >>>> +
> >>>> +maintainers:
> >>>> +  - Elaine Zhang <zhangqing@rock-chips.com>
> >>>> +  - Rob Herring <robh+dt@kernel.org>
> >>> Up to Rob, but I don't think Rob would like to be the maintainer. I think you
> >>> can only include yourself and Heiko.
> >>>
> >>>
> >>>> +  - Heiko Stuebner <heiko@sntech.de>
> >>>> +
> >>>> +description: |
> >>>> +  Rockchip processors include support for multiple power domains which can be
> >>>> +  powered up/down by software based on different application scenarios to
> >>>> save power.
> >>>> +
> >>>> +  Power domains contained within power-controller node are generic power domain
> >>>> +  providers documented in
> >>>> Documentation/devicetree/bindings/power/power-domain.yaml.
> >>>> +
> >>>> +  IP cores belonging to a power domain should contain a "power-domains"
> >>>> +  property that is a phandle for the power domain node representing the domain.
> >>>> +
> >>>> +properties:
> >>>> +  $nodename:
> >>>> +    const: power-controller
> >>>> +
> >>>> +  compatible:
> >>>> +    enum:
> >>>> +      - rockchip,px30-power-controller
> >>>> +      - rockchip,rk3036-power-controller
> >>>> +      - rockchip,rk3066-power-controller
> >>>> +      - rockchip,rk3128-power-controller
> >>>> +      - rockchip,rk3188-power-controller
> >>>> +      - rockchip,rk3228-power-controller
> >>>> +      - rockchip,rk3288-power-controller
> >>>> +      - rockchip,rk3328-power-controller
> >>>> +      - rockchip,rk3366-power-controller
> >>>> +      - rockchip,rk3368-power-controller
> >>>> +      - rockchip,rk3399-power-controller
> >>>> +
> >>>> +  "#power-domain-cells":
> >>>> +    const: 1
> >>>> +
> >>>> +  "#address-cells":
> >>>> +    const: 1
> >>>> +
> >>>> +  "#size-cells":
> >>>> +    const: 0
> >>>> +
> >>>> +patternProperties:
> >>>> +  "^pd_[0-9a-z_]{2,10}@[0-9a-f]+$":
> >>>> +    type: object
> >>>> +    description: |
> >>>> +      Represents the power domains within the power controller node as
> >>>> documented
> >>>> +      in Documentation/devicetree/bindings/power/power-domain.yaml.
> >>>> +
> >>> The node names must be generic, as this is power-domain must be in the form:
> >>>
> >>> +patternProperties:
> >>> +  "^power-domain@[0-9a-f]+$":
> >> In this way, dtbs_check cannot be passed, and all the usage methods in dts of
> >> Rockchip need to be corrected, which I think is a bigger change.
> > 
> > Well, the problem is in the Rockchip dtbs, so needs to be fixed there. The
> > bindings must describe hardware in a generic way, not describe the actual dtbs
> > to not report errors.
> > 
> 
> FWIW I remember I did something regarding this but never sent to upstream, feel
> free to pick if you find useful.
> 
> *
> https://gitlab.collabora.com/eballetbo/linux/-/commit/12499f223e3d33602449b9102404fe573fb804f5
> *
> https://gitlab.collabora.com/eballetbo/linux/-/commit/12499f223e3d33602449b9102404fe573fb804f5
> *
> https://gitlab.collabora.com/eballetbo/linux/-/commit/492bf2213c341152a1c2423242c5634b9e53ff27

looks good that way. I did look at the power-domain driver and
we're (of course) not doing anything with the name in front of the @ :-) .

So I'd be happy to get these.

Heiko


