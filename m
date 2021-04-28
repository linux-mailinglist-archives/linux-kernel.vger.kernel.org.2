Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD88836DD4A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbhD1QnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241144AbhD1QnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:43:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B283C061343
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:42:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m5so7432577wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GXfkThm6aq9/u6OAWtarhuCMLfUI31qoTKi2l6tIb1k=;
        b=xmU+qrHv7iCFgEre0umPEDJpoZFKUJz6PeWoEJP7kgqcPPnt2GlvfbWlgxgRcRoW5m
         Hlbp1sBTPIZTSY3NmfBfy9a97mH1Ry/9oJ5dcLzE9476WrKmNNJgX89m+k5t8oVi5Dms
         2qAK3qEAH2yE5ZjhCOHOHK4iWR8MUoPxkBT+AQeDHe8vTVmaktGMpJ5A/41cO1LvIa7Y
         Z5ROiKowdVjW+OqMPGsyQVbM1GmAIGwBNOv8zs0gxF+14n4x2xFcNadLaVm3n3zmQbz5
         EZXHsua4uW1IXTUQ3N4/HYs5Lj5SNmLVLVmkbVejPCblZfW/+wdQQmgGssV+YiLqRcbn
         8rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GXfkThm6aq9/u6OAWtarhuCMLfUI31qoTKi2l6tIb1k=;
        b=BH1PKtWIIz3oj2k2G2Kp5qe9TyQqYCjLjBuX1K2EaTOaaCZUblBBx0k/pZ2g78eYOK
         EhYBZJL9tf5LSRY94uziHv+5ym0wIee3Iqc2c8IJD0MPmChuYPR18tdi5QzAOUh6Sv3G
         4xzDtLor/PJqfV26avDIeQvKZqDnVbiRzsyxsCIxhELVYmmQTl6TFDZQLjqKEDNTISJT
         kbi7O47QOwrs0B15LAy++voXoB9/N7L2NG0MLUCT9wbzzzBbcuw0jZj2LiaXGwsyQu8n
         m5t32oLuE0FQpYW6aNLbggvZhpEVBFcaBJk3FCIDs3Vnwkjji279jR/s33WM0WQVfnyJ
         0u6Q==
X-Gm-Message-State: AOAM5311fIPAftkboDCWmgOOTbZOXl+mV+6yUmTF3gAogCtsDxvZ4CXn
        j7SS8zZTnaDA3Tc621SWfAY9XA==
X-Google-Smtp-Source: ABdhPJzejFayeWt08Qeq2ENMXWRVl7HiK9xF6puIKoeU6c94FV5RAzpo0AXm6LqYCBzjp3xJke7duA==
X-Received: by 2002:a1c:398a:: with SMTP id g132mr5691770wma.114.1619628151214;
        Wed, 28 Apr 2021 09:42:31 -0700 (PDT)
Received: from groot.home ([2a01:cb19:826e:8e00:5864:ddd1:d623:f912])
        by smtp.gmail.com with ESMTPSA id o10sm351299wrx.35.2021.04.28.09.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 09:42:30 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     fparent@baylibre.com,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] mfd: mt6397: Add PMIC keys for MT6358
Date:   Wed, 28 Apr 2021 18:42:18 +0200
Message-Id: <20210428164219.1115537-7-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210428164219.1115537-1-mkorpershoek@baylibre.com>
References: <20210428164219.1115537-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds compatible strings and interrupts for pmic keys
which serves as child device of MFD.

MT6358 has two interrupts per key: one for press, another one for
release (_R)

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/mfd/mt6397-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 8738b5524783..13a5e15e9dd6 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -45,6 +45,13 @@ static const struct resource mt6397_rtc_resources[] = {
 	DEFINE_RES_IRQ(MT6397_IRQ_RTC),
 };
 
+static const struct resource mt6358_keys_resources[] = {
+	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_PWRKEY, "powerkey"),
+	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_HOMEKEY, "homekey"),
+	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_PWRKEY_R, "powerkey_r"),
+	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_HOMEKEY_R, "homekey_r"),
+};
+
 static const struct resource mt6323_keys_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_PWRKEY, "powerkey"),
 	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_FCHRKEY, "homekey"),
@@ -96,6 +103,11 @@ static const struct mfd_cell mt6358_devs[] = {
 	}, {
 		.name = "mt6358-sound",
 		.of_compatible = "mediatek,mt6358-sound"
+	}, {
+		.name = "mtk-pmic-keys",
+		.num_resources = ARRAY_SIZE(mt6358_keys_resources),
+		.resources = mt6358_keys_resources,
+		.of_compatible = "mediatek,mt6358-keys"
 	},
 };
 
-- 
2.27.0

