Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB17428C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbhJKLaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:30:15 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22875 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbhJKLaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633951683; x=1665487683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7DuQKvhiqXfXrHuhwHeTUUUr9/+kf63QT9hDdoVT44A=;
  b=vjqTDkOc9BZZdVGc9+XGCNAKxfXkELzTX1jlw0nM+Fxoh6Eu/sh76lFu
   KzStRpoK3+NQU+SX1igyRvWUwWNv2aNT56swBjBmJx4u9pa089TTrvpvc
   ickg748PH5rpus5DjN3tpZfbpzObAcLQCzH0uGmopxNHetJtDLuQsqy0V
   TorCjFv1b+SZFgED94QN3GnATjvVxLBJk5EqTavkiGpIYSEJxvN5ewtPH
   VjefKdAVPr2ASPt2L1KsqVDr72u3Jp6f4lvQav0u6wYpxpRpeUgluEbsl
   SXBsPaMDQDfQvqhkg5hgB+mq9+sYzd+l8voltTNmi9yiecUdnek30b/XS
   Q==;
IronPort-SDR: tcDzZPxceoUwlsjep1riM5M0DKk1MGtVnbjQNLNCl6+mxcPYJhjxGNs3YKMEMdMr45HanLiKjV
 GlqQoSicIe3vt9yp/AHK7EvORN/lQdYpVe6BF9p9vMnYLZZ0xmL1SR+aR4xetDAWJ2+yZ0xKSL
 c67wvh031Y+dOsaC9Gy3uy9JSio9QCAyE1UsEwKZse0XKtrqqpsHOS4QPtlZWpFR1w0h9RaIK6
 XhR0Xn3xFfvel24zZKqWBaeqbvXvVl9E7tpcV657jtzi7VfWdXmzuNtt4dbVvsK5+uh4XXuq5l
 TSAUFEIOvXihpVw44AWX3Ztm
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="147591069"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 04:28:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 04:28:02 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Oct 2021 04:28:00 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 13/15] clk: at91: sama7g5: remove prescaler part of master clock
Date:   Mon, 11 Oct 2021 14:27:17 +0300
Message-ID: <20211011112719.3951784-14-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SAMA7G5 the prescaler part of master clock has been implemented as a
changeable one. Everytime the prescaler is changed the PMC_SR.MCKRDY bit
must be polled. Value 1 for PMC_SR.MCKRDY means the prescaler update is
done. Driver polls for this bit until it becomes 1. On SAMA7G5 it has
been discovered that in some conditions the PMC_SR.MCKRDY is not rising
but the rate it provides it's stable. The workaround is to add a timeout
when polling for PMC_SR.MCKRDY. At the moment, for SAMA7G5, the prescaler
will be removed from Linux clock tree as all the frequencies for CPU could
be obtained from PLL and also there will be less overhead when changing
frequency via DVFS.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index c66bde6f7b47..fd9d17eabf54 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -992,16 +992,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	}
 
 	parent_names[0] = "cpupll_divpmcck";
-	hw = at91_clk_register_master_pres(regmap, "cpuck", 1, parent_names,
-					   &mck0_layout, &mck0_characteristics,
-					   &pmc_mck0_lock,
-					   CLK_SET_RATE_PARENT, 0);
-	if (IS_ERR(hw))
-		goto err_free;
-
-	sama7g5_pmc->chws[PMC_CPU] = hw;
-
-	hw = at91_clk_register_master_div(regmap, "mck0", "cpuck",
+	hw = at91_clk_register_master_div(regmap, "mck0", "cpupll_divpmcck",
 					  &mck0_layout, &mck0_characteristics,
 					  &pmc_mck0_lock, CLK_GET_RATE_NOCACHE, 5);
 	if (IS_ERR(hw))
-- 
2.25.1

