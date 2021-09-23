Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3384415F86
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbhIWNXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:23:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:30303 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbhIWNXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632403303; x=1663939303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R9dm/LZCckRk6wJfIOlCq9hs1HeKlKJFOmWdXSXIfm8=;
  b=loZMJ/KzcQXaYliAnKyhxAuvPhoE2RCx48QWgPnsV1SSC65+W2iiawnp
   EmKoQMPQ6QvULhuAbory/61ibrle/mTMKQUXSu7IK6o4MxV0eYnQpvPyJ
   w08KXdivX2U1rr53s3ntru/N9UBm7hCnEdZeJhd70Df3eQMhtUgxCuuol
   K/tsKCdvSWQPXIvg6BN/lsMeXDCNPbshNkJZV9VZwrQWC8ad6Xz7txRE5
   hYPSDEbHzlMy4fLBjhMaz5eQdoc55quEOP8xRRxkEsIlW7VM1OW4rOG+f
   2iKG4rHZEZ67uukg78FLgHMiR0RO4njytHu7vI/AA7aC+k6q6VPc+an3f
   A==;
IronPort-SDR: bdLKG+K25wuZgXPyBll0W/GRK660j/EYOExmv/xpxV4aQIyGbaIJ5EFbRHhsp/LHmDLx158FIU
 uLSHh1OhGCcMEtsYpY1e0jhaSsofGz2wZKkO1FlyGAEUMIEKuOySIu9MkWq30eM5meLCkplYKY
 wtMT3N23rIuwYlLRgNlncyx8yEE4g4vA1QEmbYR/EEMJBDWk4D8A1MGmfYV8TxnHtVaBXhXhuH
 Ub7bfOHQMaUwDaCIV1DXC7fwwU+EuvK7RMUoR2pWiG4X65Qo2Ri3Icnik+8uLwP5wQs/brwE8r
 iQ//w5oINhN2H2Chdq3+RoaX
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="130352861"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 06:21:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 06:21:41 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Sep 2021 06:21:39 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 16/17] clk: remove extra empty line
Date:   Thu, 23 Sep 2021 16:20:45 +0300
Message-ID: <20210923132046.1860549-17-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra empty line.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/clk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 64838754cdef..815fe5f6651e 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3574,7 +3574,6 @@ static int __clk_core_init(struct clk_core *core)
 
 	clk_core_reparent_orphans_nolock();
 
-
 	kref_init(&core->ref);
 out:
 	clk_pm_runtime_put(core);
-- 
2.25.1

