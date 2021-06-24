Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC653B2A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhFXITP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:19:15 -0400
Received: from david.siemens.de ([192.35.17.14]:51310 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231713AbhFXITO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:19:14 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 15O8GUB2016391
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 10:16:31 +0200
Received: from coregen2.erlf.siemens.de (coregen2.erlf.siemens.de [157.163.234.63])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 15O8GUl5016758;
        Thu, 24 Jun 2021 10:16:30 +0200
From:   Werner Zeh <werner.zeh@siemens.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org
Cc:     Werner Zeh <werner.zeh@siemens.com>
Subject: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC date and time
Date:   Thu, 24 Jun 2021 10:15:07 +0200
Message-Id: <20210624081507.15602-1-werner.zeh@siemens.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20210614110946.15587-1-werner.zeh@siemens.com>
References: <20210614110946.15587-1-werner.zeh@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timekeeper is synchronized with the CMOS RTC when it is initialized.
If the RTC buffering is bad (not buffered at all, empty battery) the RTC
registers can contain random data. In order to avoid date and time
being completely rubbish check the sanity of the registers before
calling mktime64. If the values are not valid, set tv_sec to 0 so that
at least the starting time is valid.

Signed-off-by: Werner Zeh <werner.zeh@siemens.com>
---
[resent due to wrong lkml address]
[added RTC maintainers to the recipients]
This change introduces the same validity check that is already done in
drivers/rtc/interface.c. If it is not done here, the timekeeper can be
set up wrongly in the first run and won't be corrected once the RTC driver
is started because the validity check in the RTC driver drops the time and
date due to invalid entries.

 arch/x86/kernel/rtc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 586f718b8e95..f4af7b18c6c0 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/pnp.h>
 #include <linux/of.h>
+#include <linux/rtc.h>
 
 #include <asm/vsyscall.h>
 #include <asm/x86_init.h>
@@ -64,6 +65,7 @@ void mach_get_cmos_time(struct timespec64 *now)
 {
 	unsigned int status, year, mon, day, hour, min, sec, century = 0;
 	unsigned long flags;
+	struct rtc_time tm = {0};
 
 	/*
 	 * If pm_trace abused the RTC as storage, set the timespec to 0,
@@ -118,7 +120,15 @@ void mach_get_cmos_time(struct timespec64 *now)
 	} else
 		year += CMOS_YEARS_OFFS;
 
-	now->tv_sec = mktime64(year, mon, day, hour, min, sec);
+	tm.tm_sec = sec;
+	tm.tm_min = min;
+	tm.tm_hour = hour;
+	tm.tm_mday = day;
+	tm.tm_mon = mon;
+	tm.tm_year = year;
+	now->tv_sec = 0;
+	if (rtc_valid_tm(&tm) == 0)
+		now->tv_sec = mktime64(year, mon, day, hour, min, sec);
 	now->tv_nsec = 0;
 }
 
-- 
2.21.3

