Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88C23E4454
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhHILAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:00:37 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:40712 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbhHILAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:00:25 -0400
Received: by mail-ua1-f43.google.com with SMTP id y14so1780564uai.7;
        Mon, 09 Aug 2021 04:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCa+8aMH9lvrldDtJTsQzoAwywDdjdFTQK8ubSieS/Y=;
        b=gVUat8b6QOGWiN3CVrn4ajVbO+BPJ+dQoX0eWprAuRw//Aq2tOvKTZ7rCZgWbnH3u8
         KxAZDTsx4Wa4TYxmqnNwvOrPhLE5yNcKnlmqFueSKfuyDVwAEfZVfOCQE23IyR4lf+vP
         p9osX3zu4+qru1p4GFu5V9EGdvXq3braIWDrdtt9g2qVgDSgtlmQg1xr3gEKY2J9z0oW
         EHLVv24MRNGzfTAtRJlPoQfONWC3kn9QhRkf4TrnXDLFKifx7i5T5pyq9KK1ZqU0E9MX
         HFnHWZN3dpB9XdZoqeqVkJG9zzovlhJt5Z4XQNJa2OGGv8VjjXCeJPEyrlvJNsxf9yaM
         W1tg==
X-Gm-Message-State: AOAM530Llf5WjHdBkuGcaVUL+bLe6h+hwXiiudOjkR/pnoAxvYmXi3Gm
        bFfueTAFNokmPvFGZCZ6KDxOR1sqG50AveX32BQ=
X-Google-Smtp-Source: ABdhPJyzDIPE3tsvO4qcGGsTg9uBsU8k/CFcUQfTTC+SWZI+D9cqB89hcO9ltBZOMwDA8wciAXmJoysCLpv3MeXn4E8=
X-Received: by 2002:a9f:31ad:: with SMTP id v42mr2393402uad.58.1628506805059;
 Mon, 09 Aug 2021 04:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOnJCUL9uU5G1LOgfYPz9Ny77yFYaP5sgtdxG3_w=Zcsi+f96Q@mail.gmail.com>
 <mhng-c9300c9e-6877-492f-a290-7c51066d3920@palmerdabbelt-glaptop>
 <20210805023024.GA12312@x1> <CANBLGcwczBsc-mfU2t9=7No7KhHfBFHFzGy=5hdyEE+4VN8ksg@mail.gmail.com>
 <CAOnJCU+-orqjP5dND0QNh+08UhXitS=LPpg1VpnBcp=6YJU7EQ@mail.gmail.com>
In-Reply-To: <CAOnJCU+-orqjP5dND0QNh+08UhXitS=LPpg1VpnBcp=6YJU7EQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Aug 2021 12:59:53 +0200
Message-ID: <CAMuHMdW=HUKz-9gd6R2Sh4tu5uLrjNPhdScZMi5ev+n-B4yYsw@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: riscv: add starfive jh7100 bindings
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Drew Fustini <drew@pdp7.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 8:09 PM Atish Patra <atishp@atishpatra.org> wrote:
> On Thu, Aug 5, 2021 at 1:13 AM Emil Renner Berthing <kernel@esmil.dk> wrote:
> > On Thu, 5 Aug 2021 at 04:30, Drew Fustini <drew@pdp7.com> wrote:
> > > On Wed, Aug 04, 2021 at 02:13:47PM -0700, Palmer Dabbelt wrote:
> > > > On Wed, 04 Aug 2021 13:54:16 PDT (-0700), atishp@atishpatra.org wrote:
> > > > > On Wed, Aug 4, 2021 at 1:33 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > > > > On Thu, 15 Jul 2021 19:17:23 PDT (-0700), bmeng.cn@gmail.com wrote:
> > > > > > > On Tue, Jul 13, 2021 at 2:34 PM Drew Fustini <drew@beagleboard.org> wrote:
> > > > > > >> Add DT binding documentation for the StarFive JH7100 Soc [1] and the
> > > > > > >> BeagleV Starlight JH7100 board [2].
> > > > > > >>
> > > > > > >> [1] https://github.com/starfive-tech/beaglev_doc
> > > > > > >> [2] https://github.com/beagleboard/beaglev-starlight
> > > > > > >>
> > > > > > >> Signed-off-by: Drew Fustini <drew@beagleboard.org>

> > > > > Given that beagleV starlight mass production is cancelled [1], are we
> > > > > still upstreaming the support for this ?
> > > >
> > > > I'm not sure, but I wasn't quite sure where to have that discussion.  I
> > > > figured that the boards exist so there's no reason to shoot this down, given
> > > > that it's just the vendor DT list.  At a bare minimum there's out of tree
> > > > support for this, so having the DT strings defined seems sane as that's a
> > > > defacto interface with bootloaders.
> > > >
> > > > Maybe this is more of a question for Drew: I think we were all OK working
> > > > through the issues with the first-run chip when there was going to be a lot
> > > > of them, but with such a small number produced I'm not sure if there's going
> > > > to be enough interested to take on all that effort.
> > > >
> > > > I'm not quite sure where we stand on support for this: at some point there
> > > > were some ideas floating around as to a way to support it without major
> > > > software changes (allocating into the non-caching regions).  If that pans
> > > > out then I'm fine handling this, at least from the RISC-V side, but if we're
> > > > going to have to go through all the ISA/SBI stuff then it's probably not
> > > > worth it.  Also not sure if there are a bunch of starfive-specific drivers
> > > > that would be needed to make this boot, in which case it's probably best to
> > > > wait for whatever comes next.
> > >
> > > I think that the discontinued beta prototype could be useful as a native
> > > build host for those of you that have it and don't have an Unmatched.

Exactly.  And there are ca. 300 boards out there (many more than
some other platforms supported by Linux), which won't disappear with
the blimp of an eye (unlike "proprietary" boards that tend to get
mass-destroyed when a project is cancelled).

> > Also according to this statement [1], they're still planning on
> > producing new boards with the JH7100 (same chip as on the BeagleV
> > prototype) at the end of Q3 and the JH7110 further in the future, so I
> > still think it'd make sense to support those.
> >
> > [1]: https://www.design-reuse.com/news/50402/starfive-open-source-single-board-platform-q3-2021.html
>
> > > The arch_sync_dma RFC from Atish [1] is key to the board running
> > > mainline. Most of the peripherals (USB, SD card, ethernet) are already
> > > supported by upstream Cadence and Synopsys drivers. However, the vendor
> > > kernel used ifdef's to flush the L2 cache at several points in those
> > > drivers and subsystem cores because the peripherals are on a non-cache
> > > coherent interconnect.
> > >
> > > Without the proposed solution from Atish that uses the non-cached DDR
> > > alias, then only serial console would work on mainline (assuming the
> > > system is running from a ramdisk that the vendor uboot loaded).
>
> We need the clock patches as well. If there is an agreed effort to
> upstream the clock patches
> and other bare minimum patches, I am happy to revise the DMA patches as well.

The main issue with the clock driver is that we do not have complete
documentation about the clock tree, so the tree implemented by the
driver is a bit ad-hoc.

However, I do think we already have a good separation between DT
bindings (incl. definitions) and clock driver.  Hence we can upstream
the DT and clock driver, and fill in the missing and correct the
existing parts of the clock driver later, without needing further
changes to the DT bindings.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
