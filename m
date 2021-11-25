Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385A245D9F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbhKYMZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:25:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:32529 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348004AbhKYMX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:23:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="259402773"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="259402773"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 04:18:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="498067824"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Nov 2021 04:18:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqDhy-0006KK-Qz; Thu, 25 Nov 2021 12:18:34 +0000
Date:   Thu, 25 Nov 2021 20:18:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: esp_scsi.c:undefined reference to `scsi_done'
Message-ID: <202111252028.JcclVVMH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f53fa508db098c9d372423a6dac31c8a5679cdf
commit: f8ab27d9649440a4fa6e77bbea939a62fd44df27 scsi: esp_scsi: Call scsi_done() directly
date:   6 weeks ago
config: mips-buildonly-randconfig-r002-20211124 (https://download.01.org/0day-ci/archive/20211125/202111252028.JcclVVMH-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f8ab27d9649440a4fa6e77bbea939a62fd44df27
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f8ab27d9649440a4fa6e77bbea939a62fd44df27
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_setsync':
   esp_scsi.c:(.text+0xc04): undefined reference to `spi_display_xfer_agreement'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `scsi_esp_register':
   (.text+0xdec): undefined reference to `scsi_add_host_with_dma'
   mips64-linux-ld: (.text+0xe0c): undefined reference to `scsi_scan_host'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `scsi_esp_unregister':
   (.text+0xf70): undefined reference to `scsi_remove_host'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_set_offset':
   esp_scsi.c:(.text+0xfa8): undefined reference to `scsi_is_host_device'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_slave_configure':
   esp_scsi.c:(.text+0x10bc): undefined reference to `scsi_change_queue_depth'
   mips64-linux-ld: esp_scsi.c:(.text+0x10e8): undefined reference to `spi_dv_device'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_data_bytes_sent':
   esp_scsi.c:(.text+0x15b4): undefined reference to `scsi_kmap_atomic_sg'
   mips64-linux-ld: esp_scsi.c:(.text+0x15cc): undefined reference to `scsi_kunmap_atomic_sg'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_target_destroy':
   esp_scsi.c:(.text+0x1700): undefined reference to `scsi_is_host_device'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_target_alloc':
   esp_scsi.c:(.text+0x1768): undefined reference to `scsi_is_host_device'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_set_period':
   esp_scsi.c:(.text+0x17d8): undefined reference to `scsi_is_host_device'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_set_width':
   esp_scsi.c:(.text+0x1850): undefined reference to `scsi_is_host_device'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_reset_cleanup':
>> esp_scsi.c:(.text+0x192c): undefined reference to `scsi_done'
>> mips64-linux-ld: esp_scsi.c:(.text+0x19d4): undefined reference to `scsi_done'
>> mips64-linux-ld: esp_scsi.c:(.text+0x1ac0): undefined reference to `scsi_dma_unmap'
   mips64-linux-ld: esp_scsi.c:(.text+0x1b2c): undefined reference to `__starget_for_each_device'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_eh_abort_handler':
   esp_scsi.c:(.text+0x1d3c): undefined reference to `scsi_done'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_maybe_execute_command.part.0':
   esp_scsi.c:(.text+0x2108): undefined reference to `spi_populate_tag_msg'
   mips64-linux-ld: esp_scsi.c:(.text+0x2350): undefined reference to `scsi_dma_map'
   mips64-linux-ld: esp_scsi.c:(.text+0x2488): undefined reference to `spi_populate_sync_msg'
   mips64-linux-ld: esp_scsi.c:(.text+0x2798): undefined reference to `spi_populate_width_msg'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_cmd_is_done':
   esp_scsi.c:(.text+0x2890): undefined reference to `scsi_done'
   mips64-linux-ld: esp_scsi.c:(.text+0x2960): undefined reference to `scsi_dma_unmap'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_msgin_extended':
   esp_scsi.c:(.text+0x2c80): undefined reference to `spi_populate_sync_msg'
   mips64-linux-ld: esp_scsi.c:(.text+0x2e10): undefined reference to `spi_populate_sync_msg'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_reconnect':
   esp_scsi.c:(.text+0x3010): undefined reference to `__scsi_device_lookup_by_target'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_finish_select':
   esp_scsi.c:(.text+0x3470): undefined reference to `scsi_dma_unmap'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_msgin_process':
   esp_scsi.c:(.text+0x3704): undefined reference to `spi_populate_sync_msg'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_process_event':
   esp_scsi.c:(.text+0x3f08): undefined reference to `scsi_track_queue_full'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_exit':
   esp_scsi.c:(.exit.text+0x4): undefined reference to `spi_release_transport'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_init':
   esp_scsi.c:(.init.text+0xc): undefined reference to `spi_attach_transport'
   mips64-linux-ld: drivers/scsi/jazz_esp.o: in function `esp_jazz_remove':
   jazz_esp.c:(.text+0x98): undefined reference to `scsi_host_put'
   mips64-linux-ld: drivers/scsi/jazz_esp.o: in function `esp_jazz_probe':
   jazz_esp.c:(.text+0x1e4): undefined reference to `scsi_host_alloc'
   mips64-linux-ld: jazz_esp.c:(.text+0x338): undefined reference to `scsi_host_put'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
