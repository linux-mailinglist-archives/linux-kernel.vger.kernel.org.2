Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346AD3BA198
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhGBNvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbhGBNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:51:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057D2C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 06:48:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t15so9190157wry.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dmdV5C0TPaZh38jwc22npxunHrSD6YlmILpaclb/0ko=;
        b=MMaK4fWwJ0vbQk/VXI4ucI0gpZ5rMsazWB7JlYgn8qFz2g7U7vIaZoCdRMNNTmBQ+B
         QG/HsfLU+K0cKJNZaN16m3SRn+5WQEmPVx97e1I0ZYsGKxi0o1gjjXkDimK7/vdY6XZ4
         TxMKifvdwRulh4J8UjxgaWxj0irps6/o/rmbjojsBglcy5g9eGb8eQGp2J+yPuxCzGmK
         2X8bx//QFTfi+eb50djSKk54h7N6+7O+rc9LxS8PZxJNAc8R0eLi8Y22ZJ4QgYcUdTk0
         AkH9WyG5cA1ATdz5aAmf0/m5rnjQIx8DRZ05vQHPQeDZJvGExrcshvMhzdtym8nnumGk
         hxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dmdV5C0TPaZh38jwc22npxunHrSD6YlmILpaclb/0ko=;
        b=qazw4ryd7F6OAT6XucBNdJG9vIF6hzx4di7qn4lLc5kSE8NZ5Uu/ensV89TACw3V5h
         062s7Piyewb9hdVg6TNOEJhpWIXMsrJRNN/2e5yiid/S0VtJxfZXSNcCwo9y5evoK3yl
         8UAszIwW927p49QQevixUjL5rnnx6+OxJyuMazgFF8Lq1BESLoNj4K8Fw4VsX/QRWnYz
         TXe2RDpymwIzXArFEdaTZR5yUcoLRVaYB3ThEp6pQLqjv+q1lZ4lHlEuzhEdwLn/sFad
         B3k0H07M1Hrlc7rVQ4hJ4p7gZwAStKV1w6XJfc9/YClzc+qxdR/jaC1sMap+Ee4xU4Wg
         rUpQ==
X-Gm-Message-State: AOAM533QPu1Cjt5HLsF9KKf5zCBCXaMHNcZd1VnU9ELAiA53VcdR4qqW
        cx1gV6BzkNvrVG8QR6kAkGbUwg==
X-Google-Smtp-Source: ABdhPJwnfiPmpsT0TFwceB+yNPe62xHEvP1eccHb9f8GwnwPkFvep/IzIg4oQ9IT0EKqsY3+JcJqaA==
X-Received: by 2002:adf:ef50:: with SMTP id c16mr5998912wrp.137.1625233721485;
        Fri, 02 Jul 2021 06:48:41 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:b194:a11e:9f1:225b? ([2001:861:44c0:66c0:b194:a11e:9f1:225b])
        by smtp.gmail.com with ESMTPSA id s5sm3363652wrn.38.2021.07.02.06.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 06:48:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] media: rc: meson-irblaster: document device tree
 bindings
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc:     sean@mess.org, mchehab@kernel.org, robh+dt@kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        linux-media <linux-media@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, rockosov@gmail.com
References: <20210701215132.16317-1-viktor.prutyanov@phystech.edu>
 <20210701215132.16317-2-viktor.prutyanov@phystech.edu>
 <CAFBinCBZXRrPakwvRLsbNbuYY6fcYysMs0+SPUmAhKpcYxrq0g@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <cc677601-fb6b-970d-be8a-e68bea9727dd@baylibre.com>
Date:   Fri, 2 Jul 2021 15:48:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCBZXRrPakwvRLsbNbuYY6fcYysMs0+SPUmAhKpcYxrq0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/07/2021 15:30, Martin Blumenstingl wrote:
> Hi Viktor,
> 
> On Thu, Jul 1, 2021 at 11:51 PM Viktor Prutyanov
> <viktor.prutyanov@phystech.edu> wrote:
>>
>> This patch adds binding documentation for the IR transmitter
>> available in Amlogic Meson SoCs.
> This is an interesting piece of hardware where I've always wondered if
> there is any device out there which supports this functionality.It
> turns out that there is

You did beat me, I started a driver some time ago but failed to finish debugging it...
https://github.com/superna9999/linux/tree/amlogic/v5.2%2Fir-blaster

> 
> [...]
>> +description: |
>> +  Some Amlogic SoCs such as A311D and T950D4 have IR transmitter
>> +  (blaster) controller onboard. It is capable of sending IR signals
>> +  with arbitrary carrier frequency and duty cycle.
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,meson-irblaster
> if you feel like some registers or register values are specific to
> A311D or T950D4 then please also add a SoC-specific compatible string
> (for example: amlogic,meson-g12b-irblaster).
> An example can be seen in
> Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml

AFAIK there is 2 versions of the IP, the "old" one we can find on Meson6, 8/8b, GXBB, GXL & GXM (and maybe AXG ?),
and the one we find on the latest G12A, G12B & SM1.

The SEI510 and SEI610 boards we use for Yukawa android port do have the necessary HW for IR sending,
so I'll eventually be able to test.

So, as martin says you should add a "amlogic,g12a-ir-blaster" to be sure we support the older ir blaster version
correctly with the right bindings.

Neil

> 
> [...]
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    maxItems: 2
> from my understanding there are two clock inputs to the hardware
> dt-bindings should always describe the hardware, not what the driver
> may (or may not) use.
> based on that I think you should drop minItems (then minItems will
> have the same value as maxItems)
> 
> [...]
>> +  mod-clock:
>> +    oneOf:
>> +      - const: sysclk
>> +      - const: xtal
> Does this "mod-clock" depend on something external to the IR blaster hardware?
> If not this should be handled inside the driver only.
> 
> From how I understand the register description in the datasheet
> there's two clock inputs.
> XTAL is internally divided further down with fixed dividers.
> Then there's a configurable divider which is then used to generate the
> IR signal.
> If the sysclk (I assume that this is clk81 - or at least derived from
> it) is "too fast" then the driver should just ignore that clock while
> the dt-bindings should still describe it (see my comment above)
> 
> [...]
>> +    meson-irblaster@ff80014c {
> node names should be generic, see for example
> Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
> (spifc is the name Amlogic has given this IP, but since node names are
> supposed to be generic we use spi@...)
> 
> However, I am not sure if an IR blaster would be described as
> ir-blaster@... or simply ir@...
> 
>> +      compatible = "amlogic,meson-irblaster";
>> +      reg = <0xff80014c 0x10>;
>> +      interrupts = <0 198 IRQ_TYPE_EDGE_RISING>;
>> +      clocks = <&clkc CLKID_CLK81 &xtal>;
> [...]
>> +      clocks = <&clkc CLKID_CLK81 &xtal>;
> while this works I think the recommended format is:
>     clocks = <&clkc CLKID_CLK81>, <&xtal>
> 
> 
> Best regards,
> Martin
> 
