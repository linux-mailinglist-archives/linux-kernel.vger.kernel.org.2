Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C26436397F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbhDSCt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhDSCtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:49:24 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F65C061760
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 19:48:55 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id y12so25114673qtx.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 19:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1+InEJa8trFjlh0fgWtqwArdK90oYVaffuyevhKeECE=;
        b=fWQlWCrm2bA74uGpCK5bxlz0zGKImRXjZefHJGzxYfm6iA1SJzU1peK8vEaiaIUwlB
         qBwVKhCV+lMR4orioOEpcNAkzTajN6UVHySohvgahA54gzhLN8UPvZh69rnckoXSZ3cu
         c6qdoDGSmbvA6dJtfILS2PMvlB8mP+AIbR5JjsG0zemSkt+ynOaPeYykGVQ8MU+VYpw+
         Jy7twsozJBUFvxNc6H1uJ9EsJoStoYabocjrq90Mxb9YCgWql9bRPPmQ11CSLFJavNLJ
         H6XaUqJsvU5ze1nTPQLCrxmqO9+XgnWuVId9KjYL5uBbUDmHeGr2QCQTbybesqZwhpoJ
         jsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1+InEJa8trFjlh0fgWtqwArdK90oYVaffuyevhKeECE=;
        b=VNdcO3Z7wpPocan/aoHYvlZxydMpREGo8qdCEzGppbvpdEJPm+3yyWhxkuMM1vwHx9
         mGxuCevQZF+6ulVsgE3fVSZi3SutoIiQba3bhRakXJrT+B/IH5aj9JmJbPMfnsMyu28S
         Pc9/SSNIamHMSwAFCvXpWGXjsSDLFlKyTjjB91VXCJioHzUtipNlwppPBzy2mpSVITzZ
         S/CZb06tNpsMB99RC+2BnExnHd6lJf7kQcEBmoE5oZOyDM5xt75hHWdbZnSQZcw9WCeh
         I/KvYqQ8CADIZcjQdm+5smSrlKLa+Q3rg0cEnpnlx9h2w0lU7JvhOUEMusgTeTVtLvMi
         +okg==
X-Gm-Message-State: AOAM532ry1DoKqKZpbjF7LdLTAV8QIYKkMpw7/xp2W7Yi62y9pxSFPNw
        irOH0cXlVpYoMzZgyT10yZpA+A/40nQLsdfTecj83g==
X-Google-Smtp-Source: ABdhPJzGEibilDMHxGsNSHnrJv/U9tmYHNcWLOOGaqjAruZQp45J4ZXBCcB5S9cpxTanedNJgBmA6wy87f9KIAK0kJI=
X-Received: by 2002:a05:622a:14c:: with SMTP id v12mr9670014qtw.46.1618800534655;
 Sun, 18 Apr 2021 19:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <17994571deaf703e65ece7e44c742f82c988cf39.1615954046.git.greentime.hu@sifive.com>
 <mhng-30f397a9-b7af-4247-baa0-d8e1d30c6b97@palmerdabbelt-glaptop> <CAHCEehL+3ZxKv_nxSR6s0vWEFtNHSYOX_dHrpfGq1hM8xwhHRQ@mail.gmail.com>
In-Reply-To: <CAHCEehL+3ZxKv_nxSR6s0vWEFtNHSYOX_dHrpfGq1hM8xwhHRQ@mail.gmail.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Mon, 19 Apr 2021 10:48:46 +0800
Message-ID: <CAHCEehLG-FmQiBJpNExO8wa_8LYWmw-1R7KfyEEMyz=Y3srcUw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] riscv: dts: Add PCIe support for the SiFive
 FU740-C000 SoC
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, hes@sifive.com,
        Erik Danie <erik.danie@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>, robh+dt@kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greentime Hu <greentime.hu@sifive.com> =E6=96=BC 2021=E5=B9=B44=E6=9C=8819=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:43=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=8831=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=888:24=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Wed, 17 Mar 2021 23:08:13 PDT (-0700), greentime.hu@sifive.com wrote=
