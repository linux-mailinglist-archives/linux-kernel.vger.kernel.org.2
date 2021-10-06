Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B7942474E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbhJFTm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239701AbhJFTmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:42:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AE6C06176D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 12:39:01 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g184so3397795pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t6u5XUeO4sYz+ulCltZUbaQi7CS38xRTEpJdyBtoFfw=;
        b=gHqf7KGdvf03LAMkafGrTL614YdgYSNADvD6jKNuZzRP97v1aHA/q7T8kd0ZLXubtt
         Ws477MsfBS64eilUdOtGKUXmrXQRY6jgL2SVDJsn2QocOVzGtZubAXOWQygBkSsLMsTW
         0w/0jU/+JjkKqJigRw32QZGjanhAVzqbHsR8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t6u5XUeO4sYz+ulCltZUbaQi7CS38xRTEpJdyBtoFfw=;
        b=0MQ/B2jYGcknxtdMlyR9gilFhhn3QZpoQstrZVsDDLs5xwDVbtCc2S8A9eVOlbbGSo
         ruvhm/e/u4u91UhhfWOC6Y9at9/DguS/bF4emsjqOr/r/qI6791a47CGMTI2PYaGDGQa
         SPNQBsBafAejrA6sinT4NMpv8JTxhdMd/CcbAP5+J1WeFdyAb4RQ//Pt+5e2aobCygyb
         YrGZxoTjBLNDqERoXfwUbfCjMSKdGzrwu++PI2lXmCIiTiCZ6gr3GbSqm36S/bmZDLaD
         7Y/X2NgA31XZxHV8tNsgjnHHExFZmuXtec3yMaQ3AZGDMxh+6QnGbVMh9f7mGp/hlHhf
         Sn0g==
X-Gm-Message-State: AOAM530VAoXR1mgStlGcPx5IkQvNZu/Rv+5as5mr2HIjZr1iRxFx9WOi
        sNif9ekSrz4CsgVDmIrgaahJZA==
X-Google-Smtp-Source: ABdhPJxRuwBTqdA6VB0UEYqKM/3I58rwst1cfSUQ17xYRbRYYPzZEwkK8K8qUlPCE155WqL7hoIqqA==
X-Received: by 2002:a65:620d:: with SMTP id d13mr485007pgv.36.1633549140541;
        Wed, 06 Oct 2021 12:39:00 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:d412:c5eb:4aca:4738])
        by smtp.gmail.com with ESMTPSA id o14sm22011296pfh.84.2021.10.06.12.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:39:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v2 32/34] component: Get rid of drm_of_component_probe()
Date:   Wed,  6 Oct 2021 12:38:17 -0700
Message-Id: <20211006193819.2654854-33-swboyd@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20211006193819.2654854-1-swboyd@chromium.org>
References: <20211006193819.2654854-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There aren't any users anymore so drop it.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/drm_of.c | 87 +++++++++-------------------------------
 include/drm/drm_of.h     | 12 ------
 2 files changed, 20 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 58db65ad2770..78fe2b809872 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -99,18 +99,30 @@ void drm_of_component_match_add(struct device *master,
 }
 EXPORT_SYMBOL_GPL(drm_of_component_match_add);
 
