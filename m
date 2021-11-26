Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0148345E8D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbhKZHvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:51:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:42971 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353099AbhKZHtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:49:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="321858951"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="321858951"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 23:46:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="598369797"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 25 Nov 2021 23:46:19 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqVw2-0007mF-Eb; Fri, 26 Nov 2021 07:46:18 +0000
Date:   Fri, 26 Nov 2021 15:45:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:auth.v5 11/12]
 drivers/nvme/target/fabrics-cmd-auth.c:346:30: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202111261548.YAoOcBe0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git auth.v5
head:   1d58df043579d325e3c2a5926a89282183393f49
commit: 6ca636fe7f5c7c1d040fb4328ef7b47a62165a7e [11/12] nvmet-auth: Diffie-Hellman key exchange support
config: nios2-randconfig-s031-20211115 (https://download.01.org/0day-ci/archive/20211126/202111261548.YAoOcBe0-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=6ca636fe7f5c7c1d040fb4328ef7b47a62165a7e
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel auth.v5
        git checkout 6ca636fe7f5c7c1d040fb4328ef7b47a62165a7e
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse: sparse: invalid assignment: |=
   drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse:    left side has type restricted __le32
   drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse:    right side has type int
   drivers/nvme/target/fabrics-cmd-auth.c:84:22: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/fabrics-cmd-auth.c:84:22: sparse: sparse: cast from restricted __le16
>> drivers/nvme/target/fabrics-cmd-auth.c:346:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] dhvlen @@     got restricted __le32 [usertype] @@
   drivers/nvme/target/fabrics-cmd-auth.c:346:30: sparse:     expected restricted __le16 [usertype] dhvlen
   drivers/nvme/target/fabrics-cmd-auth.c:346:30: sparse:     got restricted __le32 [usertype]

vim +346 drivers/nvme/target/fabrics-cmd-auth.c

   315	
   316	static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
   317	{
   318		struct nvmf_auth_dhchap_challenge_data *data = d;
   319		struct nvmet_ctrl *ctrl = req->sq->ctrl;
   320		int ret = 0;
   321		int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
   322		int data_size = sizeof(*d) + hash_len;
   323	
   324		if (ctrl->dh_tfm)
   325			data_size += ctrl->dh_keysize;
   326		if (al < data_size) {
   327			pr_debug("%s: buffer too small (al %d need %d)\n", __func__,
   328				 al, data_size);
   329			return -EINVAL;
   330		}
   331		memset(data, 0, data_size);
   332		req->sq->dhchap_s1 = ctrl->dhchap_seqnum++;
   333		data->auth_type = NVME_AUTH_DHCHAP_MESSAGES;
   334		data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE;
   335		data->t_id = cpu_to_le16(req->sq->dhchap_tid);
   336		data->hashid = ctrl->shash_id;
   337		data->hl = hash_len;
   338		data->seqnum = cpu_to_le32(req->sq->dhchap_s1);
   339		req->sq->dhchap_c1 = kmalloc(data->hl, GFP_KERNEL);
   340		if (!req->sq->dhchap_c1)
   341			return -ENOMEM;
   342		get_random_bytes(req->sq->dhchap_c1, data->hl);
   343		memcpy(data->cval, req->sq->dhchap_c1, data->hl);
   344		if (ctrl->dh_tfm) {
   345			data->dhgid = ctrl->dh_gid;
 > 346			data->dhvlen = cpu_to_le32(ctrl->dh_keysize);
   347			ret = nvmet_auth_ctrl_exponential(req, data->cval + data->hl,
   348							  ctrl->dh_keysize);
   349		}
   350		pr_debug("%s: ctrl %d qid %d seq %d transaction %d hl %d dhvlen %d\n",
   351			 __func__, ctrl->cntlid, req->sq->qid, req->sq->dhchap_s1,
   352			 req->sq->dhchap_tid, data->hl, ctrl->dh_keysize);
   353		return ret;
   354	}
   355	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
