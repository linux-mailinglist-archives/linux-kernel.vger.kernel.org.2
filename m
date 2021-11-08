Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F41447A39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 06:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbhKHFsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 00:48:10 -0500
Received: from smtpbg506.qq.com ([203.205.250.33]:49749 "EHLO smtpbg506.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236975AbhKHFsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 00:48:09 -0500
X-QQ-mid: bizesmtp38t1636350317tyj7dpee
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 08 Nov 2021 13:45:13 +0800 (CST)
X-QQ-SSF: B1400000002000B0E000B00A0000000
X-QQ-FEAT: jfdGVjI73+Ry5m3tviFPMrXtRbCAlkfMdLYOFr6lv8iIFhrzNOpBALBJHUbyR
        ek1jUhwuBOOSvoCIoLmz+0PXVcZb2wJ+lZiFK00qyunODBbW9thqdpomw+75cWn9Rg+JrJY
        uKR7arQCPwVSmSX0VeKyAyza9eBT3Ap/EHo26WHwhIi7qRUiqD1YlVGrGqffN/S50NKPwhi
        ENQzbaYfbqQ8M5SUfOM7Q2V+gB+ShMRemJBzdP1YHdrwCbngjNFFk1jqj4dwCeniAeyIXwm
        KWVw/zEgB+nU22JppIsCcyzVLKezXp7zH9jFeNtbSwpqpvEpk1k5xDq2AfpAn2V6YB7Aq2Z
        F2YGFq11pSrVfdn3T7gju3ABVL1lyyHuDjEPgbO
X-QQ-GoodBg: 2
From:   lianzhi chang <changlianzhi@uniontech.com>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com, lianzhi chang <changlianzhi@uniontech.com>
Subject: [PATCH v13] tty: Fix the keyboard led light display problem
Date:   Mon,  8 Nov 2021 13:45:10 +0800
Message-Id: <20211108054510.4680-1-changlianzhi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching from the desktop environment to the tty environment,
the state of the keyboard led lights and the state of the keyboard
lock are inconsistent. This is because the attribute kb->kbdmode
of the tty bound in the desktop environment (Xorg) is set to
VC_OFF, which causes the ledstate and kb->ledflagstate
values of the bound tty to always be 0, which causes the switch
from the desktop When to the tty environment, the LED light
status is inconsistent with the keyboard lock status.
In order to ensure that the keyboard LED lights are displayed
normally during the VT switching process, when the VT is
switched, the current VT LED configuration is forced to be issued.

Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
Suggested-by: dmitry.torokhov <dmitry.torokhov@gmail.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 v13:
 The kbd_bh function no longer handles the "kb->kbdmode == VC_OFF"
 scene, but puts this process in vt_set_leds_compute_shiftstate
 together. Because the current circumvention is that other ttys
 switch to the Xorg-bound tty scene, so this Better.
 
 drivers/tty/vt/keyboard.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..ede9206d6c99 100644
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
+	/* Xorg will bind a tty, the kb->kbdmode of this tty will be set to 
+	 * VC_OFF, and this tty will no longer set the keyboard light. If 
+	 * there is no such restriction, when switching from other tty to 
+	 * Xorg-bound tty, the tty will set the keyboard light, which is 
+	 * unreasonable
+	 */
+	kb = kbd_table + fg_console;
+	if (kb->kbdmode != VC_OFF)
+	{
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



