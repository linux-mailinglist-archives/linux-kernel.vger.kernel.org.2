Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2493CB6C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 13:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhGPLhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 07:37:11 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:39847 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhGPLhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 07:37:10 -0400
Received: by mail-vs1-f46.google.com with SMTP id j2so4771854vsi.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 04:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMUPV4XWaCYtbaAI3uwGWUmIBkcAyAv0q9hV4D7V57I=;
        b=ZuFVGkX8Dq3u3WffPI2MEl7EW9pVMEUyVcD/Qd8hlX5C15/vaIWQnqmdKLI/qiYCes
         556JntrxIBGD3lj7xt2h3KbEufORcO4Ty4v4mK9sO76qzMRBqm1Hk7ILGuD/qwYmv6UM
         ycJLhmG/dbni93aG+yFgmG6rpH3C9AFJdwM9126f7DsjUPbW+Qa2IvUP5uCGSTIMjlR8
         pSuyu2SAw0a6uKgdBHIo5G2p97qS+nCCdj+tghE5QhzoRkqg2Des4o6HjOCG2ogkx/yI
         yOjUahe2AfBi6kNSru90CPkUxLgmgb2CaIsF1hqPiGlCUlvRBbo7prQQlm2gnH1GBIuL
         RW0g==
X-Gm-Message-State: AOAM530BVit8jU58Nfpe99p0jRuYpxl42gR58P7XHu75i6bL2lvGi/UK
        D8b87oPywmWLe73rxbmq+JVuDoZqMbwMOeKEs10=
X-Google-Smtp-Source: ABdhPJx+MWSgxjV8lpV2hTSfRKj7wmmWXQLwwdJkxn/F2f8hIHC5ehtlTyOGUAEmGXTFndot8GBsgIuGDCaXRI//30Q=
X-Received: by 2002:a05:6102:2828:: with SMTP id ba8mr11677390vsb.18.1626435253971;
 Fri, 16 Jul 2021 04:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210702014319.1265766-1-bmeng.cn@gmail.com> <20210702014319.1265766-2-bmeng.cn@gmail.com>
 <CAMuHMdWpJ194jEnXiUhs5dfC-33rGUm7pE9aMHUTYoMCUdFxZA@mail.gmail.com> <CAEUhbmXrSJ2dkXYvoZXTZ+3gV3h9OBx3u0hOitwLvMDKa2A4DA@mail.gmail.com>
In-Reply-To: <CAEUhbmXrSJ2dkXYvoZXTZ+3gV3h9OBx3u0hOitwLvMDKa2A4DA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 16 Jul 2021 13:34:02 +0200
Message-ID: <CAMuHMdVfRSGQcBQEFVbUZjoRBKHxPJnbXkddZvF8vcSDQ1v5jg@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: dts: microchip: Add ethernet0 to the aliases node
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On Fri, Jul 16, 2021 at 12:14 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> On Fri, Jul 16, 2021 at 5:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Jul 2, 2021 at 3:44 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> > > +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> > > @@ -9,6 +9,10 @@ / {
> > >         model = "Microchip MPFS Icicle Kit";
> > >         compatible = "microchip,mpfs-icicle-kit";
> > >
> > > +       aliases {
> > > +               ethernet0 = &emac1;
> > > +       };
> > > +
> > >         chosen {
> > >         };
> >
> > This should be added to the board DTS (microchip-mpfs-icicle-kit.dts)
> > instead.
>
> I was wondering the same thing before doing this, but when I checked
> all other DTS in arch/riscv/boot I found the aliases node is put in
> the SoC dtsi file instead of the board on so I think that's the
> convention.

The numbering of the aliases is supposed to match the labels on the
board, hence it is board-specific, not SoC-specific.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
