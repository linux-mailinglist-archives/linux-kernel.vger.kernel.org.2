Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B081A361E61
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbhDPLFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbhDPLFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:05:36 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED0EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:05:11 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p23so26910459ljn.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vgn2hLvYm9VRdUeK9QwKCOg8tHO1aZqMcGsweJ0oU3g=;
        b=vXS+MI2MPzPfvwmx/s6d4lEwtHGT1bnu9s+z5wztFqQZElxsa1jSGZ8d90yYX9PY7q
         uJnVlv2pQAOHJr94Y9Qk/V+E/hJ7ZmaBuJAH8+P6O02SYH5XBOISBWZ06c8AsUHGpu8/
         yLcBn+KlSgZKUg7o7GSQz6P1RWCs6lXk32CghVHVbIlKzeL6n06KxZ4fSqzNUoIGYwHZ
         +rHXXvWn32USaSMmtEJ1b+ryqgHTUREuQRYyrfZj/rTHXwscC7MY1neLNQiiZOrGOyLa
         rjao3DGPJpv3nDTgu34TdxTPXpuj/711CtMnb5r7OGiU5AgGOPJwC14QedSYZeNl4Gmi
         eOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vgn2hLvYm9VRdUeK9QwKCOg8tHO1aZqMcGsweJ0oU3g=;
        b=ZcwZl6LlcMZaEw58nMUXV60CN5U3laiNSsNs43TgE6rrq79xnQvGnBCyaVuAt79K44
         iDBdAYkvtMBsjZDKzF3abdppGxBgY/87T8NsmXSeaeqc4szNoyPGQtkAse2URCXGbS38
         6uqFCWVJz9JrsU4uE0/w6vr4byShRUIjA76qCyoLIyCShoTbCYhtOidr/unEW1B1yvee
         +rFpjbCf/s4PF2d3jWgg5ci4rHj33V69XqIJNQtyoMai4DJQPgaZlgoaiMaoFf2DFSXE
         Yxapi5vi5xgUBfGvkvsLbEM0FFzKgSUfArJzuY/MiyZ+NjBFX3aRjeHv8WU+Be2Wt+yx
         zqIQ==
X-Gm-Message-State: AOAM532MaHzpSzFZKFiJ6n4RpDJfyunvaW8coUB5n30T/dKMKgmn53nY
        2qm1khHTVsV6YcVdQWH6ZIUnIVpmI+iJKPZizAk=
X-Google-Smtp-Source: ABdhPJyj4UXHkh/VGecOqIFBTawOUrmNqCba91VNrDigWcTiKFTlavCottwdYTrFaB5bFDCm2+8J2JtxtpUKwH+rii4=
X-Received: by 2002:a2e:581a:: with SMTP id m26mr2352735ljb.33.1618571110203;
 Fri, 16 Apr 2021 04:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com>
 <8735vrmnc7.mognet@arm.com> <b7a76995-f6c3-67c5-b14e-d40587495d7e@arm.com>
 <CAG7+-3Nv=m0pd8t0eQEUv5zSeg86hfkKcs_VLzsbzWFabYbTTQ@mail.gmail.com>
 <87wnt2lglo.mognet@arm.com> <44ab835f-3456-6bd9-97e9-5936cf5372da@arm.com>
In-Reply-To: <44ab835f-3456-6bd9-97e9-5936cf5372da@arm.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Fri, 16 Apr 2021 19:04:38 +0800
Message-ID: <CAG7+-3OgN4Kx3Md1tOmqHDLs94DSv2puh=kA0oFMw+aZGnb3iw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] arm: topology: parse the topology from the dt
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
=8816=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:39=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On 16/04/2021 11:32, Valentin Schneider wrote:
> > On 16/04/21 15:47, Ruifeng Zhang wrote:
> >> For more requirements, if all cores in one physical cluster, the
> >> {aff2} of all cores are the same value.
> >> i.e. the sc9863a,
> >> core0: 0000000081000000
> >> core1: 0000000081000100
> >> core2: 0000000081000200
> >> core3: 0000000081000300
> >> core4: 0000000081000400
> >> core5: 0000000081000500
> >> core6: 0000000081000600
> >> core7: 0000000081000700
> >>
> >> According to MPIDR all cores will parse to the one cluster, but it's
> >> the big.LITTLE system, it's need two logic cluster for schedule or
> >> cpufreq.
> >> So I think it's better to add the logic of parse topology from DT.
> >
> > Ah, so it's a slightly different issue, but still one that requires a
> > different means of specifying topology.
>
> I'm confused. Do you have the MT bit set to 1 then? So the issue that
> the mpidr handling in arm32's store_cpu_topology() is not correct does
> not exist?

I have reconfirmed it, the MT bit has been set to 1. I am sorry for
the previous messages.
The mpidr parse by store_cpu_topology is correct, at least for the sc9863a.

>
> With DynamIQ you have only *one* cluster, you should also be able to run
> your big.LITTLE system with only an MC sched domain.
>
> # cat /proc/schedstat
> cpu0 ....
> domain0 ff ... <- MC
> ...
>
> You can introduce a cpu-map to create what we called Phantom Domains in
> Android products.
>
> # cat /proc/schedstat
>
> cpu0 ....
> domain0 0f ... <- MC
> domain1 ff ... < DIE
>
> Is this what you need for your arm32 kernel system? Adding the
> possibility to parse cpu-map to create Phantom Domains?

Yes, I need parse DT cpu-map to create different Phantom Domains.
With it, the dts should be change to:
                cpu-map {
                        cluster0 {
                                core0 {
                                        cpu =3D <&CPU0>;
                                };
                                core1 {
                                        cpu =3D <&CPU1>;
                                };
                                core2 {
                                        cpu =3D <&CPU2>;
                                };
                                core3 {
                                        cpu =3D <&CPU3>;
                                };
                        };

                        cluster1 {
                                core0 {
                                        cpu =3D <&CPU4>;
                                };
                                core1 {
                                        cpu =3D <&CPU5>;
                                };
                                core2 {
                                        cpu =3D <&CPU6>;
                                };
                                core3 {
                                        cpu =3D <&CPU7>;
                                };
                        };
                };
