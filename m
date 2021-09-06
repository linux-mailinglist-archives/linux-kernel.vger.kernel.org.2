Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D500B401ACF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 13:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbhIFL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 07:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhIFL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 07:57:23 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC7AC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 04:56:19 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id m11so8382488ioo.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 04:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnTG/NHMxnQfdG3J7CYZRoCa4rWNoUVxORNySN5cPHg=;
        b=kajCZuZ9otgw/PXzZZoJUq1SQzaEvFMcDBYC9kR6zBidnBHGK+1zkqrvkdmxtcsWnV
         Fi7cJVndjRf0HOjumKrYWVB5iDGzhgPoZD+2CM+DF3Uhv71hlTeGja21avehFqIP25bI
         p0Shp7lvRlIKJR9Rpk4pRJYjPUiogeTPDz+hmM/zo3gOH1E8TQ9xIIyKpHof1t1HV3++
         ntoFIvgjFfrpfM2vH9ksRctCJ7sg9PZgYINkB2fxyx5XGeHsPQXGQ4Uh3hrFXyV3Liqx
         5DpnwT9JBl3gXq4MT9F2SFJQA7qt0IUe2RBlH1cHvnJmvCzQaMlTAvE9KqJu27cg9zEe
         00Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnTG/NHMxnQfdG3J7CYZRoCa4rWNoUVxORNySN5cPHg=;
        b=FSiWNblmKf/6DjJpHeMYQsg10cSsS51IqoNEy2+tmcwl+UCG96g86aOSqPxMyz2drs
         +taAOgB/3FXPFF0/LGPwUP100mrEaJca7SY9Xfb64XXVkBpIRi0PWMUma4oc8+Libe7+
         y0sRSi4ila3p01NGQrrFktThb6PD2ec9ZbHRW7g1pp7yDdxDdAPbxdBS+roiD7jTmQRC
         VPg953yBksm4kiRZ1ZzKs0/LgXasRxjtQ/cCi8YAOVEvDc4oG9sY4j3kCwGGgkTYxCW6
         iU6e6aJCycqb/r6n4NOUauVv35kfpc/CzC0xTJfWebdb1AYc5uRDDQagBGzZp8NFz/7y
         HRpw==
X-Gm-Message-State: AOAM531jPE4U7U+pJcvN+GCB2wqLSW+1rRn2aaSqvdZkDKUtijRRgJC0
        vhMz3agcoAkiDpnauoTVnObeT3wlSlwYuR/OQcHAI08/5kOgkw==
X-Google-Smtp-Source: ABdhPJzEvgt/nep1+Eg+yCw7tQlo8vWKbb8j2o1M1iuaI/4ooig2MVYxjBiJAT1qDHjhSiRKN/5/p+xsMJvo3xX6knA=
X-Received: by 2002:a05:6602:2211:: with SMTP id n17mr9406209ion.142.1630929378562;
 Mon, 06 Sep 2021 04:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210811050941.398360-1-art@khadas.com> <64a6a9e1-64de-4b31-9413-cdfd981862de@baylibre.com>
 <1jlf4ayrv1.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jlf4ayrv1.fsf@starbuckisacylon.baylibre.com>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Mon, 6 Sep 2021 19:56:06 +0800
Message-ID: <CAKaHn9JOtmYoJsmZed4hLYAbtdyyMkhaM1iVThs0=2SV6y5ojQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson-sm1: add spdifin spdifout nodes
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>,
        Gouwa Wang <gouwa@khadas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It would be nice to indicate how it was tested ?

https://github.com/khadas/khadas-linux-kernel/blob/master/patches/linux-5.14-rc5.sound/0001-arm64-dts-meson-khadas-vim3-remake-simple-sound-for-.patch

i have test it

i2s  and spdif output from gpio headers - works well

On Mon, Sep 6, 2021 at 5:29 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Thu 02 Sep 2021 at 15:31, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> > Hi,
> >
> > On 11/08/2021 07:09, Artem Lapkin wrote:
> >> Add spdifin spdifout spdifout_b nodes for Amlogic SM1 SoCs.
> >>
> >> Signed-off-by: Artem Lapkin <art@khadas.com>
> >> ---
> >>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 40 ++++++++++++++++++++++
> >>  1 file changed, 40 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> >> index 3d8b1f4f2..1efdbb61e 100644
> >> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> >> @@ -356,6 +356,33 @@ tdmin_lb: audio-controller@3c0 {
> >>                      status = "disabled";
> >>              };
> >>
> >> +            spdifin: audio-controller@400 {
> >> +                    compatible = "amlogic,g12a-spdifin",
> >> +                    "amlogic,axg-spdifin";
> >> +                    reg = <0x0 0x400 0x0 0x30>;
> >> +                    #sound-dai-cells = <0>;
> >> +                    sound-name-prefix = "SPDIFIN";
> >> +                    interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
> >> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
> >> +                    <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
> >> +                    clock-names = "pclk", "refclk";
> >> +                    resets = <&clkc_audio AUD_RESET_SPDIFIN>;
> >> +                    status = "disabled";
> >> +            };
> >> +
> >> +            spdifout: audio-controller@480 {
> >> +                    compatible = "amlogic,g12a-spdifout",
> >> +                    "amlogic,axg-spdifout";
> >> +                    reg = <0x0 0x480 0x0 0x50>;
> >> +                    #sound-dai-cells = <0>;
> >> +                    sound-name-prefix = "SPDIFOUT";
> >> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
> >> +                    <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
> >> +                    clock-names = "pclk", "mclk";
> >> +                    resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
> >> +                    status = "disabled";
> >> +            };
> >> +
> >>              tdmout_a: audio-controller@500 {
> >>                      compatible = "amlogic,sm1-tdmout";
> >>                      reg = <0x0 0x500 0x0 0x40>;
> >> @@ -401,6 +428,19 @@ tdmout_c: audio-controller@580 {
> >>                      status = "disabled";
> >>              };
> >>
> >> +            spdifout_b: audio-controller@680 {
> >> +                    compatible = "amlogic,g12a-spdifout",
> >> +                    "amlogic,axg-spdifout";
> >> +                    reg = <0x0 0x680 0x0 0x50>;
> >> +                    #sound-dai-cells = <0>;
> >> +                    sound-name-prefix = "SPDIFOUT_B";
> >> +                    clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
> >> +                    <&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
> >> +                    clock-names = "pclk", "mclk";
> >> +                    resets = <&clkc_audio AUD_RESET_SPDIFOUT_B>;
> >> +                    status = "disabled";
> >> +            };
> >> +
> >>              toacodec: audio-controller@740 {
> >>                      compatible = "amlogic,sm1-toacodec",
> >>                                   "amlogic,g12a-toacodec";
> >>
> >
> > Jerome could you quickly review this ?
> >
>
> Just this, without the related card change is not usefull as it won't be
> part of the card.
>
> It would be nice to indicate how it was tested ?
>
> AFAIK:
> - spdifout b can only be routed to hdmi and dw-hdmi driver does not
>   support that yet
> - the VIM3 does not have connectors for the spdif (in or out). If it
>   requires some extension card, it should be noted somewhere, at least
>
>
> > Thanks,
> > Neil
>
