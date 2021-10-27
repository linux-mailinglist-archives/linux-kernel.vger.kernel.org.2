Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C95F43C243
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 07:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbhJ0Fij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 01:38:39 -0400
Received: from smtpbguseast1.qq.com ([54.204.34.129]:37446 "EHLO
        smtpbguseast1.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbhJ0Fih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 01:38:37 -0400
X-QQ-mid: bizesmtp31t1635312962tpi6g3yj
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 27 Oct 2021 13:35:55 +0800 (CST)
X-QQ-SSF: B1400000002000B0E000B00A0000000
X-QQ-FEAT: jfdGVjI73+TOEqv0/SGQGR6m5M8lKp3adRFuEh8s2kvlNNBgHpMbW7q5Ffhn0
        sDnBfggnTpvL/jbC4kBn12o835riLDH3yCZ0Bg91pBQtdsjk9HAQygNzqUp978tHIAbFrrT
        MyBks9vdjUifXp22k/z0wshfmHG2Xl9DsK+qLIRjQ6Oel1SXQo9KRDczLXfm3aQPa7XBab+
        A6txI2KT/zb5zDypfePvWq5Lb8s69t+JYQf0Pm61ox+cR2f6cj8f1xwq+CZe3BpjlbMKdzM
        yc1eOO69oNV+Nlr5PyavpVckoLgypW4G4ptT7qjRJM33ESh7eCIxdlSOH1O72ra8idVrtj4
        2dpYlJSZ2+rzbImBegp+T6yjEb3sGY9nNJY3vOyoiqSNaFbK0o=
X-QQ-GoodBg: 2
From:   lianzhi chang <changlianzhi@uniontech.com>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com, lianzhi chang <changlianzhi@uniontech.com>
Subject: [PATCH v9] tty: Fix the keyboard led light display problem
Date:   Wed, 27 Oct 2021 13:35:50 +0800
Message-Id: <20211027053550.28966-1-changlianzhi@uniontech.com>
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

Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
---
 v7-->v8:
 Optimize the implementation of kbd_update_ledstate function
 
 Why not adopt the opinions of Greg KH and Andy Shevchenko:
 (1) In the structure struct input_dev, the definition of led is
 like this: unsigned long led[BITS_TO_LONGS(LED_CNT)]; If you
 define it like this: unsigned long newstate = *dev->led; I
 always feel that there is still big end and Little endian problem.
 (2) The test_bit function is used to avoid the problem of large
 and small ends, and the current algorithm (v8) also exists
 elsewhere in the kernel: the atkbd_set_leds function (drivers/
 input/keyboard/atkbd.c).
 (3) In the current keyboard.c code, the code is already very good,
 and it is already relatively independent. If you modify the type
 of ledstate to u64 or modify the macro definitions such as
 VC_NUMLOCK, it feels that it is not very meaningful, and this It
 will also cause other related modifications. Of course, this is
 only my current opinion. If everyone still feels that it is
 necessary to modify, I will do it this way. Of course, this
 process may be a bit longer, and I think it is necessary to
 conduct more tests.
 
 v9: Change description information: xorg-->Xorg
 
 drivers/tty/vt/keyboard.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..f564fcf61304 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1130,6 +1130,13 @@ static void kbd_init_leds(void)
 
 #endif
 
+static void kbd_update_ledstate(struct input_dev *dev)
+{
+	ledstate = (test_bit(LED_SCROLLL, dev->led) ? BIT(VC_SCROLLOCK) : 0)
+		 | (test_bit(LED_NUML,    dev->led) ? BIT(VC_NUMLOCK) : 0)
+		 | (test_bit(LED_CAPSL,   dev->led) ? BIT(VC_CAPSLOCK) : 0);
+}
+
 /*
  * The leds display either (i) the status of NumLock, CapsLock, ScrollLock,
  * or (ii) whatever pattern of lights people want to show using KDSETLED,
@@ -1247,9 +1254,14 @@ void vt_kbd_con_stop(unsigned int console)
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
@@ -1524,6 +1536,9 @@ static void kbd_event(struct input_handle *handle, unsigned int event_type,
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



