Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AF241AC2E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbhI1JrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240000AbhI1JrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:47:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C9DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:45:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d207-20020a1c1dd8000000b00307e2d1ec1aso2237159wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NpdgeAZE/2JJ8QTB4I+A3zPOkF3A5OHzdZD2Ya/kiJo=;
        b=i2IZPEpAj9GVvkEurJnnx3+k7W2Jnzo8UJ1dMWzQ6eudHfwFSXfKL1WxaG0U6qdbRn
         w/CHf5mVcsjJkYKHdyCbBLGEq0s6AwvIKX26WFoHfoEb5B8ta6P2eJS7Fp/R1Wpk8JIY
         QJB2+IzhRoCaC0P5/nqNKoLcVxrDoI6J8Xy/dj12YBZFgMNj9aP9K1VTIA/q6D8Rb3Ob
         tEGVSinY/kU4XwhtyV1fUlF838oO6yJZI7zYyU5IjP4mHfoW6rd44T9SEL+hy7X3wz/q
         d+P8kMq3eHps14Xi2fuqyEjZsARReiEUVcz56eLD3HTQlscvFt3GxfH6OH3YKqrlB6wH
         UJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NpdgeAZE/2JJ8QTB4I+A3zPOkF3A5OHzdZD2Ya/kiJo=;
        b=Bu3J9kKejbsg37TYRkfQg0ESz4nvcrWzB4S0uJgegRCiNBg4tanX5gJfYSx4iUBKLr
         21znftSRUd2YjQKEPx/vfle2BV10I6kvjB9ZqORkumiBfGklV61oedstaBdw6j77uERi
         UO381kTQHJPgaTflnuOnRkjNt01RkJkrPBAZRwq4PVpXOLH/Bli3/eiWJwNJhVFcQ1co
         v2blumigefIZ99ARQyFjM1CwRr6Nz9fT93/kEBOspC4CTCtMPhGTwrzmCoRmdGNXEwK6
         hCJZm7QoA4uEhC0T0GvttyE7yGJ9JJhnfax9U1vppOREIKs89BWha/MqNciHwTGh0J7N
         5FYg==
X-Gm-Message-State: AOAM5304geOKdWhlqFavL8X0AqaGow9sOG+t/dDeV+/r8SL0KfVHcOZq
        GXsvlPEt9fGf/cNrRyS1+S+wJeq7cC9iqmArrvYTuw==
X-Google-Smtp-Source: ABdhPJyxl9YA7ldXa+HKq5qrAL7hFQ10SkpTKprQJ9OmzU3FO+gJY3QCdkT3sgf4vE5ySZO6ORk5Q+HYv5Yt4j84rmU=
X-Received: by 2002:a1c:7d0f:: with SMTP id y15mr3673092wmc.41.1632822336266;
 Tue, 28 Sep 2021 02:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172107.1117604-1-guoren@kernel.org> <CAOnJCUJWnDB+uRxDh=YSbGW4bf5RQvke03iCTYMYHPsw3cwnHQ@mail.gmail.com>
 <CAOnJCULrE595ex3gBTnu4GnPazO4mg8Tkrtbv6j8iLWe+sKJSA@mail.gmail.com>
 <CA+Qh7T=kud8AM-6JjuWNwJY0r_gkmnP6SmzVXqeE2VYxViLUoQ@mail.gmail.com> <CAOnJCUJp9UatyReA8-Jq=WGY_QgV4CbL4Qs2F9rXJzOHsXeW5Q@mail.gmail.com>
In-Reply-To: <CAOnJCUJp9UatyReA8-Jq=WGY_QgV4CbL4Qs2F9rXJzOHsXeW5Q@mail.gmail.com>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Tue, 28 Sep 2021 11:45:25 +0200
Message-ID: <CAAeLtUDpHDoOKJLvjct7SexoEtFckHDoeEsLS72xOQ4JWJAUaA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] riscv: Add RISC-V svpbmt extension
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Greg Favor <gfavor@ventanamicro.com>, Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sept 2021 at 01:05, Atish Patra <atishp@atishpatra.org> wrote:
>
> On Mon, Sep 27, 2021 at 1:53 PM Greg Favor <gfavor@ventanamicro.com> wrot=
e:
> >
> > With the big caveat that I haven't been in the middle of this discussio=
n, it seems like Allwinner D1's changes represent a custom (and nonconformi=
ng) extension.
>
> As per the v1.12 privilege specification, bit 63 is reserved for
> Svnapot extension while bit 60=E2=80=9354 are reserved for future standar=
d
> use.
> D1's implementation uses both 60 and 63 bit for their custom "PBMT"
> extension in addition to bit 61 & 62 [1].
>
> > Isn't this just a matter of the patch needing to be treated as for a RI=
SC-V custom extension per the recently clarified policy for handling upstre=
aming/etc. of custom extensions?  (Philipp can > speak to this clarified po=
licy.)  Or what am I missing?
>
> Linux kernel upstream policy is yet to adopt that clarification as it
> was recently discussed at RVI meetings. Is there a written definition
> of non-conforming/custom/incompatible ?
> Moreover, as per the platform specification[2],
>
> A non-conforming extension that conflicts with a supported standard
> extensions must satisfy at least one of the following:
>   --- It must be disabled by default.
>   --- The supported standard extension must be declared as unsupported
> in all feature discovery structures used by software.
>       This option is allowed only if the standard extension is not requir=
ed.

