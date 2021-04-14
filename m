Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF4435F263
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350512AbhDNL1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241695AbhDNL1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:27:42 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD00AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:27:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j18so32647026lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NfzEfY4KaDYUyM0ESHWX7Jf+kKYVbwdfUAIa4iFvaiU=;
        b=geGCc6GsK/+5I29sUCevTEJBv/E6o0dtyHymegp2hqzGp7JGqY2J8wCcXRgJJRhtyf
         O6Qe+Sla53trBqnJWH7crVJPPNmEZOUu3t9d4P2gq0JvvRU7DuRWuYGb4N3NECT4a3Hl
         nSCRENTippkF9eIJylOMi8pB9yn3YXENdjudl815GyXmHIs9MfTwyRBGVU7Rvv19ydBH
         4nZZKmj5XpxmPhjxH1mo5ri+XdWwC6sCRzypAYFZ2muJ0uzU1veDq2TCBeW/Wzo4gf+W
         YtTBJmpbKb5CfGXGQeQ6HnZ13j5CAtjwV6P44K4rXThQPVPRXviZvCDO8OKG7u44rPMX
         9ARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NfzEfY4KaDYUyM0ESHWX7Jf+kKYVbwdfUAIa4iFvaiU=;
        b=eYf4g3c9+3GB63/DpfVOK2+ooYvW/LndjEqXoMUb7IK5d2dd5thWp9VVpI7GaVd4Nb
         5uEPQoP7BlUkS77fyVERC4l75xne8bRI7ONCIEEeu1jP+IeDiI6Q6N0bWvc93gUwnvsb
         ca7jeFTQLaPtYhmS74lAYmzocjm+2hwsKDrEH3pLGgwB1xLPFohddi8nYcH5CRoswBH6
         mZJSGc+rnUI0bEKHugTxI9nMgxmSgGN32H8pQiWaKvKxJFA//WhuOnLLZe7/BN7dFJm3
         sRp1ppaz8ZMASTYcRBoedlZp2DVAQ4qrS9ZVKxelU7yhgKANhYAG/O2LHvAHF4NB9+iF
         D0DA==
X-Gm-Message-State: AOAM531Wh0mN0U/IgugcsJlYEXkZzXvg5jtE8tuIPewbdezLG9XoGSv3
        BKo5LgvvRt0wBRq6NxFf+smveZkl3uSL6JYsOfI=
X-Google-Smtp-Source: ABdhPJxajWBf1IhQdS/cweotd7z2dPfVxCKVH/NKAVycTv1IbgszZvlLSav8JlzF3uxNcSkeYNeZOa7wIv41VyaAxuw=
X-Received: by 2002:a05:6512:3448:: with SMTP id j8mr11837556lfr.531.1618399638357;
 Wed, 14 Apr 2021 04:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210412070819.23493-1-ruifeng.zhang0110@gmail.com>
 <87y2dnn3gw.mognet@arm.com> <CAG7+-3MsjuChoEOj11VAMX9W61UY6MmphkxWDF=-_R1A8sfvpA@mail.gmail.com>
 <87tuobmsba.mognet@arm.com> <CAG7+-3OMYVTc+ja9CK+94X8XtKq3hbRb+XOEv7xOeuXgNm0BHQ@mail.gmail.com>
 <87o8eimmyw.mognet@arm.com> <CAG7+-3NaUAvjv9=9HZ4jQU=DVcZW6gRKZg9ZjutL3aKnnC4FLw@mail.gmail.com>
 <74b3ff57-473f-4d5a-daf8-ecbb0761abb2@arm.com>
