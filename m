Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BCC45E204
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357178AbhKYVSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:18:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:59842 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232617AbhKYVQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:16:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="296372646"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="296372646"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:11:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="457487608"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Nov 2021 13:11:52 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqM23-0006vt-FO; Thu, 25 Nov 2021 21:11:51 +0000
Date:   Fri, 26 Nov 2021 05:11:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [ti:ti-rt-linux-5.10.y 7559/10206]
 drivers/media/pci/intel/ipu3/ipu3-cio2.c:983:27: error: incompatible pointer
 types passing 'struct media_entity *' to parameter of type 'struct media_pad
 *'
Message-ID: <202111260514.iLTDT5ia-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

FYI, the error/warning still remains.

tree:   git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git ti-rt-linux-5.10.y
head:   0c67d996db8f3c9149598bc98657ae28fee22208
commit: d42003cd0440e21c8940801e58ba2aabf3dc13b6 [7559/10206] media: entity: Use pad as the starting point for a pipeline
config: i386-randconfig-a003-20211118 (https://download.01.org/0day-ci/archive/20211126/202111260514.iLTDT5ia-lkp@intel.com/config)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add ti git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git
        git fetch --no-tags ti ti-rt-linux-5.10.y
        git checkout d42003cd0440e21c8940801e58ba2aabf3dc13b6
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/media/pci/intel/ipu3/ipu3-cio2.c:983:27: error: incompatible pointer types passing 'struct media_entity *' to parameter of type 'struct media_pad *' [-Werror,-Wincompatible-pointer-types]
           r = media_pipeline_start(&q->vdev.entity, &q->pipe);
                                    ^~~~~~~~~~~~~~~
   include/media/media-entity.h:948:57: note: passing argument to parameter 'pad' here
   __must_check int media_pipeline_start(struct media_pad *pad,
                                                           ^
   drivers/media/pci/intel/ipu3/ipu3-cio2.c:1003:22: error: incompatible pointer types passing 'struct media_entity *' to parameter of type 'struct media_pad *' [-Werror,-Wincompatible-pointer-types]
           media_pipeline_stop(&q->vdev.entity);
                               ^~~~~~~~~~~~~~~
   include/media/media-entity.h:972:44: note: passing argument to parameter 'pad' here
   void media_pipeline_stop(struct media_pad *pad);
                                              ^
   drivers/media/pci/intel/ipu3/ipu3-cio2.c:1024:22: error: incompatible pointer types passing 'struct media_entity *' to parameter of type 'struct media_pad *' [-Werror,-Wincompatible-pointer-types]
           media_pipeline_stop(&q->vdev.entity);
                               ^~~~~~~~~~~~~~~
   include/media/media-entity.h:972:44: note: passing argument to parameter 'pad' here
   void media_pipeline_stop(struct media_pad *pad);
                                              ^
   3 errors generated.


vim +983 drivers/media/pci/intel/ipu3/ipu3-cio2.c

c2a6a07afe4a466 Yong Zhi 2017-11-08   966  
c2a6a07afe4a466 Yong Zhi 2017-11-08   967  static int cio2_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
c2a6a07afe4a466 Yong Zhi 2017-11-08   968  {
c2a6a07afe4a466 Yong Zhi 2017-11-08   969  	struct cio2_queue *q = vb2q_to_cio2_queue(vq);
c2a6a07afe4a466 Yong Zhi 2017-11-08   970  	struct cio2_device *cio2 = vb2_get_drv_priv(vq);
c2a6a07afe4a466 Yong Zhi 2017-11-08   971  	int r;
c2a6a07afe4a466 Yong Zhi 2017-11-08   972  
c2a6a07afe4a466 Yong Zhi 2017-11-08   973  	cio2->cur_queue = q;
c2a6a07afe4a466 Yong Zhi 2017-11-08   974  	atomic_set(&q->frame_sequence, 0);
c2a6a07afe4a466 Yong Zhi 2017-11-08   975  
c2a6a07afe4a466 Yong Zhi 2017-11-08   976  	r = pm_runtime_get_sync(&cio2->pci_dev->dev);
c2a6a07afe4a466 Yong Zhi 2017-11-08   977  	if (r < 0) {
c2a6a07afe4a466 Yong Zhi 2017-11-08   978  		dev_info(&cio2->pci_dev->dev, "failed to set power %d\n", r);
c2a6a07afe4a466 Yong Zhi 2017-11-08   979  		pm_runtime_put_noidle(&cio2->pci_dev->dev);
c2a6a07afe4a466 Yong Zhi 2017-11-08   980  		return r;
c2a6a07afe4a466 Yong Zhi 2017-11-08   981  	}
c2a6a07afe4a466 Yong Zhi 2017-11-08   982  
c2a6a07afe4a466 Yong Zhi 2017-11-08  @983  	r = media_pipeline_start(&q->vdev.entity, &q->pipe);
c2a6a07afe4a466 Yong Zhi 2017-11-08   984  	if (r)
c2a6a07afe4a466 Yong Zhi 2017-11-08   985  		goto fail_pipeline;
c2a6a07afe4a466 Yong Zhi 2017-11-08   986  
c2a6a07afe4a466 Yong Zhi 2017-11-08   987  	r = cio2_hw_init(cio2, q);
c2a6a07afe4a466 Yong Zhi 2017-11-08   988  	if (r)
c2a6a07afe4a466 Yong Zhi 2017-11-08   989  		goto fail_hw;
c2a6a07afe4a466 Yong Zhi 2017-11-08   990  
c2a6a07afe4a466 Yong Zhi 2017-11-08   991  	/* Start streaming on sensor */
c2a6a07afe4a466 Yong Zhi 2017-11-08   992  	r = v4l2_subdev_call(q->sensor, video, s_stream, 1);
c2a6a07afe4a466 Yong Zhi 2017-11-08   993  	if (r)
c2a6a07afe4a466 Yong Zhi 2017-11-08   994  		goto fail_csi2_subdev;
c2a6a07afe4a466 Yong Zhi 2017-11-08   995  
c2a6a07afe4a466 Yong Zhi 2017-11-08   996  	cio2->streaming = true;
c2a6a07afe4a466 Yong Zhi 2017-11-08   997  
c2a6a07afe4a466 Yong Zhi 2017-11-08   998  	return 0;
c2a6a07afe4a466 Yong Zhi 2017-11-08   999  
c2a6a07afe4a466 Yong Zhi 2017-11-08  1000  fail_csi2_subdev:
c2a6a07afe4a466 Yong Zhi 2017-11-08  1001  	cio2_hw_exit(cio2, q);
c2a6a07afe4a466 Yong Zhi 2017-11-08  1002  fail_hw:
c2a6a07afe4a466 Yong Zhi 2017-11-08  1003  	media_pipeline_stop(&q->vdev.entity);
c2a6a07afe4a466 Yong Zhi 2017-11-08  1004  fail_pipeline:
c2a6a07afe4a466 Yong Zhi 2017-11-08  1005  	dev_dbg(&cio2->pci_dev->dev, "failed to start streaming (%d)\n", r);
dcd80955a0a13d6 Yong Zhi 2018-01-03  1006  	cio2_vb2_return_all_buffers(q, VB2_BUF_STATE_QUEUED);
c2a6a07afe4a466 Yong Zhi 2017-11-08  1007  	pm_runtime_put(&cio2->pci_dev->dev);
c2a6a07afe4a466 Yong Zhi 2017-11-08  1008  
c2a6a07afe4a466 Yong Zhi 2017-11-08  1009  	return r;
c2a6a07afe4a466 Yong Zhi 2017-11-08  1010  }
c2a6a07afe4a466 Yong Zhi 2017-11-08  1011  

:::::: The code at line 983 was first introduced by commit
:::::: c2a6a07afe4a466896c250cbb203657162b86f4b media: intel-ipu3: cio2: add new MIPI-CSI2 driver

:::::: TO: Yong Zhi <yong.zhi@intel.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
