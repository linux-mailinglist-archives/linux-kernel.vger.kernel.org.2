Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DD1438F11
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhJYGDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhJYGDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:03:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D886660F4F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 06:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635141657;
        bh=CuzeI+0Q9Euya1CQX3pyZPAzzTOCsyTDTkaMPkoJqGo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WrSz3/ifZ7d1DGrKK1WtVRR5rvnOUBWmMlIiuLYv9vhe2ph5eVTbGNOUV3NnGlwqK
         I4sahrPfh3i9fWUdZ9iqMnHVcNLOIqrBePBRqzdpNkQ41raIAAYxdORgt0temM4Rca
         mNH9nuuGPyWFAvxaIQRCcdEMRzoLl2OAlKpaMV+p4rNL92aRPV8uFk/AVhQf5Scrtf
         SC8V7oKAOM+rGFFVSg3EOvgiCtUfl32zpvwBqsB/HobMgy24idQrlNVFIxE0060HQ8
         lAkqHII3zAUjps+RVVb4K/lB290LF2bABjl4IISVMKidkPiJlI++iNKqh+k/K5fz9L
         Vgp4yASDVGJlw==
Received: by mail-ua1-f54.google.com with SMTP id q13so19860789uaq.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 23:00:57 -0700 (PDT)
X-Gm-Message-State: AOAM533DWb1l1nT41Cacl4R05pjJTxt102g1Ke0UIKe6jisTqJFrTqEi
        zaE8VdI/DgH4o2hQHtw4oTx+z+310iDPCkn/8Y4=
X-Google-Smtp-Source: ABdhPJxBht3G4IWScUXK+IaOfdkjsis4dL/gBa1CnvEp5RIYyns3bsUObddpMGH50GRFWCGiAevIL/WMph7+cIwhQVQ=
X-Received: by 2002:a67:fa93:: with SMTP id f19mr12463846vsq.43.1635141657031;
 Sun, 24 Oct 2021 23:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211025040607.92786-1-wefu@redhat.com> <20211025040607.92786-2-wefu@redhat.com>
 <CAAhSdy1N-UQFnbFc7PSwf62y=gbvX7pK=vwUaG8m_KzdWx3AgQ@mail.gmail.com>
In-Reply-To: <CAAhSdy1N-UQFnbFc7PSwf62y=gbvX7pK=vwUaG8m_KzdWx3AgQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 25 Oct 2021 14:00:46 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT9T-TwTmGsfDH0Y05LO6dF6nGUUSGZW=RSackM0fUUyg@mail.gmail.com>
Message-ID: <CAJF2gTT9T-TwTmGsfDH0Y05LO6dF6nGUUSGZW=RSackM0fUUyg@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 1/2] dt-bindings: riscv: add mmu-supports-svpbmt
 for Svpbmt
To:     Anup Patel <anup@brainfault.org>
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

On Mon, Oct 25, 2021 at 12:17 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Oct 25, 2021 at 9:36 AM <wefu@redhat.com> wrote:
> >
> > From: Wei Fu <wefu@redhat.com>
> >
> > Previous patch has added svpbmt in arch/riscv and changed the
> > DT mmu-type. Update dt-bindings related property here.
> >
> > Signed-off-by: Wei Fu <wefu@redhat.com>
> > Co-developed-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index e534f6a7cfa1..76f324d85e12 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -59,6 +59,11 @@ properties:
> >        - riscv,sv48
> >        - riscv,none
> >
> > +  mmu-supports-svpbmt:
> > +    description:
> > +      Describes the CPU's mmu-supports-svpbmt support
> > +    $ref: '/schemas/types.yaml#/definitions/phandle'
>
> There were various proposals from different folks in the previous
> email threads.
>
> I think most of us were converging on:
> 1) Don't modify "mmu-type" DT property for backward
> compatibility
I agree. FuWei has followed that in the patch.

> 2) Add boolean DT property "riscv,svpmbt" under
> "mmu" child DT node of each CPU DT node. Same will apply
> to boolean DT property "riscv,svnapot" as well.
We have various proposals here:
@Philipp suggests firstly, but break the backward compatibility:
 cpu@0 {
    ...
    mmu {
       type = "riscv,sv39";
       supports-svpbmt;
       supports-svnapot;
    };

@guoren suggests reusing the mmu-type, but seems not clean.
cpu@0 {
   ...
   mmu-type = "riscv,sv39,svpbmt,svnapot";


@fuwei suggests simple name property in CPU section:
cpu@0 {
   ...
   mmu-type = "riscv,sv39";
   mmu-supports-svpbmt;
   mmu-supports-svnapot;

@Anup suggests:
cpu@0 {
   ...
    mmu-type = "riscv,sv39";
    mmu {
       supports-svpbmt;
       supports-svnapot;
    };

Any other suggestions? Thx.

>
> We also have bitmanip and vector broken down into smaller
> extensions so grouping related extensions as separate DT node
> under each CPU node will be more readable and easy to parse.
Do you mean combine mmu extensions with them together?
cpu@0 {
    ...
    extensions {
        supports-svpbmt;
        supports-svnapot;
        supports-bitmanip;
        supports-vector-v0p7;
    };

>
> Regards,
> Anup
>
> > +
> >    riscv,isa:
> >      description:
> >        Identifies the specific RISC-V instruction set architecture
> > --
> > 2.25.4
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
