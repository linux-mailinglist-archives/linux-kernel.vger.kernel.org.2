Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998E844B428
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244595AbhKIUoO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Nov 2021 15:44:14 -0500
Received: from aposti.net ([89.234.176.197]:53172 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242487AbhKIUoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:44:13 -0500
Date:   Tue, 09 Nov 2021 20:41:16 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/2] dt-bindings: Rename Ingenic CGU headers to
 ingenic,*.h
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, list@opendingux.net,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Message-Id: <S4OB2R.59MVHDUBC2VP3@crapouillou.net>
In-Reply-To: <YYqzT6ZjyQPMisXE@robh.at.kernel.org>
References: <20211016133322.40771-1-paul@crapouillou.net>
        <YYqzT6ZjyQPMisXE@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le mar., nov. 9 2021 at 11:43:43 -0600, Rob Herring <robh@kernel.org> a 
écrit :
> On Sat, 16 Oct 2021 14:33:21 +0100, Paul Cercueil wrote:
>>  Tidy up a bit the tree, by prefixing all include/dt-bindings/clock/ 
>> files
>>  related to Ingenic SoCs with 'ingenic,'.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>> 
>>  Notes:
>>      v2: Fix x1000-cgu.h and x1830-cgu.h incorrectly renamed to
>>          x1000.h / x1830.h
>> 
>>   Documentation/devicetree/bindings/clock/ingenic,cgu.yaml      | 2 
>> +-
>>   Documentation/devicetree/bindings/display/ingenic,ipu.yaml    | 2 
>> +-
>>   Documentation/devicetree/bindings/display/ingenic,lcd.yaml    | 4 
>> ++--
>>   Documentation/devicetree/bindings/dma/ingenic,dma.yaml        | 2 
>> +-
>>   Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml        | 2 
>> +-
>>   Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml    | 2 
>> +-
>>   .../devicetree/bindings/memory-controllers/ingenic,nemc.yaml  | 2 
>> +-
>>   .../devicetree/bindings/mips/ingenic/ingenic,cpu.yaml         | 2 
>> +-
>>   Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml        | 2 
>> +-
>>   Documentation/devicetree/bindings/mtd/ingenic,nand.yaml       | 2 
>> +-
>>   Documentation/devicetree/bindings/net/ingenic,mac.yaml        | 2 
>> +-
>>   .../devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml       | 2 
>> +-
>>   Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml    | 2 
>> +-
>>   Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml | 2 
>> +-
>>   Documentation/devicetree/bindings/rng/ingenic,trng.yaml       | 2 
>> +-
>>   Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml        | 2 
>> +-
>>   Documentation/devicetree/bindings/serial/ingenic,uart.yaml    | 2 
>> +-
>>   Documentation/devicetree/bindings/sound/ingenic,aic.yaml      | 2 
>> +-
>>   Documentation/devicetree/bindings/sound/ingenic,codec.yaml    | 2 
>> +-
>>   Documentation/devicetree/bindings/timer/ingenic,sysost.yaml   | 2 
>> +-
>>   Documentation/devicetree/bindings/timer/ingenic,tcu.yaml      | 2 
>> +-
>>   Documentation/devicetree/bindings/usb/ingenic,musb.yaml       | 2 
>> +-
>>   arch/mips/boot/dts/ingenic/jz4725b.dtsi                       | 2 
>> +-
>>   arch/mips/boot/dts/ingenic/jz4740.dtsi                        | 2 
>> +-
>>   arch/mips/boot/dts/ingenic/jz4770.dtsi                        | 2 
>> +-
>>   arch/mips/boot/dts/ingenic/jz4780.dtsi                        | 2 
>> +-
>>   arch/mips/boot/dts/ingenic/x1000.dtsi                         | 2 
>> +-
>>   arch/mips/boot/dts/ingenic/x1830.dtsi                         | 2 
>> +-
>>   drivers/clk/ingenic/jz4725b-cgu.c                             | 2 
>> +-
>>   drivers/clk/ingenic/jz4740-cgu.c                              | 2 
>> +-
>>   drivers/clk/ingenic/jz4760-cgu.c                              | 2 
>> +-
>>   drivers/clk/ingenic/jz4770-cgu.c                              | 2 
>> +-
>>   drivers/clk/ingenic/jz4780-cgu.c                              | 2 
>> +-
>>   drivers/clk/ingenic/x1000-cgu.c                               | 2 
>> +-
>>   drivers/clk/ingenic/x1830-cgu.c                               | 2 
>> +-
>>   .../clock/{jz4725b-cgu.h => ingenic,jz4725b-cgu.h}            | 0
>>   .../dt-bindings/clock/{jz4740-cgu.h => ingenic,jz4740-cgu.h}  | 0
>>   .../dt-bindings/clock/{jz4760-cgu.h => ingenic,jz4760-cgu.h}  | 0
>>   .../dt-bindings/clock/{jz4770-cgu.h => ingenic,jz4770-cgu.h}  | 0
>>   .../dt-bindings/clock/{jz4780-cgu.h => ingenic,jz4780-cgu.h}  | 0
>>   .../dt-bindings/clock/{x1000-cgu.h => ingenic,x1000-cgu.h}    | 0
>>   .../dt-bindings/clock/{x1830-cgu.h => ingenic,x1830-cgu.h}    | 0
>>   42 files changed, 36 insertions(+), 36 deletions(-)
>>   rename include/dt-bindings/clock/{jz4725b-cgu.h => 
>> ingenic,jz4725b-cgu.h} (100%)
>>   rename include/dt-bindings/clock/{jz4740-cgu.h => 
>> ingenic,jz4740-cgu.h} (100%)
>>   rename include/dt-bindings/clock/{jz4760-cgu.h => 
>> ingenic,jz4760-cgu.h} (100%)
>>   rename include/dt-bindings/clock/{jz4770-cgu.h => 
>> ingenic,jz4770-cgu.h} (100%)
>>   rename include/dt-bindings/clock/{jz4780-cgu.h => 
>> ingenic,jz4780-cgu.h} (100%)
>>   rename include/dt-bindings/clock/{x1000-cgu.h => 
>> ingenic,x1000-cgu.h} (100%)
>>   rename include/dt-bindings/clock/{x1830-cgu.h => 
>> ingenic,x1830-cgu.h} (100%)
>> 
> 
> Applied, thanks!
> 
> I'll let Stephen take patch 2 after rc1.

Perfect, thanks!

I will later send a patch to update the spi/ingenic-spi.yaml example 
(the one that was in linux-next and not yet in master) so that it 
points to the right include.

-Paul


