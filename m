Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A333FD552
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbhIAIZU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Sep 2021 04:25:20 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:60654 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243208AbhIAIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:25:15 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 1818Njqh004816; Wed, 1 Sep 2021 17:23:45 +0900
X-Iguazu-Qid: 34trDWJKTf2SiJPISB
X-Iguazu-QSIG: v=2; s=0; t=1630484625; q=34trDWJKTf2SiJPISB; m=kn6fdyyjDWyL0Uhwj4t6ti3dxVxFCj4N2/4I9JTN0IM=
Received: from CNN1EMTA01.test.kioxia.com ([202.248.33.144])
        by relay.securemx.jp (mx-mr1513) id 1818NiFf032112;
        Wed, 1 Sep 2021 17:23:44 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
        by CNN1EMTA01.test.kioxia.com (Postfix) with ESMTP id 2B8642F00E;
        Wed,  1 Sep 2021 17:23:44 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
        by Switcher-Post_Send (Postfix) with ESMTP id 12A2D1907AD217;
        Wed,  1 Sep 2021 17:21:09 +0900 (JST)
Received: from localhost [127.0.0.1] 
         by CNN1ESTR03.kioxia.com with ESMTP id 0002TAAAAAA00JC2;
         Wed, 1 Sep 2021 17:21:09 +0900
Received: from CNN1EXMB03.r1.kioxia.com (CNN1EXMB03.r1.kioxia.com [10.232.20.152])
        by Switcher-Pre_Send (Postfix) with ESMTP id 07AD1A0347641;
        Wed,  1 Sep 2021 17:21:09 +0900 (JST)
Received: from CNN1EXMB02.r1.kioxia.com (10.232.20.151) by
 CNN1EXMB03.r1.kioxia.com (10.232.20.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 1 Sep 2021 17:23:42 +0900
Received: from CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) by
 CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) with mapi id 15.01.2242.010; Wed, 1
 Sep 2021 17:23:42 +0900
From:   sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] nvme: update keep alive interval when kato is modified
Thread-Topic: [PATCH v3] nvme: update keep alive interval when kato is
 modified
Thread-Index: AdefCnVHT6aDpXBYTEKau30wTNdtIA==
Date:   Wed, 1 Sep 2021 08:23:42 +0000
Message-ID: <894db4eeb08a4622aa1b08425cad0133@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.211.46.251]
x-tm-as-product-ver: ISME-14.0.0.2080-8.5.1020-26380.000
x-tm-as-result: No-10-1.468400-8.000000
x-tmase-matchedrid: /nPNxfnsEhP5uyvfNjfPTxvgzEPRJaDEKQNhMboqZloTiSW9r3PknEfj
        d+aXilyPRToGmkNUJwa4TDy5Lbm+t57ghrpuj+9i6s5dyYfDHehWy4+qD6wC2YB4XybRlTmEhL3
        rCQ6U0+Qc+2+RgGf529PzWwTEpBnXu6Xs4AbfF8F+J3gtIe0gA7qoFakaELIgByGoU9ZSHrbFYx
        BBONJAzQ4LQ4ivyVfr3W0MEVF2MTJfIZMaSDtuL4S/TV9k6ppAMVx/3ZYby79DlOm+558WVom99
        KFCUKgfSqdra4WWujyPQi9XuOWoOHI/MxNRI7Uks0T0PE+KHuV7xIKEgZq/Aeffrtw9TYLh7fKx
        aM2xqkADxZCHySssjFSCmfT2v3te9JykO4HIhnKtllqIt7O6XeRjZuXE0WlHvGAx/1ATZ5v6J9J
        Pzr0FdcoLwUdWvzxRho9FZFW/cB2VH5Uhim9YYG/6CCblACLhZLeVqspIPked277WeIa5e1WGm7
        GL6RCdngIgpj8eDcByZ8zcONpAscRB0bsfrpPINogTRkHigdygTkMzC2F9D9nbeNR4uIDN8RwA4
        ZVylct4GSStKYzYmuWNmJGaCGf9lFOSU6PFPfQyBfFEI+ZKDwm1lnxnTxFMF8n+PiAiji0E2TM8
        4EuTy0FgpjGVf2/bBUYQ6VBjSapyPw0xDpM2TfHHxQDHp3JrVlxr1FJij9s=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10-1.468400-8.000000
x-tmase-version: ISME-14.0.0.2080-8.5.1020-26380.000
x-tm-snts-smtp: 52C2AE1A7D514335A88CFA192EDA386345EB4928B880FA4C60A19B3A92D850162000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB03.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB03.r1.kioxia.com
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
Changes since v2:
- Remove unnecessary comment
- Move DIV_ROUND_UP into nvme_update_keep_alive
- Call nvme_update_keep_alive from nvme_passthru_end in core routine.

drivers/nvme/host/core.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfd9dec0c1f6..5718e5898104 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -116,6 +116,8 @@ static struct class *nvme_ns_chr_class;
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
+static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
+				   struct nvme_command *cmd);
 
 /*
  * Prepare a queue for teardown.
@@ -1155,7 +1157,8 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return effects;
 }
 
-static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
+static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+			      struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
 		nvme_unfreeze(ctrl);
@@ -1170,6 +1173,24 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
 	}
+	switch (cmd->common.opcode) {
+	case nvme_admin_set_features:
+		switch (cmd->common.cdw10 & 0xFF) {
+		case NVME_FEAT_KATO:
+			/*
+			 * Keep alive commands interval on the host should be updated
+			 * when KATO is modified by Set Features commands.
+			 */
+			if (!status)
+				nvme_update_keep_alive(ctrl, cmd);
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
 }
 
 int nvme_execute_passthru_rq(struct request *rq)
@@ -1184,7 +1205,7 @@ int nvme_execute_passthru_rq(struct request *rq)
 	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
 	ret = nvme_execute_rq(disk, rq, false);
 	if (effects) /* nothing to be done for zero cmd effects */
-		nvme_passthru_end(ctrl, effects);
+		nvme_passthru_end(ctrl, effects, cmd, ret);
 
 	return ret;
 }
@@ -1263,6 +1284,20 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 	nvme_queue_keep_alive_work(ctrl);
 }
 
+static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
+				   struct nvme_command *cmd)
+{
+	unsigned int new_kato = DIV_ROUND_UP(cmd->common.cdw11, 1000);
+
+	dev_info(ctrl->device,
+		 "keep alive commands interval on the host is updated from %u ms to %u ms\n",
+		 ctrl->kato * 1000 / 2, new_kato * 1000 / 2);
+
+	nvme_stop_keep_alive(ctrl);
+	ctrl->kato = new_kato;
+	nvme_start_keep_alive(ctrl);
+}
+
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
 {
 	if (unlikely(ctrl->kato == 0))
-- 
2.25.1


