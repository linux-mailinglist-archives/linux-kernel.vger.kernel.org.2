Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58C7428BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhJKL3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:29:49 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:53289 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbhJKL3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633951666; x=1665487666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7hWiJONj4Hkh2d5d5etUwZ8wYgaPJyptCsF6Gj96w40=;
  b=RE5Qt8eB4lQKHmv7xC9Xuvw2eYFv9VOpWyCRb49lVGCjHlcOkGqMtB9A
   MZjVFnTi7u6LnLvmmrxVwm5YNCm6mffJPpUZgQEvvSgUeECWSWa0CiC7z
   liodILVyXBfvpLwEL3OUQQPVE+WQRsLAGvYXIa4IrrOGNnUTdETuYrG7a
   fOlUP0yryQnStFS3DdoLxOigwVF2f9HPq8m48T1BlPawtXmV/nW8hhg9R
   8HkI39Edgjy6/b0a0k6uov26uT1kgQIwgEU1emdQVUtFMVZMaIFvTAkn8
   7BIFWE3Ci8xEIRxg3yyeQAp7lWIeM921bpvEaH7hLEZSFSgFBIoMy7pZz
   Q==;
IronPort-SDR: r4dh/SOb/uFDZ7Ovl+p9nDjwhZzWDNWRYUp76NRhfJGT3Rq1fwbN8Q/GuKTd/dPDHhj+Y5OIbM
 +vJjQglYj7N0RHYe7ZZhAcQIf8Nx2HK5mQCIIXS0ELqX2zbOpN4n0n0L8UzLKdFzMw+U6odTnR
 yoSiBvjj1D4eQNt9qVmJj/s4TnarJuiZcoVa05Gl0N64moPmWzJrpMffZwacsSWHGIXRBzlYGx
 mu63/KMLLcT7phOlAVOax8pWoD+wLjYhtBx9UV9Bg8pSg9vVqjsjouMoasC4A4kY1XOLejomiE
 Kiyt0irVjtUxEW+oeLQVZdhc
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="135067575"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 04:27:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 04:27:45 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Oct 2021 04:27:43 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 06/15] clk: at91: pmc: add sama7g5 to the list of available pmcs
Date:   Mon, 11 Oct 2021 14:27:10 +0300
Message-ID: <20211011112719.3951784-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SAMA7G5 to the list of available PMCs such that the suspend/resume
code for clocks to be used on backup mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/pmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 517973062719..5aa9c1f1c886 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -148,8 +148,9 @@ static struct syscore_ops pmc_syscore_ops = {
 	.resume = at91_pmc_resume,
 };
 
-static const struct of_device_id sama5d2_pmc_dt_ids[] = {
+static const struct of_device_id pmc_dt_ids[] = {
 	{ .compatible = "atmel,sama5d2-pmc" },
+	{ .compatible = "microchip,sama7g5-pmc", },
 	{ /* sentinel */ }
 };
 
@@ -157,7 +158,7 @@ static int __init pmc_register_ops(void)
 {
 	struct device_node *np;
 
-	np = of_find_matching_node(NULL, sama5d2_pmc_dt_ids);
+	np = of_find_matching_node(NULL, pmc_dt_ids);
 	if (!np)
 		return -ENODEV;
 
-- 
2.25.1

