Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BB440F738
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344306AbhIQMJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:09:08 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:7292 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344198AbhIQMIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880440; x=1663416440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yDDdLIef8M3sde5a3ttzfJt01DdS+aKgSikwVBlAUjc=;
  b=qS/O6m1e1YKlSRssmpVd6V5ern5NOllzk+pzBSuPfuXU3UE+1TLyW84P
   12+N8cByE9V5y8BgQYXFLaAYVUfvaPBGKGDMTbe+3a1IbguvpKoMQW8M+
   ejjRM/vc9ZPe+A5vSRurgYAo/LltE7+oUZnku7zfnybzlGehvLzfpDt/X
   Wq8UsHjA2NDGeIGd6eCsOzSg5rk6YSkpVJRJuFJAE0OAqA9Ijzh0VWv1G
   b24GHfu+z5d32prVSjCExp2Ql+vgrI6xSwLUrl+4b2WAvJVEJsWvqloi5
   8PyP4VCzLdUoEXxbihlUE6vwPwmjh8Df7T4tj/W7Ub0PqfoUF/7ivchKN
   w==;
IronPort-SDR: sHC1Bz4LfGY7eO4HkEkE9KyDbHgyuIgFzWlv3o49JCfjErd9yGYW3V/kx7fBNzfcewI3pV9oSU
 Yo5GRFcvCdi3p63FKZNZWW38ZR/u3LwMnl1NkP8TTKmCfx/knZAEVkV6GQj084xdc2aoLk9qH8
 NEpjEcMZjw5FZOTtHyCMH9C3tD2w3YDgeQ9e/iw/r5/cG+NOk0FAp87VTac3cgmea9/RD+GKBS
 hYbL7gwcbamnBQ5SKTe/UcvkoDx91EUiALT2tNZMRyyLeVTXscAtFxUOpL+DKvoHFbqscY4rz3
 ZrTFWdZMBHlnCfIMbNNfC4d/
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="136943159"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:07:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:07:19 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:07:17 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 14/17] clk: at91: sama7g5: set low limit for mck0 at 32KHz
Date:   Fri, 17 Sep 2021 15:06:39 +0300
Message-ID: <20210917120642.8993-15-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210917120642.8993-1-claudiu.beznea@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCK0 could go as low as 32KHz. Set this limit.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index aaa5769a8df1..19cbe3db7f8a 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -848,7 +848,7 @@ static const struct {
 
 /* MCK0 characteristics. */
 static const struct clk_master_characteristics mck0_characteristics = {
-	.output = { .min = 50000000, .max = 200000000 },
+	.output = { .min = 32768, .max = 200000000 },
 	.divisors = { 1, 2, 4, 3, 5 },
 	.have_div3_pres = 1,
 };
-- 
2.25.1

