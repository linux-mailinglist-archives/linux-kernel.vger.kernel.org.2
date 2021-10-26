Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213F943AA65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 04:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhJZCnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 22:43:42 -0400
Received: from smtpbguseast3.qq.com ([54.243.244.52]:60815 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhJZCnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 22:43:35 -0400
X-QQ-mid: bizesmtp48t1635216062tovaigxx
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 26 Oct 2021 10:40:50 +0800 (CST)
X-QQ-SSF: B1400000002000B0E000B00A0000000
X-QQ-FEAT: Zj+KTj18N39ISsjL3T66XEgEMKYIrQ2ZjjUW3GxEpkiz582AFrWGBipd0La81
        8ZPuTcPIYVaAIXQcqOS9+A9/WXlSc9HqFR5+wAzuVLvVnYE3roSo79/0ioxwLtAejBA5Z4T
        KmXm3uz4A2cUCQgvHqlEvTLQZPBWOyx5x5C++W4ijoq2xuvzA3ZDdpQ2gtKShbv4Jbs9VKI
        xDAtqFVMOnel1HlS92xmY6irQE14vv1IwFQ9qJZ8MLLJOqULtfgoWMrF/ujhc96JD2QKY7x
        tnn1DYJUu5ukggPfXphU0IN5bSEcfVmUPmET4pAgO9TObGGUn2g+6RGPNbzfguetxKYUVMy
        SSHzz+YsYA9C8f0/tdWXC/rZYcgNA==
X-QQ-GoodBg: 2
From:   lianzhi chang <changlianzhi@uniontech.com>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com, lianzhi chang <changlianzhi@uniontech.com>
Subject: [PATCH v7] tty: Fix the keyboard led light display problem
Date:   Tue, 26 Oct 2021 10:40:32 +0800
Message-Id: <20211026024032.15897-1-changlianzhi@uniontech.com>
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
of the tty bound in the desktop environment (xorg) is set to
VC_OFF, which causes the ledstate and kb->ledflagstate
values of the bound tty to always be 0, which causes the switch
from the desktop When to the tty environment, the LED light
status is inconsistent with the keyboard lock status.

Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
---
 v6-->v7:
 Delete the casting in the kbd_update_ledstate function, and the
 new code no longer needs casting.
 
 drivers/tty/vt/keyboard.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..e2cf40d06483 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1130,6 +1130,19 @@ static void kbd_init_leds(void)
 
 #endif
 
+static void kbd_update_ledstate(struct input_dev *dev)
+{
+	if (!!test_bit(LED_NUML, dev->led) !=
+	    !!(ledstate & BIT(VC_NUMLOCK)))
+		ledstate ^= BIT(VC_NUMLOCK);
+	if (!!test_bit(LED_CAPSL, dev->led) !=
+	    !!(ledstate & BIT(VC_CAPSLOCK)))
+		ledstate ^= BIT(VC_CAPSLOCK);
+	if (!!test_bit(LED_SCROLLL, dev->led) !=
+	    !!(ledstate & BIT(VC_SCROLLOCK)))
+		ledstate ^= BIT(VC_SCROLLOCK);
+}
+
 /*
  * The leds display either (i) the status of NumLock, CapsLock, ScrollLock,
  * or (ii) whatever pattern of lights people want to show using KDSETLED,
@@ -1247,9 +1260,14 @@ void vt_kbd_con_stop(unsigned int console)
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
@@ -1524,6 +1542,9 @@ static void kbd_event(struct input_handle *handle, unsigned int event_type,
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



