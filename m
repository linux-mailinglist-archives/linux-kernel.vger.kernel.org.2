Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC25372711
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 10:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhEDIUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 04:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhEDIUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 04:20:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A592C061574;
        Tue,  4 May 2021 01:19:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t4so11874172ejo.0;
        Tue, 04 May 2021 01:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jFYxxE/Ai61oQCqbk8ib70Q6yklWPzwYT//bt7eipoQ=;
        b=PQsB/zeXbufsBRfumImBtGFOi4EbfyiEQq5+qZDzRL6EhpH8bcfUuuTC0UeF36vX+f
         Lovgh0fM6kGsl8gMaWO0cRPkRrvGnitQJJrx01HlFX9FDP0OlnNJ8ZZ8j42bjLIZPqsS
         htXhTkc7MLmWrMUCXRf6FON1PW+DVg6Q3iPiIlAuRVF0sZnWGw/kbhY3bhRHs5gTq73E
         XaR7TMWoNWupzuVxoTzgeGV9MBsbCGlm+MOfbv/Jqb+ssbhyV0HPsu4cQVk5CcVT1gMQ
         OLp4yYpjzBHPHWdNILPMAyRk4OtLPLoTgfKr7MV5ibuReAovyqQOmcet3yMeNweCbFrN
         4mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFYxxE/Ai61oQCqbk8ib70Q6yklWPzwYT//bt7eipoQ=;
        b=IwoRiiU+JFNNbzs74ZqIc6e/pAcFq/dxILesr3/rYJCxipjLL+q/w2calguitm3Bj8
         k4NEqQ2hYC3y+oUifkNe+VIMOnqU6kQnpGhQ5g6ucSvdKSAMMZakz/3ExFsscx4VfpLU
         Ftfn+v8g+lOovPdiqDfAi0gCjlq8iocPEgr7My4V8lA5R4aZN0GHgX0FLqCb9i2lEMij
         jKfrGzoaAdrpCm9nOxB4TWIFWUOU89l0hhnnJfLTu5JV1nN9N9GMrDmfYkJGd7jqq3jK
         Ur+mHtCoXn7SEAA5Ok+wYDo/KVDACloXAuDjm96+zRy71uRx8jWQ+U7Ru/AReYaDvXn2
         NC8A==
X-Gm-Message-State: AOAM5309VvnxX6jHs1IAlTqIWC1sSiWPHFA5Ns9R0la+aBvb2Ci2jYKo
        JGmcV8fovUtOaTWIegrZWYL2KSMApSccWaWCLZSAh+FQ3g421A==
X-Google-Smtp-Source: ABdhPJxrfkJv9gNQ+qTu/TrExlQlnYNHOczojGBxK9lx7BvpZiX2BxSk3Wu3w6SGImnypoxi5TrlwEVehxkbRq9PUrE=
X-Received: by 2002:a17:906:f1d4:: with SMTP id gx20mr20558733ejb.108.1620116359971;
 Tue, 04 May 2021 01:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210503145503.1477-1-linux.amoon@gmail.com> <20210503145503.1477-4-linux.amoon@gmail.com>
 <CAFBinCCxMvomKt9E0jT_XXpyL1_-qXH4=zVDMNdbDCnZCsnT=A@mail.gmail.com>
 <CANAwSgTdFHwtKd-sgQq0Jp8WP55fZG3wsn7feCGo257yqiFkpw@mail.gmail.com>
 <CAFBinCDUc7VG7T9c8snP4ujMMViS0GRdztP6QGJvF9LNESHHCw@mail.gmail.com>
 <CANAwSgSrQnBs06+DG6x+GMvyjvu-hPFX0J5MQ0yKPBvNaNu98w@mail.gmail.com> <CAFBinCDMTmZ5ifii8rW=6qSdNngx3Gz1tZPd7aubDkmqNYD_og@mail.gmail.com>
