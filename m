Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9967A3A1FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhFIWFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:05:53 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:35565 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFIWFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:05:52 -0400
Received: by mail-pg1-f180.google.com with SMTP id o9so18055786pgd.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jdb1/nf8Xf9cHJr9ZwJVMdonN98y7jZdc9Uui2zD+k=;
        b=R5+Kw9O6I/1IU7kGnU0zCC2WYUDL/FKN3hR9p1DTSWqqrBG27MXbHsMkqbygwGuPW3
         bO/Wq4Z1GIilKr2Jrs4OMtzYEqOk28JSyj8hyIRqE7GDNDifwwKWwvegTd3JVRdOPtP0
         F4K1d8+MiIR5RmqrKs6w6YNeURP3rNVdGDt2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jdb1/nf8Xf9cHJr9ZwJVMdonN98y7jZdc9Uui2zD+k=;
        b=rJJHCQgArCC5q3JUjJRva1HLPLRG0mQQJkk77Me43ck61siJs7iTA5k2aP9iZAXj7X
         fkFxZJdonSdsqmzfc6umVFCIf1Ct/yed5wDHq9SKsscyHFwUHCc2SotcA+JEnZr2larf
         zvuAUIW6A8eg1u4EZIRdWfUCT0ZUEzV6DTcey0oblKTUo/XWEfgqDYHMCC35wpkQ9qT6
         Ib0gQuEkb8cFBBxU6lhxX4Y4/XM9dwmnu5jswg+Vsm4McmpcD2rRTwixwZ8MIFhpL/PI
         bXEFkrVPKldc/SYLYD2ZiA5eoyQ12dknp9OOQRgPQPB2fF3fPW92sr/CQjcplZf473og
         k68Q==
X-Gm-Message-State: AOAM531yKhvFTP8qplq0fgieQIH4VaU7YmXqxjXW5gBngTcZiFj200z7
        u3BhXDZX88uFogfOWsJpL+wkhg==
X-Google-Smtp-Source: ABdhPJzI+fIpPynsyQz/5H0at0akyidamyrNszW2JK2IwL29M8TGVkWfOER20Wk69wGis6Op8lNzig==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr1789309pgv.96.1623276177491;
        Wed, 09 Jun 2021 15:02:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:cedb:c2b5:f22c:760])
        by smtp.gmail.com with UTF8SMTPSA id v15sm430659pfm.216.2021.06.09.15.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 15:02:57 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Bastien Nocera <hadess@hadess.net>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v12 3/5] of/platform: Add stubs for of_platform_device_create/destroy()
Date:   Wed,  9 Jun 2021 15:02:47 -0700
Message-Id: <20210609150159.v12.3.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
In-Reply-To: <20210609220249.86061-1-mka@chromium.org>
References: <20210609220249.86061-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code for platform_device_create() and of_platform_device_destroy() is
only generated if CONFIG_OF_ADDRESS=y. Add stubs to avoid unresolved
symbols when CONFIG_OF_ADDRESS is not set.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v12:
- none

Changes in v11:
- none

Changes in v10:
- none

Changes in v9:
- added Rob's 'Acked-by' tag

Changes in v8:
- fixed C&P error in commit message

Changes in v7:
- none

Changes in v6:
- patch added to the series

 include/linux/of_platform.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 84a966623e78..d15b6cd5e1c3 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -61,16 +61,18 @@ static inline struct platform_device *of_find_device_by_node(struct device_node
 }
 #endif
 
+extern int of_platform_bus_probe(struct device_node *root,
+				 const struct of_device_id *matches,
+				 struct device *parent);
+
+#ifdef CONFIG_OF_ADDRESS
 /* Platform devices and busses creation */
 extern struct platform_device *of_platform_device_create(struct device_node *np,
 						   const char *bus_id,
 						   struct device *parent);
 
 extern int of_platform_device_destroy(struct device *dev, void *data);
-extern int of_platform_bus_probe(struct device_node *root,
-				 const struct of_device_id *matches,
-				 struct device *parent);
-#ifdef CONFIG_OF_ADDRESS
+
 extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
 				const struct of_dev_auxdata *lookup,
@@ -84,6 +86,18 @@ extern int devm_of_platform_populate(struct device *dev);
 
 extern void devm_of_platform_depopulate(struct device *dev);
 #else
+/* Platform devices and busses creation */
+static inline struct platform_device *of_platform_device_create(struct device_node *np,
+								const char *bus_id,
+								struct device *parent)
+{
+	return NULL;
+}
+static inline int of_platform_device_destroy(struct device *dev, void *data)
+{
+	return -ENODEV;
+}
+
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
 					const struct of_dev_auxdata *lookup,
-- 
2.32.0.rc1.229.g3e70b5a671-goog

