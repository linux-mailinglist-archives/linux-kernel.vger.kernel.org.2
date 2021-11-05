Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF692446355
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 13:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhKEM1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 08:27:48 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:56344 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhKEM1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 08:27:45 -0400
X-QQ-mid: bizesmtp40t1636115096t7d02pfo
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 05 Nov 2021 20:24:47 +0800 (CST)
X-QQ-SSF: B1400000002000B0E000B00A0000000
X-QQ-FEAT: zD6y7hNAcUB++xq7tffMJUeTC9c7Pwdkgb5HmTE+ryBlcDvITZzt67gMQ8n2n
        jFPLOYyGmdAD9oVRGhRcZp+q/1Yiq/d//PwIBSuhWwuGkTwQfDuyM/sUTJrM0AKBbh8jzDQ
        5ELB/xlUJ1PdVQQV2yXicfGeTUJ2T0u/cpVFEtnHYcN2sKl7Wt7YR/ZvwxtHUJUIWIgU4AL
        aYM+jFIpQEGPC79eN7k9wleWJdiAGQHGavFn1Du/pJRSiCJSzb0UKt8Cs0LcUEwdGtNhfPB
        feybi7c16Wg/u3bD6I92Q6N6HuoxJdDR5sZdfzutyMjCtdZkxteEcYpNUYQV7vKB4SRqcnY
        C48sGWBp0l0GGnoX1bQOpw8mInLww==
X-QQ-GoodBg: 2
From:   lianzhi chang <changlianzhi@uniontech.com>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com, lianzhi chang <changlianzhi@uniontech.com>
Subject: [PATCH v10] tty: Fix the keyboard led light display problem
Date:   Fri,  5 Nov 2021 20:24:43 +0800
Message-Id: <20211105122443.23897-1-changlianzhi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
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
---
 v10:
 The led state of the input device is no longer synchronized to 
 ledstate, and the related code is deleted. The current plan is
 changed to: when the VT is switched, the LED state saved by the
 current VT is forced to be issued.
 
 drivers/tty/vt/keyboard.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..20013c45b979 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -153,6 +153,7 @@ static int shift_state = 0;
 
 static unsigned int ledstate = -1U;			/* undefined */
 static unsigned char ledioctl;
+static bool vt_switch;
 
 /*
  * Notifier list for console keyboard events
@@ -412,8 +413,12 @@ static void do_compute_shiftstate(void)
 /* We still have to export this method to vt.c */
 void vt_set_leds_compute_shiftstate(void)
 {
+	struct kbd_struct *kb;
 	unsigned long flags;
 
+	kb = kbd_table + fg_console;
+	if (kb->kbdmode != VC_OFF)
+		vt_switch = true;
 	set_leds();
 
 	spin_lock_irqsave(&kbd_event_lock, flags);
@@ -1247,14 +1252,24 @@ void vt_kbd_con_stop(unsigned int console)
  */
 static void kbd_bh(struct tasklet_struct *unused)
 {
+	struct kbd_struct *kb;
 	unsigned int leds;
 	unsigned long flags;
 
+	kb = kbd_table + fg_console;
+	if (kb->kbdmode == VC_OFF)
+		return;
+
 	spin_lock_irqsave(&led_lock, flags);
 	leds = getleds();
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
@@ -1643,6 +1658,8 @@ int __init kbd_init(void)
 	int i;
 	int error;
 
+	vt_switch = false;
+
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		kbd_table[i].ledflagstate = kbd_defleds();
 		kbd_table[i].default_ledflagstate = kbd_defleds();
-- 
2.20.1



