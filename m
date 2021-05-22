Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A738D4B3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 11:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhEVJRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 05:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhEVJRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 05:17:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F101C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 02:16:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso7830199pjq.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 02:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocIAhBgbP+PNKty+shUQ/xBwv4WxwbN40wWJrHy9LDE=;
        b=H5IPHUVwsCv4PK07LQa0MFlmT/aE4HLOuzyADGUyy0rudXcLqXzGatgEgkhTxq0iEx
         LQwa078PXxu4cdbaepSXzxXHYI2d18vXDCC/fFTgDFbZmJM2k3Aa/Ui4Fbuo7KUbtrKB
         hmGI+FNCtf/n2xgdADvH6F3L0QTFijkC5wzqN146mbdbdxZOyf5tmwjBgbVOcjHzL9SW
         RPmLiBAX9pVvjxLKgmw5mnqa1mLotwFRVUYH2cXOZh4XKYYQrIx71YYDCaPBRnw+rbTu
         VM+icmERRTAtgYOpJ+dulojlQ/ftmxJAu7JANs/fN9ZOzJnZDq9RM/lTqPWkp8s4LINA
         b2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocIAhBgbP+PNKty+shUQ/xBwv4WxwbN40wWJrHy9LDE=;
        b=X7/C2HHLgJ5+n43gR75XDif7PBfURejvNH1gmD4b8+dFRwUjvT0zp7S+VjT/qoVMuH
         T+YS5Edq0xT3rKsikx3RP5EZKOLklkvmf5DFEvsiVNFgTvY6D+QhAAcXSJRmpTlTwg27
         n/3C4kA98qVeEWSuA6CRELqYHUqUo91bV/BrOijywJHFQbgDWHplvMBbcJp++ex1BAQZ
         130+fZg48rHShyjCiIDer70CbaZq1N4gjfYTrXeu6M5HN79E/kO1Qx9P/oRcQqkuWd0u
         BnqEMDcDOKHLklxGFXYesO+Q/4T42A4BpgGtjtmLQaGUqlt0p9M/R2cVl8g4Ojwp84d8
         Lqzw==
X-Gm-Message-State: AOAM531oYZjJxuUG3g65khBO6bgl0FRnwpBMBnzCeGMYy6sXjR24TVet
        S7sPboF7gpbd6JfcoNkH9syl3w==
X-Google-Smtp-Source: ABdhPJwBgPJcj3WjJ4rl8Aklh5GuighzrF2aOkUUN6iR5p/c0bE0+rouZom68Ho53Mip49r9lai9BQ==
X-Received: by 2002:a17:90a:2a89:: with SMTP id j9mr5925640pjd.141.1621674977901;
        Sat, 22 May 2021 02:16:17 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (59-124-168-89.HINET-IP.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id pg5sm3647169pjb.28.2021.05.22.02.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 02:16:17 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        schwab@linux-m68k.org, sboyd@kernel.org, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, geert@linux-m68k.org, yixun.lan@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2] net: macb: ensure the device is available before accessing GEMGXL control registers
Date:   Sat, 22 May 2021 17:16:11 +0800
Message-Id: <20210522091611.36920-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If runtime power menagement is enabled, the gigabit ethernet PLL would
be disabled after macb_probe(). During this period of time, the system
would hang up if we try to access GEMGXL control registers.

We can't put runtime_pm_get/runtime_pm_put/ there due to the issue of
sleep inside atomic section (7fa2955ff70ce453 ("sh_eth: Fix sleeping
function called from invalid context"). Add netif_running checking to
ensure the device is available before accessing GEMGXL device.

Changed in v2:
 - Use netif_running instead of its own flag

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6bc7d41d519b..a0c7b1167dbb 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2867,6 +2867,9 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 	struct gem_stats *hwstat = &bp->hw_stats.gem;
 	struct net_device_stats *nstat = &bp->dev->stats;
 
+	if (!netif_running(bp->dev))
+		return nstat;
+
 	gem_update_stats(bp);
 
 	nstat->rx_errors = (hwstat->rx_frame_check_sequence_errors +
-- 
2.31.1

