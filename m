Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF1355316
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbhDFMFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhDFMFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:05:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64FFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 05:05:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o6so4301307wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Zq1H+3FDfTaqKwXlT1gl6y8xv4DH7ZmvL1jkdV+ZIFA=;
        b=UNqbHUT9aqmO/0xJgvfKU5Uyo+8g+tsb3lGnA1Hy7s5ndUImRaJseP4umBwkEGrl6D
         Skr7JQ6J7EmqkdFCasX7lr492piHKB8YppVgePbbgwYwhTQ1vl8kRfb6Hkb2UF90VD/3
         2uumo4ehIW+PG9PAzX6kts9GPWTjNNBA81SCgm90hTKKwZxub1Lq9Ma6D67CTLWDs4QT
         IlsSSJN0sXc0yLL97Zm/RtvnW6ztnqw3bWKKGDB9HIb/XkcvmGBK7lqlgTOa/MMZ5H49
         sIyRJMV0rOPaSmbrw9CaDbqelNgcI+eC2xdl4cCxWKjdyquShiloYLvGhS2efAWNDRDf
         Pl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Zq1H+3FDfTaqKwXlT1gl6y8xv4DH7ZmvL1jkdV+ZIFA=;
        b=owXHuTL3kJ/3T6NDllOErOFCxcbsnuE+r+EBqX7Rp/MOj48ZvT6nkEcazqPGOJoR2+
         4L1nOvLTqe3V9QwoMs8TwvaldrztyBmXk0bVjAYdc3EOGtb0eeHCDZ85TZV420e3fm6U
         MGrYPXY+axePi9mnNdbOgol6MtE1jGW9oXF39mVU5O8iA6OKaLI4MpJEAZuYytIQh1c9
         N4biHUGG647DBNj30+fg8FoxuB+pF2fCRLTa9RV/l27yDG0W7xRg5D34YcD6RVDjcZNK
         9G0iPczZqD/5v+TPij0SeNsHRxLDybV996onratoG5cQJBziWjMps524yh6q/7ebEgZP
         t33w==
X-Gm-Message-State: AOAM530udDM/gjxr9eK4+/JbytaXruuiTkPO9Ai8UJWWORTB1naWe99U
        VD3ps3ilVy0QMnzd/L16S48=
X-Google-Smtp-Source: ABdhPJykKoG3XcB1LfsgR5fv5fy/w8P6/RSshU0xetPetaBj8h7U5Au5F/PEpQNMsyH5zz3uu7CLJg==
X-Received: by 2002:a1c:e341:: with SMTP id a62mr3927720wmh.152.1617710721671;
        Tue, 06 Apr 2021 05:05:21 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id g1sm10238082wru.61.2021.04.06.05.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:05:21 -0700 (PDT)
Date:   Tue, 6 Apr 2021 14:05:19 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: gemini: sl3516: Mainlining of NS 2502
Message-ID: <YGxOf8pKN8Ip/kCl@Red>
References: <YGtZeofmBv7hXK+a@Red>
 <CACRpkdZ_barDrLvD2UBKo+GA-F+g72uMQx8CfRK2YLRodpeyUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZ_barDrLvD2UBKo+GA-F+g72uMQx8CfRK2YLRodpeyUA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Apr 06, 2021 at 10:15:51AM +0200, Linus Walleij a écrit :
> On Mon, Apr 5, 2021 at 8:39 PM Corentin Labbe <clabbe.montjoie@gmail.com> wrote:
> 
> > I own an Edimax NS 2502, which is a NAS based on StormLinix 3516.
> > I successfully upgraded it with a recent Linux.
> 
> Pretty cool!
> 
> >         mdio0: ethernet-phy {
> >                 compatible = "virtual,mdio-gpio";
> >                 gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
> >                         <&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >                 phy0: ethernet-phy@1 {
> >                         reg = <1>;
> >                         device_type = "ethernet-phy";
> >                 };
> >         };
> 
> This looks like the most typical way to attach an MDIO phy.
> 
> I always try to identify the exact component used on the board. Do you have
>  a high res board photo?
> 

Hello

You could find photos at http://kernel.montjoie.ovh/gemini/
There are also photos of another SL3516 SoC based device (a SSI 1328 NAS), but I fail to setup a serial on it, so I keep it for later. 

> Realtek RTL82111 is the most common configuration.
> 
> Compare to the D-Linux DNS-313 DTS:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> 
> Try just copying the whole pinctrl-gmii section!
> 
> 
> >                 syscon: syscon@40000000 {
> >                         pinctrl {
> >                                 /*
> >                                  * gpio0agrp cover line 0-4
> >                                  * gpio0bgrp cover line 5
> >                                  */
> >                                 gpio0_default_pins: pinctrl-gpio0 {
> >                                         mux {
> >                                                 function = "gpio0";
> >                                                 groups = "gpio0agrp",
> >                                                 "gpio0bgrp";
> >                                         };
> >                                 };
> 
> Change groups to
> 
> groups = "gpio0agrp", "gpio0bgrp", "gpio0hgrp";
> 
> So you mux in group h which is where the GPIO 21, 22 go out
> to the MDIO on 3516 IIUC. The right mux out is pretty important,
> if you have vendor source code, please share so I can check how
> they set it up.
> 

No change, probably due to all pinctrl-gemini 40000000.syscon:pinctrl: could not map pin config for "R8 GMAC0 RXDV"
Please see http://kernel.montjoie.ovh/gemini/bootlog6.txt , I have added some pr_info in gmac.
I have put in the directory, the final dtb which I use.

The vendor source could be found at https://www.edimax.com/edimax/mw/cufiles/files/download/OpenSourceCode/transfer/Wireless/NAS/NAS-GPL-source.zip

> > BUT neither ethernet nor USB works.
> 
> For USB try this patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/commit/?h=gemini-usb&id=cbaf6cdf770b90de5f10bfa5112c679f1dffe948
> 

One of the USB port is now working.

> Pls report progress! I hope we can mainline this device.
> 

I hope too.
Note that I have also started to work on the gemini crypto driver.

Thanks for your help
