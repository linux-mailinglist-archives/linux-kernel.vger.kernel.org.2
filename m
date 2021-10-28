Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD11843D813
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 02:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhJ1AZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 20:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhJ1AZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 20:25:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CF4C061570;
        Wed, 27 Oct 2021 17:23:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s1so17459144edd.3;
        Wed, 27 Oct 2021 17:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCTwvoOkFjtGw94Tzk2z+JgJh7GsapYQB5zOutozzXQ=;
        b=nrN8n8PaHh1+RLQnf/FjOIy39un7mASLLph5ji94FKnne+Hpms1dFo9vJbzMDzGRJ/
         QPrduQwB8deG7+C9nV4vmkCRQb9MZq2JOFKOwE+AgBFbcrH7X2ztsUfX9wMUzT143is5
         /ID+lbejD6zNuiVBjRZEh5HKJJI/IX+FkOZuElR4aXNipFticvnzBq8r3ZO3zHQLxSF2
         jB8QLBHBlzf1Bkfd/60NDp0VPP5S/QyDcZ7j5KDD/i0X5rXVvniz2vcO8QxLUQRJoOKO
         80hKJhYG76/2bbt6idvVPsDLmAhsXPIG4qglgnLJxH4IEWNWUzpFMt1CqreJsJQ28C/I
         f5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCTwvoOkFjtGw94Tzk2z+JgJh7GsapYQB5zOutozzXQ=;
        b=Kb9t2hoJ92Ibx+BgH9ammluyJONE2oiPgHuPby1u4QkRX8pgwY77RRMCovxXVOHEnz
         iWV0wF9G+tPTOsdOGM/njsqMYYj2MMptTbw5bp2iJJtsiMAsm0M4QcRu/CQPgOm9+Oin
         jhg1g513Vfnig2D8x/NNoJhYxMKiIEoTJxI7w3m/hSakzyjJgz3xMaMoi3FhMNGrvodr
         DuAHr2i+NDwkkxnk0zprOh7Zp4C7OtG5+VCLxlb+wwoLvOtjP2DGl9A+eEetWMfD+J10
         SYHEpWtD1LOJy6+whcnH+KRzLOrq+tHdjiqRS4UaN7y95PbLOkLSuhwJfjyQQpSlH+6E
         HrrQ==
X-Gm-Message-State: AOAM530NV0TbETKQ0jezlOM9oJGR0Heg62dI5vHZBg2kBDjWKe9sKMOX
        IXysCR/8ewGykaxuQ+qLJS6YFq/1Ls8=
X-Google-Smtp-Source: ABdhPJyn/PQvwK3gWk0sKlvFLQGljjcpCVHJqRimyLWsqvENAjZxE5qN/TXKWCX0TSftaZtaNyyotg==
X-Received: by 2002:a05:6402:40f:: with SMTP id q15mr1444955edv.333.1635380585105;
        Wed, 27 Oct 2021 17:23:05 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id i22sm753801edu.93.2021.10.27.17.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 17:23:04 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/surface: aggregator: Make client device removal more generic
Date:   Thu, 28 Oct 2021 02:22:41 +0200
Message-Id: <20211028002243.1586083-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028002243.1586083-1-luzmaximilian@gmail.com>
References: <20211028002243.1586083-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are similar functions defined in the Aggregator
Registry and the controller core.

