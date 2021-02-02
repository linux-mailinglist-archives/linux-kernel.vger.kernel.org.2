Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D2530BE34
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhBBMal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:30:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:55904 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhBBMae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:30:34 -0500
IronPort-SDR: AXNiPnaHwZhqQODcnwnwPpnMBuOV+dtXy1hCp+Mtx9xl1vB8PpNeY/L9fK4Sg1h/BKAIlyff+t
 pKKxr9dSbXcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="167951074"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="gz'50?scan'50,208,50";a="167951074"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 04:29:49 -0800
IronPort-SDR: KhqawSWjl5TccEkPfoQCFkF6vOU+BX0aZXYOBUwQOJuVg9fq+A6+J5MrMI867KV7LLnnMaXejo
 /vIFGQYnax7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="gz'50?scan'50,208,50";a="581911499"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 02 Feb 2021 04:29:46 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l6uoU-0009Km-CA; Tue, 02 Feb 2021 12:29:46 +0000
Date:   Tue, 2 Feb 2021 20:29:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     kbuild-all@lists.01.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 3/3] printk: move CONSOLE_EXT_LOG_MAX to
 kernel/printk/printk.c
Message-ID: <202102022035.7AbsG6ge-lkp@intel.com>
References: <20210202070218.856847-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20210202070218.856847-3-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

