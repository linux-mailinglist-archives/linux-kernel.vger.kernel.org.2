Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C598931CF23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhBPRgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:36:25 -0500
Received: from sym2.noone.org ([178.63.92.236]:41682 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229876AbhBPRgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:36:21 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4Dg7RF0q3kzvjfn; Tue, 16 Feb 2021 18:35:36 +0100 (CET)
Date:   Tue, 16 Feb 2021 18:35:36 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alex Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
        Bjorn Topel <bjorn.topel@gmail.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        LKML <linux-kernel@vger.kernel.org>, nylon7@andestech.com,
        syzkaller <syzkaller@googlegroups.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: riscv+KASAN does not boot
Message-ID: <20210216173534.54vzyfzdm5ioxu7t@distanz.ch>
References: <CACT4Y+bDqMiC+ou5ghb=XB3Oyjw3p-GTDvNw4NkkQqQthw1yuQ@mail.gmail.com>
 <mhng-02b88d43-ede8-48f9-82f1-c84201acb7a8@palmerdabbelt-glaptop>
 <CACT4Y+aN3LvgaBc_zmW=t=D7ChU-jrWYnjt5sZ2GEDQhg_BC9A@mail.gmail.com>
 <CACT4Y+aC19DaNOm87EO3cER2=MEmO9pmtUxzVmRtg9YhZKuMVA@mail.gmail.com>
 <20210118145310.crnqnh6kax5jqicj@distanz.ch>
 <CACT4Y+bFV6m1LCYb1nO7ioKJK99916D76sJ+H-LgBjWx6biF5w@mail.gmail.com>
 <CACT4Y+bmDKNnykeTP9yKjje3XZjbXY3De+_e3fMFOMoe0dnARw@mail.gmail.com>
 <6e9ee3a1-0e16-b1fc-a690-f1ca8e9823a5@ghiti.fr>
 <CACT4Y+adSjve7bXRPh5UybCQx6ubOUu5RbwuT620wdcxHzVYJg@mail.gmail.com>
 <CACT4Y+ZNJBnkKHXUf=tm_yuowvZvHwN=0rmJ=7J+xFd+9r_6pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZNJBnkKHXUf=tm_yuowvZvHwN=0rmJ=7J+xFd+9r_6pQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-16 at 12:17:30 +0100, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Jan 29, 2021 at 9:11 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > I was fixing KASAN support for my sv48 patchset so I took a look at your
> > > issue: I built a kernel on top of the branch riscv/fixes using
> > > https://github.com/google/syzkaller/blob/269d24e857a757d09a898086a2fa6fa5d827c3e1/dashboard/config/linux/upstream-riscv64-kasan.config
> > > and Buildroot 2020.11. I have the warnings regarding the use of
> > > __virt_to_phys on wrong addresses (but that's normal since this function
> > > is used in virt_addr_valid) but not the segfaults you describe.
> >
> > Hi Alex,
> >
> > Let me try to rebuild buildroot image. Maybe there was something wrong
> > with my build, though, I did 'make clean' before doing. But at the
> > same time it worked back in June...
> >
> > Re WARNINGs, they indicate kernel bugs. I am working on setting up a
> > syzbot instance on riscv. If there a WARNING during boot then the
> > kernel will be marked as broken. No further testing will happen.
> > Is it a mis-use of WARN_ON? If so, could anybody please remove it or
> > replace it with pr_err.
> 
> 
> Hi,
> 
> I've localized one issue with riscv/KASAN:
> KASAN breaks VDSO and that's I think the root cause of weird faults I
> saw earlier. The following patch fixes it.
> Could somebody please upstream this fix? I don't know how to add/run
> tests for this.

Thanks. I've tested the fix locally using vDSO selftests and sent the
fix upstream [1]

[1] https://lore.kernel.org/linux-riscv/20210216173305.2500-1-tklauser@distanz.ch/T/#u
