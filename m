Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAEA40A57F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbhINEk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238950AbhINEk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:40:57 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92961C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:39:40 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id w10-20020a0cb54a000000b0037a9848b92fso5267123qvd.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H7CJ0ZOTgeDTdbShR48Z3KLUghddS83hyhBxmNH7VWg=;
        b=YsA8MHrAuTYR0xozqeyVK4OunNgNMMoyZubkqhia/HB936TmdfrTM5/ZQmMyzh4eW4
         fpedQdTiyzpOznnd7hFH7qBNjyWGh3DW2UoyQD3Hld8JdIFvupObTL3ajm9orU1E5JSx
         ksd3+kNUl8wI5WMQbIu0EUj8nzinXv9IJ0e0N8URmaBVJnLgHwVcdJdcdS5HD44Vlldb
         9fgSLSOYwsZGc1smU7VWn4Mto1OSvrZuqbRe5Xz+8YAbRdula8BJXm1k/r/cN2cLETXx
         2kXDf+Oz886n+WdysWiHtY47DqzCI+XxHH35li19Pm3WfCTzWsbvSwVPF4Lt0Rcd2Btk
         EeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H7CJ0ZOTgeDTdbShR48Z3KLUghddS83hyhBxmNH7VWg=;
        b=BBhzzT13TmVcBrwRs0nYvYDpoc/b+vgCo+iaJ9mVhzx4CdVNpx8iwcnqoNjndTx9zq
         zzim14WGcPvr3qu8fXr5q4tnuTyxBeOHOBtBYu6AwqXu575Wus5JLjlDgDSOUeMZ3Qbg
         oPZZbSvvDub0RHwDl4v2K1m09h7RlgPTKgQNxP52lQdqLXjVmQYaR6AL7aRpTU500Spm
         giQv7FKQRuZwU/SfvEj3KuS5IpCdP1PHD5LngTFnvGmVvbd1JLBH9TOfXqXZ1+TfP/3r
         TImKJkCjWgcmdOp/WgjvdlkTGy9Yyoe7XnGQxC1gzT8uakF90pvM3lNUOcUr6F0Lz7iZ
         Z+0A==
X-Gm-Message-State: AOAM530QKg4Oz3xstUqcC2kiDCZ3glPdtx5BsN0vzlDypGNohPUTxMGG
        5ZBOael/xoFc9PzgHHXZpbelR3XQ/2PewgA=
X-Google-Smtp-Source: ABdhPJzOyi6BDUsClRCt3SwJuKH10Mwm55maR5GCERaB4WId7L92cg7XEQ3+rcLt4z4zwfFjdCytg2S5BAWP3V4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:48b:108c:f6a1:56f3])
 (user=saravanak job=sendgmr) by 2002:a05:6214:13e3:: with SMTP id
 ch3mr3331092qvb.35.1631594379800; Mon, 13 Sep 2021 21:39:39 -0700 (PDT)
Date:   Mon, 13 Sep 2021 21:39:24 -0700
In-Reply-To: <20210914043928.4066136-1-saravanak@google.com>
Message-Id: <20210914043928.4066136-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v1 2/5] driver core: Set deferred probe reason when deferred
 by driver core
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver core defers the probe of a device, set the deferred
probe reason so that it's easier to debug. The deferred probe reason is
available in debugfs under devices_deferred.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 316df6027093..41f456904272 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -955,6 +955,29 @@ static void device_links_missing_supplier(struct device *dev)
 	}
 }
 
+/**
+ * dev_set_def_probe_reason - Set the deferred probe reason for a device
+ * @dev: the pointer to the struct device
+ * @fmt: printf-style format string
+ * @...: arguments as specified in the format string
+ *
+ * This is a more caller-friendly version of device_set_deferred_probe_reason()
+ * that takes variable argument inputs similar to dev_info().
+ */
+static void dev_set_def_probe_reason(const struct device *dev, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	device_set_deferred_probe_reason(dev, &vaf);
+
+	va_end(args);
+}
+
 /**
  * device_links_check_suppliers - Check presence of supplier drivers.
  * @dev: Consumer device.
@@ -975,6 +998,7 @@ int device_links_check_suppliers(struct device *dev)
 {
 	struct device_link *link;
 	int ret = 0;
+	struct fwnode_handle *sup_fw;
 
 	/*
 	 * Device waiting for supplier to become available is not allowed to
@@ -983,10 +1007,13 @@ int device_links_check_suppliers(struct device *dev)
 	mutex_lock(&fwnode_link_lock);
 	if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
 	    !fw_devlink_is_permissive()) {
+		sup_fw = list_first_entry(&dev->fwnode->suppliers,
+					  struct fwnode_link,
+					  c_hook)->supplier;
 		dev_dbg(dev, "probe deferral - wait for supplier %pfwP\n",
-			list_first_entry(&dev->fwnode->suppliers,
-			struct fwnode_link,
-			c_hook)->supplier);
+			sup_fw);
+		dev_set_def_probe_reason(dev,
+			"wait for supplier %pfwP\n", sup_fw);
 		mutex_unlock(&fwnode_link_lock);
 		return -EPROBE_DEFER;
 	}
@@ -1003,6 +1030,9 @@ int device_links_check_suppliers(struct device *dev)
 			device_links_missing_supplier(dev);
 			dev_dbg(dev, "probe deferral - supplier %s not ready\n",
 				dev_name(link->supplier));
+			dev_set_def_probe_reason(dev,
+				"supplier %s not ready\n",
+				dev_name(link->supplier));
 			ret = -EPROBE_DEFER;
 			break;
 		}
-- 
2.33.0.309.g3052b89438-goog

