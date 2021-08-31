Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C99A3FCEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbhHaUtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhHaUtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:49:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60A9C061575;
        Tue, 31 Aug 2021 13:48:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eb14so466323edb.8;
        Tue, 31 Aug 2021 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PukLxj8PF44hPfPZSax4F6FSnHNWQbfJmpSj2w22I78=;
        b=Xiuk9zA30NMWF8XhrbeTJPEl62/se/94IUtFgYD5W4nLHJ48vY5U7IJjWmtKVC3w1t
         o0AznnrBYn7L2lyG+Cqhqcrk6jhGtnHIQZB2YroQsrpO3GQMPOzAj/yna7wxPnJdPEPy
         qlnlFTNeTdfhHQutlVrf4xVLfCPiHbpUl39ebItWilCFor0DBvFTL7RqQqZNiSEEwDhn
         PCR1hOTGR9P6Zr/SkzzZRwnm/tJwF9GCdjQO9jDgrHNzIBF94Damn5s5Sa/Ve2Phc1YG
         DvM5FBHDhBxeUmguDyzpuTjy3TRFCn5Qdc+YrgKJjXLxxj+xNYEGcxtkB3UIzD78SuDm
         XZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PukLxj8PF44hPfPZSax4F6FSnHNWQbfJmpSj2w22I78=;
        b=YCuIXg2QoGDc+CrakKTeIqZBXqqHVnYb1eP5G7ZRDL17+moueo5UfuO4Zi4G0iWWJI
         aP1IgGO5r2PsvuDj5eKTlWWEKSeF5RMlUzxNpnHTHpHeWtUd7Ek6gBOkYUjDgZDCe2Ng
         ggMhZZGR9+XJBcXS66HP5EYHeIp/ddhcqDW0u8xtRoCkVlsc85mKcgobJuG1BB5B7tG6
         ZkcnT5SM+3IrvC8pMIsc0uWBRojQES6pRD52NLyPJ+4FBzErPX6vIbMijmtF6E+hPf7r
         /bwZHMHfBRGVb/eiUf+OvEHaz29F4XSaevq3Rc4mW6226KkwwRcj886m6IZtPEw7XIvV
         I7yw==
X-Gm-Message-State: AOAM531ArngtiIUG6nerx4Rz9CD2EvGF+ZYXM/GkWYjA12GAyJKldtu4
        JhhPw1NRCrSKAGYyEiidndwR+8BD9zvlzvoW4kc=
X-Google-Smtp-Source: ABdhPJyNzcwfdq3eKJsOgi3wlcy3jJWKnEhkHouSu9RoNQ1aKGfQSX/1suN1mGAqKGoQHXilkSjWxYdx/ZEM2Z+dWlI=
X-Received: by 2002:a50:e699:: with SMTP id z25mr31279466edm.130.1630442887231;
 Tue, 31 Aug 2021 13:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210817041548.1276-1-linux.amoon@gmail.com> <20210817041548.1276-2-linux.amoon@gmail.com>
 <c7f6213b-5ddc-881c-1aea-9cc7b03e6a4f@baylibre.com> <CAFBinCBeNMET2tvH0h6HF3dR+xBb59hifQyaoXigUs3UGkS+KQ@mail.gmail.com>
 <2b07b3de-cee5-c570-8fde-6a4c684122d6@baylibre.com>
In-Reply-To: <2b07b3de-cee5-c570-8fde-6a4c684122d6@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 1 Sep 2021 02:17:54 +0530
Message-ID: <CANAwSgRNp8UtU+Yy4smwZ5POTWTU+xN1mrf_cH7Pu9yX5HU=VA@mail.gmail.com>
Subject: Re: [PATCHv3 1/6] ARM: dts: meson8b: odroidc1: Add usb phy power node
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil / Martin,

Thanks for your review comments.

