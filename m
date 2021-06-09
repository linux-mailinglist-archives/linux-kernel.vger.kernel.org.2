Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D48A3A0AB0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhFIDhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:37:36 -0400
Received: from mail.loongson.cn ([114.242.206.163]:33898 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232787AbhFIDhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:37:35 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx70LnNsBgGIANAA--.15141S2;
        Wed, 09 Jun 2021 11:35:04 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH v2] drm/radeon: Call radeon_suspend_kms() in radeon_pci_shutdown() for Loongson64
Date:   Wed,  9 Jun 2021 11:35:01 +0800
Message-Id: <1623209701-18311-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx70LnNsBgGIANAA--.15141S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1fCFWrGF1DtrWUAFykGrg_yoW8Ar4rpr
        srG39rKwn3KFWYka47JFW7Xry5A348Xay8ZrWUKw4DW398Jr93Arnaqry3JryvgryxtF12
        vF1kGw1ruan7CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r48
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU-miiUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Loongson64 platform used with Radeon GPU, shutdown or reboot failed
when console=tty is in the boot cmdline.

radeon_suspend_kms() puts the hw in the suspend state, especially set fb
state as FBINFO_STATE_SUSPENDED:

	if (fbcon) {
		console_lock();
		radeon_fbdev_set_suspend(rdev, 1);
		console_unlock();
	}

Then avoid to do any more fb operations in the related functions:

	if (p->state != FBINFO_STATE_RUNNING)
		return;

So call radeon_suspend_kms() in radeon_pci_shutdown() for Loongson64 to fix
this issue, it looks like some kind of workaround like powerpc.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index efeb115..daabbf5 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -386,13 +386,13 @@ radeon_pci_shutdown(struct pci_dev *pdev)
 	if (radeon_device_is_virtual())
 		radeon_pci_remove(pdev);
 
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64) || defined(CONFIG_MACH_LOONGSON64)
 	/*
 	 * Some adapters need to be suspended before a
 	 * shutdown occurs in order to prevent an error
-	 * during kexec.
-	 * Make this power specific becauase it breaks
-	 * some non-power boards.
+	 * during kexec, shutdown or reboot.
+	 * Make this power and Loongson specific becauase
+	 * it breaks some other boards.
 	 */
 	radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);
 #endif
-- 
2.1.0

