Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7A3438F23
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhJYGLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhJYGLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:11:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274BBC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 23:08:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d13so8178910wrf.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 23:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGkRycj0d3BgvWsn3mqfLGnFcKdGcdIEmfaEWsojsoA=;
        b=RutRlINtDvCq2A2xg1lqlbsaVbTYFWtCjSCs91oJFS7J5ijaZ0/KKXPdEnEMmXdOp9
         ra8YOmlmjCYB+l3ELTTby0zgtclDNXgjstjLPujDO16qXR3uW0pQCzQxQ6Brfj9vHd+S
         r1q4tqd7x9kXx6yqtBIZxxEg+rfxC37SN0S9jrr8QbMtOssruTYELFGadeQXVKcvD6WP
         cf/F3dx92bKkxFrn7KgYlp1vWO+M/XmvBZ4ejnwuJ7a2Qc2jNqpG4YErx77GaRqHnXv5
         iyBcEluhcn0Cu+vW1DvKO6fdpwbFoAXYnIzFJcj5RPdFhD/1RbcT2fwHhqT6pm8X9aGI
         GKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGkRycj0d3BgvWsn3mqfLGnFcKdGcdIEmfaEWsojsoA=;
        b=q7AraPLrbWIt5sQTVsMDDKqiHkpIHUCrKSIZG/CGhwrygfMc+60uuQbhK8tU5wpznJ
         sdeBPtjlsbUTK6k/eB8r/d+pFMqoL30WJT4tpaUvtby9SVi1Fg7EY1cWgCHOU7PEBTSw
         gOG3RuGhpdVPDneJCcqbPRfEThnBZBHB31aV8WSErbkDSbEZmeRoAPTqqNibpPeuVNWV
         sdrNredElFXdgViaEn9iIB2y4q4uAfmwCox5Eo2yLgJawM8QU0n/U2BVxYbxkmUlLIxY
         QUYGS2SpP7BT2DisOvwYTjTORdce6hEDT2NcMKtxxOdUsJ7XCsWsC/IPK5BJkbsPx38/
         /omQ==
X-Gm-Message-State: AOAM532N5BgU0R/JR6g7+Tj6UmFhvzXQjbrfpSJgsKOAhyF0AA2rLtEH
        t5raLNvx2xxi+iH9hp3K7AgcQ61xblqEH7U8OqlHyQ==
X-Google-Smtp-Source: ABdhPJxo61B3UhJ1Hqmx+YwhbQWISYFBHmDSQ2UBVE+fx6sumH0Qh2AtVNl9yTqySp7SN0F9ztWiKNp4F8iXtmXvoIM=
X-Received: by 2002:a5d:5849:: with SMTP id i9mr21493562wrf.331.1635142119602;
 Sun, 24 Oct 2021 23:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211025040607.92786-1-wefu@redhat.com> <20211025040607.92786-2-wefu@redhat.com>
 <CAAhSdy1N-UQFnbFc7PSwf62y=gbvX7pK=vwUaG8m_KzdWx3AgQ@mail.gmail.com> <CAJF2gTT9T-TwTmGsfDH0Y05LO6dF6nGUUSGZW=RSackM0fUUyg@mail.gmail.com>
In-Reply-To: <CAJF2gTT9T-TwTmGsfDH0Y05LO6dF6nGUUSGZW=RSackM0fUUyg@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Oct 2021 11:38:27 +0530
Message-ID: <CAAhSdy1ZuQyWdVY5dmrnNVHe3oOYxhieW1upAhbnDvuxNL=YyA@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 1/2] dt-bindings: riscv: add mmu-supports-svpbmt
 for Svpbmt
To:     Guo Ren <guoren@kernel.org>
Cc:     Wei Fu <wefu@redhat.com>, Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com,
        Aniket Ponkshe <aniket.ponkshe@canonical.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Gordan Markus <gordan.markus@canonical.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:30 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Oct 25, 2021 at 12:17 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Mon, Oct 25, 2021 at 9:36 AM <wefu@redhat.com> wrote:
> > >
> > > From: Wei Fu <wefu@redhat.com>
> > >
> > > Previous patch has added svpbmt in arch/riscv and changed the
> > > DT mmu-type. Update dt-bindings related property here.
> > >
> > > Signed-off-by: Wei Fu <wefu@redhat.com>
> > > Co-developed-by: Guo Ren <guoren@kernel.org>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > Cc: Anup Patel <anup@brainfault.org>
> > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > index e534f6a7cfa1..76f324d85e12 100644
> > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > @@ -59,6 +59,11 @@ properties:
> > >        - riscv,sv48
> > >        - riscv,none
> > >
> > > +  mmu-supports-svpbmt:
> > > +    description:
> > > +      Describes the CPU's mmu-supports-svpbmt support
> > > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> >
> > There were various proposals from different folks in the previous
> > email threads.
> >
> > I think most of us were converging on:
> > 1) Don't modify "mmu-type" DT property for backward
> > compatibility
> I agree. FuWei has followed that in the patch.
>
> > 2) Add boolean DT property "riscv,svpmbt" under
> > "mmu" child DT node of each CPU DT node. Same will apply
> > to boolean DT property "riscv,svnapot" as well.
> We have various proposals here:
> @Philipp suggests firstly, but break the backward compatibility:
>  cpu@0 {
>     ...
>     mmu {
>        type = "riscv,sv39";
>        supports-svpbmt;
>        supports-svnapot;
>     };
>
> @guoren suggests reusing the mmu-type, but seems not clean.
> cpu@0 {
>    ...
>    mmu-type = "riscv,sv39,svpbmt,svnapot";
>
>
> @fuwei suggests simple name property in CPU section:
> cpu@0 {
>    ...
>    mmu-type = "riscv,sv39";
>    mmu-supports-svpbmt;
>    mmu-supports-svnapot;
>
> @Anup suggests:
> cpu@0 {
>    ...
>     mmu-type = "riscv,sv39";
>     mmu {
>        supports-svpbmt;
>        supports-svnapot;
>     };
>
> Any other suggestions? Thx.
>
> >
> > We also have bitmanip and vector broken down into smaller
> > extensions so grouping related extensions as separate DT node
> > under each CPU node will be more readable and easy to parse.
> Do you mean combine mmu extensions with them together?
> cpu@0 {
>     ...
>     extensions {
>         supports-svpbmt;
>         supports-svnapot;
>         supports-bitmanip;
>         supports-vector-v0p7;
>     };

I meant separate group nodes like this:

cpu@0 {
    ...
    mmu-type = "riscv,sv39";
    mmu { /* Only considered when mmu-type is present and mmu-type !=
"riscv,sv32" */
        riscv,svpmbt;
        riscv,svnapot;
    };

    bitmanip { /* Only considered when "B" is present in the ISA string */
        ...
    };

   vector { /* Only considered when "V" is present in the ISA string */
       ...
   };
    ...
};

Regards,
Anup

>
> >
> > Regards,
> > Anup
> >
> > > +
> > >    riscv,isa:
> > >      description:
> > >        Identifies the specific RISC-V instruction set architecture
> > > --
> > > 2.25.4
> > >
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
