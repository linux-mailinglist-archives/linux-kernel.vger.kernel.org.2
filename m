Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585CD3C6EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhGMKxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbhGMKxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:53:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B71CC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 03:50:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n10so3720670plk.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 03:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=986/a+XL1T//36W39++oB7kOlKnW5eYSo8veeEHej88=;
        b=A3Q/umcFWAyQTFsjWu0zZq7yNfzjuO2F03oZsK9+N4gsF+Yto7uv9o93Cw5O4pU30l
         pmnq3CcUhEL/8tHaQIa+H/J2XMafGoTkXXFgigVY7VlwFGYDdhNmVsHwifGLRFlY6aBF
         MhZjtulyDf+CNgTgvShltXI9F0SdCXh8U3XJrTebKTTnwD7KJkBiCo6+0X64QFfMWTCP
         mpx5FAYJl1zlDjBE91cO4IM6oEEZBzb7Oh9yI6PC8BwncgDUhYF+CuBM/obQfTg5AqOc
         4JVUPbUiBB3xNewdVUjwYvLePcJIV3R0zNGOZDUrLFAn56bpGPhYm7ZQgbg+7xnbUY6v
         9gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=986/a+XL1T//36W39++oB7kOlKnW5eYSo8veeEHej88=;
        b=q15MVmmAs61IqmkIWPboSwxTQGwXOA7ygTwacXPjLziJQpgg1oJ+FAgpL6tHp7/DZR
         3F5p25b8bHE0B+C+iXo0GfEOLpUvcrmM84FHV3oN4CaMsx9f2W+8ANtq6xSWXPduHICt
         Yf4/eB2Qh8304spiHXInkmjYB2zODAuuWhm/TGP+02PPBN/r2xZpUEx9GYhIpV5gUAgJ
         ZiO0XVvNUvREjYUqVP6XkQwEerpU6EXrcnwNyonxJ2OFpdwS+hjfIUASPisRiW8EZI5+
         UlJVKdz9/7KOHRRq/2JtVqTEvKNbgq6ARU0o7iafgdKmdfHAtwVM1hnnItq2pjr9B6B1
         HcQw==
X-Gm-Message-State: AOAM531rB23asS6XGH3ZKkw1jV2QCHnsH/VjqPDsdLQz87xxVa2jpVao
        17B09zqkE8eVsfC8ee5Fz8FeLQ==
X-Google-Smtp-Source: ABdhPJzdSsYRQEKyCDDhOUHI4C1uEGpynqL8WeWZ0/WvMY/knBSGmDC2UG1V/5sgTs+RTyv3zKragQ==
X-Received: by 2002:a17:90a:1549:: with SMTP id y9mr3808382pja.211.1626173452771;
        Tue, 13 Jul 2021 03:50:52 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id y15sm8993842pfn.63.2021.07.13.03.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 03:50:52 -0700 (PDT)
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
Subject: [PATCH 2/5] virtio_mmio: Bind virtio device to device-tree node
Date:   Tue, 13 Jul 2021 16:20:31 +0530
Message-Id: <26ba6941fa01eee88c99ecdd611d235c22bd6e3c.1626173013.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626173013.git.viresh.kumar@linaro.org>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bind the virtio device with its device protocol's sub-node. This will
help users of the virtio device to mention their dependencies on the
device in the DT file itself. Like GPIO pin users can use the phandle of
the device node, or the node may contain more subnodes to add i2c or spi
eeproms and other users.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/virtio/virtio_mmio.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9c46eb..ae40546a66a3 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -551,11 +551,51 @@ static void virtio_mmio_release_dev(struct device *_d)
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct platform_device *pdev = vm_dev->pdev;
 
+	of_node_put(vdev->dev.of_node);
 	devm_kfree(&pdev->dev, vm_dev);
 }
 
 /* Platform device */
 
+static int virtio_mmio_of_init(struct virtio_device *vdev)
+{
+	struct device_node *np, *pnode = vdev->dev.parent->of_node;
+	int ret, count;
+	u32 reg;
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
+	ret = of_property_read_u32(np, "reg", &reg);
+	if (ret < 0)
+		goto out;
+
+	/* The reg field should match the device id */
+	if (WARN_ON(reg != vdev->id.device)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	vdev->dev.of_node = np;
+	return 0;
+
+out:
+	of_node_put(np);
+	return ret;
+}
+
 static int virtio_mmio_probe(struct platform_device *pdev)
 {
 	struct virtio_mmio_device *vm_dev;
@@ -621,6 +661,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	if (rc)
 		dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
 
+	rc = virtio_mmio_of_init(&vm_dev->vdev);
+	if (rc)
+		return rc;
+
 	platform_set_drvdata(pdev, vm_dev);
 
 	rc = register_virtio_device(&vm_dev->vdev);
-- 
2.31.1.272.g89b43f80a514

