Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9841B113
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbhI1Ns3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhI1Ns2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:48:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510E1C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:46:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s21so18136261wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hMYwlg56M+Uatn8in7lzm9hDiMWb8QWY766EJQqjXt8=;
        b=3oDkN0xNj99wgSCVvL3+63fRcvn211dF1vO+UkFmsxWilZf/0/5RkIuHFdP7CQOGZ3
         Rr6qvizr6O33WeDjIaPBQG2BEdPsk7dFmP9bP+LnCjFjIe+mvEz6wjIerUfplSxe0KZq
         zc+LpEIej68/zv3msxQwBJGuwIxaJkaS/a0+fiw8AWKsW7nWLnID7TCCz/2u5PSS0/1M
         rQ3ZlbEgk1MU+ds0FkuhTcsw5ZXmMVOa6RrrLNYK3btGNmTsZet4VA1BBGpTsZV6yvD9
         UyKqCGQw20NmEOpaFvojWFoJaPwwu21dYjWPrbi1zvfOVusGBNjvmfLb7ndIkd+2PVPz
         H6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hMYwlg56M+Uatn8in7lzm9hDiMWb8QWY766EJQqjXt8=;
        b=p4KDloEMZTXdtdlZBbp2J7Da7BRNEtJLwimLomAM35FWJTEnX12RtCJjI1qCqUhvRm
         Q7Yfi5HSETIWI7tsmyvSaWRLCW2OcXv144uEJ81s4vpD5Yt5r7VjWScFFefpnRHLU/Ci
         Tcu/7y4SP/Ya2Fry8kpXSbjH5P+Mcd9CXJw2CyQbuL0PapnNSEL+zIBjm7XhDvKtJg5y
         /KG8hH8tMKajkSGw64+p7KDnxjpPjJNnUZ/RvKogD97TgaP9Gvbmln1wF5itfmT2kMy0
         cW37LbTKt6JNCdd+F5AaLLhwyty92HZaP3U419aabsQdp4quD/FqKwDPgDrA6VsPo6ID
         Zaxw==
X-Gm-Message-State: AOAM532G63eF55SipQh2twfw0ul0V4hKQ+TK/Kw912aj7TZbNLyDCrLf
        n9aSV3XTxODPofEYJouXpHlJf6J6cgz/jk7hJk3SFw==
X-Google-Smtp-Source: ABdhPJyLXXG3QFfhqmQbaMtaZf2urVuCmdoxlwYRrnmfrOjcUHh2PAXTLs30Ec3gtLaYjOQyjL5Rt1fX0LW8nc5RwZI=
X-Received: by 2002:a5d:6545:: with SMTP id z5mr127222wrv.90.1632836806783;
 Tue, 28 Sep 2021 06:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172107.1117604-1-guoren@kernel.org> <CAOnJCUJWnDB+uRxDh=YSbGW4bf5RQvke03iCTYMYHPsw3cwnHQ@mail.gmail.com>
 <CAOnJCULrE595ex3gBTnu4GnPazO4mg8Tkrtbv6j8iLWe+sKJSA@mail.gmail.com>
 <0790abcfa1174e0e9b5e7b185f87ced9@mailhost.ics.forth.gr> <CAAhSdy2-y4xpM9PCrS0vgCN9ngFiBygeDOWcbgsX6Myb4XjDQg@mail.gmail.com>
 <CAOnJCULg36kNiDV6ymTSRff8yYZvFKpxm5uh=cAicQT44OcLYw@mail.gmail.com> <ad40c335-ee8f-9ff3-4c34-f8fa5ef49e8b@ics.forth.gr>
In-Reply-To: <ad40c335-ee8f-9ff3-4c34-f8fa5ef49e8b@ics.forth.gr>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Tue, 28 Sep 2021 15:46:32 +0200
Message-ID: <CAAeLtUBn=WXmp4Ur+7Vg8DgKDVsK8xiiL4ukw_1EDR6tDUoftA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] riscv: Add RISC-V svpbmt extension
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
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

Nick,

