Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903AF3910DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhEZGvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:51:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:8809 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230419AbhEZGvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:51:07 -0400
IronPort-SDR: EKhCodKH1+fUrTYGdb2ZluIfRJdcnjsnQWlKYspGo1H7rL+WiN1lOoFGqJdNTt6hbToGkV9z4y
 FRIjcRFonARw==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="199341934"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="c'?log'?scan'208";a="199341934"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 23:49:31 -0700
IronPort-SDR: VPxHKWIoJlql/F7Z3+UyDUzNPOb02+5IQJcbhv5GkBbdOHG0zZeG0t8FzVDkBnRLaf8ONLFWlL
 6dcowlGV08iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="c'?log'?scan'208";a="443863432"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 25 May 2021 23:49:23 -0700
Date:   Wed, 26 May 2021 14:49:22 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [clocksource]  8901ecc231:  stress-ng.lockbus.ops_per_sec -9.5%
 regression
Message-ID: <20210526064922.GD5262@shbuild999.sh.intel.com>
References: <20210521083322.GG25531@xsang-OptiPlex-9020>
 <20210521135617.GT4441@paulmck-ThinkPad-P17-Gen-1>
 <20210522160827.GA2625834@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20210522160827.GA2625834@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 22, 2021 at 09:08:27AM -0700, Paul E. McKenney wrote:
> On Fri, May 21, 2021 at 06:56:17AM -0700, Paul E. McKenney wrote:
> > On Fri, May 21, 2021 at 04:33:22PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed a -9.5% regression of stress-ng.lockbus.ops_per_sec due to commit:
> > > 
> > > 
> > > commit: 8901ecc2315b850f35a7b8c1b73b12388b72aa78 ("clocksource: Retry clock read if long delays detected")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > 
> > > 
> > > in testcase: stress-ng
> > > on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> > > with following parameters:
> > > 
> > > 	nr_threads: 100%
> > > 	disk: 1HDD
> > > 	testtime: 60s
> > > 	class: memory
> > > 	test: lockbus
> > > 	cpufreq_governor: performance
> > > 	ucode: 0x5003006
> > > 
> > > 
> > > please be noted below in dmesg.xz (attached)
> > > [   28.110351]
> > > [   28.302357] hrtimer: interrupt took 1878423 ns
> > > [   29.690760] clocksource: timekeeping watchdog on CPU53: hpet read-back delay of 169583ns, attempt 4, marking unstable
> > > [   29.860306] tsc: Marking TSC unstable due to clocksource watchdog
> > > [   30.559390] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> > > [   30.726282] sched_clock: Marking unstable (30052964508, 499342225)<-(30915547410, -363240730)
> > > [   31.620401] clocksource: Switched to clocksource hpet
> > 
> > If I am reading the dmesg correctly, there were many interrupts that
> > prevented a good clock read.  This sound to me like a bug that the
> > clocksource watchdog located, but please let me know if this is not
> > the case.
> >
> > There are also the later "perf: interrupt took too long" messages.
>
> And of course, increasing the clocksource.max_cswd_read_retries module
> boot parameter (or clocksource.max_read_retries in the earlier commits,
> which I will fix) can work around short bursts of NMIs.  Or long bursts
> of NMIs, if you set this kernel boot parameter large enough.

I reproduced it on a borrowed baremetal 4 nodes, 96C/192T Xeon, with
latest stress-ng code https://github.com/ColinIanKing/stress-ng.git.
(2 sockets box should also be able to reproduce it)

