Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C3930B42B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBBAbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhBBAbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:31:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A71C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 16:31:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q191so4052414ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 16:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sPq47L+9BIHkF/0ZeuUBPSrtxyRugGo3S/yCj7eF4vI=;
        b=UypH13Q2VyB2rYB0/02VP0iA/N6ovqoPXcdrMWGpkOJtHHPXrG3wVAetubYWgkIuM8
         1txWwWgRgMBuVgwS9PWbL5JBy6y9gYDL1+yMJ9qQKESWseuiiiQa/uoOxcvs09tmyW/O
         U987PNj4kr2iQFxAmZClhqys6LVPTRl6UxOr9vo0UHC9NWduC2zdX5gNDFCeZhwLvq4w
         4iJ295wEEFWpHaqW22+nyjhvudMTu9E/JMIcPVeWINFs7qdONSwnIGVlbOoPJhwnSnvo
         8YQdgWW/EbMn2/lgLPmhcP0pYgCc2ykKzqUTJkDZsjHoq1Jv0Fo/kP+QJNkl33PspHfP
         IkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sPq47L+9BIHkF/0ZeuUBPSrtxyRugGo3S/yCj7eF4vI=;
        b=arM5HglkqpIqm8KlLTqrh21sZm8KFxMoXbSAvw8UxdSaAVc1HQCebsiF3UAJm+8fBb
         4I9jQo0WvXhI6VcJ90uViUVZw1VnzkryC6CWxvnu5h02J2fJNfqH4gfSfpAGIZpUe+8S
         Aega9kmcUyJjlpitNEMuYf0sxn1qQe5iG6Lo7bVuSGG1LurF1KyHsGd6fD5H/sR3N5e8
         Dlh2fBkgSvDIvOXPNJMjJw/NdQYWxSP6PJwIQpsP7o02YGtjEgCSv/8JVig3QydEr/U1
         yPcyV1oXFM1zQybIDEw/xR90Zut1DnLOLQuT5XiiCAOOwx5NNJ+brQthmV3WgLb86VoS
         LCkg==
X-Gm-Message-State: AOAM533tXZYiNE4MwdFnsid5kJtmBto7Lz33eMLTwlDugsoKQdvXAgyP
        JLe7PX+3wZDmUaLUENHtddFJArj/PL8=
X-Google-Smtp-Source: ABdhPJz5bT+4VkOmzylQfs/chnDSdWvTMSgFT+G88ZX3256ESxb7jNf34H7GjkMpjNIb3CsoT0ZHwc/uJD8=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:d56c:119f:44fb:5da4])
 (user=badhri job=sendgmr) by 2002:a25:1086:: with SMTP id 128mr28250556ybq.375.1612225868244;
 Mon, 01 Feb 2021 16:31:08 -0800 (PST)
Date:   Mon,  1 Feb 2021 16:31:00 -0800
In-Reply-To: <20210202003101.221145-1-badhri@google.com>
Message-Id: <20210202003101.221145-2-badhri@google.com>
Mime-Version: 1.0
References: <20210202003101.221145-1-badhri@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 2/3] usb: typec: tcpci: Add Callback to Usb Communication
 capable partner
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

The USB Communications Capable bit indicates if port
partner is capable of communication over the USB data lines
(e.g. D+/- or SS Tx/Rx). TCPM passes this information for chip specific
operations.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 9 +++++++++
 drivers/usb/typec/tcpm/tcpci.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index f676abab044b..a27deb0b5f03 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -255,6 +255,14 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,
 			   TCPC_TCPC_CTRL_ORIENTATION : 0);
 }
 
+static void tcpci_set_partner_usb_comm_capable(struct tcpc_dev *tcpc, bool capable)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+
+	if (tcpci->data->set_partner_usb_comm_capable)
+		tcpci->data->set_partner_usb_comm_capable(tcpci, tcpci->data, capable);
+}
+
 static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -720,6 +728,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.set_bist_data = tcpci_set_bist_data;
 	tcpci->tcpc.enable_frs = tcpci_enable_frs;
 	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
+	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
 
 	if (tcpci->data->auto_discharge_disconnect) {
 		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index c3c7d07d9b4e..57b6e24e0a0c 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -161,6 +161,10 @@ struct tcpci;
  *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
  * @vbus_vsafe0v:
  *		optional; Set when TCPC can detect whether vbus is at VSAFE0V.
+ * @set_partner_usb_comm_capable:
+ *		Optional; The USB Communications Capable bit indicates if port
+ *		partner is capable of communication over the USB data lines
+ *		(e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
  */
 struct tcpci_data {
 	struct regmap *regmap;
@@ -175,6 +179,8 @@ struct tcpci_data {
 				  enum typec_cc_status cc);
 	int (*set_vbus)(struct tcpci *tcpci, struct tcpci_data *data, bool source, bool sink);
 	void (*frs_sourcing_vbus)(struct tcpci *tcpci, struct tcpci_data *data);
+	void (*set_partner_usb_comm_capable)(struct tcpci *tcpci, struct tcpci_data *data,
+					     bool capable);
 };
 
 struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
-- 
2.30.0.365.g02bc693789-goog

