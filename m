Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662E7405A61
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbhIIPtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 11:49:22 -0400
Received: from mail-m17642.qiye.163.com ([59.111.176.42]:25872 "EHLO
        mail-m17642.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbhIIPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 11:49:13 -0400
Received: from localhost.localdomain (unknown [113.116.176.115])
        by mail-m17642.qiye.163.com (Hmail) with ESMTPA id CAAC92201B8;
        Thu,  9 Sep 2021 23:48:01 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     lduncan@suse.com, cleech@redhat.com, jejb@linux.ibm.com,
        michael.christie@oracle.co, open-iscsi@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH 2/3] scsi: libiscsi: fix invalid pointer dereference in iscsi_eh_session_reset
Date:   Thu,  9 Sep 2021 23:47:28 +0800
Message-Id: <20210909154729.20715-2-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210909154729.20715-1-dinghui@sangfor.com.cn>
References: <20210909154729.20715-1-dinghui@sangfor.com.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRkfSkhWTUwYGExIH0pNGh
        odVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBQ6Ejo4LD4VGh8JKxASM0oZ
        FgIaCwFVSlVKTUhKSUtJT0NJSElIVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKSkhVSkpNVUpMTVVKSk5ZV1kIAVlBSUpDSDcG
X-HM-Tid: 0a7bcb3e976bd998kuwscaac92201b8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

like commit 5db6dd14b313 ("scsi: libiscsi: Fix NULL pointer dereference in
iscsi_eh_session_reset"), access conn->persistent_address here is not safe
too.

The persistent_address is independent of conn refcount, so maybe
already freed by iscsi_conn_teardown(), also we put the refcount of conn
above, the conn pointer may be invalid.

Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 drivers/scsi/libiscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 712a45368385..69b3b2148328 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -2531,8 +2531,8 @@ int iscsi_eh_session_reset(struct scsi_cmnd *sc)
 	spin_lock_bh(&session->frwd_lock);
 	if (session->state == ISCSI_STATE_LOGGED_IN) {
 		ISCSI_DBG_EH(session,
-			     "session reset succeeded for %s,%s\n",
-			     session->targetname, conn->persistent_address);
+			     "session reset succeeded for %s\n",
+			     session->targetname);
 	} else
 		goto failed;
 	spin_unlock_bh(&session->frwd_lock);
-- 
2.17.1

