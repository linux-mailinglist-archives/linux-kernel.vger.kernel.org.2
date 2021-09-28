Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE8F41A88B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 08:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbhI1GGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 02:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239141AbhI1GFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:05:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECC17611F0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632809018;
        bh=vjVfKXJy2xx64ITHbCITCyC+acx70L3tyY38fPQ7Dl4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BQlnqrMapEqzveec14mb/O6Sn/bQPcYWXjE8IUOUXyUVUO3b0pXepgH2c2mnnUXgM
         C8z1jjnpLJkklKHqh6YZmCSLSSHhNW1ObqmVw+e0XDGVVKwu6Qmwq775ZRrpZjGY4H
         UvsFZQsHaEr/40GnKVPhxbl0v0d0eq5u9oDJuXzUsVhbaVc4C4yMCulD5rT7FqHnwr
         7Zoo3Bj6K1rtUtNdlGDXncEpsagdK1EE6nyGOsTMVMB5XUKGs68jPHtTIMkaFePZta
         PDyHJMYSsONlbZ9VSyTJmDb6Hl3pZ+BlQZCDysTT7a5wh/82poqwRs7bI8g1RgOe1M
         iEcUbbc6QdUww==
Received: by mail-vs1-f48.google.com with SMTP id q66so20857975vsa.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 23:03:37 -0700 (PDT)
X-Gm-Message-State: AOAM532pwNhXzn5iYJBfmaQMnlv7xKEd9W3OirNa8kFmcbt7u49X65uz
        vs94CUpPUzyY9kIhCVPD7HPWIxddUscCcVRnmqw=
X-Google-Smtp-Source: ABdhPJxXsGz/5A0ua6jddc3SvcqVj+i4dfTq8E463AgvrxLuZGOteWmC0ebDC4j5ubWscKRWo/TBkVPE1uCasriKomw=
X-Received: by 2002:a67:f9da:: with SMTP id c26mr3643460vsq.50.1632809017047;
 Mon, 27 Sep 2021 23:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172107.1117604-1-guoren@kernel.org> <CAOnJCUJWnDB+uRxDh=YSbGW4bf5RQvke03iCTYMYHPsw3cwnHQ@mail.gmail.com>
 <CAOnJCULrE595ex3gBTnu4GnPazO4mg8Tkrtbv6j8iLWe+sKJSA@mail.gmail.com>
 <0790abcfa1174e0e9b5e7b185f87ced9@mailhost.ics.forth.gr> <CAAhSdy2-y4xpM9PCrS0vgCN9ngFiBygeDOWcbgsX6Myb4XjDQg@mail.gmail.com>
 <CAOnJCULg36kNiDV6ymTSRff8yYZvFKpxm5uh=cAicQT44OcLYw@mail.gmail.com>
In-Reply-To: <CAOnJCULg36kNiDV6ymTSRff8yYZvFKpxm5uh=cAicQT44OcLYw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 28 Sep 2021 14:03:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQSvKxekXqNQ6ttra5nVTV02ZKu+x0ThFYvSQermVbNgQ@mail.gmail.com>
Message-ID: <CAJF2gTQSvKxekXqNQ6ttra5nVTV02ZKu+x0ThFYvSQermVbNgQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] riscv: Add RISC-V svpbmt extension
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
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
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 12:26 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Mon, Sep 27, 2021 at 8:50 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Tue, Sep 28, 2021 at 6:32 AM Nick Kossifidis <mick@ics.forth.gr> wro=
te:
> > >
> > > =CE=A3=CF=84=CE=B9=CF=82 2021-09-27 23:13, Atish Patra =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:
> > > >> We need to decide whether we should support the upstream kernel fo=
r
> > > >> D1. Few things to consider.
> > > >> =E2=80=93 Can it be considered as an errata ?
> > >
> > > It's one thing to follow the spec and have an error in the
> > > implementation, and another to not follow the spec.
> > >
> > > >> =E2=80=93 Does it set a bad precedent and open can of worms in fut=
ure ?
> > >
> > > IMHO yes, I'm thinking of Kendryte 210 devs for example coming up and
> > > asking for MMU support, they 've also shipped many chips already. I c=
an
> > > also imagine other vendors in the future coming up with implementatio=
ns
> > > that violate the spec in which case handling the standard stuff will
> > > become messy and complex, and hurt performance/security. We'll end up
> > > filling the code with exceptions and tweaks all over the place. We ne=
ed
> > > to be strict about what is "riscv" and what's "draft riscv" or "riscv
> > > inspired", and what we are willing to support upstream. I can underst=
and
> > > supporting vendor extensions upstream but they need to fit within the
> > > standard spec, we can't have for example extensions that use encoding
> > > space/csrs/fields etc reserved for standard use, they may only use
> > > what's reserved for custom/vendor use. At least let's agree on that.
> >
> > Totally agree with Nick here. It's a slippery slope.
> >
> > Including D1 PTE bits (or Kendryte K210 MMU) part of the Linux RISC-V
> > means future hardware which intentionally violates specs will also have=
 to
> > be merged and the RISC-V patch acceptance policy will have no significa=
nce.
> >
> > >
> > > >> =E2=80=93 Can we just ignore D1 given the mass volume ?
> > > >>
> > >
> > > IMHO no, we need to find a way to support it upstream but I believe
> > > there is another question to answer:
> > >
> > > Do we also guarantee "one image to rule them all" approach, required =
by
> > > binary distros, for implementations that violate the spec ? Are we ok
> > > for example to support Allwinner D1 upstream but require a custom
> > > configuration/build instead of supporting it with the "generic" image=
 ?
> > > In one case we need to handle the violation at runtime and introduce
> > > overhead for everyone (like looking up __riscv_svpbmt every time we s=
et
> > > a PTE in this case), in the other it's an #ifdef.
> >
> > At least, we should not have hardware violating specs as part of the
> > unified kernel image instead have these intentional deviations/violatio=
ns
> > under separate kconfig which will not be enabled by default. This means
> > vendors (of such hardware) and distros will have to explicitly enable
> > support for such violations/deviations.
> >
>
> If we merge the code and are not enabled by default, it would be a
> maintenance nightmare in future.
> These part of the kernel will not be regularly tested but we have to
> carry the changes for a long time.
> Similar changes will only grow over time causing a lot of custom
> configs that are not enabled by default.
D1 could still use generic Image. The reason why I send the standard
implementation of svpbmt is that when we introduce svpbmt, we actually
introduce the page attribute frameworks for different platforms(svpbmt
& non-svpbmt). Then, "custom svpbmt" can also modify "protect_mapp []"
and svpbmt [] "in errata by limited codes from vendor.
If we support standard svpbmt first, then let "generic Image" support
D1 would be very little modification and all could be kept in errata.

Another patch [1] cleans up the wrong usage of "protect_map []" so
that the entire Linux user state page attributes come from it. The
design principle of Linux is to allow the platform to init
"protect_map []" flexibly.
[1]: https://lore.kernel.org/all/20210927064340.2411397-1-guoren@kernel.org=
/

>
> IMHO, if we want to support this board in upstream, we should just
> clearly state that it is one time special exception
> for this board only because of the following reasons
>
> 1. The board design predates the patch acceptance policy.
D1 is designed at 2019.

> 2. We don't have enough affordable Linux compatible platforms today.
D1 only  $65.

> 3. Allowing running an upstream kernel on D1 helps the RISC-V software
> ecosystem to grow.
Yes

>
> No more exceptions will be allowed in future for such hardware that
> violates the spec. Period.
>
> > Regards,
> > Anup
>
>
>
> --
> Regards,
> Atish



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