The terminology for those cases (and x-thead-v is the mental
test-case) would be "non-compliant and non-conflicting".
The "non-compliant" part comes from the fact that the specification
has been violated: in the case of x-thead-v by using the reserved
opcode space, in the case of the PTEs by using reserved bits.
The "non-conflicting" is based on a system still being able to operate
according to the specification, even if the non-compliant extension is
simply ignored (e.g. RVV is not mandatory and the opcodes for RVV are
not required to raise illegal insn exceptions, so these systems would
simply appear as not having RVV)=E2=80=A6

Now, with their "custom" PBMT, we are pushing the boundaries of the
'non-conflicting' definition but are still within the same reasoning:
if we only signal sv39 and no PBMT-support, then the abuse of the PTE
bits does not conflict.  In the end, the 'non-conflicting' status will
hinge on whether we make svpbmt mandatory in the Platform (or the
referenced Profile).

In this particular case =E2=80=94 given the importance of the D1 boards for
bootstrapping the software ecosystem =E2=80=94 I would make the case that w=
e
need to provide a provision in the Platforms (i.e. OS-A base) to
retain the 'non-conflicting' status (e.g. by mandating "some pbmt" =E2=80=
=94
with an application note stating that this will be restricted to
svpbmt in the next major revision of the Platforms ... and already
restricting it to svpbmt for the OS-A server extension).

> In this case, the custom non-conforming implementation can not be
> disabled or marked unsupported as it is critical for all the necessary
> I/O devices (usb, mmc, ethernet).
> Without this custom implementation support in upstream, we can not
> really use the mainline kernel for Allwinner D1.

I don't agree from a specification standpoint and from the
'non-conflicting' standpoint: whether or not device drivers can be
used, does not change the 'non-conflicting' status.
This is similar to the 'non-conflicting' status with x-thead-v: vector
instructions (as in "the standard RVV instructions") also can't be
used with a toolchain/libraries/OS that only implements RVV ... but
nonetheless, vendor-specific vector instructions are available.

I would argue the same for Alibaba's PBMT: I/O devices will not work,
unless a vendor-specific non-conflicting PBMT is used.

The brings us back to the requirements that I defined multiple times
for this: the implementation needs to be properly modularized and
quarantined as to not adversely impact compliant implementations.
If this can be assured, I will always argue for inclusion based on the
benefit to the ecosystem and reconciling the imminent fragmentation.
Or in other words: In what world does it make sense to encourage a
vendor of a board with significant market share to create a
vendor-fork of the kernel, if that vendor is willing to work with the
upstream?  Note that I normally am the first to argue on principle,
but have come to the conclusion that we are really between a rock and
a hard place on this one =E2=80=94 and my priority is to keep the ecosystem
from fragmenting.

>> >> > We need to decide whether we should support the upstream kernel for=
 D1. Few things to consider.
> >> > =E2=80=93 Can it be considered as an errata ?
> >> > =E2=80=93 Does it set a bad precedent and open can of worms in futur=
e ?
> >> > =E2=80=93 Can we just ignore D1 given the mass volume ?
> >> >
> >> > One solution I can think of is that we allow this as an exception to=
 the patch acceptance policy.
> >> > We need to explicitly specify this board as an exception because the=
 policy was not in place during the design phase of the hardware.
> >> > At least, it protects us from accepting the incompatible changes in =
the future. Any other ideas ?

Anything we do needs to consider future impact and precedent.  But
that should not preclude us from making an exception, when it benefits
the ecosystem by preventing further fragmentation.
I consider the stated requirements of proper modularization
(quarantining the impact within the code base) and a precondition on
the vendor maintaining the changes, as a strong-enough discouragement
for any parties that might also consider to apply gross negligence to
the meaning of 'reserved'.

Philipp.
