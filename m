Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7435E00C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344069AbhDMN1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbhDMN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:27:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621EFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:27:13 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a25so6031062ljm.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/CkYN87dbvnUBK0ma4BR7cxQpiVPaYtBWfwiMb4LnLo=;
        b=fcYW+w5XHga0WkmaPVkb5EEFO1f1/Y72UZGoJdPnamMSZ7E/gq1/c0qjvMA8ri3ag0
         pJNYp+6lYjNyY0MQSXd/Gxe9eq2e3qyYe9rNWpThiyqOridTMvsn5537Ll8uXra9DerO
         YnmYK8RjIcXYRQesfDinRHJRSu7eF/eN2A2TDMYxGzSqqnnVLDAdlSDufjTxerW22k8W
         uELq1H4X3LPCPEqYtcamCPsGv70x0WxpkJUrfmLrfnslNU0Wz0l9yc2A4yAAu/LmK/Vn
         HM+O1XOIk5Mr0PmCKg8lU+M4cbdbOtOd+JCWVk7Cmg2G1lTCYC+nl4i1FIiK7BN5TPKz
         k2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/CkYN87dbvnUBK0ma4BR7cxQpiVPaYtBWfwiMb4LnLo=;
        b=VlaJ1KV/NNAt+G06r8l0FcBBXr1LHAYTW1t7gc/dWnSjEKtgc0o2k3VvSv79Aj5U4S
         hWm34/vh6fNBqkzrTVmKjOG0TFI6/C49lPELzJpmsEvdsCOrySf70V7luYo0GlW9CREQ
         o2tEG629fBjeyP43jejGXGhKFVlr+o5EPgUV5qXiuNb9CKmda49KsU80uwNJHcNSiI3D
         nYTceAS9ll7oKCJPeU0RhMuS0J8Xe/Zg5RM8GlCabJqMH+6lGtxKhukYcqXYhrrw/mnu
         dvfbpiIV1pmRp8KH2tFFfsIxjpGHwN7AKl58SujDx8ZrMwEwmrkwcEteDRFo0NiLTk4a
         MPOg==
X-Gm-Message-State: AOAM531hypXcBmro0Fc18iQ6k8lNDyL2pUzfHkz/goqtbsL+6+otgrR5
        FqsQ9OYGmddHW7da3uT8KCVVcA9JKrRsSWJZRLUauAFoRow0HApA
X-Google-Smtp-Source: ABdhPJyKmxOjvAuApUS0PZtZe/uPAnnCs5UXkgFGiyWg0QmlVtMxHYSarMDLNgpQw/wajXCqr/ad7vSzcVWcN7PyhpE=
X-Received: by 2002:a2e:b175:: with SMTP id a21mr12983916ljm.248.1618320431888;
 Tue, 13 Apr 2021 06:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210412070819.23493-1-ruifeng.zhang0110@gmail.com>
 <87y2dnn3gw.mognet@arm.com> <CAG7+-3MsjuChoEOj11VAMX9W61UY6MmphkxWDF=-_R1A8sfvpA@mail.gmail.com>
 <87tuobmsba.mognet@arm.com> <CAG7+-3OMYVTc+ja9CK+94X8XtKq3hbRb+XOEv7xOeuXgNm0BHQ@mail.gmail.com>
 <87o8eimmyw.mognet@arm.com>
In-Reply-To: <87o8eimmyw.mognet@arm.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Tue, 13 Apr 2021 21:26:41 +0800
Message-ID: <CAG7+-3NaUAvjv9=9HZ4jQU=DVcZW6gRKZg9ZjutL3aKnnC4FLw@mail.gmail.com>
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

Thanks for your review. Patch-v2 that solve the capacity issue will be
uploaded as soon as possible. : )

