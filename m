Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031AC3F3E9D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 10:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhHVIPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 04:15:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:58023 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhHVIPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 04:15:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10083"; a="277969679"
X-IronPort-AV: E=Sophos;i="5.84,342,1620716400"; 
   d="gz'50?scan'50,208,50";a="277969679"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2021 01:14:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,342,1620716400"; 
   d="gz'50?scan'50,208,50";a="453842109"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Aug 2021 01:14:34 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mHick-000WZL-6F; Sun, 22 Aug 2021 08:14:34 +0000
Date:   Sun, 22 Aug 2021 16:13:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Conole <aconole@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-4.4.y 9981/9999]
 include/asm-generic/bug.h:159:2: error: implicit declaration of function
 'no_printk'; did you mean 'printk'?
Message-ID: <202108221620.wtnOrR1X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
head:   bb07acdd9271518022b632253e857f43c09fb147
commit: b60b53d4980f879884740e672d83155980d74445 [9981/9999] printk: help pr_debug and pr_devel to optimize out arguments
config: powerpc64-buildonly-randconfig-r006-20210822 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=b60b53d4980f879884740e672d83155980d74445
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.4.y
        git checkout b60b53d4980f879884740e672d83155980d74445
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from lib/842/842_decompress.c:23:0:
   lib/842/842_debugfs.h: In function 'sw842_debugfs_create':
   lib/842/842_debugfs.h:27:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     for (i = 0; i < ARRAY_SIZE(template_count); i++) {
                   ^
   lib/842/842_decompress.c: In function 'next_bits':
   lib/842/842_decompress.c:115:28: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     if (DIV_ROUND_UP(bits, 8) > p->ilen)
                               ^
   In file included from arch/powerpc/include/asm/bug.h:127:0,
                    from include/linux/bug.h:4,
                    from include/linux/thread_info.h:11,
                    from include/asm-generic/preempt.h:4,
                    from arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from lib/842/842.h:76,
                    from lib/842/842_decompress.c:22:
   lib/842/842_decompress.c: In function '__do_index':
>> include/asm-generic/bug.h:159:2: error: implicit declaration of function 'no_printk'; did you mean 'printk'? [-Werror=implicit-function-declaration]
     no_printk(format);      \
     ^
   lib/842/842_decompress.c:72:3: note: in expansion of macro 'WARN'
      WARN(1, "pr_debug param err invalid size %x\n", s))
      ^~~~
   include/linux/printk.h:114:17: note: in expansion of macro 'beN_to_cpu'
      printk(fmt, ##__VA_ARGS__); \
                    ^~~~~~~~~~~
   include/linux/printk.h:289:2: note: in expansion of macro 'no_printk'
     no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
     ^~~~~~~~~
   lib/842/842_decompress.c:205:2: note: in expansion of macro 'pr_debug'
     pr_debug("index%x to %lx off %lx adjoff %lx tot %lx data %lx\n",
     ^~~~~~~~
   lib/842/842_decompress.c:71:54: warning: signed and unsigned type in conditional expression [-Wsign-compare]
      (s) == 8 ? be64_to_cpu(get_unaligned((__be64 *)d)) : \
                                                         ^
   include/linux/printk.h:114:17: note: in expansion of macro 'beN_to_cpu'
      printk(fmt, ##__VA_ARGS__); \
                    ^~~~~~~~~~~
   include/linux/printk.h:289:2: note: in expansion of macro 'no_printk'
     no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
     ^~~~~~~~~
   lib/842/842_decompress.c:205:2: note: in expansion of macro 'pr_debug'
     pr_debug("index%x to %lx off %lx adjoff %lx tot %lx data %lx\n",
     ^~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/ring_buffer.h:5:0,
                    from include/linux/trace_events.h:5,
                    from include/trace/syscall.h:6,
                    from include/linux/syscalls.h:81,
                    from arch/powerpc/kernel/syscalls.c:24:
   include/linux/mm.h: In function 'is_vmalloc_addr':
   include/linux/mm.h:386:14: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     return addr >= VMALLOC_START && addr < VMALLOC_END;
                 ^~
   arch/powerpc/kernel/syscalls.c: At top level:
>> arch/powerpc/kernel/syscalls.c:86:1: error: no previous declaration for 'ppc_select' [-Werror=missing-declarations]
    ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp)
    ^~~~~~~~~~
>> arch/powerpc/kernel/syscalls.c:118:6: error: no previous declaration for 'ppc_fadvise64_64' [-Werror=missing-declarations]
    long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
         ^~~~~~~~~~~~~~~~
   arch/powerpc/kernel/syscalls.c:125:6: error: no previous declaration for 'sys_switch_endian' [-Werror=missing-declarations]
    long sys_switch_endian(void)
         ^~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/pid_namespace.h:6:0,
                    from include/linux/ptrace.h:8,
                    from arch/powerpc/kernel/irq.c:38:
   include/linux/mm.h: In function 'is_vmalloc_addr':
   include/linux/mm.h:386:14: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     return addr >= VMALLOC_START && addr < VMALLOC_END;
                 ^~
   In file included from arch/powerpc/include/asm/bug.h:127:0,
                    from include/linux/bug.h:4,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:12,
                    from include/linux/kernel_stat.h:4,
                    from arch/powerpc/kernel/irq.c:35:
   include/linux/scatterlist.h: In function 'sg_set_buf':
>> arch/powerpc/include/asm/page.h:129:32: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
    #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
                                   ^
   include/asm-generic/bug.h:146:36: note: in definition of macro 'BUG_ON'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                       ^~~~~~~~~
   arch/powerpc/include/asm/page.h:146:32: note: in expansion of macro 'pfn_valid'
    #define virt_addr_valid(kaddr) pfn_valid(virt_to_pfn(kaddr))
                                   ^~~~~~~~~
   include/linux/scatterlist.h:140:10: note: in expansion of macro 'virt_addr_valid'
     BUG_ON(!virt_addr_valid(buf));
             ^~~~~~~~~~~~~~~
   In file included from include/linux/interrupt.h:11:0,
                    from include/linux/kernel_stat.h:8,
                    from arch/powerpc/kernel/irq.c:35:
   arch/powerpc/kernel/irq.c: In function 'migrate_irqs':
   include/linux/irqnr.h:12:45: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     for (irq = 0, desc = irq_to_desc(irq); irq < nr_irqs;  \
                                                ^
   arch/powerpc/kernel/irq.c:434:2: note: in expansion of macro 'for_each_irq_desc'
     for_each_irq_desc(irq, desc) {
     ^~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/irq.c:445:25: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
      if (cpumask_any(mask) >= nr_cpu_ids) {
                            ^~
   arch/powerpc/kernel/irq.c: At top level:
>> arch/powerpc/kernel/irq.c:547:13: error: no previous declaration for 'init_IRQ' [-Werror=missing-declarations]
    void __init init_IRQ(void)
                ^~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from arch/powerpc/kernel/signal_32.c:21:0:
   include/linux/mm.h: In function 'is_vmalloc_addr':
   include/linux/mm.h:386:14: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     return addr >= VMALLOC_START && addr < VMALLOC_END;
                 ^~
   In file included from include/asm-generic/termios-base.h:7:0,
                    from arch/powerpc/include/asm/termios.h:20,
                    from include/uapi/linux/termios.h:5,
                    from include/linux/tty.h:6,
                    from arch/powerpc/kernel/signal_32.c:36:
   include/asm-generic/termios-base.h: In function 'user_termio_to_kernel_termios':
   arch/powerpc/include/asm/uaccess.h:57:35: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
      (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
                                      ^
   arch/powerpc/include/asm/uaccess.h:63:3: note: in expansion of macro '__access_ok'
      __access_ok((__force unsigned long)(addr), (size), get_fs()))
      ^~~~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:300:6: note: in expansion of macro 'access_ok'
     if (access_ok(VERIFY_READ, __gu_addr, (size))) {  \
         ^~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:103:2: note: in expansion of macro '__get_user_check'
     __get_user_check((x), (ptr), sizeof(*(ptr)))
     ^~~~~~~~~~~~~~~~
   include/asm-generic/termios-base.h:35:6: note: in expansion of macro 'get_user'
     if (get_user(termios->c_line, &termio->c_line) < 0)
         ^~~~~~~~
   include/asm-generic/termios-base.h: In function 'kernel_termios_to_user_termio':
   arch/powerpc/include/asm/uaccess.h:57:35: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
      (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
                                      ^
   arch/powerpc/include/asm/uaccess.h:63:3: note: in expansion of macro '__access_ok'
      __access_ok((__force unsigned long)(addr), (size), get_fs()))
      ^~~~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:192:6: note: in expansion of macro 'access_ok'
     if (access_ok(VERIFY_WRITE, __pu_addr, size))   \
         ^~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:105:2: note: in expansion of macro '__put_user_check'
     __put_user_check((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
     ^~~~~~~~~~~~~~~~
   include/asm-generic/termios-base.h:57:6: note: in expansion of macro 'put_user'
         put_user(termios->c_line,  &termio->c_line) < 0 ||
         ^~~~~~~~
   arch/powerpc/kernel/signal_32.c: At top level:
   arch/powerpc/kernel/signal_32.c:1139:6: error: no previous declaration for 'sys_swapcontext' [-Werror=missing-declarations]
    long sys_swapcontext(struct ucontext __user *old_ctx,
         ^~~~~~~~~~~~~~~
   arch/powerpc/kernel/signal_32.c: In function 'sys_swapcontext':
   arch/powerpc/kernel/signal_32.c:1184:15: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     if (ctx_size < sizeof(struct ucontext))
                  ^
   In file included from include/asm-generic/termios-base.h:7:0,
                    from arch/powerpc/include/asm/termios.h:20,
                    from include/uapi/linux/termios.h:5,
                    from include/linux/tty.h:6,
                    from arch/powerpc/kernel/signal_32.c:36:
   arch/powerpc/include/asm/uaccess.h:57:35: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
      (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
                                      ^
   arch/powerpc/include/asm/uaccess.h:63:3: note: in expansion of macro '__access_ok'
      __access_ok((__force unsigned long)(addr), (size), get_fs()))
      ^~~~~~~~~~~
   arch/powerpc/kernel/signal_32.c:1199:8: note: in expansion of macro 'access_ok'
      if (!access_ok(VERIFY_WRITE, old_ctx, ctx_size)
           ^~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:57:35: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
      (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
                                      ^
   arch/powerpc/include/asm/uaccess.h:63:3: note: in expansion of macro '__access_ok'
      __access_ok((__force unsigned long)(addr), (size), get_fs()))
      ^~~~~~~~~~~
   arch/powerpc/kernel/signal_32.c:1207:7: note: in expansion of macro 'access_ok'
     if (!access_ok(VERIFY_READ, new_ctx, ctx_size)
          ^~~~~~~~~
>> arch/powerpc/kernel/signal_32.c:1143:16: error: variable 'tmp' set but not used [-Werror=unused-but-set-variable]
     unsigned char tmp;
                   ^~~
   arch/powerpc/kernel/signal_32.c: At top level:
>> arch/powerpc/kernel/signal_32.c:1230:6: error: no previous declaration for 'sys_rt_sigreturn' [-Werror=missing-declarations]
    long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
         ^~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/signal_32.c:1311:5: error: no previous declaration for 'sys_debug_setcontext' [-Werror=missing-declarations]
    int sys_debug_setcontext(struct ucontext __user *ctx,
        ^~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/signal_32.c: In function 'sys_debug_setcontext':
   arch/powerpc/kernel/signal_32.c:1318:16: error: variable 'tmp' set but not used [-Werror=unused-but-set-variable]
     unsigned char tmp;
                   ^~~
   arch/powerpc/kernel/signal_32.c: At top level:
>> arch/powerpc/kernel/signal_32.c:1502:6: error: no previous declaration for 'sys_sigreturn' [-Werror=missing-declarations]
    long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
         ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from arch/powerpc/kernel/vdso.c:15:0:
   include/linux/mm.h: In function 'is_vmalloc_addr':
   include/linux/mm.h:386:14: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     return addr >= VMALLOC_START && addr < VMALLOC_END;
                 ^~
   In file included from arch/powerpc/include/asm/bug.h:127:0,
                    from include/linux/bug.h:4,
                    from include/linux/thread_info.h:11,
                    from include/asm-generic/preempt.h:4,
                    from arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/uapi/linux/timex.h:56,
                    from include/linux/timex.h:56,
                    from include/linux/sched.h:19,
                    from arch/powerpc/kernel/vdso.c:13:
   include/linux/scatterlist.h: In function 'sg_set_buf':
>> arch/powerpc/include/asm/page.h:129:32: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
    #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
                                   ^
   include/asm-generic/bug.h:146:36: note: in definition of macro 'BUG_ON'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                       ^~~~~~~~~
   arch/powerpc/include/asm/page.h:146:32: note: in expansion of macro 'pfn_valid'
    #define virt_addr_valid(kaddr) pfn_valid(virt_to_pfn(kaddr))
                                   ^~~~~~~~~
   include/linux/scatterlist.h:140:10: note: in expansion of macro 'virt_addr_valid'
     BUG_ON(!virt_addr_valid(buf));
             ^~~~~~~~~~~~~~~
   arch/powerpc/kernel/vdso.c: In function 'vdso_fixup_alt_funcs':
   arch/powerpc/kernel/vdso.c:609:16: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     for (i = 0; i < ARRAY_SIZE(vdso_patches); i++) {
                   ^
   arch/powerpc/kernel/vdso.c: In function 'vdso_init':
   arch/powerpc/kernel/vdso.c:795:16: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     for (i = 0; i < vdso32_pages; i++) {
                   ^
   cc1: all warnings being treated as errors
--
   In file included from arch/powerpc/kernel/process.c:20:0:
   include/linux/mm.h: In function 'is_vmalloc_addr':
   include/linux/mm.h:386:14: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     return addr >= VMALLOC_START && addr < VMALLOC_END;
                 ^~
   In file included from include/net/inet_frag.h:4:0,
                    from include/net/netns/ipv4.h:9,
                    from include/net/net_namespace.h:17,
                    from include/linux/init_task.h:15,
                    from arch/powerpc/kernel/process.c:29:
   include/linux/rhashtable.h: In function 'rht_grow_above_75':
   include/linux/rhashtable.h:264:34: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     return atomic_read(&ht->nelems) > (tbl->size / 4 * 3) &&
                                     ^
   include/linux/rhashtable.h: In function 'rht_shrink_below_30':
   include/linux/rhashtable.h:277:34: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     return atomic_read(&ht->nelems) < (tbl->size * 3 / 10) &&
                                     ^
   include/linux/rhashtable.h: In function 'rht_grow_above_100':
   include/linux/rhashtable.h:289:34: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     return atomic_read(&ht->nelems) > tbl->size &&
                                     ^
   include/linux/rhashtable.h: In function 'rht_grow_above_max':
   include/linux/rhashtable.h:302:34: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
            atomic_read(&ht->nelems) >= ht->p.insecure_max_entries;
                                     ^~
   In file included from include/net/checksum.h:25:0,
                    from include/linux/skbuff.h:31,
                    from include/net/net_namespace.h:32,
                    from include/linux/init_task.h:15,
                    from arch/powerpc/kernel/process.c:29:
   include/net/checksum.h: In function 'csum_and_copy_from_user':
   arch/powerpc/include/asm/uaccess.h:57:35: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
      (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
                                      ^
   arch/powerpc/include/asm/uaccess.h:63:3: note: in expansion of macro '__access_ok'
      __access_ok((__force unsigned long)(addr), (size), get_fs()))
      ^~~~~~~~~~~
   include/net/checksum.h:33:6: note: in expansion of macro 'access_ok'
     if (access_ok(VERIFY_READ, src, len))
         ^~~~~~~~~
   include/net/checksum.h: In function 'csum_and_copy_to_user':
   arch/powerpc/include/asm/uaccess.h:57:35: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
      (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
                                      ^
   arch/powerpc/include/asm/uaccess.h:63:3: note: in expansion of macro '__access_ok'
      __access_ok((__force unsigned long)(addr), (size), get_fs()))
      ^~~~~~~~~~~
   include/net/checksum.h:49:6: note: in expansion of macro 'access_ok'
     if (access_ok(VERIFY_WRITE, dst, len)) {
         ^~~~~~~~~
   In file included from arch/powerpc/include/asm/bug.h:127:0,
                    from include/linux/bug.h:4,
                    from include/linux/thread_info.h:11,
                    from include/asm-generic/preempt.h:4,
                    from arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/uapi/linux/timex.h:56,
                    from include/linux/timex.h:56,
                    from include/linux/sched.h:19,
                    from arch/powerpc/kernel/process.c:18:
   include/linux/scatterlist.h: In function 'sg_set_buf':
>> arch/powerpc/include/asm/page.h:129:32: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
    #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
                                   ^
   include/asm-generic/bug.h:146:36: note: in definition of macro 'BUG_ON'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                       ^~~~~~~~~
   arch/powerpc/include/asm/page.h:146:32: note: in expansion of macro 'pfn_valid'
    #define virt_addr_valid(kaddr) pfn_valid(virt_to_pfn(kaddr))
                                   ^~~~~~~~~
   include/linux/scatterlist.h:140:10: note: in expansion of macro 'virt_addr_valid'
     BUG_ON(!virt_addr_valid(buf));
             ^~~~~~~~~~~~~~~
   In file included from include/net/net_namespace.h:32:0,
                    from include/linux/init_task.h:15,
                    from arch/powerpc/kernel/process.c:29:
   include/linux/skbuff.h: In function 'skb_add_data':
   include/linux/skbuff.h:2675:23: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
             &csum, from) == copy) {
                          ^~
   include/linux/skbuff.h:2679:60: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     } else if (copy_from_iter(skb_put(skb, copy), copy, from) == copy)
                                                               ^~
   include/linux/skbuff.h: In function 'skb_can_coalesce':
   include/linux/skbuff.h:2693:14: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
             off == frag->page_offset + skb_frag_size(frag);
                 ^~
   include/linux/skbuff.h: In function 'memcpy_from_msg':
   include/linux/skbuff.h:2921:51: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     return copy_from_iter(data, len, &msg->msg_iter) == len ? 0 : -EFAULT;
                                                      ^~
   include/linux/skbuff.h: In function 'memcpy_to_msg':
   include/linux/skbuff.h:2926:49: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
     return copy_to_iter(data, len, &msg->msg_iter) == len ? 0 : -EFAULT;
                                                    ^~
   arch/powerpc/kernel/process.c: At top level:
>> arch/powerpc/kernel/process.c:1088:5: error: no previous declaration for 'arch_dup_task_struct' [-Werror=missing-declarations]
    int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
        ^~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/process.c:1642:15: error: no previous declaration for 'arch_align_stack' [-Werror=missing-declarations]
    unsigned long arch_align_stack(unsigned long sp)
                  ^~~~~~~~~~~~~~~~
   arch/powerpc/kernel/process.c:1662:15: error: no previous declaration for 'arch_randomize_brk' [-Werror=missing-declarations]
    unsigned long arch_randomize_brk(struct mm_struct *mm)
                  ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
..


vim +159 include/asm-generic/bug.h

b607e70ec6a982 Josh Triplett 2014-04-07  155  
b607e70ec6a982 Josh Triplett 2014-04-07  156  #ifndef WARN
b607e70ec6a982 Josh Triplett 2014-04-07  157  #define WARN(condition, format...) ({					\
b607e70ec6a982 Josh Triplett 2014-04-07  158  	int __ret_warn_on = !!(condition);				\
4e50ebde32bed6 Josh Triplett 2014-04-07 @159  	no_printk(format);						\
b607e70ec6a982 Josh Triplett 2014-04-07  160  	unlikely(__ret_warn_on);					\
b607e70ec6a982 Josh Triplett 2014-04-07  161  })
b607e70ec6a982 Josh Triplett 2014-04-07  162  #endif
b607e70ec6a982 Josh Triplett 2014-04-07  163  

:::::: The code at line 159 was first introduced by commit
:::::: 4e50ebde32bed67a9aec8c239bbd89e5d0b8727b bug: when !CONFIG_BUG, make WARN call no_printk to check format and args

:::::: TO: Josh Triplett <josh@joshtriplett.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--fdj2RfSjLxBAspz7
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
rv8Bzl97nScbAQA=

--fdj2RfSjLxBAspz7--
