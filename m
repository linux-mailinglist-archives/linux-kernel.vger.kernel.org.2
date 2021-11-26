Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACE845E65B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 04:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359263AbhKZCv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:51:59 -0500
Received: from smtpbguseast3.qq.com ([54.243.244.52]:34954 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359267AbhKZCsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:48:18 -0500
X-QQ-mid: bizesmtp46t1637894675t7d2w1m9
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 26 Nov 2021 10:44:25 +0800 (CST)
X-QQ-SSF: B1400000002000B0F000B00A0000000
X-QQ-FEAT: Mzskoac49OgLCZCEqrgR0I0dpqAh7G35zNfJOeFSrdlT9deVfRkdC7ggXIQWj
        R94jVao+ovJHw9zQNgV7gQevFYGdLd4VSn7AZMH/zuAU9SC0Z3WqcOgSy4vgLERpBe2J+O9
        AdenW2V/7V9ov7FCwOLBeGk7Wmy1gEz1esbcG12/ityCG6olTyhvsPpYEd9WFTTQsCtUrFp
        Y6p7wgbwvqudrahuE9+f2fsAYNTyfmhtmONTlkW0uq3Y6ti+QEbVKDHe9DnS95mqB6BohFn
        zllmspLLFwUzUqV2Ol0XLKL0GPRVi46P4eh6m9yDKfMdD+EJDupRYxQlhlsslEUesspByEp
        k4Hsog6w+mIjTXuwZVeXdQ6qgvKnYXj2igHUphY
X-QQ-GoodBg: 2
From:   lianzhi chang <changlianzhi@uniontech.com>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com, lianzhi chang <changlianzhi@uniontech.com>
Subject: [PATCH v15] tty: Fix the keyboard led light display problem
Date:   Fri, 26 Nov 2021 10:44:23 +0800
Message-Id: <20211126024423.17218-1-changlianzhi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
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
Suggested-by: dmitry.torokhov <dmitry.torokhov@gmail.com>
---
 v15:
 (1) Modify the description information;
 (2) When switching VT, add the judgment on the two modes of
 VC_RAW and VC_MEDIUMRAW in the place where it is determined
 whether it is mandatory to set the led state of the
 keyboard, which is consistent with other places.
 
 drivers/tty/vt/keyboard.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..98ec12001368 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -153,6 +153,7 @@ static int shift_state = 0;
 
 static unsigned int ledstate = -1U;			/* undefined */
 static unsigned char ledioctl;
+static bool vt_switch;
 
 /*
  * Notifier list for console keyboard events
@@ -412,9 +413,20 @@ static void do_compute_shiftstate(void)
 /* We still have to export this method to vt.c */
 void vt_set_leds_compute_shiftstate(void)
 {
+	struct kbd_struct *kb;
 	unsigned long flags;
 
-	set_leds();
+	/* When switching VT, according to the value of kb->kbdmode,
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
@@ -1255,6 +1267,11 @@ static void kbd_bh(struct tasklet_struct *unused)
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



