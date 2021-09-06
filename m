Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8FF401B36
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241797AbhIFM3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbhIFM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:29:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38FBC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 05:28:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b10so9676307wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 05:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c7jc3IYQ7RGnXbO/5TtHji0wZke1aLhu70WLZPxKzuY=;
        b=jyBrm4jeQ/XpKdWWPTMjMxU4AhAImOR86O32BnDTgg2yYXIy2VUq0AU5GUTAljkgj4
         VDDdmJwovzbUspiL8jnTM47hLd9ZRg4DJg1p0nxa4BfKWq5bp0BcQyIebPfkzXxJUN8i
         oEDCvk76HjuKSiqTfWREA9jARHSqCITA0fqU8Dmp7RSvRp+WTm+vmsTV/Fw6pArfqJrs
         4PMpzckqf+ATKQvU/5FVLTzO4bxMktKXh4oSk/MOsyumaI/BpGZuvPS2uDte6umjbgaZ
         gMY3Gm/TuBfc1ssZyQ7ZK8Ao1/mnANlj5icGCiExsUpu5UI+/LH+bODvVTcAFpMuT65D
         uGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=c7jc3IYQ7RGnXbO/5TtHji0wZke1aLhu70WLZPxKzuY=;
        b=AcIS64rzjYdcoghP4qtV6mR0Itd6gz0dnVrqUvdxdjqsjUZUcnGHubWsEjmL2UEDJl
         M0oEi1ZqIdDJz7W0G4+eOx0DOsw1yknxGxS3JhRP43jSHuAXbRxDVtFhdDjdK5vo9XUZ
         bEV6rh0a0EVnwY/MiCqmmlWrvmCClMqBAkYmt/5Stp2TtcPcb4l1uCKJYs/zLcMKIpKS
         +wDBRTTwDczrxDkjxAFuoAAjGjUGAvhtqrjz+tiW1Ejzts9DwLFT92UnutsbJEovo6RB
         D/9DnS5CSDb+ZHr8ixrvzyCyl57Ny9uZNUDKEylHf7vyWGKIY9/1bcRH5hPXq1rOYt/T
         43Zw==
X-Gm-Message-State: AOAM531RS3fzhkMIPH3+qSyBDlbQTW6qx1nfzd+A0giQropFVB2i+9Yy
        SS7/GbA/M1zX405OmZP2l5hCYIJ83xrh5I/V
X-Google-Smtp-Source: ABdhPJxFPdt+Egf/+bN+An3ipOHNnO47OWI8DI4FFeyq5OD4hknChjLFGpHxRVWz1ai5EoO2ldeUqQ==
X-Received: by 2002:a5d:5712:: with SMTP id a18mr12958148wrv.367.1630931319458;
        Mon, 06 Sep 2021 05:28:39 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:9afb:57ba:5ea:2010? ([2001:861:44c0:66c0:9afb:57ba:5ea:2010])
        by smtp.gmail.com with ESMTPSA id n5sm7051594wmd.29.2021.09.06.05.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 05:28:39 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson-sm1: add spdifin spdifout nodes
To:     Art Nikpal <email2tema@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>,
        Gouwa Wang <gouwa@khadas.com>
References: <20210811050941.398360-1-art@khadas.com>
 <64a6a9e1-64de-4b31-9413-cdfd981862de@baylibre.com>
 <1jlf4ayrv1.fsf@starbuckisacylon.baylibre.com>
 <CAKaHn9JOtmYoJsmZed4hLYAbtdyyMkhaM1iVThs0=2SV6y5ojQ@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <5c9583a5-62bb-5a5f-5f1c-72479f8bfbf8@baylibre.com>