Seems this sub testcase 'lockbus' is a extreme stress case, by loop
doing "lock" operation:

  c8:	f0 83 00 01          	lock addl $0x1,(%rax)
  cc:	f0 83 40 04 01       	lock addl $0x1,0x4(%rax)
  d1:	f0 83 40 08 01       	lock addl $0x1,0x8(%rax)
  d6:	f0 83 40 0c 01       	lock addl $0x1,0xc(%rax)
  db:	f0 83 40 10 01       	lock addl $0x1,0x10(%rax)
  e0:	f0 83 40 14 01       	lock addl $0x1,0x14(%rax)
  e5:	f0 83 40 18 01       	lock addl $0x1,0x18(%rax)
  ea:	f0 83 40 1c 01       	lock addl $0x1,0x1c(%rax)
  ef:	f0 83 01 00          	lock addl $0x0,(%rcx)
  f3:	f0 83 01 00          	lock addl $0x0,(%rcx)
  f7:	f0 83 01 00          	lock addl $0x0,(%rcx)
  fb:	f0 83 01 00          	lock addl $0x0,(%rcx)
  ff:	f0 83 01 00          	lock addl $0x0,(%rcx)
 103:	f0 83 01 00          	lock addl $0x0,(%rcx)
 107:	f0 83 01 00          	lock addl $0x0,(%rcx)
 ...

(The source c file and objdump are attached fyi)

So the watchdog read (read_hpet() here) sometimes does take very
long time (hundreds of microseconds) which breaks this sanity
read check, and cause 'unstable' tsc.

As from the man page of stress-ng:
"Use stress-ng with caution as some of the tests can make a system
run hot on poorly designed hardware and also can cause excessive
system thrashing which may be difficult to stop"

I don't think this 'lockbus' is close to any real-world usage.

Thanks,
Feng

--fUYQa+Pmc3FrFX/N
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="stress-lockbus.c"

/*
 * Copyright (C) 2013-2021 Canonical, Ltd.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 * This code is a complete clean re-write of the stress tool by
 * Colin Ian King <colin.king@canonical.com> and attempts to be
 * backwardly compatible with the stress tool by Amos Waterland
 * <apw@rossby.metr.ou.edu> but has more stress tests and more
 * functionality.
 *
 */
#include "stress-ng.h"

static const stress_help_t help[] = {
	{ NULL,	"lockbus N",	 "start N workers locking a memory increment" },
	{ NULL,	"lockbus-ops N", "stop after N lockbus bogo operations" },
	{ NULL, NULL,		 NULL }
};

#if (((defined(__GNUC__) || defined(__clang__)) && 	\
       defined(STRESS_ARCH_X86)) ||			\
     (defined(__GNUC__) && 				\
      defined(HAVE_ATOMIC_ADD_FETCH) &&			\
      defined(__ATOMIC_SEQ_CST) &&			\
      NEED_GNUC(4,7,0) && 				\
      defined(STRESS_ARCH_ARM)))

#if defined(HAVE_ATOMIC_ADD_FETCH)
#define MEM_LOCK(ptr, inc)			\
do {						\
	 __atomic_add_fetch(ptr, inc, __ATOMIC_SEQ_CST);\
} while (0)
#else
#define MEM_LOCK(ptr, inc)			\
do {						\
	asm volatile("lock addl %1,%0" :	\
		     "+m" (*ptr) :		\
		     "ir" (inc));		\
} while (0)
#endif

#define BUFFER_SIZE	(1024 * 1024 * 16)
#define CHUNK_SIZE	(64 * 4)

#define MEM_LOCK_AND_INC(ptr, inc)		\
do {						\
	MEM_LOCK(ptr, inc);			\
	ptr++;					\
} while (0)

#define MEM_LOCK_AND_INCx8(ptr, inc)		\
do {						\
	MEM_LOCK_AND_INC(ptr, inc);		\
	MEM_LOCK_AND_INC(ptr, inc);		\
	MEM_LOCK_AND_INC(ptr, inc);		\
	MEM_LOCK_AND_INC(ptr, inc);		\
	MEM_LOCK_AND_INC(ptr, inc);		\
	MEM_LOCK_AND_INC(ptr, inc);		\
	MEM_LOCK_AND_INC(ptr, inc);		\
	MEM_LOCK_AND_INC(ptr, inc);		\
} while (0)

#define MEM_LOCKx8(ptr)				\
do {						\
	MEM_LOCK(ptr, 0);			\
	MEM_LOCK(ptr, 0);			\
	MEM_LOCK(ptr, 0);			\
	MEM_LOCK(ptr, 0);			\
	MEM_LOCK(ptr, 0);			\
	MEM_LOCK(ptr, 0);			\
	MEM_LOCK(ptr, 0);			\
	MEM_LOCK(ptr, 0);			\
} while (0)

