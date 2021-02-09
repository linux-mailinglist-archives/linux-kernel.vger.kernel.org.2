Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7C43158B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 22:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhBIVev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 16:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhBITIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:08:02 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D0AC061222
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 11:07:09 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id p193so5519191yba.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnLZ5tZYOr2/DrCvzy7WC9kdKIuRuK5/a3YzC0k6AGk=;
        b=e75g3AG15IROUt3EtTUpNR5CPAOw+UST8Ng0iHoQXWrMeTmZfJAjTMHzhLoHrjmtcq
         I8BVMXR3Gi4FnjuRiyh/G10QEgk1uRYNF9FMcqcHGXScpFVwjUDRikws9kloUJnFgHvA
         TIiMRJ60jHP+cCzAxbVKos3Kn91VZG4wccCdsKem7tmgj6BgXSdB3+dIpEfwlALKnU8Y
         No+RsrBHRpOc0RQBxLLfBzBjC8ViT7upgVcgYh4L07HjAwPepXzcDXcLEiQ9s2/9GfkH
         iS5gnMnEiJ+Grll8pGcV+WaJ//4RtAzAZRye1kLeUiDZeaUOUs/g4VH2nNSxaglH00lq
         fIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnLZ5tZYOr2/DrCvzy7WC9kdKIuRuK5/a3YzC0k6AGk=;
        b=Exbyhe7BGzY4DZ1X2Is/y8AhB74FRNi7pe/NUfajLdvt7EFJQCIgGCbJNPFOLlBqOP
         L0eCNzHt5t7mIikdW/HJbT4DZ8eBnwUJI8LC0h2dun2iZ9jwJs60KMNxnDtnW3KvJ/7y
         D8XDGYoh708ysMZ4+u5l9BP5HGTixIOo+2222GqQUbp/XOdSmZvfcTvgNmVTfPpmEvZJ
         ei1S4cyQB4rdy3UuU89BWYk28/jAAB5U+StGgqE6/rXD8QL9tzqicTakDZxQeylFJUkq
         8IacMokbd1OfdaIwmjVylpqMpCzG9CkjJaXV4uViH+MbqkZVKAavaP6FkcMvAF1ZWH5M
         EZhA==
X-Gm-Message-State: AOAM532dzkJpcPt2QPrjtBRGNGhlieVu5WjQUjqYbaEZRsWs4PDUd8G3
        y9cgbn/SotTygLOGT0Dgf54qmggdH0+MGpjdMZsgWA==
X-Google-Smtp-Source: ABdhPJy09lMC4Rc3TvmrPWDWTZTeCWOgbQgwXnFij6Gq2Xz1JO9YTH1cgJeLhFqmSa+YCJ5CQBpct1dz/TzsUBPGx/w=
X-Received: by 2002:a25:3345:: with SMTP id z66mr35525707ybz.466.1612897628934;
 Tue, 09 Feb 2021 11:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20210128104446.164269-1-tudor.ambarus@microchip.com>
 <CAGETcx9CodHDeqSYM1zQXRi-p_rFUJQgwMtnuWeKvCt_B3dCOw@mail.gmail.com>
 <161285731192.418021.10555916396092570051@swboyd.mtv.corp.google.com>
 <CAGETcx9C+sH-GKz61GfCxd9qk=E-AMueHSwPgp5Z_5QcOzXJiQ@mail.gmail.com> <d15b1045-2dac-a1ba-a078-2f37786c1d9d@microchip.com>
