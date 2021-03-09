Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40368332781
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhCINrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCINr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:47:29 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59720C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:47:29 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DvxNJ08gsz1s1JH;
        Tue,  9 Mar 2021 14:47:27 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DvxNH6pzmz1r1Mc;
        Tue,  9 Mar 2021 14:47:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 5JTOmEEOy3Nd; Tue,  9 Mar 2021 14:47:27 +0100 (CET)
X-Auth-Info: 6ygmABytYpN96HXdI2y97nkJkQ9UdCT22oBG/aD7Jio=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  9 Mar 2021 14:47:27 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 009E4181BA1;
        Tue,  9 Mar 2021 14:47:21 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
        id E3E0A1A0092; Tue,  9 Mar 2021 14:47:20 +0100 (CET)
From:   Heiko Schocher <hs@denx.de>
To:     linux-rtc@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: rv3028: correct weekday register usage
Date:   Tue,  9 Mar 2021 14:47:19 +0100
Message-Id: <20210309134719.1494062-1-hs@denx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet for the rv3028 says the weekday has exact 3 bits
and in chapter 3.4.0 for the "3h–Weekday" register it says:
"""
This register holds the current day of the week. Each value represents
one weekday that is assigned by the user. Values will range from 0 to 6
The weekday counter is simply a 3-bit counter which counts up to 6
and then resets to 0.
"""

So do not code weekday bitwise instead, use the raw values from
0-6.

Tested on "PHYTEC phyBOARD-Pollux i.MX8MP" board.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 drivers/rtc/rtc-rv3028.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index 0c48d980d06ae..12c807306893f 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -320,7 +320,7 @@ static int rv3028_get_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_sec  = bcd2bin(date[RV3028_SEC] & 0x7f);
 	tm->tm_min  = bcd2bin(date[RV3028_MIN] & 0x7f);
 	tm->tm_hour = bcd2bin(date[RV3028_HOUR] & 0x3f);
-	tm->tm_wday = ilog2(date[RV3028_WDAY] & 0x7f);
+	tm->tm_wday = date[RV3028_WDAY] & 0x7f;
 	tm->tm_mday = bcd2bin(date[RV3028_DAY] & 0x3f);
 	tm->tm_mon  = bcd2bin(date[RV3028_MONTH] & 0x1f) - 1;
 	tm->tm_year = bcd2bin(date[RV3028_YEAR]) + 100;
@@ -337,7 +337,7 @@ static int rv3028_set_time(struct device *dev, struct rtc_time *tm)
 	date[RV3028_SEC]   = bin2bcd(tm->tm_sec);
 	date[RV3028_MIN]   = bin2bcd(tm->tm_min);
 	date[RV3028_HOUR]  = bin2bcd(tm->tm_hour);
-	date[RV3028_WDAY]  = 1 << (tm->tm_wday);
+	date[RV3028_WDAY]  = tm->tm_wday;
 	date[RV3028_DAY]   = bin2bcd(tm->tm_mday);
 	date[RV3028_MONTH] = bin2bcd(tm->tm_mon + 1);
 	date[RV3028_YEAR]  = bin2bcd(tm->tm_year - 100);
-- 
2.29.2

