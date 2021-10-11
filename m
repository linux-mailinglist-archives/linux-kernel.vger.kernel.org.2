Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEEF428C12
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhJKLaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:30:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16138 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbhJKLaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633951687; x=1665487687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZMQb4xEm45MpshvWcAzyLo2pqQa5xUnhBFD0WqA9bk=;
  b=FnMzuJF0wQs9Seu/LYxAesJRJJ4RBgBpAhgOMCpLhmjBYmLZn09RUaid
   2juduPVPybuq6DCmWO/tKffH+awECzAQ7liWPG2BuJzfcjKNxoCLj+b0Z
   VN0UCP4Hh6Z7kWpZ8hTX6WV455F389P0/T4o8k/Il6qcoMn74xQ6uQEuT
   eYpnaRQnFpcOH4cjYZUbe7hpxK78lJ612c0Z/eiOYtk04EWeS1QPOLyMB
   SJ1s/hP+OMANqkmIEG4dAXMYYOKMpll5fxdC2QXy8mlh+T31n/IPaV/wq
   GFnDRAZXUtXL4h9Zu0+ITGBb4MJZ6WIEThcwjyfKxlaiDmUQhI/ydTiox
   w==;
IronPort-SDR: tSwK5VgRp5+lyrt2OB5LPsO4qpmJKB9h13BS9+XKCHMg0yPE7tltPlIKCO6LhgbhJDeMG0QDTi
 z/L/DHKdyS16BtWcqPPTXfPv1UPBPCFiWUFU0O3EXgiaHWQ5QUP9uGf82MGxROmxfxWq8pzHx5
 CYkWAFB8yxYL7moGQbFQ088Hdp8GtQjFP3ctWnFD7paR4hRsmd6vLSoTQEzu6Mfkoo3SneP5H0
 qhcK8j5wxEW9jO27eIFAxHF0kINrHb5ub4yQRi3TbrcEnl354FBuMJ88Eqz+OjdWNKK8cf3Uul
 I6Knp3MTW4E0Bkz8jY4VsD/G
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="132541763"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 04:28:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 04:28:07 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Oct 2021 04:28:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 15/15] clk: use clk_core_get_rate_recalc() in clk_rate_get()
Date:   Mon, 11 Oct 2021 14:27:19 +0300
Message-ID: <20211011112719.3951784-16-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
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

