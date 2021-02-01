Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CDB30A4BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhBAJyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhBAJyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:54:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0BEC0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 01:53:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m7so3917922ybm.19
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 01:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0uh+WToPVrT5nNi8VVC2Dny5IL46Dl8JAHJqCqtV+0E=;
        b=JZbMiUywIbtml14aZF5DenFmX8cTfKrnKqlNI3+SQRq+h0S5fF1pWJJNPhvWLEghUs
         HpeMrYrcFc9aiGhPxytd/CuWAkbV4Y1cUbQ34f7G/BkXprgGOZhNEXf61aFkyWwDqCiX
         gT1uNnD5uQjTsoKQ4pmx4uI5JiwYFkPyzGQmCH+B2Lca+qhjoXZFnp+cA8BcnFwpIfrl
         /gsjkXyHugeU0Q+vrgRu11mUCUuHeB1mBAQ35uMd9GPar+GG5YiVrkAts0k6vM8SmRdI
         BXdJTOdSkXXeF/e5dvNS6h9ci/0CPRMIqhVEQ82qKnFfcvHRRRgFfSh5j3LlAXfULsom
         uLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0uh+WToPVrT5nNi8VVC2Dny5IL46Dl8JAHJqCqtV+0E=;
        b=rYGQVGlXSS1yDJspeLrWWJmXccvQr142tBdkGgMcKRUv/cs73eelputEQmFoxmFsjd
         QSfngyQAgdZ7u1T8JFWDogOplAgwG5aDWlKHgX4G9uppUlZ5ivvjHSr5U6tzXKblRvpy
         J6W/R4yDMQQNpVUE4ryd7fr7iNNTOembmYWv/1zNoE3CgT6BM8mzENxyys6TOlkY72nI
         JKyK8YpAN0ROKIzBTB5PCK8RSjrDgIqlQGHSJckZxJPhp0j/yi09+3rWDxFhlj2MlF3k
         Kx/qgbYKyvjE/wTBkAtMsIvNefAXtDuolYfVjDRL+tYIg7I/bbi/1p/do9E/7FYbfnXc
         IJTw==
X-Gm-Message-State: AOAM530afDjHw8vaZ+kceTvw3pJhpxvJcAdEOfB2JyXfUsYX4C1uhoIn
        AyauXHldg+ypnrwbXnGZcYvFH+VQtvw=
X-Google-Smtp-Source: ABdhPJz7SZNhUVv6lljN4luIrVxqMNv7ABYTMW5J//phP91oa06GazQPxA7gbr4KsZZ405ctyYAxl9pFjs0=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:ac94:: with SMTP id x20mr12304706ybi.411.1612173198434;
 Mon, 01 Feb 2021 01:53:18 -0800 (PST)
Date:   Mon,  1 Feb 2021 01:53:09 -0800
In-Reply-To: <20210201095309.39486-1-badhri@google.com>
Message-Id: <20210201095309.39486-3-badhri@google.com>
Mime-Version: 1.0
References: <20210201095309.39486-1-badhri@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v1 3/3] usb: typec: tcpci_maxim: Enable data path when partner
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

