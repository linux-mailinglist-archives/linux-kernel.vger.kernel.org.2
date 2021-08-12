Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C523EAD7C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbhHLXKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:10:09 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:45799 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhHLXKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:10:08 -0400
Received: by mail-qk1-f170.google.com with SMTP id o123so3381880qkf.12;
        Thu, 12 Aug 2021 16:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/fde461zyBqFG4VxvCXC1y+Kn2D6FELzcDQs0SJciDQ=;
        b=OfFgn2h83Hx+JclR2YA697qeyq5ahp4iVCzY/buxJDjYPWjkE6AbXZFdcMOz0wdW2Y
         fReZHg1sNFvEngRf1G1x3B8uwUSQ+4K/+cI4eCifSQkxAtMppZsO1B1BIKJofMaUYeWE
         HfCLfG8aXv1yWWT+R01vf1G/wxqrrovSSLta8U9dmcVuj1aXwrm61doAOnvI1BNlsv/u
         XXtzKqu1LkKZesdT9IKO96GFivTkO/TrWn1tARBcfDQ8kfXOMPtlgKS5IKmAZdLQfDYx
         w0mcxVsUtSS7z8urr9Dx6r0t++b0Ci1oXvRmyrCLtbMtnHjgqSkINefV1M0YKAgaO0jF
         CQ9Q==
X-Gm-Message-State: AOAM5321RTBbOw4c0sQIONlZLY644GygquSJcp8oLcay91LmDZ2GCkkE
        bxXM3jPQVzK8ZpnWgQQpgLR0N65IWAo=
X-Google-Smtp-Source: ABdhPJz5NhzPyjpN6HiD4wikS0FNnO3/NvE1DMu8z1ucZLbe7wx6RLottmac+GxtaY/6wYHmIhwc1w==
X-Received: by 2002:a37:a956:: with SMTP id s83mr7105814qke.220.1628809781469;
        Thu, 12 Aug 2021 16:09:41 -0700 (PDT)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id k23sm2209649qkk.84.2021.08.12.16.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 16:09:40 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id m3so4228887qvu.0;
        Thu, 12 Aug 2021 16:09:40 -0700 (PDT)
X-Received: by 2002:ad4:4e04:: with SMTP id dl4mr6502780qvb.18.1628809780364;
 Thu, 12 Aug 2021 16:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210615131605.616-1-thunder.leizhen@huawei.com>
 <20210615131605.616-2-thunder.leizhen@huawei.com> <AS8PR04MB8946D0EB15D631346F4D13198FF69@AS8PR04MB8946.eurprd04.prod.outlook.com>
 <03d7c7be-2f19-9fdf-2a4e-f49a62bb82f6@huawei.com> <AS8PR04MB8946913A8B97C18240ADBAEA8FF79@AS8PR04MB8946.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8946913A8B97C18240ADBAEA8FF79@AS8PR04MB8946.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 12 Aug 2021 18:09:28 -0500
