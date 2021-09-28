Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3506A41B276
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbhI1PAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:00:50 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41696
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241371AbhI1PAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:00:46 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 67D54402F0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632841143;
        bh=g6a7xv0xqYvnK76VH1tylZcfdtAggOaJwHiB19FiKPk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=HisHDcrUzU91Pwvj0LyFUM6FETRi+bh7NuW/3w8W/Cke8sxaLxNOsgOPmIKNBvjbL
         wPaIKf6ah6cBE8dVhyABRhOdOkzmX4qVmVljnquMIRVMxZpMqg4W4dVsZTVK+tzYp/
         x3yiiBwyfohSdQkEq6w/1rrbwY5eEURUJ6YtLW7Y+I0LiteuKFcg1MZ8IntLHdwOtq
         EDwTQLaa2m964tM3By1BZ20T93ms2SGRI2EH70NLzvmzcnk8Db/GZpJkTKUVv/gHZK
         IafKc6G21x1KaERxIh/OWM4eVO4P7Ph/vd93Tsz9y6cnbHyg3B5R2Iftj2d0mH5BHo
         K42lt0e8T4k/A==
Received: by mail-ed1-f69.google.com with SMTP id s12-20020a05640217cc00b003cde58450f1so22240956edy.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g6a7xv0xqYvnK76VH1tylZcfdtAggOaJwHiB19FiKPk=;
        b=uf5i7lJ0kEje+fmg1SXVmpB5SPnLE+sPs8sGnbc850nJS8qMGuexR9ybAsaA8TJjiN
         YL8Dv+FAVdRMFZiCog6fhsaBdhZXwHn6LCiZm0Rplb+Q//5OuyDwHWtmCmUsncnOAChp
         IgCgN8VlWiF75hG5TBgZOMFVnXa4vQE/5a6W6ats3RGNth2VPzrZpHHSYF37CQ/uAFam
         D/z/PtS9saLo9bq4aTN42hAzQ1IWwLN4dFK6eSdTadFx8aYbZxdVL0qEzMFWip8Piyfs
         zbdlEXLDPxvvktQ5ot82kBJ3WUsbCgEzxyduKq8W9g0Z1ZTD6PJSmioQuJH4i8AFhkIZ
         7s5g==
X-Gm-Message-State: AOAM532nvyihRmPyYDskYNgU8NVEfWNdidH/O65bY5XyxwBydjWDn5Mu
        sMal+KNjuwmYtiykKEYus9bpxuUNDtrsh14EKkmw85tWBIoIg5epRr/Cnt3mF9LEEuIOHvAt276
        2L5O3eSd4VnSpu1/PrGPhNcBjmKZcS9qx4w2EDH5h9L9uBba1/6m/rv3+5A==
X-Received: by 2002:a17:907:2090:: with SMTP id pv16mr6104092ejb.156.1632841142956;
        Tue, 28 Sep 2021 07:59:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb7dk2zpfUDJWU60w07G3nZqzH6RPURAItRu5XoTm2AssdQ9aQtejza93BvvpSwe7KzFU5kG1Gdf13XV9bIQQ=
X-Received: by 2002:a17:907:2090:: with SMTP id pv16mr6104067ejb.156.1632841142712;
 Tue, 28 Sep 2021 07:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172107.1117604-1-guoren@kernel.org> <CAOnJCUJWnDB+uRxDh=YSbGW4bf5RQvke03iCTYMYHPsw3cwnHQ@mail.gmail.com>
 <CAOnJCULrE595ex3gBTnu4GnPazO4mg8Tkrtbv6j8iLWe+sKJSA@mail.gmail.com>
 <0790abcfa1174e0e9b5e7b185f87ced9@mailhost.ics.forth.gr> <CAAhSdy2-y4xpM9PCrS0vgCN9ngFiBygeDOWcbgsX6Myb4XjDQg@mail.gmail.com>
 <CAOnJCULg36kNiDV6ymTSRff8yYZvFKpxm5uh=cAicQT44OcLYw@mail.gmail.com>
 <ad40c335-ee8f-9ff3-4c34-f8fa5ef49e8b@ics.forth.gr> <CAAeLtUBn=WXmp4Ur+7Vg8DgKDVsK8xiiL4ukw_1EDR6tDUoftA@mail.gmail.com>
In-Reply-To: <CAAeLtUBn=WXmp4Ur+7Vg8DgKDVsK8xiiL4ukw_1EDR6tDUoftA@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Tue, 28 Sep 2021 16:58:51 +0200
Message-ID: <CA+zEjCuaxtD8P1CwD25kfNFGFr+nZJt7k+=P8ck5NvLNNgTttw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] riscv: Add RISC-V svpbmt extension
To:     Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Atish Patra <atishp@atishpatra.org>,
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
        Taiten Peng <taiten.peng@canonical.com>,
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

On Tue, Sep 28, 2021 at 3:48 PM Philipp Tomsich
<philipp.tomsich@vrull.eu> wrote:
>
> Nick,
>
> On Tue, 28 Sept 2021 at 15:19, Nick Kossifidis <mick@ics.forth.gr> wrote:
> >
> > On 9/28/21 7:26 AM, Atish Patra wrote:
> > > On Mon, Sep 27, 2021 at 8:50 PM Anup Patel <anup@brainfault.org> wrot=
e:
> > >>
> > >> On Tue, Sep 28, 2021 at 6:32 AM Nick Kossifidis <mick@ics.forth.gr> =
wrote:
> > >>>
> > >>> =CE=A3=CF=84=CE=B9=CF=82 2021-09-27 23:13, Atish Patra =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:
> > >>>>> We need to decide whether we should support the upstream kernel f=
or
> > >>>>> D1. Few things to consider.
> > >>>>> =E2=80=93 Can it be considered as an errata ?
> > >>>
> > >>> It's one thing to follow the spec and have an error in the
> > >>> implementation, and another to not follow the spec.
> > >>>
> > >>>>> =E2=80=93 Does it set a bad precedent and open can of worms in fu=
ture ?
> > >>>
> > >>> IMHO yes, I'm thinking of Kendryte 210 devs for example coming up a=
nd
> > >>> asking for MMU support, they 've also shipped many chips already. I=
 can
