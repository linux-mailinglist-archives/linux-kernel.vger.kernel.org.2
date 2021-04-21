Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2889B366B80
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbhDUNCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240193AbhDUNCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 562F76143C;
        Wed, 21 Apr 2021 13:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010124;
        bh=F/aqQYh/VzWOgJCY7gDITJMDm/foIeMmcGDBcbFXakw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tC07+gQB7Uu6i3BaGE80FZKBr4GUlK+T9Vd5OcTSOE6vfO+25kLoLoRgpgRqbZeUz
         0pmWXDIAOThiDXcQuFTryFf17rfIpn/uUUUVJ0X0CNukr+tyG/SIejg0ngzYzUhHLu
         YoIwJsdf2Tf2tuztqCMqoHk9iDh2voP470aYCD/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu,
        wu000273@umn.edu, Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        "Andrew F. Davis" <afd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 021/190] Revert "omapfb: fix multiple reference count leaks due to pm_runtime_get_sync"
Date:   Wed, 21 Apr 2021 14:58:16 +0200
Message-Id: <20210421130105.1226686-22-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 78c2ce9bde70be5be7e3615a2ae7024ed8173087.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: kjlu@umn.edu
Cc: wu000273@umn.edu
Cc: Allison Randal <allison@lohutok.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Enrico Weigelt <info@metux.net>
Cc: "Andrew F. Davis" <afd@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: https
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c | 7 ++-----
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c   | 7 ++-----
 drivers/video/fbdev/omap2/omapfb/dss/dss.c   | 7 ++-----
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c | 5 ++---
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c | 5 ++---
 drivers/video/fbdev/omap2/omapfb/dss/venc.c  | 7 ++-----
 6 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index b2d6e6df2161..285d33ce1e11 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -520,11 +520,8 @@ int dispc_runtime_get(void)
 	DSSDBG("dispc_runtime_get\n");
 
 	r = pm_runtime_get_sync(&dispc.pdev->dev);
-	if (WARN_ON(r < 0)) {
-		pm_runtime_put_sync(&dispc.pdev->dev);
-		return r;
-	}
-	return 0;
+	WARN_ON(r < 0);
+	return r < 0 ? r : 0;
 }
 EXPORT_SYMBOL(dispc_runtime_get);
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index daa313f14335..bfa27672fe27 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -1137,11 +1137,8 @@ static int dsi_runtime_get(struct platform_device *dsidev)
 	DSSDBG("dsi_runtime_get\n");
 
 	r = pm_runtime_get_sync(&dsi->pdev->dev);
-	if (WARN_ON(r < 0)) {
-		pm_runtime_put_sync(&dsi->pdev->dev);
-		return r;
-	}
-	return 0;
+	WARN_ON(r < 0);
+	return r < 0 ? r : 0;
 }
 
 static void dsi_runtime_put(struct platform_device *dsidev)
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
index a6b1c1598040..bfc5c4c5a26a 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -768,11 +768,8 @@ int dss_runtime_get(void)
 	DSSDBG("dss_runtime_get\n");
 
 	r = pm_runtime_get_sync(&dss.pdev->dev);
-	if (WARN_ON(r < 0)) {
-		pm_runtime_put_sync(&dss.pdev->dev);
-		return r;
-	}
-	return 0;
+	WARN_ON(r < 0);
+	return r < 0 ? r : 0;
 }
 
 void dss_runtime_put(void)
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
index 800bd108e834..e8ccb2f5ea70 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
@@ -39,10 +39,9 @@ static int hdmi_runtime_get(void)
 	DSSDBG("hdmi_runtime_get\n");
 
 	r = pm_runtime_get_sync(&hdmi.pdev->dev);
-	if (WARN_ON(r < 0)) {
-		pm_runtime_put_sync(&hdmi.pdev->dev);
+	WARN_ON(r < 0);
+	if (r < 0)
 		return r;
-	}
 
 	return 0;
 }
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
index 2c03608addcd..bb59367b69c4 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
@@ -43,10 +43,9 @@ static int hdmi_runtime_get(void)
 	DSSDBG("hdmi_runtime_get\n");
 
 	r = pm_runtime_get_sync(&hdmi.pdev->dev);
-	if (WARN_ON(r < 0)) {
-		pm_runtime_put_sync(&hdmi.pdev->dev);
+	WARN_ON(r < 0);
+	if (r < 0)
 		return r;
-	}
 
 	return 0;
 }
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/venc.c b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
index 905d642ff9ed..b9e722542afb 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/venc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
@@ -348,11 +348,8 @@ static int venc_runtime_get(void)
 	DSSDBG("venc_runtime_get\n");
 
 	r = pm_runtime_get_sync(&venc.pdev->dev);
-	if (WARN_ON(r < 0)) {
-		pm_runtime_put_sync(&venc.pdev->dev);
-		return r;
-	}
-	return 0;
+	WARN_ON(r < 0);
+	return r < 0 ? r : 0;
 }
 
 static void venc_runtime_put(void)
-- 
2.31.1

