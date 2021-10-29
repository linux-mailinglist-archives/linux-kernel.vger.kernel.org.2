Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77DA43FC36
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhJ2MXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:23:10 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49381 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhJ2MXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635510040; x=1667046040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GiZSP2N7eXt6hJAdSEsqoCePxdQqvxfYMrEZp11WUS8=;
  b=l0kn//Pge0yJQlRGuyAIh1WwqUHs+C5VAM+ozvc62phzKwkUwKNMNUUM
   zb24gA/Xm05prGeUovngqYGhk3V9hfThTBZzLiEpL8A/gTcpVR93T+DxT
   xqc2Qe5UGV7qZZhSOEZP3paXD8DlUY+jmba673V9ZYXRFIv+vg1CK6RCH
   /Ss/ZcFej+AyxJ27CLXhY/fSrTwPPYZcFsbQZsPKXGL6oXeVkrZXv4xZ3
   d/3qdXktm0aX01jDILcAeMfrF0kO/Hyf/ZMktvPB9kfkjzjZCtBq4jGH3
   eaPaU+6VK6hkPs+UZbln62dEyAJoRYJcfODl5SMCGhfRiehcEFhS2uMV+
   w==;
IronPort-SDR: LCmBK1xPqqAD8DcYbZnIaHqx9QJ/uCIQ231L0dUEEkAwIUF3tQO+Sw1e7si7RooYHANlT82xom
 Mrsbvk5fOtUw2lg9EM7wAB1dhubIYjvt7bBsX8jo3skzMJshQTwwwIQqBp00WrGi5NhCZON1xX
 A1DaWmVv6peNB4Bmx2DaxPRxavaa6j7hVySV7UW7aUcd0+MFMRoR7UxR8O5JpwdZfqOglo2oNR
 rz6TwXav/n4G+eNUck8Aik4FgTBzsB3EE2JyG9TMBR2xxHhrCFQ4uCLe2UfeGVAeuW8y68SU2C
 k5A0v+QFecsBGpH3WY8nqZm1
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="134789133"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2021 05:20:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Oct 2021 05:20:26 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Oct 2021 05:20:23 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <kavyasree.kotagiri@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [RFC PATCH v2 2/3] dt-bindings: clock: lan966x: Extend includes with clock gates
Date:   Fri, 29 Oct 2021 14:19:28 +0200
Message-ID: <20211029121929.2811811-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029121929.2811811-1-horatiu.vultur@microchip.com>
References: <20211029121929.2811811-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lan966x it is allow to control the clock to some peripherals like
USB. So extend the include file with these clocks.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/dt-bindings/clock/microchip,lan966x.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/microchip,lan966x.h b/include/dt-bindings/clock/microchip,lan966x.h
index fe36ed6d8b5f..6f9d43d76d5a 100644
--- a/include/dt-bindings/clock/microchip,lan966x.h
+++ b/include/dt-bindings/clock/microchip,lan966x.h
@@ -23,6 +23,12 @@
 #define GCK_ID_TIMER		12
 #define GCK_ID_USB_REFCLK	13
 
-#define N_CLOCKS		14
+/* Gate clocks */
+#define GCK_GATE_UHPHS		14
+#define GCK_GATE_UDPHS		15
+#define GCK_GATE_MCRAMC		16
+#define GCK_GATE_HMATRIX	17
+
+#define N_CLOCKS		18
 
 #endif
-- 
2.33.0

