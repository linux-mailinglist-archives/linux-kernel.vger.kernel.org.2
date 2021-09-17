Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2743240F3D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhIQIM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:12:58 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:40634 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhIQIM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:12:57 -0400
Received: from [192.168.1.3] (ns.gsystem.sk [62.176.172.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 493C07A0214;
        Fri, 17 Sep 2021 10:11:34 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Peter Zijlstra <peterz@infradead.org>
Subject: Re: IOPL emulation breaks hpasmd (hp-health) needed by HP DL380 G4 servers
Date:   Fri, 17 Sep 2021 10:11:31 +0200
User-Agent: KMail/1.9.10
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <202109151423.43604.linux@zary.sk> <202109162227.17415.linux@zary.sk> <20210916210509.GG4323@worktop.programming.kicks-ass.net>
In-Reply-To: <20210916210509.GG4323@worktop.programming.kicks-ass.net>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202109171011.31916.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2021, Peter Zijlstra wrote:
> On Thu, Sep 16, 2021 at 10:27:17PM +0200, Ondrej Zary wrote:
> > (gdb) run
> > Starting program: /opt/hp/hp-health/bin/IrqRouteTbl
> > 
> > Program received signal SIGSEGV, Segmentation fault.
> > 0xf7fc509b in ?? ()
> > (gdb) bt
> > #0  0xf7fc509b in ?? ()
> > #1  0x08048848 in ?? ()
> > #2  0x08048aa1 in ?? ()
> > #3  0x08048e05 in ?? ()
> > #4  0xf7df9e46 in __libc_start_main () from /lib32/libc.so.6
> > #5  0xf7ffd000 in ?? () from /lib/ld-linux.so.2
> > Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> > (gdb) x/3i $pc
> > => 0xf7fc509b:  cli
> >    0xf7fc509c:  push   %ebp
> >    0xf7fc509d:  mov    %esp,%ebp
> > 
> > OMG, maybe is it calling into the mmapped BIOS area?
> 
> Lol... does something like the below (which *really* wants to be behind
> something like sysctl.iopl_fake_if) work for you?
> 
> ---
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..55c3904e656d 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -528,6 +528,34 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
>  
>  #define GPFSTR "general protection fault"
>  
> +bool fixup_iopl_exception(struct pt_regs *regs)
> +{
> +	struct thread_struct *t = &current->thread;
> +	unsigned char buf[MAX_INSN_SIZE];
> +	struct insn insn;
> +	int nr_copied;
> +
> +	if (!IS_ENABLED(CONFIG_X86_IOPL_IOPERM) || t->iopl_emul != 3 || !regs)
> +		return false;
> +
> +	nr_copied = insn_fetch_from_user(regs, buf);
> +	if (nr_copied <= 0)
> +		return false;
> +
> +	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
> +		return false;
> +
> +	if (insn.length != 1)
> +		return false;
> +
> +	if (insn.opcode.bytes[0] != 0xfa &&
> +	    insn.opcode.bytes[0] != 0xfb)
> +		return false;
> +
> +	regs->ip += 1;
> +	return true;
> +}
> +
>  DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  {
>  	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
> @@ -553,6 +581,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	tsk = current;
>  
>  	if (user_mode(regs)) {
> +		if (fixup_iopl_exception(regs))
> +			goto exit;
> +
>  		tsk->thread.error_code = error_code;
>  		tsk->thread.trap_nr = X86_TRAP_GP;
>  
> 

Yeah, it works!

# uname -a
Linux edi2 5.15.0-rc1+ #429 SMP Fri Sep 17 08:45:36 CEST 2021 x86_64 GNU/Linux

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

# strace -f /opt/hp/hp-health/bin/IrqRouteTbl
execve("/opt/hp/hp-health/bin/IrqRouteTbl", ["/opt/hp/hp-health/bin/IrqRouteTb"...], 0x7ffcdc970c48 /* 21 vars */) = 0
[ Process PID=469 runs in 32 bit mode. ]
brk(NULL)                               = 0x91c8000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f47000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=20522, ...}) = 0
mmap2(NULL, 20522, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7f41000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/lib32/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\3\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\357\1\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1993968, ...}) = 0
mmap2(NULL, 2002876, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7d58000
mprotect(0xf7d75000, 1859584, PROT_NONE) = 0
mmap2(0xf7d75000, 1396736, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1d000) = 0xf7d75000
mmap2(0xf7eca000, 458752, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x172000) = 0xf7eca000
mmap2(0xf7f3b000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e2000) = 0xf7f3b000
mmap2(0xf7f3f000, 8124, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7f3f000
close(3)                                = 0
set_thread_area({entry_number=-1, base_addr=0xf7f48100, limit=0x0fffff, seg_32bit=1, contents=0, read_exec_only=0, limit_in_pages=1, seg_not_present=0, useable=1}) = 0 (entry_number=12)
mprotect(0xf7f3b000, 8192, PROT_READ)   = 0
mprotect(0xf7f79000, 4096, PROT_READ)   = 0
munmap(0xf7f41000, 20522)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 65535, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7d48000
close(3)                                = 0
munmap(0xf7d48000, 65535)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 65535, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7d48000
close(3)                                = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 8192, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7f45000
close(3)                                = 0
munmap(0xf7d48000, 65535)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 65535, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xe0000) = 0xf7d48000
close(3)                                = 0
munmap(0xf7d48000, 65535)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 32767, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xc8000) = 0xf7d50000
close(3)                                = 0
munmap(0xf7d50000, 32767)               = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 65535, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xd0000) = 0xf7d48000
close(3)                                = 0
munmap(0xf7d48000, 65535)               = 0
iopl(3)                                 = 0
openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 8342, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7f42000
close(3)                                = 0
iopl(3)                                 = 0
iopl(3)                                 = 0
brk(NULL)                               = 0x91c8000
brk(0x91e9000)                          = 0x91e9000
brk(0x91ea000)                          = 0x91ea000
openat(AT_FDCWD, "/opt/compaq/utils/IrqRouteTable", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/opt/hp/hp-health/IrqRouteTable", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
write(3, "\n\10a\270\0b\270\0a\270\0b\270\0\1\0\6\10b\270\0a\270\0b\270\0a\270\0\2\0"..., 112) = 112
close(3)                                = 0
brk(0x91e9000)                          = 0x91e9000
exit_group(0)                           = ?
+++ exited with 0 +++



-- 
Ondrej Zary
