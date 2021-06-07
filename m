Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190F139DC5A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFGM3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:29:42 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53980 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230241AbhFGM3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:29:40 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv0KaEL5gTV0MAA--.13959S2;
        Mon, 07 Jun 2021 20:27:07 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH] drm/radeon: Always call radeon_suspend_kms() in radeon_pci_shutdown()
Date:   Mon,  7 Jun 2021 20:27:00 +0800
Message-Id: <1623068820-2479-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxv0KaEL5gTV0MAA--.13959S2
X-Coremail-Antispam: 1UD129KBjvJXoWruF4ftr4ruFyDKF4UKF15urg_yoW8JF1Upr
        W3GwsF9rn3tF4Fkay7ArW7JF13t3Z7GayxXrWvkw1DWws8A3s8Jr9aqFyUJry8urySgF12
        qF1kG34ruF4xJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5JwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjsjjDUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

radeon_suspend_kms() puts the hw in the suspend state (all asics),
it should always call radeon_suspend_kms() in radeon_pci_shutdown(),
this is a normal cleanup process to avoid more operations on radeon,
just remove #ifdef CONFIG_PPC64 and the related comments.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index efeb115..0b1f43d 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -386,16 +386,7 @@ radeon_pci_shutdown(struct pci_dev *pdev)
 	if (radeon_device_is_virtual())
 		radeon_pci_remove(pdev);
 
-#ifdef CONFIG_PPC64
-	/*
-	 * Some adapters need to be suspended before a
-	 * shutdown occurs in order to prevent an error
-	 * during kexec.
-	 * Make this power specific becauase it breaks
-	 * some non-power boards.
-	 */
 	radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);
-#endif
 }
 
 static int radeon_pmops_suspend(struct device *dev)
-- 
2.1.0

