Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4751232BED9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377500AbhCCRp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376780AbhCCOaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:30:30 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C52C061222
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:24:36 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h98so23866613wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=it9P+DK6iP5ErXy9xYVyQcqeuX2qzCsyNDD/pOpRMy8=;
        b=bCv0+BZqoHxmgNSoh3joTZ0q1LHIPhmjZuKV0OGmOkG4szC9K8mr5c3x4o3/55qPvR
         TFyqxXYXXQaaXLajKGcgmFrzJ/uAeZK0EhV6u2SbBZ1vSgwHpA5CS1nkzSSdG7p2xCX4
         GRsLxCg7Cx/cZeRjVYNei/8ZQCzo9m3awXUyzRGhEKVr109SsSurUUCbwHZfzkmey5kX
         yi2nE3Kamp2p8Vaw+AXUzZI7LhGJxQsVyYgYsPyCCzr4Nn6W8TuuAn58GWG+lh1YcyF2
         BrLxXAXAn/nXa/XbnYarXVNzFXIrdNSMf1U8r7nXuG1VVCLVNjg/Rt3IgcU+rYSw2LaM
         CDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=it9P+DK6iP5ErXy9xYVyQcqeuX2qzCsyNDD/pOpRMy8=;
        b=I19JAIyT3816GrjL+SC3uR2mnBCDlMmJPUGN9xhS0PItM2Bcx6B/6/fk0BKszkkAq9
         AGmDT4995+AwSqiCbrjCfrN6xzmN2YMpoOuZCZCCA61a4DaEc+D46Y2jkWAS6GxH9VOi
         pWwUu+0XTq6y1Dj1qIH6qASmmxal3KSSHZVaEZul88UvkST09kxw8i7xR286Wsu/olRG
         zveIPpMJWEsmcD9ASOSzGFXK8j2JkNMOC3o4gOYj2/qJ8c40n/HLOCoLdBd1I7r/hJUp
         Zt34MzR6FptblippGyRU/Z0uF6W9V9jVxwZywrfCYQ5zCOb9+G1gzh7uBu3bBN10urIi
         Yu+w==
X-Gm-Message-State: AOAM5330J9X21c3lkfvSyqYqWi1yhLUSn0zucq5Jr9w7bL1VPEsOZoiA
        aXHqRt5oArlkHuHZwJJo1xMPYA==
X-Google-Smtp-Source: ABdhPJw3CMoWWzbFtNcbV2/R1Pvc1edPxvMhVQScvKeuKIRLwW+pwgQ1OvHFltJYOw7xGmviS7p9lw==
X-Received: by 2002:adf:e791:: with SMTP id n17mr27533260wrm.322.1614781474798;
        Wed, 03 Mar 2021 06:24:34 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id b17sm10202399wrt.17.2021.03.03.06.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:24:34 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH 1/1] clk: sunxi: Demote non-conformant kernel-doc headers
Date:   Wed,  3 Mar 2021 14:24:30 +0000
Message-Id: <20210303142430.3168703-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Headers must describe their parameters.

Fixes the following W=1 kernel build warning(s):

 drivers/clk/sunxi/clk-sun9i-core.c:27: warning: Function parameter or member 'req' not described in 'sun9i_a80_get_pll4_factors'
 drivers/clk/sunxi/clk-sun9i-core.c:100: warning: Function parameter or member 'req' not described in 'sun9i_a80_get_gt_factors'
 drivers/clk/sunxi/clk-sun9i-core.c:155: warning: Function parameter or member 'req' not described in 'sun9i_a80_get_ahb_factors'
 drivers/clk/sunxi/clk-sun9i-core.c:235: warning: Function parameter or member 'req' not described in 'sun9i_a80_get_apb1_factors'
 drivers/clk/sunxi/clk-usb.c:22: warning: cannot understand function prototype: 'struct usb_reset_data '
 drivers/clk/sunxi/clk-sun6i-ar100.c:26: warning: Function parameter or member 'req' not described in 'sun6i_get_ar100_factors'

Cc: "Emilio López" <emilio@elopez.com.ar>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/sunxi/clk-sun6i-ar100.c | 2 +-
 drivers/clk/sunxi/clk-sun9i-core.c  | 8 ++++----
 drivers/clk/sunxi/clk-usb.c         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c b/drivers/clk/sunxi/clk-sun6i-ar100.c
index e1b7d0929cf7f..54babc2b4b9ee 100644
--- a/drivers/clk/sunxi/clk-sun6i-ar100.c
+++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
@@ -16,7 +16,7 @@
 
 #include "clk-factors.h"
 
-/**
+/*
  * sun6i_get_ar100_factors - Calculates factors p, m for AR100
  *
  * AR100 rate is calculated as follows
diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
index 305ad78d5fb4f..d93c7a53c6c02 100644
--- a/drivers/clk/sunxi/clk-sun9i-core.c
+++ b/drivers/clk/sunxi/clk-sun9i-core.c
@@ -14,7 +14,7 @@
 #include "clk-factors.h"
 
 
-/**
+/*
  * sun9i_a80_get_pll4_factors() - calculates n, p, m factors for PLL4
  * PLL4 rate is calculated as follows
  * rate = (parent_rate * n >> p) / (m + 1);
@@ -90,7 +90,7 @@ static void __init sun9i_a80_pll4_setup(struct device_node *node)
 CLK_OF_DECLARE(sun9i_a80_pll4, "allwinner,sun9i-a80-pll4-clk", sun9i_a80_pll4_setup);
 
 
-/**
+/*
  * sun9i_a80_get_gt_factors() - calculates m factor for GT
  * GT rate is calculated as follows
  * rate = parent_rate / (m + 1);
@@ -145,7 +145,7 @@ static void __init sun9i_a80_gt_setup(struct device_node *node)
 CLK_OF_DECLARE(sun9i_a80_gt, "allwinner,sun9i-a80-gt-clk", sun9i_a80_gt_setup);
 
 
-/**
+/*
  * sun9i_a80_get_ahb_factors() - calculates p factor for AHB0/1/2
  * AHB rate is calculated as follows
  * rate = parent_rate >> p;
@@ -225,7 +225,7 @@ static void __init sun9i_a80_apb0_setup(struct device_node *node)
 CLK_OF_DECLARE(sun9i_a80_apb0, "allwinner,sun9i-a80-apb0-clk", sun9i_a80_apb0_setup);
 
 
-/**
+/*
  * sun9i_a80_get_apb1_factors() - calculates m, p factors for APB1
  * APB1 rate is calculated as follows
  * rate = (parent_rate >> p) / (m + 1);
diff --git a/drivers/clk/sunxi/clk-usb.c b/drivers/clk/sunxi/clk-usb.c
index d78a78495bede..5460218f3467a 100644
--- a/drivers/clk/sunxi/clk-usb.c
+++ b/drivers/clk/sunxi/clk-usb.c
@@ -15,7 +15,7 @@
 #include <linux/spinlock.h>
 
 
-/**
+/*
  * sunxi_usb_reset... - reset bits in usb clk registers handling
  */
 
-- 
2.27.0

