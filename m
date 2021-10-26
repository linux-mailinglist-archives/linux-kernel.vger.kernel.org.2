Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44F43AF15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhJZJac convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Oct 2021 05:30:32 -0400
Received: from gloria.sntech.de ([185.11.138.130]:35628 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233688AbhJZJab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:30:31 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mfIkT-0004nO-E1; Tue, 26 Oct 2021 11:28:01 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     re@w6rz.net, linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Out-of-bounds access when hartid >= NR_CPUS
Date:   Tue, 26 Oct 2021 11:28:00 +0200
Message-ID: <1714720.9tEa3Li8Nu@diego>
In-Reply-To: <CAMuHMdW7NCC3siVp6avaTRffrdFr+OMXvLeGzdHZJOg+B5aGJw@mail.gmail.com>
References: <CAMuHMdUPWOjJfJohxLJefHOrJBtXZ0xfHQt4=hXpUXnasiN+AQ@mail.gmail.com> <2328512.Zi2KH1A685@diego> <CAMuHMdW7NCC3siVp6avaTRffrdFr+OMXvLeGzdHZJOg+B5aGJw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 26. Oktober 2021, 10:57:26 CEST schrieb Geert Uytterhoeven:
> Hi Heiko,
> 
> On Tue, Oct 26, 2021 at 10:53 AM Heiko Stübner <heiko@sntech.de> wrote:
> > Am Dienstag, 26. Oktober 2021, 08:44:31 CEST schrieb Geert Uytterhoeven:
> > > On Tue, Oct 26, 2021 at 2:37 AM Ron Economos <re@w6rz.net> wrote:
> > > > On 10/25/21 8:54 AM, Geert Uytterhoeven wrote:
> > > > > When booting a kernel with CONFIG_NR_CPUS=4 on Microchip PolarFire,
> > > > > the 4th CPU either fails to come online, or the system crashes.
> > > > >
> > > > > This happens because PolarFire has 5 CPU cores: hart 0 is an e51,
> > > > > and harts 1-4 are u54s, with the latter becoming CPUs 0-3 in Linux:
> > > > >    - unused core has hartid 0 (sifive,e51),
> > > > >    - processor 0 has hartid 1 (sifive,u74-mc),
> > > > >    - processor 1 has hartid 2 (sifive,u74-mc),
> > > > >    - processor 2 has hartid 3 (sifive,u74-mc),
> > > > >    - processor 3 has hartid 4 (sifive,u74-mc).
> > > > >
> > > > > I assume the same issue is present on the SiFive fu540 and fu740
> > > > > SoCs, but I don't have access to these.  The issue is not present
> > > > > on StarFive JH7100, as processor 0 has hartid 1, and processor 1 has
> > > > > hartid 0.
> > > > >
> > > > > arch/riscv/kernel/cpu_ops.c has:
> > > > >
> > > > >      void *__cpu_up_stack_pointer[NR_CPUS] __section(".data");
> > > > >      void *__cpu_up_task_pointer[NR_CPUS] __section(".data");
> > > > >
> > > > >      void cpu_update_secondary_bootdata(unsigned int cpuid,
> > > > >                                         struct task_struct *tidle)
> > > > >      {
> > > > >              int hartid = cpuid_to_hartid_map(cpuid);
> > > > >
> > > > >              /* Make sure tidle is updated */
> > > > >              smp_mb();
> > > > >              WRITE_ONCE(__cpu_up_stack_pointer[hartid],
> > > > >                         task_stack_page(tidle) + THREAD_SIZE);
> > > > >              WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
> > > > >
> > > > > The above two writes cause out-of-bound accesses beyond
> > > > > __cpu_up_{stack,pointer}_pointer[] if hartid >= CONFIG_NR_CPUS.
> > > > >
> > > > >      }
> 
> > > https://riscv.org/wp-content/uploads/2017/05/riscv-privileged-v1.10.pdf
> > > says:
> > >
> > >     Hart IDs might not necessarily be numbered contiguously in a
> > >     multiprocessor system, but at least one hart must have a hart
> > >     ID of zero.
> > >
> > > Which means indexing arrays by hart ID is a no-go?
> >
> > Isn't that also similar on aarch64?
> >
> > On a rk3399 you get 0-3 and 100-101 and with the paragraph above
> > something like this could very well exist on some riscv cpu too I guess.
> 
> Yes, it looks like hart IDs are similar to MPIDRs on ARM.

and they have the set_cpu_logical_map construct to map hwids
to a continuous list of cpu-ids.

So with hartids not being necessarily continuous this looks like
riscv would need a similar mechanism.


