Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6474210CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbhJDN6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237574AbhJDN6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:58:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCF3C04E2FD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 06:51:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v127so13501040wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=qlWSZWlTlJBD8rbNOy3bbMpuI9Mzs9EIqR6yqDgX4mc=;
        b=fQ0YQ5yUl3Ok1UQERK8+w2pCRnX4ikWeeBfZ9oJks0APWtLsWEqP77u+wPQgvKhoUh
         1dfU0akWDjvO0FjNfxPIU/UJ6HhFkzlDJm6cjmPC76CENJR+aOm4Bbczz7tpu81hy5Sc
         juCIIEub768ZlwPtB/mvU3KVDL3q07gTg8TqvuHgfCdsr+Z2Bg5k0dpEhgX7wWODHeb4
         Urg1gePOZrOdzJtI+Ti+spF42bLgjpQHz8t4H4QTgYls/V3hKwmeohDkS7avUfCqLpBd
         x559N9vfoB5tnuehjJf2YZMBtmsfdNRq6RNIoWv/+W57i7dNxAzh3FduLCbQIpr/r7d0
         23ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=qlWSZWlTlJBD8rbNOy3bbMpuI9Mzs9EIqR6yqDgX4mc=;
        b=S5HYsA4p9P/lp7rFu3HQx0ALhuJcon+y8tyqbLBcaGzTFfKIbEqgsJTt6OFkKCjhUZ
         Oy9Ed0Yft55MZVK5l03TYYbgFAxEdCb1LmXK4cB934mVAHQTY0ZH4OXtVeV/atP61wWu
         7KKYpe5mdiS9HJJjJOeTY3QaReB08e98jle0rMc2hROllt1f8dEc3STmWj4mtSelo4eK
         90j4HWOC4JQrd7pSQ6gC7dd4xkQmokCd29+tQRxAeiEGLxsFmQ7qq6jrHAiY13lmZTMf
         TCUomWQABbozUI7FxDfKfQQxMNQ0T/HzEWip31KmjEFU4tseUfDPTUg7Vantc4C0l+Nq
         w8rg==
X-Gm-Message-State: AOAM5317rDqoBGSdPt4B3BHJurPhHPP0FHXgnDAjSY+VJq3Q8PDq5jbc
        fkRMZG1gqg00OfNTAG9+gdKfiQ==
X-Google-Smtp-Source: ABdhPJy4k/7iYi9Zk16aDxfEKAGLW65qVB3N2CVchTPBCB0n1u9yN9PTIsv7M+9EDDNBk+RNFRqsuw==
X-Received: by 2002:a7b:c350:: with SMTP id l16mr18334787wmj.151.1633355506876;
        Mon, 04 Oct 2021 06:51:46 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 5sm2529261wmj.21.2021.10.04.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:51:46 -0700 (PDT)
References: <20210811050941.398360-1-art@khadas.com>
 <64a6a9e1-64de-4b31-9413-cdfd981862de@baylibre.com>
 <1jlf4ayrv1.fsf@starbuckisacylon.baylibre.com>
 <CAKaHn9JOtmYoJsmZed4hLYAbtdyyMkhaM1iVThs0=2SV6y5ojQ@mail.gmail.com>
User-agent: mu4e 1.6.6; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Art Nikpal <email2tema@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>,
        Gouwa Wang <gouwa@khadas.com>
Subject: Re: [PATCH] arm64: dts: meson-sm1: add spdifin spdifout nodes
Date:   Mon, 04 Oct 2021 15:46:27 +0200
In-reply-to: <CAKaHn9JOtmYoJsmZed4hLYAbtdyyMkhaM1iVThs0=2SV6y5ojQ@mail.gmail.com>
Message-ID: <1jtuhwvqxa.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 06 Sep 2021 at 19:56, Art Nikpal <email2tema@gmail.com> wrote:

>> It would be nice to indicate how it was tested ?
>
> https://github.com/khadas/khadas-linux-kernel/blob/master/patches/linux-5.14-rc5.sound/0001-arm64-dts-meson-khadas-vim3-remake-simple-sound-for-.patch
>
> i have test it
>
> i2s  and spdif output from gpio headers - works well

