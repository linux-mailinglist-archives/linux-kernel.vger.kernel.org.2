Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0F943FAE7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhJ2Klo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 06:41:44 -0400
Received: from mx.socionext.com ([202.248.49.38]:58734 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231723AbhJ2Klk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 06:41:40 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Oct 2021 19:39:11 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 3BD7F203F6D9;
        Fri, 29 Oct 2021 19:39:11 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 29 Oct 2021 19:39:11 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id E71EEB62E0;
        Fri, 29 Oct 2021 19:39:10 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 3/8] dt-bindings: phy: uniphier-pcie: Add bindings for NX1 SoC
Date:   Fri, 29 Oct 2021 19:39:02 +0900
Message-Id: <1635503947-18250-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635503947-18250-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1635503947-18250-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update PCIe-PHY binding document for UniPhier NX1 SoC. Add a compatible
string for the SoC to the document.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
index 3e0566899041..fbb71d6dd531 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
@@ -19,6 +19,7 @@ properties:
       - socionext,uniphier-pro5-pcie-phy
       - socionext,uniphier-ld20-pcie-phy
       - socionext,uniphier-pxs3-pcie-phy
+      - socionext,uniphier-nx1-pcie-phy
 
   reg:
     maxItems: 1
-- 
2.7.4

