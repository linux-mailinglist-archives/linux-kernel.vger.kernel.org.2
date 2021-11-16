Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A3F452F60
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhKPKpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:45:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234126AbhKPKnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:43:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02A606321A;
        Tue, 16 Nov 2021 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637059211;
        bh=iJwYXvXaD2Nx4JOgAG9JX3K+yBIfm4s3ShpHVYk75Ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJSLVVXMro/VYVZx+Q/HlBDJdgK99TC8JMjD1/eEe4i/jWeJyEANge4hI36tY0ECn
         o8ZfnUqBxjUXUNAdG/X9GAKHF4DSFARnj8t4IsVVCIX3vtQ0++9YjMKbFjIxJEZ71m
         E/SS3R7mruo8BqjXiuth1BvK4Sfz1F9bN02i3bRxiWQk/2T27dGK4QjJ4IYmmhCqTA
         M1R/VJdOptNgWv5L3QCY66ijqVgCLBxV5ciOmcenIH4zBKDrtkjcvzWA14Ki846VEA
         ie2ygtF8TwJAwf1IU8iETqOe73SudZtAfGkfMGhYpMsYuYc2b7vjC+oMzCFnpfwIvP
         5ZVwNntyf4QTQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Roger Quadros <rogerq@ti.com>, Liam Beguin <lvb@xiphos.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] phy: ti: omap-usb2: Fix the kernel-doc style
Date:   Tue, 16 Nov 2021 16:09:50 +0530
Message-Id: <20211116103951.34482-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116103951.34482-1-vkoul@kernel.org>
References: <20211116103951.34482-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation uses incorrect style, so fix that.

drivers/phy/ti/phy-omap-usb2.c:102: warning: Function parameter or member 'comparator' not described in 'omap_usb2_set_comparator'

While at it, use a single line for function description

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/ti/phy-omap-usb2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index ebceb1520ce8..2102b7f73ffa 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -89,9 +89,9 @@ static inline void omap_usb_writel(void __iomem *addr, unsigned int offset,
 }
 
 /**
- * omap_usb2_set_comparator - links the comparator present in the system with
- *	this phy
- * @comparator - the companion phy(comparator) for this phy
+ * omap_usb2_set_comparator - links the comparator present in the system with this phy
+ *
+ * @comparator:  the companion phy(comparator) for this phy
  *
  * The phy companion driver should call this API passing the phy_companion
  * filled with set_vbus and start_srp to be used by usb phy.
-- 
2.31.1

