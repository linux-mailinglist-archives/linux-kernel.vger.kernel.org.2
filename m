Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB25E379C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhEKBqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:46:31 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:39679 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhEKBq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:46:27 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6032920003;
        Tue, 11 May 2021 01:45:20 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] alarmtimer: check RTC features instead of ops
Date:   Tue, 11 May 2021 03:45:16 +0200
Message-Id: <20210511014516.563031-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC drivers used to leave .set_alarm() NULL in order to signal the RTC
device doesn't support alarms. The drivers are now clearing the
RTC_FEATURE_ALARM bit for that purpose in order to keep the rtc_class_ops
structure const. So now, .set_alarm() is set unconditionally and this
possibly causes the alarmtimer code to select an RTC device that doesn't
support alarms.

Test RTC_FEATURE_ALARM instead of relying on ops->set_alarm to determine
whether alarms are available.

Fixes: 7ae41220ef58 ("rtc: introduce features bitfield")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index bea9d08b1698..5897828b9d7e 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -92,7 +92,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	if (rtcdev)
 		return -EBUSY;
 
-	if (!rtc->ops->set_alarm)
+	if (!test_bit(RTC_FEATURE_ALARM, rtc->features))
 		return -1;
 	if (!device_may_wakeup(rtc->dev.parent))
 		return -1;
-- 
2.31.1

