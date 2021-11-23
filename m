Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4214645A051
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhKWKjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:39:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235519AbhKWKj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:39:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD5B960F24;
        Tue, 23 Nov 2021 10:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637663779;
        bh=wXAS/FpjSEB7/o6d+SMqmkV9s0JuSHiAKnUPppuzEHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3Do7CHTOoveWOr3k7F+0yl6ExGfaXIdcsoVM/GWSdKnrsmJfBK/VK+IA2SDTaq4o
         ckZ9wYK2aG+evJ0aq4GldIY8WpTNGp7QHkwdOOc4ihKk4KvQd5tUaoUcxTtBL/GMOk
         ha/z8+T8WD0jedcVuSYTgTMYqBoCn36aj6XUwMu/WW//CTxaoc88V4DhFApZTiKiqb
         NoemiJFORZcHcZKQ7tYfR12jC8gUlR4Rd9LHxa2uzRChhi+f1r9I5mzqAVF5iYRG/y
         j8wkXT8sMDjiNZl80sAzjvrNLeIGAGUn2rVmEOa8pr4DGnGsgA6emedaDKUGu7mTpd
         mSq33sOlPRvtw==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     kishon@ti.com, nm@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/4] dt-bindings: mtd: ti,gpmc-nand: Add compatible for AM64 NAND
Date:   Tue, 23 Nov 2021 12:36:06 +0200
Message-Id: <20211123103609.14063-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123103609.14063-1-rogerq@kernel.org>
References: <20211123103609.14063-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 SoC contains the GPMC NAND controller. Add compatible for it.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
index beb26b9bcfb2..666ae4a78544 100644
--- a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
@@ -16,7 +16,10 @@ description:
 
 properties:
   compatible:
-    const: ti,omap2-nand
+    items:
+      - enum:
+          - ti,am64-nand
+          - ti,omap2-nand
 
   reg:
     maxItems: 1
-- 
2.17.1

