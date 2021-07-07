Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F82B3BE899
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhGGNQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:16:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:55515 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhGGNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625663625; x=1657199625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OrFXiBwz/YRPNtkOvyK5iHEwXaa6NwWIdZB7F3lWqcQ=;
  b=OHjO5XlWpxjjk8tsRFS9zsNBjZZF6BMBY9lvjk18wbPC1PNKMse0Id56
   edFUTcSCUlmcNROPhBRH9rM1jedxorCl4/vDU7R6hVqb8LWEzzJWea6/u
   UjZXXSPK2YmXwf4OMfldVbN7VWIFc5Uw806roz42SDjj2uQNczmOL7MGP
   f2TNhLo0y9hE/jV6v4OZtZ2o20xUveoM3bXD/1HFd+up2LpH6OQyaYKSk
   BhGStcbvsfxynvgn+fcS+lo/Dt3CUI9pcZ9kGI69+MSriPsclu7dGLbdt
   Gbk4VBQ0WPCkpNfv5WGw2ATBgQ49dTk0wrn/EWn98GZxxMO8uwevXRtLZ
   w==;
IronPort-SDR: jqBTg+4MLviX3rE4Qw208TIsfSNlxzKBsFjphK8dHm5z25LFRCUCovZb66Afl7a7RzjbC42ZZv
 72xPR1EOGpBS35A/Fz8/IZPhFo8YsQSneSd9HmamW0jQ4Cf2WAI2DYZ8sqQnFnNliIAvKFB9t+
 EJIYfBt+ZDLrM1jem1fEvPYjHFdRdlzHcRtmfMu2FohzwUTRMsVpB/V9BJgPhLFEoDG0LYGbAz
 h6SpJjVYDes+zffTsktbPA6YrWfrbqFBER+e399oIRdCgGVZJSV8Sq7t/h6n6vAaUBX9R3ts5E
 kKU=
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="121241726"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2021 06:13:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Jul 2021 06:13:44 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 7 Jul 2021 06:13:41 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <claudiu.beznea@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH] clk: at91: clk-generated: Limit the requested rate to our range
Date:   Wed, 7 Jul 2021 16:12:13 +0300
Message-ID: <20210707131213.3283509-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On clk_generated_determine_rate(), the requested rate could be outside
of clk's range. Limit the rate to the clock's range to not return an
error.

Fixes: df70aeef6083 ("clk: at91: add generated clock driver")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 drivers/clk/at91/clk-generated.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index b4fc8d71daf2..b656d25a9767 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -128,6 +128,12 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 	int i;
 	u32 div;
 
+	/* do not look for a rate that is outside of our range */
+	if (gck->range.max && req->rate > gck->range.max)
+		req->rate = gck->range.max;
+	if (gck->range.min && req->rate < gck->range.min)
+		req->rate = gck->range.min;
+
 	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
 		if (gck->chg_pid == i)
 			continue;
-- 
2.30.2

