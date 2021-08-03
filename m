Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C05D3DE441
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 04:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhHCCNh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Aug 2021 22:13:37 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:46138 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbhHCCNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 22:13:35 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 1732CmBU009378; Tue, 3 Aug 2021 11:12:48 +0900
X-Iguazu-Qid: 34trDWJKSrJTx9EzAf
X-Iguazu-QSIG: v=2; s=0; t=1627956767; q=34trDWJKSrJTx9EzAf; m=/EiBB3luwALRn92WAeWiVyD+L6Jq9ovDK3wrrxTHr0g=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
        by relay.securemx.jp (mx-mr1512) id 1732Ckvq024677;
        Tue, 3 Aug 2021 11:12:46 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
        by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id F3DC331B1F;
        Tue,  3 Aug 2021 11:12:45 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
        by Switcher-Post_Send (Postfix) with ESMTP id 621AA190579700;
        Tue,  3 Aug 2021 11:09:32 +0900 (JST)
Received: from localhost [127.0.0.1] 
         by CNN1ESTR04.kioxia.com with ESMTP id 0003MAAAAAA0068A;
         Tue, 3 Aug 2021 11:09:32 +0900
Received: from CNN1EXMB01.r1.kioxia.com (CNN1EXMB01.r1.kioxia.com [10.232.20.150])
        by Switcher-Pre_Send (Postfix) with ESMTP id 57244A009358A;
        Tue,  3 Aug 2021 11:09:32 +0900 (JST)
Received: from CNN1EXMB02.r1.kioxia.com (10.232.20.151) by
 CNN1EXMB01.r1.kioxia.com (10.232.20.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 3 Aug 2021 11:12:45 +0900
Received: from CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) by
 CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) with mapi id 15.01.2242.010; Tue, 3
 Aug 2021 11:12:45 +0900
From:   sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
To:     kernel test robot <lkp@intel.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme: update keep alive interval when kato is modified
Thread-Topic: [PATCH] nvme: update keep alive interval when kato is modified
Thread-Index: AdeHNEBfLn7U7T5+SsyG/rbRVH2ESP//rzwA//3+YZA=
Date:   Tue, 3 Aug 2021 02:12:45 +0000
Message-ID: <1f5231f5d0d14829ae72aa97e5f2487a@kioxia.com>
References: <b7cde4c23c44485198f12739bb8fbca0@kioxia.com>
 <202108021253.QwqCWvYe-lkp@intel.com>
In-Reply-To: <202108021253.QwqCWvYe-lkp@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.211.40.142]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB01.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB01.r1.kioxia.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the connection between host and NVMe-oF target gets
disconnected by keep-alive timeout when a user connects to a target
with a relatively large kato value and then sets the smaller kato
with a set features command (e.g. connects with 60 seconds kato value
and then sets 10 seconds kato value).

The cause is that keep alive command interval on the host, which is
defined as unsigned int kato in nvme_ctrl structure, does not follow
the kato value changes.

This patch updates the keep alive interval in the following steps when
the kato is modified by a set features command: stops the keep alive
work queue, then sets the kato as new timer value and re-start the queue.

Signed-off-by: Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>
---
 drivers/nvme/host/core.c  |  3 ++-
 drivers/nvme/host/ioctl.c | 17 +++++++++++++++++
 drivers/nvme/host/nvme.h  |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfd9dec0c1f6..89c52da15618 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1255,13 +1255,14 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	blk_execute_rq_nowait(NULL, rq, 0, nvme_keep_alive_end_io);
 }
 
-static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
+void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 {
 	if (unlikely(ctrl->kato == 0))
 		return;
 
 	nvme_queue_keep_alive_work(ctrl);
 }
+EXPORT_SYMBOL_GPL(nvme_start_keep_alive);
 
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 305ddd415e45..0066728e77b2 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -231,6 +231,23 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			return -EFAULT;
 	}
 
+	/*
+	 * Keep alive commands interval on the host should be updated
+	 * when KATO is modified by Set Features commands.
+	 */
+	if (!status && cmd.opcode == nvme_admin_set_features &&
+	    (cmd.cdw10 & 0xFF) == NVME_FEAT_KATO) {
+		/* ms -> s */
+		unsigned int new_kato = DIV_ROUND_UP(cmd.cdw11, 1000);
+
+		dev_info(ctrl->device,
+			 "keep alive commands interval on the host is updated from %u milliseconds to %u milliseconds\n",
+			 ctrl->kato * 1000 / 2, new_kato * 1000 / 2);
+		nvme_stop_keep_alive(ctrl);
+		ctrl->kato = new_kato;
+		nvme_start_keep_alive(ctrl);
+	}
+
 	return status;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5cd1fa3b8464..d4066b7c5fc8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -666,6 +666,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
