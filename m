Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B77B421C61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhJECMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:12:36 -0400
Received: from mx.socionext.com ([202.248.49.38]:40418 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231225AbhJECMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:12:34 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 05 Oct 2021 11:10:43 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id B05A82058B40;
        Tue,  5 Oct 2021 11:10:43 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 5 Oct 2021 11:10:43 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 42467B62B7;
        Tue,  5 Oct 2021 11:10:43 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/3] dt-bindings: reset: uniphier: Add NX1 reset control binding
Date:   Tue,  5 Oct 2021 11:10:41 +0900
Message-Id: <1633399842-1402-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633399842-1402-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1633399842-1402-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update reset controller binding document for UniPhier NX1 SoC.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml       | 1 +
 Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml b/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml
index 29e4a90..bfbd3e9 100644
--- a/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml
@@ -23,6 +23,7 @@ properties:
       - socionext,uniphier-pxs2-usb3-reset
       - socionext,uniphier-ld20-usb3-reset
       - socionext,uniphier-pxs3-usb3-reset
+      - socionext,uniphier-nx1-usb3-reset
       - socionext,uniphier-pro4-ahci-reset
       - socionext,uniphier-pxs2-ahci-reset
       - socionext,uniphier-pxs3-ahci-reset
diff --git a/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml b/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
index 4c9b0eb..377a7d2 100644
--- a/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
@@ -23,6 +23,7 @@ properties:
           - socionext,uniphier-ld11-reset
           - socionext,uniphier-ld20-reset
           - socionext,uniphier-pxs3-reset
+          - socionext,uniphier-nx1-reset
       - description: Media I/O (MIO) reset, SD reset
         enum:
           - socionext,uniphier-ld4-mio-reset
@@ -34,6 +35,7 @@ properties:
           - socionext,uniphier-ld11-sd-reset
           - socionext,uniphier-ld20-sd-reset
           - socionext,uniphier-pxs3-sd-reset
+          - socionext,uniphier-nx1-sd-reset
       - description: Peripheral reset
         enum:
           - socionext,uniphier-ld4-peri-reset
@@ -44,6 +46,7 @@ properties:
           - socionext,uniphier-ld11-peri-reset
           - socionext,uniphier-ld20-peri-reset
           - socionext,uniphier-pxs3-peri-reset
+          - socionext,uniphier-nx1-peri-reset
       - description: Analog signal amplifier reset
         enum:
           - socionext,uniphier-ld11-adamv-reset
-- 
2.7.4

