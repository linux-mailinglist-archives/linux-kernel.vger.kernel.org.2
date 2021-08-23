Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17633F46E0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbhHWIuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:50:11 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:53497 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235690AbhHWIsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:48:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C5059580C63;
        Mon, 23 Aug 2021 04:47:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 23 Aug 2021 04:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ozNmHqW4eot36
        610HLCN2jfvbbHmClu9J/C1QfHxiwE=; b=QRq3BK7UhXm0Es6GAPhxJmYDdi94+
        6eFRXrxY6i70AN573dVCjPZzsdAWVH81yxrskIik2oiC25naFbbZiPGFKwMtsWgv
        lGCc7ojQJpjGbnWwGp+SHO6yUNj5ocbhEL+0ePq3EFIYmU718SmwNPS5V8NqwlVj
        L5Q0djxOharweusZhOVCUY4yZDNbY4bWy30aV3hfl8w0yh5w+zB62zWXbi6ZRcvh
        2vK1pdxy/bnSOoDB6pOHIDWfQ76ijKaL08C2EvWx+F6y3xR5MCDNxnCC1tZZG1Iz
        nCv2LcM8KrtPzn7+4KrkSugD2qLFmXgbeG0cxE0gVJs0m9DGCbL+6UxHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ozNmHqW4eot36610HLCN2jfvbbHmClu9J/C1QfHxiwE=; b=Lbn6KVs9
        BpFPkI3IBzJOVbxbbDKeF6mZhldG+i6mwhKG1VYEs52bWvUFRreUMrykg4CTQJJ+
        Nv4Z+XRyJUT5O1Lyhwyeptvm417dYESjj+wbicdpPBT5YP/2szL75yig9LuQzvGm
        vsJhbU2M5NrPFnfc4DiibDE3eIQzfAUONYdHRw+uYTllOKFKQxIK5Mz2bNYUngTo
        ogRGCiRWR47RzXiQ6O7NK7L65BQdIzibrNvaBOY4fsUAlRpWU1tru2umGwidUEqI
        LFEKWMswVJZihck/fqYkcF38NKiJs5G6MRSlQU8OYlIwc/CZNsDwUtWQJp7g33FA
        IZjfhHAw5D49ng==
X-ME-Sender: <xms:q2AjYafVnWAd_BzM8QWW9M1zbIMFuL73o9ObKxyUvJEwW4TwS2kQ5Q>
    <xme:q2AjYUMeEgHwIuC_1Czd2RX1PXKVoGdWoJBShOw1O0_DWDe6hedc5reGN8N3AhX2S
    0HSRxhnz-N4x2kR0O0>
X-ME-Received: <xmr:q2AjYbhsC7PzNXcn2l-2vA9aF3mBAjiYwnuDAmP1rkibeKyLwzJBcZYzVjyBo2XGDRNJI93sLe1zj3sqgSQotW1pgzrwiyAbT0ve>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddthedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:q2AjYX8GDo6SHLA6cmJUuWyzLTXes6NEdNGZDWPn20apdH3-nFxuxA>
    <xmx:q2AjYWuiJnGXVvfRjS8RQ4eeFWttzZDYL-Qsi5N9xflgL89bV9WFnA>
    <xmx:q2AjYeHl6ei467sf_HXUrn7vitBZlr4eSqiLgpswsvv4I1XawMYi8Q>
    <xmx:q2AjYbOIYzVKLqyMZuzoKahG5vHeP7ZuaitAdW-gchpRZyCoNf6vgg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Aug 2021 04:47:39 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jonas Karlman <jonas@kwiboo.se>, Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 3/8] drm/mipi-dsi: Create devm device registration
Date:   Mon, 23 Aug 2021 10:47:18 +0200
Message-Id: <20210823084723.1493908-4-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210823084723.1493908-1-maxime@cerno.tech>
References: <20210823084723.1493908-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices that take their data through the MIPI-DSI bus but are controlled
through a secondary bus like I2C have to register a secondary device on
the MIPI-DSI bus through the mipi_dsi_device_register_full() function.

At removal or when an error occurs, that device needs to be removed
through a call to mipi_dsi_device_unregister().

Let's create a device-managed variant of the registration function that
will automatically unregister the device at unbind.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 46 ++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  3 +++
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 5dd475e82995..ddf67463eaa1 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -246,6 +246,52 @@ void mipi_dsi_device_unregister(struct mipi_dsi_device *dsi)
 }
 EXPORT_SYMBOL(mipi_dsi_device_unregister);
 
+static void devm_mipi_dsi_device_unregister(void *arg)
+{
+	struct mipi_dsi_device *dsi = arg;
+
+	mipi_dsi_device_unregister(dsi);
+}
+
+/**
+ * devm_mipi_dsi_device_register_full - create a managed MIPI DSI device
+ * @dev: device to tie the MIPI-DSI device lifetime to
+ * @host: DSI host to which this device is connected
+ * @info: pointer to template containing DSI device information
+ *
+ * Create a MIPI DSI device by using the device information provided by
+ * mipi_dsi_device_info template
+ *
+ * This is the managed version of mipi_dsi_device_register_full() which
+ * automatically calls mipi_dsi_device_unregister() when @dev is
+ * unbound.
+ *
+ * Returns:
+ * A pointer to the newly created MIPI DSI device, or, a pointer encoded
+ * with an error
+ */
+struct mipi_dsi_device *
+devm_mipi_dsi_device_register_full(struct device *dev,
+				   struct mipi_dsi_host *host,
+				   const struct mipi_dsi_device_info *info)
+{
+	struct mipi_dsi_device *dsi;
+	int ret;
+
+	dsi = mipi_dsi_device_register_full(host, info);
+	if (IS_ERR(dsi))
+		return dsi;
+
+	ret = devm_add_action_or_reset(dev,
+				       devm_mipi_dsi_device_unregister,
+				       dsi);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return dsi;
+}
+EXPORT_SYMBOL_GPL(devm_mipi_dsi_device_register_full);
+
 static DEFINE_MUTEX(host_lock);
 static LIST_HEAD(host_list);
 
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index af7ba8071eb0..d0032e435e08 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -227,6 +227,9 @@ struct mipi_dsi_device *
 mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 			      const struct mipi_dsi_device_info *info);
 void mipi_dsi_device_unregister(struct mipi_dsi_device *dsi);
+struct mipi_dsi_device *
+devm_mipi_dsi_device_register_full(struct device *dev, struct mipi_dsi_host *host,
+				   const struct mipi_dsi_device_info *info);
 struct mipi_dsi_device *of_find_mipi_dsi_device_by_node(struct device_node *np);
 int mipi_dsi_attach(struct mipi_dsi_device *dsi);
 int mipi_dsi_detach(struct mipi_dsi_device *dsi);
-- 
2.31.1

