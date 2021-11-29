Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47801460DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 05:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhK2EKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 23:10:20 -0500
Received: from smtpbg703.qq.com ([203.205.195.89]:56100 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231724AbhK2EIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 23:08:19 -0500
X-QQ-mid: bizesmtp48t1638158696t2ha1n3x
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 29 Nov 2021 12:04:50 +0800 (CST)
X-QQ-SSF: B1400000002000B0F000000B0000000
X-QQ-FEAT: Y/4E1fKPEOoSdHOJelqpd8WQpw0lxAJM0rqutnli2zV/DIkQXfl9n5vdNWVw+
        Lq8zJkqUwRa6gULvpKmKyCM1XGhQc4tAwZHVFl3GLP8ZHOG6d7ga7mW5V6luTiuYmcVq3cs
        56RHeiOaiaDI2YMnfcLqezp9q7a8GnMKidYl9XQdd4W151K6c3w9xiYVh+HDYbefpEP/Va9
        VQ0XuamWjMMwaOdDxMSY+l5UsfHE49Y4tUydR/j3JvCo7rrkDs7EeGcV9DQa486Du+BNMe/
        WQ64YcFEnh7h8P0weuw95evxur44JVSr3zc+4t2pGbQAHsbPKgI2qd9dx11/9L7zrK8M4/7
        WJ5hPSqhffNZth2wsmGV8B86PL7tSyvm4vTt5XC/BgW7BHSDFQ=
X-QQ-GoodBg: 1
From:   lianzhi chang <changlianzhi@uniontech.com>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com, lianzhi chang <changlianzhi@uniontech.com>
Subject: [PATCH v18] tty: Fix the keyboard led light display problem
Date:   Mon, 29 Nov 2021 12:04:45 +0800
Message-Id: <20211129040445.24134-1-changlianzhi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the "ctrl+alt+Fn" key combination to switch the system from tty to
desktop or switch the system from desktop to tty. After the switch is
completed, it is found that the state of the keyboard lock is
inconsistent with the state of the keyboard Led light.The reasons are
as follows:

* The desktop environment (Xorg and other services) is bound to a tty
  (assuming it is tty1), and the kb->kbdmode attribute value of tty1
  will be set to VC_OFF. According to the current code logic, in the
  desktop environment, the values of ledstate and kb->ledflagstate
  of tty1 will not be modified anymore, so they are always 0.

* When switching between each tty, the final value of ledstate set by
  the previous tty is compared with the kb->ledflagstate value of the
  current tty to determine whether to set the state of the keyboard
  light. The process of switching between desktop and tty is also the
  process of switching between tty1 and other ttys. There are two
  situations:

  - (1) In the desktop environment, tty1 will not set the ledstate,
  which will cause when switching from the desktop to other ttys,
  if the desktop lights up the keyboard's led, after the switch is
  completed, the keyboard's led light will always be on;

  - (2) When switching from another tty to the desktop, this
  mechanism will trigger tty1 to set the led state. If other tty
  lights up the led of the keyboard before switching to the desktop,
  the led will be forcibly turned off. This situation should
  be avoided.

* The current patch is to solve these problems: by judging the
  kb->kbdmode value of the current tty, it is determined whether
  the led state is forced to be set when the VT switch is completed.

Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 v18:
 (1) Modify the description information.
 (2) The judgment condition of kb->kbdmode should be "!=",
 correct it.
 (3) Modify code indentation.
 
 drivers/tty/vt/keyboard.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..bcf8a858afd2 100644
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
+	if (kb->kbdmode != VC_RAW ||
+		 kb->kbdmode != VC_MEDIUMRAW ||
+		 kb->kbdmode != VC_OFF) {
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



