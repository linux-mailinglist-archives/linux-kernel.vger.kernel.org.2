Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D889456D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhKSKeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhKSKeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:34:20 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A59C061574;
        Fri, 19 Nov 2021 02:31:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so7130690wmz.2;
        Fri, 19 Nov 2021 02:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=8qcNpIruPHOCURb4JPC4y8c/ZrBHmkV4VFdtM1GCETA=;
        b=W3Kulo/fHkMbv97aIBfN6IqZZZXmcgt+wmegf9k/5c4Ual92oePzDiGvmj09fe4La8
         ig2A9HwnkSlKQ7YQhBKpses7douOzDMq58ktoURi6CY/H+Gb5gSkOSuZ38sjzSAfnVig
         q3x1wZxK6YipnY+VeRsxaCMAPp9yC1BTtb6w6WEHPiNLnrsP62BsWSdenSePW7/IOz2j
         N5duvEcPMePXbGv/NmTi3vlI2sN1bWPv2Ft7guCFgBEQKMHeIEf8D5yJZlLXXzb9JROy
         uAOeke4EGOVq4Yc4zNv12at89xu9f9U44XZXkNhH7S8XkjQWTDbsc0xuygv0QV/6WfG+
         ksfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=8qcNpIruPHOCURb4JPC4y8c/ZrBHmkV4VFdtM1GCETA=;
        b=LaYOlgaywkx/NNnoLR9BVg3pRNmJAyMhzU5vjQsGnpvUmkqRPIjWFyrJLTfza2gnLd
         OSuexXKV7mZs8Dcs6+AsOCaLT3jtUehEV2PDKm5fA1JJOycc1aXMzMWBfA7APc/0+fEf
         /brTDxSkFRjsebGstiL7XVzX35EcVY2j38jFg9LcRNOvw6Erf9q3OaoWNBBsG6Sr107s
         IxGhiX6Vb2rPydT7uPyWhYGUO34oHLZE/eXracaMb43UtX/M82bCZJhgjZCWZHi5sXpy
         3CoOUerOSkM6f17ALp4Cw+/F2Zb/SVYHrkak5mJMPepS9YHGRhNkmJHNzKPPABAQ+NeS
         ZOGA==
X-Gm-Message-State: AOAM531kMxoIzvC39lNAMGPMjF73aeLsij0uk6s3xM/eyicD0n3LaPoQ
        lMiMbedf0Ev/514koUEijVY=
X-Google-Smtp-Source: ABdhPJwwKQv4fbKDqpxSYakdfFxL2W7Mh9oHH00GiSJk8QVXtjUQFhLBp0xI1vw7UMTKTzpQynNkbg==
X-Received: by 2002:a05:600c:4e8d:: with SMTP id f13mr5611132wmq.7.1637317877617;
        Fri, 19 Nov 2021 02:31:17 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id h22sm2952241wmq.14.2021.11.19.02.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 02:31:16 -0800 (PST)
Message-ID: <a4605e32-3af3-5636-6682-475bef8448d1@gmail.com>
Date:   Fri, 19 Nov 2021 11:31:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     John Crispin <john@phrozen.org>, Ryder Lee <Ryder.Lee@mediatek.com>
References: <20211018114009.13350-1-sam.shih@mediatek.com>
 <20211018114009.13350-3-sam.shih@mediatek.com>
 <d411aec5-efa8-c71d-8179-54ff52c17039@gmail.com>
 <d299493d8fec0f34f527942f2cdedf15f2136c9a.camel@mediatek.com>
 <c5c0849d-a95a-25a0-11f8-9156770afc10@gmail.com>
 <59963509ec833009f5c10f0a1aee91670224c6c7.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v7 2/3] arm64: dts: mediatek: add basic mt7986a support
In-Reply-To: <59963509ec833009f5c10f0a1aee91670224c6c7.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	

