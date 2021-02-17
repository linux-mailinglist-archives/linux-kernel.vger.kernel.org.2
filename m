Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E762531E341
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhBQXwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhBQXwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:52:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327DEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 15:51:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o9so493726yba.18
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 15:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=LCtiyFgAGb69QmDoRrsjBB09pBROIM+Hfs91sBf4Y/Q=;
        b=hxSIl+9NKjykJoctDjMeS7xXhlAN2TGwfDJGN4QZfJzsvGggP+JUpp+iPmTrs05Zl0
         GMai15cNPj4Xgf+1LPjID7OZ+GbtACiXv59t0ecTavee4pSMdTIcxXGScHNb9VYQmAe3
         k7xeKvl7psrWYkf1K3rwwckFOQOWi3Qhg4Lj0+vzdpUaoMY/VCH+1vxScH0xcF6e6LxU
         YgOJHyoZ7IIohncA8Ik9ZaXVOXv7G1UNGMV+zgv6oL2DgrdqsnYQK2FD4qiIlceVeOuP
         O1xU8vPbU4g5hRmxs9Zafd+wdOoGCMCJrQVq2iGfAM5fLYtOEd9ZPukxf2Ae2VHOiuID
         HxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=LCtiyFgAGb69QmDoRrsjBB09pBROIM+Hfs91sBf4Y/Q=;
        b=CYtOFGR2qLqItTkIhFe+NkYzRPbXlGkmFf/ePG4D9mYuFuGvguCTQX4nePGFScn5WK
         v2h3irSIe7kEhNRWF0tzJgfoE3cj7jm6mYYnocThNRtV606QhjqleBGgRUTY1nGAyouD
         mxUlXI22h+wwsJGHaZaxDPcmlDlVTsBgb/VSbhzv75Z3ioUB6YpWe5Q0DkpHGVueui0w
         HSl+09V3/ZwCySladeJ71ny5gEd1KdezJeO9y+cZa/w2Ztz1RAo3tSQzfSs00IW9s0o+
         DVoOw7EM67qrZd5iFUTuDxSd0eut06/ipKkyReR1ZWOYNj132IAqiXOKcfAcFQEyKTPJ
         1XNQ==
X-Gm-Message-State: AOAM5305HtIWTjZ+6Ja9XpeZHViQrbGRa53zUHbddccl1FZgtRcu9ua4
        Sl95t7omMnxpHq5Lbu3CA3GLg5k70ij56Ek=
X-Google-Smtp-Source: ABdhPJzlDio6VuBQm14YeCdnULcCsM8lQ1WRYaI5uJyXaP/vGtMo0figJqr2ePwwlrHyO8jtTtJOboCnPS6ogzM=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f554:3d97:21a9:f360])
 (user=saravanak job=sendgmr) by 2002:a5b:b8b:: with SMTP id
 l11mr2773389ybq.205.1613605897237; Wed, 17 Feb 2021 15:51:37 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:51:30 -0800
Message-Id: <20210217235130.1744843-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] driver core: Avoid pointless deferred probe attempts
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point in adding a device to the deferred probe list if we
know for sure that it doesn't have a matching driver. So, check if a
device can match with a driver before adding it to the deferred probe
list.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Geert,

Can you give this a shot for your I2C DMA issue with fw_devlink=on?

-Saravana

 drivers/base/dd.c      | 6 ++++++
 include/linux/device.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9179825ff646..f18963f42e21 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -123,6 +123,9 @@ static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
 
 void driver_deferred_probe_add(struct device *dev)
 {
+	if (!dev->can_match)
+		return;
+
 	mutex_lock(&deferred_probe_mutex);
 	if (list_empty(&dev->p->deferred_probe)) {
 		dev_dbg(dev, "Added to deferred list\n");
@@ -726,6 +729,7 @@ static int driver_probe_device(struct device_driver *drv, struct device *dev)
 	if (!device_is_registered(dev))
 		return -ENODEV;
 
+	dev->can_match = true;
 	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 
@@ -829,6 +833,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 		return 0;
 	} else if (ret == -EPROBE_DEFER) {
 		dev_dbg(dev, "Device match requests probe deferral\n");
+		dev->can_match = true;
 		driver_deferred_probe_add(dev);
 	} else if (ret < 0) {
 		dev_dbg(dev, "Bus failed to match device: %d\n", ret);
@@ -1064,6 +1069,7 @@ static int __driver_attach(struct device *dev, void *data)
 		return 0;
 	} else if (ret == -EPROBE_DEFER) {
 		dev_dbg(dev, "Device match requests probe deferral\n");
+		dev->can_match = true;
 		driver_deferred_probe_add(dev);
 	} else if (ret < 0) {
 		dev_dbg(dev, "Bus failed to match device: %d\n", ret);
diff --git a/include/linux/device.h b/include/linux/device.h
index 7619a84f8ce4..1f9cc1ba78bc 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -438,6 +438,9 @@ struct dev_links_info {
  * @state_synced: The hardware state of this device has been synced to match
  *		  the software state of this device by calling the driver/bus
  *		  sync_state() callback.
+ * @can_match:	The device has matched with a driver at least once or it is in
+ *		a bus (like AMBA) which can't check for matching drivers until
+ *		other devices probe successfully.
  * @dma_coherent: this particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
  * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
@@ -544,6 +547,7 @@ struct device {
 	bool			offline:1;
 	bool			of_node_reused:1;
 	bool			state_synced:1;
+	bool			can_match:1;
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
-- 
2.30.0.478.g8a0d178c01-goog

