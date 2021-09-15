Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C1840C525
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhIOMZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:25:12 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:57804 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhIOMZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:25:07 -0400
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 595597A0350;
        Wed, 15 Sep 2021 14:23:46 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Thomas Gleixner <tglx@linutronix.de>
Subject: IOPL emulation breaks hpasmd (hp-health) needed by HP DL380 G4 servers
Date:   Wed, 15 Sep 2021 14:23:43 +0200
User-Agent: KMail/1.9.10
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202109151423.43604.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
after upgrading Debian from 10 (kernel 4.19.194) to 11 (kernel 5.10.46) on HP
DL380 G4 servers, hpasmd segfaults. Booting the 4.19.194 kernel allows hpasmd
to work.

hpasmd is a binary-only crap that is required on these servers for the fan
regulation to work. Without it, fans run at full speed, producing too much
noise and consuming power.
The last version that works on these servers comes from hp-health_8.7.0.1.2-5_amd64.deb package
(found on HP_ProLiant_Value_Add_Software-8.70-10-6.iso).
Newer versions of hp-health package lacks hpasmd binary and won't run (at
least iLO 2 is probably required).

Details:
[   11.539938] process 'hp/hp-health/bin/hpasmd' started with executable stack
[   11.720404] traps: hpasmd[389] general protection fault ip:f7ccc09b sp:ffb369e4 error:0 in mem[f7ccc000+3000]

# strace -f /opt/hp/hp-health/bin/hpasmd
[...]
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 65535, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7d64000
close(3)                                = 0
munmap(0xf7d64000, 65535)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 65535, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7d64000
close(3)                                = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 8192, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7f86000
close(3)                                = 0
munmap(0xf7d64000, 65535)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 65535, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xe0000) = 0xf7d64000
close(3)                                = 0
munmap(0xf7d64000, 65535)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 32767, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xc8000) = 0xf7d6c000
close(3)                                = 0
munmap(0xf7d6c000, 32767)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 65535, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xd0000) = 0xf7d64000
close(3)                                = 0
munmap(0xf7d64000, 65535)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xfff8c000) = 0xf7f82000
close(3)                                = 0
munmap(0xf7f82000, 16384)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 8192, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xfffa6000) = 0xf7f84000
close(3)                                = 0
mprotect(0x80b6000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 65535, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7d64000
close(3)                                = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 8342, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7d61000
close(3)                                = 0
--- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL, si_addr=NULL} ---
+++ killed by SIGSEGV +++

First thought that the problem is caused by /dev/mem restrictions but it's not.
The same problem affects /opt/hp/hp-health/bin/IrqRouteTbl:
# strace -f /opt/hp/hp-health/bin/IrqRouteTbl
execve("/opt/hp/hp-health/bin/IrqRouteTbl", ["/opt/hp/hp-health/bin/IrqRouteTb"...], 0x7ffe4dfd1148 /* 22 vars */) = 0
[ Process PID=494 runs in 32 bit mode. ]
brk(NULL)                               = 0x94ac000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fc6000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=20522, ...}) = 0
mmap2(NULL, 20522, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7fc0000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/lib32/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\3\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\357\1\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1993968, ...}) = 0
mmap2(NULL, 2002876, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7dd7000
mprotect(0xf7df4000, 1859584, PROT_NONE) = 0
mmap2(0xf7df4000, 1396736, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1d000) = 0xf7df4000
mmap2(0xf7f49000, 458752, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x172000) = 0xf7f49000
mmap2(0xf7fba000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e2000) = 0xf7fba000
mmap2(0xf7fbe000, 8124, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7fbe000
close(3)                                = 0
set_thread_area({entry_number=-1, base_addr=0xf7fc7100, limit=0x0fffff, seg_32bit=1, contents=0, read_exec_only=0, limit_in_pages=1, seg_not_present=0, useable=1}) = 0 (entry_number=12)
mprotect(0xf7fba000, 8192, PROT_READ)   = 0
mprotect(0xf7ff8000, 4096, PROT_READ)   = 0
munmap(0xf7fc0000, 20522)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 65535, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7dc7000
close(3)                                = 0
munmap(0xf7dc7000, 65535)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 65535, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7dc7000
close(3)                                = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 8192, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7fc4000
close(3)                                = 0
munmap(0xf7dc7000, 65535)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 65535, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xe0000) = 0xf7dc7000
close(3)                                = 0
munmap(0xf7dc7000, 65535)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 32767, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xc8000) = 0xf7dcf000
close(3)                                = 0
munmap(0xf7dcf000, 32767)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 65535, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xd0000) = 0xf7dc7000
close(3)                                = 0
munmap(0xf7dc7000, 65535)               = 0
iopl(3)                                 = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 8342, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7fc1000
close(3)                                = 0
iopl(3)                                 = 0
--- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL, si_addr=NULL} ---
+++ killed by SIGSEGV +++
Segmentation fault

Noticed the iopl(3) call. Checked out a kernel before "x86/iopl: Remove legacy IOPL option"
(a24ca9976843156eabbc5f2d798954b5674d1b61) and built with CONFIG_X86_IOPL_LEGACY.
It works!.

# uname -a
Linux edi2 5.4.0-rc7+ #428 SMP Wed Sep 15 14:01:53 CEST 2021 x86_64 GNU/Linux
# hpasmcli -s "show fans"

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

Building the same kernel with CONFIG_X86_IOPL_EMULATION breaks it again.

I even disassembled /opt/hp/hp-health/bin/IrqRouteTbl (it's only 5952 bytes
and does not use any hp libs). There's no CLI, only a couple of INs and OUTs:
 8048f3e:       66 ba 85 00             mov    dx,0x85
 8048f42:       ee                      out    dx,al
 8048f43:       66 ba 84 00             mov    dx,0x84
 8048f47:       88 e0                   mov    al,ah
 8048f49:       ee                      out    dx,al
...
 8048f5f:       66 ba d4 0c             mov    dx,0xcd4
 8048f63:       ec                      in     al,dx
 8048f64:       0c 80                   or     al,0x80
 8048f66:       ee                      out    dx,al
 8048f67:       66 ba d4 0c             mov    dx,0xcd4
 8048f6b:       ec                      in     al,dx
...
 8048f75:       66 ba 84 00             mov    dx,0x84
 8048f79:       66 b8 00 00             mov    ax,0x0
 8048f7d:       ee                      out    dx,al
 8048f7e:       66 ba 85 00             mov    dx,0x85
 8048f82:       ee                      out    dx,al

But I still don't know what's going on.

-- 
Ondrej Zary
