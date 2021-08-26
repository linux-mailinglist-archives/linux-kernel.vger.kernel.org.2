Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38C53F8067
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 04:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbhHZCY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 22:24:27 -0400
Received: from smtpbgsg1.qq.com ([54.254.200.92]:57679 "EHLO smtpbgsg1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235677AbhHZCY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 22:24:26 -0400
X-QQ-mid: bizesmtp47t1629944600t0qbyafz
Received: from localhost.localdomain (unknown [111.207.172.18])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 26 Aug 2021 10:23:17 +0800 (CST)
X-QQ-SSF: 0140000000200050D000B00A0000000
X-QQ-FEAT: zEFwFsE0FwpIbzN/rQ0seBiGJYh4ez3wZarFkHyzKOOMPDaKXKPVZqZhm5b0y
        t00/pnVZyX/ysLQOnp7WOI4rsTD+SO4sJTbUI9ENNNpbyob2XS4/h7JPro0WSxF3ZsXsQAw
        rl7IFbMAYbicqOR0tH8vgWz+PBQ12quXRtvIRyef67TPylwkJJHdy4AjeAg9+D/1UcIe/1V
        Wro6ak++2HXkqwoghVz5Nj8EUw/T296TMXxfiCfyz25oQYDQf36G2FD0Od2MVXSb4iKL+89
        qqXN+7+WkSJ+gCxSF2W4R7MJYWx8PRPz6fP55YEBNdjnX2PgZKSshjJtZSDkupye4I9ASBT
        10Ex5ojATVXD0nKUag=
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     jordan@cosmicpenguin.net, saiprakash.ranjan@codeaurora.org,
        jonathan@marek.ca, airlied@redhat.com, smasetty@codeaurora.org,
        konrad.dybcio@somainline.org, akhilpo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH v2] drm: msm: adreno_gpu.c: Add and use pr_fmt(fmt)
Date:   Thu, 26 Aug 2021 10:23:16 +0800
Message-Id: <20210826022316.9559-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a more common logging style.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
v2:Remove the line: #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
   drivers/gpu/drm/msm/adreno/adreno_gpu.c:23:9: warning: 'pr_fmt' macro redefined [-Wmacro-redefined]
   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
           ^
   include/linux/printk.h:348:9: note: previous definition is here
   #define pr_fmt(fmt) fmt

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 9f5a30234b33..f10e9e04c13b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -753,7 +753,7 @@ void adreno_dump_info(struct msm_gpu *gpu)
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	int i;
 
-	printk("revision: %d (%d.%d.%d.%d)\n",
+	pr_info("revision: %d (%d.%d.%d.%d)\n",
 			adreno_gpu->info->revn, adreno_gpu->rev.core,
 			adreno_gpu->rev.major, adreno_gpu->rev.minor,
 			adreno_gpu->rev.patchid);
@@ -761,12 +761,12 @@ void adreno_dump_info(struct msm_gpu *gpu)
 	for (i = 0; i < gpu->nr_rings; i++) {
 		struct msm_ringbuffer *ring = gpu->rb[i];
 
-		printk("rb %d: fence:    %d/%d\n", i,
+		pr_info("rb %d: fence:    %d/%d\n", i,
 			ring->memptrs->fence,
 			ring->seqno);
 
-		printk("rptr:     %d\n", get_rptr(adreno_gpu, ring));
-		printk("rb wptr:  %d\n", get_wptr(ring));
+		pr_info("rptr:     %d\n", get_rptr(adreno_gpu, ring));
+		pr_info("rb wptr:  %d\n", get_wptr(ring));
 	}
 }
 
@@ -780,7 +780,7 @@ void adreno_dump(struct msm_gpu *gpu)
 		return;
 
 	/* dump these out in a form that can be parsed by demsm: */
-	printk("IO:region %s 00000000 00020000\n", gpu->name);
+	pr_info("IO:region %s 00000000 00020000\n", gpu->name);
 	for (i = 0; adreno_gpu->registers[i] != ~0; i += 2) {
 		uint32_t start = adreno_gpu->registers[i];
 		uint32_t end   = adreno_gpu->registers[i+1];
@@ -788,7 +788,7 @@ void adreno_dump(struct msm_gpu *gpu)
 
 		for (addr = start; addr <= end; addr++) {
 			uint32_t val = gpu_read(gpu, addr);
-			printk("IO:R %08x %08x\n", addr<<2, val);
+			pr_info("IO:R %08x %08x\n", addr<<2, val);
 		}
 	}
 }
-- 
2.20.1