#if defined(STRESS_ARCH_X86)
static sigjmp_buf jmp_env;
static bool do_splitlock;

static void NORETURN MLOCKED_TEXT stress_sigbus_handler(int signum)
{
	(void)signum;

	do_splitlock = false;

	siglongjmp(jmp_env, 1);
}
#endif

/*
 *  stress_lockbus()
 *      stress memory with lock and increment
 */
static int stress_lockbus(const stress_args_t *args)
{
	uint32_t *buffer;
	int flags = MAP_ANONYMOUS | MAP_SHARED;
#if defined(STRESS_ARCH_X86)
	uint32_t *splitlock_ptr1, *splitlock_ptr2;

	if (stress_sighandler(args->name, SIGBUS, stress_sigbus_handler, NULL) < 0)
		return EXIT_FAILURE;
#endif

#if defined(MAP_POPULATE)
	flags |= MAP_POPULATE;
#endif
	buffer = (uint32_t*)mmap(NULL, BUFFER_SIZE, PROT_READ | PROT_WRITE, flags, -1, 0);
	if (buffer == MAP_FAILED) {
		int rc = exit_status(errno);

		pr_err("%s: mmap failed\n", args->name);
		return rc;
	}

#if defined(STRESS_ARCH_X86)
	/* Split lock on a page boundary */
	splitlock_ptr1 = (uint32_t *)(((uint8_t *)buffer) + args->page_size - (sizeof(uint32_t) >> 1));
	/* Split lock on a cache boundary */
	splitlock_ptr2 = (uint32_t *)(((uint8_t *)buffer) + 64 - (sizeof(uint32_t) >> 1));
	do_splitlock = true;
	if (sigsetjmp(jmp_env, 1) && !keep_stressing(args))
		goto done;
#endif
	stress_set_proc_state(args->name, STRESS_STATE_RUN);

	do {
		uint32_t *ptr0 = buffer + ((stress_mwc32() % (BUFFER_SIZE - CHUNK_SIZE)) >> 2);
#if defined(STRESS_ARCH_X86)
		uint32_t *ptr1 = do_splitlock ? splitlock_ptr1 : ptr0;
		uint32_t *ptr2 = do_splitlock ? splitlock_ptr2 : ptr0;
#else
		uint32_t *ptr1 = ptr0;
		uint32_t *ptr2 = ptr0;
#endif
		const uint32_t inc = 1;

		MEM_LOCK_AND_INCx8(ptr0, inc);
		MEM_LOCKx8(ptr1);
		MEM_LOCKx8(ptr2);
		MEM_LOCK_AND_INCx8(ptr0, inc);
		MEM_LOCKx8(ptr1);
		MEM_LOCKx8(ptr2);
		MEM_LOCK_AND_INCx8(ptr0, inc);
		MEM_LOCKx8(ptr1);
		MEM_LOCKx8(ptr2);
		MEM_LOCK_AND_INCx8(ptr0, inc);
		MEM_LOCKx8(ptr1);
		MEM_LOCKx8(ptr2);

		inc_counter(args);
	} while (keep_stressing(args));

#if defined(STRESS_ARCH_X86)
done:
#endif
	stress_set_proc_state(args->name, STRESS_STATE_DEINIT);

	(void)munmap((void *)buffer, BUFFER_SIZE);

	return EXIT_SUCCESS;
}

stressor_info_t stress_lockbus_info = {
	.stressor = stress_lockbus,
	.class = CLASS_CPU_CACHE | CLASS_MEMORY,
	.help = help
};
#else
stressor_info_t stress_lockbus_info = {
	.stressor = stress_not_implemented,
	.class = CLASS_CPU_CACHE | CLASS_MEMORY,
	.help = help
};
#endif

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="objdump_lockbus.log"