X-Gmail-Original-Message-ID: <CADRPPNQaM+-LfacBJLQPYjk3df_p0VuF9rx933T6bTQOcgYacw@mail.gmail.com>
Message-ID: <CADRPPNQaM+-LfacBJLQPYjk3df_p0VuF9rx933T6bTQOcgYacw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible string of
 LX2160A UART
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 1:28 AM Leo Li <leoyang.li@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Leizhen (ThunderTown) <thunder.leizhen@huawei.com>
> > Sent: Monday, August 9, 2021 8:28 PM
> > To: Leo Li <leoyang.li@nxp.com>; Shawn Guo <shawnguo@kernel.org>; Rob
> > Herring <robh+dt@kernel.org>; Mark Kettenis <mark.kettenis@xs4all.nl>;
> > devicetree <devicetree@vger.kernel.org>; linux-arm-kernel <linux-arm-
> > kernel@lists.infradead.org>; linux-kernel <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible string of
> > LX2160A UART
> >
> >
> >
> > On 2021/8/10 6:52, Leo Li wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Zhen Lei <thunder.leizhen@huawei.com>
> > >> Sent: Tuesday, June 15, 2021 8:16 AM
> > >> To: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>;
> > Rob
> > >> Herring <robh+dt@kernel.org>; Mark Kettenis
> > >> <mark.kettenis@xs4all.nl>; devicetree <devicetree@vger.kernel.org>;
> > >> linux-arm-kernel <linux-arm- kernel@lists.infradead.org>;
> > >> linux-kernel <linux-kernel@vger.kernel.org>
> > >> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> > >> Subject: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible
> > >> string of LX2160A UART
> > >>
> > >> Mark Kettenis told us that:
> > >> According to the NXP documentation, the LX2160A has a real PL011 UART.
> > >>
> > >> Therefore, rewrite it to the compatible string of pl011. The property
> > >> "current- speed" specific to "arm,sbsa-uart" is also deleted.
> > >
> > > Sorry that I missed the discussion on the v1.  But looks like this change
> > breaks the LX2160 boot.  The AMBA matching doesn't seem to work.  And
> > the console is not registered correctly.
> >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
> > ernel.org%2Flinux-arm-kernel%2Fcba3a29f-92b5-072a-9a27-
> > 60240f072dad%40huawei.com%2F&amp;data=04%7C01%7Cleoyang.li%40nx
> > p.com%7C9986b52f71724d7f6ae108d95b9e1d9b%7C686ea1d3bc2b4c6fa92cd
> > 99c5c301635%7C0%7C0%7C637641556923909225%7CUnknown%7CTWFpbGZ
> > sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> > n0%3D%7C1000&amp;sdata=wReesSfMj1hV2iPTN0%2F%2B%2Fb%2BKJH8xF
> > LLcDgOMfjx731I%3D&amp;reserved=0
> >
> > Maybe we should fall back to v1.
>
> I didn't look into the problem in detail.  Probably it is because of lacking the clock properties needed by the AMBA bus?
>

After reading through the history of sbsa-uart,  I think that I would
prefer us to fall back to v1 to be compatible with sbsa-uart rather
than changing it to be compatible with pl011.  Although the hardware
is actually compatible with the pl011, it would be better for us to
follow the newer SBSA standard to leave advanced configuration to
firmware and just expose the simple standard interface to OS.

Regards,
Leo

> >
> > >
> > > [    0.639055] OF: amba_device_add() failed (-2) for /soc/serial@21c0000
> > > [    0.645612] OF: amba_device_add() failed (-2) for /soc/serial@21d0000
> > >
> > >>
> > >> Suggested-by: Shawn Guo <shawnguo@kernel.org>
> > >> Suggested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
> > >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > >> ---
> > >>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 12 ++++--------
> > >>  1 file changed, 4 insertions(+), 8 deletions(-)
> > >>
> > >> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > >> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > >> index c4b1a59ba424..d2e6f7285674 100644
> > >> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > >> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > >> @@ -920,34 +920,30 @@ QORIQ_CLK_PLL_DIV(8)>,
> > >>            };
> > >>
> > >>            uart0: serial@21c0000 {
> > >> -                  compatible = "arm,sbsa-uart","arm,pl011";
> > >> +                  compatible = "arm,pl011", "arm,primecell";
> > >>                    reg = <0x0 0x21c0000 0x0 0x1000>;
> > >>                    interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> > >> -                  current-speed = <115200>;
> > >>                    status = "disabled";
> > >>            };
> > >>
> > >>            uart1: serial@21d0000 {
> > >> -                  compatible = "arm,sbsa-uart","arm,pl011";
> > >> +                  compatible = "arm,pl011", "arm,primecell";
> > >>                    reg = <0x0 0x21d0000 0x0 0x1000>;
> > >>                    interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> > >> -                  current-speed = <115200>;
> > >>                    status = "disabled";
> > >>            };
> > >>
> > >>            uart2: serial@21e0000 {
> > >> -                  compatible = "arm,sbsa-uart","arm,pl011";
> > >> +                  compatible = "arm,pl011", "arm,primecell";
> > >>                    reg = <0x0 0x21e0000 0x0 0x1000>;
> > >>                    interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> > >> -                  current-speed = <115200>;
> > >>                    status = "disabled";
> > >>            };
> > >>
> > >>            uart3: serial@21f0000 {
> > >> -                  compatible = "arm,sbsa-uart","arm,pl011";
> > >> +                  compatible = "arm,pl011", "arm,primecell";
> > >>                    reg = <0x0 0x21f0000 0x0 0x1000>;
> > >>                    interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> > >> -                  current-speed = <115200>;
> > >>                    status = "disabled";
> > >>            };
> > >>
> > >> --
> > >> 2.25.1
> > >>
> > >
> > > .
> > >
