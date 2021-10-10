Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D400428180
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 15:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhJJNXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 09:23:46 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:48415 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232697AbhJJNXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 09:23:38 -0400
Received: from pop-os.home ([90.126.248.220])
        by mwinf5d78 with ME
        id 4DMc2600C4m3Hzu03DMdYq; Sun, 10 Oct 2021 15:21:38 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Oct 2021 15:21:38 +0200
X-ME-IP: 90.126.248.220
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     linkinjeon@kernel.org, senozhatsky@chromium.org, sfrench@samba.org,
        hyc.lee@gmail.com
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ksmbd: Remove redundant 'flush_workqueue()' calls
Date:   Sun, 10 Oct 2021 15:21:35 +0200
Message-Id: <bf5648ef0933536661e42cc73aa06722522d5862.1633872027.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- 	flush_workqueue(E);
	destroy_workqueue(E);

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/ksmbd/ksmbd_work.c     | 1 -
 fs/ksmbd/transport_rdma.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/ksmbd/ksmbd_work.c b/fs/ksmbd/ksmbd_work.c
index fd58eb4809f6..14b9caebf7a4 100644
--- a/fs/ksmbd/ksmbd_work.c
+++ b/fs/ksmbd/ksmbd_work.c
@@ -69,7 +69,6 @@ int ksmbd_workqueue_init(void)
 
 void ksmbd_workqueue_destroy(void)
 {
-	flush_workqueue(ksmbd_wq);
 	destroy_workqueue(ksmbd_wq);
 	ksmbd_wq = NULL;
 }
diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 3a7fa23ba850..0fa7b9c17af3 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -2026,7 +2026,6 @@ int ksmbd_rdma_destroy(void)
 	smb_direct_listener.cm_id = NULL;
 
 	if (smb_direct_wq) {
-		flush_workqueue(smb_direct_wq);
 		destroy_workqueue(smb_direct_wq);
 		smb_direct_wq = NULL;
 	}
-- 
2.30.2

