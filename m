Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BBA309C8D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhAaOGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhAaKnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 05:43:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF5FC0613D6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 02:40:40 -0800 (PST)
Date:   Sun, 31 Jan 2021 10:40:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612089639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7hwUYghopTpmgD4Eujx9wWOzCVXxKHHsLt3YXM4KDJs=;
        b=uZ9MaX+CyODGCe0NdRcw5a4+dN6jU3FpX5Rw5nzdLVqrASn4Dlh6AeMVIf9B5U6YLeplQH
        9uiqVixDNdA4nxjUvMKQnu8G2MGNxEnFKAFEdmzz8fmih3D57CqyszHO4Y2zUMdZBv4a3g
        KNOznng3RJZ3Nyz+zmCcHoYmgX/l61HCDBIKsO464Wv4XHwVEb4+gzB654ThPRfGS4BEcU
        bPLeEA9grtt3nVAshAL+0n4RcFJvdV7zH++h7Kud2NC6MpNQCN64aNxKvubYRsRf+HQjdz
        EE3xCAg1RmvB7X7Uqs/gdtsJQCTGfhdULfZepeGAIwCIi4gchZRZGgvDZ81Q9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612089639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7hwUYghopTpmgD4Eujx9wWOzCVXxKHHsLt3YXM4KDJs=;
        b=8EvYehGqTA2Udv0V/9oN8uYQ2eUvMHVswAbnmrVmS66p0iYQsd4uSM58q0I5Cr2tJg9f4i
        EnnBXH51ckD+/XBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.11-rc6
References: <161208961675.22671.12893376547737348246.tglx@nanos>
Message-ID: <161208961796.22671.11474931705642662612.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-01-31

up to:  211e5db19d15: rtc: mc146818: Detect and handle broken RTCs


A fix for handling advertised, but non-existent 146818 RTCs correctly. With
the recent UIP handling changes the time readout of non-existent RTCs hangs
forever as the read returns always 0xFF which means the UIP bit is
set. Sanity check the RTC before registering by checking the RTC_VALID
register for correctness.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      rtc: mc146818: Detect and handle broken RTCs


 drivers/rtc/rtc-cmos.c         | 8 ++++++++
 drivers/rtc/rtc-mc146818-lib.c | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 51e80bc70d42..68a9ac6f2fe1 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -805,6 +805,14 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 
 	spin_lock_irq(&rtc_lock);
 
+	/* Ensure that the RTC is accessible. Bit 0-6 must be 0! */
+	if ((CMOS_READ(RTC_VALID) & 0x7f) != 0) {
+		spin_unlock_irq(&rtc_lock);
+		dev_warn(dev, "not accessible\n");
+		retval = -ENXIO;
+		goto cleanup1;
+	}
+
 	if (!(flags & CMOS_RTC_FLAGS_NOFREQ)) {
 		/* force periodic irq to CMOS reset default of 1024Hz;
 		 *
diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index 972a5b9a629d..f83c13818af3 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -21,6 +21,13 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 
 again:
 	spin_lock_irqsave(&rtc_lock, flags);
+	/* Ensure that the RTC is accessible. Bit 0-6 must be 0! */
+	if (WARN_ON_ONCE((CMOS_READ(RTC_VALID) & 0x7f) != 0)) {
+		spin_unlock_irqrestore(&rtc_lock, flags);
+		memset(time, 0xff, sizeof(*time));
+		return 0;
+	}
+
 	/*
 	 * Check whether there is an update in progress during which the
 	 * readout is unspecified. The maximum update time is ~2ms. Poll

