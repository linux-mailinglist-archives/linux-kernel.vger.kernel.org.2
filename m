Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256D03C7A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 01:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhGMX2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 19:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbhGMX2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 19:28:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CC8C0613EF;
        Tue, 13 Jul 2021 16:25:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so2723420wms.1;
        Tue, 13 Jul 2021 16:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQtFi3Hnx4K3qedNDcjWCvPvHnc34scNXSyJRM66eyc=;
        b=O/qHa4p8MUICgTw2moGtJHisz2F0qV71BT3dbeMDgUXv/x4+5h3u0twAFSJzUipAxr
         QGSW48t3kwX0Pmyk0J4M2o28wylS7QEEjfVWnTfAitPIIX/k1ZWmk8DiZAj+eesy3Wus
         IvHbL6JXs1V/EcIJKWION1Sl9cuspToxmpq5s9rfnpb4rcvUIm3ttnVUalhulkrPdsLv
         Wz4Pghpqc+xXFDRiPjxFQv0mcODuCb3TnBoqEH7m7+Zmb/QLlcM1JOYiPajSNSno/+dv
         N85Krrv37jqo2cEYfaJ1Ilmn6BRI0Iz8RqS8amoe5fyHa8BoqdqrV79RmAUq+uFM6Yga
         44Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQtFi3Hnx4K3qedNDcjWCvPvHnc34scNXSyJRM66eyc=;
        b=Ci09jNlRLVHn82QYAJz+voUIj/HWrDJKWAEl8eYw7OXpMctt5pX+XKQTgE/dCTAG+E
         iigPEThjClN2RD2XgaeT1zMjS2JHTppuevysmz9Xj2vyHq6AXgkdBRP3puvkZKFGZIdS
         n0CGba7FJF2iILZWmjeMULLMRahqs1/uTgS8zmxOG7iaQxYVMqUjhPNf3wRYJrTAzQaw
         1CluuTybxj2m3Sop5VKsHwy/UpynTiCFtP//n5N6St8lyAtK+1eAuB+biNph0VTRg7Ds
         wUTo9fmGnWYaT8HCLFBDNj455yTmocVcoDgrwjreBk/+OvggWS6cnRvCx4waDuyxiVwU
         xKqg==
X-Gm-Message-State: AOAM531jm53FmA9JcM6u68NTKDs3JtOyGinJvnGE2VdWr6Gu7tyd3je1
        APxDqP7QolcKwjLTyL9tHyM=
X-Google-Smtp-Source: ABdhPJyZ7mnr+2FtCpzC0i7HKv0GbjmCDE4Hv35Q6SXgvJihuYYbPLxTsQr0J5yi07J72MH5t5j1IQ==
X-Received: by 2002:a7b:c013:: with SMTP id c19mr653114wmb.158.1626218718324;
        Tue, 13 Jul 2021 16:25:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c041-6f00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c041:6f00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id o11sm3857390wmc.2.2021.07.13.16.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:25:18 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/6] clk: meson: meson8b: Use CLK_SET_RATE_NO_REPARENT for vclk{,2}_in_sel
Date:   Wed, 14 Jul 2021 01:25:05 +0200
Message-Id: <20210713232510.3057750-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713232510.3057750-1-martin.blumenstingl@googlemail.com>
References: <20210713232510.3057750-1-martin.blumenstingl@googlemail.com>
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
2.32.0

