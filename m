Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479F932BD26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448501AbhCCPZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351575AbhCCKrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:47:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFB7C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:35:49 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHOr6-0001xE-4f
        for linux-kernel@vger.kernel.org; Wed, 03 Mar 2021 11:35:48 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D2E2B5ECB4A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 10:35:46 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2C58D5ECB44;
        Wed,  3 Mar 2021 10:35:46 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9a3d7d0b;
        Wed, 3 Mar 2021 10:35:45 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] time: timecounter_cyc2time(): mark 1st argument (struct timecounter) as const
Date:   Wed,  3 Mar 2021 11:35:44 +0100
Message-Id: <20210303103544.994855-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the timecounter is not modified in this function, mark it as const.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/timecounter.h | 2 +-
 kernel/time/timecounter.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/timecounter.h b/include/linux/timecounter.h
index 754b74a2167f..c6540ceea143 100644
--- a/include/linux/timecounter.h
+++ b/include/linux/timecounter.h
@@ -124,7 +124,7 @@ extern u64 timecounter_read(struct timecounter *tc);
  * This allows conversion of cycle counter values which were generated
  * in the past.
  */
-extern u64 timecounter_cyc2time(struct timecounter *tc,
+extern u64 timecounter_cyc2time(const struct timecounter *tc,
 				u64 cycle_tstamp);
 
 #endif
diff --git a/kernel/time/timecounter.c b/kernel/time/timecounter.c
index 85b98e727306..e6285288d765 100644
--- a/kernel/time/timecounter.c
+++ b/kernel/time/timecounter.c
@@ -76,7 +76,7 @@ static u64 cc_cyc2ns_backwards(const struct cyclecounter *cc,
 	return ns;
 }
 
-u64 timecounter_cyc2time(struct timecounter *tc,
+u64 timecounter_cyc2time(const struct timecounter *tc,
 			 u64 cycle_tstamp)
 {
 	u64 delta = (cycle_tstamp - tc->cycle_last) & tc->cc->mask;
-- 
2.30.1


