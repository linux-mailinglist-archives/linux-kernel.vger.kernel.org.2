Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCEF45ECA3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbhKZLdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:33:01 -0500
Received: from smtpbgeu2.qq.com ([18.194.254.142]:52950 "EHLO smtpbgeu2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241470AbhKZLbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:31:00 -0500
X-Greylist: delayed 2338 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 06:30:59 EST
X-QQ-mid: bizesmtp36t1637926061tdr1ln5d
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 26 Nov 2021 19:27:31 +0800 (CST)
X-QQ-SSF: B1400000002000B0F000B00A0000000
X-QQ-FEAT: HoyAXBWgskka4bh9UyaNZ1144nv/V1jU2BzTHZ5WhQgAGl1YBN0+VXcDWJJ08
        1lHzRKGXuafNjA85SaAxQU4Xdag+c1UhvEOfzgfZ/bYsO5kf94gmG9mKEBM+q3cq2Pf4+bV
        UYqeI3MKdgAmnAEisBCJMiLYriF8hPwDPfTxiS7K2HBR+0EYTd32KBlC3N4SyzKr1ewUoUo
        lMUfCRCWaCOzXyGtatsQ0skZidIDd+e9Kg7lYgScc6lsR3BMv4azksBHeMhqsKwJ/sgoh+h
        eRU+68q7+9MfzfH8tdQjt6rU3+JX3Z1yv3MO54bkY2VGBEKa3NIg9iUIrTUQJ2PhgoTLFas
        qsgxtcWY6nHnKu41qMQ2ty1ZMbojDbpoSL5qIY6TFuo5BeDFCc=
X-QQ-GoodBg: 2
From:   lianzhi chang <changlianzhi@uniontech.com>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com, lianzhi chang <changlianzhi@uniontech.com>
Subject: [PATCH v17] tty: Fix the keyboard led light display problem
Date:   Fri, 26 Nov 2021 19:27:27 +0800
Message-Id: <20211126112727.14939-1-changlianzhi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By judging the value of kb->kbdmode to determine whether it is necessary
to forcibly set the led state of the keyboard when switching between
different ttys. Solve the problem of the inconsistency between the
keyboard led status and the keyboard lock status in some scenarios,
such as the scenario where the desktop and tty switch mutually.

Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 v17: Modify the description information.
 
 drivers/tty/vt/keyboard.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..e60ac9f39d6c 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -153,6 +153,7 @@ static int shift_state = 0;
 
 static unsigned int ledstate = -1U;			/* undefined */
 static unsigned char ledioctl;
+static bool vt_switch;
 
 /*
  * Notifier list for console keyboard events
@@ -412,9 +413,21 @@ static void do_compute_shiftstate(void)
 /* We still have to export this method to vt.c */
 void vt_set_leds_compute_shiftstate(void)
 {
+	struct kbd_struct *kb;
 	unsigned long flags;
 
-	set_leds();
+	/*
+	 * When switching VT, according to the value of kb->kbdmode,
+	 * judge whether it is necessary to force the keyboard light
+	 * state to be issued.
+	 */
+	kb = kbd_table + fg_console;
+	if (kb->kbdmode == VC_RAW ||
+	     kb->kbdmode == VC_MEDIUMRAW ||
+	     kb->kbdmode == VC_OFF) {
+		vt_switch = true;
+		set_leds();
+	}
 
 	spin_lock_irqsave(&kbd_event_lock, flags);
 	do_compute_shiftstate();
@@ -1255,6 +1268,11 @@ static void kbd_bh(struct tasklet_struct *unused)
 	leds |= (unsigned int)kbd->lockstate << 8;
 	spin_unlock_irqrestore(&led_lock, flags);
 
+	if (vt_switch) {
+		ledstate = ~leds;
+		vt_switch = false;
+	}
+
 	if (leds != ledstate) {
 		kbd_propagate_led_state(ledstate, leds);
 		ledstate = leds;
-- 
2.20.1



