Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6B440995
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 16:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhJ3Omu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 10:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhJ3Omt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 10:42:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDF9C061570;
        Sat, 30 Oct 2021 07:40:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso5811945wmd.4;
        Sat, 30 Oct 2021 07:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DToYAQHxf/EmU+9Qq/Jcp+BO8Gdd2Z8qCSR2az0OK88=;
        b=a53BaJ/pGJ3Hj01nFTpBqLr4jU05yNGuyqncmlBy+RmTLQrM8VbMFWJy+0rKgVVphe
         xfI0NfjE1wtNbyBsZgb4obty9Zk5A3uAB4n9NVtNVzn2vGK9y2+XSSQP74YhusdENAgY
         r19CnsOa7O/IechMMK3ivb/hI59eQc8XHWC4YdiqCDZDYhLV7V9V23eC60OklNAgL0Q5
         QkpPnxH3Bsib1MJxv+xlxlhgoKY/cHtcbiA+ZhV/irtQdglsV6foMdCwaK6btX0L9kSq
         ELsgXG0weVSyJUJj6jOY62MlzsqPCZqEVRMO3kE9K+AtbAkf2/XDgSdUn9N9i8YXXZuN
         xi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DToYAQHxf/EmU+9Qq/Jcp+BO8Gdd2Z8qCSR2az0OK88=;
        b=Iu4V2DvY9amLtPL8UmpbEb9fY3/AwuHcfRGCLinJwz9yodCg7ICIBcSEE7jJGzzaWc
         d5eI/BUIrQz9aeggBgwqqFxApWodBZ4h3q6l1t5KnnIkIJ1iTO0hascwHco06P2aCDp6
         34JyMqBIktQKlTuLwSzoC6W/0Be0Nh12QJpndWt32/B0bntrreSD3OGnFtf9iIiKSf+B
         8ODRnojs6SY0VfrbnSlbTKUlYmUvn23O+6eRY271c8ft0GRDpzrE7ikVTMoczO/XRyXl
         GVni1vTdUWN9o8r0vpZYCVMP3S8p3YfDYQok6gqcBCZpYgMHUNx5HmZ6B7HeBo8FHh0x
         JIOg==
X-Gm-Message-State: AOAM531S4Blo9uJVbj/+X/arTbSbkmp1x/zhYaFYvVpQSWn5uQ7Or1Gt
        b3LjwpVFEfUoDV2hbxTsdHY=
X-Google-Smtp-Source: ABdhPJzXEmb4NsKsRqQU3A4l8zsj0JrJBwWolog/9AGpwCkOKdzKsMv2kO2ecoDitQlKYo1XMHO3jw==
X-Received: by 2002:a05:600c:4f81:: with SMTP id n1mr26909887wmq.63.1635604817623;
        Sat, 30 Oct 2021 07:40:17 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id u19sm483602wmm.5.2021.10.30.07.40.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Oct 2021 07:40:17 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org, john@phrozen.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
Date:   Sat, 30 Oct 2021 16:40:11 +0200
Message-Id: <20211030144014.26315-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211030144014.26315-1-sergio.paracuellos@gmail.com>
References: <20211030144014.26315-1-sergio.paracuellos@gmail.com>
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

