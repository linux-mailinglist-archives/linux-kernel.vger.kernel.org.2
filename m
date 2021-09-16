Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C9140EBAE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhIPU2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:28:43 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:34370 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhIPU2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:28:42 -0400
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 4A5A57A0214;
        Thu, 16 Sep 2021 22:27:20 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Thomas Gleixner <tglx@linutronix.de>
Subject: Re: IOPL emulation breaks hpasmd (hp-health) needed by HP DL380 G4 servers
Date:   Thu, 16 Sep 2021 22:27:17 +0200
User-Agent: KMail/1.9.10
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
References: <202109151423.43604.linux@zary.sk> <87pmt8a1mc.ffs@tglx>
In-Reply-To: <87pmt8a1mc.ffs@tglx>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202109162227.17415.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2021 19:09:31 Thomas Gleixner wrote:
> Ondrej,
> 
> On Wed, Sep 15 2021 at 14:23, Ondrej Zary wrote:
> > after upgrading Debian from 10 (kernel 4.19.194) to 11 (kernel 5.10.46) on HP
> > DL380 G4 servers, hpasmd segfaults. Booting the 4.19.194 kernel allows hpasmd
> > to work.
> >
> > Noticed the iopl(3) call. Checked out a kernel before "x86/iopl: Remove legacy IOPL option"
> > (a24ca9976843156eabbc5f2d798954b5674d1b61) and built with CONFIG_X86_IOPL_LEGACY.
> > It works!.
> >
> > I even disassembled /opt/hp/hp-health/bin/IrqRouteTbl (it's only 5952 bytes
> > and does not use any hp libs). There's no CLI, only a couple of INs and OUTs:
> > ...
> >  8048f75:       66 ba 84 00             mov    dx,0x84
> >  8048f79:       66 b8 00 00             mov    ax,0x0
> >  8048f7d:       ee                      out    dx,al
> >  8048f7e:       66 ba 85 00             mov    dx,0x85
> >  8048f82:       ee                      out    dx,al
> >
> > But I still don't know what's going on.
> 
> That's weird. Let me think about a way to debug that. I just ran a
> trivial test program which issues iopl(3) and reads all ports from
> 0-65535. That works like a charm.
> 
> #include <stdio.h>
> #include <sys/io.h>
> 
> int main(void)
> {
> 	unsigned int i;
> 	int ret;
> 
> 	ret = iopl(3);
> 	if (ret)
> 		return ret;
> 
> 	for (i = 0; i < 65536; i++)
> 		printf("%5u: %02x\n", i, inb(i));
> 
> 	return 0;
> }
> 
> Which CPU is in that machine?

A Netburst-based Xeon (1-core, HT):
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.00GHz
stepping        : 3
microcode       : 0x5
cpu MHz         : 2999.868
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc pebs bts nopl cpuid pni dtes64 monitor ds_cpl cid cx16 xtpr pti
bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs
bogomips        : 5999.73
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

> Can you please run that failing program with GDB and figure out which
> instruction causes #GP and what the register content is.

(gdb) run
Starting program: /opt/hp/hp-health/bin/IrqRouteTbl

Program received signal SIGSEGV, Segmentation fault.
0xf7fc509b in ?? ()
(gdb) bt
#0  0xf7fc509b in ?? ()
#1  0x08048848 in ?? ()
#2  0x08048aa1 in ?? ()
#3  0x08048e05 in ?? ()
#4  0xf7df9e46 in __libc_start_main () from /lib32/libc.so.6
#5  0xf7ffd000 in ?? () from /lib/ld-linux.so.2
Backtrace stopped: previous frame inner to this frame (corrupt stack?)
(gdb) x/3i $pc
=> 0xf7fc509b:  cli
   0xf7fc509c:  push   %ebp
   0xf7fc509d:  mov    %esp,%ebp

OMG, maybe is it calling into the mmapped BIOS area?


-- 
Ondrej Zary
