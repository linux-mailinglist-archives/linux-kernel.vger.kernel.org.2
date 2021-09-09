Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0539A405A63
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 17:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhIIPt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 11:49:26 -0400
Received: from mail-m17642.qiye.163.com ([59.111.176.42]:25906 "EHLO
        mail-m17642.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbhIIPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 11:49:13 -0400
Received: from localhost.localdomain (unknown [113.116.176.115])
        by mail-m17642.qiye.163.com (Hmail) with ESMTPA id 614EB2201B9;
        Thu,  9 Sep 2021 23:48:02 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     lduncan@suse.com, cleech@redhat.com, jejb@linux.ibm.com,
        michael.christie@oracle.co, open-iscsi@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH 3/3] scsi: libiscsi: get ref to conn in iscsi_eh_device/target_reset()
Date:   Thu,  9 Sep 2021 23:47:29 +0800
Message-Id: <20210909154729.20715-3-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210909154729.20715-1-dinghui@sangfor.com.cn>
References: <20210909154729.20715-1-dinghui@sangfor.com.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJMQxlWQxkeQ0kdTk9NH0
        NDVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6Dyo*DD4VMB8cDRA*MwJO
        CCMaCgpVSlVKTUhKSUtJT0NJQktNVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKSkhVSkpNVUpMTVVKSk5ZV1kIAVlBSEhMQzcG
X-HM-Tid: 0a7bcb3e99a5d998kuws614eb2201b9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

like commit fda290c5ae98 ("scsi: iscsi: Get ref to conn during reset
handling"), because in iscsi_exec_task_mgmt_fn(), the eh_mutex and
frwd_lock will be unlock, the conn also can be released if we not
hold ref.

Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 drivers/scsi/libiscsi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 69b3b2148328..4d3b37c20f8a 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -2398,7 +2398,7 @@ int iscsi_eh_device_reset(struct scsi_cmnd *sc)
 {
 	struct iscsi_cls_session *cls_session;
 	struct iscsi_session *session;
-	struct iscsi_conn *conn;
+	struct iscsi_conn *conn = NULL;
 	struct iscsi_tm *hdr;
 	int rc = FAILED;
 
@@ -2417,6 +2417,7 @@ int iscsi_eh_device_reset(struct scsi_cmnd *sc)
 	if (!session->leadconn || session->state != ISCSI_STATE_LOGGED_IN)
 		goto unlock;
 	conn = session->leadconn;
+	iscsi_get_conn(conn->cls_conn);
 
 	/* only have one tmf outstanding at a time */
 	if (session->tmf_state != TMF_INITIAL)
@@ -2463,6 +2464,8 @@ int iscsi_eh_device_reset(struct scsi_cmnd *sc)
 done:
 	ISCSI_DBG_EH(session, "dev reset result = %s\n",
 		     rc == SUCCESS ? "SUCCESS" : "FAILED");
+	if (conn)
+		iscsi_put_conn(conn->cls_conn);
 	mutex_unlock(&session->eh_mutex);
 	return rc;
 }
@@ -2560,7 +2563,7 @@ static int iscsi_eh_target_reset(struct scsi_cmnd *sc)
 {
 	struct iscsi_cls_session *cls_session;
 	struct iscsi_session *session;
-	struct iscsi_conn *conn;
+	struct iscsi_conn *conn = NULL;
 	struct iscsi_tm *hdr;
 	int rc = FAILED;
 
@@ -2579,6 +2582,7 @@ static int iscsi_eh_target_reset(struct scsi_cmnd *sc)
 	if (!session->leadconn || session->state != ISCSI_STATE_LOGGED_IN)
 		goto unlock;
 	conn = session->leadconn;
+	iscsi_get_conn(conn->cls_conn);
 
 	/* only have one tmf outstanding at a time */
 	if (session->tmf_state != TMF_INITIAL)
@@ -2625,6 +2629,8 @@ static int iscsi_eh_target_reset(struct scsi_cmnd *sc)
 done:
 	ISCSI_DBG_EH(session, "tgt %s reset result = %s\n", session->targetname,
 		     rc == SUCCESS ? "SUCCESS" : "FAILED");
+	if (conn)
+		iscsi_put_conn(conn->cls_conn);
 	mutex_unlock(&session->eh_mutex);
 	return rc;
 }
-- 
2.17.1