> > >>> also imagine other vendors in the future coming up with implementat=
ions
> > >>> that violate the spec in which case handling the standard stuff wil=
l
> > >>> become messy and complex, and hurt performance/security. We'll end =
up
> > >>> filling the code with exceptions and tweaks all over the place. We =
need
> > >>> to be strict about what is "riscv" and what's "draft riscv" or "ris=
cv
> > >>> inspired", and what we are willing to support upstream. I can under=
stand
> > >>> supporting vendor extensions upstream but they need to fit within t=
he
> > >>> standard spec, we can't have for example extensions that use encodi=
ng
> > >>> space/csrs/fields etc reserved for standard use, they may only use
> > >>> what's reserved for custom/vendor use. At least let's agree on that=
.
> > >>
> > >> Totally agree with Nick here. It's a slippery slope.
> > >>
> > >> Including D1 PTE bits (or Kendryte K210 MMU) part of the Linux RISC-=
V
> > >> means future hardware which intentionally violates specs will also h=
ave to
> > >> be merged and the RISC-V patch acceptance policy will have no signif=
icance.
> > >>
> > >>>
> > >>>>> =E2=80=93 Can we just ignore D1 given the mass volume ?
> > >>>>>
> > >>>
> > >>> IMHO no, we need to find a way to support it upstream but I believe
> > >>> there is another question to answer:
> > >>>
> > >>> Do we also guarantee "one image to rule them all" approach, require=
d by
> > >>> binary distros, for implementations that violate the spec ? Are we =
ok
> > >>> for example to support Allwinner D1 upstream but require a custom
> > >>> configuration/build instead of supporting it with the "generic" ima=
ge ?
> > >>> In one case we need to handle the violation at runtime and introduc=
e
> > >>> overhead for everyone (like looking up __riscv_svpbmt every time we=
 set
> > >>> a PTE in this case), in the other it's an #ifdef.
> > >>
> > >> At least, we should not have hardware violating specs as part of the
> > >> unified kernel image instead have these intentional deviations/viola=
tions
> > >> under separate kconfig which will not be enabled by default. This me=
ans
> > >> vendors (of such hardware) and distros will have to explicitly enabl=
e
> > >> support for such violations/deviations.
> > >>
> > >
> > > If we merge the code and are not enabled by default, it would be a
> > > maintenance nightmare in future.
> > > These part of the kernel will not be regularly tested but we have to
> > > carry the changes for a long time.
> >
> > I don't see a difference between having these features as part of the
> > generic image vs having them as custom configs/builds. The code will ge=
t
> > executed only on boards that support the custom/non-compliant
> > implementation anyway. To the contrary we'll have more code to test if
> > we are doing things at runtime vs at compile time.
> >
> > > Similar changes will only grow over time causing a lot of custom
> > > configs that are not enabled by default.
> > >
> >
> > We'll have a lot of custom configs that will only get used on boards
> > that use them, vs runtime code that will run for no reason on every
> > board and choose the default/standard-compliant implementation most of
> > the time. In the end the code will only get tested on specific hardware
> > anyway.
> >
> > > IMHO, if we want to support this board in upstream, we should just
> > > clearly state that it is one time special exception
> > > for this board only because of the following reasons
> > >
> > > 1. The board design predates the patch acceptance policy.
> > > 2. We don't have enough affordable Linux compatible platforms today.
> > > 3. Allowing running an upstream kernel on D1 helps the RISC-V softwar=
e
> > > ecosystem to grow.
> > >
> >
> > The same can be said for Kendryte as well, are we willing to also
> > support their MMU implementation on the generic image if a patch comes
> > in? To be clear I'm not saying we shouldn't support D1 or Kendryte
> > upstream, I'm just saying that we shouldn't sacrifice the complexity an=
d
> > performance of the code path for standard-compliant implementations, to
> > support non-compliant implementations, and instead support non-complian=
t
> > implementations with custom kernel builds using compile time options. I=
t
>
> For priming the pump on the software effort, having a solution that is en=
abled
> on distro-builds is clearly preferable =E2=80=94 that leads to the soluti=
on that Palmer
> had outlined at LPC, which is to have a KCONFIG option that enables the
> alternate code paths and can be turned off for embedded use-cases.
>
> > still counts as upstream support, they won't have to maintain their own
> > forks. It'll also allow custom implementations to have more flexibility
> > on what they can do since they will be able to use completely
> > different/custom code paths, instead of trying to fit in the standard
> > code path (which will become a mess over time). I think this approach i=
s
> > much more flexible and will allow more customizations to be supported
> > upstream in the future.
>
> The important detail will be the ground rules: changes have to be suffici=
ently
> quarantined that (a) they can be turned off, (b) can be reverted easily (=
in case
> that vendors fail to perform their maintenance obligations),

Can we really remove support once it is in and widely used?

> and (c) they don't
> affect the performance and complexity of the standard code paths.
>
> Cheers,
> Philipp.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