Date:   Mon, 6 Sep 2021 14:28:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAKaHn9JOtmYoJsmZed4hLYAbtdyyMkhaM1iVThs0=2SV6y5ojQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2021 13:56, Art Nikpal wrote:
>> It would be nice to indicate how it was tested ?
> 
> https://github.com/khadas/khadas-linux-kernel/blob/master/patches/linux-5.14-rc5.sound/0001-arm64-dts-meson-khadas-vim3-remake-simple-sound-for-.patch
> 
> i have test it
> 
> i2s  and spdif output from gpio headers - works well
> 
> On Mon, Sep 6, 2021 at 5:29 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>>
>> On Thu 02 Sep 2021 at 15:31, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>>> Hi,
>>>
>>> On 11/08/2021 07:09, Artem Lapkin wrote:
>>>> Add spdifin spdifout spdifout_b nodes for Amlogic SM1 SoCs.
>>>>
>>>> Signed-off-by: Artem Lapkin <art@khadas.com>
>>>> ---
>>>>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 40 ++++++++++++++++++++++
>>>>  1 file changed, 40 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>>>> index 3d8b1f4f2..1efdbb61e 100644
>>>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>>>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>>>> @@ -356,6 +356,33 @@ tdmin_lb: audio-controller@3c0 {
>>>>                      status = "disabled";
>>>>              };
>>>>
>>>> +            spdifin: audio-controller@400 {
>>>> +                    compatible = "amlogic,g12a-spdifin",
>>>> +                    "amlogic,axg-spdifin";
>>>> +                    reg = <0x0 0x400 0x0 0x30>;
>>>> +                    #sound-dai-cells = <0>;
>>>> +                    sound-name-prefix = "SPDIFIN";
>>>> +                    interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
>>>> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
>>>> +                    <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
>>>> +                    clock-names = "pclk", "refclk";
>>>> +                    resets = <&clkc_audio AUD_RESET_SPDIFIN>;
>>>> +                    status = "disabled";
>>>> +            };
>>>> +
>>>> +            spdifout: audio-controller@480 {
>>>> +                    compatible = "amlogic,g12a-spdifout",
>>>> +                    "amlogic,axg-spdifout";
>>>> +                    reg = <0x0 0x480 0x0 0x50>;
>>>> +                    #sound-dai-cells = <0>;
>>>> +                    sound-name-prefix = "SPDIFOUT";
>>>> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
>>>> +                    <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
>>>> +                    clock-names = "pclk", "mclk";
>>>> +                    resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
>>>> +                    status = "disabled";
>>>> +            };
>>>> +
>>>>              tdmout_a: audio-controller@500 {
>>>>                      compatible = "amlogic,sm1-tdmout";
>>>>                      reg = <0x0 0x500 0x0 0x40>;
>>>> @@ -401,6 +428,19 @@ tdmout_c: audio-controller@580 {
>>>>                      status = "disabled";
>>>>              };
>>>>
>>>> +            spdifout_b: audio-controller@680 {
>>>> +                    compatible = "amlogic,g12a-spdifout",
>>>> +                    "amlogic,axg-spdifout";
>>>> +                    reg = <0x0 0x680 0x0 0x50>;
>>>> +                    #sound-dai-cells = <0>;
>>>> +                    sound-name-prefix = "SPDIFOUT_B";
>>>> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
>>>> +                    <&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
>>>> +                    clock-names = "pclk", "mclk";
>>>> +                    resets = <&clkc_audio AUD_RESET_SPDIFOUT_B>;
>>>> +                    status = "disabled";
>>>> +            };
>>>> +
>>>>              toacodec: audio-controller@740 {
>>>>                      compatible = "amlogic,sm1-toacodec",
>>>>                                   "amlogic,g12a-toacodec";
>>>>
>>>
>>> Jerome could you quickly review this ?
>>>
>>
>> Just this, without the related card change is not usefull as it won't be
>> part of the card.
>>
>> It would be nice to indicate how it was tested ?
>>
>> AFAIK:
>> - spdifout b can only be routed to hdmi and dw-hdmi driver does not
>>   support that yet

It doesn't harm to have it described in DT, maybe one day the dw-hdmi driver will support SPDIF input.

Neil

>> - the VIM3 does not have connectors for the spdif (in or out). If it
>>   requires some extension card, it should be noted somewhere, at least
>>
>>
>>> Thanks,
>>> Neil
>>

