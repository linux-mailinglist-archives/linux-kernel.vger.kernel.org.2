Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7BA35E48B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347020AbhDMRFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:05:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34529 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbhDMRFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:05:38 -0400
Received: from 1-171-231-81.dynamic-ip.hinet.net ([1.171.231.81] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lWMTS-0005T2-Fo; Tue, 13 Apr 2021 17:05:15 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     pjones@redhat.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-fbdev@vger.kernel.org (open list:EFIFB FRAMEBUFFER DRIVER),
        dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] efifb: Check efifb_pci_dev before using it
Date:   Wed, 14 Apr 2021 01:05:08 +0800
Message-Id: <20210413170508.968148-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms like Hyper-V and RPi4 with UEFI firmware, efifb is not
a PCI device.

So make sure efifb_pci_dev is found before using it.

Fixes: a6c0fd3d5a8b ("efifb: Ensure graphics device for efifb stays at PCI D0")
BugLink: https://bugs.launchpad.net/bugs/1922403
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/video/fbdev/efifb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index f58a545b3bf3..8ea8f079cde2 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -575,7 +575,8 @@ static int efifb_probe(struct platform_device *dev)
 		goto err_fb_dealoc;
 	}
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
-	pm_runtime_get_sync(&efifb_pci_dev->dev);
+	if (efifb_pci_dev)
+		pm_runtime_get_sync(&efifb_pci_dev->dev);
 	return 0;
 
 err_fb_dealoc:
@@ -602,7 +603,8 @@ static int efifb_remove(struct platform_device *pdev)
 	unregister_framebuffer(info);
 	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
 	framebuffer_release(info);
-	pm_runtime_put(&efifb_pci_dev->dev);
+	if (efifb_pci_dev)
+		pm_runtime_put(&efifb_pci_dev->dev);
 
 	return 0;
 }
-- 
2.30.2

