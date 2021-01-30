Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866F0309324
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhA3JSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhA3EOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 23:14:32 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF4EC061356
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 20:03:52 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id 22so7485148qty.14
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 20:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=l1vXrQs2lv+kNAXuJD7PXrJj1pClRpRGVgsnuacvh0k=;
        b=qrhairEvJPB4oBg83+oklny/gIomRLTUTylZQT1Gb6DxImdDeGrGfghK//TmZcppIe
         XcEqVu2Sook9+PfNaiDig9nAuSguWTrMmYzT/cDxcQL13dkIXwL/3Hv58Rl5qViay/n4
         n6611i3IvNwyOl0j4iPKIn7Gfwrw4vNpNVY/0ool0D3gX1kYarHJ4Xr18sqwJJKgtpMA
         4b5pgc5aApw17fIRtU86SfgcpshZWwrE+lrR0e7JvdGa28LNlUWNk6BlGCvPoHA27hq9
         uAW+R9aetnQQ61TzYTJuyWNWqvXa0UDcRX9vvj92hdCPiRTS7npB9tSgr6Sbqg193oc5
         tJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l1vXrQs2lv+kNAXuJD7PXrJj1pClRpRGVgsnuacvh0k=;
        b=JBC7jnaXZfnEVc4cgfnylu6zNTE/r0ZNUwr7Iga6rjEoC69/C5bJ5lGS2ez0/E3did
         echcBkwnYetIpuVy9bGDWEgCcXeR2u4VEYM6qN7SD7V4L7x13c6OMIKk5eCTUu6N7WRj
         Huyi4cRfV3a0eU8qfiIoUm6JwNwauu2jKr/v6GiZGJPfFi+Bo89FlWlJjqvqqF3Q+mVB
         CsDIAMv5plAsZiNZcGnO3VEG5DmjcwSrj7cZEvheKzd/d6RIkQos//obhipz3PmH37qB
         yvx3MFQTB8k+dQ5e31fuHHyZFf6QISy5gK9b+mC9adCWeNLyi1K8tQodF754qtyBeBUT
         Z0OQ==
X-Gm-Message-State: AOAM5307oejVU7+8gyPtSFB4CT4JrnJnFeKHvraGAUSHKYFKAOEzdsif
        bt8vw6u5kpITaqU2TaLwdowJ2IcSZpn2KDA=
X-Google-Smtp-Source: ABdhPJxFeKkgjWYpH4/dmm9xkCIllMb+GIs/fyxdlGKN7LW237jrOW/br7jaEA3u3m4sAmAbjDYX41fpv0ebyrE=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:c687:: with SMTP id
 d7mr6778697qvj.17.1611979431286; Fri, 29 Jan 2021 20:03:51 -0800 (PST)
Date:   Fri, 29 Jan 2021 20:03:43 -0800
In-Reply-To: <20210130040344.2807439-1-saravanak@google.com>
Message-Id: <20210130040344.2807439-2-saravanak@google.com>
Mime-Version: 1.0
References: <20210130040344.2807439-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v1 1/2] driver core: fw_devlink: Detect supplier devices that
 will never be added
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the initial parsing of firmware by fw_devlink, fw_devlink might
infer that some supplier firmware nodes would get populated as devices.
But the inference is not always correct. This patch tries to logically
detect and fix such mistakes as boot progresses or more devices probe.

fw_devlink makes a fundamental assumption that once a device binds to a
driver, it will populate (i.e: add as struct devices) all the child
firmware nodes that could be populated as devices.

So, whenever a device probes, we check all its child firmware nodes. If
a child firmware node has a corresponding device populated, we don't
modify the child node or its descendants. However, if a child firmware
node has not been populated as a device, we go an delete all the fwnode
links where the child node or its descendants are suppliers. This
ensures that no other device is blocked on a firmware node that will
never be populated as a device.

Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 484a942884ba..f380133df63b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -148,6 +148,20 @@ void fwnode_links_purge(struct fwnode_handle *fwnode)
 	fwnode_links_purge_consumers(fwnode);
 }
 
+static void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *child;
+
+	/* Don't purge consumer links of an added child */
+	if (fwnode->dev)
+		return;
+
+	fwnode_links_purge_consumers(fwnode);
+
+	fwnode_for_each_available_child_node(fwnode, child)
+		fw_devlink_purge_absent_suppliers(child);
+}
+
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
 DEFINE_STATIC_SRCU(device_links_srcu);
@@ -1154,12 +1168,22 @@ void device_links_driver_bound(struct device *dev)
 	LIST_HEAD(sync_list);
 
 	/*
-	 * If a device probes successfully, it's expected to have created all
+	 * If a device binds successfully, it's expected to have created all
 	 * the device links it needs to or make new device links as it needs
-	 * them. So, it no longer needs to wait on any suppliers.
+	 * them. So, fw_devlink no longer needs to create device links to any
+	 * of the device's suppliers.
+	 *
+	 * Also, if a child firmware node of this bound device is not added as
+	 * a device by now, assume it is never going to be added and make sure
+	 * other devices don't defer probe indefinitely by waiting for such a
+	 * child device.
 	 */
-	if (dev->fwnode && dev->fwnode->dev == dev)
+	if (dev->fwnode && dev->fwnode->dev == dev) {
+		struct fwnode_handle *child;
 		fwnode_links_purge_suppliers(dev->fwnode);
+		fwnode_for_each_available_child_node(dev->fwnode, child)
+			fw_devlink_purge_absent_suppliers(child);
+	}
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 
 	device_links_write_lock();
-- 
2.30.0.365.g02bc693789-goog

