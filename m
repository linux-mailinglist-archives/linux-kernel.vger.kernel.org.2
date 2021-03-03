Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC032BCAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381627AbhCCOa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842971AbhCCKXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:11 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5A4C061221
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:32:18 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id a41so15325255qtk.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Z6rdKKqDx14ISAnnTv14YP9QCQ+xZleGBaatgAEnvpg=;
        b=ix1W871I05z+OFEXarV2iP8yIq9kZ0cXw2+CbtMcwwoGO6xGTRHRqvQNQLjKs9FRmi
         wAbb+tLNRg1EEzKnpUSpyAnkgx28b8kDSfIxkUmUzjf2uzshPhHPpi7iMEspAnWdnGN0
         1DX96pyQAM69ozT1PnJXTo7fDgOwDe9tSSMwgu+1231cT6Ch5YMVMvCoFRbTVTroM51J
         T+O94nw09Dls/6QrqLV8QMGpf6z/iZ4GM6JGzww/Ft2e2bUTpKT7OraWsiT4L6BtUwlx
         iV/yh/nMcQPWObY1gtWNKzZt4Dr4BBu24hocz4G2Xoj0j7RJiaPWPiIfSZjZHjex7F40
         4mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Z6rdKKqDx14ISAnnTv14YP9QCQ+xZleGBaatgAEnvpg=;
        b=CMJMHp8l1twl+bGFqIvG2iqwEKICaWC490U5uIIL1lPdOWx9pxFT+DXzhU91p0p4MM
         EOIzaUT5Uq4So78PgI6bFFPDIDYq/oOFJT2Ftpm5iRdkRU7QDY/ncMWZzklhhjajl1r3
         mUlJvCx8Vv/LTKkKI12h3+WB+CqNeRo3lsfAZCFlj71JU4fIjv+z78qxazPanCBf2yHQ
         kXQepKdZ+h4Jea+twCugBuxyGNym+n+8qOolnUweDgW7lpId+hCGBwAf3d4068Z1zDwn
         HjZjlNZToMFi0Dc6JbOeXaokNdI/o4TMqz3TKHK4jqiro5sdz9S23LqC6YTzd6C5WbJk
         zxkw==
X-Gm-Message-State: AOAM530RBvO0HaNXOzBGPYBPutYyrQHI78NzA+BqNrCvqu3QXppOmH1i
        1Ymn/sbhSAT0IndZJPHgYEWGljP5a8wWlgQ=
X-Google-Smtp-Source: ABdhPJxANFa77Gz+LeoUsGjRoi6ip6is9nKR/LaCYarg1JR7XwXXuTJJkAreYZZjjH26KpToRNAxrFSm4OH2/Ic=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:71d0:e842:de76:b9be])
 (user=saravanak job=sendgmr) by 2002:a0c:b8a3:: with SMTP id
 y35mr1624430qvf.23.1614760338007; Wed, 03 Mar 2021 00:32:18 -0800 (PST)
Date:   Wed,  3 Mar 2021 00:32:14 -0800
Message-Id: <20210303083215.3257304-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v1] RFC: amba: Remove amba specific deferred probe handling
From:   Saravana Kannan <saravanak@google.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Saravana Kannan <saravanak@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addition/probe of amba devices has its own weird deferred probe
mechanism that needs to be maintained separately. It doesn't
automatically get any bugs fixes or improvements to the common deferred
probe mechanism.

It also has an arbitrary 5 second periodic attempt. So, even if the
resources are available, there can be an arbitrary delay before amba
devices are probed.

This patch used a proxy/stub device so that amba devices can hook into
the common deferred probe mechanism. This also means amba devices get
probed as soon as their resources are available.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

We talked about this almost a year ago[1] and it has been nagging me all
this time. So, finally got around to giving it a shot. This actually
seems to work -- I tested it on a device that was lying around.

Thoughts?

[1] - https://lore.kernel.org/linux-arm-kernel/CAGETcx8Cn-b6L2y10LKb91S3n06b6+Be2z_A0402EyNy-8yECg@mail.gmail.com/
-Saravana

 drivers/amba/bus.c       | 116 ++++++++++++++++++---------------------
 include/linux/amba/bus.h |   1 +
 2 files changed, 53 insertions(+), 64 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 939ca220bf78..393d189b6bca 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -24,6 +24,9 @@
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
+static int amba_proxy_probe(struct amba_device *adev,
+			    const struct amba_id *id);
+
 /* called on periphid match and class 0x9 coresight device. */
 static int
 amba_cs_uci_id_match(const struct amba_id *table, struct amba_device *dev)
