Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE852440978
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 16:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhJ3OWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 10:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhJ3OWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 10:22:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC11C061570;
        Sat, 30 Oct 2021 07:20:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 133so1035440wme.0;
        Sat, 30 Oct 2021 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DToYAQHxf/EmU+9Qq/Jcp+BO8Gdd2Z8qCSR2az0OK88=;
        b=lch/4hovwMuDOBS9A1cTb7nQndbyEguJ3+9lcAlXv1X9QT8JN53xNT2HkYxZVFRjmp
         xywnmlU6TprkgBN1WEvKLxrGp2uRJiKaJpTNcMHVcz+7utONDz5PC4Oyxe1j5MbNl7wY
         tjKVEXE35n75hm14SdqYhAkeDILX4WV0gtE0FEOnNzFXr/9eWGmO+4R2qZ6sdVzx4xdm
         k0bq7Hc0iK42ulFXN2Kr6CULXefS8bwDUQhHNWxEV036BY4270T5PZU8hFdZwYj4gvH1
         U/FR9IRiw8+J8WdPfaApjR/tWz2y+OeyTJnx/m2cLamYYsnCMs9DZUWeCKac6F+N43Ey
         rDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DToYAQHxf/EmU+9Qq/Jcp+BO8Gdd2Z8qCSR2az0OK88=;
        b=WKrnroOKR8KbnykoKSjExZVAz5PgVOpld1cxzmpeKJWSCeRuKelTh9hknFQOLKSaNh
         7b40+b9RoYdfTk86thR2+HsByjkqG6mvMKC+CghViEvWVwmedNJ+d/VI8+mAVQUL88EP
         6qx2xGPlDuzhn6kibGVCJVV8IZ9ulyyL0oomCzmlblQ3krNxhMcCNHrxt1oTnTolxEKo
         Kn+vnwByHFXCwtSJ8DYm/RLaW0Y7xy5wg7exldq1bovQQhWUGG8WiO3s3kmEZISGrWcY
         K86QkUZCgfzmLTaWHrZ6pqIXbsrFnnk6hrF+hiQfUqcgmuluGbrurenICira/f0RQ9k+
         tnpA==
X-Gm-Message-State: AOAM530igmvfAv7A/xLBzx+RCsvdnp0e5PiuwqHr4NtThzxxS4ViG0J2
        ngmDYjzdI7o7kUENRwj+WabxKjj8zKHckg==
X-Google-Smtp-Source: ABdhPJxYdplZsYeZu0kDBxVD5SD/C4Oi+ARiKw4LEdiCrHM5gXLecnRUd0iKipp6Y8Vu6fdKX+DQhA==
X-Received: by 2002:a7b:cbc2:: with SMTP id n2mr21756186wmi.123.1635603611767;
        Sat, 30 Oct 2021 07:20:11 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id m12sm8208521wrq.69.2021.10.30.07.20.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Oct 2021 07:20:11 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org, john@phrozen.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
Date:   Sat, 30 Oct 2021 16:20:04 +0200
Message-Id: <20211030142007.27085-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211030142007.27085-1-sergio.paracuellos@gmail.com>
References: <20211030142007.27085-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt binding header for resets lines in Mediatek MT7621 SoCs.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 include/dt-bindings/reset/mt7621-reset.h | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 include/dt-bindings/reset/mt7621-reset.h

diff --git a/include/dt-bindings/reset/mt7621-reset.h b/include/dt-bindings/reset/mt7621-reset.h
new file mode 100644
index 000000000000..7572c6b41453
--- /dev/null
+++ b/include/dt-bindings/reset/mt7621-reset.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021 Sergio Paracuellos
+ * Author: Sergio Paracuellos <sergio.paracuellos@gmail.com>
+ */
+
+#ifndef DT_BINDING_MT7621_RESET_H
+#define DT_BINDING_MT7621_RESET_H
+
+#define MT7621_RST_SYS		0
+#define MT7621_RST_MCM		2
+#define MT7621_RST_HSDMA	5
+#define MT7621_RST_FE		6
+#define MT7621_RST_SPDIFTX	7
+#define MT7621_RST_TIMER	8
+#define MT7621_RST_INT		9
+#define MT7621_RST_MC		10
+#define MT7621_RST_PCM		11
+#define MT7621_RST_PIO		13
+#define MT7621_RST_GDMA		14
+#define MT7621_RST_NFI		15
+#define MT7621_RST_I2C		16
+#define MT7621_RST_I2S		17
+#define MT7621_RST_SPI		18
+#define MT7621_RST_UART1	19
+#define MT7621_RST_UART2	20
+#define MT7621_RST_UART3	21
+#define MT7621_RST_ETH		23
+#define MT7621_RST_PCIE0	24
+#define MT7621_RST_PCIE1	25
+#define MT7621_RST_PCIE2	26
+#define MT7621_RST_AUX_STCK	28
+#define MT7621_RST_CRYPTO	29
+#define MT7621_RST_SDXC		30
+#define MT7621_RST_PPE		31
+
+#endif /* DT_BINDING_MT7621_RESET_H */
-- 
2.33.0

