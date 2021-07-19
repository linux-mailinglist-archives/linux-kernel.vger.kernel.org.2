Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF2E3CF091
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355967AbhGSX33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 19:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359372AbhGSVnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 17:43:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0485C0613B2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:21:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cu14so12576159pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g1VUsyo7cljMbwFDieYIV5JeeNR2RlcZC3D27A3qHS0=;
        b=kRPPvmFXE5Mgwv6tfnWkE5muTpKYOVG1GPrtHQPkNg2Uq0mHyjN4wTBe/SvY0sQ5mr
         KOdfbofNj2wonIXBN43Pd7ACr4mRptJj5t/etiPE7pqSGb7BS5oMCCWb6K1/kFb8FaaR
         MHpVWaFE87Fz4kpxPfwaO09iOE9M8MaFvBue4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g1VUsyo7cljMbwFDieYIV5JeeNR2RlcZC3D27A3qHS0=;
        b=HoQgt3ZWE/KKXfTqskk5GqBNncTjczQq0IDBeT8s7X8464UAtpJiKbr1P3oAjYcNo7
         ChFe4fNYwGvGzYB15IDHCYlN89aLHAUkMWhkPRWarxyns8BpsqTSprwOQfwdHQg8jG2A
         gVD5q3oqdaAPP+8JXuflogAhJ+j4HQz4xYHQsgIjfG84yo4fAO0xmTYkXTsXzIzQPEKa
         1cgEiY1N68IbRGiBFbSORhE1TO7L0gP/fqw7SZ8fYkqAZ+ytPD0eNjCrr9WGeB1/jdTS
         vLO6Vv/DKYskN7SoivVcy0N2gVm2wzThz3y9D5J5M99dUxDMrq/GtBMuKD516WmgyNX5
         KWIw==
X-Gm-Message-State: AOAM5316cOzLi0tpXN/VcADZ5IPZ7tHAM5vyUHhtwIAUqONzLH2yvHfZ
        zvXSGx7a5RH5vY8mrYNPHPJuUA==
X-Google-Smtp-Source: ABdhPJxNEIIx43kLmIxC13TtCzAy+cwH4DSRv1ugrH0M+JFDIXzpmvYBZJWXHwJo/0jMChy783KZ4g==
X-Received: by 2002:a17:90a:8c9:: with SMTP id 9mr31381363pjn.58.1626733297505;
        Mon, 19 Jul 2021 15:21:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:4d0:bf5f:b8cd:2d67])
        by smtp.gmail.com with UTF8SMTPSA id nl2sm17351924pjb.10.2021.07.19.15.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 15:21:37 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-usb@vger.kernel.org,
        Peter Chen <peter.chen@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v14 2/6] of/platform: Add stubs for of_platform_device_create/destroy()
Date:   Mon, 19 Jul 2021 15:21:24 -0700
Message-Id: <20210719152055.v14.2.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
In-Reply-To: <20210719222128.4122837-1-mka@chromium.org>
References: <20210719222128.4122837-1-mka@chromium.org>
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
2.32.0.402.g57bb445576-goog

