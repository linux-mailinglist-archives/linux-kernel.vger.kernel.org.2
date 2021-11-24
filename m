Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C975645CBE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350119AbhKXSOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:14:01 -0500
Received: from mail.pr-group.ru ([178.18.215.3]:54998 "EHLO mail.pr-group.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350411AbhKXSNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=eRPC+jPltyinnrCnMd2235MZc7JZTbnA8XD3gJo7/5g=;
        b=hrEOstFkItKn3yTvsyL9B4hUI2Wear7cd9MSAcRr+VpfUxK0MG1WpSjEVlX7IdihljL22ybukDY28
         iVHw0wqxSr508AaeRhO8n2TMskmxxBPc2nm8UXxXS4cwQbFzp1tE8vBg/fHSFEqXuvyX6KQzpHa9B8
         3rOHLOWJ4g8E6oKVRYNv80UXOco+QPnvOVbcp5FYIZjXKg5L382rQdgXKtLiFMvAMbLc2wA9MgrEYb
         xgC6r9qGkpHhICqSpl2P7LIdM3p3MXRN4hBDBrD7Tdyj2PtMx4us15fjc+a3cu3sZCHmnVD/Cut/lF
         FYrMgtV57MygC11D9L/fUHJakaySuCQ==
X-Spam-Status: No, hits=0.0 required=3.4
        tests=BAYES_00: -1.665, CUSTOM_RULE_FROM: ALLOW, TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.66.213.198])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 24 Nov 2021 21:10:27 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, system@metrotek.ru,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: bus: imx-weim: add words about continuous bclk
Date:   Wed, 24 Nov 2021 20:55:42 +0300
Message-Id: <20211124175542.2772-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124175542.2772-1-i.bornyakov@metrotek.ru>
References: <20211124175542.2772-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document continuous Burst Clock option. With this option Burst Clock, if
enabled, will output continuous clock, otherwise Burst Clock will output
clock only when necessary.
---
 Documentation/devicetree/bindings/bus/imx-weim.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
index 1b1d1c5c21ea..e7f502070d77 100644
--- a/Documentation/devicetree/bindings/bus/imx-weim.txt
+++ b/Documentation/devicetree/bindings/bus/imx-weim.txt
@@ -48,6 +48,11 @@ Optional properties:
 			devices, the presence of this property indicates that
 			the weim bus should operate in Burst Clock Mode.
 
+ - fsl,continuous-burst-clk	Make Burst Clock to output continuous clock.
+			Without this option Burst Clock will output clock
+			only when necessary. This takes effect only if
+			"fsl,burst-clk-enable" is set.
+
 Timing property for child nodes. It is mandatory, not optional.
 
  - fsl,weim-cs-timing:	The timing array, contains timing values for the
-- 
2.32.0


