Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29B3429A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 02:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhJLA4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 20:56:08 -0400
Received: from mx.socionext.com ([202.248.49.38]:50014 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhJLAz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 20:55:58 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 12 Oct 2021 09:53:56 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 593522059034;
        Tue, 12 Oct 2021 09:53:56 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 12 Oct 2021 09:53:56 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id C774CB62B7;
        Tue, 12 Oct 2021 09:53:55 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 2/5] dt-bindings: clock: uniphier: Add NX1 clock binding
Date:   Tue, 12 Oct 2021 09:53:52 +0900
Message-Id: <1634000035-3114-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634000035-3114-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634000035-3114-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update clock binding document for UniPhier NX1 SoC.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
index c3930edc410f..ee8d16a8019e 100644
--- a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
@@ -23,6 +23,7 @@ properties:
           - socionext,uniphier-ld11-clock
           - socionext,uniphier-ld20-clock
           - socionext,uniphier-pxs3-clock
+          - socionext,uniphier-nx1-clock
       - description: Media I/O (MIO) clock, SD clock
         enum:
           - socionext,uniphier-ld4-mio-clock
@@ -33,6 +34,7 @@ properties:
           - socionext,uniphier-ld11-mio-clock
           - socionext,uniphier-ld20-sd-clock
           - socionext,uniphier-pxs3-sd-clock
+          - socionext,uniphier-nx1-sd-clock
       - description: Peripheral clock
         enum:
           - socionext,uniphier-ld4-peri-clock
@@ -43,6 +45,7 @@ properties:
           - socionext,uniphier-ld11-peri-clock
           - socionext,uniphier-ld20-peri-clock
           - socionext,uniphier-pxs3-peri-clock
+          - socionext,uniphier-nx1-peri-clock
 
   "#clock-cells":
     const: 1
-- 
2.7.4

