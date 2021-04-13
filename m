Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F47735D7CD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344889AbhDMGOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhDMGOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:14:20 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37D3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:13:59 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r22so7382053ljc.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E3w3Sr1LangGVSW3HX3D5u850lOWa1sm6SyjRu/yID4=;
        b=npIODaim968KZ4K2v7flPUis6UKYxA88aDRzur8Ca2AOJNxKtJ2zpEUKVXti08E0zu
         obW2pfrU8SN5CHaYoJUO835rKVIzB+14BRWoAAQcfLcBMdm/ZErstp4Pp4fslM/Cw46Y
         n26o20YCJKVVGideFB+l0CCRwn0jqqfu4OembgbiQFWVajH/T+guTy+gejdTgnf2Xq7z
         tqUepmnfuyvti0iGxURrWJGM+vW5Re41mG9paeZKKcO1qGD2txMLunYoOaHeawx3Nvvb
         RL0NyrxDoAK8pJGjO6UeGeBCW3cZIbEx6cMbTKycmyY5zsGhv2hzcWmxcGTx/F9NaePU
         hTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E3w3Sr1LangGVSW3HX3D5u850lOWa1sm6SyjRu/yID4=;
        b=Lrq/dVCVUyeqwIkitwhIn3X6qldsSkh3aMXUod/Dw8A6lAmyhyUNylQtRyfvA14tcm
         SrdvkhI/W0zr9Ol1S+DVDZWMNIzEArs2/b/ZnWD8nOhClGXRdGVThtOmmmg1CZaDjEEn
         WWSgoywQCrjCKshCXS4q2hSZmnI1CIj2JHfKh4HMVRhDCpQhK/y+RV7WzbUJnCRDKqwY
         NngdaS7s48wFKrdGmFqoe84Snscq4baKd58qTJeWi1lndHIDNxJ12I5bnu0LZL7NS9KV
         7rHQ6nK6saL4EOigPgr7KCmD+IvJZEtVGc1P4neU7u8kDuTVE0utGumv8G+muQxaMQ2p
         FZaA==
X-Gm-Message-State: AOAM533+nDfN5GLnKB/tk3PWyfEMhRKJL/uyCTJ7GUcTNuC4NLUr4RBN
        yGSFJqAoEq+as2GMrJCI4iUvPN73bBB+DkO9rr1MxyoMcwfBXVpQ
X-Google-Smtp-Source: ABdhPJzBXl3Me2CBnTKogELCIanAffVzFmaVRP5u+wb/RvqujnEkU85lsxEVDpMlXvClbhypyp9aJgEBRdHeT3RL7Io=
X-Received: by 2002:a2e:b175:: with SMTP id a21mr12065467ljm.248.1618294438436;
 Mon, 12 Apr 2021 23:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210412070819.23493-1-ruifeng.zhang0110@gmail.com>
 <87y2dnn3gw.mognet@arm.com> <CAG7+-3MsjuChoEOj11VAMX9W61UY6MmphkxWDF=-_R1A8sfvpA@mail.gmail.com>
 <87tuobmsba.mognet@arm.com>
In-Reply-To: <87tuobmsba.mognet@arm.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Tue, 13 Apr 2021 14:13:28 +0800
Message-ID: <CAG7+-3OMYVTc+ja9CK+94X8XtKq3hbRb+XOEv7xOeuXgNm0BHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm: topology: parse the topology from the dt
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        dietmar.eggemann@arm.com, mingo@kernel.org,
        ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Schneider <valentin.schneider@arm.com> =E4=BA=8E2021=E5=B9=B44=E6=
=9C=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:33=E5=86=99=E9=81=
=93=EF=BC=9A
>
> On 12/04/21 20:20, Ruifeng Zhang wrote:
> > There is a armv8.3 cpu which should work normally both on aarch64 and a=
arch32.
> > The MPIDR has been written to the chip register in armv8.3 format.
> > For example,
> > core0: 0000000080000000
> > core1: 0000000080000100
> > core2: 0000000080000200
> > ...
> >
> > Its cpu topology can be parsed normally on aarch64 mode (both
> > userspace and kernel work on arm64).
> >
> > The problem is when it working on aarch32 mode (both userspace and
> > kernel work on arm 32-bit),
>
> I didn't know using aarch32 elsewhere than EL0 was something actually bei=
ng
> used. Do you deploy this somewhere, or do you use it for testing purposes=
?

In Unisoc, the sc9863a SoC which using cortex-a55, it has two software
version, one
of them is the kernel running on EL1 using aarch32.
                          user(EL0)            kernel(EL1)
sc9863a_go      aarch32               aarch32
sc9863a            aarch64               aarch64
>
> > the cpu topology
> > will parse error because of the format is different between armv7 and a=
rmv8.3.
> > The arm 32-bit driver, arch/arm/kernel/topology will parse the MPIDR
> > and store to the topology with armv7,
> > and the result is all cpu core_id is 0, the bit[1:0] of armv7 MPIDR for=
mat.
> >
>
> I'm not fluent at all in armv7 (or most aarch32 compat mode stuff), but
> I couldn't find anything about MPIDR format differences:
>
>   DDI 0487G.a G8.2.113
>   """
>   AArch32 System register MPIDR bits [31:0] are architecturally mapped to
>   AArch64 System register MPIDR_EL1[31:0].
>   """
>
> Peeking at some armv7 doc and arm/kernel/topology.c the layout really loo=
ks
> just the same, i.e. for both of them, with your example of:

The cortex-a7 spec DDI0464F 4.3.5
https://developer.arm.com/documentation/ddi0464/f/?lang=3Den

The current arch/arm/kernel/topology code parse the MPIDR with a armv7 form=
at.
the parse code is:
void store_cpu_topology(unsigned int cpuid)
{
    ...
    cpuid_topo->thread_id =3D -1;
    cpuid_topo->core_id =3D MPIDR_AFFINITY_LEVEL(mpidr, 0);
    cpuid_topo->package_id =3D MPIDR_AFFINITY_LEVEL(mpidr, 1);
    ...
}
>
>   core0: 0000000080000000
>   core1: 0000000080000100
>   core2: 0000000080000200
>   ...
>
> we'll get:
>
>   |       | aff2 | aff1 | aff0 |
>   |-------+------+------+------|
>   | Core0 |    0 |    0 |    0 |
>   | Core1 |    0 |    1 |    0 |
>   | Core2 |    0 |    2 |    0 |
>       ...
>
> Now, arm64 doesn't fallback to MPIDR for topology information anymore sin=
ce
>
>   3102bc0e6ac7 ("arm64: topology: Stop using MPIDR for topology informati=
on")
>
> so without DT we would get:
>   |       | package_id | core_id |
>   |-------+------------+---------|
>   | Core0 |          0 |       0 |
>   | Core1 |          0 |       1 |
>   | Core2 |          0 |       2 |
>
> Whereas with an arm kernel we'll end up parsing MPIDR as:
>   |       | package_id | core_id |
>   |-------+------------+---------|
>   | Core0 |          0 |       0 |
>   | Core1 |          1 |       0 |
>   | Core2 |          2 |       0 |
>
> Did I get this right? Is this what you're observing?

Yes, this is a problem if an armv8.2 or above cpu is running a 32-bit
kernel on EL1.
>
> > In addition, I think arm should also allow customers to configure cpu
> > topologies via DT.
