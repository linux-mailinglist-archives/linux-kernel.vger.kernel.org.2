Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F74607B2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350739AbhK1QvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:51:16 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:60068 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243266AbhK1QtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:49:15 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id rNJMmflft2lVYrNJNmrScH; Sun, 28 Nov 2021 17:45:58 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 28 Nov 2021 17:45:58 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] drm/amdkfd: Use bitmap_zalloc() when applicable
Date:   Sun, 28 Nov 2021 17:45:55 +0100
Message-Id: <f12820f6c5fca9b10ac8f82b3689c50ccb6966aa.1638117878.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'kfd->gtt_sa_bitmap' is a bitmap. So use 'bitmap_zalloc()' to simplify
code, improve the semantic and avoid some open-coded arithmetic in
allocator arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e1294fba0c26..c5a0ce44a295 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1252,8 +1252,6 @@ int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 				unsigned int chunk_size)
 {
-	unsigned int num_of_longs;
-
 	if (WARN_ON(buf_size < chunk_size))
 		return -EINVAL;
 	if (WARN_ON(buf_size == 0))
@@ -1264,11 +1262,8 @@ static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 	kfd->gtt_sa_chunk_size = chunk_size;
 	kfd->gtt_sa_num_of_chunks = buf_size / chunk_size;
 
-	num_of_longs = (kfd->gtt_sa_num_of_chunks + BITS_PER_LONG - 1) /
-		BITS_PER_LONG;
-
-	kfd->gtt_sa_bitmap = kcalloc(num_of_longs, sizeof(long), GFP_KERNEL);
-
+	kfd->gtt_sa_bitmap = bitmap_zalloc(kfd->gtt_sa_num_of_chunks,
+					   GFP_KERNEL);
 	if (!kfd->gtt_sa_bitmap)
 		return -ENOMEM;
 
@@ -1278,13 +1273,12 @@ static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 	mutex_init(&kfd->gtt_sa_lock);
 
 	return 0;
-
 }
 
 static void kfd_gtt_sa_fini(struct kfd_dev *kfd)
 {
 	mutex_destroy(&kfd->gtt_sa_lock);
-	kfree(kfd->gtt_sa_bitmap);
+	bitmap_free(kfd->gtt_sa_bitmap);
 }
 
 static inline uint64_t kfd_gtt_sa_calc_gpu_addr(uint64_t start_addr,
-- 
2.30.2

