Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B3F43130B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhJRJRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:17:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16894 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhJRJQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634548481; x=1666084481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KF9bcBS1aN5J5YJFqNrlEjHZxvMOq6zrEhAbR5BXkug=;
  b=b9YsGiGl7cTg9On/zm/yl2567t9H1lJ6T3m4cK4dCMXM5kRuIyoBV3bh
   GYlhSB4EBVse2kZvwXyZ6z44MQufRSPPNvrraW2A3h9015ILLN4AupLbB
   6a4Uyl0MWMX5vOAa5piMZJY/3SVHPkfLdfP3UywO8RfH0jpkcoAsFa8hO
   zitnrG408zzonsaE/xdBms4Y7taMrkO1ML7GiVkajU3cRcYKvE5MAQYgi
   656fEcls1xgBEoledXG/xX3gEAeQpJoSYnk4f8EKzlXawhKSWH7P0biHj
   bhXkSxxkrn4C/yPWvRnsndCFmcIf57POONB2OPvBOGxCMoxZBqWRlGTAi
   g==;
IronPort-SDR: TiHGsLzahI453AFoCVVf4zjmXSd7ZW6xlTU0Qa7nSgnXqvg9Pa3SSfOlSoeDd8U4S36TFthY4L
 r+G/y6cqkoY03KTXig+JbMrnYsK393twN/7sLt+Kj7NWN1MPNNadKweDfVr/rRQyPpZeMB9cA+
 TeqhvDctnMGhr3jp4OVbg/ytZTKHV54FWdCQfpVvEBhdFhVrK4VQ1GE6KMK87tHr20NZ1V3+hA
 pV/2PPvtKBFY/JtDwDsLWxEWpzFx8a8DebMp6K0NuO0swbCxjF72BiGGoKfudRdLCS92LGkA7r
 XMXw/359Q+F3O1SxLiPOj0+M
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="133411108"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2021 02:14:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 02:14:40 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 18 Oct 2021 02:14:38 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: reset: Add lan966x support
Date:   Mon, 18 Oct 2021 11:15:21 +0200
Message-ID: <20211018091522.1113510-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018091522.1113510-1-horatiu.vultur@microchip.com>
References: <20211018091522.1113510-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the existing file microchip,rst.yaml to support
also the lan966x. For this is added only a new compatible string.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 Documentation/devicetree/bindings/reset/microchip,rst.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
index 370579aeeca1..578bfa529b16 100644
--- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
+++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
@@ -20,7 +20,9 @@ properties:
     pattern: "^reset-controller@[0-9a-f]+$"
 
   compatible:
-    const: microchip,sparx5-switch-reset
+    enum:
+      - microchip,sparx5-switch-reset
+      - microchip,lan966x-switch-reset
 
   reg:
     items:
-- 
2.33.0

