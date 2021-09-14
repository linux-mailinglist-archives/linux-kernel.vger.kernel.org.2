Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF93F40BC25
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 01:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhINX3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 19:29:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:63761 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbhINX3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:29:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="285849561"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="gz'50?scan'50,208,50";a="285849561"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 16:28:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="gz'50?scan'50,208,50";a="529157982"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2021 16:28:29 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mQHqn-0008rG-53; Tue, 14 Sep 2021 23:28:29 +0000
Date:   Wed, 15 Sep 2021 07:27:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:locking/futex 4/8] kernel/futex/core.c:2804:23:
 warning: cast to pointer from integer of different size
Message-ID: <202109150749.atkhGTAn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/futex
head:   3e6fb0c7cd6f4839a2ac03396781247f7e902875
commit: 038e21d9eaa0a4bc011f9d4e8d006e8072a48422 [4/8] futex: Implement sys_futex_waitv()
config: um-i386_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=038e21d9eaa0a4bc011f9d4e8d006e8072a48422
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue locking/futex
        git checkout 038e21d9eaa0a4bc011f9d4e8d006e8072a48422
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=i386

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/futex/core.c: In function 'futex_wait_multiple_setup':
>> kernel/futex/core.c:2804:23: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    2804 |   u32 __user *uaddr = (u32 __user *)vs[i].w.uaddr;
         |                       ^


vim +2804 kernel/futex/core.c

  2750	
  2751	/**
  2752	 * futex_wait_multiple_setup - Prepare to wait and enqueue multiple futexes
  2753	 * @vs:		The futex list to wait on
  2754	 * @count:	The size of the list
  2755	 * @awaken:	Index of the last awoken futex, if any. Used to notify the
  2756	 *		caller that it can return this index to userspace (return parameter)
  2757	 *
  2758	 * Prepare multiple futexes in a single step and enqueue them. This may fail if
  2759	 * the futex list is invalid or if any futex was already awoken. On success the
  2760	 * task is ready to interruptible sleep.
  2761	 *
  2762	 * Return:
  2763	 *  -  1 - One of the futexes was awaken by another thread
  2764	 *  -  0 - Success
  2765	 *  - <0 - -EFAULT, -EWOULDBLOCK or -EINVAL
  2766	 */
  2767	static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *awaken)
  2768	{
  2769		struct futex_hash_bucket *hb;
  2770		bool retry = false;
  2771		int ret, i;
  2772		u32 uval;
  2773	
  2774		/*
  2775		 * Enqueuing multiple futexes is tricky, because we need to enqueue
  2776		 * each futex in the list before dealing with the next one to avoid
  2777		 * deadlocking on the hash bucket. But, before enqueuing, we need to
  2778		 * make sure that current->state is TASK_INTERRUPTIBLE, so we don't
  2779		 * absorb any awake events, which cannot be done before the
  2780		 * get_futex_key of the next key, because it calls get_user_pages,
  2781		 * which can sleep. Thus, we fetch the list of futexes keys in two
  2782		 * steps, by first pinning all the memory keys in the futex key, and
  2783		 * only then we read each key and queue the corresponding futex.
  2784		 *
  2785		 * Private futexes doesn't need to recalculate hash in retry, so skip
  2786		 * get_futex_key() when retrying.
  2787		 */
  2788	retry:
  2789		for (i = 0; i < count; i++) {
  2790			if ((vs[i].w.flags & FUTEX_PRIVATE_FLAG) && retry)
  2791				continue;
  2792	
  2793			ret = get_futex_key(u64_to_user_ptr(vs[i].w.uaddr),
  2794					    !(vs[i].w.flags & FUTEX_PRIVATE_FLAG),
  2795					    &vs[i].q.key, FUTEX_READ);
  2796	
  2797			if (unlikely(ret))
  2798				return ret;
  2799		}
  2800	
  2801		set_current_state(TASK_INTERRUPTIBLE);
  2802	
  2803		for (i = 0; i < count; i++) {
> 2804			u32 __user *uaddr = (u32 __user *)vs[i].w.uaddr;
  2805			struct futex_q *q = &vs[i].q;
  2806			u32 val = (u32)vs[i].w.val;
  2807	
  2808			hb = queue_lock(q);
  2809			ret = get_futex_value_locked(&uval, uaddr);
  2810	
  2811			if (!ret && uval == val) {
  2812				/*
  2813				 * The bucket lock can't be held while dealing with the
  2814				 * next futex. Queue each futex at this moment so hb can
  2815				 * be unlocked.
  2816				 */
  2817				queue_me(q, hb);
  2818				continue;
  2819			}
  2820	
  2821			queue_unlock(hb);
  2822			__set_current_state(TASK_RUNNING);
  2823	
  2824			/*
  2825			 * Even if something went wrong, if we find out that a futex
  2826			 * was awaken, we don't return error and return this index to
  2827			 * userspace
  2828			 */
  2829			*awaken = unqueue_multiple(vs, i);
  2830			if (*awaken >= 0)
  2831				return 1;
  2832	
  2833			if (uval != val)
  2834				return -EWOULDBLOCK;
  2835	
  2836			if (ret) {
  2837				/*
  2838				 * If we need to handle a page fault, we need to do so
  2839				 * without any lock and any enqueued futex (otherwise
  2840				 * we could lose some wakeup). So we do it here, after
  2841				 * undoing all the work done so far. In success, we
  2842				 * retry all the work.
  2843				 */
  2844				if (get_user(uval, uaddr))
  2845					return -EFAULT;
  2846	
  2847				retry = true;
  2848				goto retry;
  2849			}
  2850		}
  2851	
  2852		return 0;
  2853	}
  2854	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--UugvWAfsgieZRqgk
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
YmZAnzqwiNCnP+Me0HGqkzbi/wFc9E8ff5gAAA==

--UugvWAfsgieZRqgk--