stress-lockbus.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <stress_lockbus>:
   0:	53                   	push   %rbx
   1:	48 8d 15 00 00 00 00 	lea    0x0(%rip),%rdx        # 8 <stress_lockbus+0x8>
   8:	31 c9                	xor    %ecx,%ecx
   a:	be 07 00 00 00       	mov    $0x7,%esi
   f:	bb 01 00 00 00       	mov    $0x1,%ebx
  14:	48 83 ec 20          	sub    $0x20,%rsp
  18:	48 89 3c 24          	mov    %rdi,(%rsp)
  1c:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
  20:	e8 00 00 00 00       	callq  25 <stress_lockbus+0x25>
  25:	85 c0                	test   %eax,%eax
  27:	0f 88 e9 02 00 00    	js     316 <stress_lockbus+0x316>
  2d:	45 31 c9             	xor    %r9d,%r9d
  30:	31 ff                	xor    %edi,%edi
  32:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
  38:	b9 21 80 00 00       	mov    $0x8021,%ecx
  3d:	ba 03 00 00 00       	mov    $0x3,%edx
  42:	be 00 00 00 01       	mov    $0x1000000,%esi
  47:	e8 00 00 00 00       	callq  4c <stress_lockbus+0x4c>
  4c:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  50:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  55:	0f 84 85 02 00 00    	je     2e0 <stress_lockbus+0x2e0>
  5b:	48 8b 04 24          	mov    (%rsp),%rax
  5f:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
  64:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 6b <stress_lockbus+0x6b>
  6b:	be 01 00 00 00       	mov    $0x1,%esi
  70:	c6 05 00 00 00 00 01 	movb   $0x1,0x0(%rip)        # 77 <stress_lockbus+0x77>
  77:	48 8b 40 30          	mov    0x30(%rax),%rax
  7b:	48 8d 44 03 fe       	lea    -0x2(%rbx,%rax,1),%rax
  80:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  85:	48 8d 43 3e          	lea    0x3e(%rbx),%rax
  89:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  8e:	e8 00 00 00 00       	callq  93 <stress_lockbus+0x93>
  93:	85 c0                	test   %eax,%eax
  95:	0f 85 85 02 00 00    	jne    320 <stress_lockbus+0x320>
  9b:	48 8b 04 24          	mov    (%rsp),%rax
  9f:	be 02 00 00 00       	mov    $0x2,%esi
  a4:	48 8b 78 10          	mov    0x10(%rax),%rdi
  a8:	e8 00 00 00 00       	callq  ad <stress_lockbus+0xad>
  ad:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
  b2:	e9 da 01 00 00       	jmpq   291 <stress_lockbus+0x291>
  b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  be:	00 00 
  c0:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
  c5:	48 89 d9             	mov    %rbx,%rcx
  c8:	f0 83 00 01          	lock addl $0x1,(%rax)
  cc:	f0 83 40 04 01       	lock addl $0x1,0x4(%rax)
  d1:	f0 83 40 08 01       	lock addl $0x1,0x8(%rax)
  d6:	f0 83 40 0c 01       	lock addl $0x1,0xc(%rax)
  db:	f0 83 40 10 01       	lock addl $0x1,0x10(%rax)
  e0:	f0 83 40 14 01       	lock addl $0x1,0x14(%rax)
  e5:	f0 83 40 18 01       	lock addl $0x1,0x18(%rax)
  ea:	f0 83 40 1c 01       	lock addl $0x1,0x1c(%rax)
  ef:	f0 83 01 00          	lock addl $0x0,(%rcx)
  f3:	f0 83 01 00          	lock addl $0x0,(%rcx)
  f7:	f0 83 01 00          	lock addl $0x0,(%rcx)
  fb:	f0 83 01 00          	lock addl $0x0,(%rcx)
  ff:	f0 83 01 00          	lock addl $0x0,(%rcx)
 103:	f0 83 01 00          	lock addl $0x0,(%rcx)
 107:	f0 83 01 00          	lock addl $0x0,(%rcx)
 10b:	f0 83 01 00          	lock addl $0x0,(%rcx)
 10f:	f0 83 02 00          	lock addl $0x0,(%rdx)
 113:	f0 83 02 00          	lock addl $0x0,(%rdx)
 117:	f0 83 02 00          	lock addl $0x0,(%rdx)
 11b:	f0 83 02 00          	lock addl $0x0,(%rdx)
 11f:	f0 83 02 00          	lock addl $0x0,(%rdx)
 123:	f0 83 02 00          	lock addl $0x0,(%rdx)
 127:	f0 83 02 00          	lock addl $0x0,(%rdx)
 12b:	f0 83 02 00          	lock addl $0x0,(%rdx)
 12f:	f0 83 40 20 01       	lock addl $0x1,0x20(%rax)
 134:	f0 83 40 24 01       	lock addl $0x1,0x24(%rax)
 139:	f0 83 40 28 01       	lock addl $0x1,0x28(%rax)
 13e:	f0 83 40 2c 01       	lock addl $0x1,0x2c(%rax)
 143:	f0 83 40 30 01       	lock addl $0x1,0x30(%rax)
 148:	f0 83 40 34 01       	lock addl $0x1,0x34(%rax)
 14d:	f0 83 40 38 01       	lock addl $0x1,0x38(%rax)
 152:	f0 83 40 3c 01       	lock addl $0x1,0x3c(%rax)
 157:	f0 83 01 00          	lock addl $0x0,(%rcx)
 15b:	f0 83 01 00          	lock addl $0x0,(%rcx)
 15f:	f0 83 01 00          	lock addl $0x0,(%rcx)
 163:	f0 83 01 00          	lock addl $0x0,(%rcx)
 167:	f0 83 01 00          	lock addl $0x0,(%rcx)
 16b:	f0 83 01 00          	lock addl $0x0,(%rcx)
 16f:	f0 83 01 00          	lock addl $0x0,(%rcx)
 173:	f0 83 01 00          	lock addl $0x0,(%rcx)
 177:	f0 83 02 00          	lock addl $0x0,(%rdx)
 17b:	f0 83 02 00          	lock addl $0x0,(%rdx)
 17f:	f0 83 02 00          	lock addl $0x0,(%rdx)
 183:	f0 83 02 00          	lock addl $0x0,(%rdx)
 187:	f0 83 02 00          	lock addl $0x0,(%rdx)
 18b:	f0 83 02 00          	lock addl $0x0,(%rdx)
 18f:	f0 83 02 00          	lock addl $0x0,(%rdx)
 193:	f0 83 02 00          	lock addl $0x0,(%rdx)
 197:	f0 83 40 40 01       	lock addl $0x1,0x40(%rax)
 19c:	f0 83 40 44 01       	lock addl $0x1,0x44(%rax)
 1a1:	f0 83 40 48 01       	lock addl $0x1,0x48(%rax)
 1a6:	f0 83 40 4c 01       	lock addl $0x1,0x4c(%rax)
 1ab:	f0 83 40 50 01       	lock addl $0x1,0x50(%rax)
 1b0:	f0 83 40 54 01       	lock addl $0x1,0x54(%rax)
 1b5:	f0 83 40 58 01       	lock addl $0x1,0x58(%rax)
 1ba:	f0 83 40 5c 01       	lock addl $0x1,0x5c(%rax)
 1bf:	f0 83 01 00          	lock addl $0x0,(%rcx)
 1c3:	f0 83 01 00          	lock addl $0x0,(%rcx)
 1c7:	f0 83 01 00          	lock addl $0x0,(%rcx)
 1cb:	f0 83 01 00          	lock addl $0x0,(%rcx)
 1cf:	f0 83 01 00          	lock addl $0x0,(%rcx)
 1d3:	f0 83 01 00          	lock addl $0x0,(%rcx)
 1d7:	f0 83 01 00          	lock addl $0x0,(%rcx)
 1db:	f0 83 01 00          	lock addl $0x0,(%rcx)
 1df:	f0 83 02 00          	lock addl $0x0,(%rdx)
 1e3:	f0 83 02 00          	lock addl $0x0,(%rdx)
 1e7:	f0 83 02 00          	lock addl $0x0,(%rdx)
 1eb:	f0 83 02 00          	lock addl $0x0,(%rdx)
 1ef:	f0 83 02 00          	lock addl $0x0,(%rdx)
 1f3:	f0 83 02 00          	lock addl $0x0,(%rdx)
 1f7:	f0 83 02 00          	lock addl $0x0,(%rdx)
 1fb:	f0 83 02 00          	lock addl $0x0,(%rdx)
 1ff:	f0 83 40 60 01       	lock addl $0x1,0x60(%rax)
 204:	f0 83 40 64 01       	lock addl $0x1,0x64(%rax)
 209:	f0 83 40 68 01       	lock addl $0x1,0x68(%rax)
 20e:	f0 83 40 6c 01       	lock addl $0x1,0x6c(%rax)
 213:	f0 83 40 70 01       	lock addl $0x1,0x70(%rax)
 218:	f0 83 40 74 01       	lock addl $0x1,0x74(%rax)
 21d:	f0 83 40 78 01       	lock addl $0x1,0x78(%rax)
 222:	f0 83 40 7c 01       	lock addl $0x1,0x7c(%rax)
 227:	f0 83 01 00          	lock addl $0x0,(%rcx)
 22b:	f0 83 01 00          	lock addl $0x0,(%rcx)
 22f:	f0 83 01 00          	lock addl $0x0,(%rcx)
 233:	f0 83 01 00          	lock addl $0x0,(%rcx)
 237:	f0 83 01 00          	lock addl $0x0,(%rcx)
 23b:	f0 83 01 00          	lock addl $0x0,(%rcx)
 23f:	f0 83 01 00          	lock addl $0x0,(%rcx)
 243:	f0 83 01 00          	lock addl $0x0,(%rcx)
 247:	f0 83 02 00          	lock addl $0x0,(%rdx)
 24b:	f0 83 02 00          	lock addl $0x0,(%rdx)
 24f:	f0 83 02 00          	lock addl $0x0,(%rdx)
 253:	f0 83 02 00          	lock addl $0x0,(%rdx)
 257:	f0 83 02 00          	lock addl $0x0,(%rdx)
 25b:	f0 83 02 00          	lock addl $0x0,(%rdx)
 25f:	f0 83 02 00          	lock addl $0x0,(%rdx)
 263:	f0 83 02 00          	lock addl $0x0,(%rdx)
 267:	48 8b 3c 24          	mov    (%rsp),%rdi
 26b:	48 8b 47 08          	mov    0x8(%rdi),%rax
 26f:	c6 00 00             	movb   $0x0,(%rax)
 272:	48 8b 07             	mov    (%rdi),%rax
 275:	48 83 00 01          	addq   $0x1,(%rax)
 279:	48 8b 47 08          	mov    0x8(%rdi),%rax
 27d:	c6 00 01             	movb   $0x1,(%rax)
 280:	48 8d 77 18          	lea    0x18(%rdi),%rsi
 284:	e8 00 00 00 00       	callq  289 <stress_lockbus+0x289>
 289:	84 c0                	test   %al,%al
 28b:	0f 84 a4 00 00 00    	je     335 <stress_lockbus+0x335>
 291:	e8 00 00 00 00       	callq  296 <stress_lockbus+0x296>
 296:	89 c1                	mov    %eax,%ecx
 298:	48 89 ca             	mov    %rcx,%rdx
 29b:	48 c1 e2 10          	shl    $0x10,%rdx
 29f:	48 01 ca             	add    %rcx,%rdx
 2a2:	48 c1 e2 0f          	shl    $0xf,%rdx
 2a6:	48 01 ca             	add    %rcx,%rdx
 2a9:	48 c1 ea 37          	shr    $0x37,%rdx
 2ad:	69 d2 00 ff ff 00    	imul   $0xffff00,%edx,%edx
 2b3:	48 29 d0             	sub    %rdx,%rax
 2b6:	83 e0 fc             	and    $0xfffffffc,%eax
 2b9:	48 03 44 24 08       	add    0x8(%rsp),%rax
 2be:	80 3d 00 00 00 00 00 	cmpb   $0x0,0x0(%rip)        # 2c5 <stress_lockbus+0x2c5>
 2c5:	0f 85 f5 fd ff ff    	jne    c0 <stress_lockbus+0xc0>
 2cb:	48 89 c1             	mov    %rax,%rcx
 2ce:	48 89 c2             	mov    %rax,%rdx
 2d1:	e9 f2 fd ff ff       	jmpq   c8 <stress_lockbus+0xc8>
 2d6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 2dd:	00 00 00 
 2e0:	e8 00 00 00 00       	callq  2e5 <stress_lockbus+0x2e5>
 2e5:	8b 00                	mov    (%rax),%eax
 2e7:	83 f8 1c             	cmp    $0x1c,%eax
 2ea:	74 74                	je     360 <stress_lockbus+0x360>
 2ec:	83 f8 26             	cmp    $0x26,%eax
 2ef:	bb 04 00 00 00       	mov    $0x4,%ebx
 2f4:	74 0a                	je     300 <stress_lockbus+0x300>
 2f6:	83 f8 0c             	cmp    $0xc,%eax
 2f9:	74 65                	je     360 <stress_lockbus+0x360>
 2fb:	bb 01 00 00 00       	mov    $0x1,%ebx
 300:	48 8b 04 24          	mov    (%rsp),%rax
 304:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 30b <stress_lockbus+0x30b>
 30b:	48 8b 70 10          	mov    0x10(%rax),%rsi
 30f:	31 c0                	xor    %eax,%eax
 311:	e8 00 00 00 00       	callq  316 <stress_lockbus+0x316>
 316:	48 83 c4 20          	add    $0x20,%rsp
 31a:	89 d8                	mov    %ebx,%eax
 31c:	5b                   	pop    %rbx
 31d:	c3                   	retq   
 31e:	66 90                	xchg   %ax,%ax
 320:	48 8b 3c 24          	mov    (%rsp),%rdi
 324:	48 8d 77 18          	lea    0x18(%rdi),%rsi
 328:	e8 00 00 00 00       	callq  32d <stress_lockbus+0x32d>
 32d:	84 c0                	test   %al,%al
 32f:	0f 85 66 fd ff ff    	jne    9b <stress_lockbus+0x9b>
 335:	48 8b 04 24          	mov    (%rsp),%rax
 339:	be 03 00 00 00       	mov    $0x3,%esi
 33e:	31 db                	xor    %ebx,%ebx
 340:	48 8b 78 10          	mov    0x10(%rax),%rdi
 344:	e8 00 00 00 00       	callq  349 <stress_lockbus+0x349>
 349:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
 34e:	be 00 00 00 01       	mov    $0x1000000,%esi
 353:	e8 00 00 00 00       	callq  358 <stress_lockbus+0x358>
 358:	48 83 c4 20          	add    $0x20,%rsp
 35c:	89 d8                	mov    %ebx,%eax
 35e:	5b                   	pop    %rbx
 35f:	c3                   	retq   
 360:	bb 03 00 00 00       	mov    $0x3,%ebx
 365:	eb 99                	jmp    300 <stress_lockbus+0x300>

