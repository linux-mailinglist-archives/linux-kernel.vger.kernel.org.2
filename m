Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD645E0AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 19:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350339AbhKYSuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:50:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:5110 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241847AbhKYSsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:48:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235795590"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235795590"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 10:44:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="607638730"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2021 10:44:48 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqJjj-0006nd-DG; Thu, 25 Nov 2021 18:44:47 +0000
Date:   Fri, 26 Nov 2021 02:44:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:reserved-tags.v9 16/16]
 drivers/scsi/aacraid/linit.c:705:25: error: no member named 'request' in
 'struct scsi_cmnd'
Message-ID: <202111260218.7VLnGxAO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git reserved-tags.v9
head:   b734f6a1dc097d72408e753b7d7022516d7174f4
commit: b734f6a1dc097d72408e753b7d7022516d7174f4 [16/16] aacraid: use scsi_host_busy_iter() to traverse outstanding commands
config: riscv-buildonly-randconfig-r002-20211125 (https://download.01.org/0day-ci/archive/20211126/202111260218.7VLnGxAO-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 0332d105b9ad7f1f0ffca7e78b71de8b3a48f158)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=b734f6a1dc097d72408e753b7d7022516d7174f4
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel reserved-tags.v9
        git checkout b734f6a1dc097d72408e753b7d7022516d7174f4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/scsi/aacraid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/scsi/aacraid/linit.c:705:25: error: no member named 'request' in 'struct scsi_cmnd'
                   fib = &aac->fibs[cmd->request->tag];
                                    ~~~  ^
   drivers/scsi/aacraid/linit.c:772:26: error: no member named 'request' in 'struct scsi_cmnd'
                           fib = &aac->fibs[cmd->request->tag];
                                            ~~~  ^
   drivers/scsi/aacraid/linit.c:786:26: error: no member named 'request' in 'struct scsi_cmnd'
                           fib = &aac->fibs[cmd->request->tag];
                                            ~~~  ^
   drivers/scsi/aacraid/linit.c:1006:36: error: no member named 'request' in 'struct scsi_cmnd'
           struct fib *fib = &aac->fibs[cmd->request->tag];
                                        ~~~  ^
   4 errors generated.
--
>> drivers/scsi/aacraid/commsup.c:1473:40: error: no member named 'request' in 'struct scsi_cmnd'
           struct fib *fib = &aac->fibs[command->request->tag];
                                        ~~~~~~~  ^
   1 error generated.


vim +705 drivers/scsi/aacraid/linit.c

   680	
   681	static int aac_eh_abort(struct scsi_cmnd* cmd)
   682	{
   683		struct scsi_device * dev = cmd->device;
   684		struct Scsi_Host * host = dev->host;
   685		struct aac_dev * aac = (struct aac_dev *)host->hostdata;
   686		struct fib *fib;
   687		int count;
   688		u32 bus, cid;
   689		int ret = FAILED;
   690	
   691		if (aac_adapter_check_health(aac))
   692			return ret;
   693	
   694		bus = aac_logical_to_phys(scmd_channel(cmd));
   695		cid = scmd_id(cmd);
   696		if (aac->hba_map[bus][cid].devtype == AAC_DEVTYPE_NATIVE_RAW) {
   697			struct aac_hba_tm_req *tmf;
   698			int status;
   699			u64 address;
   700	
   701			pr_err("%s: Host adapter abort request (%d,%d,%d,%d)\n",
   702			       AAC_DRIVERNAME, host->host_no,
   703			       sdev_channel(dev), sdev_id(dev), (int)dev->lun);
   704	
 > 705			fib = &aac->fibs[cmd->request->tag];
   706			if (*(u8 *)fib->hw_fib_va != 0 &&
   707			    (fib->flags & FIB_CONTEXT_FLAG_NATIVE_HBA) &&
   708			    (fib->callback_data == cmd))
   709				ret = SUCCESS;
   710			if (ret == FAILED)
   711				return ret;
   712	
   713			/* start a HBA_TMF_ABORT_TASK TMF request */
   714			fib = aac_fib_alloc(aac, DMA_NONE);
   715			if (!fib)
   716				return ret;
   717	
   718			tmf = (struct aac_hba_tm_req *)fib->hw_fib_va;
   719			memset(tmf, 0, sizeof(*tmf));
   720			tmf->tmf = HBA_TMF_ABORT_TASK;
   721			tmf->it_nexus = aac->hba_map[bus][cid].rmw_nexus;
   722			tmf->lun[1] = cmd->device->lun;
   723	
   724			address = (u64)fib->hw_error_pa;
   725			tmf->error_ptr_hi = cpu_to_le32((u32)(address >> 32));
   726			tmf->error_ptr_lo = cpu_to_le32((u32)(address & 0xffffffff));
   727			tmf->error_length = cpu_to_le32(FW_ERROR_BUFFER_SIZE);
   728	
   729			fib->hbacmd_size = sizeof(*tmf);
   730			cmd->SCp.sent_command = 0;
   731	
   732			status = aac_hba_send(HBA_IU_TYPE_SCSI_TM_REQ, fib,
   733					  (fib_callback) aac_hba_callback,
   734					  (void *) cmd);
   735			if (status != -EINPROGRESS) {
   736				aac_fib_complete(fib);
   737				aac_fib_free(fib);
   738				return ret;
   739			}
   740			/* Wait up to 15 secs for completion */
   741			for (count = 0; count < 15; ++count) {
   742				if (cmd->SCp.sent_command) {
   743					ret = SUCCESS;
   744					break;
   745				}
   746				msleep(1000);
   747			}
   748	
   749			if (ret != SUCCESS)
   750				pr_err("%s: Host adapter abort request timed out\n",
   751				AAC_DRIVERNAME);
   752		} else {
   753			pr_err(
   754				"%s: Host adapter abort request.\n"
   755				"%s: Outstanding commands on (%d,%d,%d,%d):\n",
   756				AAC_DRIVERNAME, AAC_DRIVERNAME,
   757				host->host_no, sdev_channel(dev), sdev_id(dev),
   758				(int)dev->lun);
   759			switch (cmd->cmnd[0]) {
   760			case SERVICE_ACTION_IN_16:
   761				if (!(aac->raw_io_interface) ||
   762				    !(aac->raw_io_64) ||
   763				    ((cmd->cmnd[1] & 0x1f) != SAI_READ_CAPACITY_16))
   764					break;
   765				fallthrough;
   766			case INQUIRY:
   767			case READ_CAPACITY:
   768				/*
   769				 * Mark associated FIB to not complete,
   770				 * eh handler does this
   771				 */
   772				fib = &aac->fibs[cmd->request->tag];
   773				if (fib->hw_fib_va->header.XferState &&
   774				    (fib->flags & FIB_CONTEXT_FLAG) &&
   775				    (fib->callback_data == cmd)) {
   776					fib->flags |= FIB_CONTEXT_FLAG_TIMED_OUT;
   777					cmd->SCp.phase = AAC_OWNER_ERROR_HANDLER;
   778					ret = SUCCESS;
   779				}
   780				break;
   781			case TEST_UNIT_READY:
   782				/*
   783				 * Mark associated FIB to not complete,
   784				 * eh handler does this
   785				 */
   786				fib = &aac->fibs[cmd->request->tag];
   787				if ((fib->hw_fib_va->header.XferState &
   788				     cpu_to_le32(Async | NoResponseExpected)) &&
   789				    (fib->flags & FIB_CONTEXT_FLAG) &&
   790				    (fib->callback_data == cmd)) {
   791					fib->flags |= FIB_CONTEXT_FLAG_TIMED_OUT;
   792					cmd->SCp.phase = AAC_OWNER_ERROR_HANDLER;
   793					ret = SUCCESS;
   794				}
   795				break;
   796			}
   797		}
   798		return ret;
   799	}
   800	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