In-Reply-To: <74b3ff57-473f-4d5a-daf8-ecbb0761abb2@arm.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Wed, 14 Apr 2021 19:26:48 +0800
Message-ID: <CAG7+-3P6FYhqmt3p6g8b5ZXzaFW2pfx-vOZJYwuLCKXVqfFMVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm: topology: parse the topology from the dt
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        mingo@kernel.org, ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dietmar Eggemann <dietmar.eggemann@arm.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:43=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On 13/04/2021 15:26, Ruifeng Zhang wrote:
> > Thanks for your review. Patch-v2 that solve the capacity issue will be
> > uploaded as soon as possible. : )
> >
> > Valentin Schneider <valentin.schneider@arm.com> =E4=BA=8E2021=E5=B9=B44=
=E6=9C=8813=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:40=E5=86=99=E9=
=81=93=EF=BC=9A
> >>
> >> On 13/04/21 14:13, Ruifeng Zhang wrote:
> >>> Valentin Schneider <valentin.schneider@arm.com> =E4=BA=8E2021=E5=B9=
=B44=E6=9C=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:33=E5=86=99=
=E9=81=93=EF=BC=9A
> >>>> I'm not fluent at all in armv7 (or most aarch32 compat mode stuff), =
but
> >>>> I couldn't find anything about MPIDR format differences:
> >>>>
> >>>>   DDI 0487G.a G8.2.113
> >>>>   """
> >>>>   AArch32 System register MPIDR bits [31:0] are architecturally mapp=
ed to
> >>>>   AArch64 System register MPIDR_EL1[31:0].
> >>>>   """
> >>>>
> >>>> Peeking at some armv7 doc and arm/kernel/topology.c the layout reall=
y looks
> >>>> just the same, i.e. for both of them, with your example of:
> >>>
> >>> The cortex-a7 spec DDI0464F 4.3.5
> >>> https://developer.arm.com/documentation/ddi0464/f/?lang=3Den
> >>>
> >>
> >> Ah, so that's where the core_id=3Dbit[1:0] comes from. That does still
> >> conform to the MPIDR format, and as you point out below that's being p=
arsed
> >> the same (aff2, aff1, aff0) =3D=3D mpidr([23:16][15:8][7:0])
> >>
> >>> The current arch/arm/kernel/topology code parse the MPIDR with a armv=
7 format.
> >>> the parse code is:
> >>> void store_cpu_topology(unsigned int cpuid)
> >>> {
> >>>     ...
> >>>     cpuid_topo->thread_id =3D -1;
> >>>     cpuid_topo->core_id =3D MPIDR_AFFINITY_LEVEL(mpidr, 0);
> >>>     cpuid_topo->package_id =3D MPIDR_AFFINITY_LEVEL(mpidr, 1);
> >>>     ...
> >>> }
> >>>>
> >>>>   core0: 0000000080000000
> >>>>   core1: 0000000080000100
> >>>>   core2: 0000000080000200
> >>>>   ...
> >>>>
> >>>> we'll get:
> >>>>
> >>>>   |       | aff2 | aff1 | aff0 |
> >>>>   |-------+------+------+------|
> >>>>   | Core0 |    0 |    0 |    0 |
> >>>>   | Core1 |    0 |    1 |    0 |
> >>>>   | Core2 |    0 |    2 |    0 |
> >>>>       ...
> >>>>
> >>>> Now, arm64 doesn't fallback to MPIDR for topology information anymor=
e since
> >>>>
> >>>>   3102bc0e6ac7 ("arm64: topology: Stop using MPIDR for topology info=
rmation")
> >>>>
> >>>> so without DT we would get:
> >>>>   |       | package_id | core_id |
> >>>>   |-------+------------+---------|
> >>>>   | Core0 |          0 |       0 |
> >>>>   | Core1 |          0 |       1 |
> >>>>   | Core2 |          0 |       2 |
> >>>>
> >>>> Whereas with an arm kernel we'll end up parsing MPIDR as:
> >>>>   |       | package_id | core_id |
> >>>>   |-------+------------+---------|
> >>>>   | Core0 |          0 |       0 |
> >>>>   | Core1 |          1 |       0 |
> >>>>   | Core2 |          2 |       0 |
> >>>>
> >>>> Did I get this right? Is this what you're observing?
> >>>
> >>> Yes, this is a problem if an armv8.2 or above cpu is running a 32-bit
> >>> kernel on EL1.
> >>
> >>
> >> With the above MPIDR(_EL1) values, you would have the same problem in
> >> aarch64 mode on any kernel predating
> >>
> >>   3102bc0e6ac7 ("arm64: topology: Stop using MPIDR for topology inform=
ation")
> >>
> >> since all Aff0 values are 0. Arguably those MPIDR(_EL1) values don't
> >> make much sense (cores in the same cluster should have different Aff0
> >> values, unless SMT), but in arm64 that's usually "corrected" by DT.
> >>
> >> As you pointed out, arm doesn't currently leverage the cpu-map DT entr=
y. I
> >> don't see any obvious problem with adding support for it, so if you ca=
n fix
> >> the capacity issue Dietmar reported, I think we could consider it.
>
> Coming back to your original patch. You want to use parse_dt_topology()
> from drivers/base/arch_topology.c to be able detect a cpu-map in dt and
> so bypassing the read of mpidr in store_cpu_topology()?

Yes
>
> Looks like sc9863a has two frequency domains (1.6 and 1.2GHz). So
> technically it's a big.LITTLE system (based only on max CPU frequency
> (not on uarch) differences).
> But the dts file doesn't contain any `capacity-dmips-mhz` entries? So
> asymmetric CPU capacity (even only based on max CPU frequency) detection
> won't kick in. Since you don't have any uarch diffs, you would have to
> specify `capacity-dmips-mhz =3D <1024>` for each CPU.

Yes, for capacity, the DT should have a capacity-dmips-MHz entry or a
clock-frequency entry (for A7 and A15 only).
The sc9863a dts is a vendor file,  in my opinion is not appropriate to
be update with this series.
What do you think if I independently update the sc9863a dts file later?
