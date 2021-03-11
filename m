Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203E1336F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhCKKDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbhCKKDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:03:24 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FF8C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 02:03:23 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id a1so14977461qkn.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 02:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hcg8ctscEa0t8SSV4gNeUgkygeqJTngQzkOo9fh7MZE=;
        b=pY/arfFlAeunr2gBLh/qaucb9n4p2jHJsMQdzw2R0zgMiyRNgPIwWwpkUiUoegcP+P
         CpjC5aws7kQ6Br4CxtAGk8WrVQLzvTR4VOQdO9DrPZZ98A1Qd5hXZmEwmUM4b0XJIc/r
         ZeyVwVAH0W4hI3oowy8Rbr8SIoecXf+kenzXVRBpGloiUhf6mj2ESUI9PsWhSqaiAyjb
         PooBa28gYPzLgTGnN9eDzMrQaBmCUKYtNVe3UOC6oNFRu6eBd8WItgfFeqVdBAuXEMPN
         26O2UrXUUVritRYagYxDjMjpKzRQAo2zLNBwA7Y2xwKe7NEHVaxri6uMV5okxs9LT3Gh
         RduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hcg8ctscEa0t8SSV4gNeUgkygeqJTngQzkOo9fh7MZE=;
        b=ZXgsGZ3XU5egcm6WMbNv5EoqKyYQeA1GKQlFZeBjf5GuRTV9dJ8+wvXh5aEyMIYWz4
         XMJtjaAYnKq5zpPWjiDQmZf6T+girvqupmPWwInVHeTw/dM7uZKydVEfPzpe5TG+mN0i
         B4J5m1ljbWZeKqZwjKIXLoTs0wzV7R08Q0D22q5cwcxScY34sIjbjVwlHSU5cpX1nXAh
         e9CsJbw1i1I2+TX5hpyienhhAipnhS6HP84XED8SfiDyg0NwuDTmaLuyHC+ODp/9cskh
         keN/uYdH1PY7155klRGPkgJ6OJ+2AiP/uuSsnYdD4yecmEra8gIAW7U7v26mrOyW7uHl
         zNvw==
X-Gm-Message-State: AOAM5303AL8/0QMbKNbPoPeR+VzC9kRE2HKxzFQjZrv4gn6tc5CKS785
        bhS2x7o91ZPuZtqGEGqB0EyJg1yyWt4=
X-Google-Smtp-Source: ABdhPJwJfpnB5Bcd8nZ5NGE+1+XjO3DvogRTxHoA3Kak2RVpj+77JMe/TjEqDy0XIv3k30GGMUVXeMgRX9E=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:39e6:8b30:8665:4bec])
 (user=badhri job=sendgmr) by 2002:a05:6214:1085:: with SMTP id
 o5mr6988474qvr.5.1615457003120; Thu, 11 Mar 2021 02:03:23 -0800 (PST)
Date:   Thu, 11 Mar 2021 02:03:12 -0800
In-Reply-To: <20210311100313.3591254-1-badhri@google.com>
Message-Id: <20210311100313.3591254-3-badhri@google.com>
Mime-Version: 1.0
References: <20210311100313.3591254-1-badhri@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 3/4] usb: typec: tcpci_maxim: configure charging & data paths
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

This change allows the driver to configure input current/voltage
limit for the charging path. The driver sets current_max and voltage_max
values of the power supply identified through chg-psy-name.

The change also exposes the data_role and the orientation as a extcon
interface for configuring the USB data controller.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 126 ++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 041a1c393594..365ff4c18146 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -7,8 +7,11 @@
 
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
+#include <linux/extcon.h>
+#include <linux/extcon-provider.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/power_supply.h>
 #include <linux/regmap.h>
 #include <linux/usb/pd.h>
 #include <linux/usb/tcpm.h>
@@ -46,6 +49,10 @@ struct max_tcpci_chip {
 	struct device *dev;
 	struct i2c_client *client;
 	struct tcpm_port *port;
+	bool pd_capable;
+	bool attached;
+	struct power_supply *chg_psy;
+	struct extcon_dev *extcon;
 };
 
 static const struct regmap_range max_tcpci_tcpci_range[] = {
@@ -439,11 +446,92 @@ static int tcpci_init(struct tcpci *tcpci, struct tcpci_data *data)
 	return -1;
 }
 
