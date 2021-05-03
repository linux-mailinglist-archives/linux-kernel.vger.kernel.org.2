Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD322371EE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhECRxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhECRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:53:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14299C06174A;
        Mon,  3 May 2021 10:52:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y26so7317719eds.4;
        Mon, 03 May 2021 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VlqRIueTk0F5zfM99p/8Ijk8GV72FYyMIcRNpH9/8mM=;
        b=eooZ7Dwqywhke7IsxQry6Qnd3r8Tl+sm5eALs9IGsiN1IxnQMTtnOoewuAZiiELP0A
         Oq1do3ed0/7ljCCNrAa9mhIhhb8AZe+XNd87um07rYhnpkzZPC6XDLVceejTtmMIoPbg
         10RLe8tfnaeruO4rT7qt8do6SmiomXLuSDJjndPoOIpP5eOR3N4HTNiUUCGdNLQZfNaM
         dTLGitz3PDkvou7ykOSbNP4UWLoAYURkQUizwamQHUonxL3blbly2TmB1gEZgk5B6q79
         o0BkQtjxm4Lm4zzEQRv0Ye2Fp3tYu6OAfGs21slmgpOfE19npY9BWZzQrQYmIDQm7Qr8
         8DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlqRIueTk0F5zfM99p/8Ijk8GV72FYyMIcRNpH9/8mM=;
        b=pEAKTDP2Sfyu67OWlukNbteOV1BT+LzICmIYNz2paL4hAjCdCMXKn2grEVemmm/eZM
         /vZ+VO9+p6fwMNc5ja7fkpLqRefYGc7QQXAuR2pon61Ex2sCYqs62I+TIpLCb0xcoTj6
         njXIPK873jJ2cE1wOpSNuP5bBXyrYl8AKLPLfNN6Kctj65BwGgdfYNmwY4O2oENlG4KR
         QcQXiyme2+lnxXMrM0oCB7E6V78UXAKWR33GZua+rCbNIEadzKNPzDWudSe0bcb7DUpx
         yB8QcckjNRE5UsrTBdx0E+udK45X7I8oOHoI/3NLXKrSjnSOyt33dc8ir+uycwv5bQlR
         Gncg==
X-Gm-Message-State: AOAM530ptyFq2ia3A6LQjqfd4XvxvKV148YyRt5iGlIcXhlzK2n6+kz+
        4BDE5CSwioNbguX+9qM7/x09ogpi5HVXZbu57ZI=
X-Google-Smtp-Source: ABdhPJyrEQbpkN6DYy/v2aTjZOD4g2MB0cEeRUPbrKzX7JTf9OUhJYCBJs+HCk0MHU6eo1Zly1UAUzUOCR5e8eChZdQ=
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr21251334edx.52.1620064344776;
 Mon, 03 May 2021 10:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210503145503.1477-1-linux.amoon@gmail.com> <20210503145503.1477-4-linux.amoon@gmail.com>
 <CAFBinCCxMvomKt9E0jT_XXpyL1_-qXH4=zVDMNdbDCnZCsnT=A@mail.gmail.com>
 <CANAwSgTdFHwtKd-sgQq0Jp8WP55fZG3wsn7feCGo257yqiFkpw@mail.gmail.com>
 <CAFBinCDUc7VG7T9c8snP4ujMMViS0GRdztP6QGJvF9LNESHHCw@mail.gmail.com> <CANAwSgSrQnBs06+DG6x+GMvyjvu-hPFX0J5MQ0yKPBvNaNu98w@mail.gmail.com>
In-Reply-To: <CANAwSgSrQnBs06+DG6x+GMvyjvu-hPFX0J5MQ0yKPBvNaNu98w@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 3 May 2021 19:52:13 +0200
Message-ID: <CAFBinCDMTmZ5ifii8rW=6qSdNngx3Gz1tZPd7aubDkmqNYD_og@mail.gmail.com>
Subject: Re: [PATCHv1 3/9] soc: amlogic: meson-ee-pwrc: Add hdmi power domain
 Meson g12a SoCs
To:     Anand Moon <linux.amoon@gmail.com>
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

Hi Anand,

On Mon, May 3, 2021 at 6:37 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > > whenever I try something new it fails. Please ignore this series.
> > if the VPU and HDMI power domains were separate (from hardware
> > perspective, not from driver perspective) then your change is a good
> > step forward.
> > in that case VPU_HHI_MEMPD would need to be removed from wherever it's
> > currently used -> that means we need to also decide if we want to
> > break compatibility with older (before this series) .dtbs
> >
> >
>
> As per the datasheet S922X Datasheet, HDMI and VPU are different
> reg controller and they are independent of each other.
[...]
> Note: HDMI and AUDIO and Ethernet are also independent of each other.
let me say it this way: I've seen cases where the information from the
datasheet is not correct

Also to me it doesn't explicitly state that the bits are independent
of each other (at the same time it also doesn't state that they belong
together).

In the same datasheet you also find the HHI_HDMI_PLL_CNTL0 register
hdmi_dpll_M, hdmi_dpll_N and hdmi_dpll_od are listed in there.
The PLL output depends on hdmi_dpll_M and hdmi_dpll_N while
hdmi_dpll_od is taking the output of the two and dividing it.
This relation is nowhere described in the datasheet either so you
"just have to know it".

Unfortunately I don't know of any good way to check the relationship
of the power domain registers other than someone from Amlogic
explaining to us how it works internally.

[...]
> Below is the output on Odroid N2.
>
> [alarm@archl-on2 ~]$ sudo cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> domain                          status          children
>             performance
>     /device                                             runtime status
> ----------------------------------------------------------------------------------------------
> HDMI                            on
>             0
>     /devices/platform/soc/ff600000.bus/ff600000.hdmi-tx  unsupported
>              0
> AUDIO                           on
>             0
>     /devices/platform/sound                             unsupported
>             0
> ETH                             on
>             0
>     /devices/platform/soc/ff3f0000.ethernet             active
>             0
> VPU                             on
>             0
>     /devices/platform/soc/ff900000.vpu                  unsupported
>             0
This describes what Linux sees (based on how you configured the device-tree).
The output confirms what you are expecting to see (I think), but based
on that we can't tell what's right or wrong in terms of the actual
hardware.

To make another example: I could edit meson-g12b-odroid-n2.dtsi and
change the vin-supply of "VDDAO_3V3" to &usb_pwr_en
Then /sys/kernel/debug/regulator/regulator_summary would show that
VDDAO_3V3 is taking the voltage from USB_PWR_EN as input.
But from a hardware (schematics) perspective this is not correct.
Since the schematics describe the relation (input, output) between the
regulators we know how they are connected to each other.
If this relation was not described in the schematics then we'd be in
the same situation as with the power domains.


Best regards,
Martin
