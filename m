Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC9B3F28A0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhHTIpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:45:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:18555 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhHTIpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:45:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216772399"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="gz'50?scan'50,208,50";a="216772399"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 01:45:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="gz'50?scan'50,208,50";a="512456533"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2021 01:45:11 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mH09H-000Ugk-3v; Fri, 20 Aug 2021 08:45:11 +0000
Date:   Fri, 20 Aug 2021 16:44:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mcgrof-next:20210819-add-disk-error-handling-next 49/90]
 arch/um/drivers/ubd_kern.c:930:24: error: expected ';' before
 'out_cleanup_tags'
Message-ID: <202108201609.PRl42maB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210819-add-disk-error-handling-next
head:   4a644c3aee4465306a79d393956c84ce8925fa6b
commit: 21b0a62497fab52bffe4e6fc20be46e7f8d4bbb1 [49/90] um/drivers/ubd_kern: add error handling support for add_disk()
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=21b0a62497fab52bffe4e6fc20be46e7f8d4bbb1
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20210819-add-disk-error-handling-next
        git checkout 21b0a62497fab52bffe4e6fc20be46e7f8d4bbb1
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

--ew6BAiZeqk4r7MaW
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
zzu+f/L5/wBUbingkJYAAA==

--ew6BAiZeqk4r7MaW--
