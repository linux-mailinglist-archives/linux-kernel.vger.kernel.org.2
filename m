Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34D53532DB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 08:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhDCGxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 02:53:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:30678 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232178AbhDCGxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 02:53:15 -0400
IronPort-SDR: h9ATOQh5u+cAoMLjulLUYQ0alIETOLsojkFdhtNn/06jM+w0lheabOosInBcoWdao8P0hv1MP8
 g/wPBRbEeJGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="172623999"
X-IronPort-AV: E=Sophos;i="5.81,302,1610438400"; 
   d="gz'50?scan'50,208,50";a="172623999"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 23:53:10 -0700
IronPort-SDR: OnWtxlRtW9cuC7Io+x4Shq7S4jxD72glubZMyORNPmd2R3E5gaQvZeC6hSk5MX3pjIpfO4t0aH
 qD8c074mWzdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,302,1610438400"; 
   d="gz'50?scan'50,208,50";a="417324173"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 02 Apr 2021 23:53:07 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSa9a-0007a0-Pe; Sat, 03 Apr 2021 06:53:06 +0000
Date:   Sat, 3 Apr 2021 14:52:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] tty: use printk_safe context at tty_msg()
Message-ID: <202104031438.RuTk02Vc-lkp@intel.com>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tetsuo,

I love your patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on v5.12-rc5 next-20210401]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Tetsuo-Handa/tty-use-printk_safe-context-at-tty_msg/20210403-121636
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: microblaze-randconfig-r001-20210403 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/88235b87a105a519a205a28753857b7db5e6b3d1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tetsuo-Handa/tty-use-printk_safe-context-at-tty_msg/20210403-121636
        git checkout 88235b87a105a519a205a28753857b7db5e6b3d1
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=microblaze 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/tty.h:17,
                    from kernel/signal.c:26:
>> include/uapi/../../kernel/printk/internal.h:59:20: warning: no previous prototype for 'vprintk_func' [-Wmissing-prototypes]
      59 | __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
         |                    ^~~~~~~~~~~~
--
   In file included from include/linux/tty.h:17,
                    from kernel/audit.h:13,
                    from kernel/audit.c:63:
>> include/uapi/../../kernel/printk/internal.h:59:20: warning: no previous prototype for 'vprintk_func' [-Wmissing-prototypes]
      59 | __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
         |                    ^~~~~~~~~~~~
   kernel/audit.c:1778:14: warning: no previous prototype for 'audit_serial' [-Wmissing-prototypes]
    1778 | unsigned int audit_serial(void)
         |              ^~~~~~~~~~~~
   kernel/audit.c: In function 'audit_log_vformat':
   kernel/audit.c:1926:2: warning: function 'audit_log_vformat' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1926 |  len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args);
         |  ^~~
   kernel/audit.c:1935:3: warning: function 'audit_log_vformat' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1935 |   len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
         |   ^~~
--
   In file included from include/linux/tty.h:17,
                    from kernel/audit.h:13,
                    from kernel/auditfilter.c:23:
>> include/uapi/../../kernel/printk/internal.h:59:20: warning: no previous prototype for 'vprintk_func' [-Wmissing-prototypes]
      59 | __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
         |                    ^~~~~~~~~~~~
   kernel/auditfilter.c: In function 'audit_data_to_entry':
   kernel/auditfilter.c:609:37: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     609 |   audit_remove_mark(entry->rule.exe); /* that's the template one */
         |                                     ^
   kernel/auditfilter.c: In function 'audit_dupe_rule':
   kernel/auditfilter.c:875:32: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     875 |     audit_remove_mark(new->exe);
         |                                ^
   kernel/auditfilter.c: In function 'audit_del_rule':
   kernel/auditfilter.c:1045:35: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1045 |   audit_remove_mark_rule(&e->rule);
         |                                   ^
   kernel/auditfilter.c: In function 'audit_rule_change':
   kernel/auditfilter.c:1150:38: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1150 |    audit_remove_mark(entry->rule.exe);
         |                                      ^
   kernel/auditfilter.c: In function 'update_lsm_rule':
   kernel/auditfilter.c:1402:37: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1402 |   audit_remove_mark(entry->rule.exe);
         |                                     ^
--
   In file included from include/linux/tty.h:17,
                    from kernel/fork.c:78:
>> include/uapi/../../kernel/printk/internal.h:59:20: warning: no previous prototype for 'vprintk_func' [-Wmissing-prototypes]
      59 | __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
         |                    ^~~~~~~~~~~~
   kernel/fork.c:161:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     161 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:746:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     746 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:836:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     836 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/tty.h:17,
                    from include/linux/vt_kern.h:12,
                    from kernel/panic.c:19:
