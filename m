Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760C23CED04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351458AbhGSRlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356826AbhGSQl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:41:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A71CC005F26;
        Mon, 19 Jul 2021 09:53:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g8so25578871lfh.8;
        Mon, 19 Jul 2021 10:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8dlreiD3y0FAWWt5AwOtsV8l36/rdSofslQ0of0y/lQ=;
        b=XRbyBWGsdZCS2L6gOZl9l+VDDZ9yWUpInAe9LM08ApS9nbNSGT5QR/fPF6+wTQEuGH
         y/LiUCk4t3wgjsBolsvgQ21MZ9TfDHumwa32TgCZgDIIhpqjXFnM8V3j1c+Q/NzrGUH6
         +eYRhrqQg4FTU24EDoyiRcmZyMaWD9mR/Mp3Hwo8u5cTv/t8JN4xD7rWDk2dGq7eZZel
         P3euVjlZjRdO/NF3qQes8zrIU33LXM+3X9+1ic8q/ZaxFD8Iefy7m6g+0H93kbPnlgeG
         nb2BmiPsO8+3XwHWNgsj4o3tr1Yddx6girWNA78kCrms0A7f6sOK615SDf8uYILH7J7k
         uSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dlreiD3y0FAWWt5AwOtsV8l36/rdSofslQ0of0y/lQ=;
        b=k9mdZhK22xqKJL2TZSlAatCTBeJxz/x938bB/Jy9GJRfzlQomKOGP9KiuJWN5X12tQ
         C1hMNAoxME5aLju288GRucVphkwY6UMuQpPYxE0/4V0D2vzt2LjcxsrapQIUeWu6xdlp
         Yn3aoCQqJIkB7IbhpVU89YdcCVll9L/hGE5NbDpltmwbJEY1Nc9BYTJeV3/L5525vaiw
         LOvm09yy78d1h/Vi73zHfO40SKi7EZuwtY8Ey/EjCrcP5yIBvylORl+49D1i+4+n3Ebi
         J2Rt5iz3I7A9ZyecZl/7EDXk4IJPvcq1W/5BHjV3pmYbOknOZ/DKNkP+0djG4KGFUVnI
         /JOA==
X-Gm-Message-State: AOAM532QvYqxRT2ZrpBa8pNYvyRCeXjjGBE9UI2FtAEq+2V1LkXM9PIQ
        cRoW/gXe8kLhjwL3IFKld/g28N5IVJOjsXOp1TQ=
X-Google-Smtp-Source: ABdhPJzpgx9uN5/6xXR2djonVwm0YGIUSndku6RB0m4t7rOTmele/+5bGntahfqx4YeJb3+/ly6SRQ+MLmeNW7FFiMM=
X-Received: by 2002:a05:6512:3e0c:: with SMTP id i12mr18458374lfv.122.1626714793061;
 Mon, 19 Jul 2021 10:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <1607403341-57214-1-git-send-email-yash.shah@sifive.com>
 <1607403341-57214-8-git-send-email-yash.shah@sifive.com> <CAMuHMdW74DsiqyLCYyWSosZmwVEqPiAWNV2i6m4LWzz0868fbg@mail.gmail.com>
In-Reply-To: <CAMuHMdW74DsiqyLCYyWSosZmwVEqPiAWNV2i6m4LWzz0868fbg@mail.gmail.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Mon, 19 Jul 2021 20:12:37 +0300
Message-ID: <CAEn-LTqq8+B4HRV_1aHSrrRRwd9Xvpd3mBg0fUixtHb_4-4u6w@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] riscv: dts: add initial support for the SiFive
 FU740-C000 SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yash Shah <yash.shah@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 3:51 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Yash,
>
> On Tue, Dec 8, 2020 at 5:57 AM Yash Shah <yash.shah@sifive.com> wrote:
> > Add initial support for the SiFive FU540-C000 SoC. FU740-C000 is built
> > around the SiFIve U7 Core Complex and a TileLink interconnect.
> >
> > This file is expected to grow as more device drivers are added to the
> > kernel.
> >
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
>
> Thanks for your patch, which became commit 57985788158a5a6b ("riscv:
> dts: add initial support for the SiFive FU740-C000 SoC").
>
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> > @@ -0,0 +1,293 @@
>
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               cpu0: cpu@0 {
> > +                       compatible = "sifive,bullet0", "riscv";
>
> I'm wondering why you're using
>
>     compatible = "sifive,bullet0", "riscv";
>
> According to your own commit 75e6d7248efccc2b ("dt-bindings: riscv:
> Update DT binding docs to support SiFive FU740 SoC"), it should be
>
>     compatible = "sifive,u74-mc", "riscv";
>
> instead.

I plan to send out new DT for the Rev3A and Rev3B (the final board
customers can buy) boards.
This is already fixed in meta-sifive.

In general bullet here is micro architecture, but it's less
descriptive in /proc/cpuinfo.

>
> Likewise, the older arch/riscv/boot/dts/sifive/fu540-c000.dtsi is using
>
>     compatible = "sifive,e51", "sifive,rocket0", "riscv";
>
> and
>
>     compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
>
> but according to the DT bindings the rocket part should not be present.
>
> Is there any specific reason for that?
> Should the DT bindings and/or the DTS files be fixed?
>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
