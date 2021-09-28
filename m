Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDB641A69C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 06:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbhI1E2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 00:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhI1E2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 00:28:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED65C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 21:26:41 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id f133so28908009yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 21:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=noe4hEAkbPLyBzwsLG+b+9dUQ25Iugn4/xpnSPeZAuc=;
        b=ctUHytmLgvRhUr64u9ZUvPYMirmLeEo1ceE54uHVxga0Zp6hfDZbpNOZ4ZA8yG8XMb
         YTsiXQjRH0z+TyECxxbOC1j9RFukaCdUqocVlR9iid9GQFLLRnwAJh2fm1l8OmZgXX13
         0nqxEZAgpo7qOvaXxuECxOW2w2IGzdLEG/yPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=noe4hEAkbPLyBzwsLG+b+9dUQ25Iugn4/xpnSPeZAuc=;
        b=EPPKDbbsNG9Z/qicbLuJANEk/fYSNLECdtXVk0HHA78dKrQYCW63IbRDu0EEm9I6JU
         EW+pBfM7jlixnWbj7yWOWrEkbHWtRGg3khdZ3qKPV+SvZqb5jhlQe1zHtPHi8Ap9H3TJ
         goTUEmdIcDpubPkbnWNu6RDq3tEAWYrxNuGIOmVPJoy0VYLH6t1HE77VpN3tEGDQyqk6
         AjnWDwCEPt0QX05B0jiRSiokngtlS0nsN8GECURSzjB6HqujY4dPUj61Kl/3clwzSagI
         Dmwva9DrPn5I9zqs6jgAwT+VshTqrWR1MONHPz17TkjURPC0NPxKTYG76hOHVf9mTnoH
         7VdQ==
X-Gm-Message-State: AOAM532mH1zWKU2CwcmOQOsOOs4Rh6aEFgv42d/z2M93Sb81zajkvOMT
        UjHPIMEZV7klHQdhud+UvbwqF83v/lKe7+63tv0c
X-Google-Smtp-Source: ABdhPJyJGMnHW02KO4TptssE4KBJfrgM81CuyWAoWSwb2Hm4Gq9MtUrqECYDOf2ICR3oGYkoyn14YeEGc75+Z/OeWis=
X-Received: by 2002:a5b:2d2:: with SMTP id h18mr4411546ybp.526.1632803200399;
 Mon, 27 Sep 2021 21:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172107.1117604-1-guoren@kernel.org> <CAOnJCUJWnDB+uRxDh=YSbGW4bf5RQvke03iCTYMYHPsw3cwnHQ@mail.gmail.com>
 <CAOnJCULrE595ex3gBTnu4GnPazO4mg8Tkrtbv6j8iLWe+sKJSA@mail.gmail.com>
 <0790abcfa1174e0e9b5e7b185f87ced9@mailhost.ics.forth.gr> <CAAhSdy2-y4xpM9PCrS0vgCN9ngFiBygeDOWcbgsX6Myb4XjDQg@mail.gmail.com>
In-Reply-To: <CAAhSdy2-y4xpM9PCrS0vgCN9ngFiBygeDOWcbgsX6Myb4XjDQg@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 27 Sep 2021 21:26:29 -0700
Message-ID: <CAOnJCULg36kNiDV6ymTSRff8yYZvFKpxm5uh=cAicQT44OcLYw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] riscv: Add RISC-V svpbmt extension
To:     Anup Patel <anup@brainfault.org>
Cc:     Nick Kossifidis <mick@ics.forth.gr>, Guo Ren <guoren@kernel.org>,
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

On Mon, Sep 27, 2021 at 8:50 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Sep 28, 2021 at 6:32 AM Nick Kossifidis <mick@ics.forth.gr> wrote=
:
> >
> > =CE=A3=CF=84=CE=B9=CF=82 2021-09-27 23:13, Atish Patra =CE=AD=CE=B3=CF=
=81=CE=B1=CF=88=CE=B5:
> > >> We need to decide whether we should support the upstream kernel for
> > >> D1. Few things to consider.
> > >> =E2=80=93 Can it be considered as an errata ?
> >
> > It's one thing to follow the spec and have an error in the
> > implementation, and another to not follow the spec.
> >
> > >> =E2=80=93 Does it set a bad precedent and open can of worms in futur=
e ?
> >
> > IMHO yes, I'm thinking of Kendryte 210 devs for example coming up and
> > asking for MMU support, they 've also shipped many chips already. I can
> > also imagine other vendors in the future coming up with implementations
> > that violate the spec in which case handling the standard stuff will
> > become messy and complex, and hurt performance/security. We'll end up
> > filling the code with exceptions and tweaks all over the place. We need
> > to be strict about what is "riscv" and what's "draft riscv" or "riscv
> > inspired", and what we are willing to support upstream. I can understan=
d
> > supporting vendor extensions upstream but they need to fit within the
> > standard spec, we can't have for example extensions that use encoding
> > space/csrs/fields etc reserved for standard use, they may only use
> > what's reserved for custom/vendor use. At least let's agree on that.
>
> Totally agree with Nick here. It's a slippery slope.
>
> Including D1 PTE bits (or Kendryte K210 MMU) part of the Linux RISC-V
> means future hardware which intentionally violates specs will also have t=
o
> be merged and the RISC-V patch acceptance policy will have no significanc=
e.
>
> >
> > >> =E2=80=93 Can we just ignore D1 given the mass volume ?
> > >>
> >
> > IMHO no, we need to find a way to support it upstream but I believe
> > there is another question to answer:
> >
> > Do we also guarantee "one image to rule them all" approach, required by
> > binary distros, for implementations that violate the spec ? Are we ok
> > for example to support Allwinner D1 upstream but require a custom
> > configuration/build instead of supporting it with the "generic" image ?
> > In one case we need to handle the violation at runtime and introduce
> > overhead for everyone (like looking up __riscv_svpbmt every time we set
> > a PTE in this case), in the other it's an #ifdef.
>
> At least, we should not have hardware violating specs as part of the
> unified kernel image instead have these intentional deviations/violations
> under separate kconfig which will not be enabled by default. This means
> vendors (of such hardware) and distros will have to explicitly enable
> support for such violations/deviations.
>

If we merge the code and are not enabled by default, it would be a
maintenance nightmare in future.
These part of the kernel will not be regularly tested but we have to
carry the changes for a long time.
Similar changes will only grow over time causing a lot of custom
configs that are not enabled by default.

IMHO, if we want to support this board in upstream, we should just
clearly state that it is one time special exception
for this board only because of the following reasons

1. The board design predates the patch acceptance policy.
2. We don't have enough affordable Linux compatible platforms today.
3. Allowing running an upstream kernel on D1 helps the RISC-V software
ecosystem to grow.

No more exceptions will be allowed in future for such hardware that
violates the spec. Period.

> Regards,
> Anup



--=20
Regards,
Atish
