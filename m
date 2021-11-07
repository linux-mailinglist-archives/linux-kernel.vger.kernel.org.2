Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8544447685
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 23:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbhKGW5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 17:57:53 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:59177 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbhKGW5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 17:57:48 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 858C6240002;
        Sun,  7 Nov 2021 22:55:04 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] rtc: ab-eoz9: use RTC_FEATURE_UPDATE_INTERRUPT
Date:   Sun,  7 Nov 2021 23:54:49 +0100
Message-Id: <20211107225458.111068-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211107225458.111068-1-alexandre.belloni@bootlin.com>
References: <20211107225458.111068-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from uie_unsupported to RTC_FEATURE_UPDATE_INTERRUPT

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab-eoz9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ab-eoz9.c b/drivers/rtc/rtc-ab-eoz9.c
index a9b355510cd4..50ead6fce880 100644
--- a/drivers/rtc/rtc-ab-eoz9.c
+++ b/drivers/rtc/rtc-ab-eoz9.c
@@ -534,7 +534,7 @@ static int abeoz9_probe(struct i2c_client *client,
 	data->rtc->ops = &rtc_ops;
 	data->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	data->rtc->range_max = RTC_TIMESTAMP_END_2099;
-	data->rtc->uie_unsupported = 1;
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, data->rtc->features);
 	clear_bit(RTC_FEATURE_ALARM, data->rtc->features);
 
 	if (client->irq > 0) {
-- 
2.31.1

