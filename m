Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35704447DF2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbhKHKbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:31:33 -0500
Received: from vps.xff.cz ([195.181.215.36]:41358 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237791AbhKHKb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1636367321; bh=HRSQ+/1rPbZP9SjFY8jo2peIysEbpfJpy6m4H91Z50Y=;
        h=From:To:Subject:Date:From;
        b=if3XFMIAs+VZxmHa71B3VJCRes0xFAqw9J8Fkyoi6Oj24rEtoO6K/J5cwEPp+AHsZ
         BExhWmf7aPRA6gbL52L/x/2Jbij6GDV+9MRfqWxwfYJBNaXtJ1LVjmPgCn4OZPR2dH
         YT/8EDgIarsZ/0tzIEjQxkn7eD2g96wmlkYOk9F4=
From:   Ondrej Jirman <megous@megous.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ondrej Jirman <megous@megous.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org (open list:USB TYPEC PORT CONTROLLER DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] usb: typec: fusb302: Fix masking of comparator and bc_lvl interrupts
Date:   Mon,  8 Nov 2021 11:28:32 +0100
Message-Id: <20211108102833.2793803-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code that enables either BC_LVL or COMP_CHNG interrupt in tcpm_set_cc
wrongly assumes that the interrupt is unmasked by writing 1 to the apropriate
bit in the mask register. In fact, interrupts are enabled when the mask
is 0, so the tcpm_set_cc enables interrupt for COMP_CHNG when it expects
BC_LVL interrupt to be enabled.

This causes inability of the driver to recognize cable unplug events
in host mode (unplug is recognized only via a COMP_CHNG interrupt).

In device mode this bug was masked by simultaneous triggering of the VBUS
change interrupt, because of loss of VBUS when the port peer is providing
power.

Fixes: 48242e30532b ("usb: typec: fusb302: Revert "Resolve fixed power role contract setup"")
Signed-off-by: Ondrej Jirman <megous@megous.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/typec/tcpm/fusb302.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 7a2a17866a823..72f9001b07921 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -669,25 +669,27 @@ static int tcpm_set_cc(struct tcpc_dev *dev, enum typec_cc_status cc)
 		ret = fusb302_i2c_mask_write(chip, FUSB_REG_MASK,
 					     FUSB_REG_MASK_BC_LVL |
 					     FUSB_REG_MASK_COMP_CHNG,
-					     FUSB_REG_MASK_COMP_CHNG);
+					     FUSB_REG_MASK_BC_LVL);
 		if (ret < 0) {
 			fusb302_log(chip, "cannot set SRC interrupt, ret=%d",
 				    ret);
 			goto done;
 		}
 		chip->intr_comp_chng = true;
+		chip->intr_bc_lvl = false;
 		break;
 	case TYPEC_CC_RD:
 		ret = fusb302_i2c_mask_write(chip, FUSB_REG_MASK,
 					     FUSB_REG_MASK_BC_LVL |
 					     FUSB_REG_MASK_COMP_CHNG,
-					     FUSB_REG_MASK_BC_LVL);
+					     FUSB_REG_MASK_COMP_CHNG);
 		if (ret < 0) {
 			fusb302_log(chip, "cannot set SRC interrupt, ret=%d",
 				    ret);
 			goto done;
 		}
 		chip->intr_bc_lvl = true;
+		chip->intr_comp_chng = false;
 		break;
 	default:
 		break;
-- 
2.33.1

