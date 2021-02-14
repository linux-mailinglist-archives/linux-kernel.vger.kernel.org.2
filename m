Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E781F31AED0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 04:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBNDbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 22:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBNDbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 22:31:45 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019A9C061756
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 19:30:59 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id h10so2630567qvf.19
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 19:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=YrJTBBwLjoHKxPdL5FhIlxlSkWTvnTyZYkPeyIaD1xw=;
        b=l5hwQ2622VL/iTkcYGrDG9Ny6HUhIPJNPbGy1+MKdgcpvn5aoF5MKATbcv66eGp59k
         PUZcrPjLiBzOxSGCGfEf3njGfE6Zp86eJP6NHKSZ5qfS6fLrajqZLVVW7nfAQTzs35Bo
         QugRxmwtEDx3HjAFjoOYYZW/b3uTYrYQZG1dZ/rxkZ0ol0hhdoTPd5gndsjUSTWHBk7z
         RUUeCEzZW/yeZWgxEohefr+KpyljrGiE/cPuP1EbHGvouIIBcC8MBG+Jlo6p/ARrKJiz
         80GlwcrqR6lqFxQ5zVXfBcSjj0CAUcMBYQjbttYV2c0ADqr+u7+JQCajMBJzO8LeZyKM
         JDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=YrJTBBwLjoHKxPdL5FhIlxlSkWTvnTyZYkPeyIaD1xw=;
        b=tpe9EdMRoggOxodI6zUo8SK/Xfa4+q+KBwLg94Y/a9DboDp6FtUA3MK4jossrRyCNl
         PriwUFgJSjvroCeuc64anncTCgLxifKmXocuwzbynUPOtDnHqZaIcrKQ6cKifvPzuBFU
         OK4wX95H7aID1xAWOHqS61qeHTO0CPRZ5iNTAO3ndjBScko4C61ukRYoyvqJevMq9fpZ
         E/QS70wVzzZNlf6KbyMIcvDr0kX28pQLR0dFbkobXweEhPb52R0MCvFPxxcXR++T09AL
         /hZffpt9Kc8fx+omNYbkVww5r7yqQ/LKiLDs22xN5GlOMFekidLtm8NvtAO2lS9q+gNO
         9xHA==
X-Gm-Message-State: AOAM533yWGYqy5OI3rYf1rUxWgJ5tmiTFy22c3gt9u4i28+q13ceyr2v
        ZzlQM8ouWPeA2wQ5m0A0NsVHUFIhYzPv
X-Google-Smtp-Source: ABdhPJyDD0D6Q8Cu1HTh9Oa6/NsgLsl4obNfXsOVHhj1qxYkpYf37ENZpqPSU6/k2RxzNQDPAqmRAJCNlZn9
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:5de6:90a2:6272:c4ff])
 (user=kyletso job=sendgmr) by 2002:a0c:c583:: with SMTP id
 a3mr9426003qvj.15.1613273458822; Sat, 13 Feb 2021 19:30:58 -0800 (PST)
Date:   Sun, 14 Feb 2021 11:30:52 +0800
Message-Id: <20210214033052.1284385-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v2] usb: typec: tcpm: Export partner Source Capabilities
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export a function for other drivers to get the partner Source
Capabilities.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changes since v1:
- add a put function to free the memory

 drivers/usb/typec/tcpm/tcpm.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/usb/tcpm.h      |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index be0b6469dd3d..6c6d199f63b7 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5739,6 +5739,40 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 	return 0;
 }
 
+/*
+ * Don't call this function in interrupt context. Caller needs to free the
+ * memory by calling tcpm_put_partner_src_caps.
+ */
+int tcpm_get_partner_src_caps(struct tcpm_port *port, u32 **src_pdo)
+{
+	unsigned int nr_pdo;
+
+	mutex_lock(&port->lock);
+	if (port->nr_source_caps == 0) {
+		mutex_unlock(&port->lock);
+		return -ENODATA;
+	}
+
+	*src_pdo = kcalloc(port->nr_source_caps, sizeof(u32), GFP_KERNEL);
+	if (!src_pdo) {
+		mutex_unlock(&port->lock);
+		return -ENOMEM;
+	}
+
+	nr_pdo = tcpm_copy_pdos(*src_pdo, port->source_caps,
+				port->nr_source_caps);
+	mutex_unlock(&port->lock);
+	return nr_pdo;
+}
+EXPORT_SYMBOL_GPL(tcpm_get_partner_src_caps);
+
+void tcpm_put_partner_src_caps(u32 **src_pdo)
+{
+	kfree(*src_pdo);
+	*src_pdo = NULL;
+}
+EXPORT_SYMBOL_GPL(tcpm_put_partner_src_caps);
+
 /* Power Supply access to expose source power information */
 enum tcpm_psy_online_states {
 	TCPM_PSY_OFFLINE = 0,
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 42fcfbe10590..f83d9ff89a13 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -161,5 +161,7 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
 			       enum tcpm_transmit_status status);
 void tcpm_pd_hard_reset(struct tcpm_port *port);
 void tcpm_tcpc_reset(struct tcpm_port *port);
+int tcpm_get_partner_src_caps(struct tcpm_port *port, u32 **pdo);
+void tcpm_put_partner_src_caps(u32 **pdo);
 
 #endif /* __LINUX_USB_TCPM_H */
-- 
2.30.0.478.g8a0d178c01-goog

