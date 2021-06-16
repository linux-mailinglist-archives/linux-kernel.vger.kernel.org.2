Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C93A9EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhFPPQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbhFPPQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:16:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AF3C061574;
        Wed, 16 Jun 2021 08:14:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a1so4801199lfr.12;
        Wed, 16 Jun 2021 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCUe9yfJi8lButFYN+6DXnGgFGVFnjhGmS6IdUFM/PE=;
        b=P9gYjuYuzTOvvhKnAnjxUs0opTMMss9J94gjjllmYV1996b99XjsTVEPKMyuyQ2Csw
         ZZl8Nun3vnmJqQSmBwIjjfm/mswaE8JDT8eNnZ5zxV0MI0hoyrYQiqJycTji6C3DdWr2
         4H05z1nOd217vS0ByxBD0jtVLzXyDWwemSFbAKy6XrS1MNXbD8RYNHHgdV05OVU9lm08
         xNXJwIH1H7hYnt8eJTRKZumddevouP7wQzaHIDQa0gKR3/cNv4wdGIyrXBtHJXaXiQRc
         +0h37BsuW36iMqOk3Cy78yDO/SNdFoEOydZh9z/Kd58BlMAuuxtz1+WHZSfkI0UzqywC
         jtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCUe9yfJi8lButFYN+6DXnGgFGVFnjhGmS6IdUFM/PE=;
        b=sk6Oe/UtYioIJdjszZnu2PngK/WrPerPTWEo8+7Nbz/qt3LyVOuRdo0Plh6ccQ/h1x
         R8JIsOWQutTUyEAXknk1kZFfup7whEo87dFexXI1smJMZkH/YH6BCb5qRYOgxLGRXT1Q
         E+Xm/3ypifzQ4qY/rTY7xiym0bE2aXX3hv81vLvJte7EAlnwK7WerkmLvsonXW7sNNxu
         bhGhRo0yFZcaSu8HV1buBD7eCQzpOX5fNcytBqLN3FNtPB+ho/6NoFVG95wz0kcSfK1J
         og5gOFQg4EhVSNxn7xc/z3x8sOBwtyFfV6/43XF4jgyTId5O5NO6Qn7zjwnJejZ4a2+G
         kAmw==
X-Gm-Message-State: AOAM532VlnzvSnT/pZnOqlYuRBEZ4oPsb651c9FIANGSJD36coj7JfBY
        WMynhGDaq0KSe7hYcO4eEgKIjxn44hUCSPg9rYA=
X-Google-Smtp-Source: ABdhPJwIpMycqjcQSuT4OYUHdF/dfwOWq9xQzFw5rA040gQQSFuud2r0vCT1k8gg8ncNYf6VPFmHVufU57mjRtx+qcI=
X-Received: by 2002:a19:4086:: with SMTP id n128mr140101lfa.464.1623856455921;
 Wed, 16 Jun 2021 08:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <1592308864-30205-1-git-send-email-yash.shah@sifive.com>
 <1592308864-30205-3-git-send-email-yash.shah@sifive.com> <CAEUhbmXKdukBwd0OL2ApOD67aQ9ytSPns3z=COtXTSP_mm3wvQ@mail.gmail.com>
In-Reply-To: <CAEUhbmXKdukBwd0OL2ApOD67aQ9ytSPns3z=COtXTSP_mm3wvQ@mail.gmail.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Wed, 16 Jun 2021 18:13:40 +0300
Message-ID: <CAEn-LToZODMPLpsbKJcJXpksJSxTk0WSNpaR9N7uMekNriC+bg@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: dts: fu540-c000: define hart clocks
To:     Bin Meng <bmeng.cn@gmail.com>
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

On Wed, Jun 16, 2021 at 6:17 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Tue, Jun 16, 2020 at 8:01 PM Yash Shah <yash.shah@sifive.com> wrote:
> >
> > Declare that each hart defined in the FU540 DT data is clocked by the
> > COREPLL. This is in preparation for enabling CPUFreq for the
> > FU540-C000 SoC on the HiFive Unleashed board.
> >
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
>
> Any idea of why this patch was not applied?

There was a decision not to upstream CPUFreq stuff for Unleashed thus
the whole series probably was abandoned. Not all Unleashed can operate
in a stable way at 1.4GHz. IIRC other issues could exist. See Palmer
reply for the whole series.

david

>
> Regards,
> Bin
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
