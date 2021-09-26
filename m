Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B01C4189A9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 16:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhIZPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhIZPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:01:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE109C061570;
        Sun, 26 Sep 2021 07:59:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v17so618123wrv.9;
        Sun, 26 Sep 2021 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xkO4wy2+3E/bRHxiF+Cv5z6Xhl/K+wMhVZfJg/wDmc=;
        b=EO+MRnbUJhIWMxCoS8uOTSzbRCpm6oDifs8ih4CVNKOvxfCP5//CgH5Pbv0/0FYJWN
         O/ADm6iMFv3ozd20PK2t8VE0t+Dfw4ZCg1k6DlQa/fLQdKSOukxrw6B6zzh0g9imzM8L
         75nt0KnTxJE4FGPIYbHjrXPDkUr2wPDKtFjEZO/2X+XFl3SkQOVngYx1aXI/uq0SUyxR
         MZ1nf2QPMBOgRcwv41z9ng01bmLxrGwtLZJ0+fr+1hodORyE8XbHOuKU4ikVZY8dU2/H
         7kWZxKJNe4UIVTj0fFf4qIcJKwJRd3+ERlL8p9E46AcXrWX4UiH90rW8cGfN69kLff9/
         XztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xkO4wy2+3E/bRHxiF+Cv5z6Xhl/K+wMhVZfJg/wDmc=;
        b=XjKCjPaoJP8P0NBBsFOcAcjDvTspMI+yML3YFtO90Cr+EhuS8zkYF51Tf+OlMM8RjK
         wJH2oY7ETNVq17Tl9vtfwqGCmARV6/vdRGQEDgoyQYEyyeb7G2b1P7k75nlRsaU9eT70
         akPYPYeERlrSnwzkKbvmRF8Cw9whgNsIRE59xcw4OYuUssIXg8sc8LmvSkzWRTfYG96Z
         NtDwb4cqK6tm0lxGvPFLrwSVePIOSR1omfaFKFu4tKh+RL25idqmtY54n1BT0I6o2eJ6
         MVEvmlua8nN3c0GP0WFEGQnjrG7j/JP6m6jdna4zETEFn7GIxIWg0zSJeP53nR4HLScf
         bz4g==
X-Gm-Message-State: AOAM532YF/HoiO+NOa6sYbOx+ynD7Xsxm3blSqCyttkMcic2u8AZDIfS
        gIgfAiSx3G2eQ5NGuYFBkZM=
X-Google-Smtp-Source: ABdhPJxBsp32YkM0y46bTL/Sw3B4+akzcO9XXCL6RyWk6kN7NFkkVCHOPvbubutg6cG0ORD2jbdPWw==
X-Received: by 2002:adf:f946:: with SMTP id q6mr11250450wrr.437.1632668374530;
        Sun, 26 Sep 2021 07:59:34 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id n7sm14143840wra.37.2021.09.26.07.59.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 07:59:34 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     robh@kernel.org, john@phrozen.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: reset: add dt binding header for ralink RT2880 resets
Date:   Sun, 26 Sep 2021 16:59:29 +0200
Message-Id: <20210926145931.14603-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926145931.14603-1-sergio.paracuellos@gmail.com>
References: <20210926145931.14603-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds dt binding header for 'ralink,rt2880-reset' resets.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 include/dt-bindings/reset/ralink-rt2880.h | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 include/dt-bindings/reset/ralink-rt2880.h

diff --git a/include/dt-bindings/reset/ralink-rt2880.h b/include/dt-bindings/reset/ralink-rt2880.h
new file mode 100644
index 000000000000..266ef521a584
--- /dev/null
+++ b/include/dt-bindings/reset/ralink-rt2880.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Sergio Paracuellos
+ * Author: Sergio Paracuellos <sergio.paracuellos@gmail.com>
+ */
+
+#ifndef DT_BINDING_RALINK_RT2880_RESET_H
+#define DT_BINDING_RALINK_RT2880_RESET_H
+
+/*
+ * Ralink RT2880 SoC reset controller register bits.
+ */
+#define RALINK_RT2880_SYS	0
+#define RALINK_RT2880_MCM	2
+#define RALINK_RT2880_HSDMA	5
+#define RALINK_RT2880_FE	6
+#define RALINK_RT2880_SPDIFTX	7
+#define RALINK_RT2880_TIMER	8
+#define RALINK_RT2880_INT	9
+#define RALINK_RT2880_MC	10
+#define RALINK_RT2880_PCM	11
+#define RALINK_RT2880_PIO	13
+#define RALINK_RT2880_GDMA	14
+#define RALINK_RT2880_NFI	15
+#define RALINK_RT2880_I2C	16
+#define RALINK_RT2880_I2S	17
+#define RALINK_RT2880_SPI	18
+#define RALINK_RT2880_UART1	19
+#define RALINK_RT2880_UART2	20
+#define RALINK_RT2880_UART3	21
+#define RALINK_RT2880_ETH	23
+#define RALINK_RT2880_PCIE0	24
+#define RALINK_RT2880_PCIE1	25
+#define RALINK_RT2880_PCIE2	26
+#define RALINK_RT2880_AUX_STCK	28
+#define RALINK_RT2880_CRYPTO	29
+#define RALINK_RT2880_SDXC	30
+#define RALINK_RT2880_PPE	31
+
+#endif /* DT_BINDING_RALINK_RT2880_RESET_H */
-- 
2.25.1

