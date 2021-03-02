Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363F432A1F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347939AbhCBHPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:15:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:39620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577539AbhCBGXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:23:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56B31AF9C;
        Tue,  2 Mar 2021 06:22:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/44] tty: 8250, use ms_to_ktime
Date:   Tue,  2 Mar 2021 07:21:41 +0100
Message-Id: <20210302062214.29627-11-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This really eliminates multiplications from the assembly. I would have
thought they are optimized by inlining ktime_set, but not on x86_64 with
gcc 10.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/8250/8250_port.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b0af13074cd3..167c1e3e53bc 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1487,11 +1487,7 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 
 static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
 {
-	long sec = msec / 1000;
-	long nsec = (msec % 1000) * 1000000;
-	ktime_t t = ktime_set(sec, nsec);
-
-	hrtimer_start(hrt, t, HRTIMER_MODE_REL);
+	hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
 }
 
 static void __stop_tx_rs485(struct uart_8250_port *p)
-- 
2.30.1