On 18/11/2021 04:48, Sam Shih wrote:
> Hi
> 
> On Tue, 2021-11-16 at 12:18 +0100, Matthias Brugger wrote:
>>
>> On 16/11/2021 02:39, Sam Shih wrote:
>>> Hi,
>>>
>>> On Mon, 2021-11-15 at 17:27 +0100, Matthias Brugger wrote:
>>>> Hi,
>>>>
>>>> On 18/10/2021 13:40, Sam Shih wrote:
>>>>> Add basic chip support for Mediatek mt7986a, include
>>>>> basic uart nodes, rng node and watchdog node.
>>>>>
>>>>> Add cpu node, timer node, gic node, psci and reserved-memory
>>>>> node
>>>>> for ARM Trusted Firmware.
>>>>>
>>>>
>>>> What is the exact difference between mt7986a and mt7986b? Right
>>>> now,
>>>> it's only
>>>> the compatible, for that it makes no sense to split them.
>>>>
>>>
>>> The difference between mt7986a and mt7986b is pinout which
>>> described
>>> in our pinctrl patch series
>>>
> https://urldefense.com/v3/__https://lore.kernel.org/all/20211022124036.5291-3-sam.shih@mediatek.com/__;!!CTRNKA9wMg0ARbw!0kseU8x1KnHHXDErh6Yj6MKqecufPEfGyeumtTBism47e99UFO2Gs-HfWjL1_jUv$
>>>   
>>>
>>> You are right, in this "basic SoC support" patch series, only show
>>> compatible differences
>>>
>>>> It would be good to see what the exact differences are, so that
>>>> we
>>>> can see if it
>>>> makes sense to have one of the alternatives:
>>>> 1) use a common mt7986.dtsi which get included by
>>>> mt7986[a,b].dtsi
>>>> 2) Use on mt7986.dtsi and only add one mt7986a.dtsi or
>>>> mt7986b.dtsi
>>>> which has
>>>> add-ons.
>>>>
>>>
>>> In this case, can we use solution (1) to create a generic
>>> mt7986.dtsi
>>> in this patch series, and add mt7986[a,b].dtsi to the dts part of
>>> the
>>> pinctrl patch series to separate the difference nodes?
>>>
>>
>> If the only difference is the GPIO controller then why not go with
>> solution 2.
>> Create a mt7986.dtsi which holds e.g. the node for pincontroller
>> mt7986a and
>> then create a mt7986b.dtsi that just changes compatible and gpio-
>> ranges:
>>
>> &pio {
>>      compatible = "mediatek,mt7986b-pinctrl";
>>      gpio-ranges = <&pio 0 0 41>, <&pio 66 66 35>;
>> }
>>
>> What do you think?
> 
> Ok,
> 
> For this basic patch series DTS, I will send the next version:
> - Use "mt7986.dtsi" instead of "mt7986[a,b].dtsi",
>    And make"mt7986.dtsi" get included by "mt7986[a,b]-rfb.dts"
>    (No dedicated uart1/uart2 pinout for mt7986b-rfb, status of dts node
> shoud be set to "disabled")
> 
> 
> For the pinctrl patch series DTS, I will send th next version:
> - Add "mt7986b.dtsi" according to your suggestion,
>    the new include
> chain will be:
>    mt7986a-rfb.dts <-- mt7986.dtsi (mt7986a pinctrl)
>   
> mt7986b-rfb.dts <-- mt7986b.dtsi (mt7986b pinctrl) <-- mt7986.dtsi
> (mt7986a pinctrl)
> 
> Do you agree above proposal?
> 

I mean something like this:
mt7986a.dtsi:
pio: pinctrl@1001f000 {
	compatible = "mediatek,mt7986a-pinctrl";
	reg = <0 0x1001f000 0 0x1000>,
	      <0 0x11c30000 0 0x1000>,
	      <0 0x11c40000 0 0x1000>,
	      <0 0x11e20000 0 0x1000>,
	      <0 0x11e30000 0 0x1000>,
	      <0 0x11f00000 0 0x1000>,
	      <0 0x11f10000 0 0x1000>,
	      <0 0x1000b000 0 0x1000>;
	reg-names = "gpio", "iocfg_rt", "iocfg_rb", "iocfg_lt",
		    "iocfg_lb", "iocfg_tr", "iocfg_tl", "eint";
	gpio-controller;
	#gpio-cells = <2>;
	gpio-ranges = <&pio 0 0 100>;
	interrupt-controller;
	interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
	interrupt-parent = <&gic>;
	#interrupt-cells = <2>;
};

mt7986b.dtsi:
#include "mt7986a.dtsi"

&pio {
      compatible = "mediatek,mt7986b-pinctrl";
      gpio-ranges = <&pio 0 0 41>, <&pio 66 66 35>;
}

mt7986b-rfb.dts:
#include "mt7986b.dtsi"

&pio {
	uart1_pins: uart1-pins {
		mux { [...]


mt7986a-rfb.dts:
#include "mt7986a.dtsi"

&pio {
	uart1_pins: uart1-pins {
		mux { [...]


Makes sense?

Regards,
Matthias