On Tue, 31 Aug 2021 at 20:20, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 30/08/2021 21:37, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > On Mon, Aug 30, 2021 at 9:45 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> Hi,
> >>
> >> On 17/08/2021 06:15, Anand Moon wrote:
> >>> Add missing usb phy power node for usb node fix below warning.
> >>> P5V0 regulator supply input voltage range to USB host controller.
> >>> As described in the C1+ schematics, GPIO GPIOAO_5 is used to
> >>> enable input power to USB ports, set it to Active Low.
> >>>
> >>> [    1.260772] dwc2 c90c0000.usb: Looking up vbus-supply from device tree
> >>> [    1.260784] dwc2 c90c0000.usb: Looking up vbus-supply property in
> >>>               mode /soc/usb@c90c0000 failed
> >>
> >> First of all, DT is not here to fix boot message.
> > Anand mentioned elsewhere that this is a debug/info message
> >
> >> Finally, I looked at the Odroid-C1 schematics and the GPIOAO.BIT5 is an input
> >> to the S805, and the PWREN signal is controlled by the USB Hub so this regulator
> >> should not be added at all.
> > I think there's a misunderstanding because there's two PWREN signals
> > with different meanings.
> > The PWREN signal for the USB host ports is hard-wired and not
> > connected to the SoC at all.
> > The PWREN signal for the Micro-USB port (which Anand is adding here)
> > is controlled by GPIOAO_5. odroid-c1+_rev0.4_20150615.pdf [0] shows it
> > as an input to "USB_OTG" on page 1. "USB_OTG" consists of a power
> > switch and the connector itself as shown on page 28.
> >
> > Personally I think that the change from Anand itself is good.
> > If you feel otherwise then please speak up.
>
> Ok thanks for the clarification, then the change is ok, but not the commit message.
>
> >> Add missing usb phy power node for usb node fix below warning.
>
> is not a good reason for a DT change. A proper reason should be added.
>
> And the commit message doesn't specify the change is for the Micro-USB port,
> this should be clarified.
>
> Neil
>
> > As I pointed out three smaller changes I am hoping that Anand will
> > re-send the updated patch anyways. At that point he can also add the
> > changes from your feedback.
> >
Ok I will try to address your feedback in the next version.

After enabling CONFIG_REGULATOR_DEBUG, with this patch applied
I still not getting the USB regulator to enable.
Do you see different output at your end?

On Odroid C1+
[    5.737571] reg-fixed-voltage regulator-usb-pwr-en: GPIO lookup for
consumer (null)
[    5.737630] reg-fixed-voltage regulator-usb-pwr-en: using device
tree for GPIO lookup
[    5.737711] of_get_named_gpiod_flags: can't parse 'gpios' property
of node '/regulator-usb-pwr-en[0]'
[    5.737906] of_get_named_gpiod_flags: parsed 'gpio' property of
node '/regulator-usb-pwr-en[0]' - status (0)
[    5.738209] gpio_stub_drv gpiochip0: Persistence not supported for GPIO 5
[    5.738490] USB_OTG_PWR: 5000 mV, disabled
[    5.740313] reg-fixed-voltage regulator-usb-pwr-en: Looking up
vin-supply from device tree
[    5.740394] USB_OTG_PWR: supplied by P5V0
[    5.741235] reg-fixed-voltage regulator-usb-pwr-en: USB_OTG_PWR
supplying 5000000uV

Odroid N2.
[    3.047813] reg-fixed-voltage regulator-hub_5v: HUB_5V supplying 5000000uV
[    3.049282] reg-fixed-voltage regulator-usb_pwr_en: GPIO lookup for
consumer (null)
[    3.049305] reg-fixed-voltage regulator-usb_pwr_en: using device
tree for GPIO lookup
[    3.049370] of_get_named_gpiod_flags: can't parse 'gpios' property
of node '/regulator-usb_pwr_en[0]'
[    3.049500] of_get_named_gpiod_flags: parsed 'gpio' property of
node '/regulator-usb_pwr_en[0]' - status (0)
[    3.049622] gpio_stub_drv gpiochip0: Persistence not supported for GPIO 22
[    3.049759] USB_PWR_EN: 5000 mV, disabled
[    3.051257] reg-fixed-voltage regulator-usb_pwr_en: Looking up
vin-supply from device tree
[    3.051320] USB_PWR_EN: supplied by 5V

Thanks
-Anand



> >
> > Best regards,
> > Martin
> >
> >
> > [0] https://dn.odroid.com/S805/Schematics/odroid-c1+_rev0.4_20150615.pdf
> >
>
