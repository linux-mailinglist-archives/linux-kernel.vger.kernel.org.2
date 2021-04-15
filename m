Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE2D36047E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhDOIic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhDOIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:38:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A908FC061756;
        Thu, 15 Apr 2021 01:38:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 432ED1F42C47
Subject: Re: [PATCH 3/3] arm64: dts: mt8183-kukui: fix dtbs_check warnings
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        matthias.bgg@kernel.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20210414144643.17435-1-matthias.bgg@kernel.org>
 <20210414144643.17435-3-matthias.bgg@kernel.org>
 <CANMq1KAxZ+QiRR7LgR22pvhs4us=ne_VtSM-S_byCC0N__6BZA@mail.gmail.com>
 <d87f20bd-2195-663b-dd0b-ea1fa2f28a46@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <82fdfa6e-9c4d-7146-fd90-353e350159c2@collabora.com>
Date:   Thu, 15 Apr 2021 10:37:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <d87f20bd-2195-663b-dd0b-ea1fa2f28a46@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 15/4/21 9:47, Matthias Brugger wrote:
> Hi Nicolas,
> 
> On 15/04/2021 02:29, Nicolas Boichat wrote:
>> On Wed, Apr 14, 2021 at 10:46 PM <matthias.bgg@kernel.org> wrote:
>>>
>>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>>
>>> The dsi children don't have any reg property,
>>
>> Confused, see below.
>>
>>> so we don't need address and
>>> size cells. This makes dtbs_check happy.
>>>
>>> CC: Hsin-Yi Wang <hsinyi@chromium.org>
>>> CC: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> CC: Nicolas Boichat <drinkcat@chromium.org>
>>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>>>
>>> ---
>>>
>>>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>>> index ff56bcfa3370..f4dca6a33168 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>>> @@ -251,8 +251,7 @@ &cpu7 {
>>>
>>>  &dsi0 {
>>>         status = "okay";
>>> -       #address-cells = <1>;
>>> -       #size-cells = <0>;
>>> +
>>>         panel: panel@0 {
>>>                 /* compatible will be set in board dts */
>>>                 reg = <0>;
>>
>> ^^ isn't that... a reg property?
>>
> 
> Yes, that's my fault. I'm not quite sure why we would need this reg property. In
> any case also we have it present "dtbs_check W=1" throws the following warning:
> mediatek/mt8183.dtsi:1234.22-1246.5: Warning (avoid_unnecessary_addr_size):
> /soc/dsi@14014000: unnecessary #address-cells/#size-cells without "ranges" or
> child "reg" property
> 
> 
> Can you have a look at that?
> 

I think it is needed reg. See at
Documentation/devicetree/bindings/display/dsi-controller.yaml

Regards,
Enric

> Regards,
> Matthias
> 
>>> --
>>> 2.30.2
>>>
