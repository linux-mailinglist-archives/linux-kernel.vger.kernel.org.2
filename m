Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3E843E600
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJ1QYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhJ1QYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:24:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72127C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:21:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so1497647wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m20iJzl8FCJn3/Aq4QjAnuM6BFP3jWxbcygupmKPknQ=;
        b=WDooaRy7PXz6OqsUeaLv8dmpmyg/sNWvRiEqsEd6HD4elIO6AGrhnc/P5BFTMA1H+W
         Jz2XP6P5SrsOusyzxIfKt0gpEyZhSY+5rSvk956c5oZ/+0QN3iiHOzfe9kUAvqI0fPHi
         /gxnjfzRLGkZ9clVei9RxyalrDzjj4WAvaK/3YiiRjBGXB1pVBa6WKUAusNMAEpB/A7T
         eWIKGk/eRkw7P5kJarT06cSwfAtnLqpIiweucWHx/RIhJpMHAX0BWbdlQwbWS+nDIb2z
         130XTrigzHvGSJEpKEcMaojXdlddl5LgaZNHKeMqvmoYDyH4jndO469YjiPsv7ByOxo+
         L5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m20iJzl8FCJn3/Aq4QjAnuM6BFP3jWxbcygupmKPknQ=;
        b=2gBmt7xrTXYb6Kr2xbw/f3rJR6mfQS5KlGp8aQR9Y1Pg32PvGb78WANXDqw787Sj3O
         3rAGTKcfMHEYLJO9hVOODsxbchD1top3QBfJFfoyYF68u7XnyF28b2WLvyjMx34V51nD
         /pWoEjxqPpo2EwgcbDeEIyOqko8hoA7qvBJHj0I0HK1fmnNB1cFEc5b+zX/Z2Leu8vom
         tDayq8dx29RtiUfqDoCWClLVT3gIZURQv/ahS1vG6rHg+m8oxDKFeCoo6nqilc8E5sko
         oVXyrRgR1O4clIGurbxwWMZn1uQpXZrRzCgbV0LrgbOabXcCLHW2VKdbut3ngnnNEJ8/
         iWmA==
X-Gm-Message-State: AOAM531vsBoU86EY98RBdySiKY8FwHuVKxlc86mDFyIgaRpbKcozgYqL
        A1uqUx0feT19b+EVPkxFCOO02NZu6w7J++CqcwuVvg==
X-Google-Smtp-Source: ABdhPJzclTDye6i6Mg+/6rgfW/2emgoOi3qnHH4nhc0/AORC01ItLoXAFvdAIP1y/8e/hTe3hzSkvV1n0cRr4jofZ+g=
X-Received: by 2002:a05:600c:2f97:: with SMTP id t23mr13981310wmn.59.1635438102851;
 Thu, 28 Oct 2021 09:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAOnJCU+MSP1QdpRRGYUpen8xZU+kn3PcSMJnZnRQw-iATs8JgQ@mail.gmail.com>
 <mhng-51188428-41ff-4962-b548-bf514a779723@palmerdabbelt-glaptop>
In-Reply-To: <mhng-51188428-41ff-4962-b548-bf514a779723@palmerdabbelt-glaptop>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 28 Oct 2021 21:51:31 +0530
Message-ID: <CAAhSdy2oV9fNtsY258h6zQS6Us7GyW6B_ox6U1Um2Why354-gA@mail.gmail.com>
Subject: Re: Out-of-bounds access when hartid >= NR_CPUS
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, re@w6rz.net,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 8:39 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 27 Oct 2021 16:34:15 PDT (-0700), atishp@atishpatra.org wrote:
> > On Tue, Oct 26, 2021 at 2:34 AM Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> >>
> >> Am Dienstag, 26. Oktober 2021, 10:57:26 CEST schrieb Geert Uytterhoeve=
n:
> >> > Hi Heiko,
> >> >
> >> > On Tue, Oct 26, 2021 at 10:53 AM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
> >> > > Am Dienstag, 26. Oktober 2021, 08:44:31 CEST schrieb Geert Uytterh=
oeven:
> >> > > > On Tue, Oct 26, 2021 at 2:37 AM Ron Economos <re@w6rz.net> wrote=
:
> >> > > > > On 10/25/21 8:54 AM, Geert Uytterhoeven wrote:
> >> > > > > > When booting a kernel with CONFIG_NR_CPUS=3D4 on Microchip P=
olarFire,
> >> > > > > > the 4th CPU either fails to come online, or the system crash=
es.
> >> > > > > >
> >> > > > > > This happens because PolarFire has 5 CPU cores: hart 0 is an=
 e51,
