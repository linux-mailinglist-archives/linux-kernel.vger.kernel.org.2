Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD0240F73A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344327AbhIQMJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:09:11 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:52288 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbhIQMIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880443; x=1663416443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZMQb4xEm45MpshvWcAzyLo2pqQa5xUnhBFD0WqA9bk=;
  b=H2mtiCg4zOT1W74rZEII1WL5qPvnoZgZdRS8XrDt9/Yjo4RMiVue9VJ0
   yFJkbJu0vCHripCiB39xvGg1tmU43LmOGA++5k/87utSEgpXM1ASb9MR1
   wt3i1GWXz5BQ850YrLTyYtHOpPE2MeRpH0Q+uEf5gDvTNEO0ok839hoST
   1u9aPnlCbgE5i0N0m1bFu507pZXsz685TTd1UCNzbDxLFsX6/04RbViMH
   ueWDV6DdvOJ59mNb/QQfyzBo+v33ktsNd7XQB/lKiuzOTVXDtlZNMuF+H
   Kzry+ihAx0/jXVK6JHv8Q/XNZWDv3u7ZZ6oHvk/4bNiMxgCD1xsWLUWGO
   Q==;
IronPort-SDR: MbYRf5iuTP3eWbMu9Uxbm32tExkfqVWUxgwm0A3TdtVjfOhrcwy5VC+17u1o0JapTdp9+yBM+X
 41OjXgFrULdY1C2pbqavuUFRu0Xrfzz07uL9s06GJNjvm3fggG3TirxWyOUd6y5ZuPmXrMN/as
 g0r/qgCALgdVWmGw5+PAUE+mPIHtWYBthSdA+wwHGG/hIFy7TzDC6TvlOWQmT5TUHZPqrPNg2V
 NEsiGi8LFBr0E+z+8pqJHtjiH/L/s5Ath1n1Zhed9Blx28xjZEHUgvlxA5QNVEH1r3pwjD2os5
 CVGjbU6exT9UcUNaKsk7MLfR
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="132201109"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:07:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:07:22 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:07:20 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 15/17] clk: use clk_core_get_rate_recalc() in clk_rate_get()
Date:   Fri, 17 Sep 2021 15:06:40 +0300
Message-ID: <20210917120642.8993-16-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210917120642.8993-1-claudiu.beznea@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case clock flags contains CLK_GET_RATE_NOCACHE the clk_rate_get()
will return the cached rate. Thus, use clk_core_get_rate_recalc() which
takes proper action when clock flags contains CLK_GET_RATE_NOCACHE.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 65508eb89ec9..64838754cdef 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3108,7 +3108,7 @@ static int clk_rate_get(void *data, u64 *val)
 {
 	struct clk_core *core = data;
 
-	*val = core->rate;
+	*val = clk_core_get_rate_recalc(core);
 	return 0;
 }
 
-- 
2.25.1

