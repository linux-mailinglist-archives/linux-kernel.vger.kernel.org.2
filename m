Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6044D434B55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhJTMmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhJTMmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:42:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1703FC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:39:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o24so11258914wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNc+IrE+4SO33Ds9wqRQl0pqGwosqKnED8f9gFIZ4qQ=;
        b=sbcmiTisBHNPWCJCNj0ZEFL6T6yazKdDkenqxBK+vGcmvMPGyKGuEDdRczr5hN49G8
         iTuJGRGgV4mNoOOi9jvAhQ8muFgKizP3rPwNBDanoSJdLWjNybTypdX8ZvHTwi2QZWND
         hWDU88N5I1VvHg52AWu0k1q4RT+AsTnyKLY2s+IIVt0F8H338KChTYxU9eWHqH2ggL5f
         xtYpNiGUccgoVVFcAgPktyYBIarMDEVLshmCVXI/eQbWpviuGsJSc+aRf5PSnyiXmF5l
         LQ/WGg9nZkhXqqAlNbOqNSxPDP4UVtALg21uGLl7mK3/O4wfT9AKTX3aG2yR3WU3TGn9
         R0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNc+IrE+4SO33Ds9wqRQl0pqGwosqKnED8f9gFIZ4qQ=;
        b=DJafYE/dbZKPuH5ElP4HdV7gxfykG0Odgn1ewtJqksmO+M9omlTDXGvXEzB7UpgENK
         bXO/YnReuqimqP9dsY4hFS/eOvzauLmLRK+ktdxGDbgiEcE7mUMAjgtONmjYkuX4Udfz
         CudiZ26QYofWGRIZxt+gf24qerKMlvTxenZbNiKfD3RzUS7Vv6RpTybXefIcVPcPR/u6
         dmr/j3sPt9prLp2XWr4HCKyUwkD6IorXN6WyFAuCf0YH7p/eglEsK4Ki65WTklOWBAwe
         JmHZpeK537S3/Hc0BuXEL2FpiQqAnwMlKbERoiABRWzVn6NmqFTShFSGeVIJ1NNhudv2
         nGcw==
X-Gm-Message-State: AOAM53116Dcem0veUIg/jPK/Fnck2ekgj7lq+WzJs5Sq9yAZSS/rZcnO
        VmHsbUCV25suPpu5ZmKUr/IMkw==
X-Google-Smtp-Source: ABdhPJyfZenXNQXewRr9MrYXS1oHuTUvJJDaaL3WIBEzrGcuL8a1CKoWn41lbZIItQcqXIisJs5d9g==
X-Received: by 2002:a5d:58ca:: with SMTP id o10mr52164130wrf.358.1634733591429;
        Wed, 20 Oct 2021 05:39:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:d31f:1512:8915:e439])
        by smtp.gmail.com with ESMTPSA id b19sm5342680wmj.9.2021.10.20.05.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:39:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org
Cc:     martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 1/6] drm/bridge: display-connector: implement bus fmts callbacks
Date:   Wed, 20 Oct 2021 14:39:42 +0200
Message-Id: <20211020123947.2585572-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020123947.2585572-1-narmstrong@baylibre.com>
References: <20211020123947.2585572-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5053; h=from:subject; bh=ZaTrpeiEqqaaclH17vTiRNAhyUGCyF81N0KiKn9lflo=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhcA34Cdfjx5c+XeC3VOSgmFhN4Wi6IIA5tNLXd6l9 J94s5laJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYXAN+AAKCRB33NvayMhJ0dRoEA DDbIoGBmTMHXzmDKf2phe1k3efBjyW65XCjnPlwIcdCalhqUuzI7/uGmbSAg2HlHb1wY50I8tdblcb klAd7dzufsoPB0EnPN0mtiR3SBlPkcluR9aC2M7lJHEvo4kIk5OfLiM76yNxdvUOxo2N3rccsxusnm ZZ8m8HOpTcbXjE/XYg450Drq6wLQFf4N/dNM60JkpRyM2fduZNxjuloL564R3rnOPbM/cB8o2JkYQG 4xU4FdnQwfpxgNEPnE1pe3V8LFl+8yfBx0/4igtnbTFNwOukgtGUWjvY7GkeiDaTMaMKRLDJ/QAiXr cRsJ0tmF+wm3ayo+6dTpjCctypEB+SvUOoenlfvCJf6Jw86j42g2fkozV3xGMX2hsh0F/JrMkAbJqM mXkqUAO+nzA9Y4+sWHDRbTtqcqT/zLzrGC7oSF3wBjYk2TFTF0iSPnG0/t6gDLehk6N/28RzT3xhZB jC48h9zKJlTSwFhOrFK+37x+aZOdpuu+kABUJt6gAV/lrPULKdPa0iR6Oyw83JQqNJFnT/rB7geaX7 Vgh8Pmmfz1G0Ap1G4kz9ZhEhAPORqsHwSXHaLkNut0fkWD0N6BSLRLUrbpm4TR2eGFkqxpSZ18nMA4 VzlVm0oa2xAt0u4jKLUPBGhNj9B0vQ2HDnb04M9r5fFi9xB7m8yu/ILIwtuQ==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this bridge is tied to the connector, it acts like a passthrough,
so concerning the output & input bus formats, either pass the bus formats from the
previous bridge or return fallback data like done in the bridge function:
drm_atomic_bridge_chain_select_bus_fmts() & select_bus_fmt_recursive.

