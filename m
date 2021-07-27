Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92EB3D6E07
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 07:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhG0FYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 01:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbhG0FYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 01:24:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A650C061798
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 22:24:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c16so8890851plh.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 22:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bReu9/QiDlixJ/zUrMpF+Tdh8nXeZ2MTWODegeEltE=;
        b=sguymNCUwJvY2Vm/IznufncDBF3sjETSlEYR+vj6oJ+UM67MLBhMqFWHk4mxJ2PsSK
         5b/s7cah1FqzNg7kC19ikh307/G6HXGV6vMozb6gQ9Ivrinas5A5uGFE+gYR4y+sp8CP
         ooRPiSyF+J/ZHTpxuhxzjHDtCtY6Ig6pMCAsZA77tabFVO9u5bZFxnaz0DMP43yxUwc0
         BsPvx34ZEDZ4sn9IAvNFCcHSOMaiylMSvxoU6OsQqf64kvFfB6/cJZ/Wc6nZS8In21fJ
         Il3PEhvnL7Rv74YUjSqCJQU+77wRAcE34sRn7mrHM27QxxrNB5RZ77Q1OyKTtOWvxq+T
         z91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bReu9/QiDlixJ/zUrMpF+Tdh8nXeZ2MTWODegeEltE=;
        b=ZDH0yFRY7PIitLuqwVs4yhj/ePy8+pkfNs5o1p1Xsao9pxWU+5nBUlBLu+ecTDxz+g
         bH6hkY3gdL23rmkeXkhaj4f66X+w0xcRNTN1tcwaGXI/yzhuQhb+aToP67/ZOxgjaqK0
         IQpgw989eLI1O8fJnWE3nuzDCiMWQO84hRqldgls+zrNikZA4TcE3+ZWTKYXofd4OzFY
         PDQLhUrm9c2fWpSn9BamtyGiisnVVysULTQJgWJ6pE5tcGspJ129IHbLayUNIsP1hXMh
         pb4+RZjZIey7wBA67AWIWypljwxULQ/EHY9t3BTVwljdPL5ZDtzPJkU6nbUfyaHXIJP9
         kcDw==
X-Gm-Message-State: AOAM531KeYQQXxMMebUmxEridsnRpqixHawtLc5wMbl34ahH3DmXfxvG
        IHVX9ud0gVMjxLJHvJLPE2AR2g==
X-Google-Smtp-Source: ABdhPJy6I9aeK/9Rc3UXH2kpfbIZFK/LBxRNWnIHopkBRg9v94YtfYYGkl2/6Qm2SBVK8JZ5lLhYiQ==
X-Received: by 2002:a17:90a:86:: with SMTP id a6mr2447703pja.133.1627363473907;
        Mon, 26 Jul 2021 22:24:33 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id b9sm1857444pfm.124.2021.07.26.22.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 22:24:28 -0700 (PDT)
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
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH V4 5/5] virtio: Bind virtio device to device-tree node
Date:   Tue, 27 Jul 2021 10:53:52 +0530
Message-Id: <94c12705602929968477aaf27e02439eb7a7f253.1627362340.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627362340.git.viresh.kumar@linaro.org>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
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

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/virtio/virtio.c | 57 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..5f80786c2aa2 100644
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
 
@@ -319,6 +323,43 @@ void unregister_virtio_driver(struct virtio_driver *driver)
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_driver);
 
+static int virtio_device_of_init(struct virtio_device *dev)
+{
+	struct device_node *np, *pnode = dev_of_node(dev->dev.parent);
+	char compat[] = "virtio,deviceXXXXXXXX";
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
+	ret = snprintf(compat, sizeof(compat), "virtio,device%x", dev->id.device);
+	BUG_ON(ret >= sizeof(compat));
+
+	if (!of_device_is_compatible(np, compat)) {
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
@@ -343,6 +384,10 @@ int register_virtio_device(struct virtio_device *dev)
 	dev->index = err;
 	dev_set_name(&dev->dev, "virtio%u", dev->index);
 
+	err = virtio_device_of_init(dev);
+	if (err)
+		goto out_ida_remove;
+
 	spin_lock_init(&dev->config_lock);
 	dev->config_enabled = false;
 	dev->config_change_pending = false;
@@ -362,10 +407,16 @@ int register_virtio_device(struct virtio_device *dev)
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