In-Reply-To: <d15b1045-2dac-a1ba-a078-2f37786c1d9d@microchip.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 9 Feb 2021 11:06:32 -0800
Message-ID: <CAGETcx8+RFPM51hixbpmroHB17iMpxeyUrFe6hOLaoQNNp-zKg@mail.gmail.com>
Subject: Re: [PATCH] clk: at91: sama5d2: Mark device OF_POPULATED after setup
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas.Ferre@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        mirq-linux@rere.qmqm.pl,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 7:21 AM <Tudor.Ambarus@microchip.com> wrote:
>
> Hi, Saravana,
>
> On 2/9/21 11:11 AM, Saravana Kannan wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On Mon, Feb 8, 2021 at 11:55 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >>
> >> Quoting Saravana Kannan (2021-01-28 09:01:41)
> >>> On Thu, Jan 28, 2021 at 2:45 AM Tudor Ambarus
> >>> <tudor.ambarus@microchip.com> wrote:
> >>>>
> >>>> The sama5d2 requires the clock provider initialized before timers.
> >>>> We can't use a platform driver for the sama5d2-pmc driver, as the
> >>>> platform_bus_init() is called later on, after time_init().
> >>>>
> >>>> As fw_devlink considers only devices, it does not know that the
> >>>> pmc is ready. Hence probing of devices that depend on it fail:
> >>>> probe deferral - supplier f0014000.pmc not ready
> >>>>
> >>>> Fix this by setting the OF_POPULATED flag for the sama5d2_pmc
> >>>> device node after successful setup. This will make
> >>>> of_link_to_phandle() ignore the sama5d2_pmc device node as a
> >>>> dependency, and consumer devices will be probed again.
> >>>>
> >>>> Fixes: e590474768f1cc04 ("driver core: Set fw_devlink=on by default")
> >>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>>> ---
> >>>> I'll be out of office, will check the rest of the at91 SoCs
> >>>> at the begining of next week.
> >>>>
> >>>>  drivers/clk/at91/sama5d2.c | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> >>>> index 9a5cbc7cd55a..5eea2b4a63dd 100644
> >>>> --- a/drivers/clk/at91/sama5d2.c
> >>>> +++ b/drivers/clk/at91/sama5d2.c
> >>>> @@ -367,6 +367,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
> >>>>
> >>>>         of_clk_add_hw_provider(np, of_clk_hw_pmc_get, sama5d2_pmc);
> >>>>
> >>>> +       of_node_set_flag(np, OF_POPULATED);
> >>>> +
> >>>>         return;
> >>>
> >>> Hi Tudor,
> >>>
> >>> Thanks for looking into this.
> >>>
> >>> I already accounted for early clocks like this when I designed
> >>> fw_devlink. Each driver shouldn't need to set OF_POPULATED.
> >>> drivers/clk/clk.c already does this for you.
> >>>
> >>> I think the problem is that your driver is using
> >>> CLK_OF_DECLARE_DRIVER() instead of CLK_OF_DECLARE(). The comments for
> >>> CLK_OF_DECLARE_DRIVER() says:
> >>> /*
> >>>  * Use this macro when you have a driver that requires two initialization
> >>>  * routines, one at of_clk_init(), and one at platform device probe
> >>>  */
> >>>
> >>> In your case, you are explicitly NOT having a driver bind to this
> >>> clock later. So you shouldn't be using CLK_OF_DECLARE() instead.
> >>>
> >>
> >> I see
> >>
> >> drivers/power/reset/at91-sama5d2_shdwc.c:       { .compatible = "atmel,sama5d2-pmc" },
> >>
> >> so isn't that the driver that wants to bind to the same device node
> >> again? First at of_clk_init() time here and then second for the reset
> >> driver?
> >
> > You are right. I assumed that when Tudor was setting OF_POPULATED,
>
> No, there's a single driver that binds to that compatible.
>
> > they didn't want to create a struct device and they knew it was right
> > for their platform.
> >
> > However...
> > $ git grep "atmel,sama5d2-pmc"
> > arch/arm/boot/dts/sama5d2.dtsi:                         compatible =
> > "atmel,sama5d2-pmc", "syscon";
> > arch/arm/mach-at91/pm.c:        { .compatible = "atmel,sama5d2-pmc",
> > .data = &pmc_infos[1] },
> > drivers/clk/at91/pmc.c: { .compatible = "atmel,sama5d2-pmc" },
> > drivers/clk/at91/sama5d2.c:CLK_OF_DECLARE_DRIVER(sama5d2_pmc,
> > "atmel,sama5d2-pmc", sama5d2_pmc_setup);
> > drivers/power/reset/at91-sama5d2_shdwc.c:       { .compatible =
> > "atmel,sama5d2-pmc" },
> >
> > Geez! How many drivers are there for this one device. Clearly not all
> > of them are going to bind. But I'm not going to dig into this. You can
>
> From this entire list only the drivers/clk/at91/sama5d2.c driver binds to the
> "atmel,sama5d2-pmc" compatible, the rest are just using the compatible to
> map the PMC memory.
>
> > reject this patch. I expect this series [1] to take care of the issue
> > Tudor was trying to fix.
> >
> > Tudor,
> >
> > Want to give this series [1] a shot?
>
> The series at [1] doesn't apply clean neither on next-20210209, nor on
> driver-core-next. On top of which sha1 should I apply them?

It's on top of driver-core-next:
4731210c09f5 gpiolib: Bind gpio_device to a driver to enable
fw_devlink=on by default

> Anyway, I think the patch at [2] is still needed, regardless of the outcome
> of [1].

Right, [2] is still a good clean up based on your comment above.

-Saravana

> >
> > [1] - https://lore.kernel.org/lkml/20210205222644.2357303-1-saravanak@google.com/
>
> [2] https://lore.kernel.org/lkml/20210203154332.470587-1-tudor.ambarus@microchip.com/
>
> Cheers,
> ta
>
