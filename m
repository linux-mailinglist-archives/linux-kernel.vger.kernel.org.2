Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247E63D4F07
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 19:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhGYQfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 12:35:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:43911 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGYQfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 12:35:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="210223280"
X-IronPort-AV: E=Sophos;i="5.84,269,1620716400"; 
   d="gz'50?scan'50,208,50";a="210223280"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2021 10:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,269,1620716400"; 
   d="gz'50?scan'50,208,50";a="661594495"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2021 10:15:48 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m7hj9-0004is-Vv; Sun, 25 Jul 2021 17:15:47 +0000
Date:   Mon, 26 Jul 2021 01:14:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mcgrof-next:20210708-block-fixes-v2 23/89]
 arch/um/drivers/ubd_kern.c:930:24: error: expected ';' before
 'out_cleanup_tags'
Message-ID: <202107260139.R51HU5n5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210708-block-fixes-v2
head:   db0174e39de7dc941f158ce53ee3af95b1635b62
commit: eed79117e58fb752797d7efe719f7f75a12ee2a7 [23/89] um/drivers/ubd_kern: add error handling support for add_disk()
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=eed79117e58fb752797d7efe719f7f75a12ee2a7
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20210708-block-fixes-v2
        git checkout eed79117e58fb752797d7efe719f7f75a12ee2a7
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/um/drivers/ubd_kern.c: In function 'ubd_add':
>> arch/um/drivers/ubd_kern.c:930:24: error: expected ';' before 'out_cleanup_tags'
     930 |  blk_cleanup_disk(disk)
         |                        ^
         |                        ;
     931 | out_cleanup_tags:
         | ~~~~~~~~~~~~~~~~        
>> arch/um/drivers/ubd_kern.c:915:3: error: label 'out_cleanup_tags' used but not defined
     915 |   goto out_cleanup_tags;
         |   ^~~~


vim +930 arch/um/drivers/ubd_kern.c

   883	
   884	static int ubd_add(int n, char **error_out)
   885	{
   886		struct ubd *ubd_dev = &ubd_devs[n];
   887		struct gendisk *disk;
   888		int err = 0;
   889	
   890		if(ubd_dev->file == NULL)
   891			goto out;
   892	
   893		err = ubd_file_size(ubd_dev, &ubd_dev->size);
   894		if(err < 0){
   895			*error_out = "Couldn't determine size of device's file";
   896			goto out;
   897		}
   898	
   899		ubd_dev->size = ROUND_BLOCK(ubd_dev->size);
   900	
   901		ubd_dev->tag_set.ops = &ubd_mq_ops;
   902		ubd_dev->tag_set.queue_depth = 64;
   903		ubd_dev->tag_set.numa_node = NUMA_NO_NODE;
   904		ubd_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
   905		ubd_dev->tag_set.driver_data = ubd_dev;
   906		ubd_dev->tag_set.nr_hw_queues = 1;
   907	
   908		err = blk_mq_alloc_tag_set(&ubd_dev->tag_set);
   909		if (err)
   910			goto out;
   911	
   912		disk = blk_mq_alloc_disk(&ubd_dev->tag_set, ubd_dev);
   913		if (IS_ERR(disk)) {
   914			err = PTR_ERR(disk);
 > 915			goto out_cleanup_tags;
   916		}
   917		ubd_dev->queue = disk->queue;
   918	
   919		blk_queue_write_cache(ubd_dev->queue, true, false);
   920		blk_queue_max_segments(ubd_dev->queue, MAX_SG);
   921		blk_queue_segment_boundary(ubd_dev->queue, PAGE_SIZE - 1);
   922		err = ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
   923		if (err)
   924			goto out_cleanup_disk;
   925	
   926		ubd_gendisk[n] = disk;
   927		return 0;
   928	
   929	out_cleanup_disk:
 > 930		blk_cleanup_disk(disk)
   931	out_cleanup_tags:
   932		blk_mq_free_tag_set(&ubd_dev->tag_set);
   933	out:
   934		return err;
   935	}
   936	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/wFULt7s2JUAAA==

--+HP7ph2BbKc20aGI--
