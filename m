Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46ADA3F57B0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 07:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhHXFqK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Aug 2021 01:46:10 -0400
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:46600 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhHXFqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 01:46:06 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 17O5iuW9005032; Tue, 24 Aug 2021 14:44:56 +0900
X-Iguazu-Qid: 34trwupu8TLDtWTKa6
X-Iguazu-QSIG: v=2; s=0; t=1629783895; q=34trwupu8TLDtWTKa6; m=ei91gsjyzkr8XAHAdBquO4uHuJri38kAXtwFed+DOXU=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
        by relay.securemx.jp (mx-mr1511) id 17O5isgf017318;
        Tue, 24 Aug 2021 14:44:54 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
        by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 9A3A231B1E;
        Tue, 24 Aug 2021 14:44:54 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
        by Switcher-Post_Send (Postfix) with ESMTP id 062A519057971A;
        Tue, 24 Aug 2021 14:41:32 +0900 (JST)
Received: from localhost [127.0.0.1] 
         by CNN1ESTR04.kioxia.com with ESMTP id 0003QAAAAAA01F2G;
         Tue, 24 Aug 2021 14:41:32 +0900
Received: from CNN1EXMB02.r1.kioxia.com (CNN1EXMB02.r1.kioxia.com [10.232.20.151])
        by Switcher-Pre_Send (Postfix) with ESMTP id EF3EBA00617EB;
        Tue, 24 Aug 2021 14:41:31 +0900 (JST)
Received: from CNN1EXMB02.r1.kioxia.com (10.232.20.151) by
 CNN1EXMB02.r1.kioxia.com (10.232.20.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 24 Aug 2021 14:44:53 +0900
Received: from CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) by
 CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) with mapi id 15.01.2242.010; Tue,
 24 Aug 2021 14:44:53 +0900
From:   sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] nvme: update keep alive interval when kato is modified
Thread-Topic: [PATCH v2] nvme: update keep alive interval when kato is
 modified
Thread-Index: AdeYqq0GYCdtylBoR8GOhZA2v9EjoA==
Date:   Tue, 24 Aug 2021 05:44:52 +0000
Message-ID: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.211.40.126]
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
Changes since v1:
- Add nvme_update_keep_alive to update keep alive timer in core routine.
- Add nvme_user_cmd_post to call nvme_update_keep_alive in ioctl.c

 drivers/nvme/host/core.c  | 12 ++++++++++++
 drivers/nvme/host/ioctl.c | 19 +++++++++++++++++++
 drivers/nvme/host/nvme.h  |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfd9dec0c1f6..76f0ee431b11 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1263,6 +1263,18 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 	nvme_queue_keep_alive_work(ctrl);
 }
 
+void nvme_update_keep_alive(struct nvme_ctrl *ctrl, unsigned int new_kato)
+{
+	dev_info(ctrl->device,
+		 "keep alive commands interval on the host is updated from %u ms to %u ms\n",
+		 ctrl->kato * 1000 / 2, new_kato * 1000 / 2);
+
+	nvme_stop_keep_alive(ctrl);
+	ctrl->kato = new_kato;
+	nvme_start_keep_alive(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvme_update_keep_alive);
+
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
 {
 	if (unlikely(ctrl->kato == 0))
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 305ddd415e45..79006bfb5537 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -187,6 +187,22 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 	return true;
 }
 
+static void nvme_user_cmd_post(struct nvme_passthru_cmd *cmd,
+			       struct nvme_ctrl *ctrl)
+{
+	/*
+	 * Keep alive commands interval on the host should be updated
+	 * when KATO is modified by Set Features commands.
+	 */
+	if (cmd->opcode == nvme_admin_set_features &&
+	    (cmd->cdw10 & 0xFF) == NVME_FEAT_KATO) {
+		/* ms -> s */
+		unsigned int new_kato = DIV_ROUND_UP(cmd->cdw11, 1000);
+
+		nvme_update_keep_alive(ctrl, new_kato);
+	}
+}
+
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			struct nvme_passthru_cmd __user *ucmd)
 {
@@ -231,6 +247,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			return -EFAULT;
 	}
 
+	if (!status)
+		nvme_user_cmd_post(&cmd, ctrl);
+
 	return status;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5cd1fa3b8464..0372480db508 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -666,6 +666,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
+void nvme_update_keep_alive(struct nvme_ctrl *ctrl, unsigned int new_kato);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
-- 
2.25.1


