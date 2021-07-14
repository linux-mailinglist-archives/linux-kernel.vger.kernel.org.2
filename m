Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36503C806E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 10:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbhGNIo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 04:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbhGNIo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:44:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F37C06175F;
        Wed, 14 Jul 2021 01:41:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9327A1F42ABD
Subject: Re: [PATCH 3/6] arm64: dts: mt8173: Add the mmsys reset bit to reset
 the dsi0
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20210630144646.868702-1-enric.balletbo@collabora.com>
 <20210630164623.3.I7bd7d9a8da5e2894711b700a1127e6902a2b2f1d@changeid>
 <CAAOTY_-VAvKCkBj1q4euWFcmbnNUJfXpG9rh9vua80yrok-y9w@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <406a96c6-8547-1908-0f52-fca783d05262@collabora.com>
Date:   Wed, 14 Jul 2021 10:41:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY_-VAvKCkBj1q4euWFcmbnNUJfXpG9rh9vua80yrok-y9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

Thank you for the review.

On 1/7/21 0:48, Chun-Kuang Hu wrote:
> HI, Enric:
> 
> Enric Balletbo i Serra <enric.balletbo@collabora.com> 於 2021年6月30日 週三 下午10:47寫道：
>>
>> Reset the DSI hardware is needed to prevent different settings between
>> the bootloader and the kernel.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi  | 2 ++
>>  include/dt-bindings/reset/mt8173-resets.h | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> index e5596fe01a1d..36c3998eb7f1 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -1036,6 +1036,7 @@ mmsys: syscon@14000000 {
>>                         assigned-clocks = <&topckgen CLK_TOP_MM_SEL>;
>>                         assigned-clock-rates = <400000000>;
>>                         #clock-cells = <1>;
>> +                       #reset-cells = <1>;
>>                         mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
>>                                  <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
>>                         mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>> @@ -1262,6 +1263,7 @@ dsi0: dsi@1401b000 {
>>                                  <&mmsys CLK_MM_DSI0_DIGITAL>,
>>                                  <&mipi_tx0>;
>>                         clock-names = "engine", "digital", "hs";
>> +                       resets = <&mmsys MT8173_MMSYS_SW0_RST_B_DISP_DSI0>;
> 
> Add this in binding document. It would be good if the binding document
> is in yaml format.
> 

Ack, will add this optional property in the mediatek,dsi.txt binding.

I can try to translate it to yaml but IMO would be better if someone that really
knows the hardware and has access to the datasheet could do it. From the current
.txt file I can deduce most of the things, but still I can lack some kind of
information, i.e I know that there are three clocks, but don't know if all three
are needed (from .txt yes, are all needed but not sure), also I know that the
names of the clocks are "engine", "digital", and "hs", but I don't know the
description of these clocks.

IMHO would be nice if someone from Mediatek can take care of all the binding
migration to yaml.

Cheers,
  Enric

> Regards,
> Chun-Kuang.
> 
>>                         phys = <&mipi_tx0>;
>>                         phy-names = "dphy";
>>                         status = "disabled";
>> diff --git a/include/dt-bindings/reset/mt8173-resets.h b/include/dt-bindings/reset/mt8173-resets.h
>> index ba8636eda5ae..6a60c7cecc4c 100644
>> --- a/include/dt-bindings/reset/mt8173-resets.h
>> +++ b/include/dt-bindings/reset/mt8173-resets.h
>> @@ -27,6 +27,8 @@
>>  #define MT8173_INFRA_GCE_FAXI_RST       40
>>  #define MT8173_INFRA_MMIOMMURST         47
>>
>> +/* MMSYS resets */
>> +#define MT8173_MMSYS_SW0_RST_B_DISP_DSI0       25
>>
>>  /*  PERICFG resets */
>>  #define MT8173_PERI_UART0_SW_RST        0
>> --
>> 2.30.2
>>
