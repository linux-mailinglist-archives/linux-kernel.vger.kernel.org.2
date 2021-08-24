Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FD33F5715
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 06:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhHXEOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 00:14:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:16386 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229568AbhHXEOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 00:14:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="214107270"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="gz'50?scan'50,208,50";a="214107270"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 21:13:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="gz'50?scan'50,208,50";a="515267454"
Received: from lkp-server02.sh.intel.com (HELO 181e7be6f509) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2021 21:13:46 -0700
Received: from kbuild by 181e7be6f509 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mINoo-0000IZ-1l; Tue, 24 Aug 2021 04:13:46 +0000
Date:   Tue, 24 Aug 2021 12:13:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: [linux-stable-rc:linux-4.4.y 9951/9999]
 drivers/ata/libata-scsi.c:1662:7: error: implicit declaration of function
 'blk_rq_is_passthrough'
Message-ID: <202108241212.WjGD62D6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
head:   48a16935fdcdb0926ed5e743a9d8d238bbc9c243
commit: 5d784a2d4a0e302f51f6d96f44f5c21de47d6f19 [9951/9999] libata: have ata_scsi_rw_xlat() fail invalid passthrough requests
config: powerpc-buildonly-randconfig-r002-20210822 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=5d784a2d4a0e302f51f6d96f44f5c21de47d6f19
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.4.y
        git checkout 5d784a2d4a0e302f51f6d96f44f5c21de47d6f19
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

     ^~~~~~~~~~~~~~~
   include/linux/blk-mq.h: In function 'blk_mq_rq_from_pdu':
   include/linux/blk-mq.h:247:22: error: invalid application of 'sizeof' to incomplete type 'struct request'
     return pdu - sizeof(struct request);
                         ^~~~~~
   include/linux/blk-mq.h: In function 'blk_mq_rq_to_pdu':
   include/linux/blk-mq.h:251:12: error: invalid use of undefined type 'struct request'
     return rq + 1;
               ^
   In file included from drivers/ata/libata-scsi.c:43:0:
   include/scsi/scsi_cmnd.h: At top level:
   include/scsi/scsi_cmnd.h:30:25: warning: "BLK_MAX_CDB" is not defined, evaluates to 0 [-Wundef]
    #if (MAX_COMMAND_SIZE > BLK_MAX_CDB)
                            ^~~~~~~~~~~
   include/scsi/scsi_cmnd.h:31:3: error: #error MAX_COMMAND_SIZE can not be bigger than BLK_MAX_CDB
    # error MAX_COMMAND_SIZE can not be bigger than BLK_MAX_CDB
      ^~~~~
   include/scsi/scsi_cmnd.h: In function 'scsi_cmd_to_driver':
   include/scsi/scsi_cmnd.h:155:45: error: dereferencing pointer to incomplete type 'struct request'
     return *(struct scsi_driver **)cmd->request->rq_disk->private_data;
                                                ^~
   include/scsi/scsi_cmnd.h: In function 'scsi_bidi_cmnd':
   include/scsi/scsi_cmnd.h:201:9: error: implicit declaration of function 'blk_bidi_rq' [-Werror=implicit-function-declaration]
     return blk_bidi_rq(cmd->request) &&
            ^~~~~~~~~~~
   include/scsi/scsi_cmnd.h: In function 'scsi_get_lba':
   include/scsi/scsi_cmnd.h:294:9: error: implicit declaration of function 'blk_rq_pos' [-Werror=implicit-function-declaration]
     return blk_rq_pos(scmd->request);
            ^~~~~~~~~~
   In file included from drivers/ata/libata-scsi.c:44:0:
   include/scsi/scsi_eh.h: At top level:
   include/scsi/scsi_eh.h:41:24: error: 'BLK_MAX_CDB' undeclared here (not in a function); did you mean 'BLK_MQ_H'?
     unsigned char eh_cmnd[BLK_MAX_CDB];
                           ^~~~~~~~~~~
                           BLK_MQ_H
   In file included from include/linux/libata.h:35:0,
                    from drivers/ata/libata-scsi.c:48:
   include/linux/ata.h: In function 'ata_id_is_lba_capacity_ok':
   include/linux/ata.h:950:17: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
         (lba_sects >= 16383 * 63 * id[ATA_ID_HEADS]))
                    ^~
   In file included from drivers/ata/libata-scsi.c:48:0:
   include/linux/libata.h: In function 'ata_msg_init':
   include/linux/libata.h:112:23: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     if (dval < 0 || dval >= (sizeof(u32) * 8))
                          ^~
   drivers/ata/libata-scsi.c: In function 'ata_scsi_park_store':
   drivers/ata/libata-scsi.c:267:17: warning: signed and unsigned type in conditional expression [-Wsign-compare]
     return rc ? rc : len;
                    ^
   drivers/ata/libata-scsi.c: In function 'ata_sas_scsi_ioctl':
   drivers/ata/libata-scsi.c:699:12: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
       if (val != ata_ioc32(ap))
               ^~
   In file included from include/asm-generic/bug.h:4:0,
                    from arch/powerpc/include/asm/bug.h:127,
                    from include/linux/bug.h:4,
                    from include/linux/mmdebug.h:4,
                    from include/linux/gfp.h:4,
                    from include/linux/slab.h:14,
                    from drivers/ata/libata-scsi.c:36:
   drivers/ata/libata-scsi.c: In function 'atapi_drain_needed':
   drivers/ata/libata-scsi.c:1124:29: error: 'REQ_TYPE_BLOCK_PC' undeclared (first use in this function)
     if (likely(rq->cmd_type != REQ_TYPE_BLOCK_PC))
                                ^
   include/linux/compiler.h:181:40: note: in definition of macro 'likely'
    # define likely(x) __builtin_expect(!!(x), 1)
                                           ^
   drivers/ata/libata-scsi.c:1124:29: note: each undeclared identifier is reported only once for each function it appears in
     if (likely(rq->cmd_type != REQ_TYPE_BLOCK_PC))
                                ^
   include/linux/compiler.h:181:40: note: in definition of macro 'likely'
    # define likely(x) __builtin_expect(!!(x), 1)
                                           ^
   drivers/ata/libata-scsi.c:1127:7: error: implicit declaration of function 'blk_rq_bytes'; did you mean 'clear_bits'? [-Werror=implicit-function-declaration]
     if (!blk_rq_bytes(rq) || (rq->cmd_flags & REQ_WRITE))
          ^~~~~~~~~~~~
          clear_bits
   drivers/ata/libata-scsi.c: In function 'ata_scsi_dev_config':
   drivers/ata/libata-scsi.c:1142:2: error: implicit declaration of function 'blk_queue_max_hw_sectors' [-Werror=implicit-function-declaration]
     blk_queue_max_hw_sectors(q, dev->max_sectors);
     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/libata-scsi.c:1150:3: error: implicit declaration of function 'blk_queue_update_dma_pad' [-Werror=implicit-function-declaration]
      blk_queue_update_dma_pad(q, ATA_DMA_PAD_SZ - 1);
      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/libata-scsi.c:1153:35: error: dereferencing pointer to incomplete type 'struct request_queue'
      buf = kmalloc(ATAPI_MAX_DRAIN, q->bounce_gfp | GFP_KERNEL);
                                      ^~
   drivers/ata/libata-scsi.c:1159:3: error: implicit declaration of function 'blk_queue_dma_drain' [-Werror=implicit-function-declaration]
      blk_queue_dma_drain(q, atapi_drain_needed, buf, ATAPI_MAX_DRAIN);
      ^~~~~~~~~~~~~~~~~~~
   drivers/ata/libata-scsi.c:1177:2: error: implicit declaration of function 'blk_queue_update_dma_alignment'; did you mean '__assume_page_alignment'? [-Werror=implicit-function-declaration]
     blk_queue_update_dma_alignment(q, sdev->sector_size - 1);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     __assume_page_alignment
   drivers/ata/libata-scsi.c:1190:2: error: implicit declaration of function 'blk_queue_flush_queueable'; did you mean 'blk_needs_flush_plug'? [-Werror=implicit-function-declaration]
     blk_queue_flush_queueable(q, false);
     ^~~~~~~~~~~~~~~~~~~~~~~~~
     blk_needs_flush_plug
   drivers/ata/libata-scsi.c: In function 'ata_check_nblocks':
