Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A1D3E49AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhHIQVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbhHIQVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:21:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2251C06179E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:20:56 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1mD816-00021Z-BA; Mon, 09 Aug 2021 18:20:44 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1mD814-0008Kd-Se; Mon, 09 Aug 2021 18:20:42 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH v5 3/7] watchdog: f71808e_wdt: constify static array
Date:   Mon,  9 Aug 2021 18:20:33 +0200
Message-Id: <9720c5a1efcef861da68b693453bb3eb3c21af37.1628525954.git-series.a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.3654d10d79751f1b01adc9403f9840543df4bcc4.1628525954.git-series.a.fatoum@pengutronix.de>
References: <cover.3654d10d79751f1b01adc9403f9840543df4bcc4.1628525954.git-series.a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fintek_wdt_names is meant for read-only use and is currently not
modified. Mark it const to catch future writes.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/watchdog/f71808e_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 3a0b29cb5854..8913747517fa 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -112,7 +112,7 @@ MODULE_PARM_DESC(start_withtimeout, "Start watchdog timer on module load with"
 enum chips { f71808fg, f71858fg, f71862fg, f71868, f71869, f71882fg, f71889fg,
 	     f81803, f81865, f81866};
 
-static const char *f71808e_names[] = {
+static const char * const f71808e_names[] = {
 	"f71808fg",
 	"f71858fg",
 	"f71862fg",
-- 
git-series 0.9.1
