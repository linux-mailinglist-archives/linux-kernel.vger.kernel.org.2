Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C183C40F73F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344310AbhIQMJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:09:28 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:7308 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243484AbhIQMIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880448; x=1663416448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QVpsGQacYBazRN4bjzMQ0GaU+hULlQ1/8bIf+zxYHAo=;
  b=Mbdg1UIoqJ5pipWA3xQnpJ1oXkwlSfkRlGSfIjLx6Gaww8xSbF/mpI7v
   DovM0Ut867mWLL1EpakJuOMs+5/dFU1hq6znkXs1WnF4SdmZAAaxXoC76
   LZE8uMvgcMxxT0STYSCrKTvkfOaOSTjdPpyyx529cl5grlk69P86UP+iO
   ApMnYFkzJd9KsgdsyjYcUSdVo1hPG9mGNbbjSEcnrrBnifNOxk4H4wFCk
   aSDHaSMPGvitSmnVxwOzv9UsaIalzsw89sd10fdT/FMyT/cTeuCrDW2Nq
   qSlRffyDU+MWY8uopfCYbylz/SOOTblnzqvWTK0NNTXE4qqEkRb8M6wWC
   g==;
IronPort-SDR: THOoq7TX75LfIdEpAqzk85Gzwsm8TqW2N2W6aod93jhvjq8SQWJmAAIy4ykz9JX8CqvhxbJi87
 WnBVyP0rLG7x9L9yi3HTw8Syhmw14jKhCG0qCBT/eixgMfp9U1vlkHAhwrHUpX6+12GscZXEnV
 CHIadJRhQIaUxcJVHPh5VSzOTgW0r1dGXCOhRdSyYt+93TVNCHdvcXo80EMjYdofjZltIlR8gW
 9+FeXG3rs1yeFs72Wj/G7EouaSjzZF13r8Yfk3bki6S5BJuO/s/W1bi1b6MOLhbA9BiJJpdrr1
 +1+mivcVkfqQFhnA42IVHt7T
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="136943175"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:07:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:07:27 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:07:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 17/17] clk: do not initialize ret
Date:   Fri, 17 Sep 2021 15:06:42 +0300
Message-ID: <20210917120642.8993-18-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210917120642.8993-1-claudiu.beznea@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
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