>> drivers/ata/libata-scsi.c:1662:7: error: implicit declaration of function 'blk_rq_is_passthrough' [-Werror=implicit-function-declaration]
     if (!blk_rq_is_passthrough(rq))
          ^~~~~~~~~~~~~~~~~~~~~
   drivers/ata/libata-scsi.c: In function 'ata_scsi_mode_select_xlat':
   drivers/ata/libata-scsi.c:3306:56: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     if (!scsi_sg_count(scmd) || scsi_sglist(scmd)->length < len)
                                                           ^
   drivers/ata/libata-scsi.c:3312:10: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     if (len < hdr_len)
             ^
   drivers/ata/libata-scsi.c:3322:10: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     if (len < bd_len)
             ^
   drivers/ata/libata-scsi.c:3358:13: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     if (pg_len > len)
                ^
   drivers/ata/libata-scsi.c:3375:10: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     if (len > pg_len)
             ^
   In file included from include/asm-generic/bug.h:4:0,
                    from arch/powerpc/include/asm/bug.h:127,
                    from include/linux/bug.h:4,
                    from include/linux/mmdebug.h:4,
                    from include/linux/gfp.h:4,
                    from include/linux/slab.h:14,
                    from drivers/ata/libata-scsi.c:36:
   drivers/ata/libata-scsi.c: In function '__ata_scsi_queuecmd':
   drivers/ata/libata-scsi.c:3497:14: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
             len > dev->cdb_len ||
                 ^
   include/linux/compiler.h:182:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
   drivers/ata/libata-scsi.c: In function 'ata_scsi_add_hosts':
   drivers/ata/libata-scsi.c:3695:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     for (i = 0; i < host->n_ports; i++) {
                   ^
   drivers/ata/libata-scsi.c: In function 'ata_scsi_user_scan':
   drivers/ata/libata-scsi.c:4027:10: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     if (lun != SCAN_WILD_CARD && lun)
             ^~
   drivers/ata/libata-scsi.c:4031:15: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
      if (channel != SCAN_WILD_CARD && channel)
                  ^~
   drivers/ata/libata-scsi.c:4035:10: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
      if (id != SCAN_WILD_CARD && id)
             ^~
   drivers/ata/libata-scsi.c: In function 'atapi_drain_needed':
   drivers/ata/libata-scsi.c:1131:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors


vim +/blk_rq_is_passthrough +1662 drivers/ata/libata-scsi.c

  1656	
  1657	static bool ata_check_nblocks(struct scsi_cmnd *scmd, u32 n_blocks)
  1658	{
  1659		struct request *rq = scmd->request;
  1660		u32 req_blocks;
  1661	
> 1662		if (!blk_rq_is_passthrough(rq))
  1663			return true;
  1664	
  1665		req_blocks = blk_rq_bytes(rq) / scmd->device->sector_size;
  1666		if (n_blocks > req_blocks)
  1667			return false;
  1668	
  1669		return true;
  1670	}
  1671	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6TrnltStXW4iwmi0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6TrnltStXW4iwmi0--
