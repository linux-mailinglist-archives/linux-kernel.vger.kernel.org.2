Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A735E351D3B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbhDAS1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:27:44 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:19744 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbhDASAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617300021; x=1648836021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qV0JxVgerqrpLMTEzoS0XnWxl85b6WMlFIIcxkZ+TjA=;
  b=SNjIeISrINs5exAYkmkxdXoSF0PgLclb6owuVW6yO7yvIPyD/L5wCjUT
   bKeoIXCpb2S57hYqstTR8UX6+JHVrBtGBTqrn5o7GzDaAzp+VWS1CkpnD
   myIrnxiomhq9SY8qI+LONrNobWSg8eQZuTEwhla/RYjgPejUux5SL0W0s
   zWSftFfLPx7NIZdEFTlKEcylWvfT0OmNCOzK2O8sMG0Zvp8RUvm7qRw7q
   USLeMXugGp0Vo2BTxOlNmReeSvDFKv+l0I7de6KBhVmqrXPMicYfq7jBh
   Q7uN1LeXcjMyRpwEyfVj1m42CCUKBsPMN235yqpajKM163BpsIaT1CX9T
   g==;
IronPort-SDR: zldxxCiHHG/Lh8GGOQ4c2+3s+yeEkqsJHfy+vbinGhayR0aJVywtQMIw6IsGHylqbmObUjJ7Hv
 6JNfXM45GM4JcljkrNdNe5ItETVysoTAjGfN8c73hWzIOaizyvAHJGQ0CIlSxWMyrZY5aSliBt
 f72Z/3unnUvMX7fftxNpzLJiOkBlBNeMcIQw9216O7Ql+ou9RbyCZbEfg5t17In/8TJ6Zn1/qg
 rPvaWywznAq4eCvSt0DJ+MM/6zGWyLgPcNULFW61DiSXHtF87xYVhMhjr0WeMknBXQHr7WeoaJ
 Obw=
X-IronPort-AV: E=Sophos;i="5.81,296,1610434800"; 
   d="scan'208";a="109344809"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2021 05:27:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 05:27:39 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 1 Apr 2021 05:27:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <viresh.kumar@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/6] clk: at91: sama7g5: add securam's peripheral clock
Date:   Thu, 1 Apr 2021 15:27:23 +0300
Message-ID: <20210401122726.28528-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210401122726.28528-1-claudiu.beznea@microchip.com>
References: <20210401122726.28528-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SECURAM's peripheral clock.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 9e1ec48c4474..9c87b50abbae 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -377,6 +377,7 @@ static const struct {
 	u8 id;
 } sama7g5_periphck[] = {
 	{ .n = "pioA_clk",	.p = "mck0", .id = 11, },
+	{ .n = "securam_clk",	.p = "mck0", .id = 18, },
 	{ .n = "sfr_clk",	.p = "mck1", .id = 19, },
 	{ .n = "hsmc_clk",	.p = "mck1", .id = 21, },
 	{ .n = "xdmac0_clk",	.p = "mck1", .id = 22, },
-- 
2.25.1

