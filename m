Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD013103A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhBEDfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhBEDfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:35:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4C2C06178C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 19:34:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e62so5503179yba.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 19:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TY/cIJ2lz/cuhJtZ2QRLRNyD9hhczDvNRqFenFoSo88=;
        b=uQHJkkyPdM1kTXNA0yrXHWUnD8qztnfv5csKg0rFQPJ0m0aE4DkUeASlpRoekBahd7
         g2FdmKaOoczBojr7PTQey4YZsa26ewx14mffCyz5RKiApkhTeG1SflqM0SQkgEfML/yp
         mP54dMwNPN0IigdywDOqvztKCp+duc7lxO+aC5y5v8ZwCwwsmxvjCgicGKUfxyD7ezM3
         ZXSuAwK+dUKCBuZw6t39IcErgqoKfNWSc68EIWOCt9qmSLk604weMZ/Rsb3wlxkO0Qqc
         eah9S3EZ77GFI4+Vzfz034RSJtBV7p0JjNe8r3FRSyB78FCziDRsJ0dw3j02pGUIF6af
         4sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TY/cIJ2lz/cuhJtZ2QRLRNyD9hhczDvNRqFenFoSo88=;
        b=jkmqzEfkdhlx5MG7iMy2Qq5bmAvwXjugxevM8d9wyeMvIKRaW+GFW0bTl/vyeuP9hw
         HEjQ7d4uPf+ANq6cHh2o/7ygnFyCeD0TnkVP09DsPzCErG5exzIirCaQP0sUvab/lEQ/
         ATLziYYJzrfpKJxQll3EtiSvg1xBSmGPLC+Hk7qjmESoHEO4VhdI0tWnoJFkTICnHxSD
         LAg1jv9ZSC9KnvueLmlkV2nbSd3jNAgK/QRKuv/xLXNerQndsXTMxQZGaWd2bzy+evp+
         1X6ZVM+2yoLfD9XO7FzQbsNEbQGJnuivwfzT4R7m/1HZd5BxlZ0PVPa1vSIKavv47eA1
         uF9A==
X-Gm-Message-State: AOAM530D8vCafRx+ODyFNWW9gQnb3JG98yIRXNEqsHvD8xng8KEslFQ3
        QyhBRLCUpkU6HPLkaGXBqO0fmJ32bQHZ
X-Google-Smtp-Source: ABdhPJyDS0xP+3dt7PYoCZnfjYfb/LsNJHR0nfzEHobo452TiQToDQtJtfSADrumcV7aEQVR4EjbuVuzb9Hh
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:dd94:c753:a81d:c855])
 (user=kyletso job=sendgmr) by 2002:a25:c244:: with SMTP id
 s65mr3581959ybf.128.1612496066228; Thu, 04 Feb 2021 19:34:26 -0800 (PST)
Date:   Fri,  5 Feb 2021 11:34:09 +0800
In-Reply-To: <20210205033415.3320439-1-kyletso@google.com>
Message-Id: <20210205033415.3320439-2-kyletso@google.com>
Mime-Version: 1.0
References: <20210205033415.3320439-1-kyletso@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCHi v6 1/7] usb: typec: Manage SVDM version
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PD Spec Revision 3.0 Version 2.0 + ECNs 2020-12-10
  6.4.4.2.3 Structured VDM Version
  "The Structured VDM Version field of the Discover Identity Command
  sent and received during VDM discovery Shall be used to determine the
  lowest common Structured VDM Version supported by the Port Partners or
  Cable Plug and Shall continue to operate using this Specification
  Revision until they are Detached."

Add a variable in typec_capability to specify the highest SVDM version
supported by the port and another variable in typec_partner to cache the
negotiated SVDM version between the port and the partner.

Also add setter/getter functions for the negotiated SVDM version.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changes since v5
- !! most changes are from Heikki
- location of the negotiated SVDM version is changed. Now the variable
  resides in typec_partner
- The setter and getter functions were modified according to the above
  changes
