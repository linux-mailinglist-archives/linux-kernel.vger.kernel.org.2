Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACBC320A3E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 13:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBUM1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 07:27:30 -0500
Received: from m15113.mail.126.com ([220.181.15.113]:34008 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhBUM12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 07:27:28 -0500
X-Greylist: delayed 8994 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Feb 2021 07:27:25 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=G9gwKZta4TeKG9dXje
        SByg2i5Ouo5RFeGkqM2bZkx+U=; b=OLCm1lX0QSJLbic8cJMPGv2/lP6QajOLWf
        R62xYjJGyxgW6P/Nt3sYTS0bUehMuvD54N+lF7G/VxFCPlCI2C7o6VTjyQ0gEnXT
        kPvKKxyBuRNDX/r9UfWCzrchhhBDoXNgxA4LXdcvPMz5yfYJdnyAkSAp2KXs223U
        hjLUrip/g=
Received: from 192.168.137.133 (unknown [112.10.84.6])
        by smtp3 (Coremail) with SMTP id DcmowAB32_jkyTFgxsFKOw--.43436S3;
        Sun, 21 Feb 2021 10:48:06 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     guoren@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: remove export for virtio_config_{enable, disable}
Date:   Sat, 20 Feb 2021 21:48:04 -0500
Message-Id: <1613875684-7967-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DcmowAB32_jkyTFgxsFKOw--.43436S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy8XF17JrWDXF1UKF1fXrb_yoW8ury3pF
        n7AFyFy3yUJF4fGa95Ja48u3WavanFk3yxJ34Fgwn8Wr12yr9Fyr1kA34xZa17ArWDAF1r
        JFyIgFyjv34DuFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwTmhUUUUU=
X-Originating-IP: [112.10.84.6]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbioAZApFx5bq+kEgAAsQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio_config_enable(), virtio_config_disable() are only used inside
drivers/virtio/virtio.c, so it doesn't need export the symbols.

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 drivers/virtio/virtio.c | 6 ++----
 include/linux/virtio.h  | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 42e09cc..4b15c00 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -141,15 +141,14 @@ void virtio_config_changed(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_config_changed);
 
-void virtio_config_disable(struct virtio_device *dev)
+static void virtio_config_disable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
 	dev->config_enabled = false;
 	spin_unlock_irq(&dev->config_lock);
 }
-EXPORT_SYMBOL_GPL(virtio_config_disable);
 
-void virtio_config_enable(struct virtio_device *dev)
+static void virtio_config_enable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
 	dev->config_enabled = true;
@@ -158,7 +157,6 @@ void virtio_config_enable(struct virtio_device *dev)
 	dev->config_change_pending = false;
 	spin_unlock_irq(&dev->config_lock);
 }
-EXPORT_SYMBOL_GPL(virtio_config_enable);
 
 void virtio_add_status(struct virtio_device *dev, unsigned int status)
 {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 55ea329..b1894e0 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -132,8 +132,6 @@ static inline struct virtio_device *dev_to_virtio(struct device *_dev)
 void virtio_break_device(struct virtio_device *dev);
 
 void virtio_config_changed(struct virtio_device *dev);
-void virtio_config_disable(struct virtio_device *dev);
-void virtio_config_enable(struct virtio_device *dev);
 int virtio_finalize_features(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
-- 
1.8.3.1

