Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADF938E7F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhEXNq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhEXNqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:46:54 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C87CC061574;
        Mon, 24 May 2021 06:45:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y14so26521467wrm.13;
        Mon, 24 May 2021 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EeXZgICZ0Z3OHOI6Ok7UZ8Rl7RngQhEPXl7GMuZ58Z4=;
        b=mqHqSvWf0wfZVsJwOA4yoT0GvgyqdORSFVATxX3FS9pw+TQbsGfYNWfByKi9GeDwjk
         0xi0l5/2FL3ip9OYJcVHqUvc2C0gcGgM5Bn0DNreRpchYwI6nBg8pwMMzPdwOhUjg4lG
         /qyhqKnKA28WSUgWIehtnP1elwWVLy9FQREWCuqBUhO+qepcUrXFdq4IYrOqzLvOh7O9
         vhMpGXEIfs+rMVig2KLSMEgAXCL2TSIrNWWqcm0HR2kczawpbSGtEHT5n18Hn97tyJg2
         1z0Kth5HKKmp6dWrUOuj7VIPtnY2oidk2pafQKGYgDq/CFTAB7lMj4NMfFEZ9dYaMyb+
         hZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EeXZgICZ0Z3OHOI6Ok7UZ8Rl7RngQhEPXl7GMuZ58Z4=;
        b=ldcH5/Hxx3rLUk9EAnr5XzYMbZpyNfD1A3NW3YB6dgl7EMRI8mEhI5AIETqNHkl7M5
         Jvf8RaxgPiVp8G9w/EKZRXDskd6cORoUhbLum0aGmKh5CvFZzHtb2iyM+O3ldBMBVt11
         OjnbA/iETIozePaNvyftQvebmSBvFTlFuPl6/TvfFa+3dork2/wNVfQV8xoNcJMTGqsj
         7eNqtpLOZinNNorof4NnRA/zlzpvcBoxjQ9SSqkA9bU3sRi7zfy8vPvGv7DdAx2Y35Wi
         mpLEKa0MUfslaJxCJFlQdbgFT59dnAdYVsCtPs5ZZWqItGy/4BVILS/jGT5UB38ET7R9
         6usw==
X-Gm-Message-State: AOAM532NE2XgJYI1gJQsIoKb3bg1rshG59PuFSzmpSg+ydrvz0EXpcoZ
        GW2x6MxH2IxMbyPNcgc/oH4=
X-Google-Smtp-Source: ABdhPJzT63Ul/bqB6pl6ZjLa+2aDy2Jm8I+RrICz2ZatOw7KGfEaFEZk8DVBL1gqsUVVcPv9ctEw5A==
X-Received: by 2002:adf:ee11:: with SMTP id y17mr22401706wrn.57.1621863923145;
        Mon, 24 May 2021 06:45:23 -0700 (PDT)
Received: from localhost.localdomain (p200300f1370a3a00f22f74fffe210725.dip0.t-ipconnect.de. [2003:f1:370a:3a00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id b13sm1470159wmj.40.2021.05.24.06.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 06:45:22 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        khilman@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2] clk: meson: meson8b: Use CLK_SET_RATE_NO_REPARENT for vclk{,2}_in_sel
Date:   Mon, 24 May 2021 15:45:17 +0200
Message-Id: <20210524134517.687089-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use CLK_SET_RATE_NO_REPARENT for the vclk{,2}_in_sel clocks. The only
parent which is actually used is vid_pll_final_div. This should be set
using assigned-clock-parents in the .dts rather than removing some
"unwanted" clock parents from the clock driver.

Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
After a hint from Jerome (thanks) this is the improved version of
"clk: meson: meson8b: Don't use MPLL1 as parent of vclk_in_sel" from [0]


[0] https://patchwork.kernel.org/project/linux-clk/patch/20210524104533.555953-1-martin.blumenstingl@googlemail.com/


 drivers/clk/meson/meson8b.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index a844d35b553a..0f8bd707217a 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1175,7 +1175,7 @@ static struct clk_regmap meson8b_vclk_in_sel = {
 		.ops = &clk_regmap_mux_ro_ops,
 		.parent_hws = meson8b_vclk_mux_parent_hws,
 		.num_parents = ARRAY_SIZE(meson8b_vclk_mux_parent_hws),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 	},
 };
 
@@ -1358,7 +1358,7 @@ static struct clk_regmap meson8b_vclk2_in_sel = {
 		.ops = &clk_regmap_mux_ro_ops,
 		.parent_hws = meson8b_vclk_mux_parent_hws,
 		.num_parents = ARRAY_SIZE(meson8b_vclk_mux_parent_hws),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 	},
 };
 
-- 
2.31.1

