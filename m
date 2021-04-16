Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A5A361ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbhDPHsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhDPHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:48:13 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FF6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 00:47:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f41so19967813lfv.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 00:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ntkre8qeLlI+F1SKceB7/gyabsqQNrFWwnVLXboUGWk=;
        b=RKaKdufNANllMNvp6xN7BPEEOv2+NtkHrCiEInLRjmGgVJTyYtXOhkwBt3B1dvaPzd
         pM07a7fVUDS4fld342eFCyn89MGtHjYoT7o6fcqYrWiM5er0Pdg/BXpVLTO2AvhA/1Ed
         G7ET/qj51uNwP29ob+Mur4HCyqmwum6IQVqZWqgEOprNM2HXZzPGDI2DXHsooRnrhezC
         xF/bZcJdGSZ9r4eVGk1huYwr1zq4V97956++CGnDrLt2zheDB5VyzfVYvfoNyZV5MjPm
         X20UBlfBdrt73ClZELBDvghV4rNI6vbxr3yD2dSoCjHtTQqHuFq9NvoPcvl+VATAR8gj
         CrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ntkre8qeLlI+F1SKceB7/gyabsqQNrFWwnVLXboUGWk=;
        b=RnfB6+vNkcicsuncu+TM8udeyCbh8TMgtZL3nQxsBSE3co2lOi2OgnkiFgdSEnfi20
         0462+oSQk/rcbVN4+5o8fJI+lfm4C7Jjxz88/AcNix2Kn4M1XBJXJhNHbtBrnywhW9uB
         L1RjNvHWUSHDarED2xidZS9zetIOgot2WCUAUlwtbNWYUYaU2gdydlUz1qMsglPcUGZ2
         NevXOO8WRk8y7logb2s+mvMWvaLf+xXEgAPQW138cpL7rWqG7nrvffgZTuBY/uLyQlma
         wThia7It4YL7tVn1TdOA6lD1mE6DTjF9Bik0LSVJqxNB0pUMUuO6mymONwAPVe5/VU8u
         Pcfw==
X-Gm-Message-State: AOAM532TDhTR82wWqiPvgmEMHNYIkBfDo9BSg6tLiRpDI42++3VZfMEb
        4g9iteumHBLsbxh3R47Gzujvu/fADv6AjU9ZPng=
X-Google-Smtp-Source: ABdhPJyQC4r2hOR4ojW3IB5L891b21yK3hu8Nl+DTI4L/G8hJg3W/Gd89cbnebFYH9qpSqy1AvANViXuPNMmxTWnGCw=
X-Received: by 2002:ac2:4e84:: with SMTP id o4mr2032068lfr.557.1618559267831;
 Fri, 16 Apr 2021 00:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com>
 <8735vrmnc7.mognet@arm.com> <b7a76995-f6c3-67c5-b14e-d40587495d7e@arm.com>
In-Reply-To: <b7a76995-f6c3-67c5-b14e-d40587495d7e@arm.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Fri, 16 Apr 2021 15:47:15 +0800
Message-ID: <CAG7+-3Nv=m0pd8t0eQEUv5zSeg86hfkKcs_VLzsbzWFabYbTTQ@mail.gmail.com>
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
=8816=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=884:10=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On 15/04/2021 20:09, Valentin Schneider wrote:
> > On 14/04/21 20:23, Ruifeng Zhang wrote:
> >> From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> >>
> >> In Unisoc, the sc9863a SoC which using cortex-a55, it has two software
> >> version, one of them is the kernel running on EL1 using aarch32.
> >>                 user(EL0)             kernel(EL1)
> >> sc9863a_go      aarch32               aarch32
> >> sc9863a         aarch64               aarch64
> >>
> >> When kernel runs on EL1 using aarch32, the topology will parse wrong.
> >> For example,
> >> The MPIDR has been written to the chip register in armv8.2 format.
> >> For example,
> >> core0: 0000000080000000
> >> core1: 0000000080000100
> >> core2: 0000000080000200
> >> ...
> >>
> >> It will parse to:
> >> |       | aff2 | packageid | coreid |
> >> |-------+------+-----------+--------|
> >> | Core0 |    0 |         0 |    0   |
> >> | Core1 |    0 |         1 |    0   |
> >> | Core2 |    0 |         2 |    0   |
> >> |  ...  |      |           |        |
> >>
> >> The wrong topology is that all of the coreid are 0 and unexpected
> >> packageid.
> >>
> >> The reason is the MPIDR format is different between armv7 and armv8.2.
> >> armv7 (A7) mpidr is:
> >> [11:8]      [7:2]       [1:0]
> >> cluster     reserved    cpu
> >> The cortex-a7 spec DDI0464F 4.3.5
> >> https://developer.arm.com/documentation/ddi0464/f/?lang=3Den
> >>
> >> armv8.2 (A55) mpidr is:
> >> [23:16]     [15:8]      [7:0]
> >> cluster     cpu         thread
> >>
> >
> > What I had understood from our conversation was that there *isn't* a fo=
rmat
> > difference (at least for the bottom 32 bits) - arm64/kernel/topopology.=
c
> > would parse it the same, except that MPIDR parsing has been deprecated =
for
> > arm64.

I agree, I should change my description.

> >
> > The problem is that those MPIDR values don't match the actual topology.=
 If
> > they had the MT bit set, i.e.
> >
> >   core0: 0000000081000000
> >   core1: 0000000081000100
> >   core2: 0000000081000200
> >
> > then it would be parsed as:
> >
> >   |       | package_id | core_id | thread_id |
> >   |-------+------------+---------+-----------|
> >   | Core0 |          0 |       0 |         0 |
> >   | Core1 |          0 |       1 |         0 |
> >   | Core2 |          0 |       2 |         0 |
> >
> > which would make more sense (wrt the actual, physical topology).
>
> ... and this would be in sync with
> https://developer.arm.com/documentation/100442/0200/register-descriptions=
/aarch32-system-registers/mpidr--multiprocessor-affinity-register
>
> MT, [24]
>
>    0b1 ...
>
> There is no 0b0 for MT.
>
As you said, the MT must be 0b1, so the {aff1} means coreid for A55.
It's no problem for parsing coreid.

For more requirements, if all cores in one physical cluster, the
{aff2} of all cores are the same value.
i.e. the sc9863a,
core0: 0000000081000000
core1: 0000000081000100
core2: 0000000081000200
core3: 0000000081000300
core4: 0000000081000400
core5: 0000000081000500
core6: 0000000081000600
core7: 0000000081000700

According to MPIDR all cores will parse to the one cluster, but it's
the big.LITTLE system, it's need two logic cluster for schedule or
cpufreq.
So I think it's better to add the logic of parse topology from DT.