+static int max_tcpci_get_current_limit(struct tcpci *tcpci, struct tcpci_data *data)
+{
+	struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
+	union power_supply_propval val = {0};
+	int ret;
+
+	if (!chip->chg_psy)
+		return 0;
+
+	ret = power_supply_get_property(chip->chg_psy, POWER_SUPPLY_PROP_CURRENT_MAX, &val);
+	return ret < 0 ? ret : val.intval;
+}
+
+static int max_tcpci_set_current_limit(struct tcpci *tcpci, struct tcpci_data *data, u32 max_ma,
+				       u32 mv)
+{
+	struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
+	union power_supply_propval val;
+	int ret;
+
+	if (!chip->chg_psy)
+		return 0;
+
+	val.intval = mv;
+	ret = power_supply_set_property(chip->chg_psy, POWER_SUPPLY_PROP_VOLTAGE_MAX, &val);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Disregard 0mA vote for Rp-default value. Rp-default current values
+	 * would be inferred from other sources such BC1.2 and data stack.
+	 */
+	if (!chip->pd_capable && max_ma == 0 && chip->attached)
+		return 0;
+
+	val.intval = max_ma;
+	return power_supply_set_property(chip->chg_psy, POWER_SUPPLY_PROP_CURRENT_MAX, &val);
+}
+
+static void max_tcpci_set_pd_capable(struct tcpci *tcpci, struct tcpci_data *data, bool capable)
+{
+	struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
+
+	chip->pd_capable = capable;
+}
+
+static void max_tcpci_set_roles(struct tcpci *tcpci, struct tcpci_data *data, bool attached,
+				enum typec_role role, enum typec_data_role data_role)
+{
+	struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
+
+	chip->attached = attached;
+
+	if (!attached) {
+		extcon_set_state_sync(chip->extcon, EXTCON_USB_HOST, 0);
+		extcon_set_state_sync(chip->extcon, EXTCON_USB, 0);
+		return;
+	}
+
+	extcon_set_state_sync(chip->extcon, data_role == TYPEC_HOST ? EXTCON_USB_HOST : EXTCON_USB,
+			      1);
+}
+
+static void max_tcpci_set_cc_polarity(struct tcpci *tcpci, struct tcpci_data *data,
+				      enum typec_cc_polarity polarity)
+{
+	struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
+
+	extcon_set_property(chip->extcon, EXTCON_USB, EXTCON_PROP_USB_TYPEC_POLARITY,
+			    (union extcon_property_value)(int)polarity);
+	extcon_set_property(chip->extcon, EXTCON_USB_HOST, EXTCON_PROP_USB_TYPEC_POLARITY,
+			    (union extcon_property_value)(int)polarity);
+}
+
+static const unsigned int usbpd_extcon[] = {
+	EXTCON_USB,
+	EXTCON_USB_HOST,
+};
+
 static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id *i2c_id)
 {
 	int ret;
 	struct max_tcpci_chip *chip;
 	u8 power_status;
+	char *chg_psy_name;
+	struct device_node *dn;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -472,6 +560,11 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 	chip->data.auto_discharge_disconnect = true;
 	chip->data.vbus_vsafe0v = true;
 	chip->data.set_partner_usb_comm_capable = max_tcpci_set_partner_usb_comm_capable;
+	chip->data.get_current_limit = max_tcpci_get_current_limit;
+	chip->data.set_current_limit = max_tcpci_set_current_limit;
+	chip->data.set_pd_capable = max_tcpci_set_pd_capable;
+	chip->data.set_roles = max_tcpci_set_roles;
+	chip->data.set_cc_polarity = max_tcpci_set_cc_polarity;
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
@@ -484,9 +577,38 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 	if (ret < 0)
 		goto unreg_port;
 
+	dn = dev_of_node(&client->dev);
+	if (!dn) {
+		dev_err(&client->dev, "of node not found\n");
+		ret = -EINVAL;
+		goto unreg_port;
+	}
+	chg_psy_name = (char *)of_get_property(dn, "chg-psy-name", NULL);
+	if (chg_psy_name)
+		chip->chg_psy = power_supply_get_by_name(chg_psy_name);
+
+	chip->extcon = devm_extcon_dev_allocate(&client->dev, usbpd_extcon);
+	if (IS_ERR(chip->extcon)) {
+		dev_err(&client->dev, "Error allocating extcon: %ld\n", PTR_ERR(chip->extcon));
+		ret = PTR_ERR(chip->extcon);
+		goto psy_put;
+	}
+
+	ret = devm_extcon_dev_register(&client->dev, chip->extcon);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to register extcon device");
+		goto psy_put;
+	}
+
+	extcon_set_property_capability(chip->extcon, EXTCON_USB, EXTCON_PROP_USB_TYPEC_POLARITY);
+	extcon_set_property_capability(chip->extcon, EXTCON_USB_HOST,
+				       EXTCON_PROP_USB_TYPEC_POLARITY);
+
 	device_init_wakeup(chip->dev, true);
 	return 0;
-
+psy_put:
+	if (chip->chg_psy)
+		power_supply_put(chip->chg_psy);
 unreg_port:
 	tcpci_unregister_port(chip->tcpci);
 
@@ -499,6 +621,8 @@ static int max_tcpci_remove(struct i2c_client *client)
 
 	if (!IS_ERR_OR_NULL(chip->tcpci))
 		tcpci_unregister_port(chip->tcpci);
+	if (chip->chg_psy)
+		power_supply_put(chip->chg_psy);
 
 	return 0;
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

