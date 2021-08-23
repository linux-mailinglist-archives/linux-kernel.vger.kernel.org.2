Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4DB3F44A9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 07:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhHWFlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 01:41:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:17052 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231267AbhHWFlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 01:41:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="196612080"
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="gz'50?scan'50,208,50";a="196612080"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2021 22:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="gz'50?scan'50,208,50";a="514621517"
Received: from lkp-server02.sh.intel.com (HELO ca0e9373e375) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 22 Aug 2021 22:40:19 -0700
Received: from kbuild by ca0e9373e375 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mI2h0-00001k-JB; Mon, 23 Aug 2021 05:40:18 +0000
Date:   Mon, 23 Aug 2021 13:39:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [block:for-5.15/io_uring-late 5/10] fs/io_uring.c:1429:61: warning:
 parameter 'locked' set but not used
Message-ID: <202108231310.6pI1RKs7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.15/io_uring-late
head:   7183e74cadee8d9a65f2dbd23d41006e96ecb26e
commit: 984a7d0be18d007162655ae84db6f54d2449ed2d [5/10] io_uring: batch task work locking
config: nios2-defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=984a7d0be18d007162655ae84db6f54d2449ed2d
        git remote add block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags block for-5.15/io_uring-late
        git checkout 984a7d0be18d007162655ae84db6f54d2449ed2d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/io_uring.c: In function 'io_queue_async_work':
>> fs/io_uring.c:1429:61: warning: parameter 'locked' set but not used [-Wunused-but-set-parameter]
    1429 | static void io_queue_async_work(struct io_kiocb *req, bool *locked)
         |                                                       ~~~~~~^~~~~~


vim +/locked +1429 fs/io_uring.c

  1428	
> 1429	static void io_queue_async_work(struct io_kiocb *req, bool *locked)
  1430	{
  1431		struct io_ring_ctx *ctx = req->ctx;
  1432		struct io_kiocb *link = io_prep_linked_timeout(req);
  1433		struct io_uring_task *tctx = req->task->io_uring;
  1434	
  1435		/* must not take the lock, NULL it as a precaution */
  1436		locked = NULL;
  1437	
  1438		BUG_ON(!tctx);
  1439		BUG_ON(!tctx->io_wq);
  1440	
  1441		/* init ->work of the whole link before punting */
  1442		io_prep_async_link(req);
  1443	
  1444		/*
  1445		 * Not expected to happen, but if we do have a bug where this _can_
  1446		 * happen, catch it here and ensure the request is marked as
  1447		 * canceled. That will make io-wq go through the usual work cancel
  1448		 * procedure rather than attempt to run this request (or create a new
  1449		 * worker for it).
  1450		 */
  1451		if (WARN_ON_ONCE(!same_thread_group(req->task, current)))
  1452			req->work.flags |= IO_WQ_WORK_CANCEL;
  1453	
  1454		trace_io_uring_queue_async_work(ctx, io_wq_is_hashed(&req->work), req,
  1455						&req->work, req->flags);
  1456		io_wq_enqueue(tctx->io_wq, &req->work);
  1457		if (link)
  1458			io_queue_linked_timeout(link);
  1459	}
  1460	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--17pEHd4RhPHOinZp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--17pEHd4RhPHOinZp--
