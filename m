Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2C43CD203
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhGSJxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 05:53:51 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47206
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235440AbhGSJxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:53:51 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 272FC40334;
        Mon, 19 Jul 2021 10:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626690870;
        bh=oD0uyN5gHA69IbTnnbd6ii92QeiCFwsBKCa7VtjsOp8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=p3RfhgLW4LF4rmf7I9Hq2e7Ay9l58gFnwmJm19NIr1bnkA2yRT737hF9y3UpXd3VC
         2V5VnURhQLvcpqoTMq3nNHGZR+nYnGWKNrSW8+LZbc+TPpamgtuwtrlEnZMIMVZyvn
         2sJOB62r9J+8avlZwMwAMfnqPOmzK9Ko06X/tlM6oAbAN+0l5TNcWsF3K6fGhyuzWM
         9U4uqacf/bsYjGzBnD4DQs1zo0Ihx9pNXBh8hsiyC9eZax/A0sEzueB3yrUYbwSTcR
         lyV3fltBZyWbWnXXAJ9R2IkRuLSDVJkhOqm/9bLGZbqSMvxDsPyo/pOa4NTtvkPmc7
         bK1IRNITu5q2g==
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: Fix a couple of spelling mistakes in Kconfig
Date:   Mon, 19 Jul 2021 11:34:29 +0100
Message-Id: <20210719103429.15544-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of spelling mistakes in the Kconfig text. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6562d4c243b0..c63d5faa883c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1044,7 +1044,7 @@ config REGULATOR_RT6160
 	help
 	  This adds support for voltage regulator in Richtek RT6160.
 	  This device automatically change voltage output mode from
-	  Buck or Boost. The mode transistion depend on the input source voltage.
+	  Buck or Boost. The mode transition depend on the input source voltage.
 	  The wide output range is from 2025mV to 5200mV and can be used on most
 	  common application scenario.
 
@@ -1053,7 +1053,7 @@ config REGULATOR_RT6245
 	depends on I2C
 	select REGMAP_I2C
 	help
-	  This adds supprot for Richtek RT6245 voltage regulator.
+	  This adds support for Richtek RT6245 voltage regulator.
 	  It can support up to 14A output current and adjustable output voltage
 	  from 0.4375V to 1.3875V, per step 12.5mV.
 
-- 
2.31.1

