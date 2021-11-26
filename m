Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D717545E7D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 07:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352638AbhKZG3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 01:29:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:25879 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352642AbhKZG1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 01:27:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="299021880"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="299021880"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:24:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="607752896"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2021 22:24:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqUed-0007ez-P8; Fri, 26 Nov 2021 06:24:15 +0000
Date:   Fri, 26 Nov 2021 14:23:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:auth.v5 10/12]
 drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse: sparse: invalid
 assignment: |=
Message-ID: <202111261417.8ZOl2MI8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git auth.v5
head:   1d58df043579d325e3c2a5926a89282183393f49
commit: ef0f97eadc213836b338300792fea952d14e1240 [10/12] nvmet: Implement basic In-Band Authentication
config: nios2-randconfig-s031-20211115 (https://download.01.org/0day-ci/archive/20211126/202111261417.8ZOl2MI8-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=ef0f97eadc213836b338300792fea952d14e1240
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel auth.v5
        git checkout ef0f97eadc213836b338300792fea952d14e1240
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse: sparse: invalid assignment: |=
>> drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse:    left side has type restricted __le32
>> drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse:    right side has type int
>> drivers/nvme/target/fabrics-cmd-auth.c:85:22: sparse: sparse: cast to restricted __le32
>> drivers/nvme/target/fabrics-cmd-auth.c:85:22: sparse: sparse: cast from restricted __le16

vim +20 drivers/nvme/target/fabrics-cmd-auth.c

    14	
    15	void nvmet_init_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
    16	{
    17		/* Initialize in-band authentication */
    18		req->sq->authenticated = false;
    19		req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
  > 20		req->cqe->result.u32 |= 0x2 << 16;
    21	}
    22	
    23	static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
    24	{
    25		struct nvmet_ctrl *ctrl = req->sq->ctrl;
    26		struct nvmf_auth_dhchap_negotiate_data *data = d;
    27		int i, hash_id, dhgid;
    28	
    29		pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d authid %d halen %d dhlen %d\n",
    30			 __func__, ctrl->cntlid, req->sq->qid,
    31			 data->sc_c, data->napd, data->auth_protocol[0].dhchap.authid,
    32			 data->auth_protocol[0].dhchap.halen,
    33			 data->auth_protocol[0].dhchap.dhlen);
    34		req->sq->dhchap_tid = le16_to_cpu(data->t_id);
    35		if (data->sc_c)
    36			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
    37	
    38		if (data->napd != 1)
    39			return NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
    40	
    41		if (data->auth_protocol[0].dhchap.authid !=
    42		    NVME_AUTH_DHCHAP_AUTH_ID)
    43			return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
    44	
    45		hash_id = 0;
    46		for (i = 0; i < data->auth_protocol[0].dhchap.halen; i++) {
    47			if (ctrl->shash_id != data->auth_protocol[0].dhchap.idlist[i])
    48				continue;
    49			hash_id = ctrl->shash_id;
    50			break;
    51		}
    52		if (hash_id == 0) {
    53			pr_debug("%s: ctrl %d qid %d: no usable hash found\n",
    54				 __func__, ctrl->cntlid, req->sq->qid);
    55			return NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
    56		}
    57	
    58		dhgid = -1;
    59		for (i = data->auth_protocol[0].dhchap.halen;
    60		     i < data->auth_protocol[0].dhchap.halen +
    61			     data->auth_protocol[0].dhchap.dhlen; i++) {
    62			int tmp_dhgid = data->auth_protocol[0].dhchap.idlist[i];
    63	
    64			if (tmp_dhgid == NVME_AUTH_DHCHAP_DHGROUP_NULL) {
    65				dhgid = tmp_dhgid;
    66				break;
    67			}
    68		}
    69		if (dhgid < 0) {
    70			pr_debug("%s: ctrl %d qid %d: no DH group selected\n",
    71				 __func__, ctrl->cntlid, req->sq->qid);
    72			return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
    73		}
    74		ctrl->dh_gid = dhgid;
    75		pr_debug("%s: ctrl %d qid %d: selected DH group %s (%d)\n",
    76			 __func__, ctrl->cntlid, req->sq->qid,
    77			 nvme_auth_dhgroup_name(ctrl->dh_gid), ctrl->dh_gid);
    78		return 0;
    79	}
    80	
    81	static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
    82	{
    83		struct nvmet_ctrl *ctrl = req->sq->ctrl;
    84		struct nvmf_auth_dhchap_reply_data *data = d;
  > 85		u32 dhvlen = le32_to_cpu(data->dhvlen);
    86		u8 *response;
    87	
    88		pr_debug("%s: ctrl %d qid %d: data hl %d cvalid %d dhvlen %d\n",
    89			 __func__, ctrl->cntlid, req->sq->qid,
    90			 data->hl, data->cvalid, dhvlen);
    91	
    92		if (dhvlen) {
    93			return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
    94		}
    95	
    96		response = kmalloc(data->hl, GFP_KERNEL);
    97		if (!response)
    98			return NVME_AUTH_DHCHAP_FAILURE_FAILED;
    99	
   100		if (!ctrl->dhchap_key || !ctrl->dhchap_key_len) {
   101			pr_warn("ctrl %d qid %d no key\n",
   102				ctrl->cntlid, req->sq->qid);
   103			kfree(response);
   104			return NVME_AUTH_DHCHAP_FAILURE_FAILED;
   105		}
   106		if (nvmet_auth_host_hash(req, response, data->hl) < 0) {
   107			pr_debug("ctrl %d qid %d host hash failed\n",
   108				 ctrl->cntlid, req->sq->qid);
   109			kfree(response);
   110			return NVME_AUTH_DHCHAP_FAILURE_FAILED;
   111		}
   112	
   113		if (memcmp(data->rval, response, data->hl)) {
   114			pr_info("ctrl %d qid %d host response mismatch\n",
   115				ctrl->cntlid, req->sq->qid);
   116			kfree(response);
   117			return NVME_AUTH_DHCHAP_FAILURE_FAILED;
   118		}
   119		kfree(response);
   120		pr_debug("%s: ctrl %d qid %d host authenticated\n",
   121			 __func__, ctrl->cntlid, req->sq->qid);
   122		if (data->cvalid) {
   123			req->sq->dhchap_c2 = kmalloc(data->hl, GFP_KERNEL);
   124			if (!req->sq->dhchap_c2)
   125				return NVME_AUTH_DHCHAP_FAILURE_FAILED;
   126			memcpy(req->sq->dhchap_c2, data->rval + data->hl, data->hl);
   127	
   128			pr_debug("%s: ctrl %d qid %d challenge %*ph\n",
   129				 __func__, ctrl->cntlid, req->sq->qid, data->hl,
   130				 req->sq->dhchap_c2);
   131			req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
   132		} else
   133			req->sq->dhchap_c2 = NULL;
   134	
   135		return 0;
   136	}
   137	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