-static int _drm_of_component_probe(struct device *dev,
-			   int (*compare_of)(struct device *, void *),
-			   struct component_match **matchptr)
+/**
+ * drm_of_aggregate_probe - Generic probe function for a component based aggregate host
+ * @dev: device containing the OF node
+ * @compare_of: compare function used for matching components
+ * @adrv: aggregate driver to be used
+ *
+ * Parse the platform device OF node and bind all the components associated
+ * with the aggregate device. Interface ports are added before the encoders in
+ * order to satisfy their .bind_component requirements
+ * See Documentation/devicetree/bindings/graph.txt for the bindings.
+ *
+ * Returns zero if successful, or one of the standard error codes if it fails.
+ */
+static int drm_of_aggregate_probe(struct device *dev,
+				  int (*compare_of)(struct device *, void *),
+				  struct aggregate_driver *adrv)
 {
 	struct device_node *ep, *port, *remote;
+	struct component_match *match = NULL;
 	int i;
 
 	if (!dev->of_node)
 		return -EINVAL;
 
-	*matchptr = NULL;
-
 	/*
 	 * Bind the crtc's ports first, so that drm_of_find_possible_crtcs()
 	 * called from encoder's .bind callbacks works as expected
@@ -121,7 +133,7 @@ static int _drm_of_component_probe(struct device *dev,
 			break;
 
 		if (of_device_is_available(port->parent))
-			drm_of_component_match_add(dev, matchptr, compare_of,
+			drm_of_component_match_add(dev, &match, compare_of,
 						   port);
 
 		of_node_put(port);
@@ -132,7 +144,7 @@ static int _drm_of_component_probe(struct device *dev,
 		return -ENODEV;
 	}
 
-	if (!*matchptr) {
+	if (!match) {
 		dev_err(dev, "no available port\n");
 		return -ENODEV;
 	}
@@ -162,72 +174,13 @@ static int _drm_of_component_probe(struct device *dev,
 				continue;
 			}
 
-			drm_of_component_match_add(dev, matchptr, compare_of,
+			drm_of_component_match_add(dev, &match, compare_of,
 						   remote);
 			of_node_put(remote);
 		}
 		of_node_put(port);
 	}
 
-	return 0;
-}
-
-/**
- * drm_of_component_probe - Generic probe function for a component based master
- * @dev: master device containing the OF node
- * @compare_of: compare function used for matching components
- * @m_ops: component master ops to be used
- *
- * Parse the platform device OF node and bind all the components associated
- * with the master. Interface ports are added before the encoders in order to
- * satisfy their .bind requirements
- * See Documentation/devicetree/bindings/graph.txt for the bindings.
- *
- * Deprecated: Use drm_of_aggregate_probe() instead.
- *
- * Returns zero if successful, or one of the standard error codes if it fails.
- */
-static int drm_of_component_probe(struct device *dev,
-			   int (*compare_of)(struct device *, void *),
-			   const struct component_master_ops *m_ops)
-{
-
-	struct component_match *match;
-	int ret;
-
-	ret = _drm_of_component_probe(dev, compare_of, &match);
-	if (ret)
-		return ret;
-
-	return component_master_add_with_match(dev, m_ops, match);
-}
-EXPORT_SYMBOL(drm_of_component_probe);
-
-
-/**
- * drm_of_aggregate_probe - Generic probe function for a component based aggregate host
- * @dev: device containing the OF node
- * @compare_of: compare function used for matching components
- * @adrv: aggregate driver to be used
- *
- * Parse the platform device OF node and bind all the components associated
- * with the aggregate device. Interface ports are added before the encoders in
- * order to satisfy their .bind_component requirements
- * See Documentation/devicetree/bindings/graph.txt for the bindings.
- *
- * Returns zero if successful, or one of the standard error codes if it fails.
- */
-static int drm_of_aggregate_probe(struct device *dev,
-			   int (*compare_of)(struct device *, void *),
-			   struct aggregate_driver *adrv)
-{
-	struct component_match *match;
-	int ret;
-
-	ret = _drm_of_component_probe(dev, compare_of, &match);
-	if (ret)
-		return ret;
-
 	return component_aggregate_register(dev, adrv, match);
 }
 EXPORT_SYMBOL(drm_of_aggregate_probe);
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index c3ec9b14df48..447568992294 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -7,7 +7,6 @@
 #include <drm/drm_bridge.h>
 #endif
 
-struct component_master_ops;
 struct component_match;
 struct device;
 struct drm_device;
@@ -37,9 +36,6 @@ void drm_of_component_match_add(struct device *master,
 				struct component_match **matchptr,
 				int (*compare)(struct device *, void *),
 				struct device_node *node);
-int drm_of_component_probe(struct device *dev,
-			   int (*compare_of)(struct device *, void *),
-			   const struct component_master_ops *m_ops);
 int drm_of_aggregate_probe(struct device *dev,
 			   int (*compare_of)(struct device *, void *),
 			   struct aggregate_driver *adrv);
@@ -73,14 +69,6 @@ drm_of_component_match_add(struct device *master,
 {
 }
 
-static inline int
-drm_of_component_probe(struct device *dev,
-		       int (*compare_of)(struct device *, void *),
-		       const struct component_master_ops *m_ops)
-{
-	return -EINVAL;
-}
-
 static inline int
 drm_of_aggregate_probe(struct device *dev,
 		       int (*compare_of)(struct device *, void *),
-- 
https://chromeos.dev

