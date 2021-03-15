Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E3333BEE1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhCOOup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:50:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:43125 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234886AbhCOO3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:29:45 -0400
IronPort-SDR: nZIlsPNLHPbi83YtVp8DjK666m8ZYxZUyItI54WlIZAWsQty2buCViIClQ0So3XE+dzkInO4RD
 JjnVP+MTK8NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="250460891"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="gz'50?scan'50,208,50";a="250460891"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 07:29:42 -0700
IronPort-SDR: B3AUnME0YWSc3cMBmQFTqrCsrO/RkCefquWKUC7V8yp1hgqO4TcLvGnm84/NO2F0WaGYAeuiXs
 +HwYTo+x3M2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="gz'50?scan'50,208,50";a="378526193"
Received: from lkp-server02.sh.intel.com (HELO 1dc5e1a854f4) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Mar 2021 07:29:38 -0700
Received: from kbuild by 1dc5e1a854f4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lLoDy-0000Wo-0d; Mon, 15 Mar 2021 14:29:38 +0000
Date:   Mon, 15 Mar 2021 22:28:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: drivers/scsi/qedi/qedi_fw.c:1064:45: sparse: sparse: incorrect type
 in assignment (different base types)
Message-ID: <202103152249.rp1kOBrJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1e28eed17697bcf343c6743f0028cc3b5dd88bf0
commit: 06e85c7e9a1c1356038936566fc23f7c0d363b96 asm-generic: fix unistd_32.h generation format
date:   11 months ago
config: xtensa-randconfig-s031-20210315 (attached as .config)
compiler: xtensa-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-277-gc089cd2d-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=06e85c7e9a1c1356038936566fc23f7c0d363b96
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 06e85c7e9a1c1356038936566fc23f7c0d363b96
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=xtensa 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/scsi/qedi/qedi_fw.c:284:35: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:287:37: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:324:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] idx @@     got restricted __le16 [usertype] rqe_opaque @@
   drivers/scsi/qedi/qedi_fw.c:324:13: sparse:     expected unsigned short [usertype] idx
   drivers/scsi/qedi/qedi_fw.c:324:13: sparse:     got restricted __le16 [usertype] rqe_opaque
   drivers/scsi/qedi/qedi_fw.c:360:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] idx @@     got restricted __le16 [usertype] rqe_opaque @@
   drivers/scsi/qedi/qedi_fw.c:360:13: sparse:     expected unsigned short [usertype] idx
   drivers/scsi/qedi/qedi_fw.c:360:13: sparse:     got restricted __le16 [usertype] rqe_opaque
   drivers/scsi/qedi/qedi_fw.c:378:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] opaque @@     got restricted __le32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:378:41: sparse:     expected restricted __le16 [usertype] opaque
   drivers/scsi/qedi/qedi_fw.c:378:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:421:29: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:428:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:429:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:430:23: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:431:20: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:447:28: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:492:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:508:18: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:508:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:508:16: sparse:     expected unsigned int
   drivers/scsi/qedi/qedi_fw.c:508:16: sparse:     got restricted __be32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:509:18: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:509:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:509:16: sparse:     expected unsigned int
   drivers/scsi/qedi/qedi_fw.c:509:16: sparse:     got restricted __be32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:511:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:512:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:513:28: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:518:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:519:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:520:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:543:29: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:558:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:558:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:558:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:560:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:561:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:562:23: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:585:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] iscsi_cid @@     got restricted __le16 [usertype] conn_id @@
   drivers/scsi/qedi/qedi_fw.c:585:20: sparse:     expected unsigned int [usertype] iscsi_cid
   drivers/scsi/qedi/qedi_fw.c:585:20: sparse:     got restricted __le16 [usertype] conn_id
   drivers/scsi/qedi/qedi_fw.c:625:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:626:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:627:20: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:631:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:634:38: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:739:28: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] proto_itt @@     got restricted __le16 [usertype] itid @@
   drivers/scsi/qedi/qedi_fw.c:739:28: sparse:     expected unsigned int [usertype] proto_itt
   drivers/scsi/qedi/qedi_fw.c:739:28: sparse:     got restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:751:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] iscsi_cid @@     got restricted __le16 [usertype] conn_id @@
   drivers/scsi/qedi/qedi_fw.c:751:19: sparse:     expected unsigned int [usertype] iscsi_cid
   drivers/scsi/qedi/qedi_fw.c:751:19: sparse:     got restricted __le16 [usertype] conn_id
   drivers/scsi/qedi/qedi_fw.c:809:25: sparse: sparse: cast to restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:828:45: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] tid @@     got restricted __le16 [usertype] itid @@
   drivers/scsi/qedi/qedi_fw.c:828:45: sparse:     expected unsigned int [usertype] tid
   drivers/scsi/qedi/qedi_fw.c:828:45: sparse:     got restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:849:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int idx @@     got restricted __le16 [usertype] itid @@
   drivers/scsi/qedi/qedi_fw.c:849:57: sparse:     expected int idx
   drivers/scsi/qedi/qedi_fw.c:849:57: sparse:     got restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:852:45: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] tid @@     got restricted __le16 [usertype] itid @@
   drivers/scsi/qedi/qedi_fw.c:852:45: sparse:     expected unsigned int [usertype] tid
   drivers/scsi/qedi/qedi_fw.c:852:45: sparse:     got restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:890:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] iscsi_cid @@     got restricted __le16 [usertype] conn_id @@
   drivers/scsi/qedi/qedi_fw.c:890:20: sparse:     expected unsigned int [usertype] iscsi_cid
   drivers/scsi/qedi/qedi_fw.c:890:20: sparse:     got restricted __le16 [usertype] conn_id
   drivers/scsi/qedi/qedi_fw.c:921:50: sparse: sparse: cast from restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:921:40: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:926:48: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:925:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] itid @@     got unsigned int @@
   drivers/scsi/qedi/qedi_fw.c:925:49: sparse:     expected restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:925:49: sparse:     got unsigned int
   drivers/scsi/qedi/qedi_fw.c:975:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] sq_prod @@     got unsigned short [usertype] fw_sq_prod_idx @@
   drivers/scsi/qedi/qedi_fw.c:975:23: sparse:     expected restricted __le16 [assigned] [usertype] sq_prod
   drivers/scsi/qedi/qedi_fw.c:975:23: sparse:     got unsigned short [usertype] fw_sq_prod_idx
   drivers/scsi/qedi/qedi_fw.c:1048:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] isid_tabc @@     got unsigned int @@
   drivers/scsi/qedi/qedi_fw.c:1048:40: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] isid_tabc
   drivers/scsi/qedi/qedi_fw.c:1048:40: sparse:     got unsigned int
   drivers/scsi/qedi/qedi_fw.c:1049:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] isid_d @@     got unsigned short @@
   drivers/scsi/qedi/qedi_fw.c:1049:37: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] isid_d
   drivers/scsi/qedi/qedi_fw.c:1049:37: sparse:     got unsigned short
   drivers/scsi/qedi/qedi_fw.c:1051:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] tsih @@     got restricted __be16 [usertype] tsih @@
   drivers/scsi/qedi/qedi_fw.c:1051:35: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] tsih
   drivers/scsi/qedi/qedi_fw.c:1051:35: sparse:     got restricted __be16 [usertype] tsih
   drivers/scsi/qedi/qedi_fw.c:1052:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hdr_second_dword @@     got int @@
   drivers/scsi/qedi/qedi_fw.c:1052:47: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hdr_second_dword
   drivers/scsi/qedi/qedi_fw.c:1052:47: sparse:     got int
   drivers/scsi/qedi/qedi_fw.c:1055:36: sparse: sparse: cast to restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:1055:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] itt @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1055:34: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] itt
   drivers/scsi/qedi/qedi_fw.c:1055:34: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1056:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] cid @@     got unsigned int [usertype] iscsi_conn_id @@
   drivers/scsi/qedi/qedi_fw.c:1056:34: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] cid
   drivers/scsi/qedi/qedi_fw.c:1056:34: sparse:     got unsigned int [usertype] iscsi_conn_id
   drivers/scsi/qedi/qedi_fw.c:1057:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] cmd_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1057:37: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] cmd_sn
   drivers/scsi/qedi/qedi_fw.c:1057:37: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1058:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] exp_stat_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1058:42: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] exp_stat_sn
   drivers/scsi/qedi/qedi_fw.c:1058:42: sparse:     got unsigned int [usertype]
