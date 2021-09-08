Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB20403FD2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350637AbhIHTc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:32:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:26645 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233179AbhIHTc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:32:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="220634044"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="gz'50?scan'50,208,50";a="220634044"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 12:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="gz'50?scan'50,208,50";a="606416992"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2021 12:31:16 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mO3Hv-0002Yy-GG; Wed, 08 Sep 2021 19:31:15 +0000
Date:   Thu, 9 Sep 2021 03:30:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [block:io_uring-fops.v7 6/8] fs/block_dev.c:344:10: error: implicit
 declaration of function 'blkdev_uring_ioctl'; did you mean
 'blkdev_async_ioctl'?
Message-ID: <202109090340.cKQ1zpPB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git io_uring-fops.v7
head:   733ce76b0107afe87534cfdd5403594ccef3bbe9
commit: e9640aeebe88d42bf792d7ad773498d7f001b453 [6/8] block: add example ioctl
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=e9640aeebe88d42bf792d7ad773498d7f001b453
        git remote add block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags block io_uring-fops.v7
        git checkout e9640aeebe88d42bf792d7ad773498d7f001b453
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/block_dev.c: In function 'blkdev_async_cmd':
>> fs/block_dev.c:344:10: error: implicit declaration of function 'blkdev_uring_ioctl'; did you mean 'blkdev_async_ioctl'? [-Werror=implicit-function-declaration]
     344 |   return blkdev_uring_ioctl(bdev, cmd);
         |          ^~~~~~~~~~~~~~~~~~
         |          blkdev_async_ioctl
   At top level:
   fs/block_dev.c:324:12: warning: 'blkdev_async_ioctl' defined but not used [-Wunused-function]
     324 | static int blkdev_async_ioctl(struct block_device *bdev,
         |            ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +344 fs/block_dev.c

   336	
   337	static int blkdev_async_cmd(struct io_uring_cmd *cmd,
   338				    enum io_uring_cmd_flags flags)
   339	{
   340		struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
   341	
   342		switch (cmd->op) {
   343		case BLOCK_URING_OP_IOCTL:
 > 344			return blkdev_uring_ioctl(bdev, cmd);
   345		default:
   346			break;
   347		}
   348	
   349		return blk_uring_cmd(bdev, cmd, flags);
   350	}
   351	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--lrZ03NoBR/3+SXJZ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
OwM674FdhT5DWneIjveetDT/DyTEeE8TlgAA

--lrZ03NoBR/3+SXJZ--
