Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B95320A71
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhBUNJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:09:50 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:59902 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhBUNJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:09:46 -0500
X-Greylist: delayed 45781 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Feb 2021 08:09:45 EST
Date:   Sun, 21 Feb 2021 13:08:59 +0000
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        "Dmitry V . Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] ia64: fix ptrace(PTRACE_SYSCALL_INFO_EXIT) sign
Message-ID: <20210221130859.089ce1ed@sf>
In-Reply-To: <66569d56-1af0-a6bb-8b54-9d1cded893cd@physik.fu-berlin.de>
References: <20210221002554.333076-1-slyfox@gentoo.org>
        <20210221002554.333076-2-slyfox@gentoo.org>
        <66569d56-1af0-a6bb-8b54-9d1cded893cd@physik.fu-berlin.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Feb 2021 10:21:56 +0100
John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> Hi Sergei!
> 
> On 2/21/21 1:25 AM, Sergei Trofimovich wrote:
> > In https://bugs.gentoo.org/769614 Dmitry noticed that
> > `ptrace(PTRACE_GET_SYSCALL_INFO)` does not return error sign properly.
> > (...)  
> 
> Do these two patches unbreak gdb on ia64?

gdb was somewhat working on ia64 for Gentoo. strace was the main
impacted here.

But I did not try anything complicated recently. Anything specific that
breaks for you?

$ uname -r
5.10.0
(even without the patches above)

$ cat c.c
int main(){}
$ gcc c.c -o a -ggdb3
$ gdb --quiet ./a
Reading symbols from ./a...
(gdb) start
Temporary breakpoint 1 at 0x7f2: file c.c, line 1.
Starting program: /home/slyfox/a
Failed to read a valid object file image from memory.

Temporary breakpoint 1, main () at c.c:1
1	int main(){}
(gdb) disassemble
Dump of assembler code for function main:
   0x20000008000007f0 <+0>:	[MII]       mov r2=r12
   0x20000008000007f1 <+1>:	            mov r14=r0;;
=> 0x20000008000007f2 <+2>:	            mov r8=r14
   0x2000000800000800 <+16>:	[MIB]       mov r12=r2
   0x2000000800000801 <+17>:	            nop.i 0x0
   0x2000000800000802 <+18>:	            br.ret.sptk.many b0;;
End of assembler dump.
(gdb) break *0x2000000800000800
Breakpoint 2 at 0x2000000800000800: file c.c, line 1.
(gdb) continue
Continuing.

Breakpoint 2, 0x2000000800000800 in main () at c.c:1
1	int main(){}

Looks ok for minor stuff.

> And have you, by any chance, managed to get the hpsa driver working again?

v5.10 seems to boot off hpsa just fine without extra patches:
  14:01.0 RAID bus controller: Hewlett-Packard Company Smart Array P600
	Subsystem: Hewlett-Packard Company 3 Gb/s SAS RAID
	Kernel driver in use: hpsa

v5.11 does not boot yet. Kernel does not see some files while boots after init is
started  (but I'm not sure it's a block device problem). Bisecting now why.

-- 

  Sergei
