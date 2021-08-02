Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0411C3DCE73
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 03:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhHBBA2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 1 Aug 2021 21:00:28 -0400
Received: from mo-csw-fb1516.securemx.jp ([210.130.202.172]:36866 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhHBBA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 21:00:27 -0400
X-Greylist: delayed 2104 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Aug 2021 21:00:26 EDT
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1516) id 1720PE1X029825; Mon, 2 Aug 2021 09:25:15 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 1720Oenj025785; Mon, 2 Aug 2021 09:24:40 +0900
X-Iguazu-Qid: 34ts0Afxgte1HvvDCT
X-Iguazu-QSIG: v=2; s=0; t=1627863879; q=34ts0Afxgte1HvvDCT; m=Z7EySAtOE1bn94zu5SpC2UkEWj1b/5Yfv0uz/zexrj8=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
        by relay.securemx.jp (mx-mr1513) id 1720ObZc002024;
        Mon, 2 Aug 2021 09:24:37 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
        by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id B8D4931B1E;
        Mon,  2 Aug 2021 09:24:37 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
        by Switcher-Post_Send (Postfix) with ESMTP id 96B4A190467A2F;
        Mon,  2 Aug 2021 09:21:24 +0900 (JST)
Received: from localhost [127.0.0.1] 
         by CNN1ESTR04.kioxia.com with ESMTP id 0003KAAAAAA025KH;
         Mon, 2 Aug 2021 09:21:24 +0900
Received: from CNN1EXMB02.r1.kioxia.com (CNN1EXMB02.r1.kioxia.com [10.232.20.151])
        by Switcher-Pre_Send (Postfix) with ESMTP id 8BCCBA0093D81;
        Mon,  2 Aug 2021 09:21:24 +0900 (JST)
Received: from CNN1EXMB02.r1.kioxia.com (10.232.20.151) by
 CNN1EXMB02.r1.kioxia.com (10.232.20.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 2 Aug 2021 09:24:37 +0900
Received: from CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) by
 CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) with mapi id 15.01.2242.010; Mon, 2
 Aug 2021 09:24:37 +0900
From:   sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme: update keep alive interval when kato is modified
Thread-Topic: [PATCH] nvme: update keep alive interval when kato is modified
Thread-Index: AdeHNEBfLn7U7T5+SsyG/rbRVH2ESA==
Date:   Mon, 2 Aug 2021 00:24:37 +0000
Message-ID: <b7cde4c23c44485198f12739bb8fbca0@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.211.40.97]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB02.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB02.r1.kioxia.com
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
index 66973bb56..3e821a0be 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1242,13 +1242,14 @@ static void nvme_keep_alive_work(struct work_struct *work)
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
index 9557ead02..574f956f0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -225,6 +225,23 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			return -EFAULT;
 	}
 
+	/*
+	 * Keep alive commands interval on the host should be updated
+	 * when KATO is modified by Set Features commands.
+	 */
+	if (!status && c.common.opcode == nvme_admin_set_features &&
+	    ((u8)c.common.cdw10 & 0xFF) == NVME_FEAT_KATO) {
+		/* ms -> s */
+		unsigned int new_kato = DIV_ROUND_UP(c.common.cdw11, 1000);
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
index 0015860ec..150ad6d4d 100644
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


