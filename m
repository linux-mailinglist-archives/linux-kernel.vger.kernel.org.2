Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6EA43F6EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhJ2GIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJ2GIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:08:22 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4639EC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:05:54 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a129so8467791yba.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ef7CgH5bstiFbSOUk78qZ1LgQ+HaUKVN7yqdDJbvgJM=;
        b=Lu4P/PB9F9ghzQlQ1gTf3elDPEt0VhIoLYh95RM87su3kRebBW0vq9G4CCKAYPcy6R
         wkQEqfeatb5Rz8ZoPPZqQNjN6n4ggXEmgDcY+rgzkpTnH3K0Lyuja8CkAHIwskQe6tmC
         l+xuWdDlokRksbYia9moXY+odalbngjOHN3oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ef7CgH5bstiFbSOUk78qZ1LgQ+HaUKVN7yqdDJbvgJM=;
        b=wPNnbZ7c06DTr91dEOQxL4yxkk4kw9O+iUgPFm/kh5JMF0xg3Bfk7bI8k9fC4QB7uP
         GCUjGMyu7lXVLfPTVyXII40ZXx14zGmduNejeBBoPEWem3HCTsGW9SfrqVpHrImrtKxt
         AEvnq/igDnzGThE0o8Uxr//gk05jAqEYAUeM/7UAvkdO5U3xYxF9Cr1YFZA9YBKPo5yR
         apgDcJUPGiK7hUnYD4yM0Reg2+wDPS0jo+/uY4jfF8Wu9qo6Yqys/f/2n3ZzgOujaJBR
         MsoVdOhJDPMh4MQQefRd1eJhivqAkVqMAE/10OPPO+tomZdARB1F2r/XmbHtugSdhWtV
         NKcw==
X-Gm-Message-State: AOAM530GqMMWPBlTdDsbOsYN3x89FbWRHtmK/dpAF4war+DFbC+YUEuX
        nhECBy/RPb6YmpF78rCNWQOABcrSksK1v+M3crZv
X-Google-Smtp-Source: ABdhPJyAbwZ9hvTFa/radJfuWMS3aMdr2KxRKeUkW7bQFbqcD1sB+dxag58TbQt8Fx9iY4ymtLyrLQiBHBB94EUg6MQ=
X-Received: by 2002:a25:5341:: with SMTP id h62mr9970718ybb.481.1635487553445;
 Thu, 28 Oct 2021 23:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211025195350.242914-1-atish.patra@wdc.com> <20211025195350.242914-11-atish.patra@wdc.com>
 <YXsMtrmuavGAHk8S@Jessicas-MacBook-Pro.local> <CAOnJCULqwZvK52nczp2HNinDCBjThnbGbvJpAvdameny1fK4Vw@mail.gmail.com>
 <EDB030D6-D37A-43D6-9027-222794FDA80D@jrtc27.com>
