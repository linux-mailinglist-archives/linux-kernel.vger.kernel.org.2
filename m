Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48E7452721
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 03:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245538AbhKPCQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 21:16:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:61004 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238756AbhKORsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 12:48:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="233328564"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="gz'50?scan'50,208,50";a="233328564"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 09:40:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="gz'50?scan'50,208,50";a="535581292"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Nov 2021 09:40:44 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mmfyF-000MpH-Gz; Mon, 15 Nov 2021 17:40:43 +0000
Date:   Tue, 16 Nov 2021 01:40:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, willy@infradead.org, dhowells@redhat.com,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        jglisse@redhat.com, jgg@nvidia.com, rcampbell@nvidia.com,
        jhubbard@nvidia.com
Subject: Re: [PATCH v3] mm/migrate.c: Rework migration_entry_wait() to not
 take a pageref
Message-ID: <202111160147.rAGM9CgH-lkp@intel.com>
References: <20211115105222.4183286-1-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20211115105222.4183286-1-apopple@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alistair,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.16-rc1 next-20211115]
[cannot apply to hnaz-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Alistair-Popple/mm-migrate-c-Rework-migration_entry_wait-to-not-take-a-pageref/20211115-185444
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git debe436e77c72fcee804fb867f275e6d31aa999c
config: nios2-defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/91a437ddc7606450e331059d80babe2d4c1163e0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Alistair-Popple/mm-migrate-c-Rework-migration_entry_wait-to-not-take-a-pageref/20211115-185444
        git checkout 91a437ddc7606450e331059d80babe2d4c1163e0
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/filemap.c:1447:6: warning: no previous prototype for 'migration_entry_wait_on_locked' [-Wmissing-prototypes]
    1447 | void migration_entry_wait_on_locked(struct folio *folio, pte_t *ptep,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/migration_entry_wait_on_locked +1447 mm/filemap.c

  1428	
  1429	#ifdef CONFIG_MIGRATION
  1430	/**
  1431	 * migration_entry_wait_on_locked - Wait for a migration entry to be removed
  1432	 * @page: page referenced by the migration entry.
  1433	 * @ptep: mapped pte pointer. This function will return with the ptep unmapped.
  1434	 * @ptl: already locked ptl. This function will drop the lock.
  1435	 *
  1436	 * Wait for a migration entry referencing the given page to be removed. This is
  1437	 * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
  1438	 * this can be called without taking a reference on the page. Instead this
  1439	 * should be called while holding the ptl for the migration entry referencing
  1440	 * the page.
  1441	 *
  1442	 * Returns after unmapping and unlocking the pte/ptl with pte_unmap_unlock().
  1443	 *
  1444	 * This follows the same logic as wait_on_page_bit_common() so see the comments
  1445	 * there.
  1446	 */
> 1447	void migration_entry_wait_on_locked(struct folio *folio, pte_t *ptep,
  1448					spinlock_t *ptl)
  1449	{
  1450		struct wait_page_queue wait_page;
  1451		wait_queue_entry_t *wait = &wait_page.wait;
  1452		bool thrashing = false;
  1453		bool delayacct = false;
  1454		unsigned long pflags;
  1455		wait_queue_head_t *q;
  1456	
  1457		q = folio_waitqueue(folio);
  1458		if (!folio_test_uptodate(folio) && folio_test_workingset(folio)) {
  1459			if (!folio_test_swapbacked(folio)) {
  1460				delayacct_thrashing_start();
  1461				delayacct = true;
  1462			}
  1463			psi_memstall_enter(&pflags);
  1464			thrashing = true;
  1465		}
  1466	
  1467		init_wait(wait);
  1468		wait->func = wake_page_function;
  1469		wait_page.folio = folio;
  1470		wait_page.bit_nr = PG_locked;
  1471		wait->flags = 0;
  1472	
  1473		spin_lock_irq(&q->lock);
  1474		folio_set_waiters(folio);
  1475		if (!folio_trylock_flag(folio, PG_locked, wait))
  1476			__add_wait_queue_entry_tail(q, wait);
  1477		spin_unlock_irq(&q->lock);
  1478	
  1479		/*
  1480		 * If a migration entry exists for the page the migration path must hold
  1481		 * a valid reference to the page, and it must take the ptl to remove the
  1482		 * migration entry. So the page is valid until the ptl is dropped.
  1483		 */
  1484		if (ptep)
  1485			pte_unmap_unlock(ptep, ptl);
  1486		else
  1487			spin_unlock(ptl);
  1488	
  1489		for (;;) {
  1490			unsigned int flags;
  1491	
  1492			set_current_state(TASK_UNINTERRUPTIBLE);
  1493	
  1494			/* Loop until we've been woken or interrupted */
  1495			flags = smp_load_acquire(&wait->flags);
  1496			if (!(flags & WQ_FLAG_WOKEN)) {
  1497				if (signal_pending_state(TASK_UNINTERRUPTIBLE, current))
  1498					break;
  1499	
  1500				io_schedule();
  1501				continue;
  1502			}
  1503			break;
  1504		}
  1505	
  1506		finish_wait(q, wait);
  1507	
  1508		if (thrashing) {
  1509			if (delayacct)
  1510				delayacct_thrashing_end();
  1511			psi_memstall_leave(&pflags);
  1512		}
  1513	}
  1514	#endif
  1515	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--FCuugMFkClbJLl1L
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
jIau9qsAAA==

--FCuugMFkClbJLl1L--
