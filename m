Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927CD41A633
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 05:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbhI1DwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 23:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbhI1DwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 23:52:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE18BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 20:50:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g16so55485117wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 20:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GGTQElJtl5mpUB6QPkkm10aMhOfJ7ChPo3DKsQZG/IM=;
        b=4aWrxSP5DQIFQrbo7iVY+qyKl54ratZ5R+7yXw+fPvYcfNqzMl3s23B/z5fi6lRMtd
         vTolleMK8gGQ4xj/0he5l4aSkQ0H0ADrEYwH3H5NzAYGolhhk/aGH+rvA8+rpQ8PFpj8
         8qM//UJieTlE4u4+M8R/VftCz66yydY211gYotIjtuYPlZs20/3sAuiIFRcSk26dfUon
         KILFOsFkep1l5Traig1MFsXSR1KlCkQgHIFpyAFg2zbHKDzQdwtTju2/9Y2L/QafDH7D
         199sh+G7yNaZO1CaDeQFs6+9ZxvXWvku/Fip17hsOiRlEuBaJ7N0+j8nRMs/yFGoKhao
         dMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GGTQElJtl5mpUB6QPkkm10aMhOfJ7ChPo3DKsQZG/IM=;
        b=l6CuCbSHBYAc/mBd56MdBFF9bfc43FjHYPoOjsu6LGBRCH5Wmz1/8PfBqUknEmTJ/1
         KHGOSK3DQO19VyjStsuIYmqig0Wjk1NMY1LExaULNFSPwhMMxBX0KDRCzYxU6mTAwhYN
         eF0dW8/W61y5pjVqtuuV4Eak9H+cb7e6loUY6YzyXcW05q3K0BjOYM4zA5DP/h5LzRmc
         icbOvflLcDFyJPPWt/rO4Hqm8HMMJjfaG3TwqhR++d7ddMA1yI/6e9peec4Exi3d+lKy
         Ml9kuMtXH0Uu1ecbPbt6iboF326wBI7+nfPjuiVxNBp+JVG/3s1VGrxQlORLX3DbHdwm
         WExg==
X-Gm-Message-State: AOAM531y4lGOh3wr+sdmGbQ7xlprbjra/i8Fywxy/A+j9LWTMzbAtu89
        FW3VGxOgxPM3LkV17Gr+4B1+SMQ+MKjfUlUvOha1hg==
X-Google-Smtp-Source: ABdhPJwnzhJ7dz9dy7GqwipLDzQCfNNWTpOdzNdjAj6Zbro5+DmRqN7N0viMMGaHqBhkAtmFU5ZygFM7uTlEHTwVlUY=
X-Received: by 2002:adf:e387:: with SMTP id e7mr3941847wrm.199.1632801029905;
 Mon, 27 Sep 2021 20:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172107.1117604-1-guoren@kernel.org> <CAOnJCUJWnDB+uRxDh=YSbGW4bf5RQvke03iCTYMYHPsw3cwnHQ@mail.gmail.com>
 <CAOnJCULrE595ex3gBTnu4GnPazO4mg8Tkrtbv6j8iLWe+sKJSA@mail.gmail.com> <0790abcfa1174e0e9b5e7b185f87ced9@mailhost.ics.forth.gr>
In-Reply-To: <0790abcfa1174e0e9b5e7b185f87ced9@mailhost.ics.forth.gr>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 28 Sep 2021 09:20:18 +0530
Message-ID: <CAAhSdy2-y4xpM9PCrS0vgCN9ngFiBygeDOWcbgsX6Myb4XjDQg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] riscv: Add RISC-V svpbmt extension
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Atish Patra <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>,
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

On Tue, Sep 28, 2021 at 6:32 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-09-27 23:13, Atish Patra =CE=AD=CE=B3=CF=81=
=CE=B1=CF=88=CE=B5:
> >> We need to decide whether we should support the upstream kernel for
> >> D1. Few things to consider.
> >> =E2=80=93 Can it be considered as an errata ?
>
> It's one thing to follow the spec and have an error in the
> implementation, and another to not follow the spec.
>
> >> =E2=80=93 Does it set a bad precedent and open can of worms in future =
?
>
> IMHO yes, I'm thinking of Kendryte 210 devs for example coming up and
> asking for MMU support, they 've also shipped many chips already. I can
> also imagine other vendors in the future coming up with implementations
> that violate the spec in which case handling the standard stuff will
> become messy and complex, and hurt performance/security. We'll end up
> filling the code with exceptions and tweaks all over the place. We need
> to be strict about what is "riscv" and what's "draft riscv" or "riscv
> inspired", and what we are willing to support upstream. I can understand
> supporting vendor extensions upstream but they need to fit within the
> standard spec, we can't have for example extensions that use encoding
> space/csrs/fields etc reserved for standard use, they may only use
> what's reserved for custom/vendor use. At least let's agree on that.

Totally agree with Nick here. It's a slippery slope.

Including D1 PTE bits (or Kendryte K210 MMU) part of the Linux RISC-V
means future hardware which intentionally violates specs will also have to
be merged and the RISC-V patch acceptance policy will have no significance.

>
> >> =E2=80=93 Can we just ignore D1 given the mass volume ?
> >>
>
> IMHO no, we need to find a way to support it upstream but I believe
> there is another question to answer:
>
> Do we also guarantee "one image to rule them all" approach, required by
> binary distros, for implementations that violate the spec ? Are we ok
> for example to support Allwinner D1 upstream but require a custom
> configuration/build instead of supporting it with the "generic" image ?
> In one case we need to handle the violation at runtime and introduce
> overhead for everyone (like looking up __riscv_svpbmt every time we set
> a PTE in this case), in the other it's an #ifdef.

At least, we should not have hardware violating specs as part of the
unified kernel image instead have these intentional deviations/violations
under separate kconfig which will not be enabled by default. This means
vendors (of such hardware) and distros will have to explicitly enable
support for such violations/deviations.

Regards,
Anup
