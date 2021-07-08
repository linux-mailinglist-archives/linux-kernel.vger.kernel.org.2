Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9DF3C1460
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhGHNkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:40:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:48500 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231755AbhGHNkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:40:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="189882792"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="gz'50?scan'50,208,50";a="189882792"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 06:37:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="gz'50?scan'50,208,50";a="628504133"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2021 06:37:34 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m1UDd-000EIf-Hw; Thu, 08 Jul 2021 13:37:33 +0000
Date:   Thu, 8 Jul 2021 21:37:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [linux-rt-devel:linux-5.13.y-rt-rebase 9/222]
 kernel/printk/printk.c:2648:4: error: implicit declaration of function
 'latched_seq_write'
Message-ID: <202107082118.QYPDyoR3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.13.y-rt-rebase
head:   7e175e6b59975c8901ad370f7818937f68de45c1
commit: 7995ace9ab04969b9d5577e5fd74d77765c7d917 [9/222] printk: use seqcount_latch for console_seq
config: i386-tinyconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=7995ace9ab04969b9d5577e5fd74d77765c7d917
        git remote add linux-rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags linux-rt-devel linux-5.13.y-rt-rebase
        git checkout 7995ace9ab04969b9d5577e5fd74d77765c7d917
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/printk/printk.c:176:5: warning: no previous prototype for 'devkmsg_sysctl_set_loglvl' [-Wmissing-prototypes]
     176 | int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c:2282:2: error: #error FIXME
    2282 | #error FIXME
         |  ^~~~~
   kernel/printk/printk.c: In function 'console_unlock':
   kernel/printk/printk.c:2642:9: error: implicit declaration of function 'latched_seq_read_nolock' [-Werror=implicit-function-declaration]
    2642 |   seq = latched_seq_read_nolock(&console_seq);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