+void nvme_start_keep_alive(struct nvme_ctrl *ctrl);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
-- 
2.25.1

-----Original Message-----
From: kernel test robot <lkp@intel.com> 
Sent: Monday, August 2, 2021 1:32 PM
To: sasaki tatsuya(佐々木 達哉 ＫＩＣ ○Ｓ技Ｃ□ＳＳ開○ＳＳ一) <tatsuya6.sasaki@kioxia.com>; kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
Cc: kbuild-all@lists.01.org
Subject: Re: [PATCH] nvme: update keep alive interval when kato is modified

Hi sasaki,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on block/for-next]
[also build test WARNING on hch-configfs/for-next linus/master v5.14-rc3 next-20210730]
[cannot apply to linux-nvme/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/sasaki-tatsuya/nvme-update-keep-alive-interval-when-kato-is-modified/20210802-090235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-randconfig-s002-20210802 (attached as .config)
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://github.com/0day-ci/linux/commit/eda2903523c28b51997fb071c0ff3653081c8a79
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review sasaki-tatsuya/nvme-update-keep-alive-interval-when-kato-is-modified/20210802-090235
        git checkout eda2903523c28b51997fb071c0ff3653081c8a79
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/ioctl.c:239:15: sparse: sparse: cast from restricted __le32
>> drivers/nvme/host/ioctl.c:241:41: sparse: sparse: restricted __le32 degrades to integer

vim +239 drivers/nvme/host/ioctl.c

   189	
   190	static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
   191				struct nvme_passthru_cmd __user *ucmd)
   192	{
   193		struct nvme_passthru_cmd cmd;
   194		struct nvme_command c;
   195		unsigned timeout = 0;
   196		u64 result;
   197		int status;
   198	
   199		if (!capable(CAP_SYS_ADMIN))
   200			return -EACCES;
   201		if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
   202			return -EFAULT;
   203		if (cmd.flags)
   204			return -EINVAL;
   205		if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
   206			return -EINVAL;
   207	
   208		memset(&c, 0, sizeof(c));
   209		c.common.opcode = cmd.opcode;
   210		c.common.flags = cmd.flags;
   211		c.common.nsid = cpu_to_le32(cmd.nsid);
   212		c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
   213		c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
   214		c.common.cdw10 = cpu_to_le32(cmd.cdw10);
   215		c.common.cdw11 = cpu_to_le32(cmd.cdw11);
   216		c.common.cdw12 = cpu_to_le32(cmd.cdw12);
   217		c.common.cdw13 = cpu_to_le32(cmd.cdw13);
   218		c.common.cdw14 = cpu_to_le32(cmd.cdw14);
   219		c.common.cdw15 = cpu_to_le32(cmd.cdw15);
   220	
   221		if (cmd.timeout_ms)
   222			timeout = msecs_to_jiffies(cmd.timeout_ms);
   223	
   224		status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
   225				nvme_to_user_ptr(cmd.addr), cmd.data_len,
   226				nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
   227				0, &result, timeout);
   228	
   229		if (status >= 0) {
   230			if (put_user(result, &ucmd->result))
   231				return -EFAULT;
   232		}
   233	
   234		/*
   235		 * Keep alive commands interval on the host should be updated
   236		 * when KATO is modified by Set Features commands.
   237		 */
   238		if (!status && c.common.opcode == nvme_admin_set_features &&
 > 239		    ((u8)c.common.cdw10 & 0xFF) == NVME_FEAT_KATO) {
   240			/* ms -> s */
 > 241			unsigned int new_kato = DIV_ROUND_UP(c.common.cdw11, 1000);
   242	
   243			dev_info(ctrl->device,
   244				 "keep alive commands interval on the host is updated from %u milliseconds to %u milliseconds\n",
   245				 ctrl->kato * 1000 / 2, new_kato * 1000 / 2);
   246			nvme_stop_keep_alive(ctrl);
   247			ctrl->kato = new_kato;
   248			nvme_start_keep_alive(ctrl);
   249		}
   250	
   251		return status;
   252	}
   253	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

