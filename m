Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6074045AD8E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 21:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbhKWUuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 15:50:01 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:61493 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbhKWUt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:49:59 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id pcggmIyPtBazopcggmCFfd; Tue, 23 Nov 2021 21:46:47 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 23 Nov 2021 21:46:47 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 1/2] drm/amdkfd: Use bitmap_zalloc() when applicable
Date:   Tue, 23 Nov 2021 21:46:44 +0100
Message-Id: <cebaed4e892db804eece363e07a3ddd04af0f7be.1637700315.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'doorbell_bitmap' and 'queue_slot_bitmap' are bitmaps. So use
'bitmap_zalloc()' to simplify code, improve the semantic and avoid some
open-coded arithmetic in allocator arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v1 --> v2: Compile tested :)
           Add a missing ',' (kernel test robot)
           Add kfd_process_queue_manager.c (Felix Kuehling)
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c               | 7 +++----
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d4c8a6948a9f..67bb1654becc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1011,7 +1011,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 			free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
 				get_order(KFD_CWSR_TBA_TMA_SIZE));
 
-		kfree(pdd->qpd.doorbell_bitmap);
+		bitmap_free(pdd->qpd.doorbell_bitmap);
 		idr_destroy(&pdd->alloc_idr);
 
 		kfd_free_process_doorbells(pdd->dev, pdd->doorbell_index);
@@ -1433,9 +1433,8 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
 	if (!KFD_IS_SOC15(dev))
 		return 0;
 
-	qpd->doorbell_bitmap =
-		kzalloc(DIV_ROUND_UP(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
-				     BITS_PER_BYTE), GFP_KERNEL);
+	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
+					     GFP_KERNEL);
 	if (!qpd->doorbell_bitmap)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 4f8464658daf..c5f5a25c6dcc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -135,9 +135,8 @@ void kfd_process_dequeue_from_all_devices(struct kfd_process *p)
 int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p)
 {
 	INIT_LIST_HEAD(&pqm->queues);
-	pqm->queue_slot_bitmap =
-			kzalloc(DIV_ROUND_UP(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
-					BITS_PER_BYTE), GFP_KERNEL);
+	pqm->queue_slot_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
+					       GFP_KERNEL);
 	if (!pqm->queue_slot_bitmap)
 		return -ENOMEM;
 	pqm->process = p;
@@ -159,7 +158,7 @@ void pqm_uninit(struct process_queue_manager *pqm)
 		kfree(pqn);
 	}
 
-	kfree(pqm->queue_slot_bitmap);
+	bitmap_free(pqm->queue_slot_bitmap);
 	pqm->queue_slot_bitmap = NULL;
 }
 
-- 
2.30.2