>> include/uapi/../../kernel/printk/internal.h:59:20: warning: no previous prototype for 'vprintk_func' [-Wmissing-prototypes]
      59 | __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
         |                    ^~~~~~~~~~~~
   kernel/panic.c:85:13: warning: no previous prototype for 'panic_smp_self_stop' [-Wmissing-prototypes]
      85 | void __weak panic_smp_self_stop(void)
         |             ^~~~~~~~~~~~~~~~~~~
   kernel/panic.c:95:13: warning: no previous prototype for 'nmi_panic_self_stop' [-Wmissing-prototypes]
      95 | void __weak nmi_panic_self_stop(struct pt_regs *regs)
         |             ^~~~~~~~~~~~~~~~~~~
   kernel/panic.c:106:13: warning: no previous prototype for 'crash_smp_send_stop' [-Wmissing-prototypes]
     106 | void __weak crash_smp_send_stop(void)
         |             ^~~~~~~~~~~~~~~~~~~
   kernel/panic.c:576:6: warning: no previous prototype for '__warn' [-Wmissing-prototypes]
     576 | void __warn(const char *file, int line, void *caller, unsigned taint,
         |      ^~~~~~
   kernel/panic.c: In function '__warn':
   kernel/panic.c:590:3: warning: function '__warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     590 |   vprintk(args->fmt, args->args);
         |   ^~~~~~~
   kernel/panic.c: At top level:
   kernel/panic.c:620:6: warning: no previous prototype for 'warn_slowpath_fmt' [-Wmissing-prototypes]
     620 | void warn_slowpath_fmt(const char *file, int line, unsigned taint,
         |      ^~~~~~~~~~~~~~~~~
--
   In file included from include/linux/tty.h:17,
                    from kernel/exit.c:21:
>> include/uapi/../../kernel/printk/internal.h:59:20: warning: no previous prototype for 'vprintk_func' [-Wmissing-prototypes]
      59 | __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
         |                    ^~~~~~~~~~~~
   kernel/exit.c:1763:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1763 | __weak void abort(void)
         |             ^~~~~
--
   In file included from include/linux/tty.h:17,
                    from kernel/printk/printk.c:24:
>> include/uapi/../../kernel/printk/internal.h:59:20: warning: no previous prototype for 'vprintk_func' [-Wmissing-prototypes]
      59 | __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
         |                    ^~~~~~~~~~~~
   In file included from kernel/printk/printk.c:61:
>> kernel/printk/internal.h:59:20: error: redefinition of 'vprintk_func'
      59 | __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
         |                    ^~~~~~~~~~~~
   In file included from include/linux/tty.h:17,
                    from kernel/printk/printk.c:24:
   include/uapi/../../kernel/printk/internal.h:59:20: note: previous definition of 'vprintk_func' was here
      59 | __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
         |                    ^~~~~~~~~~~~
   In file included from kernel/printk/printk.c:61:
>> kernel/printk/internal.h:72:20: error: redefinition of 'printk_safe_init'
      72 | static inline void printk_safe_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   In file included from include/linux/tty.h:17,
                    from kernel/printk/printk.c:24:
   include/uapi/../../kernel/printk/internal.h:72:20: note: previous definition of 'printk_safe_init' was here
      72 | static inline void printk_safe_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   In file included from kernel/printk/printk.c:61:
>> kernel/printk/internal.h:73:20: error: redefinition of 'printk_percpu_data_ready'
      73 | static inline bool printk_percpu_data_ready(void) { return false; }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/tty.h:17,
                    from kernel/printk/printk.c:24:
   include/uapi/../../kernel/printk/internal.h:73:20: note: previous definition of 'printk_percpu_data_ready' was here
      73 | static inline bool printk_percpu_data_ready(void) { return false; }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:175:5: warning: no previous prototype for 'devkmsg_sysctl_set_loglvl' [-Wmissing-prototypes]
     175 | int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/vprintk_func +59 kernel/printk/internal.h

099f1c84c0052e Sergey Senozhatsky 2016-12-27  58  
099f1c84c0052e Sergey Senozhatsky 2016-12-27 @59  __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
099f1c84c0052e Sergey Senozhatsky 2016-12-27  60  
099f1c84c0052e Sergey Senozhatsky 2016-12-27  61  /*
099f1c84c0052e Sergey Senozhatsky 2016-12-27  62   * In !PRINTK builds we still export logbuf_lock spin_lock, console_sem
099f1c84c0052e Sergey Senozhatsky 2016-12-27  63   * semaphore and some of console functions (console_unlock()/etc.), so
099f1c84c0052e Sergey Senozhatsky 2016-12-27  64   * printk-safe must preserve the existing local IRQ guarantees.
099f1c84c0052e Sergey Senozhatsky 2016-12-27  65   */
099f1c84c0052e Sergey Senozhatsky 2016-12-27  66  #define printk_safe_enter_irqsave(flags) local_irq_save(flags)
099f1c84c0052e Sergey Senozhatsky 2016-12-27  67  #define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
099f1c84c0052e Sergey Senozhatsky 2016-12-27  68  
099f1c84c0052e Sergey Senozhatsky 2016-12-27  69  #define printk_safe_enter_irq() local_irq_disable()
099f1c84c0052e Sergey Senozhatsky 2016-12-27  70  #define printk_safe_exit_irq() local_irq_enable()
099f1c84c0052e Sergey Senozhatsky 2016-12-27  71  
ab6f762f0f5316 Sergey Senozhatsky 2020-03-03 @72  static inline void printk_safe_init(void) { }
ab6f762f0f5316 Sergey Senozhatsky 2020-03-03 @73  static inline bool printk_percpu_data_ready(void) { return false; }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
DQECAA==

--VbJkn9YxBvnuCH5J--
