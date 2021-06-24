Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DEA3B2749
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 08:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFXGRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 02:17:08 -0400
Received: from smtp1.hiworks.co.kr ([121.254.168.204]:19798 "EHLO
        smtp1.hiworks.co.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhFXGRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:17:08 -0400
Received: (qmail 141388 invoked from network); 24 Jun 2021 15:14:45 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.21.201)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        24 Jun 2021 15:14:45 +0900
Received: (qmail 29379 invoked from network); 24 Jun 2021 15:14:45 +0900
Received: from unknown (HELO localhost.localdomain) (tykwon@m2i.co.kr@58.75.176.98)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        24 Jun 2021 15:14:45 +0900
X-Authinfo: HIWORKS SMTP authenticated <tykwon@m2i.co.kr|58.75.176.98|tykwon@m2i.co.kr|210624151445_617828793>
From:   Kwon Tae-young <tykwon@m2i.co.kr>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kwon Tae-young <tykwon@m2i.co.kr>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Added support for LED trigger only when SD card is connected
Date:   Thu, 24 Jun 2021 15:14:17 +0900
Message-Id: <20210624061418.30361-1-tykwon@m2i.co.kr>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

led_trigger_event() is always called.
In this case, if the LED trigger is set to the SD Card, the trigger
will occur even when the SD card is not connected and the LED will blink.

In case of SD Card, it is judged based on Card Detection information and
changes to generate LED trigger only when SD Card is connected.

Board tested: NXP i.MX 8M board

Signed-off-by: Kwon Tae-young <tykwon@m2i.co.kr>
---
 drivers/mmc/core/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f194940c5974..b3156f6c5cfa 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -352,7 +352,11 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		return err;
 
-	led_trigger_event(host->led, LED_FULL);
+	if (host->ops->get_cd)
+		host->ops->get_cd(host) ? led_trigger_event(host->led, LED_FULL) : NULL;
+	else
+		led_trigger_event(host->led, LED_FULL);
+
 	__mmc_start_request(host, mrq);
 
 	return 0;
-- 
2.17.1