You have tested spdifout_a then.

Nothing says spdifin (which was only tested on the axg series so far) or
spdifout_b would actually work if enabled at a later point.

I would prefer if things could at least be tested once before being
added DT. 

>
> On Mon, Sep 6, 2021 at 5:29 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>>
>> On Thu 02 Sep 2021 at 15:31, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> > Hi,
>> >
>> > On 11/08/2021 07:09, Artem Lapkin wrote:
>> >> Add spdifin spdifout spdifout_b nodes for Amlogic SM1 SoCs.
>> >>
>> >> Signed-off-by: Artem Lapkin <art@khadas.com>
>> >> ---
>> >>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 40 ++++++++++++++++++++++
>> >>  1 file changed, 40 insertions(+)
>> >>
>> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> >> index 3d8b1f4f2..1efdbb61e 100644
>> >> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> >> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> >> @@ -356,6 +356,33 @@ tdmin_lb: audio-controller@3c0 {
>> >>                      status = "disabled";
>> >>              };
>> >>
>> >> +            spdifin: audio-controller@400 {
>> >> +                    compatible = "amlogic,g12a-spdifin",
>> >> +                    "amlogic,axg-spdifin";
>> >> +                    reg = <0x0 0x400 0x0 0x30>;
>> >> +                    #sound-dai-cells = <0>;
>> >> +                    sound-name-prefix = "SPDIFIN";
>> >> +                    interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
>> >> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
>> >> +                    <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
>> >> +                    clock-names = "pclk", "refclk";
>> >> +                    resets = <&clkc_audio AUD_RESET_SPDIFIN>;
>> >> +                    status = "disabled";
>> >> +            };
>> >> +
>> >> +            spdifout: audio-controller@480 {
>> >> +                    compatible = "amlogic,g12a-spdifout",
>> >> +                    "amlogic,axg-spdifout";
>> >> +                    reg = <0x0 0x480 0x0 0x50>;
>> >> +                    #sound-dai-cells = <0>;
>> >> +                    sound-name-prefix = "SPDIFOUT";
>> >> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
>> >> +                    <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
>> >> +                    clock-names = "pclk", "mclk";
>> >> +                    resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
>> >> +                    status = "disabled";
>> >> +            };
>> >> +
>> >>              tdmout_a: audio-controller@500 {
>> >>                      compatible = "amlogic,sm1-tdmout";
>> >>                      reg = <0x0 0x500 0x0 0x40>;
>> >> @@ -401,6 +428,19 @@ tdmout_c: audio-controller@580 {
>> >>                      status = "disabled";
>> >>              };
>> >>
>> >> +            spdifout_b: audio-controller@680 {
>> >> +                    compatible = "amlogic,g12a-spdifout",
>> >> +                    "amlogic,axg-spdifout";
>> >> +                    reg = <0x0 0x680 0x0 0x50>;
>> >> +                    #sound-dai-cells = <0>;
>> >> +                    sound-name-prefix = "SPDIFOUT_B";
>> >> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
>> >> +                    <&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
>> >> +                    clock-names = "pclk", "mclk";
>> >> +                    resets = <&clkc_audio AUD_RESET_SPDIFOUT_B>;
>> >> +                    status = "disabled";
>> >> +            };
>> >> +
>> >>              toacodec: audio-controller@740 {
>> >>                      compatible = "amlogic,sm1-toacodec",
>> >>                                   "amlogic,g12a-toacodec";
>> >>
>> >
>> > Jerome could you quickly review this ?
>> >
>>
>> Just this, without the related card change is not usefull as it won't be
>> part of the card.
>>
>> It would be nice to indicate how it was tested ?
>>
>> AFAIK:
>> - spdifout b can only be routed to hdmi and dw-hdmi driver does not
>>   support that yet
>> - the VIM3 does not have connectors for the spdif (in or out). If it
>>   requires some extension card, it should be noted somewhere, at least
>>
>>
>> > Thanks,
>> > Neil
>>

