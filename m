Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E72343D797
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhJ0Xgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ0Xgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:36:53 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E4DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:34:27 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id y80so10445461ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oz3la9qDxujtDqexpAw2x+f60dyey4m7gnEBfsN5KGo=;
        b=TVQOUdZVVzlisn93Q+LsaGBEr2IstMf9+JFWH6dH1goJYJF/2/8r9e7/AIhv3vv5e5
         rGoIpe8uW+u4FYE3T5uF7fe8ndRXSSxdwV/LyJsSPCTGfgGiZI8rkDjp9eIiU4nwYfD9
         wzS/5hWEjqyhdnRQ8lELiKBSM/ZbP+HE/vWM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oz3la9qDxujtDqexpAw2x+f60dyey4m7gnEBfsN5KGo=;
        b=S4qMlHXXaMkgC3xjVwFdU4tvz3lg04ofGqBrZyt+yt8YwUGZuDjN8tJrAvZbSNIuPv
         qdRfo4drJdGkZtlk7DSta3sgfC1ltfNxuRzm++GvyD7zni2bAYJTMBqAXO5dsGimtqCb
         xbTgwEjhN6aAkLajdTJ0JmFtYaljyyAPNc/Wamx7Efq4eshalp8YOk19c4exF47ENYYf
         4cUxkh7eNrJ6ez1rBC2Z27aDxMk7S6DBEIErqD4+zyk0XRHLKRMUzqTals7qzm2/b8R2
         Nug23sR1qcE6XbSYQQnxwCqEvfne8IJ+xqewOuJ9ANyM+Zr7hQOcyMSzbx1gnW4I8MXZ
         iiSw==
X-Gm-Message-State: AOAM532wpzQsCgkNQjJHHMp6qMhK86TcAlgies879mqmUDEH9mvNkRVK
        F2hJUg1oyrdOkEt1SO8BI/86OZ5Kvk+1O6BMUnFR
X-Google-Smtp-Source: ABdhPJwhrNSWpRUm5Dd6OwK81WlAR7RS5KdtONsXjCmoK9nBs/HUgokkoMs+qszLWig8f/mg7j6YIiURyecYTovIUio=
X-Received: by 2002:a25:324d:: with SMTP id y74mr810941yby.526.1635377666261;
 Wed, 27 Oct 2021 16:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUPWOjJfJohxLJefHOrJBtXZ0xfHQt4=hXpUXnasiN+AQ@mail.gmail.com>
 <2328512.Zi2KH1A685@diego> <CAMuHMdW7NCC3siVp6avaTRffrdFr+OMXvLeGzdHZJOg+B5aGJw@mail.gmail.com>
 <1714720.9tEa3Li8Nu@diego>
In-Reply-To: <1714720.9tEa3Li8Nu@diego>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 27 Oct 2021 16:34:15 -0700
Message-ID: <CAOnJCU+MSP1QdpRRGYUpen8xZU+kn3PcSMJnZnRQw-iATs8JgQ@mail.gmail.com>
Subject: Re: Out-of-bounds access when hartid >= NR_CPUS
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, re@w6rz.net,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 2:34 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Dienstag, 26. Oktober 2021, 10:57:26 CEST schrieb Geert Uytterhoeven:
> > Hi Heiko,
> >
> > On Tue, Oct 26, 2021 at 10:53 AM Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> > > Am Dienstag, 26. Oktober 2021, 08:44:31 CEST schrieb Geert Uytterhoev=
en:
> > > > On Tue, Oct 26, 2021 at 2:37 AM Ron Economos <re@w6rz.net> wrote:
> > > > > On 10/25/21 8:54 AM, Geert Uytterhoeven wrote:
> > > > > > When booting a kernel with CONFIG_NR_CPUS=3D4 on Microchip Pola=
rFire,
> > > > > > the 4th CPU either fails to come online, or the system crashes.
> > > > > >
> > > > > > This happens because PolarFire has 5 CPU cores: hart 0 is an e5=
1,
> > > > > > and harts 1-4 are u54s, with the latter becoming CPUs 0-3 in Li=
nux:
> > > > > >    - unused core has hartid 0 (sifive,e51),
> > > > > >    - processor 0 has hartid 1 (sifive,u74-mc),
> > > > > >    - processor 1 has hartid 2 (sifive,u74-mc),
> > > > > >    - processor 2 has hartid 3 (sifive,u74-mc),
> > > > > >    - processor 3 has hartid 4 (sifive,u74-mc).
> > > > > >
> > > > > > I assume the same issue is present on the SiFive fu540 and fu74=
0
> > > > > > SoCs, but I don't have access to these.  The issue is not prese=
nt
> > > > > > on StarFive JH7100, as processor 0 has hartid 1, and processor =
1 has
> > > > > > hartid 0.
> > > > > >
> > > > > > arch/riscv/kernel/cpu_ops.c has:
> > > > > >
> > > > > >      void *__cpu_up_stack_pointer[NR_CPUS] __section(".data");
> > > > > >      void *__cpu_up_task_pointer[NR_CPUS] __section(".data");
> > > > > >
> > > > > >      void cpu_update_secondary_bootdata(unsigned int cpuid,
> > > > > >                                         struct task_struct *tid=
le)
> > > > > >      {
> > > > > >              int hartid =3D cpuid_to_hartid_map(cpuid);
> > > > > >
> > > > > >              /* Make sure tidle is updated */
> > > > > >              smp_mb();
> > > > > >              WRITE_ONCE(__cpu_up_stack_pointer[hartid],
> > > > > >                         task_stack_page(tidle) + THREAD_SIZE);
> > > > > >              WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
> > > > > >
> > > > > > The above two writes cause out-of-bound accesses beyond
> > > > > > __cpu_up_{stack,pointer}_pointer[] if hartid >=3D CONFIG_NR_CPU=
S.
> > > > > >
> > > > > >      }
> >
> > > > https://riscv.org/wp-content/uploads/2017/05/riscv-privileged-v1.10=
.pdf
> > > > says:
> > > >
> > > >     Hart IDs might not necessarily be numbered contiguously in a
> > > >     multiprocessor system, but at least one hart must have a hart
> > > >     ID of zero.
> > > >
> > > > Which means indexing arrays by hart ID is a no-go?
> > >
> > > Isn't that also similar on aarch64?
> > >
> > > On a rk3399 you get 0-3 and 100-101 and with the paragraph above
> > > something like this could very well exist on some riscv cpu too I gue=
ss.
> >
> > Yes, it looks like hart IDs are similar to MPIDRs on ARM.
>
> and they have the set_cpu_logical_map construct to map hwids
> to a continuous list of cpu-ids.
>
> So with hartids not being necessarily continuous this looks like
> riscv would need a similar mechanism.
>

RISC-V already has a similar mechanism cpuid_to_hartid_map. Logical
cpu ids are continuous
while hartid can be sparse.

The issue here is that __cpu_up_stack/task_pointer are per hart but
array size depends on the NR_CPUs
which represents the logical CPU.

That's why, having a maximum number of hartids defined in config will
be helpful.

>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
