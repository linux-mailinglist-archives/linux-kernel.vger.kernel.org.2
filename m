Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47ABD32A1F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349322AbhCBHOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:14:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:39618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577540AbhCBGXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:23:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36E36AF9A;
        Tue,  2 Mar 2021 06:22:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 10/44] tty: imx, use ms_to_ktime
Date:   Tue,  2 Mar 2021 07:21:40 +0100
Message-Id: <20210302062214.29627-10-jslaby@suse.cz>
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
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
---
 drivers/tty/serial/imx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8257597d034d..3f69356937ef 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -394,11 +394,7 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
 
 static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
 {
-       long sec = msec / MSEC_PER_SEC;
-       long nsec = (msec % MSEC_PER_SEC) * 1000000;
-       ktime_t t = ktime_set(sec, nsec);
-
-       hrtimer_start(hrt, t, HRTIMER_MODE_REL);
+       hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
 }
 
 /* called with port.lock taken and irqs off */
-- 
2.30.1

