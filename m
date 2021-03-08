Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3E3315EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhCHSYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:24:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36029 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhCHSXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:23:54 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lJKXp-0004CI-FJ
        for linux-kernel@vger.kernel.org; Mon, 08 Mar 2021 18:23:53 +0000
Received: by mail-wr1-f70.google.com with SMTP id e29so5189061wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 10:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jymu3EByRYEIYMZqwvOwIlXmg/aB/evOdJ/m4CaTdu4=;
        b=LWM/O+0ZskJaPugbGbgl919t5PWZsaX9eZEwpM1GJyTT+InQ/yQzXwNLLSdJlf5Dgl
         uXPiNKQMKJVVwIiz+uVkQKDJgWURRiYZssRj1Yc2ZnoQuQluigYatxzQ626fGaGWQbj+
         YeBACLQR5KvByGOlGSVYTm0c0SzF4ZzrSzDcvMhfCPROn+qb5/2iTn34FuZhVlpelr2y
         dxAR/RAEVab4v5mRxv7J4RAkksLgqxAWDopTm4IOKHG6EK63WbB0oLM6O7k61liPoSKx
         rqVEnbCBSNLkj9HpGTtC+sGJ7aRJXs5ymFG1AOUXntM0D+FsnEHi7aem/uRFhs/G+o4m
         Srcw==
X-Gm-Message-State: AOAM532fQ64UVk2eaRlOJl6WpxuyVOn+cOyoWxdrRLNJrPlvcouNJSib
        D2Sel0PmXb8HSgiQ0nR/hBICIsHmR6zvmO4rX3UjPDwvtqqlWnCdHjlz4TPBKu3J7BFqudimFil
        9g9/MlGKS4BKgzrBVtNuCG6n1ZDBQiUFAmITh4dQw1Q==
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr90593wmq.71.1615227833246;
        Mon, 08 Mar 2021 10:23:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvx3QjvMhUgtRrkNT3iony3aNl5ECgG9Nj1FpImbQaEIixS7Crze+Ph3daeR20dkp9tEnIeQ==
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr90579wmq.71.1615227833061;
        Mon, 08 Mar 2021 10:23:53 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id f22sm158207wmb.31.2021.03.08.10.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:23:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/3] clk: socfpga: drop duplicated lines in Makefile
Date:   Mon,  8 Mar 2021 19:23:38 +0100
Message-Id: <20210308182339.379775-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308182339.379775-1-krzysztof.kozlowski@canonical.com>
References: <20210308182339.379775-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three clock drivers are used by Stratix 10, Agilex and N5X, so use
separate dedicated Kconfig entry to get rid of duplicated Makefile
lines.  This will also allow later compile testing.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clk/socfpga/Kconfig  | 7 +++++++
 drivers/clk/socfpga/Makefile | 3 +--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/socfpga/Kconfig b/drivers/clk/socfpga/Kconfig
index cae6fd9fac64..4922cc35f4cc 100644
--- a/drivers/clk/socfpga/Kconfig
+++ b/drivers/clk/socfpga/Kconfig
@@ -1,6 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
+config COMMON_CLK_STRATIX10
+	bool
+	# Intel Stratix / Agilex / N5X clock controller support
+	default y if ARCH_AGILEX || ARCH_N5X || ARCH_STRATIX10
+	depends on ARCH_AGILEX || ARCH_N5X || ARCH_STRATIX10
+
 config COMMON_CLK_AGILEX
 	bool
 	# Intel Agilex / N5X clock controller support
 	default y if ARCH_AGILEX || ARCH_N5X
 	depends on ARCH_AGILEX || ARCH_N5X
+	select COMMON_CLK_STRATIX10
diff --git a/drivers/clk/socfpga/Makefile b/drivers/clk/socfpga/Makefile
index e3614f758184..8a875de971fc 100644
--- a/drivers/clk/socfpga/Makefile
+++ b/drivers/clk/socfpga/Makefile
@@ -2,6 +2,5 @@
 obj-$(CONFIG_ARCH_SOCFPGA) += clk.o clk-gate.o clk-pll.o clk-periph.o
 obj-$(CONFIG_ARCH_SOCFPGA) += clk-pll-a10.o clk-periph-a10.o clk-gate-a10.o
 obj-$(CONFIG_ARCH_STRATIX10) += clk-s10.o
-obj-$(CONFIG_ARCH_STRATIX10) += clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o
+obj-$(CONFIG_COMMON_CLK_STRATIX10) += clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o
 obj-$(CONFIG_COMMON_CLK_AGILEX) += clk-agilex.o
-obj-$(CONFIG_COMMON_CLK_AGILEX) += clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o
-- 
2.25.1

