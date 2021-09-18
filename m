Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8874410771
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 17:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbhIRPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 11:55:25 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:55630 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237245AbhIRPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 11:55:24 -0400
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 4323D7A02A5;
        Sat, 18 Sep 2021 17:53:59 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/iopl: Fake iopl(3) CLI/STI usage
Date:   Sat, 18 Sep 2021 17:53:55 +0200
User-Agent: KMail/1.9.10
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202109151423.43604.linux@zary.sk> <YUWPuPyBxR9OVtXS@hirez.programming.kicks-ass.net> <20210918090641.GD5106@worktop.programming.kicks-ass.net>
In-Reply-To: <20210918090641.GD5106@worktop.programming.kicks-ass.net>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202109181753.55995.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 September 2021 11:06:41 Peter Zijlstra wrote:
> On Sat, Sep 18, 2021 at 09:05:28AM +0200, Peter Zijlstra wrote:
> > On Fri, Sep 17, 2021 at 03:24:51PM -0700, Linus Torvalds wrote:
> > > On Fri, Sep 17, 2021 at 3:23 PM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > I think the proper thing to do is perhaps something like
> > > 
> > > The alternative is to just ignore cs_abse entirely, and just use
> > > "regs->ip", which makes this all even easier.
> > > 
> > > If somebody uses a code segment _and_ cli/sti, maybe they should just
> > > get the SIGSEGV?
> > 
> > I did a hatched job on fixup_ump_exception() which is why it looks like
> > it does, that said...
> > 
> > our case at hand mmap()'s BIOS code from /dev/mem and executes that, I
> > don't think it does an LDT segment but it would be entirely in line with
> > the level of hack we're looking at.
> > 
> > Let me frob at this after breakfast and see if I can make it better.
> 
> How's this then? I should probably look to see if I should be using this
> insn_get_effective_ip() for perf_instruction_pointer() too. Although I
> suspect we maybe took a shortcut there in favour of performance.

Good for me because it works.
# dmesg | tail
[    7.229031] Console: switching to colour frame buffer device 128x48
[    7.234234] atyfb: fb0: ATY Mach64 frame buffer device on PCI
[    7.929907] random: crng init done
[    7.929913] random: 7 urandom warning(s) missed due to ratelimiting
[    8.441701] process 'hp/hp-health/bin/hpasmd' started with executable stack
[    8.638998] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:f7cb109b in mem[f7cb1000+3000]
[   10.253851] floppy0: no floppy controllers found
[   16.413225] tg3 0000:03:01.0 enp3s1f0: Link is up at 1000 Mbps, full duplex
[   16.413257] tg3 0000:03:01.0 enp3s1f0: Flow control is on for TX and on for RX
[   16.414645] IPv6: ADDRCONF(NETDEV_CHANGE): enp3s1f0: link becomes ready
root@edi2:/home/edi# hpasmcli -s "show fans"

Fan  Location        Present Speed  of max  Redundant  Partner  Hot-pluggable
---  --------        ------- -----  ------  ---------  -------  -------------
#1   PROCESSOR_ZONE  Yes     NORMAL  22%     Yes        2        Yes
#2   PROCESSOR_ZONE  Yes     NORMAL  22%     Yes        1        Yes
#3   I/O_ZONE        Yes     NORMAL  11%     Yes        1        Yes
#4   I/O_ZONE        Yes     NORMAL  11%     Yes        1        Yes
#5   PROCESSOR_ZONE  Yes     NORMAL  22%     Yes        1        Yes
#6   PROCESSOR_ZONE  Yes     NORMAL  22%     Yes        1        Yes
#7   POWERSUPPLY_BAY Yes     NORMAL  11%     Yes        1        Yes
#8   POWERSUPPLY_BAY Yes     NORMAL  11%     Yes        1        Yes


-- 
Ondrej Zary
