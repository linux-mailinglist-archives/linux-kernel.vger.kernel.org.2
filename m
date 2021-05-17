Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD62383D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhEQTWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbhEQTWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:22:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE43BC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:21:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e138-20020a25e7900000b029050df4b648fcso4501982ybh.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=79DMjSxiP2F1AeRPgnsBg/R7gF79NxIe5NFXbthP6VI=;
        b=MFAW2KY9zPq61R1HXjxZWc7oA7t20+c367OWkGm31d5kdUS65UbfPlI6yNMVqyuMnO
         JZ/Vq2/nO8r1udNp4pIQN4xkD0zaqijcJtZggsgvVawgrwK73nPXhcQonCueCyT7rqG+
         zJSnYj9QSKyYqzJsFP+hMArHnsBmMLBh506d8o3j9OBwIXpjGjN6ZnmI/tSfdMkzB+/G
         ikBY/kmZ6Yxiyt60OygzXJrhamDOrdsIttQ3bSUIIB1/Ny/2+2wbSjIPrlwMJB/y4WvF
         0JKJvYJpISCzuWkd4eVYF8QeEZ5ECCwOqFulXspVklIFV7/dAFP4rxgx8QA7l0y+xG09
         7uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=79DMjSxiP2F1AeRPgnsBg/R7gF79NxIe5NFXbthP6VI=;
        b=pvFQ8exvr8TzBfODGDkLkQOryQ2TBXxgLtrtzQEvUR6nFSQHOEE0LN9f74WyT/QkUP
         L/HTNwFPmRWaWKtfGFOBPHv6+Ntg0u5cGyAz6gbFV8e14f/SWXL9GrYyztx4y7rCOAFY
         0ebo40JroDSSecqAJUmB1PaWOn1V6P5RgFvfkKdIqIegHPD7ft6L613A/woZoHDqeWyQ
         bp4vGsb9sLCfRkXncbNZL6er9McZ053rYpWx+Q5FYv+gVNcpMaOUHl+avlllgjrob1c5
         TL3ajFMWGN4vvlMqBbvCQRgUBkkS7gGIivnE4Vm563G/+WiSa321vB2vQmGODyceFYKr
         XkbQ==
X-Gm-Message-State: AOAM533jkQ51YwXfdmOm7NXbPhRzOjxJiKyuHW4/AMV4TcrPMboUei9y
        xMqDEBpkOSWTJZTfWnxIX5P6gW6g/PU=
X-Google-Smtp-Source: ABdhPJweE4HBhuxz8PmhtWA0Hdo6sKmybMPGmOK564AHaorko3PoYnyRUB1tLJ3hTruPY1fVS9NogOY6Lv4=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:b562:7011:fe35:1c9e])
 (user=badhri job=sendgmr) by 2002:a25:d8d6:: with SMTP id p205mr1919757ybg.485.1621279283104;
 Mon, 17 May 2021 12:21:23 -0700 (PDT)
Date:   Mon, 17 May 2021 12:21:12 -0700
In-Reply-To: <20210517192112.40934-1-badhri@google.com>
Message-Id: <20210517192112.40934-4-badhri@google.com>
Mime-Version: 1.0
References: <20210517192112.40934-1-badhri@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 4/4] usb: typec: tcpci: Implement callback for apply_rc
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>, stable@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APPLY RC is defined as ROLE_CONTROL.CC1 != ROLE_CONTROL.CC2 and
POWER_CONTROL.AutodischargeDisconnect is 0. When ROLE_CONTROL.CC1 ==
ROLE_CONTROL.CC2, set the other CC to OPEN.

Fixes: f321a02caebd ("usb: typec: tcpm: Implement enabling Auto Discharge disconnect support")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since V1:
- Added Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/tcpm/tcpci.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 25b480752266..34b5095cc84f 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -115,6 +115,32 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
 	return 0;
 }
 
+int tcpci_apply_rc(struct tcpc_dev *tcpc, enum typec_cc_status cc, enum typec_cc_polarity polarity)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(tcpci->regmap, TCPC_ROLE_CTRL, &reg);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * APPLY_RC state is when ROLE_CONTROL.CC1 != ROLE_CONTROL.CC2 and vbus autodischarge on
+	 * disconnect is disabled. Bail out when ROLE_CONTROL.CC1 != ROLE_CONTROL.CC2.
+	 */
+	if (((reg & (TCPC_ROLE_CTRL_CC2_MASK << TCPC_ROLE_CTRL_CC2_SHIFT)) >>
+	     TCPC_ROLE_CTRL_CC2_SHIFT) !=
+	    ((reg & (TCPC_ROLE_CTRL_CC1_MASK << TCPC_ROLE_CTRL_CC1_SHIFT)) >>
+	     TCPC_ROLE_CTRL_CC1_SHIFT))
+		return 0;
+
+	return regmap_update_bits(tcpci->regmap, TCPC_ROLE_CTRL, polarity == TYPEC_POLARITY_CC1 ?
+				  TCPC_ROLE_CTRL_CC2_MASK << TCPC_ROLE_CTRL_CC2_SHIFT :
+				  TCPC_ROLE_CTRL_CC1_MASK << TCPC_ROLE_CTRL_CC1_SHIFT,
+				  TCPC_ROLE_CTRL_CC_OPEN);
+}
+
 static int tcpci_start_toggling(struct tcpc_dev *tcpc,
 				enum typec_port_type port_type,
 				enum typec_cc_status cc)
@@ -728,6 +754,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.get_vbus = tcpci_get_vbus;
 	tcpci->tcpc.set_vbus = tcpci_set_vbus;
 	tcpci->tcpc.set_cc = tcpci_set_cc;
+	tcpci->tcpc.apply_rc = tcpci_apply_rc;
 	tcpci->tcpc.get_cc = tcpci_get_cc;
 	tcpci->tcpc.set_polarity = tcpci_set_polarity;
 	tcpci->tcpc.set_vconn = tcpci_set_vconn;
-- 
2.31.1.751.gd2f1c929bd-goog

