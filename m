Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F8A368D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240767AbhDWG0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240393AbhDWG0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:26:38 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA1BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 23:26:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a36so43742272ljq.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 23:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S+bu8m+R2xAF2mNNdlF42B7is9j6ZJyE5tfMqemMD+A=;
        b=fwZGSD/n3XqVciBKe8DGEsqsoYhAq0H2ftf8ONKXhifitBqyvnZBzmvHyTP/k35FZ/
         qUJmFt2hU80WlZoL9NkXeWvfLtaOvYcjCWhuVDlryDzu97Vb1mFArYuOxE+FrAU6QYWQ
         zsp3EqAKEvXvFt6WUqbJmJxMN+YGH2Yf8sG7hsj1GrRTEb8wBUjJGL8oBS3I61ncmxXR
         OWVqe0OUVLAxA331mUOttiayCCiNQr8lJs5JiJmyfZUClCz27S3V+GOCKlXp6F9uyu+O
         oLpgDvhoNBMea5JoNxWAfejlkJuYI3EdUKKQesZptT5Iy8473xk6aTQhN01jGa6Co/nG
         zxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S+bu8m+R2xAF2mNNdlF42B7is9j6ZJyE5tfMqemMD+A=;
        b=KjxTgU0IsOVe01H/KZYo8j0dIy8A+ZN9vTM7TwZoHf6pLH9XKLToKc0q5Q+PSYRRnH
         P4eofrO9MIEMCL768WQB54bw0hYxehSKFkuQ7IaGzKqeA5R6Bem3LJHcaOKHWfhGzMK8
         RFXwYBHmYMN7yDFQ4zcFhjfWi793B10eGv32TisWTfdPZUJlJmbEG8n/4K7CZ1BSnYsx
         qjqruHA+8L1JRgLYM70BPqCpfu5JIflUmxF2Is0MMMVjzDDqLZJUs3XMa/4GZx4teFJM
         Utl32fWofZorqoFiLuKuclDvnnBTeC8uucERA5UFDK+T4fd7P/ThPiUQrzT48oTpzrqk
         YWRw==
X-Gm-Message-State: AOAM532FTRDjY0bjnneeETN6UhlUTQxxdUCsnXS2A5lWaeu5BUqfzxxP
        8Xhe9SMRB4u/tIOu0kHScFIoJ74umKsiNtUhUKc=
X-Google-Smtp-Source: ABdhPJwwD2n+Kn39CraDMy6Z9oG5KsvHkfKTo4M9n/mpfqG1Ver8qh0YpVRE7pYrUmee5IuXRuS7EBunHxwVHXiGNmk=
X-Received: by 2002:a2e:bb81:: with SMTP id y1mr1776225lje.138.1619159160821;
 Thu, 22 Apr 2021 23:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com>
 <8735vrmnc7.mognet@arm.com> <b7a76995-f6c3-67c5-b14e-d40587495d7e@arm.com>
 <CAG7+-3Nv=m0pd8t0eQEUv5zSeg86hfkKcs_VLzsbzWFabYbTTQ@mail.gmail.com>
 <87wnt2lglo.mognet@arm.com> <44ab835f-3456-6bd9-97e9-5936cf5372da@arm.com>
 <CAG7+-3OgN4Kx3Md1tOmqHDLs94DSv2puh=kA0oFMw+aZGnb3iw@mail.gmail.com>
 <2a4efeea-cc70-ca0a-81fd-84d8b54586c0@arm.com> <CAG7+-3MX8Ntzh-fiTFZq-d9EO4GNpY2b3AuAOZPxVmxA=jNtNg@mail.gmail.com>
 <31faf969-c8fe-1acf-e78f-793a37b8d0b2@arm.com>
In-Reply-To: <31faf969-c8fe-1acf-e78f-793a37b8d0b2@arm.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Fri, 23 Apr 2021 14:25:25 +0800
Message-ID: <CAG7+-3OMkC_tYEKeXW6MGrsTbEsf6iUG24-9TYJGL-Kh6Dr83A@mail.gmail.com>
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
=8820=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=885:27=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On 19/04/2021 04:55, Ruifeng Zhang wrote:
> > Dietmar Eggemann <dietmar.eggemann@arm.com> =E4=BA=8E2021=E5=B9=B44=E6=
=9C=8817=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:00=E5=86=99=E9=81=
=93=EF=BC=9A
> >>
> >> On 16/04/2021 13:04, Ruifeng Zhang wrote:
> >>> Dietmar Eggemann <dietmar.eggemann@arm.com> =E4=BA=8E2021=E5=B9=B44=
=E6=9C=8816=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:39=E5=86=99=E9=
=81=93=EF=BC=9A
> >>>>
> >>>> On 16/04/2021 11:32, Valentin Schneider wrote:
> >>>>> On 16/04/21 15:47, Ruifeng Zhang wrote:
>
> [...]
>
> >> I'm afraid that this is now a much weaker case to get this into
> >> mainline.
> >
> > But it's still a problem and it's not break the original logic ( parse
> > topology from MPIDR or parse capacity ), only add the support for
> > parse topology from DT.
> > I think it should still be merged into the mainline. If don't, the
> > DynamIQ SoC has some issue in sched and cpufreq.
>
> IMHO, not necessarily. Your DynamIQ SoC is one cluster with 8 CPUs. It's
> subdivided into 2 Frequency Domains (FDs).
>
> CFS Energy-Aware-Scheduling (EAS, find_energy_efficient_cpu()) and
> Capacity-Aware-Scheduling (CAS, select_idle_sibling() ->
> select_idle_capacity()) work correctly even in case you only have an MC
> sched domain (sd).
> No matter which sd (MC, DIE) the sd_asym_cpucapacity is, we always
> iterate over all CPUs. Per Performance Domains (i.e. FDs) in EAS and
> over sched_domain_span(sd) in CAS.
>
> CFS load-balancing (in case your system is `over-utilized`) might work
> slightly different due to the missing DIE sd but not inevitably worse.
>
> Do you have benchmarks or testcases in mind which convince you that
> Phantom Domains is something you would need? BTW, they are called
> Phantom since they let you use uarch and/or max CPU frequency domain to
> fake real topology (like LLC) boundaries.

I'm researching the impact of all CPUs in the same cluster, such as
DVFS. If there is any progress in the future, I hope to keep
communicating with you. Thank you very much.
>
> [...]
>
> > Why do you keep the logic of topology_parse_cpu_capacity in arm
> > get_coretype_capacity function? The capacity-dmips-mhz will be parsed
> > by drivers/base/arch_topology.c as following:
> > parse_dt_topology
> >     parse_cluster
> >         parse_core
> >             get_cpu_for_node
> >                 topology_parse_cpu_capacity
>
> I think we still need it for systems out there w/o cpu-map in dt, like
> my arm32 TC2 with mainline vexpress-v2p-ca15_a7.dts.
>
> It's called twice on each CPU in case I add the cpu-map dt entry though.