This permits avoiding skipping the negociation if the remaining bridge chain has
all the bits in place.

Without this bus fmt negociation breaks on drm/meson HDMI pipeline when attaching
dw-hdmi with DRM_BRIDGE_ATTACH_NO_CONNECTOR, because the last bridge of the
display-connector doesn't implement buf fmt callbacks and MEDIA_BUS_FMT_FIXED
is used leading to select an unsupported default bus format from dw-hdmi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/bridge/display-connector.c | 86 ++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index 847a0dce7f1d..d24f5b90feab 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_edid.h>
 
@@ -87,10 +88,95 @@ static struct edid *display_connector_get_edid(struct drm_bridge *bridge,
 	return drm_get_edid(connector, conn->bridge.ddc);
 }
 
+/*
+ * Since this bridge is tied to the connector, it acts like a passthrough,
+ * so concerning the output bus formats, either pass the bus formats from the
+ * previous bridge or return fallback data like done in the bridge function:
+ * drm_atomic_bridge_chain_select_bus_fmts().
+ * This supports negotiation if the bridge chain has all bits in place.
+ */
+static u32 *display_connector_get_output_bus_fmts(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state,
+					unsigned int *num_output_fmts)
+{
+	struct drm_bridge *prev_bridge = drm_bridge_get_prev_bridge(bridge);
+	struct drm_bridge_state *prev_bridge_state;
+
+	if (!prev_bridge || !prev_bridge->funcs->atomic_get_output_bus_fmts) {
+		struct drm_connector *conn = conn_state->connector;
+		u32 *out_bus_fmts;
+
+		*num_output_fmts = 1;
+		out_bus_fmts = kmalloc(sizeof(*out_bus_fmts), GFP_KERNEL);
+		if (!out_bus_fmts)
+			return NULL;
+
+		if (conn->display_info.num_bus_formats &&
+		    conn->display_info.bus_formats)
+			out_bus_fmts[0] = conn->display_info.bus_formats[0];
+		else
+			out_bus_fmts[0] = MEDIA_BUS_FMT_FIXED;
+
+		return out_bus_fmts;
+	}
+
+	prev_bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state,
+							    prev_bridge);
+
+	return prev_bridge->funcs->atomic_get_output_bus_fmts(prev_bridge, prev_bridge_state,
+							      crtc_state, conn_state,
+							      num_output_fmts);
+}
+
+/*
+ * Since this bridge is tied to the connector, it acts like a passthrough,
+ * so concerning the input bus formats, either pass the bus formats from the
+ * previous bridge or MEDIA_BUS_FMT_FIXED (like select_bus_fmt_recursive())
+ * when atomic_get_input_bus_fmts is not supported.
+ * This supports negotiation if the bridge chain has all bits in place.
+ */
+static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state,
+					u32 output_fmt,
+					unsigned int *num_input_fmts)
+{
+	struct drm_bridge *prev_bridge = drm_bridge_get_prev_bridge(bridge);
+	struct drm_bridge_state *prev_bridge_state;
+
+	if (!prev_bridge || !prev_bridge->funcs->atomic_get_input_bus_fmts) {
+		u32 *in_bus_fmts;
+
+		*num_input_fmts = 1;
+		in_bus_fmts = kmalloc(sizeof(*in_bus_fmts), GFP_KERNEL);
+		if (!in_bus_fmts)
+			return NULL;
+
+		in_bus_fmts[0] = MEDIA_BUS_FMT_FIXED;
+
+		return in_bus_fmts;
+	}
+
+	prev_bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state,
+							    prev_bridge);
+
+	return prev_bridge->funcs->atomic_get_input_bus_fmts(prev_bridge, prev_bridge_state,
+							     crtc_state, conn_state, output_fmt,
+							     num_input_fmts);
+}
+
 static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.attach = display_connector_attach,
 	.detect = display_connector_detect,
 	.get_edid = display_connector_get_edid,
+	.atomic_get_output_bus_fmts = display_connector_get_output_bus_fmts,
+	.atomic_get_input_bus_fmts = display_connector_get_input_bus_fmts,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
 };
 
 static irqreturn_t display_connector_hpd_irq(int irq, void *arg)
-- 
2.25.1

