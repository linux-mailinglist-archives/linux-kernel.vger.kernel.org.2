Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCA5405A62
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbhIIPtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 11:49:24 -0400
Received: from mail-m17642.qiye.163.com ([59.111.176.42]:25830 "EHLO
        mail-m17642.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbhIIPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 11:49:13 -0400
Received: from localhost.localdomain (unknown [113.116.176.115])
        by mail-m17642.qiye.163.com (Hmail) with ESMTPA id 3BE3F2201A4;
        Thu,  9 Sep 2021 23:48:01 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     lduncan@suse.com, cleech@redhat.com, jejb@linux.ibm.com,
        michael.christie@oracle.co, open-iscsi@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH 1/3] scsi: libiscsi: move init ehwait to iscsi_session_setup()
Date:   Thu,  9 Sep 2021 23:47:27 +0800
Message-Id: <20210909154729.20715-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRkaQ0lWSExMQ0tJTUgdSx
        lLVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K0k6Nxw5ET4ICh8QDRcOM0IV
        IS8aFEJVSlVKTUhKSUtJT0NKTE5PVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKSkhVSkpNVUpMTVVKSk5ZV1kIAVlBSUpCSjcG
X-HM-Tid: 0a7bcb3e9529d998kuws3be3f2201a4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ec29d0ac29be ("scsi: iscsi: Fix conn use after free during
resets") move member ehwait from conn to session, but left init ehwait
in iscsi_conn_setup().

Due to one session can be binded by multi conns, the conn after the
first will reinit the session->ehwait, move init ehwait to
iscsi_session_setup() to fix it.

Fixes: ec29d0ac29be ("scsi: iscsi: Fix conn use after free during resets")
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 drivers/scsi/libiscsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 4683c183e9d4..712a45368385 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -2947,6 +2947,7 @@ iscsi_session_setup(struct iscsi_transport *iscsit, struct Scsi_Host *shost,
 	session->tmf_state = TMF_INITIAL;
 	timer_setup(&session->tmf_timer, iscsi_tmf_timedout, 0);
 	mutex_init(&session->eh_mutex);
+	init_waitqueue_head(&session->ehwait);
 
 	spin_lock_init(&session->frwd_lock);
 	spin_lock_init(&session->back_lock);
@@ -3074,8 +3075,6 @@ iscsi_conn_setup(struct iscsi_cls_session *cls_session, int dd_size,
 		goto login_task_data_alloc_fail;
 	conn->login_task->data = conn->data = data;
 
-	init_waitqueue_head(&session->ehwait);
-
 	return cls_conn;
 
 login_task_data_alloc_fail:
-- 
2.17.1

