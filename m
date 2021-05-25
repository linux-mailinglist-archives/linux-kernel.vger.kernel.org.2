Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864963900B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhEYMRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:17:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46204 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhEYMRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:17:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id AF1D61F42247
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, xxm@rock-chips.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 2/4] dt-bindings: iommu: rockchip: Add compatible for v2
Date:   Tue, 25 May 2021 14:15:49 +0200
Message-Id: <20210525121551.606240-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525121551.606240-1-benjamin.gaignard@collabora.com>
References: <20210525121551.606240-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the second version of IOMMU hardware block.
RK356x IOMMU can also be link to a power domain.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/iommu/rockchip,iommu.yaml          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index 099fc2578b54..d2e28a9e3545 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -19,7 +19,9 @@ description: |+
 
 properties:
   compatible:
-    const: rockchip,iommu
+    enum:
+      - rockchip,iommu
+      - rockchip,rk3568-iommu
 
   reg:
     items:
@@ -48,6 +50,9 @@ properties:
   "#iommu-cells":
     const: 0
 
+  power-domains:
+    maxItems: 1
+
   rockchip,disable-mmu-reset:
     $ref: /schemas/types.yaml#/definitions/flag
     description: |
-- 
2.25.1

