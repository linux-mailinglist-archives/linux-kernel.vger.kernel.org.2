Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA1040A6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 08:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbhINGZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 02:25:15 -0400
Received: from mail.loongson.cn ([114.242.206.163]:46662 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239908AbhINGZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:25:14 -0400
Received: from localhost.localdomain (unknown [10.2.5.180])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxH2v4P0Bh3U0GAA--.10627S3;
        Tue, 14 Sep 2021 14:23:52 +0800 (CST)
From:   bibo mao <maobibo@loongson.cn>
To:     Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/qxl: Add qxl dma fence release function
Date:   Tue, 14 Sep 2021 02:23:52 -0400
Message-Id: <20210914062352.6102-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210914062352.6102-1-maobibo@loongson.cn>
References: <20210914062352.6102-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxH2v4P0Bh3U0GAA--.10627S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWUGr4UJF4rZr47JF47Arb_yoW8GrykpF
        W8Gw45CF47JFZFgwsxAF1UXryrC3Z5KFyfKF92k3y3Zw15JF1UJr18Jay0vFs8AF97tF42
        qF1qkF15KF1jgFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
        aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVCm-wCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07b0PEfUUUUU=
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qxl dma fence release function, previously default dma fence
release function is used, and fence pointer is used to free 
the memory. With this patch, actual qxl release pointer is used
to free memory, so that dma fence can put at any place of 
struct qxl_release.

Signed-off-by: bibo mao <maobibo@loongson.cn>
---
 drivers/gpu/drm/qxl/qxl_release.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 469979cd0341..a9724857c526 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -74,10 +74,25 @@ static long qxl_fence_wait(struct dma_fence *fence, bool intr,
 	return end - cur;
 }
 
+static void qxl_fence_release_rcu(struct rcu_head *rcu)
+{
+	struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
+	struct qxl_release *release;
+
+	release = container_of(fence, struct qxl_release, base);
+	kfree(release);
+}
+
+static void qxl_fence_release(struct dma_fence *fence)
+{
+	call_rcu(&fence->rcu, qxl_fence_release_rcu);
+}
+
 static const struct dma_fence_ops qxl_fence_ops = {
 	.get_driver_name = qxl_get_driver_name,
 	.get_timeline_name = qxl_get_timeline_name,
 	.wait = qxl_fence_wait,
+	.release = qxl_fence_release,
 };
 
 static int
-- 
2.27.0

