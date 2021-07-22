Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88CB3D2169
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhGVJRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhGVJQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:16:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09DBC0617A1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:57:03 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x13-20020a17090a46cdb0290175cf22899cso4738493pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zqCgE34yKyEIxvuJmPDWwVVxXXN+22OEi5ENUvJ8OeA=;
        b=oNd9MyfvR0nYVTjrW1t93WrZmnXFXN7AAJDIlU2Ob6ZsJ6AU3uISvEzFldVwS/MN9y
         T+lAXUsG6wseU6YsEN069LVRTMg2F+luTvrzDcO6ABMJee/zl4OVlVUjIxOw3AKPXCVK
         7aV8DcMDgsVAgTuP+HGVtzfa1qTbErhmDrgwIiELLIroBKiMtJlnjJYkcQBlQ3wbCB9x
         9SCcjQZhUu+w+qSF1F5GNFSwX+ny4kwes2xQbcFfKHhotxKM/Nq9JMYodrgOaFYlb8Ik
         jERO1a1rAdxXN9yAyjOamz+lXVVqJkBTLTcEyh26w+pWL1N1SH/IbLS3ggA6HRd6N7WI
         fTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqCgE34yKyEIxvuJmPDWwVVxXXN+22OEi5ENUvJ8OeA=;
        b=S1dDesGUI9a6hgRiZ6PNxEPe8+Ba5ANxR3rII/dd6Ds0nNn8yhg8wJaBsxGmJBBIPQ
         wlCXag83H/9e7QZqC/6f0sD+OYH+oSwXpUwEcJBsFBRuKrKrU7j9UkAgt3NK0kyZJGOt
         8iy4L/4JT5Vd04DPsaifkaj5fqrJ4LJIlr40VFnSanz1D1PNysy0xMdhtk7uQyvzZJL5
         F/zd+YU7Z263hHLjguWd96N6NWIvwwx6xbQHVoiFgv1HaL9+ZyZn+XDnQnBGRssLxUBf
         +/EMPNZgaLaEUlpir0a2s1MkHyLNJ1SdAqWg1GrPLESR2O7ViLDWLKvwJS0VN3m58Cse
         RkGA==
X-Gm-Message-State: AOAM532RQMozu/kSTDq6XO+glecOh8T+ZGrlS689yURQN/2Xu8e5Cq9+
        Zbh/CyCu0wDuonogLFjxT7Zxkg==
X-Google-Smtp-Source: ABdhPJxt9prk84Rhz1qfl8PCP3CdBdMFHhzAR/AnhH9ZFn8x+XmZlhtH9HWAY7tkUHoyMCqWqiy6gw==
X-Received: by 2002:a17:90a:658c:: with SMTP id k12mr8021272pjj.167.1626947823491;
        Thu, 22 Jul 2021 02:57:03 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id ay2sm2400955pjb.14.2021.07.22.02.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 02:57:03 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH V2 5/5] virtio: Bind virtio device to device-tree node
Date:   Thu, 22 Jul 2021 15:26:43 +0530
Message-Id: <026ad5f274d64d46590623f9f3a04b8abfbe62d7.1626947324.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626947324.git.viresh.kumar@linaro.org>
References: <cover.1626947324.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bind the virtio devices with their of_node. This will help users of the
virtio devices to mention their dependencies on the device in the DT
itself. Like GPIO pin users can use the phandle of the device node, or
the node may contain more subnodes to add i2c or spi eeproms and other
users.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/virtio/virtio.c | 67 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..87bee5b966c3 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -4,6 +4,7 @@
 #include <linux/virtio_config.h>
 #include <linux/module.h>
 #include <linux/idr.h>
+#include <linux/of.h>
 #include <uapi/linux/virtio_ids.h>
 
 /* Unique numbering for virtio devices. */
@@ -292,6 +293,9 @@ static int virtio_dev_remove(struct device *_d)
 
 	/* Acknowledge the device's existence again. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
+
+	of_node_put(dev->dev.of_node);
+
 	return 0;
 }
 
@@ -319,6 +323,53 @@ void unregister_virtio_driver(struct virtio_driver *driver)
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_driver);
 
+/* Virtio device compatibles and IDs */
+static const struct of_device_id of_virtio_devices[] = {
+	{ .compatible = "virtio,22", .data = (void *)VIRTIO_ID_I2C_ADAPTER },
+	{ .compatible = "virtio,29", .data = (void *)VIRTIO_ID_GPIO },
+	{ }
+};
+
+static int virtio_device_of_init(struct virtio_device *dev)
+{
+	struct device_node *np, *pnode = dev->dev.parent->of_node;
+	const struct of_device_id *match;
+	int ret, count;
+
+	if (!pnode)
+		return 0;
+
+	count = of_get_available_child_count(pnode);
+	if (!count)
+		return 0;
+
+	/* There can be only 1 child node */
+	if (WARN_ON(count > 1))
+		return -EINVAL;
+
+	np = of_get_next_available_child(pnode, NULL);
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	match = of_match_node(of_virtio_devices, np);
+	if (!match) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if ((unsigned long)match->data != dev->id.device) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dev->dev.of_node = np;
+	return 0;
+
+out:
+	of_node_put(np);
+	return ret;
+}
+
 /**
  * register_virtio_device - register virtio device
  * @dev        : virtio device to be registered
@@ -343,6 +394,10 @@ int register_virtio_device(struct virtio_device *dev)
 	dev->index = err;
 	dev_set_name(&dev->dev, "virtio%u", dev->index);
 
+	err = virtio_device_of_init(dev);
+	if (err)
+		goto out_ida_remove;
+
 	spin_lock_init(&dev->config_lock);
 	dev->config_enabled = false;
 	dev->config_change_pending = false;
@@ -362,10 +417,16 @@ int register_virtio_device(struct virtio_device *dev)
 	 */
 	err = device_add(&dev->dev);
 	if (err)
-		ida_simple_remove(&virtio_index_ida, dev->index);
+		goto out_of_node_put;
+
+	return 0;
+
+out_of_node_put:
+	of_node_put(dev->dev.of_node);
+out_ida_remove:
+	ida_simple_remove(&virtio_index_ida, dev->index);
 out:
-	if (err)
-		virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
 	return err;
 }
 EXPORT_SYMBOL_GPL(register_virtio_device);
-- 
2.31.1.272.g89b43f80a514