@@ -46,6 +49,8 @@ amba_cs_uci_id_match(const struct amba_id *table, struct amba_device *dev)
 static const struct amba_id *
 amba_lookup(const struct amba_id *table, struct amba_device *dev)
 {
+	if (!table)
+		return NULL;
 	while (table->mask) {
 		if (((dev->periphid & table->mask) == table->id) &&
 			((dev->cid != CORESIGHT_CID) ||
@@ -185,6 +190,9 @@ static int amba_probe(struct device *dev)
 	const struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
 	int ret;
 
+	if (!pcdev->periphid)
+		return pcdrv->probe(pcdev, 0);
+
 	do {
 		ret = of_clk_set_defaults(dev->of_node, false);
 		if (ret < 0)
@@ -224,6 +232,9 @@ static int amba_remove(struct device *dev)
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *drv = to_amba_driver(dev->driver);
 
+	if (!pcdev->periphid)
+		return 0;
+
 	pm_runtime_get_sync(dev);
 	if (drv->remove)
 		drv->remove(pcdev);
@@ -325,9 +336,20 @@ struct bus_type amba_bustype = {
 };
 EXPORT_SYMBOL_GPL(amba_bustype);
 
+static struct amba_driver amba_proxy_drv = {
+	.drv = {
+		.name = "amba-proxy",
+	},
+	.probe = amba_proxy_probe,
+};
+
 static int __init amba_init(void)
 {
-	return bus_register(&amba_bustype);
+	int ret = bus_register(&amba_bustype);
+
+	if (ret)
+		return ret;
+	return amba_driver_register(&amba_proxy_drv);
 }
 
 postcore_initcall(amba_init);
@@ -490,58 +512,19 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 	goto err_release;
 }
 
-/*
- * Registration of AMBA device require reading its pid and cid registers.
- * To do this, the device must be turned on (if it is a part of power domain)
- * and have clocks enabled. However in some cases those resources might not be
- * yet available. Returning EPROBE_DEFER is not a solution in such case,
- * because callers don't handle this special error code. Instead such devices
- * are added to the special list and their registration is retried from
- * periodic worker, until all resources are available and registration succeeds.
- */
-struct deferred_device {
-	struct amba_device *dev;
-	struct resource *parent;
-	struct list_head node;
-};
-
-static LIST_HEAD(deferred_devices);
-static DEFINE_MUTEX(deferred_devices_lock);
-
-static void amba_deferred_retry_func(struct work_struct *dummy);
-static DECLARE_DELAYED_WORK(deferred_retry_work, amba_deferred_retry_func);
-
-#define DEFERRED_DEVICE_TIMEOUT (msecs_to_jiffies(5 * 1000))
-
-static int amba_deferred_retry(void)
+static int amba_proxy_probe(struct amba_device *adev,
+			    const struct amba_id *id)
 {
-	struct deferred_device *ddev, *tmp;
-
-	mutex_lock(&deferred_devices_lock);
-
-	list_for_each_entry_safe(ddev, tmp, &deferred_devices, node) {
-		int ret = amba_device_try_add(ddev->dev, ddev->parent);
-
-		if (ret == -EPROBE_DEFER)
-			continue;
-
-		list_del_init(&ddev->node);
-		kfree(ddev);
-	}
-
-	mutex_unlock(&deferred_devices_lock);
+	int ret;
 
-	return 0;
-}
-late_initcall(amba_deferred_retry);
+	if (!adev->other_dev)
+		return -ENODEV;
 
-static void amba_deferred_retry_func(struct work_struct *dummy)
-{
-	amba_deferred_retry();
+	ret = amba_device_try_add(adev->other_dev, adev->dev.platform_data);
+	if (ret != -EPROBE_DEFER)
+		adev->other_dev = NULL;
 
-	if (!list_empty(&deferred_devices))
-		schedule_delayed_work(&deferred_retry_work,
-				      DEFERRED_DEVICE_TIMEOUT);
+	return ret;
 }
 
 /**
@@ -557,25 +540,30 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 {
 	int ret = amba_device_try_add(dev, parent);
 
+	/*
+	 * Registration of AMBA device require reading its pid and cid
+	 * registers.  To do this, the device must be turned on (if it is a
+	 * part of power domain) and have clocks enabled. However in some cases
+	 * those resources might not be yet available. Returning EPROBE_DEFER
+	 * is not a solution in such case, because callers don't handle this
+	 * special error code. Instead, create a dummy proxy device that'll
+	 * keep deferring probe until all the resources are available and then
+	 * add the real device.
+	 */
 	if (ret == -EPROBE_DEFER) {
-		struct deferred_device *ddev;
+		struct amba_device *proxy_dev;
 
-		ddev = kmalloc(sizeof(*ddev), GFP_KERNEL);
-		if (!ddev)
+		proxy_dev = amba_device_alloc(NULL, 0, 0);
+		if (!proxy_dev)
 			return -ENOMEM;
 
-		ddev->dev = dev;
-		ddev->parent = parent;
-		ret = 0;
-
-		mutex_lock(&deferred_devices_lock);
-
-		if (list_empty(&deferred_devices))
-			schedule_delayed_work(&deferred_retry_work,
-					      DEFERRED_DEVICE_TIMEOUT);
-		list_add_tail(&ddev->node, &deferred_devices);
-
-		mutex_unlock(&deferred_devices_lock);
+		proxy_dev->other_dev = dev;
+		proxy_dev->dev.platform_data = parent;
+		proxy_dev->driver_override = "amba-proxy";
+		dev_set_name(&proxy_dev->dev, "proxy:%s", dev_name(&dev->dev));
+		ret = device_add(&proxy_dev->dev);
+		if (ret)
+			put_device(&proxy_dev->dev);
 	}
 	return ret;
 }
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 6cc93ab5b809..432b32cf8fcc 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -71,6 +71,7 @@ struct amba_device {
 	struct amba_cs_uci_id	uci;
 	unsigned int		irq[AMBA_NR_IRQS];
 	char			*driver_override;
+	struct amba_device	*other_dev;
 };
 
 struct amba_driver {
-- 
2.30.1.766.gb4fecdf3b7-goog

