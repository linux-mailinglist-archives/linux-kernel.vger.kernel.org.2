Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B00380A92
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhENNoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbhENNn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:43:56 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:150:448b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C73C061760;
        Fri, 14 May 2021 06:42:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 01BB9222567;
        Fri, 14 May 2021 15:42:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aAEfIBP1sinp; Fri, 14 May 2021 15:42:39 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v3 6/7] dt-bindings: sound: sun4i-i2s: add Allwinner V3 I2S compatible
Date:   Fri, 14 May 2021 15:44:04 +0200
Message-Id: <20210514134405.2097464-7-t.schramm@manjaro.org>
In-Reply-To: <20210514134405.2097464-1-t.schramm@manjaro.org>
References: <20210514134405.2097464-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2S peripheral of the Allwinner V3 SoC is compatible with the one
found in the Allwinner H3 SoC.
This patch adds a compatible string for it.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index a16e37b01e1d..39b66e9ce3e3 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -20,6 +20,9 @@ properties:
       - const: allwinner,sun6i-a31-i2s
       - const: allwinner,sun8i-a83t-i2s
       - const: allwinner,sun8i-h3-i2s
+      - items:
+          - const: allwinner,sun8i-v3-i2s
+          - const: allwinner,sun8i-h3-i2s
       - const: allwinner,sun50i-a64-codec-i2s
       - items:
           - const: allwinner,sun50i-a64-i2s
-- 
2.31.1

