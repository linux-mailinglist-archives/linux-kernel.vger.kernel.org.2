Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5560447514
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 20:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhKGTEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 14:04:48 -0500
Received: from vps.xff.cz ([195.181.215.36]:41346 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhKGTEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 14:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1636311279; bh=Fb2lbIy0DxeOVrDEvMYpc879rA2zbBbnXd2+sxXDYNU=;
        h=From:To:Subject:Date:From;
        b=CgXQVNPlVcX3bB6kx3o3bjM5mqqymkTx1KFOMLQBlafOju0G6jv4uZBlNbJ/v/2zw
         i4epAT3uTOeSaDF7oWmi/8Ky3qSAEy65DN4pTMNIxkR56g8PVP+87WEXxPa4OKBj40
         20n0lQ8VBnmFocwnQV10NewjusgY3TTtMzoVUOoA=
From:   Ondrej Jirman <megous@megous.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ondrej Jirman <megous@megous.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org (open list:USB TYPEC PORT CONTROLLER DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/15] usb: typec: fusb302: Fix masking of comparator and bc_lvl interrupts
Date:   Sun,  7 Nov 2021 19:54:33 +0100
Message-Id: <20211107185435.2540185-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The masks are swapped (interrupts are enabled when the mask is 0).

This caused inability of the driver to recognize cable unplug events
in host mode (where only comparator interrupt is generated, and VBUS
interrupt is not).

Signed-off-by: Ondrej Jirman <megous@megous.com>
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