Make client device removal more generic and export it. We can then use
this function later on to remove client devices from device hubs as well
as the controller and avoid re-defining similar things.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/bus.c  | 24 ++++++++--------------
 drivers/platform/surface/aggregator/bus.h  |  3 ---
 drivers/platform/surface/aggregator/core.c |  3 ++-
 include/linux/surface_aggregator/device.h  |  9 ++++++++
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/surface/aggregator/bus.c b/drivers/platform/surface/aggregator/bus.c
index 0a40dd9c94ed..abbbb5b08b07 100644
--- a/drivers/platform/surface/aggregator/bus.c
+++ b/drivers/platform/surface/aggregator/bus.c
@@ -374,27 +374,19 @@ static int ssam_remove_device(struct device *dev, void *_data)
 }
 
 /**
- * ssam_controller_remove_clients() - Remove SSAM client devices registered as
- * direct children under the given controller.
- * @ctrl: The controller to remove all direct clients for.
+ * ssam_remove_clients() - Remove SSAM client devices registered as direct
+ * children under the given parent device.
+ * @dev: The (parent) device to remove all direct clients for.
  *
- * Remove all SSAM client devices registered as direct children under the
- * given controller. Note that this only accounts for direct children of the
- * controller device. This does not take care of any client devices where the
- * parent device has been manually set before calling ssam_device_add. Refer
- * to ssam_device_add()/ssam_device_remove() for more details on those cases.
- *
- * To avoid new devices being added in parallel to this call, the main
- * controller lock (not statelock) must be held during this (and if
- * necessary, any subsequent deinitialization) call.
+ * Remove all SSAM client devices registered as direct children under the given
+ * device. Note that this only accounts for direct children of the device.
+ * Refer to ssam_device_add()/ssam_device_remove() for more details.
  */
-void ssam_controller_remove_clients(struct ssam_controller *ctrl)
+void ssam_remove_clients(struct device *dev)
 {
-	struct device *dev;
-
-	dev = ssam_controller_device(ctrl);
 	device_for_each_child_reverse(dev, NULL, ssam_remove_device);
 }
+EXPORT_SYMBOL_GPL(ssam_remove_clients);
 
 /**
  * ssam_bus_register() - Register and set-up the SSAM client device bus.
diff --git a/drivers/platform/surface/aggregator/bus.h b/drivers/platform/surface/aggregator/bus.h
index ed032c2cbdb2..6964ee84e79c 100644
--- a/drivers/platform/surface/aggregator/bus.h
+++ b/drivers/platform/surface/aggregator/bus.h
@@ -12,14 +12,11 @@
 
 #ifdef CONFIG_SURFACE_AGGREGATOR_BUS
 
-void ssam_controller_remove_clients(struct ssam_controller *ctrl);
-
 int ssam_bus_register(void);
 void ssam_bus_unregister(void);
 
 #else /* CONFIG_SURFACE_AGGREGATOR_BUS */
 
-static inline void ssam_controller_remove_clients(struct ssam_controller *ctrl) {}
 static inline int ssam_bus_register(void) { return 0; }
 static inline void ssam_bus_unregister(void) {}
 
diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index c61bbeeec2df..d384d36098c2 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -22,6 +22,7 @@
 #include <linux/sysfs.h>
 
 #include <linux/surface_aggregator/controller.h>
+#include <linux/surface_aggregator/device.h>
 
 #include "bus.h"
 #include "controller.h"
@@ -735,7 +736,7 @@ static void ssam_serial_hub_remove(struct serdev_device *serdev)
 	ssam_controller_lock(ctrl);
 
 	/* Remove all client devices. */
-	ssam_controller_remove_clients(ctrl);
+	ssam_remove_clients(&serdev->dev);
 
 	/* Act as if suspending to silence events. */
 	status = ssam_ctrl_notif_display_off(ctrl);
diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index f636c5310321..cc257097eb05 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -319,6 +319,15 @@ void ssam_device_driver_unregister(struct ssam_device_driver *d);
 		      ssam_device_driver_unregister)
 
 
+/* -- Helpers for controller and hub devices. ------------------------------- */
+
+#ifdef CONFIG_SURFACE_AGGREGATOR_BUS
+void ssam_remove_clients(struct device *dev);
+#else /* CONFIG_SURFACE_AGGREGATOR_BUS */
+static inline void ssam_remove_clients(struct device *dev) {}
+#endif /* CONFIG_SURFACE_AGGREGATOR_BUS */
+
+
 /* -- Helpers for client-device requests. ----------------------------------- */
 
 /**
-- 
2.33.1

