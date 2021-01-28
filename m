Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3431307A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhA1QTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:19:24 -0500
Received: from m15111.mail.126.com ([220.181.15.111]:33757 "EHLO
        m15111.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhA1QTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=uGytE7I0mp3c6lgSL+
        ib2vk1NbSDygdXthHzFLoUVvw=; b=SJ6gkniHmwz/08M9zPGkVWQgMv/SZt7dX+
        GrvxiqPxo2vwpK2EmdcEE1qwKFnm7Ftwn1O33WtEf/1+0x4MPMmSFb+8Ye0y7a6Z
        TQCbbJCOrDKt8ZEOhtJiMBkC0ekH/9Ik0g6iiC5vVVMlVaS/+w5iRv9ms80ssvzU
        ffo3BMqRg=
Received: from localhost.localdomain.localdomain (unknown [182.150.46.145])
        by smtp1 (Coremail) with SMTP id C8mowAC3vj6iqhJguUeDOA--.19095S2;
        Thu, 28 Jan 2021 20:14:27 +0800 (CST)
From:   Qu Huang <jinsdb@126.com>
To:     Felix.Kuehling@amd.com
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        jinsdb@126.com
Subject: [PATCH v2] drm/amdkfd: dqm fence memory corruption
Date:   Thu, 28 Jan 2021 20:14:25 +0800
Message-Id: <1611836065-30884-1-git-send-email-jinsdb@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: C8mowAC3vj6iqhJguUeDOA--.19095S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF48JF1rWFWUArykGw47XFb_yoWxAF45pF
        Z3Jr17Wry8tF4av348Za48AFy3C3WxJFyfKry7G3sI93Z8Xa4rKrZ8Aay5K3y0gF9Fyay7
        JrsrGrW8W3Zrtr7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uev3nUUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: pmlq2vbe6rjloofrz/1tbirwMoDlpD-hp4ZQAAsq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amdgpu driver uses 4-byte data type as DQM fence memory,
and transmits GPU address of fence memory to microcode
through query status PM4 message. However, query status
PM4 message definition and microcode processing are all
processed according to 8 bytes. Fence memory only allocates
4 bytes of memory, but microcode does write 8 bytes of memory,
so there is a memory corruption.

Changes since v1:
  * Change dqm->fence_addr as a u64 pointer to fix this issue,
also fix up query_status and amdkfd_fence_wait_timeout function
uses 64 bit fence value to make them consistent.

Signed-off-by: Qu Huang <jinsdb@126.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c               | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c       | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c    | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c    | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 8 ++++----
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index b258a3d..159add0f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -155,7 +155,7 @@ static int dbgdev_diq_submit_ib(struct kfd_dbgdev *dbgdev,

 	/* Wait till CP writes sync code: */
 	status = amdkfd_fence_wait_timeout(
-			(unsigned int *) rm_state,
+			rm_state,
 			QUEUESTATE__ACTIVE, 1500);

 	kfd_gtt_sa_free(dbgdev->dev, mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e686ce2..4598a9a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1167,7 +1167,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	if (retval)
 		goto fail_allocate_vidmem;

-	dqm->fence_addr = dqm->fence_mem->cpu_ptr;
+	dqm->fence_addr = (uint64_t *)dqm->fence_mem->cpu_ptr;
 	dqm->fence_gpu_addr = dqm->fence_mem->gpu_addr;

 	init_interrupts(dqm);
@@ -1340,8 +1340,8 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	return retval;
 }

-int amdkfd_fence_wait_timeout(unsigned int *fence_addr,
-				unsigned int fence_value,
+int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
+				uint64_t fence_value,
 				unsigned int timeout_ms)
 {
 	unsigned long end_jiffies = msecs_to_jiffies(timeout_ms) + jiffies;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 16262e5..16b23dd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -192,7 +192,7 @@ struct device_queue_manager {
 	uint16_t		vmid_pasid[VMID_NUM];
 	uint64_t		pipelines_addr;
 	uint64_t		fence_gpu_addr;
-	unsigned int		*fence_addr;
+	uint64_t		*fence_addr;
 	struct kfd_mem_obj	*fence_mem;
 	bool			active_runlist;
 	int			sched_policy;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 5d541e0..f71a7fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -347,7 +347,7 @@ int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_queues)
 }

 int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
-			uint32_t fence_value)
+			uint64_t fence_value)
 {
 	uint32_t *buffer, size;
 	int retval = 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index dfaf771..e3ba0cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -283,7 +283,7 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 }

 static int pm_query_status_v9(struct packet_manager *pm, uint32_t *buffer,
-			uint64_t fence_address,	uint32_t fence_value)
+			uint64_t fence_address,	uint64_t fence_value)
 {
 	struct pm4_mes_query_status *packet;

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index a852e0d..08442e7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -263,7 +263,7 @@ static int pm_unmap_queues_vi(struct packet_manager *pm, uint32_t *buffer,
 }

 static int pm_query_status_vi(struct packet_manager *pm, uint32_t *buffer,
-			uint64_t fence_address,	uint32_t fence_value)
+			uint64_t fence_address,	uint64_t fence_value)
 {
 	struct pm4_mes_query_status *packet;

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 09599ef..f304d1f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1003,8 +1003,8 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 		       u32 *ctl_stack_used_size,
 		       u32 *save_area_used_size);

-int amdkfd_fence_wait_timeout(unsigned int *fence_addr,
-			      unsigned int fence_value,
+int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
+			      uint64_t fence_value,
 			      unsigned int timeout_ms);

 /* Packet Manager */
@@ -1040,7 +1040,7 @@ struct packet_manager_funcs {
 			uint32_t filter_param, bool reset,
 			unsigned int sdma_engine);
 	int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
-			uint64_t fence_address,	uint32_t fence_value);
+			uint64_t fence_address,	uint64_t fence_value);
 	int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);

 	/* Packet sizes */
@@ -1062,7 +1062,7 @@ int pm_send_set_resources(struct packet_manager *pm,
 				struct scheduling_resources *res);
 int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_queues);
 int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
-				uint32_t fence_value);
+				uint64_t fence_value);

 int pm_send_unmap_queue(struct packet_manager *pm, enum kfd_queue_type type,
 			enum kfd_unmap_queues_filter mode,
--
1.8.3.1

