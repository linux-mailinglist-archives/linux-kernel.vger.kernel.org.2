Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FB743A899
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 02:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhJZADd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 20:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbhJZADN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 20:03:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE05CC061220
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:00:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 75so12301547pga.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0msA0xs8lhZ+Yu7wuGuAFKr0B67vxNoH5+pgXRqbiBg=;
        b=fINIymHE/3VXwQ4Cv4u1C8mWtt0WD7C3a+GM+AqVyvsqSuzRyN05Ov13w93KcIJ7YC
         uGfRG9WMH6ZmoC65whT9OOrVWakix/A3gm95LjHyVCeUQy6Bx/yGc6+TJwkSsF0zbtdp
         n/lFvtAUzzyUf1tY0ikLKeweCG2gHITgrOa/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0msA0xs8lhZ+Yu7wuGuAFKr0B67vxNoH5+pgXRqbiBg=;
        b=qDqDdS9CgSwlvI9KHBVPsvDruA+6eDrpbchajz4O0AV0KtNiCaWU3DkULLvE2RX/Qc
         N9o+/mmUtFij2p/5249nLm4l3tL044SS1n198XhZylY0seDxpqb+EYzAs0sIAbz3qFFm
         K3xNR06wy/NsE9uq0Fju0tdEbZwXB0tdN2Ed/KWzza3vxRdjPORNdEcMAAEjHFQGKQqT
         nCXnRi2iXevjrpzYeoWee8ZMDUpJfFPk/kREC4ajcl8UY9WIn754iWtV47zOHrrlhwEv
         yOIH7zqQDDBVVLIP9Bm4BjG+LDIRTKna/f6FHu4qr+DQZpAjx0X92RGkBg7q0O/2x/Qr
         MzGg==
X-Gm-Message-State: AOAM5335OGARlBfqBvVKoJsMJvKtILXwSTgenBDxlU8JfBcXpPuT3sD3
        TqQJN025CDqavuhRkosCHBgYXA==
X-Google-Smtp-Source: ABdhPJzqgDUOkGmwmKvQRwRgZjpUZ3O0xIL9NVI95wISsKuBIjI/vJP1pFC34pBwEaJ2WMB7uOBRsw==
X-Received: by 2002:a05:6a00:198b:b0:47b:ac2d:68f4 with SMTP id d11-20020a056a00198b00b0047bac2d68f4mr21337865pfl.1.1635206450134;
        Mon, 25 Oct 2021 17:00:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:f5e3:5eb1:d5ee:6893])
        by smtp.gmail.com with ESMTPSA id b7sm9900747pfm.28.2021.10.25.17.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 17:00:49 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v3 04/34] component: Move struct aggregate_device out to header file
Date:   Mon, 25 Oct 2021 17:00:14 -0700
Message-Id: <20211026000044.885195-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211026000044.885195-1-swboyd@chromium.org>
References: <20211026000044.885195-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows aggregate driver writers to use the device passed to their
probe/remove/shutdown functions properly instead of treating it as an
opaque pointer.

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/component.c  | 15 ---------------
 include/linux/component.h | 19 ++++++++++++++++---
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 3d9d2f94df28..997b17053ecf 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -57,21 +57,6 @@ struct component_match {
 	struct component_match_array *compare;
 };
 
-struct aggregate_device {
-	const struct component_master_ops *ops;
-	struct device *parent;
-	struct device dev;
-	struct component_match *match;
-	struct aggregate_driver *adrv;
-
-	int id;
-};
-
-static inline struct aggregate_device *to_aggregate_device(struct device *d)
-{
-	return container_of(d, struct aggregate_device, dev);
-}
-
 struct component {
 	struct list_head node;
 	struct aggregate_device *adev;
diff --git a/include/linux/component.h b/include/linux/component.h
index 95d1b23ede8a..e99cf8e910f0 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -5,6 +5,8 @@
 #include <linux/stddef.h>
 #include <linux/device.h>
 
+struct component_match;
+
 /**
  * struct component_ops - callbacks for component drivers
  *
@@ -39,8 +41,6 @@ void component_del(struct device *, const struct component_ops *);
 int component_bind_all(struct device *master, void *master_data);
 void component_unbind_all(struct device *master, void *master_data);
 
-struct aggregate_device;
-
 /**
  * struct component_master_ops - callback for the aggregate driver
  *
@@ -80,7 +80,20 @@ struct component_master_ops {
 	void (*unbind)(struct device *master);
 };
 
-struct component_match;
+struct aggregate_device {
+	const struct component_master_ops *ops;
+	struct device *parent;
+	struct device dev;
+	struct component_match *match;
+	struct aggregate_driver *adrv;
+
+	int id;
+};
+
+static inline struct aggregate_device *to_aggregate_device(struct device *d)
+{
+	return container_of(d, struct aggregate_device, dev);
+}
 
 /**
  * struct aggregate_driver - Aggregate driver (made up of other drivers)
-- 
https://chromeos.dev

