Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685824467C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhKERZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhKERZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:25:56 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF160C061714;
        Fri,  5 Nov 2021 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=ctF+ypAFgSoH0Id9vII8CUGN6vLFTyuz4AWE/C/4nUw=; b=XQ
        jAixBCYw5JdFAs0OhECoIoekyoj6b3MSl3jZPA0dsASrJwp9mC/zEg7ihQA80pGzOqpXIFMk+1LLU
        D2MLD+/PMJGc+EEM0hxjrpljG5OPJ9qNyRD3+XTT82Sp9AW14wFOHYNhMHQ6mEr5e1dOSHA3fJnke
        JHMedJGT+ROccEOtZQtWqwuCJQ9zz37xU/Q99vdZf8WFR4FIw/1SmnNKMezyAoOIbku+1n3m24yGg
        RuUW/vo+w7B2swnIozTX4lcrnVABq0AwVHhmc2J9BeWmgm+7+tySHASofn/R1TbiQqDWTv0jjakHW
        zSwX1Fn7hf6gHOhnEPnU0fkndQLHrrpA==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mj2vo-0006fe-Dc; Fri, 05 Nov 2021 17:23:12 +0000
From:   John Keeping <john@metanate.com>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     John Keeping <john@metanate.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc2: gadget: respect driver's max_speed
Date:   Fri,  5 Nov 2021 17:23:04 +0000
Message-Id: <20211105172304.1308458-1-john@metanate.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UDCs should not enumerate faster than the max_speed set by the gadget
driver.  Use this to further restrict the speed set in the DWC2
parameters so that the device will not connect faster than is supported
by the gadget driver.

For configfs-based composite devices this can be set via the max_speed
configfs file.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/dwc2/gadget.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 744539b78f6c..1f39c2f1be8e 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3377,6 +3377,7 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 	u32 val;
 	u32 usbcfg;
 	u32 dcfg = 0;
+	u8 speed;
 	int ep;
 
 	/* Kill any ep0 requests as controller will be reinitialized */
@@ -3418,7 +3419,22 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 
 	dcfg |= DCFG_EPMISCNT(1);
 
-	switch (hsotg->params.speed) {
+	speed = hsotg->params.speed;
+	if (hsotg->driver) {
+		switch (hsotg->driver->max_speed) {
+		case USB_SPEED_LOW:
+			speed = DWC2_SPEED_PARAM_LOW;
+			break;
+		case USB_SPEED_FULL:
+			if (speed != USB_SPEED_LOW)
+				speed = DWC2_SPEED_PARAM_FULL;
+			break;
+		default:
+			break;
+		}
+	}
+
+	switch (speed) {
 	case DWC2_SPEED_PARAM_LOW:
 		dcfg |= DCFG_DEVSPD_LS;
 		break;
-- 
2.33.1