- the default SVDM version is stored upon calling to
  typec_register_partner

 drivers/usb/typec/class.c         | 43 +++++++++++++++++++++++++++++++
 include/linux/usb/typec.h         | 12 +++++++++
 include/linux/usb/typec_altmode.h | 10 +++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index b4a5d9d4564f..45f0bf65e9ab 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -38,6 +38,7 @@ struct typec_partner {
 	struct ida			mode_ids;
 	int				num_altmodes;
 	u16				pd_revision; /* 0300H = "3.0" */
+	enum usb_pd_svdm_ver		svdm_version;
 };
 
 struct typec_port {
@@ -824,6 +825,20 @@ typec_partner_register_altmode(struct typec_partner *partner,
 }
 EXPORT_SYMBOL_GPL(typec_partner_register_altmode);
 
+/**
+ * typec_partner_set_svdm_version - Set negotiated Structured VDM (SVDM) Version
+ * @partner: USB Type-C Partner that supports SVDM
+ * @svdm_version: Negotiated SVDM Version
+ *
+ * This routine is used to save the negotiated SVDM Version.
+ */
+void typec_partner_set_svdm_version(struct typec_partner *partner,
+				   enum usb_pd_svdm_ver svdm_version)
+{
+	partner->svdm_version = svdm_version;
+}
+EXPORT_SYMBOL_GPL(typec_partner_set_svdm_version);
+
 /**
  * typec_register_partner - Register a USB Type-C Partner
  * @port: The USB Type-C Port the partner is connected to
@@ -848,6 +863,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 	partner->accessory = desc->accessory;
 	partner->num_altmodes = -1;
 	partner->pd_revision = desc->pd_revision;
+	partner->svdm_version = port->cap->svdm_version;
 
 	if (desc->identity) {
 		/*
@@ -1894,6 +1910,33 @@ EXPORT_SYMBOL_GPL(typec_set_mode);
 
 /* --------------------------------------- */
 
+/**
+ * typec_get_negotiated_svdm_version - Get negotiated SVDM Version
+ * @port: USB Type-C Port.
+ *
+ * Get the negotiated SVDM Version. The Version is set to the port default
+ * value stored in typec_capability on partner registration, and updated after
+ * a successful Discover Identity if the negotiated value is less than the
+ * default value.
+ *
+ * Returns usb_pd_svdm_ver if the partner has been registered otherwise -ENODEV.
+ */
+int typec_get_negotiated_svdm_version(struct typec_port *port)
+{
+	enum usb_pd_svdm_ver svdm_version;
+	struct device *partner_dev;
+
+	partner_dev = device_find_child(&port->dev, NULL, partner_match);
+	if (!partner_dev)
+		return -ENODEV;
+
+	svdm_version = to_typec_partner(partner_dev)->svdm_version;
+	put_device(partner_dev);
+
+	return svdm_version;
+}
+EXPORT_SYMBOL_GPL(typec_get_negotiated_svdm_version);
+
 /**
  * typec_get_drvdata - Return private driver data pointer
  * @port: USB Type-C port
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index a94df82ab62f..91b4303ca305 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -217,12 +217,19 @@ struct typec_operations {
 			     enum typec_port_type type);
 };
 
+enum usb_pd_svdm_ver {
+	SVDM_VER_1_0 = 0,
+	SVDM_VER_2_0 = 1,
+	SVDM_VER_MAX = SVDM_VER_2_0,
+};
+
 /*
  * struct typec_capability - USB Type-C Port Capabilities
  * @type: Supported power role of the port
  * @data: Supported data role of the port
  * @revision: USB Type-C Specification release. Binary coded decimal
  * @pd_revision: USB Power Delivery Specification revision if supported
+ * @svdm_version: USB PD Structured VDM version if supported
  * @prefer_role: Initial role preference (DRP ports).
  * @accessory: Supported Accessory Modes
  * @fwnode: Optional fwnode of the port
@@ -236,6 +243,7 @@ struct typec_capability {
 	enum typec_port_data	data;
 	u16			revision; /* 0120H = "1.2" */
 	u16			pd_revision; /* 0300H = "3.0" */
+	enum usb_pd_svdm_ver	svdm_version;
 	int			prefer_role;
 	enum typec_accessory	accessory[TYPEC_MAX_ACCESSORY];
 	unsigned int		orientation_aware:1;
@@ -286,4 +294,8 @@ int typec_find_orientation(const char *name);
 int typec_find_port_power_role(const char *name);
 int typec_find_power_role(const char *name);
 int typec_find_port_data_role(const char *name);
+
+void typec_partner_set_svdm_version(struct typec_partner *partner,
+				    enum usb_pd_svdm_ver svdm_version);
+int typec_get_negotiated_svdm_version(struct typec_port *port);
 #endif /* __LINUX_USB_TYPEC_H */
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index 5e0a7b7647c3..65933cbe9129 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -132,6 +132,16 @@ typec_altmode_get_orientation(struct typec_altmode *altmode)
 	return typec_get_orientation(typec_altmode2port(altmode));
 }
 
+/**
+ * typec_altmode_get_svdm_version - Get negotiated SVDM version
+ * @altmode: Handle to the alternate mode
+ */
+static inline int
+typec_altmode_get_svdm_version(struct typec_altmode *altmode)
+{
+	return typec_get_negotiated_svdm_version(typec_altmode2port(altmode));
+}
+
 /**
  * struct typec_altmode_driver - USB Type-C alternate mode device driver
  * @id_table: Null terminated array of SVIDs
-- 
2.30.0.365.g02bc693789-goog