I love your patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on efi/next tty/tty-testing tip/x86/core v5.11-rc6 next-20210125]
[cannot apply to pmladek/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/printk-use-CONFIG_CONSOLE_LOGLEVEL_-directly/20210202-151411
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2ab38c17aac10bf55ab3efde4c4db3893d8691d2
config: alpha-randconfig-s031-20210202 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-215-g0fb77bb6-dirty
        # https://github.com/0day-ci/linux/commit/35d219bfad62e5008215f996430732aeb52c0652
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Masahiro-Yamada/printk-use-CONFIG_CONSOLE_LOGLEVEL_-directly/20210202-151411
        git checkout 35d219bfad62e5008215f996430732aeb52c0652
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/printk/printk.c:61:
   kernel/printk/internal.h:59:20: warning: no previous prototype for 'vprintk_func' [-Wmissing-prototypes]
      59 | __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
         |                    ^~~~~~~~~~~~
   kernel/printk/printk.c:175:5: warning: no previous prototype for 'devkmsg_sysctl_set_loglvl' [-Wmissing-prototypes]
     175 | int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c: In function 'console_unlock':
>> kernel/printk/printk.c:2469:23: error: 'CONSOLE_EXT_LOG_MAX' undeclared (first use in this function)
    2469 |  static char ext_text[CONSOLE_EXT_LOG_MAX];
         |                       ^~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:2469:23: note: each undeclared identifier is reported only once for each function it appears in
   kernel/printk/printk.c:2469:14: warning: unused variable 'ext_text' [-Wunused-variable]
    2469 |  static char ext_text[CONSOLE_EXT_LOG_MAX];
         |              ^~~~~~~~


vim +/CONSOLE_EXT_LOG_MAX +2469 kernel/printk/printk.c

a8199371afc279 kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2452  
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2453  /**
ac751efa6a0d70 kernel/printk.c        Torben Hohn             2011-01-25  2454   * console_unlock - unlock the console system
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2455   *
ac751efa6a0d70 kernel/printk.c        Torben Hohn             2011-01-25  2456   * Releases the console_lock which the caller holds on the console system
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2457   * and the console driver list.
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2458   *
ac751efa6a0d70 kernel/printk.c        Torben Hohn             2011-01-25  2459   * While the console_lock was held, console output may have been buffered
ac751efa6a0d70 kernel/printk.c        Torben Hohn             2011-01-25  2460   * by printk().  If this is the case, console_unlock(); emits
ac751efa6a0d70 kernel/printk.c        Torben Hohn             2011-01-25  2461   * the output prior to releasing the lock.
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2462   *
7f3a781d6fd81e kernel/printk.c        Kay Sievers             2012-05-09  2463   * If there is output waiting, we wake /dev/kmsg and syslog() users.
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2464   *
ac751efa6a0d70 kernel/printk.c        Torben Hohn             2011-01-25  2465   * console_unlock(); may be called from any context.
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2466   */
ac751efa6a0d70 kernel/printk.c        Torben Hohn             2011-01-25  2467  void console_unlock(void)
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2468  {
6fe29354befe4c kernel/printk/printk.c Tejun Heo               2015-06-25 @2469  	static char ext_text[CONSOLE_EXT_LOG_MAX];
70498253186586 kernel/printk.c        Kay Sievers             2012-07-16  2470  	static char text[LOG_LINE_MAX + PREFIX_MAX];
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2471  	unsigned long flags;
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2472  	bool do_cond_resched, retry;
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2473  	struct printk_info info;
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2474  	struct printk_record r;
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2475  
557240b48e2dc4 kernel/printk.c        Linus Torvalds          2006-06-19  2476  	if (console_suspended) {
bd8d7cf5b8410f kernel/printk/printk.c Jan Kara                2014-06-04  2477  		up_console_sem();
557240b48e2dc4 kernel/printk.c        Linus Torvalds          2006-06-19  2478  		return;
557240b48e2dc4 kernel/printk.c        Linus Torvalds          2006-06-19  2479  	}
78944e549d3667 kernel/printk.c        Antonino A. Daplas      2006-08-05  2480  
f35efc78add643 kernel/printk/printk.c John Ogness             2020-09-19  2481  	prb_rec_init_rd(&r, &info, text, sizeof(text));
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2482  
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2483  	/*
257ab443118bff kernel/printk/printk.c Petr Mladek             2017-03-24  2484  	 * Console drivers are called with interrupts disabled, so
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2485  	 * @console_may_schedule should be cleared before; however, we may
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2486  	 * end up dumping a lot of lines, for example, if called from
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2487  	 * console registration path, and should invoke cond_resched()
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2488  	 * between lines if allowable.  Not doing so can cause a very long
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2489  	 * scheduling stall on a slow console leading to RCU stall and
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2490  	 * softlockup warnings which exacerbate the issue with more
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2491  	 * messages practically incapacitating the system.
257ab443118bff kernel/printk/printk.c Petr Mladek             2017-03-24  2492  	 *
257ab443118bff kernel/printk/printk.c Petr Mladek             2017-03-24  2493  	 * console_trylock() is not able to detect the preemptive
257ab443118bff kernel/printk/printk.c Petr Mladek             2017-03-24  2494  	 * context reliably. Therefore the value must be stored before
547bbf7d214fff kernel/printk/printk.c Randy Dunlap            2020-08-06  2495  	 * and cleared after the "again" goto label.
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2496  	 */
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2497  	do_cond_resched = console_may_schedule;
257ab443118bff kernel/printk/printk.c Petr Mladek             2017-03-24  2498  again:
78944e549d3667 kernel/printk.c        Antonino A. Daplas      2006-08-05  2499  	console_may_schedule = 0;
78944e549d3667 kernel/printk.c        Antonino A. Daplas      2006-08-05  2500  
a8199371afc279 kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2501  	/*
a8199371afc279 kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2502  	 * We released the console_sem lock, so we need to recheck if
a8199371afc279 kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2503  	 * cpu is online and (if not) is there at least one CON_ANYTIME
a8199371afc279 kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2504  	 * console.
a8199371afc279 kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2505  	 */
a8199371afc279 kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2506  	if (!can_use_console()) {
a8199371afc279 kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2507  		console_locked = 0;
a8199371afc279 kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2508  		up_console_sem();
a8199371afc279 kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2509  		return;
a8199371afc279 kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2510  	}
a8199371afc279 kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2511  
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2512  	for (;;) {
6fe29354befe4c kernel/printk/printk.c Tejun Heo               2015-06-25  2513  		size_t ext_len = 0;
3ce9a7c0ac2856 kernel/printk.c        Kay Sievers             2012-05-13  2514  		size_t len;
7ff9554bb578ba kernel/printk.c        Kay Sievers             2012-05-03  2515  
f975237b768279 kernel/printk/printk.c Sergey Senozhatsky      2016-12-27  2516  		printk_safe_enter_irqsave(flags);
f975237b768279 kernel/printk/printk.c Sergey Senozhatsky      2016-12-27  2517  		raw_spin_lock(&logbuf_lock);
084681d14e429c kernel/printk.c        Kay Sievers             2012-06-28  2518  skip:
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2519  		if (!prb_read_valid(prb, console_seq, &r))
7ff9554bb578ba kernel/printk.c        Kay Sievers             2012-05-03  2520  			break;
7ff9554bb578ba kernel/printk.c        Kay Sievers             2012-05-03  2521  
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2522  		if (console_seq != r.info->seq) {
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2523  			console_dropped += r.info->seq - console_seq;
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2524  			console_seq = r.info->seq;
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2525  		}
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2526  
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2527  		if (suppress_message_printing(r.info->level)) {
084681d14e429c kernel/printk.c        Kay Sievers             2012-06-28  2528  			/*
a6ae928c25835c kernel/printk/printk.c Petr Mladek             2018-09-10  2529  			 * Skip record we have buffered and already printed
a6ae928c25835c kernel/printk/printk.c Petr Mladek             2018-09-10  2530  			 * directly to the console when we received it, and
a6ae928c25835c kernel/printk/printk.c Petr Mladek             2018-09-10  2531  			 * record that has level above the console loglevel.
084681d14e429c kernel/printk.c        Kay Sievers             2012-06-28  2532  			 */
084681d14e429c kernel/printk.c        Kay Sievers             2012-06-28  2533  			console_seq++;
084681d14e429c kernel/printk.c        Kay Sievers             2012-06-28  2534  			goto skip;
084681d14e429c kernel/printk.c        Kay Sievers             2012-06-28  2535  		}
649e6ee33f73ba kernel/printk.c        Kay Sievers             2012-05-10  2536  
f92b070f2dc89a kernel/printk/printk.c Petr Mladek             2018-09-13  2537  		/* Output to all consoles once old messages replayed. */
f92b070f2dc89a kernel/printk/printk.c Petr Mladek             2018-09-13  2538  		if (unlikely(exclusive_console &&
f92b070f2dc89a kernel/printk/printk.c Petr Mladek             2018-09-13  2539  			     console_seq >= exclusive_console_stop_seq)) {
f92b070f2dc89a kernel/printk/printk.c Petr Mladek             2018-09-13  2540  			exclusive_console = NULL;
f92b070f2dc89a kernel/printk/printk.c Petr Mladek             2018-09-13  2541  		}
f92b070f2dc89a kernel/printk/printk.c Petr Mladek             2018-09-13  2542  
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2543  		/*
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2544  		 * Handle extended console text first because later
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2545  		 * record_print_text() will modify the record buffer in-place.
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2546  		 */
6fe29354befe4c kernel/printk/printk.c Tejun Heo               2015-06-25  2547  		if (nr_ext_console_drivers) {
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2548  			ext_len = info_print_ext_header(ext_text,
6fe29354befe4c kernel/printk/printk.c Tejun Heo               2015-06-25  2549  						sizeof(ext_text),
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2550  						r.info);
6fe29354befe4c kernel/printk/printk.c Tejun Heo               2015-06-25  2551  			ext_len += msg_print_ext_body(ext_text + ext_len,
6fe29354befe4c kernel/printk/printk.c Tejun Heo               2015-06-25  2552  						sizeof(ext_text) - ext_len,
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2553  						&r.text_buf[0],
74caba7f2a0685 kernel/printk/printk.c John Ogness             2020-09-21  2554  						r.info->text_len,
74caba7f2a0685 kernel/printk/printk.c John Ogness             2020-09-21  2555  						&r.info->dev_info);
6fe29354befe4c kernel/printk/printk.c Tejun Heo               2015-06-25  2556  		}
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2557  		len = record_print_text(&r,
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2558  				console_msg_format & MSG_FORMAT_SYSLOG,
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2559  				printk_time);
7ff9554bb578ba kernel/printk.c        Kay Sievers             2012-05-03  2560  		console_seq++;
07354eb1a74d1e kernel/printk.c        Thomas Gleixner         2009-07-25  2561  		raw_spin_unlock(&logbuf_lock);
7ff9554bb578ba kernel/printk.c        Kay Sievers             2012-05-03  2562  
dbdda842fe96f8 kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2563) 		/*
dbdda842fe96f8 kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2564) 		 * While actively printing out messages, if another printk()
dbdda842fe96f8 kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2565) 		 * were to occur on another CPU, it may wait for this one to
dbdda842fe96f8 kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2566) 		 * finish. This task can not be preempted if there is a
dbdda842fe96f8 kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2567) 		 * waiter waiting to take over.
dbdda842fe96f8 kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2568) 		 */
c162d5b4338d72 kernel/printk/printk.c Petr Mladek             2018-01-12  2569  		console_lock_spinning_enable();
dbdda842fe96f8 kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2570) 
81d68a96a39844 kernel/printk.c        Steven Rostedt          2008-05-12  2571  		stop_critical_timings();	/* don't trace print latency */
d9c23523ed98a3 kernel/printk/printk.c Sergey Senozhatsky      2016-12-24  2572  		call_console_drivers(ext_text, ext_len, text, len);
81d68a96a39844 kernel/printk.c        Steven Rostedt          2008-05-12  2573  		start_critical_timings();
dbdda842fe96f8 kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2574) 
c162d5b4338d72 kernel/printk/printk.c Petr Mladek             2018-01-12  2575  		if (console_lock_spinning_disable_and_check()) {
c162d5b4338d72 kernel/printk/printk.c Petr Mladek             2018-01-12  2576  			printk_safe_exit_irqrestore(flags);
43a17111c25539 kernel/printk/printk.c Sergey Senozhatsky      2018-04-19  2577  			return;
c162d5b4338d72 kernel/printk/printk.c Petr Mladek             2018-01-12  2578  		}
dbdda842fe96f8 kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2579) 
f975237b768279 kernel/printk/printk.c Sergey Senozhatsky      2016-12-27  2580  		printk_safe_exit_irqrestore(flags);
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2581  
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2582  		if (do_cond_resched)
8d91f8b15361df kernel/printk/printk.c Tejun Heo               2016-01-15  2583  			cond_resched();
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2584  	}
dbdda842fe96f8 kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2585) 
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2586  	console_locked = 0;
fe3d8ad31cf51b kernel/printk.c        Feng Tang               2011-03-22  2587  
07354eb1a74d1e kernel/printk.c        Thomas Gleixner         2009-07-25  2588  	raw_spin_unlock(&logbuf_lock);
4f2a8d3cf5e048 kernel/printk.c        Peter Zijlstra          2011-06-22  2589  
bd8d7cf5b8410f kernel/printk/printk.c Jan Kara                2014-06-04  2590  	up_console_sem();
4f2a8d3cf5e048 kernel/printk.c        Peter Zijlstra          2011-06-22  2591  
4f2a8d3cf5e048 kernel/printk.c        Peter Zijlstra          2011-06-22  2592  	/*
4f2a8d3cf5e048 kernel/printk.c        Peter Zijlstra          2011-06-22  2593  	 * Someone could have filled up the buffer again, so re-check if there's
4f2a8d3cf5e048 kernel/printk.c        Peter Zijlstra          2011-06-22  2594  	 * something to flush. In case we cannot trylock the console_sem again,
4f2a8d3cf5e048 kernel/printk.c        Peter Zijlstra          2011-06-22  2595  	 * there's a new owner and the console_unlock() from them will do the
4f2a8d3cf5e048 kernel/printk.c        Peter Zijlstra          2011-06-22  2596  	 * flush, no worries.
4f2a8d3cf5e048 kernel/printk.c        Peter Zijlstra          2011-06-22  2597  	 */
07354eb1a74d1e kernel/printk.c        Thomas Gleixner         2009-07-25  2598  	raw_spin_lock(&logbuf_lock);
896fbe20b4e233 kernel/printk/printk.c John Ogness             2020-07-09  2599  	retry = prb_read_valid(prb, console_seq, NULL);
f975237b768279 kernel/printk/printk.c Sergey Senozhatsky      2016-12-27  2600  	raw_spin_unlock(&logbuf_lock);
f975237b768279 kernel/printk/printk.c Sergey Senozhatsky      2016-12-27  2601  	printk_safe_exit_irqrestore(flags);
09dc3cf93f7d16 kernel/printk.c        Peter Zijlstra          2011-12-08  2602  
4f2a8d3cf5e048 kernel/printk.c        Peter Zijlstra          2011-06-22  2603  	if (retry && console_trylock())
4f2a8d3cf5e048 kernel/printk.c        Peter Zijlstra          2011-06-22  2604  		goto again;
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2605  }
ac751efa6a0d70 kernel/printk.c        Torben Hohn             2011-01-25  2606  EXPORT_SYMBOL(console_unlock);
^1da177e4c3f41 kernel/printk.c        Linus Torvalds          2005-04-16  2607  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VS++wcV0S1rZb1Fb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
BtwXT7lnLytaln8B8SpVaeiFAQA=

--VS++wcV0S1rZb1Fb--