>> drivers/scsi/qedi/qedi_fw.c:1064:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] lo @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1064:45: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] lo
   drivers/scsi/qedi/qedi_fw.c:1064:45: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1066:45: sparse: sparse: too many warnings

vim +1064 drivers/scsi/qedi/qedi_fw.c

be086e7c53f1fa Mintz, Yuval     2017-03-11  1005  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1006  int qedi_send_iscsi_login(struct qedi_conn *qedi_conn,
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1007  			  struct iscsi_task *task)
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1008  {
be086e7c53f1fa Mintz, Yuval     2017-03-11  1009  	struct iscsi_login_req_hdr login_req_pdu_header;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1010  	struct scsi_sgl_task_params tx_sgl_task_params;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1011  	struct scsi_sgl_task_params rx_sgl_task_params;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1012  	struct iscsi_task_params task_params;
21dd79e82f00b2 Tomer Tayar      2017-12-27  1013  	struct e4_iscsi_task_context *fw_task_ctx;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1014  	struct qedi_ctx *qedi = qedi_conn->qedi;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1015  	struct iscsi_login_req *login_hdr;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1016  	struct scsi_sge *resp_sge = NULL;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1017  	struct qedi_cmd *qedi_cmd;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1018  	struct qedi_endpoint *ep;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1019  	s16 tid = 0;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1020  	u16 sq_idx = 0;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1021  	int rval = 0;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1022  
be086e7c53f1fa Mintz, Yuval     2017-03-11  1023  	resp_sge = (struct scsi_sge *)qedi_conn->gen_pdu.resp_bd_tbl;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1024  	qedi_cmd = (struct qedi_cmd *)task->dd_data;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1025  	ep = qedi_conn->ep;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1026  	login_hdr = (struct iscsi_login_req *)task->hdr;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1027  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1028  	tid = qedi_get_task_idx(qedi);
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1029  	if (tid == -1)
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1030  		return -ENOMEM;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1031  
be086e7c53f1fa Mintz, Yuval     2017-03-11  1032  	fw_task_ctx =
21dd79e82f00b2 Tomer Tayar      2017-12-27  1033  	     (struct e4_iscsi_task_context *)qedi_get_task_mem(&qedi->tasks,
21dd79e82f00b2 Tomer Tayar      2017-12-27  1034  							       tid);
21dd79e82f00b2 Tomer Tayar      2017-12-27  1035  	memset(fw_task_ctx, 0, sizeof(struct e4_iscsi_task_context));
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1036  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1037  	qedi_cmd->task_id = tid;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1038  
be086e7c53f1fa Mintz, Yuval     2017-03-11  1039  	memset(&task_params, 0, sizeof(task_params));
be086e7c53f1fa Mintz, Yuval     2017-03-11  1040  	memset(&login_req_pdu_header, 0, sizeof(login_req_pdu_header));
be086e7c53f1fa Mintz, Yuval     2017-03-11  1041  	memset(&tx_sgl_task_params, 0, sizeof(tx_sgl_task_params));
be086e7c53f1fa Mintz, Yuval     2017-03-11  1042  	memset(&rx_sgl_task_params, 0, sizeof(rx_sgl_task_params));
be086e7c53f1fa Mintz, Yuval     2017-03-11  1043  	/* Update header info */
be086e7c53f1fa Mintz, Yuval     2017-03-11  1044  	login_req_pdu_header.opcode = login_hdr->opcode;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1045  	login_req_pdu_header.version_min = login_hdr->min_version;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1046  	login_req_pdu_header.version_max = login_hdr->max_version;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1047  	login_req_pdu_header.flags_attr = login_hdr->flags;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1048  	login_req_pdu_header.isid_tabc = swab32p((u32 *)login_hdr->isid);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1049  	login_req_pdu_header.isid_d = swab16p((u16 *)&login_hdr->isid[4]);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1050  
be086e7c53f1fa Mintz, Yuval     2017-03-11  1051  	login_req_pdu_header.tsih = login_hdr->tsih;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1052  	login_req_pdu_header.hdr_second_dword = ntoh24(login_hdr->dlength);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1053  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1054  	qedi_update_itt_map(qedi, tid, task->itt, qedi_cmd);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1055  	login_req_pdu_header.itt = qedi_set_itt(tid, get_itt(task->itt));
be086e7c53f1fa Mintz, Yuval     2017-03-11  1056  	login_req_pdu_header.cid = qedi_conn->iscsi_conn_id;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1057  	login_req_pdu_header.cmd_sn = be32_to_cpu(login_hdr->cmdsn);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1058  	login_req_pdu_header.exp_stat_sn = be32_to_cpu(login_hdr->exp_statsn);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1059  	login_req_pdu_header.exp_stat_sn = 0;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1060  
be086e7c53f1fa Mintz, Yuval     2017-03-11  1061  	/* Fill tx AHS and rx buffer */
be086e7c53f1fa Mintz, Yuval     2017-03-11  1062  	tx_sgl_task_params.sgl =
be086e7c53f1fa Mintz, Yuval     2017-03-11  1063  			       (struct scsi_sge *)qedi_conn->gen_pdu.req_bd_tbl;
be086e7c53f1fa Mintz, Yuval     2017-03-11 @1064  	tx_sgl_task_params.sgl_phys_addr.lo =
be086e7c53f1fa Mintz, Yuval     2017-03-11  1065  					 (u32)(qedi_conn->gen_pdu.req_dma_addr);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1066  	tx_sgl_task_params.sgl_phys_addr.hi =
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1067  			      (u32)((u64)qedi_conn->gen_pdu.req_dma_addr >> 32);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1068  	tx_sgl_task_params.total_buffer_size = ntoh24(login_hdr->dlength);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1069  	tx_sgl_task_params.num_sges = 1;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1070  
be086e7c53f1fa Mintz, Yuval     2017-03-11  1071  	rx_sgl_task_params.sgl =
be086e7c53f1fa Mintz, Yuval     2017-03-11  1072  			      (struct scsi_sge *)qedi_conn->gen_pdu.resp_bd_tbl;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1073  	rx_sgl_task_params.sgl_phys_addr.lo =
be086e7c53f1fa Mintz, Yuval     2017-03-11  1074  					(u32)(qedi_conn->gen_pdu.resp_dma_addr);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1075  	rx_sgl_task_params.sgl_phys_addr.hi =
be086e7c53f1fa Mintz, Yuval     2017-03-11  1076  			     (u32)((u64)qedi_conn->gen_pdu.resp_dma_addr >> 32);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1077  	rx_sgl_task_params.total_buffer_size = resp_sge->sge_len;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1078  	rx_sgl_task_params.num_sges = 1;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1079  
be086e7c53f1fa Mintz, Yuval     2017-03-11  1080  	/* Fill fw input params */
be086e7c53f1fa Mintz, Yuval     2017-03-11  1081  	task_params.context = fw_task_ctx;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1082  	task_params.conn_icid = (u16)qedi_conn->iscsi_conn_id;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1083  	task_params.itid = tid;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1084  	task_params.cq_rss_number = 0;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1085  	task_params.tx_io_size = ntoh24(login_hdr->dlength);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1086  	task_params.rx_io_size = resp_sge->sge_len;
be086e7c53f1fa Mintz, Yuval     2017-03-11  1087  
be086e7c53f1fa Mintz, Yuval     2017-03-11  1088  	sq_idx = qedi_get_wqe_idx(qedi_conn);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1089  	task_params.sqe = &ep->sq[sq_idx];
be086e7c53f1fa Mintz, Yuval     2017-03-11  1090  
be086e7c53f1fa Mintz, Yuval     2017-03-11  1091  	memset(task_params.sqe, 0, sizeof(struct iscsi_wqe));
be086e7c53f1fa Mintz, Yuval     2017-03-11  1092  	rval = init_initiator_login_request_task(&task_params,
be086e7c53f1fa Mintz, Yuval     2017-03-11  1093  						 &login_req_pdu_header,
be086e7c53f1fa Mintz, Yuval     2017-03-11  1094  						 &tx_sgl_task_params,
be086e7c53f1fa Mintz, Yuval     2017-03-11  1095  						 &rx_sgl_task_params);
be086e7c53f1fa Mintz, Yuval     2017-03-11  1096  	if (rval)
be086e7c53f1fa Mintz, Yuval     2017-03-11  1097  		return -1;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1098  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1099  	spin_lock(&qedi_conn->list_lock);
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1100  	list_add_tail(&qedi_cmd->io_cmd, &qedi_conn->active_cmd_list);
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1101  	qedi_cmd->io_cmd_in_list = true;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1102  	qedi_conn->active_cmd_count++;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1103  	spin_unlock(&qedi_conn->list_lock);
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1104  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1105  	qedi_ring_doorbell(qedi_conn);
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1106  	return 0;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1107  }
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1108  

:::::: The code at line 1064 was first introduced by commit
:::::: be086e7c53f1fac51eed14523b28f2214b548dd2 qed*: Utilize Firmware 8.15.3.0

:::::: TO: Mintz, Yuval <Yuval.Mintz@cavium.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--y0ulUmNC+osPPQO6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AQA=

--y0ulUmNC+osPPQO6--
