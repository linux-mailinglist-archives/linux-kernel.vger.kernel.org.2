Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924CA3AA71C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhFPW63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhFPW6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:58:25 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10EDC061574;
        Wed, 16 Jun 2021 15:56:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id e10so5348943ybb.7;
        Wed, 16 Jun 2021 15:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ktzrciVp8PDUDyfHCUWiDdgZR3bBYVG0fuSDVfTYG0=;
        b=qKOD10Tgu4BRblFOlZbhaFW8lYbpgeWnzioSB3cfKLCk1QQxWR0r774hpSmbGWafHU
         5O6hR7JijyPFHeyIK4QbOX1EQrTcNs7F7UPMv4X0Lr61la5R1lMlkosh9L1qRqv8RaW7
         JJRSCxMHgLVYrkRC0i+0apZT7KNQy8afKnvH2ZymKlehT+Bs1hvm8+8YMnGOvNbgvcx3
         H3zweqdOJke4rT5iSW7mXpdDDSuS5JUapjcq83M2LL5TC8i65qsTJd/rOli0yC5HYeFN
         IyOQ7Kq/E75TiHH6nQFZxzbSchiGG5KFhmw6ppI555KMdYPlozEdW5REX1ALnr1WF9xx
         3h4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ktzrciVp8PDUDyfHCUWiDdgZR3bBYVG0fuSDVfTYG0=;
        b=YWDW7XlpssHOzU1MiRp1EU91Q+zbUQ8MTpJTthu5X2K/u0m7YD0JceHM04KJLxp9NN
         q83nYtv1wmT/NjIu0seD/2/Vh7zvDxuaPUUAeoDVrgAyIVfsqXfu3r2Es397AB2EqO/W
         Vph4DMHdG4s8KBl6K1XO419XX77L8FsLN0t/5lD6BZrk0XQ4s2HaDI7wG+WhDdbGfSpl
         gmgP0YUzbTu/i6qNiQbz0uKY+02E4mpI9Pin6hX8lMU4YUihx9j4ErbMDSj7lWC9NchT
         DB0SUxdJuNRuxf7FNBOpr05A4NhuZgAixiio+EIB7yElRoVdYV+y1K2tMkD/0N1Wv5lR
         ggSw==
X-Gm-Message-State: AOAM533l9+yeh9d5OxOsFZYTSxHI/gc5uBeu5zlKMMS3CXYW+zbcADW9
        2Vi0H7u5BLtTbs3+kwoOvE9rDf9NZ96pRZwexNo=
X-Google-Smtp-Source: ABdhPJy2bYjcw+GuihyRCyKaLF4ubMehx74EDGkm1MsIat5q4cEpt8wfuO31nYmDN5SMlLzYIE7y12qKOEMMqbKltO4=
X-Received: by 2002:a25:cf8f:: with SMTP id f137mr1995862ybg.314.1623884178196;
 Wed, 16 Jun 2021 15:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <1592308864-30205-1-git-send-email-yash.shah@sifive.com>
 <1592308864-30205-3-git-send-email-yash.shah@sifive.com> <CAEUhbmXKdukBwd0OL2ApOD67aQ9ytSPns3z=COtXTSP_mm3wvQ@mail.gmail.com>
 <CAEn-LToZODMPLpsbKJcJXpksJSxTk0WSNpaR9N7uMekNriC+bg@mail.gmail.com>
In-Reply-To: <CAEn-LToZODMPLpsbKJcJXpksJSxTk0WSNpaR9N7uMekNriC+bg@mail.gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 17 Jun 2021 06:56:06 +0800
Message-ID: <CAEUhbmUUCprZ20rUUsiM4YWgH=WKsUh_WqnxXbyB7jQqdQB9Hw@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: dts: fu540-c000: define hart clocks
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Yash Shah <yash.shah@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Green Wan <green.wan@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        lollivier@baylibre.com, deepa.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:14 PM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
>
> On Wed, Jun 16, 2021 at 6:17 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Tue, Jun 16, 2020 at 8:01 PM Yash Shah <yash.shah@sifive.com> wrote:
> > >
> > > Declare that each hart defined in the FU540 DT data is clocked by the
> > > COREPLL. This is in preparation for enabling CPUFreq for the
> > > FU540-C000 SoC on the HiFive Unleashed board.
> > >
> > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > ---
> > >  arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> >
> > Any idea of why this patch was not applied?
>
> There was a decision not to upstream CPUFreq stuff for Unleashed thus
> the whole series probably was abandoned. Not all Unleashed can operate
> in a stable way at 1.4GHz. IIRC other issues could exist. See Palmer
> reply for the whole series.

Thanks, but the DT change is still valid, and should be upstreamed.

Regards,
Bin
