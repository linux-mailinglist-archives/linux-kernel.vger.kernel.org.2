Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3078B45496D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbhKQPCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:02:09 -0500
Received: from marcansoft.com ([212.63.210.85]:57450 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235146AbhKQPCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:02:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7ED0141F55;
        Wed, 17 Nov 2021 14:59:06 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH 1/3] drm/simpledrm: Bind to OF framebuffers in /chosen
Date:   Wed, 17 Nov 2021 23:58:27 +0900
Message-Id: <20211117145829.204360-2-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117145829.204360-1-marcan@marcan.st>
References: <20211117145829.204360-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This matches the simplefb behavior; these nodes are not matched by the
standard OF machinery. This fixes a regression when simpledrm replaces
simeplefb.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/gpu/drm/tiny/simpledrm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 481b48bde047..2c84f2ea1fa2 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -2,6 +2,7 @@
 
 #include <linux/clk.h>
 #include <linux/of_clk.h>
+#include <linux/of_platform.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
@@ -897,5 +898,21 @@ static struct platform_driver simpledrm_platform_driver = {
 
 module_platform_driver(simpledrm_platform_driver);
 
+static int __init simpledrm_init(void)
+{
+	struct device_node *np;
+
+	if (IS_ENABLED(CONFIG_OF_ADDRESS) && of_chosen) {
+		for_each_child_of_node(of_chosen, np) {
+			if (of_device_is_compatible(np, "simple-framebuffer"))
+				of_platform_device_create(np, NULL, NULL);
+		}
+	}
+
+	return 0;
+}
+
+fs_initcall(simpledrm_init);
+
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL v2");
-- 
2.33.0