Disassembly of section mlocked_text:

0000000000000000 <stress_sigbus_handler>:
   0:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 7 <stress_sigbus_handler+0x7>
   7:	48 83 ec 08          	sub    $0x8,%rsp
   b:	be 01 00 00 00       	mov    $0x1,%esi
  10:	c6 05 00 00 00 00 00 	movb   $0x0,0x0(%rip)        # 17 <stress_sigbus_handler+0x17>
  17:	e8 00 00 00 00       	callq  1c <stress_sigbus_handler+0x1c>

Disassembly of section .text.hot:

0000000000000000 <keep_stressing.isra.0>:
   0:	0f b6 05 00 00 00 00 	movzbl 0x0(%rip),%eax        # 7 <keep_stressing.isra.0+0x7>
   7:	84 c0                	test   %al,%al
   9:	74 08                	je     13 <keep_stressing.isra.0+0x13>
   b:	48 8b 16             	mov    (%rsi),%rdx
   e:	48 85 d2             	test   %rdx,%rdx
  11:	75 05                	jne    18 <keep_stressing.isra.0+0x18>
  13:	f3 c3                	repz retq 
  15:	0f 1f 00             	nopl   (%rax)
  18:	48 8b 07             	mov    (%rdi),%rax
  1b:	48 3b 10             	cmp    (%rax),%rdx
  1e:	0f 97 c0             	seta   %al
  21:	c3                   	retq   

--fUYQa+Pmc3FrFX/N--
