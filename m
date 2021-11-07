Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAEE447510
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 20:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbhKGTEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 14:04:42 -0500
Received: from vps.xff.cz ([195.181.215.36]:41348 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhKGTEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 14:04:41 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Nov 2021 14:04:40 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1636311289; bh=HiZb3ZiAzuRqywkmIfYHOeUqTjKUx9wlhuWTEHTWTjI=;
        h=From:To:Subject:Date:From;
        b=EcJr8djcTWe7I2LWyYv6QKk/nsSQfshK7mEYMUTsu4F3psgxKqjYWtSbNowcnAEH/
         FQSpm4BKdUAripXsksqkLoiV1qF7MUUNGTshlfCEjaoCkgDBAsxC6CUKf+R/s84Qbk
         ApjUHB1G8tJHxbBBikJWgM2ajL0NYK+sE0uPZ+FI=
From:   Ondrej Jirman <megous@megous.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ondrej Jirman <megous@megous.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org (open list:USB TYPEC PORT CONTROLLER DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 07/15] usb: typec: fusb302: Set the current before enabling pullups
Date:   Sun,  7 Nov 2021 19:54:47 +0100
Message-Id: <20211107185447.2540248-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems more reasonable and should avoid short period of incorrect
current setting being applied to CC pin.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/usb/typec/tcpm/fusb302.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 72f9001b07921..776a949ef6e39 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -635,6 +635,14 @@ static int tcpm_set_cc(struct tcpc_dev *dev, enum typec_cc_status cc)
 		goto done;
 	}
 
+	/* adjust current for SRC */
+	ret = fusb302_set_src_current(chip, cc_src_current[cc]);
+	if (ret < 0) {
+		fusb302_log(chip, "cannot set src current %s, ret=%d",
+			    typec_cc_status_name[cc], ret);
+		goto done;
+	}
+
 	ret = fusb302_i2c_mask_write(chip, FUSB_REG_SWITCHES0,
 				     switches0_mask, switches0_data);
 	if (ret < 0) {
@@ -645,14 +653,6 @@ static int tcpm_set_cc(struct tcpc_dev *dev, enum typec_cc_status cc)
 	chip->cc1 = TYPEC_CC_OPEN;
 	chip->cc2 = TYPEC_CC_OPEN;
 
-	/* adjust current for SRC */
-	ret = fusb302_set_src_current(chip, cc_src_current[cc]);
-	if (ret < 0) {
-		fusb302_log(chip, "cannot set src current %s, ret=%d",
-			    typec_cc_status_name[cc], ret);
-		goto done;
-	}
-
 	/* enable/disable interrupts, BC_LVL for SNK and COMP_CHNG for SRC */
 	switch (cc) {
 	case TYPEC_CC_RP_DEF:
-- 
2.33.1

