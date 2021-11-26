Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5589345EBEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhKZKyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:54:20 -0500
Received: from smtpbgsg1.qq.com ([54.254.200.92]:41543 "EHLO smtpbgsg1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376959AbhKZKwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:52:18 -0500
X-QQ-mid: bizesmtp40t1637923721tlakymwu
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 26 Nov 2021 18:48:35 +0800 (CST)
X-QQ-SSF: B1400000002000B0F000B00A0000000
X-QQ-FEAT: gYiVu/z0yd/cH6TA/IFyselHzYKBnHqikAZUpdSoLWaw5MR6yle1DFaVNAwSY
        RjTA7vLp0Fb51uBIC4YxNtvC4eUN0dR392wPj1z4W4II3MEW5OXJzppWwIvGBcy4st89HC8
        sT4hiG5F6c07d610jyiVNxt2CAusPYq8332hqy74JNzpRk1bIdl46dE6AAv4OfTXldA96Wn
        DmUELnwUdJVyvfRh3VpGDbo8tYz8Y+NVNiZvWlcmXISqBCs4NyfOaD/Z6irfYEMSSKUIrTT
        TV1r9bWX9HStDxHZmQMTvVXSx+uRJ4DejQ1lozvt1YBpqgrPNhMprF3iRv9ls99m4RAa1qP
        1IwBVtdt1I1DrSuNK9iouR130pFVtjC5qLsObC+n6sy6P2uLN0=
X-QQ-GoodBg: 2
From:   lianzhi chang <changlianzhi@uniontech.com>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com, lianzhi chang <changlianzhi@uniontech.com>
Subject: [PATCH v16] tty: Fix the keyboard led light display problem
Date:   Fri, 26 Nov 2021 18:48:32 +0800
Message-Id: <20211126104832.11371-1-changlianzhi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the desktop and tty switch mutually, the led state of the
keyboard may be inconsistent with the state of the keyboard lock.
This is because the desktop environment (Xorg, etc.) is bound to
a tty, and the kb->kbdmode attribute of this tty is set to VC_OFF.
This leads to the fact that in the desktop environment, the bound
tty will not set the keyboard light state, so in the current tty
scene, the values of ledstate and kb->ledflagstate are always 0.
This leads to two situations: (1) When switching from the desktop
to another tty, the code inside VT still compares ledstate with
the kb->ledflagstate of the next tty. If they are equal, then
after the switch is completed, The keyboard light will maintain
the state of the previous desktop settings, and the state of the
keyboard lock may be inconsistent; (2) When switching from another
tty to the desktop, according to the code logic, it may still
trigger the desktop bound tty to set the keyboard light state.
After the switch is completed, the keyboard light is forcibly
turned off. I think in this case, the tty should not set the
keyboard light, and give control to Xorg etc. to handle it.
The current modification judges the value of kb->kbdmode.
In some modes, when switching VT, the current tty keyboard
light status is forcibly issued. And when switching to the
desktop, the tty no longer sets the keyboard light.

Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 v15:
 (1) Modify the description information;
 (2) When switching VT, add the judgment on the two modes of
 VC_RAW and VC_MEDIUMRAW in the place where it is determined
 whether it is mandatory to set the led state of the
 keyboard, which is consistent with other places.
 v16:
 Change the signature; change the format of the note text.
 
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



