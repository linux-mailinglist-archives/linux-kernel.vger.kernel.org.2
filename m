Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC454358C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 05:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJUDEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 23:04:40 -0400
Received: from smtpbguseast3.qq.com ([54.243.244.52]:57632 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUDEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 23:04:39 -0400
X-QQ-mid: bizesmtp44t1634785336to95vbq5
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 21 Oct 2021 11:02:08 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00A0000000
X-QQ-FEAT: 0YKk8i+cYxzJtGdd1MILtRSoIj2r0mLHXjFF/M9b19aTQRAwSQBaYFKIFSTf2
        V00nYYppqZqVBiPW2CQzziQRkH06qeoG7y6tEgjTssOI8c4XjGq/iJTqnbENXmBpswTN1Uq
        G+0dx21wFNDQQ2CGv+OqZbQdULbenG7WcuxJmn3u60sPiC6B37FKixafb7oSwxjRoK7Wlm7
        1jizQKy1HswZG2Fr7Og2lmgbLNAbk2NLvSbsxJUeX7LuGU5g6Y0yl63zs8Pum6Ia2SN+VOG
        yLfcCciv8mIf5aecPidBXTBAPpPqus/Qm5Uat+wbwO8ed+mNj8gKijRJ4zOlB+vKPNB9J/x
        Hjfzd4lp6nmTr7rOBbLlKhu0zMimT+bU3xnrGXRlV30pfAL16Q=
X-QQ-GoodBg: 2
From:   lianzhi chang <changlianzhi@uniontech.com>
To:     linux-kernel@vger.kernel.org
Cc:     lianzhi chang <changlianzhi@uniontech.com>
Subject: [PATCH v6] tty: Fix the keyboard led light display problem
Date:   Thu, 21 Oct 2021 11:02:06 +0800
Message-Id: <20211021030206.492-1-changlianzhi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching from the desktop environment to the tty environment,
the state of the keyboard led lights and the state of the keyboard
lock are inconsistent. This is because the attribute kb->kbdmode
of the tty bound in the desktop environment (xorg) is set to
VC_OFF, which causes the ledstate and kb->ledflagstate
values of the bound tty to always be 0, which causes the switch
from the desktop When to the tty environment, the LED light
status is inconsistent with the keyboard lock status.

Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
---
 v2-->v3:
 (1) Abandon the previous modification plan.
 (2) Added the kbd_update_ledstate function, this function gets the
 latest state of the led from the input device, and then synchronizes
 it to the ledstate. The kbd_event function calls it.
 (3) When the tty's kbdmode==VC_OFF, the tty does not set the keyboard light (modify the kbd_bh function).
 v3-->v4:
 Correct the subject
 v5:
 Some code adjustments
 
 Why didn't you follow Dmitry's advice:
 According to Dmitry's suggestion, modifying the code should not involve
 changes to the input core, and only needs to be done in keyboard.c. According
 to my previous patch logic, it is impossible not to involve changes to the
 input core. So it was changed to the current patch.
 
 test_bit(EV_LED, dev->evbit) is used to detect whether the input device
 supports EV_LED, I think it should exist. "If (ledstate == -1U)" is
 because the initialized value of ledstate is -1U, I think it should exist.
 V6:
 (1)I deleted "if (ledstate == -1U)", and after careful consideration, my
 thoughts are superfluous.
 (2)Format adjustment and a wrong parameter modification
 
 drivers/tty/vt/keyboard.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..9194ad92f062 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1130,6 +1130,20 @@ static void kbd_init_leds(void)
 
 #endif
 
+static void kbd_update_ledstate(struct input_dev *dev)
+{
+	unsigned long leds;
+
+	leds = (unsigned long)ledstate;
+
+	if (!!test_bit(LED_NUML, dev->led) != !!test_bit(VC_NUMLOCK, &leds))
+		ledstate ^= BIT(VC_NUMLOCK);
+	if (!!test_bit(LED_CAPSL, dev->led) != !!test_bit(VC_CAPSLOCK, &leds))
+		ledstate ^= BIT(VC_CAPSLOCK);
+	if (!!test_bit(LED_SCROLLL, dev->led) != !!test_bit(VC_SCROLLOCK, &leds))
+		ledstate ^= BIT(VC_SCROLLOCK);
+}
+
 /*
  * The leds display either (i) the status of NumLock, CapsLock, ScrollLock,
  * or (ii) whatever pattern of lights people want to show using KDSETLED,
@@ -1247,9 +1261,14 @@ void vt_kbd_con_stop(unsigned int console)
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
@@ -1524,6 +1543,9 @@ static void kbd_event(struct input_handle *handle, unsigned int event_type,
 	/* We are called with interrupts disabled, just take the lock */
 	spin_lock(&kbd_event_lock);
 
+	if (test_bit(EV_LED, handle->dev->evbit))
+		kbd_update_ledstate(handle->dev);
+
 	if (event_type == EV_MSC && event_code == MSC_RAW &&
 			kbd_is_hw_raw(handle->dev))
 		kbd_rawcode(value);
-- 
2.20.1