:
> > > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > > ---
> > >  arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 34 ++++++++++++++++++++=
++
> > >  1 file changed, 34 insertions(+)
> > >
> > > diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/=
boot/dts/sifive/fu740-c000.dtsi
> > > index d1bb22b11920..d0839739b425 100644
> > > --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> > > +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> > > @@ -158,6 +158,7 @@ prci: clock-controller@10000000 {
> > >                       reg =3D <0x0 0x10000000 0x0 0x1000>;
> > >                       clocks =3D <&hfclk>, <&rtcclk>;
> > >                       #clock-cells =3D <1>;
> > > +                     #reset-cells =3D <1>;
> > >               };
> > >               uart0: serial@10010000 {
> > >                       compatible =3D "sifive,fu740-c000-uart", "sifiv=
e,uart0";
> > > @@ -288,5 +289,38 @@ gpio: gpio@10060000 {
> > >                       clocks =3D <&prci PRCI_CLK_PCLK>;
> > >                       status =3D "disabled";
> > >               };
> > > +             pcie@e00000000 {
> > > +                     #address-cells =3D <3>;
> > > +                     #interrupt-cells =3D <1>;
> > > +                     #num-lanes =3D <8>;
> > > +                     #size-cells =3D <2>;
> > > +                     compatible =3D "sifive,fu740-pcie";
> > > +                     reg =3D <0xe 0x00000000 0x1 0x0
> > > +                            0xd 0xf0000000 0x0 0x10000000
> > > +                            0x0 0x100d0000 0x0 0x1000>;
> > > +                     reg-names =3D "dbi", "config", "mgmt";
> > > +                     device_type =3D "pci";
> > > +                     dma-coherent;
> > > +                     bus-range =3D <0x0 0xff>;
> > > +                     ranges =3D <0x81000000  0x0 0x60080000  0x0 0x6=
0080000 0x0 0x10000        /* I/O */
> > > +                               0x82000000  0x0 0x60090000  0x0 0x600=
90000 0x0 0xff70000      /* mem */
> > > +                               0x82000000  0x0 0x70000000  0x0 0x700=
00000 0x0 0x1000000      /* mem */
> > > +                               0xc3000000 0x20 0x00000000 0x20 0x000=
00000 0x20 0x00000000>;  /* mem prefetchable */
> > > +                     num-lanes =3D <0x8>;
> > > +                     interrupts =3D <56 57 58 59 60 61 62 63 64>;
> > > +                     interrupt-names =3D "msi", "inta", "intb", "int=
c", "intd";
> > > +                     interrupt-parent =3D <&plic0>;
> > > +                     interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> > > +                     interrupt-map =3D <0x0 0x0 0x0 0x1 &plic0 57>,
> > > +                                     <0x0 0x0 0x0 0x2 &plic0 58>,
> > > +                                     <0x0 0x0 0x0 0x3 &plic0 59>,
> > > +                                     <0x0 0x0 0x0 0x4 &plic0 60>;
> > > +                     clock-names =3D "pcie_aux";
> > > +                     clocks =3D <&prci PRCI_CLK_PCIE_AUX>;
> > > +                     pwren-gpios =3D <&gpio 5 0>;
> > > +                     perstn-gpios =3D <&gpio 8 0>;
> > > +                     resets =3D <&prci 4>;
> > > +                     status =3D "okay";
> > > +             };
> > >       };
> > >  };
> >
> > Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> >
> > I'm happy to take these all through the RISC-V tree if that helps, but
> > as usual I'd like reviews or acks from the subsystem maintainers.  It
> > looks like there are some issues so I'm going to drop this from my
> > inbox.
>
> Hi Palmer,
>
> Since the subsystem maintainer has pick the first 5 patches to his
> branch, would you please help to pick the 6th patch of version 6?

Sorry there is no version 6, I mean version 5. :p

> Thank you. :)
>
> https://www.spinics.net/lists/linux-clk/msg57213.html
> https://patchwork.kernel.org/project/linux-riscv/patch/20210406092634.504=
65-7-greentime.hu@sifive.com/
