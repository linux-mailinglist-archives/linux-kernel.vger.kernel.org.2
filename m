Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B26743976A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhJYNYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhJYNYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:24:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7D6C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 06:22:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d10so8734056wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHr5OHD5jpaUHwRPw9aH93bpMTz/ijSR6iNj3HeWX0s=;
        b=dBywuSgiJPi0D1S2vr4DoJq7T77YxIGCJ4mMgfU1wZFg1NE4zAn8AmG4mPRPFf7+qc
         ZSJrUumbL0079syfoR2CyAKgq0q+MCS43Gx7PO5URbNHdhHO8GneCUDG1Emf/f0qNPv/
         5Z1Z3YVsJ4l/RG7K8OZ5BQkGwcdA5qFpwDMMqiFPs8Ecaxj+fd8D5EAxTblxG6n5tGh7
         Ep/f7hyzQOg+IBVCR2VqteZC+cYAD35O3VSXUQIn8daTgVBg2706ggFDQwTt46LFT8vG
         z0ZrDRWWZb40w2oS1LN7rkqp5TC5HrQLvm42Fyk5y8oRZYeUsgrj6UHxG+300x8oz3QB
         /tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHr5OHD5jpaUHwRPw9aH93bpMTz/ijSR6iNj3HeWX0s=;
        b=N+kPdxRyQ38g8YaD6tS5fJ9q5LV/qqfTcnaJHW9LKPmC+AyGe+oJBmmBerwojFA7aF
         tVfO1R0J0Pa1bV/ezCvrFvotTukoQllsYgZBBKijvJpw2mBuKEFqoGO4+eFH7GkHXotQ
         l/Zos6PACCeZ0SdCX28/EhhQqJP2x2DBvnGXtGHZUJuNzcCLBonRLv+llzE2sz7Rasoo
         JXmACoBmpl8swHKbdWwqecsIGAUyEJsH6W6kPKCHMN8wXKrAHRL6tva4AF+lSwE9YuZs
         ZfpOSnfqizK0Dcj069wY9Yux9lDpSqPqWGx+Hs6AKmiCnOLVCo6ibSHiniVDq7iU/oSC
         mwnA==
X-Gm-Message-State: AOAM531JCCMQrj+pIEjVRrN/H0DWPkvVXwyhsexvkcJJJDgNMruFAFlj
        O2itgSTI6xohyLn0ubXBGGhhAh9jZC4H+xVlMty9Bg==
X-Google-Smtp-Source: ABdhPJz5nKuH/w0FKB9WEVD82bBCnHRd2n8YsgxSr40uZXV9aVLRM0MQ++QJYWyVgoVf8kfjPS6XpV7zEbHEnScn5dc=
X-Received: by 2002:adf:c183:: with SMTP id x3mr21329364wre.90.1635168127135;
 Mon, 25 Oct 2021 06:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211025040607.92786-1-wefu@redhat.com> <20211025040607.92786-2-wefu@redhat.com>
 <CAAhSdy1N-UQFnbFc7PSwf62y=gbvX7pK=vwUaG8m_KzdWx3AgQ@mail.gmail.com>
 <CAJF2gTT9T-TwTmGsfDH0Y05LO6dF6nGUUSGZW=RSackM0fUUyg@mail.gmail.com> <CAAhSdy1ZuQyWdVY5dmrnNVHe3oOYxhieW1upAhbnDvuxNL=YyA@mail.gmail.com>
In-Reply-To: <CAAhSdy1ZuQyWdVY5dmrnNVHe3oOYxhieW1upAhbnDvuxNL=YyA@mail.gmail.com>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Mon, 25 Oct 2021 15:21:56 +0200
Message-ID: <CAAeLtUCM=01oue8hZQ_hTgzRDXu1qdgtyqyKBG5kOzXCbbUxYQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 1/2] dt-bindings: riscv: add mmu-supports-svpbmt
 for Svpbmt
To:     Anup Patel <anup@brainfault.org>
Cc:     Guo Ren <guoren@kernel.org>, Wei Fu <wefu@redhat.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
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

