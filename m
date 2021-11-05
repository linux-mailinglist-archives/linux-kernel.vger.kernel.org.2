Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2054462ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 12:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhKELmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 07:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbhKELlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 07:41:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EC8C061203
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 04:39:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g14so31484708edz.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 04:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ck6CnoOUEpGTUA7mAEjajeF6BgfIwURf2ogwlOV0P5c=;
        b=jmLBKKyKZ8Ekwd8uM8vB3tZ+PPyyhmcVZq2ecajkPXURrhRvA8olhb+jkvV9VP5Ef0
         CdF7zr+OIiA1xk9njuhrggek/F14dtzsIynJCxtcwYg4jutcZ3NtUAay7XR1HBNdFMSG
         NYqBAQJWwA6mWo7bdz0kOWo+fRTqX9qB3a46wuW9ebEjSG+2PQG+PDMSWLzc1m84JN6k
         y6iyveiy1U0CVbrY/5tl7DCHBjqH3BoVNk9oAEt78TacX+6tgkv8wAlr8USOnww94IKj
         33IReUWs55pYrJgHob8M+YDRgyncHBPO3U0GCcH3e3fnrC6DAd2sKX7gV9mbgHQ9rWmV
         STdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ck6CnoOUEpGTUA7mAEjajeF6BgfIwURf2ogwlOV0P5c=;
        b=fJAwV51Di7s0mH+FCsLTpfLaCRb0OJnRBsvMpXL5tr6+1LbdbuikU8GbhPC2u5q1tX
         P64RBpLfwIxbgIwP8UAPwPhvb8OngU2xz8CjakH/JxpR2IWaIJfePmrNirPVF1FFxLg2
         3xRtS3SkMZ79lpBAfEaeeCj/+mdWkEcxCqSfzlzhFXrYJnJDhvMWYkQXNFqahM3HoBYq
         wtPsOt4QdtWOrLuUsTOQqG8rZuxRrUcEnG4bwORkb+RvLNzGr/Hy0nqQaAXT2+8o6ATg
         l9ayU2cAs0hQaEdPFWGWGLyGxM/Efjz3SQcKJsNw/8KLEwBmFew4cuMDGt4VpUIm0Wmi
         xmiQ==
X-Gm-Message-State: AOAM5328z/Zummj4t7LQrdLdTIfuK7r9f3YlVLm9w4RvoienmwkpwfVY
        tkQb+GTOmLUWix7nG4xLRfTyyA==
X-Google-Smtp-Source: ABdhPJwQJ6pI2myDid81p56qbL+BAalAoh+JzDW0wFzYPYZCMHeodMIpnqBmUyjdDFPX+nQoHngiHA==
X-Received: by 2002:a17:907:e86:: with SMTP id ho6mr51083665ejc.197.1636112348961;
        Fri, 05 Nov 2021 04:39:08 -0700 (PDT)
Received: from fedora.. (dh207-99-83.xnet.hr. [88.207.99.83])
        by smtp.googlemail.com with ESMTPSA id bn20sm4011325ejb.5.2021.11.05.04.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 04:39:08 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, lee.jones@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        michael@walle.cc
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v8 3/6] dt-bindings: reset: Add Delta TN48M
Date:   Fri,  5 Nov 2021 12:38:56 +0100
Message-Id: <20211105113859.101868-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105113859.101868-1-robert.marko@sartura.hr>
References: <20211105113859.101868-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header for the Delta TN48M CPLD provided
resets.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 include/dt-bindings/reset/delta,tn48m-reset.h | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/reset/delta,tn48m-reset.h

diff --git a/include/dt-bindings/reset/delta,tn48m-reset.h b/include/dt-bindings/reset/delta,tn48m-reset.h
new file mode 100644
index 000000000000..d4e9ed12de3e
--- /dev/null
+++ b/include/dt-bindings/reset/delta,tn48m-reset.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Delta TN48M CPLD GPIO driver
+ *
+ * Copyright (C) 2021 Sartura Ltd.
+ *
+ * Author: Robert Marko <robert.marko@sartura.hr>
+ */
+
+#ifndef _DT_BINDINGS_RESET_TN48M_H
+#define _DT_BINDINGS_RESET_TN48M_H
+
+#define CPU_88F7040_RESET	0
+#define CPU_88F6820_RESET	1
+#define MAC_98DX3265_RESET	2
+#define PHY_88E1680_RESET	3
+#define PHY_88E1512_RESET	4
+#define POE_RESET		5
+
+#endif /* _DT_BINDINGS_RESET_TN48M_H */
-- 
2.33.1

