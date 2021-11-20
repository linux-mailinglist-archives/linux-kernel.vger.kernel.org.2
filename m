Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F38457BFD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 07:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbhKTGS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 01:18:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236265AbhKTGSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 01:18:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 631D360E9C;
        Sat, 20 Nov 2021 06:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637388943;
        bh=BlDTN/fYlJgH1aIXEB5pPtTmQOvs8AurQM7U/adzSb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DSjWLGjOpcuTRyI/E/SMlkyA9a5G5FqpidFQ++GLEn/RyeaFa29Ri561m4pIRkvMb
         4sGMD5jJ5wgkjxtip31RBavsB217c/RQpxGrVi+GtPrOLYlUu/LgDcceTegKIqCQ8Z
         joB9vwIEGDlJJRLEIXMkZNgvuFNogmJ5/IXXiyb1Jil2qiJwB+zGn8Xj+I/GEqOAQi
         kFPfK495BX4HJN/JHKWO4WUXqY5rFxRo3x0Ba4jl6UPAQidGZnMXoBRIloawfBn+Dh
         U2hr3V5tnAY+tQPyeVYS7QPHT3yH/d18UQVLJpKRzRSiuqpRNrgyyGcjgsI9wMzqv6
         G4LCj2MENaIxg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Roger Quadros <rogerq@ti.com>, Liam Beguin <lvb@xiphos.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] phy: ti: omap-usb2: Fix the kernel-doc style
Date:   Sat, 20 Nov 2021 11:45:31 +0530
Message-Id: <20211120061531.410771-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120061531.410771-1-vkoul@kernel.org>
References: <20211120061531.410771-1-vkoul@kernel.org>
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
Changes in v2: use () for function names

 drivers/phy/ti/phy-omap-usb2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index ebceb1520ce8..3a505fe5715a 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -89,9 +89,9 @@ static inline void omap_usb_writel(void __iomem *addr, unsigned int offset,
 }
 
 /**
- * omap_usb2_set_comparator - links the comparator present in the system with
- *	this phy
- * @comparator - the companion phy(comparator) for this phy
+ * omap_usb2_set_comparator() - links the comparator present in the system with this phy
+ *
+ * @comparator:  the companion phy(comparator) for this phy
  *
  * The phy companion driver should call this API passing the phy_companion
  * filled with set_vbus and start_srp to be used by usb phy.
-- 
2.31.1

