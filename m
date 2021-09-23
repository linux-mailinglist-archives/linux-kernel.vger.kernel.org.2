Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D4A415F87
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbhIWNXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:23:37 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:7798 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241302AbhIWNXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632403305; x=1663939305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QVpsGQacYBazRN4bjzMQ0GaU+hULlQ1/8bIf+zxYHAo=;
  b=vuoJYRmLG2fkXvnEIby5aiz9dAoCaUdfc9ww6la3p36pBP/W1HujVObM
   54wWWO/MIoMSywbyVVufvOy6koS/bQrefngSEgMf1h2RZGP2rGQk4jp2b
   /CfXx6UNCFQT8V/Bo/UoyfNTjOWDHGAORnfYwKesPfvn2Ydkw+aKZK2zo
   kodhb9q64FvhHJmZM4KHls+W9fW2rOu/mwEAGZ4vEaMmfOcS34cSVITaw
   myLNnOgRvuyVfXgyxUjkm6GkFF3BFcTcXF/cp54PnLiSOeuddY0bx2AML
   kCg3OuyYPRa0tP6uhAzcv0WK2dUm/OwoKJDCZl3CowZT60e4rCl4YCixQ
   A==;
IronPort-SDR: GQ4MQtfibrFgCkykZtbKAF3droCnjQBYTd4D0iqkWxCAnqwxDPX4MfLtdK6AMKxNll+AV0GnZu
 CrYmMYa+ZxvIXh6lbXynVlK2mOdtLULwTao2b5c3jXvukvhl90WmI6ZWJ7wzV4kbxKjcs65otV
 l7eRaa2k/4nHD+sms+4fG3dBBu2Nq2MyJNXhczT0mObgXmgxe0ZlYnU9ET9YbLle6zr4FSPoL6
 E5eqEKLdpIB+23XuqXOSkiBERGiUS99ABAEjZnvwgrO5hKDL7scZKaRM6XvIxiTNzC5fkjnGwD
 erR4F6IeKtp+RajoRURZnl8z
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="70327459"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 06:21:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 06:21:44 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Sep 2021 06:21:42 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 17/17] clk: do not initialize ret
Date:   Thu, 23 Sep 2021 16:20:46 +0300
Message-ID: <20210923132046.1860549-18-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to initialize ret.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 815fe5f6651e..b854c18e73af 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2175,7 +2175,7 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 {
 	struct clk_core *top, *fail_clk;
 	unsigned long rate;
-	int ret = 0;
+	int ret;
 
 	if (!core)
 		return 0;
-- 
2.25.1

