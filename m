Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8410D32AE13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360491AbhCBWVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383589AbhCBVQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:16:28 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A3AC061794
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 13:11:41 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id i1so5407030qvu.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 13:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ha32Pb8LQarekc1l29yMATX3+MJye2BpgFbjrEa+47o=;
        b=OnY895K/7pS8uVuh5xN1WbuUXXt1LrnLrKtSlEZafXgfD7nC0rgEpXnKR7lHwkiAJV
         7nD/VI4XXUOZnYpWDMKM2RNjhL5F10ODPqMqtD1A1xhi4ESH69giqc3Akw1gSu3a+rzq
         W/FL4ypFBsEuszLO2XsKMurKqWfPawdUJw6tBLTFNZp06Urso/TakpvkiTkh22Gf2ach
         jHXUGa/QvHQRntFpJKFJUZKeAe4X7RE01AWiv/grMHoQY0o3p4taXeoi0iICipsZU/fn
         XiVSZ5pVkWp+hBCx5PMbmfNmomEqc2vwebdVEr9Y11SlW0tjPse3q9RiAmRR9wt5fjg5
         2PJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ha32Pb8LQarekc1l29yMATX3+MJye2BpgFbjrEa+47o=;
        b=p7JcPYGA0w3ae++8sh3o9/Tmf+Mks4fgT5zBDLZBITCCgOPP2M1Vls3Drd2veq8TaQ
         M7A/1kNwLybWst2wnjn7IT4CYTNgymIsj/agzfpsphHq/UV3K4V4InS21cAc4dbRY4Bd
         tUBnH3w43qRk5vKJxTtAsGgabjJ/Ir+F7F8e/HrnWM/CnpO6cqyidfKsqU8d0EMHNz91
         uiEF6tpPxbIkxpMi2qcdS0WLKGekC9OkPt9ozj2RAxEAJ7HUd6QmRP2qT0DzeLBMj4Q1
         oH4z3Ej+IrkVkWseRcqv+w8TYFcdrpDYFbf7VEn/c/jOHmTVQwmf0BNTR+ud3caWo5Ru
         xkIQ==
X-Gm-Message-State: AOAM533rqgQWicm8qsOYYOpFTIvw2kHdk8hplBqZx98MTqwl4iWIO3HR
        elb3PBsIEQxB6+ljkzQRfoLid20cXKlM1IY=
X-Google-Smtp-Source: ABdhPJzTbMYKKSz5Mm8hHKRSrnzQ9BCNkd58dEhtIqC24T8TOWMdFHTwHLcwba8GIZWePxdw2QukihT9qJ4njm8=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:a1ad:fce1:8a40:59b6])
 (user=saravanak job=sendgmr) by 2002:a05:6214:523:: with SMTP id
 x3mr21274886qvw.27.1614719500715; Tue, 02 Mar 2021 13:11:40 -0800 (PST)
Date:   Tue,  2 Mar 2021 13:11:30 -0800
In-Reply-To: <20210302211133.2244281-1-saravanak@google.com>
Message-Id: <20210302211133.2244281-2-saravanak@google.com>
Mime-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v1 1/3] driver core: Avoid pointless deferred probe attempts
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
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
index ba660731bd25..569932d282c0 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -439,6 +439,9 @@ struct dev_links_info {
  * @state_synced: The hardware state of this device has been synced to match
  *		  the software state of this device by calling the driver/bus
  *		  sync_state() callback.
+ * @can_match:	The device has matched with a driver at least once or it is in
+ *		a bus (like AMBA) which can't check for matching drivers until
+ *		other devices probe successfully.
  * @dma_coherent: this particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
  * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
@@ -545,6 +548,7 @@ struct device {
 	bool			offline:1;
 	bool			of_node_reused:1;
 	bool			state_synced:1;
+	bool			can_match:1;
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
-- 
2.30.1.766.gb4fecdf3b7-goog