On Tue, 28 Sept 2021 at 15:19, Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> On 9/28/21 7:26 AM, Atish Patra wrote:
> > On Mon, Sep 27, 2021 at 8:50 PM Anup Patel <anup@brainfault.org> wrote:
> >>
> >> On Tue, Sep 28, 2021 at 6:32 AM Nick Kossifidis <mick@ics.forth.gr> wr=
ote:
> >>>
> >>> =CE=A3=CF=84=CE=B9=CF=82 2021-09-27 23:13, Atish Patra =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:
> >>>>> We need to decide whether we should support the upstream kernel for
> >>>>> D1. Few things to consider.
> >>>>> =E2=80=93 Can it be considered as an errata ?
> >>>
> >>> It's one thing to follow the spec and have an error in the
> >>> implementation, and another to not follow the spec.
> >>>
> >>>>> =E2=80=93 Does it set a bad precedent and open can of worms in futu=
re ?
> >>>
> >>> IMHO yes, I'm thinking of Kendryte 210 devs for example coming up and
> >>> asking for MMU support, they 've also shipped many chips already. I c=
an
> >>> also imagine other vendors in the future coming up with implementatio=
ns
> >>> that violate the spec in which case handling the standard stuff will
> >>> become messy and complex, and hurt performance/security. We'll end up
> >>> filling the code with exceptions and tweaks all over the place. We ne=
ed
> >>> to be strict about what is "riscv" and what's "draft riscv" or "riscv
> >>> inspired", and what we are willing to support upstream. I can underst=
and
> >>> supporting vendor extensions upstream but they need to fit within the
> >>> standard spec, we can't have for example extensions that use encoding
> >>> space/csrs/fields etc reserved for standard use, they may only use
> >>> what's reserved for custom/vendor use. At least let's agree on that.
> >>
> >> Totally agree with Nick here. It's a slippery slope.
> >>
> >> Including D1 PTE bits (or Kendryte K210 MMU) part of the Linux RISC-V
> >> means future hardware which intentionally violates specs will also hav=
e to
> >> be merged and the RISC-V patch acceptance policy will have no signific=
ance.
> >>
> >>>
> >>>>> =E2=80=93 Can we just ignore D1 given the mass volume ?
> >>>>>
> >>>
> >>> IMHO no, we need to find a way to support it upstream but I believe
> >>> there is another question to answer:
> >>>
> >>> Do we also guarantee "one image to rule them all" approach, required =
by
> >>> binary distros, for implementations that violate the spec ? Are we ok
> >>> for example to support Allwinner D1 upstream but require a custom
> >>> configuration/build instead of supporting it with the "generic" image=
 ?
> >>> In one case we need to handle the violation at runtime and introduce
> >>> overhead for everyone (like looking up __riscv_svpbmt every time we s=
et
> >>> a PTE in this case), in the other it's an #ifdef.
> >>
> >> At least, we should not have hardware violating specs as part of the
> >> unified kernel image instead have these intentional deviations/violati=
ons
> >> under separate kconfig which will not be enabled by default. This mean=
s
> >> vendors (of such hardware) and distros will have to explicitly enable
> >> support for such violations/deviations.
> >>
> >
> > If we merge the code and are not enabled by default, it would be a
> > maintenance nightmare in future.
> > These part of the kernel will not be regularly tested but we have to
> > carry the changes for a long time.
>
> I don't see a difference between having these features as part of the
> generic image vs having them as custom configs/builds. The code will get
> executed only on boards that support the custom/non-compliant
> implementation anyway. To the contrary we'll have more code to test if
> we are doing things at runtime vs at compile time.
>
> > Similar changes will only grow over time causing a lot of custom
> > configs that are not enabled by default.
> >
>
> We'll have a lot of custom configs that will only get used on boards
> that use them, vs runtime code that will run for no reason on every
> board and choose the default/standard-compliant implementation most of
> the time. In the end the code will only get tested on specific hardware
> anyway.
>
> > IMHO, if we want to support this board in upstream, we should just
> > clearly state that it is one time special exception
> > for this board only because of the following reasons
> >
> > 1. The board design predates the patch acceptance policy.
> > 2. We don't have enough affordable Linux compatible platforms today.
> > 3. Allowing running an upstream kernel on D1 helps the RISC-V software
> > ecosystem to grow.
> >
>
> The same can be said for Kendryte as well, are we willing to also
> support their MMU implementation on the generic image if a patch comes
> in? To be clear I'm not saying we shouldn't support D1 or Kendryte
> upstream, I'm just saying that we shouldn't sacrifice the complexity and
> performance of the code path for standard-compliant implementations, to
> support non-compliant implementations, and instead support non-compliant
> implementations with custom kernel builds using compile time options. It

For priming the pump on the software effort, having a solution that is enab=
led
on distro-builds is clearly preferable =E2=80=94 that leads to the solution=
 that Palmer
had outlined at LPC, which is to have a KCONFIG option that enables the
alternate code paths and can be turned off for embedded use-cases.

> still counts as upstream support, they won't have to maintain their own
> forks. It'll also allow custom implementations to have more flexibility
> on what they can do since they will be able to use completely
> different/custom code paths, instead of trying to fit in the standard
> code path (which will become a mess over time). I think this approach is
> much more flexible and will allow more customizations to be supported
> upstream in the future.

The important detail will be the ground rules: changes have to be sufficien=
tly
quarantined that (a) they can be turned off, (b) can be reverted easily (in=
 case
that vendors fail to perform their maintenance obligations), and (c) they d=
on't
affect the performance and complexity of the standard code paths.

Cheers,
Philipp.