On Mon, 25 Oct 2021 at 08:08, Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Oct 25, 2021 at 11:30 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Mon, Oct 25, 2021 at 12:17 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Mon, Oct 25, 2021 at 9:36 AM <wefu@redhat.com> wrote:
> > > >
> > > > From: Wei Fu <wefu@redhat.com>
> > > >
> > > > Previous patch has added svpbmt in arch/riscv and changed the
> > > > DT mmu-type. Update dt-bindings related property here.
> > > >
> > > > Signed-off-by: Wei Fu <wefu@redhat.com>
> > > > Co-developed-by: Guo Ren <guoren@kernel.org>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > Cc: Anup Patel <anup@brainfault.org>
> > > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > index e534f6a7cfa1..76f324d85e12 100644
> > > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > @@ -59,6 +59,11 @@ properties:
> > > >        - riscv,sv48
> > > >        - riscv,none
> > > >
> > > > +  mmu-supports-svpbmt:
> > > > +    description:
> > > > +      Describes the CPU's mmu-supports-svpbmt support
> > > > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > >
> > > There were various proposals from different folks in the previous
> > > email threads.
> > >
> > > I think most of us were converging on:
> > > 1) Don't modify "mmu-type" DT property for backward
> > > compatibility
> > I agree. FuWei has followed that in the patch.
> >
> > > 2) Add boolean DT property "riscv,svpmbt" under
> > > "mmu" child DT node of each CPU DT node. Same will apply
> > > to boolean DT property "riscv,svnapot" as well.
> > We have various proposals here:
> > @Philipp suggests firstly, but break the backward compatibility:
> >  cpu@0 {
> >     ...
> >     mmu {
> >        type = "riscv,sv39";
> >        supports-svpbmt;
> >        supports-svnapot;
> >     };
> >
> > @guoren suggests reusing the mmu-type, but seems not clean.
> > cpu@0 {
> >    ...
> >    mmu-type = "riscv,sv39,svpbmt,svnapot";
> >
> >
> > @fuwei suggests simple name property in CPU section:
> > cpu@0 {
> >    ...
> >    mmu-type = "riscv,sv39";
> >    mmu-supports-svpbmt;
> >    mmu-supports-svnapot;
> >
> > @Anup suggests:
> > cpu@0 {
> >    ...
> >     mmu-type = "riscv,sv39";
> >     mmu {
> >        supports-svpbmt;
> >        supports-svnapot;
> >     };
> >
> > Any other suggestions? Thx.
> >
> > >
> > > We also have bitmanip and vector broken down into smaller
> > > extensions so grouping related extensions as separate DT node
> > > under each CPU node will be more readable and easy to parse.
> > Do you mean combine mmu extensions with them together?
> > cpu@0 {
> >     ...
> >     extensions {
> >         supports-svpbmt;
> >         supports-svnapot;
> >         supports-bitmanip;
> >         supports-vector-v0p7;
> >     };
>
> I meant separate group nodes like this:
>
> cpu@0 {
>     ...
>     mmu-type = "riscv,sv39";
>     mmu { /* Only considered when mmu-type is present and mmu-type !=
> "riscv,sv32" */
>         riscv,svpmbt;
>         riscv,svnapot;
>     };
>
>     bitmanip { /* Only considered when "B" is present in the ISA string */
>         ...
>     };

Please disregard this comment regarding bitmanip/B.
The B bit in the misa CSR is not used for any signalling regarding
Zb[abcs] (or the other Zb-extensions), so this entire node is not
needed and B in the ISA string is not related to any of the Zb*
extensions).
All Zb* extensions are directly visible from the ISA string.

>    vector { /* Only considered when "V" is present in the ISA string */
>        ...
>    };
>     ...
> };
>
> Regards,
> Anup
>
> >
> > >
> > > Regards,
> > > Anup
> > >
> > > > +
> > > >    riscv,isa:
> > > >      description:
> > > >        Identifies the specific RISC-V instruction set architecture
> > > > --
> > > > 2.25.4
> > > >
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/