> >> > > > > > and harts 1-4 are u54s, with the latter becoming CPUs 0-3 in=
 Linux:
> >> > > > > >    - unused core has hartid 0 (sifive,e51),
> >> > > > > >    - processor 0 has hartid 1 (sifive,u74-mc),
> >> > > > > >    - processor 1 has hartid 2 (sifive,u74-mc),
> >> > > > > >    - processor 2 has hartid 3 (sifive,u74-mc),
> >> > > > > >    - processor 3 has hartid 4 (sifive,u74-mc).
> >> > > > > >
> >> > > > > > I assume the same issue is present on the SiFive fu540 and f=
u740
> >> > > > > > SoCs, but I don't have access to these.  The issue is not pr=
esent
> >> > > > > > on StarFive JH7100, as processor 0 has hartid 1, and process=
or 1 has
> >> > > > > > hartid 0.
> >> > > > > >
> >> > > > > > arch/riscv/kernel/cpu_ops.c has:
> >> > > > > >
> >> > > > > >      void *__cpu_up_stack_pointer[NR_CPUS] __section(".data"=
);
> >> > > > > >      void *__cpu_up_task_pointer[NR_CPUS] __section(".data")=
;
> >> > > > > >
> >> > > > > >      void cpu_update_secondary_bootdata(unsigned int cpuid,
> >> > > > > >                                         struct task_struct *=
tidle)
> >> > > > > >      {
> >> > > > > >              int hartid =3D cpuid_to_hartid_map(cpuid);
> >> > > > > >
> >> > > > > >              /* Make sure tidle is updated */
> >> > > > > >              smp_mb();
> >> > > > > >              WRITE_ONCE(__cpu_up_stack_pointer[hartid],
> >> > > > > >                         task_stack_page(tidle) + THREAD_SIZE=
);
> >> > > > > >              WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle=
);
> >> > > > > >
> >> > > > > > The above two writes cause out-of-bound accesses beyond
> >> > > > > > __cpu_up_{stack,pointer}_pointer[] if hartid >=3D CONFIG_NR_=
CPUS.
> >> > > > > >
> >> > > > > >      }
> >> >
> >> > > > https://riscv.org/wp-content/uploads/2017/05/riscv-privileged-v1=
.10.pdf
> >> > > > says:
> >> > > >
> >> > > >     Hart IDs might not necessarily be numbered contiguously in a
> >> > > >     multiprocessor system, but at least one hart must have a har=
t
> >> > > >     ID of zero.
> >> > > >
> >> > > > Which means indexing arrays by hart ID is a no-go?
> >> > >
> >> > > Isn't that also similar on aarch64?
> >> > >
> >> > > On a rk3399 you get 0-3 and 100-101 and with the paragraph above
> >> > > something like this could very well exist on some riscv cpu too I =
guess.
> >> >
> >> > Yes, it looks like hart IDs are similar to MPIDRs on ARM.
> >>
> >> and they have the set_cpu_logical_map construct to map hwids
> >> to a continuous list of cpu-ids.
> >>
> >> So with hartids not being necessarily continuous this looks like
> >> riscv would need a similar mechanism.
> >>
> >
> > RISC-V already has a similar mechanism cpuid_to_hartid_map. Logical
> > cpu ids are continuous
> > while hartid can be sparse.
> >
> > The issue here is that __cpu_up_stack/task_pointer are per hart but
> > array size depends on the NR_CPUs
> > which represents the logical CPU.
> >
> > That's why, having a maximum number of hartids defined in config will
> > be helpful.
>
> I don't understand why we'd have both: if we can't find a CPU number for
> a hart, then all we can do is just leave it offline.  Wouldn't it be
> simpler to just rely on NR_CPUS?  We'll need to fix the crashes on
> overflows either way.,

For HSM ops, we can easily fix this limitation because the HART
start call has an opaque parameter which can be used to specify TP
and SP for the HART being brought up.

For spinwait ops, I don't see much value in fixing sparse hartid
problems so let's document this problem and have appropriate
checks in spinwait ops for out-of-bound array checks.

Regards,
Anup
