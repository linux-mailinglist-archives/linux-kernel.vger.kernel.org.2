Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CF2424CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 07:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbhJGFOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 01:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhJGFOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 01:14:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AB1F60F6F;
        Thu,  7 Oct 2021 05:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633583559;
        bh=Rw3rWqbqsbMslWYJBU0ib0rem4WuJFy2fSBNtgcPAg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HuHtnnblr1nqu+5IWhmBsVzMEr0dGMxuNvsgesaA36M3QNJVbZi6dWu/qJriKqfPI
         RsCwphDVZjeLoG29nqpMFmO+xkT6RyJ0qqCiG8Rn8Ns1JDw0MlJ5z5TRa5WH9I6ctW
         T/4I4Ibv9QfVH2SNYhb7mSP6RuAq2kC+JNj+lRqkTp4z8OcLDrPi6S2R2/OBdp3ohX
         LEHq7juNwLEiwDfKxgtIIu3CyvpCTckshcMpbv2+mZkOsI2ujO5A6W6Ot3EjWv4ENJ
         amxMMM99e8R/QBlP4MN6QBi7xD0Zocm1AuWv4MG0os4+GsjhZkSNZOeybVdrSxvlPT
         YvfMSA53I+pig==
Date:   Thu, 7 Oct 2021 13:12:29 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH 0/6] Chipidea USB driver Enhancements and Bug Fixes
Message-ID: <20211007051229.GG4653@Peter>
References: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-24 22:46:12, Manish Narani wrote:
> This patch series has some Enhancements and Bug Fixes to chipidea USB
> driver related to Zynq platform.
> 
> Manish Narani (3):
>   usb: chipidea: Add support for VBUS control with PHY
>   usb: chipidea: Use usb2 phy for Zynq platform
>   usb: chipidea: Check usb_phy exists before using it
> 
> Piyush Mehta (3):
>   usb: chipidea: Fix return value handling
>   usb: chipidea: core: Add return value function check
>   usb: chipidea: udc: Add xilinx revision support
> 
>  drivers/usb/chipidea/ci_hdrc_usb2.c |  5 +++++
>  drivers/usb/chipidea/core.c         | 26 +++++++++++++++++++-------
>  drivers/usb/chipidea/host.c         |  9 +++++++++
>  drivers/usb/chipidea/otg.c          |  6 +++++-
>  drivers/usb/chipidea/otg_fsm.c      |  9 +++++++++
>  drivers/usb/chipidea/udc.c          |  3 ++-
>  include/linux/usb/chipidea.h        |  1 +
>  7 files changed, 50 insertions(+), 9 deletions(-)
> 

I am afraid I can't find [4/6] at my INBOX, comments below:

From: Piyush Mehta <piyush.mehta@xilinx.com>

API was neither captured nor checked.Fixed it by capturing the
return value and then checking for any error.

Addresses-Coverity: "Calling without checking return"
Addresses-Coverity: "CHECKED_RETURN"
Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/usb/chipidea/core.c | 11 +++++++----
 drivers/usb/chipidea/otg.c  |  6 +++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 2b18f50..676346f 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -700,13 +700,16 @@ static int ci_get_platdata(struct device *dev,
 	if (usb_get_maximum_speed(dev) == USB_SPEED_FULL)
 		platdata->flags |= CI_HDRC_FORCE_FULLSPEED;

-	of_property_read_u32(dev->of_node, "phy-clkgate-delay-us",
-				     &platdata->phy_clkgate_delay_us);
+	if (of_property_read_u32(dev->of_node, "phy-clkgate-delay-us",
+				 &platdata->phy_clkgate_delay_us))
+		dev_dbg(dev, "Missing phy-clkgate-delay-us property\n");

 	platdata->itc_setting = 1;

-	of_property_read_u32(dev->of_node, "itc-setting",
-					&platdata->itc_setting);
+	if (of_property_read_u32(dev->of_node, "itc-setting",
+				 &platdata->itc_setting))
+		dev_dbg(dev, "Missing itc-setting property\n");
+

You may check how to handle this for other properties in this function.


 	ret = of_property_read_u32(dev->of_node, "ahb-burst-config",
 				&platdata->ahb_burst_config);
diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index 8dd5928..d527d9d 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -168,6 +168,7 @@ static int hw_wait_vbus_lower_bsv(struct ci_hdrc *ci)
 static void ci_handle_id_switch(struct ci_hdrc *ci)
 {
 	enum ci_role role = ci_otg_role(ci);
+	int ret;

 	if (role != ci->role) {
 		dev_dbg(ci->dev, "switching from %s to %s\n",
@@ -193,7 +194,10 @@ static void ci_handle_id_switch(struct ci_hdrc *ci)
 			 */
 			hw_wait_vbus_lower_bsv(ci);

-		ci_role_start(ci, role);
+		ret = ci_role_start(ci, role);
+		if (ret < 0)
+			dev_dbg(ci->dev, "switching err %d\n", ret);
+

You may use dev_err for it.

 		/* vbus change may have already occurred */
 		if (role == CI_ROLE_GADGET)
 			ci_handle_vbus_change(ci);

-- 

Thanks,
Peter Chen

