Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006F6423CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbhJFLZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbhJFLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:25:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E02AC061749;
        Wed,  6 Oct 2021 04:23:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v17so7734220wrv.9;
        Wed, 06 Oct 2021 04:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMW4foefc6bEFLqLQ2H0asFN0IF8jIbnNoNDfv9QTpo=;
        b=fqdoZhMJ2rxSvh2lAg5TQLQ6khL0EhpVeNi4HptuzUZ1DC3nJNGIPgvplHbMR76SeG
         tE+zzecpcLnJU5QQF05MnQrHtQbUemmbu1R6HLp8c9S47FR70J57K6ovtyOM65f8M6ih
         PFZUHsOON6/HLhhmHOHAr6wdjR+GkNljvpSXtIm1QpL5Gti0XljT56KRRtf/G6RsqTFB
         y6u3ydnPQpjnlIQA2q/9pnH5T2uqARPPc5mY7feGiQRBaP4xeVtbGGn6SjmKuoCTtx06
         HVk7gdoqFC7wgyRkwpLkqY46OkBcZh0OnWuNb1pJCr8W6FKR4/G3z7ty99I7PY2w1VYP
         KZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMW4foefc6bEFLqLQ2H0asFN0IF8jIbnNoNDfv9QTpo=;
        b=2PdPYCZXndpd/kVPuaEpiXvIc2XfJxjeokS0LMTzd9JkDrCF4VdncZZuUKL6y/HqRV
         2omdA4X6/W8omr9Wr0L2DtSMfvq67eHZcFcMfKuMiH7bHya6fcBBU4SzWWnbBPnXSUVX
         AReD+6LfG5Xmsebzxi0Uoymgx2lmlgtcVAtlAEyUCsckEtw4Eu+pgkgpNnfYw+tyGz73
         IcyzZnNaTbW31CkCPEZZpAbcrXDKCC01RTBIJKtLd7tdQUCBjxIbBGq2isIxbKLX21L5
         fG04HdVesEx0SLz4Ch5iLuv45uZQbuyCUglVFMqwYsTuTIs794a4Mdx4i52DDpGEPUKs
         i2Wg==
X-Gm-Message-State: AOAM532K/33rfdzmrL9urJ3VBhfE1Pp04/8364MgTQEUYUYq9eKOH5NA
        rO4NKHUsf+4x+fHp0MRS1WSFzJLQgzA=
X-Google-Smtp-Source: ABdhPJy9s/UAVv/L8Zfm9yvqWMej5Q+dXlji9BY4WfNy30A6S0GHmbTvPS+EYEKibZtyWtSJQgEwGg==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr9314376wml.126.1633519388877;
        Wed, 06 Oct 2021 04:23:08 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id e14sm10801985wrw.33.2021.10.06.04.23.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Oct 2021 04:23:08 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org, john@phrozen.org
Subject: [PATCH v2 1/4] dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
Date:   Wed,  6 Oct 2021 13:23:03 +0200
Message-Id: <20211006112306.4691-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006112306.4691-1-sergio.paracuellos@gmail.com>
References: <20211006112306.4691-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt binding header for resets lines in Mediatek MT7621 SoCs.

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

