Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6574143B466
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhJZOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:40:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:61815 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234327AbhJZOkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:40:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="293387442"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="293387442"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 07:23:57 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="596948590"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 07:23:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfNMV-0018jX-SD;
        Tue, 26 Oct 2021 17:23:35 +0300
Date:   Tue, 26 Oct 2021 17:23:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, 282827961@qq.com
Subject: Re: [PATCH v7] tty: Fix the keyboard led light display problem
Message-ID: <YXgPZw3eluaaVvRc@smile.fi.intel.com>
References: <20211026024032.15897-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026024032.15897-1-changlianzhi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:40:32AM +0800, lianzhi chang wrote:
> Switching from the desktop environment to the tty environment,
> the state of the keyboard led lights and the state of the keyboard
> lock are inconsistent. This is because the attribute kb->kbdmode
> of the tty bound in the desktop environment (xorg) is set to

Xorg

I think I already pointed that out.

> VC_OFF, which causes the ledstate and kb->ledflagstate
> values of the bound tty to always be 0, which causes the switch
> from the desktop When to the tty environment, the LED light
> status is inconsistent with the keyboard lock status.

...

> +static void kbd_update_ledstate(struct input_dev *dev)
> +{
> +	if (!!test_bit(LED_NUML, dev->led) !=
> +	    !!(ledstate & BIT(VC_NUMLOCK)))
> +		ledstate ^= BIT(VC_NUMLOCK);
> +	if (!!test_bit(LED_CAPSL, dev->led) !=
> +	    !!(ledstate & BIT(VC_CAPSLOCK)))
> +		ledstate ^= BIT(VC_CAPSLOCK);
> +	if (!!test_bit(LED_SCROLLL, dev->led) !=
> +	    !!(ledstate & BIT(VC_SCROLLOCK)))
> +		ledstate ^= BIT(VC_SCROLLOCK);

This looks ugly.

Since LED_* are part of uAPI and VC_* are not, perhaps
makes sense to modify kbd_kern.h and optimize above
(disclaimer: compile tested only, no locking or other
 synchronization have been checked / reviewed / etc):

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..2b04eaa5c6fd 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -49,6 +49,11 @@
 
 #include <asm/irq_regs.h>
 
+/* We rely on these in kbd_update_ledstate() */
+static_assert(VC_NUMLOCK == LED_NUML);
+static_assert(VC_CAPSLOCK == LED_CAPSL);
+static_assert(VC_SCROLLOCK == LED_SCROLLL);
+
 /*
  * Exported functions/variables
  */
@@ -1130,6 +1135,15 @@ static void kbd_init_leds(void)
 
 #endif
 
+static void kbd_update_ledstate(struct input_dev *dev)
+{
+	unsigned long leds = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
+	unsigned long newstate = *dev->led;
+
+	newstate ^= ledstate;
+	ledstate ^= newstate & leds;
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
diff --git a/include/linux/kbd_kern.h b/include/linux/kbd_kern.h
index c40811d79769..4c131dd21fc9 100644
--- a/include/linux/kbd_kern.h
+++ b/include/linux/kbd_kern.h
@@ -38,9 +38,9 @@ struct kbd_struct {
 
 	unsigned char ledflagstate:4;	/* flags, not lights */
 	unsigned char default_ledflagstate:4;
-#define VC_SCROLLOCK	0	/* scroll-lock mode */
-#define VC_NUMLOCK	1	/* numeric lock mode */
-#define VC_CAPSLOCK	2	/* capslock mode */
+#define VC_NUMLOCK	0	/* numeric lock mode */
+#define VC_CAPSLOCK	1	/* capslock mode */
+#define VC_SCROLLOCK	2	/* scroll-lock mode */
 #define VC_KANALOCK	3	/* kanalock mode */
 
 	unsigned char kbdmode:3;	/* one 3-bit value */

> +}

-- 
With Best Regards,
Andy Shevchenko


