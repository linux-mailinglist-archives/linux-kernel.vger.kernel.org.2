Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FD4345933
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCWICF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:02:05 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42681 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhCWIBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:01:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UT2X8eb_1616486482;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UT2X8eb_1616486482)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Mar 2021 16:01:28 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     bskeggs@redhat.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/nouveau/mc: make tu102_mc_intr_unarm static
Date:   Tue, 23 Mar 2021 16:01:21 +0800
Message-Id: <1616486481-94130-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c:74:1: warning: symbol
'tu102_mc_intr_mask' was not declared. Should it be static?

drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c:62:1: warning: symbol
'tu102_mc_intr_rearm' was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c
index 58db83e..7cf659cc 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c
@@ -58,7 +58,7 @@ struct tu102_mc {
 	spin_unlock_irqrestore(&mc->lock, flags);
 }
 
-void
+static void
 tu102_mc_intr_rearm(struct nvkm_mc *base)
 {
 	struct tu102_mc *mc = tu102_mc(base);
@@ -70,7 +70,7 @@ struct tu102_mc {
 	spin_unlock_irqrestore(&mc->lock, flags);
 }
 
-void
+static void
 tu102_mc_intr_mask(struct nvkm_mc *base, u32 mask, u32 intr)
 {
 	struct tu102_mc *mc = tu102_mc(base);
-- 
1.8.3.1

