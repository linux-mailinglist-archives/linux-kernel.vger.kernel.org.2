Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19AA4237D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbhJFGOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbhJFGOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:14:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AFEC061749;
        Tue,  5 Oct 2021 23:12:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u18so5249450wrg.5;
        Tue, 05 Oct 2021 23:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMW4foefc6bEFLqLQ2H0asFN0IF8jIbnNoNDfv9QTpo=;
        b=e7WgKi5k+F0e4KVHalUl0lt6lYta3FL9Lkj0By+kc+nNmKihLUhm3SfM1xLx5Mu+1l
         pmpIU2EbRexP0Zqdig9TajTW6ADUosnNfNUn7jtko/sE0jSOW7CQAjioh62b953JLM3O
         RGxKtsSZzDp3ALgtv7+rUJICwcQ1Kw0khoWA6ggL6mdd6ONsbmq1hxh3+xUrQwqPNvhr
         GixcQLr9D3DxEhuTsUtzfl9Q/nSI9l2L0wj6A7F0ig2ZBaHJ9gnjIFt4fAGkIuWc4sKS
         pi1rg3Un8B5QyukJICIWtpFrYvP8i7WIjSpOwd6pkZQWV7F8/hDwDGen/znRoq/CvpLi
         Cyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMW4foefc6bEFLqLQ2H0asFN0IF8jIbnNoNDfv9QTpo=;
        b=DX/+yQ1Z55VtOvun3aABPvCS5XKhclJfxhXwG1nN8M/XPk1h1DbmESExV1sMvemehG
         XTP3uuS33ylN6DAdZGJhUPb9ZclZ/a0+TB7y938rIF/IvJjF2Bksc9Hcep7LSL05unVD
         GdN0m2a+IMG7I/WsiigDp2pMBg1DcKIaWe2Zs75o+DSWKBl0PRobOCdtnl11XA9QV4Qu
         AWtaF47qWR1H9T8/Z9taV8TRZ5iYIRnJXFtQDFFc880Da/nA18QJl/jYHTq2Xn0lKYs+
         wNvksROgrq3Yx70UOudcZhZsrbtQZSn0vSwe5PICGzXSb4ITkqJGDaudZsI9NBSGdiRY
         AgKQ==
X-Gm-Message-State: AOAM531EQScuVjJjk3TMVUjkW4eqx+Ir784ZVjY3xpXjZV14MmTYOdaW
        0gB61Zwu8ofDP0kPqkQa3GI=
X-Google-Smtp-Source: ABdhPJzWFOAKHtnF6xn6CskP/tAMoCqT71fSDgdsfiv31c5iXRR6qJf29QeN5a8UFgqEsQWkRwWT0Q==
X-Received: by 2002:a05:600c:3b22:: with SMTP id m34mr7622500wms.130.1633500727710;
        Tue, 05 Oct 2021 23:12:07 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id e8sm3893071wme.46.2021.10.05.23.12.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Oct 2021 23:12:07 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org, john@phrozen.org
Subject: [PATCH 1/4] dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
Date:   Wed,  6 Oct 2021 08:12:01 +0200
Message-Id: <20211006061204.2854-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006061204.2854-1-sergio.paracuellos@gmail.com>
References: <20211006061204.2854-1-sergio.paracuellos@gmail.com>
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

