Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A030B430
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhBBAc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBBAc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:32:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C14C061786
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 16:31:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 203so21793721ybz.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 16:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0uh+WToPVrT5nNi8VVC2Dny5IL46Dl8JAHJqCqtV+0E=;
        b=SFTMdNMBaucckx4ugeVWqiTaqglAACSOnYW1A8/Ez40FvYEsGsO0865cf6SOLLRZMl
         cmExytKpiIUQTLdGyeq+PUR8+HohaxLo62ySgm8hUBnNJJ8mgLdsddWbKPXMRA+E67eG
         SaWVdQsXlr1DGAk5sISAxgbEgxZjQztEiPSMkFTiBzFTDoH2i9guief7sffShnkAG7u8
         TMoF4o4nYGOdaEdrTSTHI+h1rUtOxgpNU4MHtE1VjEcJTKOHLug3obBT6AYxiwSd4G7y
         gfT8tiVCijoHyEFRRycKzh7fSI9c+1FoSLpezB91zdOv5mTJXXTjZyfZ7t5IGvyV49I9
         5M9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0uh+WToPVrT5nNi8VVC2Dny5IL46Dl8JAHJqCqtV+0E=;
        b=qRJ9fU6YKhE2olqx7vAtx21nT35v3rxECoeCqx8n+JSWWRGFmPvM/CYmqJKnn4dQ0L
         +SGWBl40zgQijavghncC2bvVnqlFyxl/KogBUzZ6ZJUhuuh1xnCsyPg0AuDTrcMe6dMH
         AKWXOcjHZe1HWRBst4xSPd49P31viqijE/ECBA/tLEvq5jJNTQUEnZJlNDIFGoGgJyYT
         LgVSUeuIu97UOBV6LuruaOWAX2d3RUqH4BoW8JcAEjiqHz0G8usKpDWQppMGFc8QUE/O
         Y3mIOZD2+bQ7Kqv6+NHwXrZBU88zAeqTuVR3k67Dtdv6RtNMg3ZZGchmuxgII0glEXkS
         Y1Sg==
X-Gm-Message-State: AOAM532sziBX6in/ROWAonpAitCu2btmca74B3IUx6BaD8RbUYqCV8l7
        HO05CBOANpw7zCqmJLIV8x+p2n8BJuo=
X-Google-Smtp-Source: ABdhPJxS4YMkF5b8SGdcc3Ax0TQLzMLXyrGtOPZ0WQnmvJc3+bh0U5qT1yd0Va0gS871RnMu44QVgUNzi+Q=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:d56c:119f:44fb:5da4])
 (user=badhri job=sendgmr) by 2002:a25:cd01:: with SMTP id d1mr11984442ybf.125.1612225870209;
 Mon, 01 Feb 2021 16:31:10 -0800 (PST)
Date:   Mon,  1 Feb 2021 16:31:01 -0800
In-Reply-To: <20210202003101.221145-1-badhri@google.com>
Message-Id: <20210202003101.221145-3-badhri@google.com>
Mime-Version: 1.0
References: <20210202003101.221145-1-badhri@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 3/3] usb: typec: tcpci_maxim: Enable data path when partner
 is USB Comm capable
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure USB switches when partner is USB Communication capable.
The is enabled USB data communication over D+/D- pins.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index f1674a611033..041a1c393594 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -19,6 +19,9 @@
 #define PD_ACTIVITY_TIMEOUT_MS				10000
 
 #define TCPC_VENDOR_ALERT				0x80
+#define TCPC_VENDOR_USBSW_CTRL				0x93
+#define TCPC_VENDOR_USBSW_CTRL_ENABLE_USB_DATA		0x9
+#define TCPC_VENDOR_USBSW_CTRL_DISABLE_USB_DATA		0
 
 #define TCPC_RECEIVE_BUFFER_COUNT_OFFSET		0
 #define TCPC_RECEIVE_BUFFER_FRAME_TYPE_OFFSET		1
@@ -274,6 +277,21 @@ static void process_tx(struct max_tcpci_chip *chip, u16 status)
 		max_tcpci_init_regs(chip);
 }
 
+/* Enable USB switches when partner is USB communications capable */
+static void max_tcpci_set_partner_usb_comm_capable(struct tcpci *tcpci, struct tcpci_data *data,
+						   bool capable)
+{
+	struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
+	int ret;
+
+	ret = max_tcpci_write8(chip, TCPC_VENDOR_USBSW_CTRL, capable ?
+			       TCPC_VENDOR_USBSW_CTRL_ENABLE_USB_DATA :
+			       TCPC_VENDOR_USBSW_CTRL_DISABLE_USB_DATA);
+
+	if (ret < 0)
+		dev_err(chip->dev, "Failed to enable USB switches");
+}
+
 static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
 {
 	u16 mask;
@@ -453,6 +471,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 	chip->data.frs_sourcing_vbus = max_tcpci_frs_sourcing_vbus;
 	chip->data.auto_discharge_disconnect = true;
 	chip->data.vbus_vsafe0v = true;
+	chip->data.set_partner_usb_comm_capable = max_tcpci_set_partner_usb_comm_capable;
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
-- 
2.30.0.365.g02bc693789-goog