In-Reply-To: <CAFBinCDMTmZ5ifii8rW=6qSdNngx3Gz1tZPd7aubDkmqNYD_og@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 4 May 2021 13:49:09 +0530
Message-ID: <CANAwSgTTvPRJW8G1g4gzaSvud2YVf_bPP3QZdYMtL-CuSvosAA@mail.gmail.com>
Subject: Re: [PATCHv1 3/9] soc: amlogic: meson-ee-pwrc: Add hdmi power domain
 Meson g12a SoCs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin

On Mon, 3 May 2021 at 23:22, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Mon, May 3, 2021 at 6:37 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > > > whenever I try something new it fails. Please ignore this series.
> > > if the VPU and HDMI power domains were separate (from hardware
> > > perspective, not from driver perspective) then your change is a good
> > > step forward.
> > > in that case VPU_HHI_MEMPD would need to be removed from wherever it's
> > > currently used -> that means we need to also decide if we want to
> > > break compatibility with older (before this series) .dtbs
> > >
> > >
> >
> > As per the datasheet S922X Datasheet, HDMI and VPU are different
> > reg controller and they are independent of each other.
> [...]
> > Note: HDMI and AUDIO and Ethernet are also independent of each other.
> let me say it this way: I've seen cases where the information from the
> datasheet is not correct
>
> Also to me it doesn't explicitly state that the bits are independent
> of each other (at the same time it also doesn't state that they belong
> together).
>
> In the same datasheet you also find the HHI_HDMI_PLL_CNTL0 register
> hdmi_dpll_M, hdmi_dpll_N and hdmi_dpll_od are listed in there.
> The PLL output depends on hdmi_dpll_M and hdmi_dpll_N while
> hdmi_dpll_od is taking the output of the two and dividing it.
> This relation is nowhere described in the datasheet either so you
> "just have to know it".
>
> Unfortunately I don't know of any good way to check the relationship
> of the power domain registers other than someone from Amlogic
> explaining to us how it works internally.
>

I should have sought more details on this feature before posting something.
Thanks for the detailed explanation of this feature,

So in order for this feature to work the final state should be *active*
for each power domain.

> [...]
> > Below is the output on Odroid N2.
> >
> > [alarm@archl-on2 ~]$ sudo cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> > domain                          status          children
> >             performance
> >     /device                                             runtime status
> > ----------------------------------------------------------------------------------------------
> > HDMI                            on
> >             0
> >     /devices/platform/soc/ff600000.bus/ff600000.hdmi-tx  unsupported
> >              0
> > AUDIO                           on
> >             0
> >     /devices/platform/sound                             unsupported
> >             0
> > ETH                             on
> >             0
> >     /devices/platform/soc/ff3f0000.ethernet             active
> >             0
> > VPU                             on
> >             0
> >     /devices/platform/soc/ff900000.vpu                  unsupported
> >             0
> This describes what Linux sees (based on how you configured the device-tree).
> The output confirms what you are expecting to see (I think), but based
> on that we can't tell what's right or wrong in terms of the actual
> hardware.
>
> To make another example: I could edit meson-g12b-odroid-n2.dtsi and
> change the vin-supply of "VDDAO_3V3" to &usb_pwr_en
> Then /sys/kernel/debug/regulator/regulator_summary would show that
> VDDAO_3V3 is taking the voltage from USB_PWR_EN as input.
> But from a hardware (schematics) perspective this is not correct.
> Since the schematics describe the relation (input, output) between the
> regulators we know how they are connected to each other.
> If this relation was not described in the schematics then we'd be in
> the same situation as with the power do
>

On Amlogic SBC, I think VDDAO_3V3 and VDDIO_AO1V8 share the power with
SD card and USB.
so can we add these as optional regulators to enable/disable within
the usb driver if needed?

I am facing some issues to fix the power on Odroid C1+ and C2 board as well.

> Best regards,
> Martin

Thanks
-Anand