In-Reply-To: <EDB030D6-D37A-43D6-9027-222794FDA80D@jrtc27.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 28 Oct 2021 23:05:42 -0700
Message-ID: <CAOnJCUJjzmW=QobLPKAWYGppFeoJXjT2Ee6eG2-H=s2mnei=RQ@mail.gmail.com>
Subject: Re: [v4 10/11] riscv: dts: fu740: Add pmu node
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        devicetree <devicetree@vger.kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 5:07 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On 29 Oct 2021, at 00:37, Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Thu, Oct 28, 2021 at 1:49 PM Jessica Clarke <jrtc27@jrtc27.com> wrot=
e:
> >>
> >> On Mon, Oct 25, 2021 at 12:53:49PM -0700, Atish Patra wrote:
> >>> HiFive unmatched supports HPMCounters but does not implement mcountin=
hibit
> >>> or sscof extension. Thus, perf monitoring can be used on the unmatche=
d
> >>> board without sampling.
> >>>
> >>> Add the PMU node with compatible string so that Linux perf driver can
> >>> utilize this to enable PMU.
> >>>
> >>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >>> ---
> >>> arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 3 +++
> >>> 1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/=
boot/dts/sifive/fu740-c000.dtsi
> >>> index abbb960f90a0..b35b96b58820 100644
> >>> --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> >>> +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> >>> @@ -140,6 +140,9 @@ soc {
> >>>              #size-cells =3D <2>;
> >>>              compatible =3D "simple-bus";
> >>>              ranges;
> >>> +             pmu {
> >>> +                     compatible =3D "riscv,pmu";
> >>> +             };
> >>
> >> This is a property of the user-replaceable firmware, not a property of
> >> the hardware,
> >
> > It's a property of hardware that indicates that the hardware supports P=
MU.
>
> All RISC-V hardware provides the CSRs, they=E2=80=99re part of the privil=
eged
> spec and not marked optional. How many aren=E2=80=99t hard-wired to zero =
is up
> to the implementation. But even then you can=E2=80=99t know from the hard=
ware
> alone what is supported; the firmware has to enable S-mode (and
> U-mode)=E2=80=99s ability to read them, so you can=E2=80=99t assume anyth=
ing in a
> static device tree hard-coded in Linux about what firmware has done.
> Since you currently have to query the firmware to determine what=E2=80=99=
s
> available to you anyway, I see no benefit from having a node in the
> device tree that tells you your firmware *might* have counters you can
> use.
>
> > Additionally, the counter overflow interrupt number needs to be
> > defined through the DT as well
> > so that a clean platform driver can be implemented.
>
> The interrupt number is specified as 13 by the Sscofmpf spec.
> But that=E2=80=99s not relevant here, the FU740 predates and doesn=E2=80=
=99t implement
> Sscofmpf, meaning there is no interrupt to even define here. And as I
> said on the other patch, don=E2=80=99t conflate =E2=80=9CSBI PMU firmware=
 interface is
> supported=E2=80=9D and =E2=80=9CSscofmpf is implemented in the hardware=
=E2=80=9D; the former
> should be discovered by talking to firmware, and the latter should be
> discovered like any other extension (however that ends up happening).

Presence of sscof extension can be discovered through general extension
discovery mechanism (probably a separate DT node..that's a separate discuss=
ion).

However, the interrupt number discovery has to be through DT so the
platform driver
can probe the DT to figure out that.

>
> >> so having this in the device tree under /soc, let alone
> >> hard-coded in Linux, is utterly wrong. Why can this not just be probed
> >> like any other SBI interface? The "Probe SBI extension" interface is
> >> precisely for this kind of thing.
> >>
> > SBI extension is anyways probed to verify if the firmware has PMU
> > extension or not.
> > However, adding the DT property allows different platforms (with or
> > without sscof extension)
> > to use the same code path.
>
> You don=E2=80=99t need a device tree for that; that same code path can ju=
st be
> =E2=80=9Cuse the existing standard firmware interface=E2=80=9D. That also=
 has the
> benefit that it=E2=80=99s not tied to device tree and so works identicall=
y for
> ACPI, rather than needing an ACPI version of it.
>

I don't disagree with that argument. However, we need a DT node for
interrupt number as explained in the above.
A DT based platform driver allows us to provide a unified code path
which can handle both kinds of platforms described below.

1. Platforms without sscof extension
2. Platforms with sscof extension that requires a DT node for interrupt num=
ber

Otherwise, the driver has to do the following things in order.

1. Probe PMU extension
2. first check if sscof extension is present in the special RISC-V ISA
extension DT node (which is yet to finalize)
3. If sscof extension is present then register for a DT based platform driv=
er.
4. Otherwise, register a simple platform driver.

I am not completely opposed to doing that if there is a strong
technical issue with the current approach.

> I see nothing here that can=E2=80=99t be discovered through pre-existing =
means.
> If it can be discovered without use of the device tree then it does not
> belong in the device tree; the device tree is purely for things that
> cannot otherwise be discovered.
>
> Jess
>


--=20
Regards,
Atish