Valentin Schneider <valentin.schneider@arm.com> =E4=BA=8E2021=E5=B9=B44=E6=
=9C=8813=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:40=E5=86=99=E9=81=
=93=EF=BC=9A
>
> On 13/04/21 14:13, Ruifeng Zhang wrote:
> > Valentin Schneider <valentin.schneider@arm.com> =E4=BA=8E2021=E5=B9=B44=
=E6=9C=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:33=E5=86=99=E9=
=81=93=EF=BC=9A
> >> I'm not fluent at all in armv7 (or most aarch32 compat mode stuff), bu=
t
> >> I couldn't find anything about MPIDR format differences:
> >>
> >>   DDI 0487G.a G8.2.113
> >>   """
> >>   AArch32 System register MPIDR bits [31:0] are architecturally mapped=
 to
> >>   AArch64 System register MPIDR_EL1[31:0].
> >>   """
> >>
> >> Peeking at some armv7 doc and arm/kernel/topology.c the layout really =
looks
> >> just the same, i.e. for both of them, with your example of:
> >
> > The cortex-a7 spec DDI0464F 4.3.5
> > https://developer.arm.com/documentation/ddi0464/f/?lang=3Den
> >
>
> Ah, so that's where the core_id=3Dbit[1:0] comes from. That does still
> conform to the MPIDR format, and as you point out below that's being pars=
ed
> the same (aff2, aff1, aff0) =3D=3D mpidr([23:16][15:8][7:0])
>
> > The current arch/arm/kernel/topology code parse the MPIDR with a armv7 =
format.
> > the parse code is:
> > void store_cpu_topology(unsigned int cpuid)
> > {
> >     ...
> >     cpuid_topo->thread_id =3D -1;
> >     cpuid_topo->core_id =3D MPIDR_AFFINITY_LEVEL(mpidr, 0);
> >     cpuid_topo->package_id =3D MPIDR_AFFINITY_LEVEL(mpidr, 1);
> >     ...
> > }
> >>
> >>   core0: 0000000080000000
> >>   core1: 0000000080000100
> >>   core2: 0000000080000200
> >>   ...
> >>
> >> we'll get:
> >>
> >>   |       | aff2 | aff1 | aff0 |
> >>   |-------+------+------+------|
> >>   | Core0 |    0 |    0 |    0 |
> >>   | Core1 |    0 |    1 |    0 |
> >>   | Core2 |    0 |    2 |    0 |
> >>       ...
> >>
> >> Now, arm64 doesn't fallback to MPIDR for topology information anymore =
since
> >>
> >>   3102bc0e6ac7 ("arm64: topology: Stop using MPIDR for topology inform=
ation")
> >>
> >> so without DT we would get:
> >>   |       | package_id | core_id |
> >>   |-------+------------+---------|
> >>   | Core0 |          0 |       0 |
> >>   | Core1 |          0 |       1 |
> >>   | Core2 |          0 |       2 |
> >>
> >> Whereas with an arm kernel we'll end up parsing MPIDR as:
> >>   |       | package_id | core_id |
> >>   |-------+------------+---------|
> >>   | Core0 |          0 |       0 |
> >>   | Core1 |          1 |       0 |
> >>   | Core2 |          2 |       0 |
> >>
> >> Did I get this right? Is this what you're observing?
> >
> > Yes, this is a problem if an armv8.2 or above cpu is running a 32-bit
> > kernel on EL1.
>
>
> With the above MPIDR(_EL1) values, you would have the same problem in
> aarch64 mode on any kernel predating
>
>   3102bc0e6ac7 ("arm64: topology: Stop using MPIDR for topology informati=
on")
>
> since all Aff0 values are 0. Arguably those MPIDR(_EL1) values don't
> make much sense (cores in the same cluster should have different Aff0
> values, unless SMT), but in arm64 that's usually "corrected" by DT.
>
> As you pointed out, arm doesn't currently leverage the cpu-map DT entry. =
I
> don't see any obvious problem with adding support for it, so if you can f=
ix
> the capacity issue Dietmar reported, I think we could consider it.