>> kernel/printk/printk.c:2648:4: error: implicit declaration of function 'latched_seq_write' [-Werror=implicit-function-declaration]
    2648 |    latched_seq_write(&console_seq, r.info->seq);
         |    ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/latched_seq_write +2648 kernel/printk/printk.c

  2576	
  2577	/**
  2578	 * console_unlock - unlock the console system
  2579	 *
  2580	 * Releases the console_lock which the caller holds on the console system
  2581	 * and the console driver list.
  2582	 *
  2583	 * While the console_lock was held, console output may have been buffered
  2584	 * by printk().  If this is the case, console_unlock(); emits
  2585	 * the output prior to releasing the lock.
  2586	 *
  2587	 * If there is output waiting, we wake /dev/kmsg and syslog() users.
  2588	 *
  2589	 * console_unlock(); may be called from any context.
  2590	 */
  2591	void console_unlock(void)
  2592	{
  2593		static char ext_text[CONSOLE_EXT_LOG_MAX];
  2594		static char text[CONSOLE_LOG_MAX];
  2595		unsigned long flags;
  2596		bool do_cond_resched, retry;
  2597		struct printk_info info;
  2598		struct printk_record r;
  2599		u64 seq;
  2600	
  2601		if (console_suspended) {
  2602			up_console_sem();
  2603			return;
  2604		}
  2605	
  2606		prb_rec_init_rd(&r, &info, text, sizeof(text));
  2607	
  2608		/*
  2609		 * Console drivers are called with interrupts disabled, so
  2610		 * @console_may_schedule should be cleared before; however, we may
  2611		 * end up dumping a lot of lines, for example, if called from
  2612		 * console registration path, and should invoke cond_resched()
  2613		 * between lines if allowable.  Not doing so can cause a very long
  2614		 * scheduling stall on a slow console leading to RCU stall and
  2615		 * softlockup warnings which exacerbate the issue with more
  2616		 * messages practically incapacitating the system.
  2617		 *
  2618		 * console_trylock() is not able to detect the preemptive
  2619		 * context reliably. Therefore the value must be stored before
  2620		 * and cleared after the "again" goto label.
  2621		 */
  2622		do_cond_resched = console_may_schedule;
  2623	again:
  2624		console_may_schedule = 0;
  2625	
  2626		/*
  2627		 * We released the console_sem lock, so we need to recheck if
  2628		 * cpu is online and (if not) is there at least one CON_ANYTIME
  2629		 * console.
  2630		 */
  2631		if (!can_use_console()) {
  2632			console_locked = 0;
  2633			up_console_sem();
  2634			return;
  2635		}
  2636	
  2637		for (;;) {
  2638			size_t ext_len = 0;
  2639			size_t len;
  2640	
  2641	skip:
  2642			seq = latched_seq_read_nolock(&console_seq);
  2643			if (!prb_read_valid(prb, seq, &r))
  2644				break;
  2645	
  2646			if (seq != r.info->seq) {
  2647				console_dropped += r.info->seq - seq;
> 2648				latched_seq_write(&console_seq, r.info->seq);
  2649				seq = r.info->seq;
  2650			}
  2651	
  2652			if (suppress_message_printing(r.info->level)) {
  2653				/*
  2654				 * Skip record we have buffered and already printed
  2655				 * directly to the console when we received it, and
  2656				 * record that has level above the console loglevel.
  2657				 */
  2658				latched_seq_write(&console_seq, seq + 1);
  2659				goto skip;
  2660			}
  2661	
  2662			/* Output to all consoles once old messages replayed. */
  2663			if (unlikely(exclusive_console &&
  2664				     seq >= exclusive_console_stop_seq)) {
  2665				exclusive_console = NULL;
  2666			}
  2667	
  2668			/*
  2669			 * Handle extended console text first because later
  2670			 * record_print_text() will modify the record buffer in-place.
  2671			 */
  2672			if (nr_ext_console_drivers) {
  2673				ext_len = info_print_ext_header(ext_text,
  2674							sizeof(ext_text),
  2675							r.info);
  2676				ext_len += msg_print_ext_body(ext_text + ext_len,
  2677							sizeof(ext_text) - ext_len,
  2678							&r.text_buf[0],
  2679							r.info->text_len,
  2680							&r.info->dev_info);
  2681			}
  2682			len = record_print_text(&r,
  2683					console_msg_format & MSG_FORMAT_SYSLOG,
  2684					printk_time);
  2685			latched_seq_write(&console_seq, seq + 1);
  2686	
  2687			printk_safe_enter_irqsave(flags);
  2688	
  2689			/*
  2690			 * While actively printing out messages, if another printk()
  2691			 * were to occur on another CPU, it may wait for this one to
  2692			 * finish. This task can not be preempted if there is a
  2693			 * waiter waiting to take over.
  2694			 */
  2695			console_lock_spinning_enable();
  2696	
  2697			stop_critical_timings();	/* don't trace print latency */
  2698			call_console_drivers(ext_text, ext_len, text, len);
  2699			start_critical_timings();
  2700	
  2701			if (console_lock_spinning_disable_and_check()) {
  2702				printk_safe_exit_irqrestore(flags);
  2703				return;
  2704			}
  2705	
  2706			printk_safe_exit_irqrestore(flags);
  2707	
  2708			if (do_cond_resched)
  2709				cond_resched();
  2710		}
  2711	
  2712		console_locked = 0;
  2713	
  2714		up_console_sem();
  2715	
  2716		/*
  2717		 * Someone could have filled up the buffer again, so re-check if there's
  2718		 * something to flush. In case we cannot trylock the console_sem again,
  2719		 * there's a new owner and the console_unlock() from them will do the
  2720		 * flush, no worries.
  2721		 */
  2722		retry = prb_read_valid(prb, latched_seq_read_nolock(&console_seq), NULL);
  2723		if (retry && console_trylock())
  2724			goto again;
  2725	}
  2726	EXPORT_SYMBOL(console_unlock);
  2727	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Dxnq1zWXvFF0Q93v
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
6W3y6425/wAN04EXP2sAAA==

--Dxnq1zWXvFF0Q93v--
