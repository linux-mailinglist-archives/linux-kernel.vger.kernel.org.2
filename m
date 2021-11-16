Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B188453A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 21:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbhKPUK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 15:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbhKPUKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 15:10:50 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A63C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 12:07:53 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id m15so121409pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 12:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvDK4g+MssztZL9f0zgas9whsPHn8yfadjOivX02YqU=;
        b=cyZBykbvgBUa1WxWjpfw7wyDr7wRRBZyXCA/JX8pNR7uIzH0Rqm81Cszko7ZIz+QIW
         BgtCMoTYJYcXRfstoAZuAqdx5GQ6PyuOOmrq5CylHIdIZYEikdOIiRUXcAKqFGHbmNRa
         xh29X96REsy7e46OkRth94JCinRyubKmN/WU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvDK4g+MssztZL9f0zgas9whsPHn8yfadjOivX02YqU=;
        b=pBQAN3gjw6ybEaEyuLy7dpa6Sl8SrR1w19qYLZxm6rg72uNJ+aXbRRCvqhgaScQJIX
         gEqKsicxxuvARbuE1wZpg/Xb8CtwvRNJEl2RqGdWczEiBNR8nyAdph1U5GT/sAz4q2cB
         1mhn3jbpQFKyDRQBarQpk2WVy4uznfGNoF+ELKsI+8FxhK2bf0hfx6/ooy4e2YtZlkbI
         zA0HWLBlSIDotsmmqT/9lYWab1r2bjBSd/WjNiKKfePhLx1k85uAW2fZOTCSD4QJHAfg
         od1WB1xflJzgg/GSoJC9IlXFqMEgBFyBIKc0khpcMLCXuIMyxvW2jWh0eDRDd48WRMp4
         nIxQ==
X-Gm-Message-State: AOAM532DoLqPDGKUf/KOoFaUk8dZgPXelbCpdhXGLTYGMbLOUQqvzUKB
        E/kaK1RGYweRG08V+JW2kMb7wg==
X-Google-Smtp-Source: ABdhPJxPC+dDUBDh8PLix9hhdK1SakGbKdPXJrCH/qiTo0UzPSLelJ7Ov0WB3vXQCRxh3+SaX8Eriw==
X-Received: by 2002:a65:6a56:: with SMTP id o22mr1191230pgu.249.1637093272499;
        Tue, 16 Nov 2021 12:07:52 -0800 (PST)
Received: from localhost ([2620:15c:202:201:54aa:73ab:b480:41e2])
        by smtp.gmail.com with UTF8SMTPSA id r2sm7291219pgm.4.2021.11.16.12.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 12:07:52 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v17 2/7] of/platform: Add stubs for of_platform_device_create/destroy()
Date:   Tue, 16 Nov 2021 12:07:34 -0800
Message-Id: <20211116120642.v17.2.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211116200739.924401-1-mka@chromium.org>
References: <20211116200739.924401-1-mka@chromium.org>
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

Changes in v17:
- none

Changes in v16:
- none

Changes in v15:
- none

Changes in v14:
- none

Changes in v13:
- none

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
2.34.0.rc1.387.gb447b232ab-goog

