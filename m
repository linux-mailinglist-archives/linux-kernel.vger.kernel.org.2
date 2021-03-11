Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82CE336F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhCKKDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhCKKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:03:22 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108D9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 02:03:22 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id h20so15043942qkj.18
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 02:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l9CMWPdWDhliYrHN/g/05oM0suTsXVO5bL0BBWp8xVQ=;
        b=PWe712s1TPhf8Wes9gxc0mJgydqlFrhOqr/zVo/FIMQjUrI87BLhHdZJCQcG3U/3d4
         2IdEJ2Bxsl7OLDluzj/zIZKsKcELdEQnW0Byo7Y/BxotOJ6XqhZgVjyLdttUnkauH+c5
         irENCVF6E0IqCOjOsxkTCNlwhNkD35JWux8qiWNA2rRBKTaMDJhjFE6YzZI2t6Ehq2g9
         48uhRwcuFJ6KRwxm2yIcrbUOuf6acW1UTXDJTpBJVsUSNexNPUCapGRtrJPqkvsH5Z5s
         RomwmVw+wJeK0hN+zU2VBWqOQn2JUiAvlMyh+/8viUBo4Xlf95a1gAdUDxEfZz8WhfqI
         gXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l9CMWPdWDhliYrHN/g/05oM0suTsXVO5bL0BBWp8xVQ=;
        b=ZnwFfIj8ROEPEBY46e05GEWuPJB4/TxtWRvESA8P7AX1+TsS92x0Q54u7297H19+Vr
         DaGItuSIniK2f7KI+84KONCRnke6EiVUu485V33tBebtobpz6Ka1qvuRAm2Lb7qZcybL
         HPn64898gL9EFCO5snvaRgSZe1x5JZCC52NWk/CDIyvwFl0PuQztjiHur48DxkCkczK1
         mwJCy/FCPTt2uMf584oSreFS+H2Y8JWnqxZRpn1yW6mBryZ6uC6kOaSPx1a2pxH1WQjX
         JJZ1xD5txeW6VL5yGyFOJq0zYBZV2Xe1AZuK1R02u4iES2W+eFqwDjZkHfWvQBjsE6th
         ZL+A==
X-Gm-Message-State: AOAM531oN/I5+HzWxwjf4vYxmbmzQRyqGUR1wLCHDVUmKmzj6hP0HMG7
        vwA2V9v5GcIJwTy4V9r420UNuVAj5u8=
X-Google-Smtp-Source: ABdhPJxWJw52lTOHAorcVvKKdbDVGEprFZqCIR2v+1inSvJ2s/QvAEBJg6tupvELlAQ5ynL8cWwBGRO9OKs=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:39e6:8b30:8665:4bec])
 (user=badhri job=sendgmr) by 2002:a05:6214:12a1:: with SMTP id
 w1mr6851339qvu.57.1615457001221; Thu, 11 Mar 2021 02:03:21 -0800 (PST)
Date:   Thu, 11 Mar 2021 02:03:11 -0800
In-Reply-To: <20210311100313.3591254-1-badhri@google.com>
Message-Id: <20210311100313.3591254-2-badhri@google.com>
Mime-Version: 1.0
References: <20210311100313.3591254-1-badhri@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 2/4] usb: typec: tcpci: Add tcpc chip level callbacks
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>, devicetree@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds chip callbacks for the following operations:
1. Setting/getting vbus voltage and current limits.
2. Notifying presence of PD capable partner
3. Notifying port role
4. Notifying orientation

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 45 +++++++++++++++++++++++++++++++++-
 drivers/usb/typec/tcpm/tcpci.h |  7 ++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 027afd7dfdce..35f229d1dde8 100644
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
 
@@ -439,6 +449,36 @@ static bool tcpci_is_vbus_vsafe0v(struct tcpc_dev *tcpc)
 	return !!(reg & TCPC_EXTENDED_STATUS_VSAFE0V);
 }
 
+static void tcpci_set_pd_capable(struct tcpc_dev *tcpc, bool capable)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+
+	if (tcpci->data->set_pd_capable)
+		tcpci->data->set_pd_capable(tcpci, tcpci->data, capable);
+}
+
+static int tcpci_get_current_limit(struct tcpc_dev *tcpc)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+
+	if (tcpci->data->get_current_limit)
+		return tcpci->data->get_current_limit(tcpci, tcpci->data);
+
+	return 0;
+}
+
+static int tcpci_set_current_limit(struct tcpc_dev *tcpc, u32 max_ma, u32 mv)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+	int ret = 0;
+
+	if (tcpci->data->set_current_limit)
+		ret = tcpci->data->set_current_limit(tcpci, tcpci->data, max_ma,
+						     mv);
+
+	return ret;
+}
+
 static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool source, bool sink)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -744,6 +784,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.enable_frs = tcpci_enable_frs;
 	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
 	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
+	tcpci->tcpc.set_pd_capable = tcpci_set_pd_capable;
+	tcpci->tcpc.set_current_limit = tcpci_set_current_limit;
+	tcpci->tcpc.get_current_limit = tcpci_get_current_limit;
 
 	if (tcpci->data->auto_discharge_disconnect) {
 		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 57b6e24e0a0c..6fdad15ce1f2 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -181,6 +181,13 @@ struct tcpci_data {
 	void (*frs_sourcing_vbus)(struct tcpci *tcpci, struct tcpci_data *data);
 	void (*set_partner_usb_comm_capable)(struct tcpci *tcpci, struct tcpci_data *data,
 					     bool capable);
+	void (*set_pd_capable)(struct tcpci *tcpci, struct tcpci_data *data, bool capable);
+	int (*get_current_limit)(struct tcpci *tcpci, struct tcpci_data *data);
+	int (*set_current_limit)(struct tcpci *tcpci, struct tcpci_data *data, u32 max_ma, u32 mv);
+	void (*set_roles)(struct tcpci *tcpci, struct tcpci_data *data, bool attached,
+			  enum typec_role role, enum typec_data_role data_role);
+	void (*set_cc_polarity)(struct tcpci *tcpci, struct tcpci_data *data,
+				enum typec_cc_polarity polarity);
 };
 
 struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
-- 
2.31.0.rc2.261.g7f71774620-goog

