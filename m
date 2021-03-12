Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9BF338528
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 06:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhCLFYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 00:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhCLFYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 00:24:48 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9785CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 21:24:48 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id m35so7495020qtd.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 21:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9hWh3mPPnMd+7sgA4bB4jM0VJmsYOSTpWV6kivY/w7E=;
        b=Hg5mX1cINvIihpuUY2ieD0jNJTtxVNv/hp0fSVy5nAJFPqF3Em4k41fBrc+F9CRuDo
         Bt2CM5Hl2yy5XGQLb3AocKOExxdHgblnCKasIOxbrXxWcEOQFtqEzaEgzGmX/kd0AJaG
         BgPWpr8oZzPdbpo+imT8XBf+uiQbDu8ZHTNXl+/uyZ3GwPBpwRPCRMhVdfg98x7OEY3d
         kFyS5RWDGi23lmnFgIoF9vSvvoqraqJdhCZl+m1XHEtO8duTeH5xkSrRg0vD4twKWvNR
         1uAnzbuVBVfCNsRSs/zo/e43SrxJ2o41yPoBUF20h4albWrM0oqM0r71yAV81MEmiGO6
         8MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9hWh3mPPnMd+7sgA4bB4jM0VJmsYOSTpWV6kivY/w7E=;
        b=nZIK6mZyImNEg3MJfaQxdf+ZNkFF3hHjBrW+fygj0tJi7OrsEYmhK7a7v/T1zs+H1t
         f8pOPKGIaDuwuNp0hxce4RhvjdrvMu5U/2aGIC9ujxC8kPwKPZX3gixZlm2nnBYxKRcH
         8yv/bXDZ3hadDtQHRI0knCNAUEFHa/Z/t3sKcxh1PTi0fdPgrQUozB60NeCsYUJlXY2E
         rJJxJZ1ZhdJpgwCDGXdpF8XFazTHB9ngJPc9tnG9SNj3CD7TDtISjLabCzHbXzahYrn/
         pNTbVSCf7O0+Gw8rHUoocy+/tUroDYjzviCSK/s2TSHfhBWBl5ILTHQuUB1L+AtWRjlT
         27UA==
X-Gm-Message-State: AOAM5302yO8yBDc3wHdk3oU+zRYScCXb78nehzC+MHRqDN+AgQxq9PDS
        wD9LobEi8ffdVGwCxglhU+OG7spN4d8=
X-Google-Smtp-Source: ABdhPJx1KL5uJPgcPfK8l/iWCtj8fel/ejPIwTJbt3G4JxwxOrZYyB1k7MQ0rPxvKf3N1sPLFwByhAqpX0I=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:39e6:8b30:8665:4bec])
 (user=badhri job=sendgmr) by 2002:a05:6214:20ed:: with SMTP id
 13mr10835104qvk.34.1615526687598; Thu, 11 Mar 2021 21:24:47 -0800 (PST)
Date:   Thu, 11 Mar 2021 21:24:42 -0800
Message-Id: <20210312052443.3797674-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 1/2] usb: typec: tcpci: Add tcpc chip level callbacks
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds chip callbacks for the following operations:
1. Notifying port role
2. Notifying orientation

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since V1:
- Dropped changes related to get_/set_current_limit and pd_capable
  callback. Will send them in as separate patches.
---
 drivers/usb/typec/tcpm/tcpci.c | 12 +++++++++++-
 drivers/usb/typec/tcpm/tcpci.h | 10 ++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 027afd7dfdce..c37bbb2e9961 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -265,9 +265,16 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,
 	if (ret < 0)
 		return ret;
 
-	return regmap_write(tcpci->regmap, TCPC_TCPC_CTRL,
+	ret = regmap_write(tcpci->regmap, TCPC_TCPC_CTRL,
 			   (polarity == TYPEC_POLARITY_CC2) ?
 			   TCPC_TCPC_CTRL_ORIENTATION : 0);
+	if (ret < 0)
+		return ret;
+
+	if (tcpci->data->set_cc_polarity)
+		tcpci->data->set_cc_polarity(tcpci, tcpci->data, polarity);
+
+	return ret;
 }
 
 static void tcpci_set_partner_usb_comm_capable(struct tcpc_dev *tcpc, bool capable)
@@ -395,6 +402,9 @@ static int tcpci_set_roles(struct tcpc_dev *tcpc, bool attached,
 	if (ret < 0)
 		return ret;
 
+	if (tcpci->data->set_roles)
+		tcpci->data->set_roles(tcpci, tcpci->data, attached, role, data);
+
 	return 0;
 }
 
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 57b6e24e0a0c..75a2c9b575b5 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -165,6 +165,12 @@ struct tcpci;
  *		Optional; The USB Communications Capable bit indicates if port
  *		partner is capable of communication over the USB data lines
  *		(e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
+ * @set_roles:
+ *		Optional; This callback notifies the TCPC driver of the resolved
+ *		port role and attached status.
+ * @set_cc_polarity:
+ *		Optional; This callback notifies the TCPC driver of the resolved
+ *		polarity.
  */
 struct tcpci_data {
 	struct regmap *regmap;
@@ -181,6 +187,10 @@ struct tcpci_data {
 	void (*frs_sourcing_vbus)(struct tcpci *tcpci, struct tcpci_data *data);
 	void (*set_partner_usb_comm_capable)(struct tcpci *tcpci, struct tcpci_data *data,
 					     bool capable);
+	void (*set_roles)(struct tcpci *tcpci, struct tcpci_data *data, bool attached,
+			  enum typec_role role, enum typec_data_role data_role);
+	void (*set_cc_polarity)(struct tcpci *tcpci, struct tcpci_data *data,
+				enum typec_cc_polarity polarity);
 };
 
 struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
-- 
2.31.0.rc2.261.g7f71774620-goog

