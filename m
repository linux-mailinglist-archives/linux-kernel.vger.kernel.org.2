Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3173230858C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhA2GPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhA2GO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:14:59 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 22:14:19 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o16so5972869pgg.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 22:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VG+CFdFGOlLcoNTjFCZePZjqocxq9mnm/N79AG4wxhM=;
        b=cv9Ge/7s9evbDApQ5Vz73qw5LA3h/ChF4WumCkvr0xileVrKKfEaNtOXA765fvAQWT
         g4tn/VDTZoG9oJFMdTs6zv4s3Nz/OKgQLasg7u8Qd+n9fQ5sgQrSm1+KsYq0FksVGUWu
         t7kkT7nkrdouy2nHNViC1hgm7xrW36TGsIpIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VG+CFdFGOlLcoNTjFCZePZjqocxq9mnm/N79AG4wxhM=;
        b=orA0wceAkcfuDTjUc4KSvrNgYjhSXdt5AjsfEQSsuj9Sv+hl7S+rIx1y4O/Ab8jBDX
         SSft+fJE7atPlifLhgZgqOLbIkOwaUTALHQBdGKeQXlem/kFIJZ8bAnwmdKhUAfSPV83
         YBCZRGHnI+QEuvT+e1vkaDhtTTK84rsRlZDCc7IPMo8NuVKx2qyey7aLm0PK304KfwZN
         LaBnYvWAHzJJbSPtMyElYcKZ7w+y8jUVBzszOD0fFJOJUtxan60YkOFg4eXCLC3dBjbf
         sMr1NvSAijmjZIUsj/ynAkNFZdq+Bi8KkroaNkkOI0CDFn/UHFjnrAgbvXc4+0gxO5dK
         mk0w==
X-Gm-Message-State: AOAM531+iWjwbcLSEFBwSPNsvRYzPKp91y1gKxSnZJNMyNUBtv/xbn/q
        kCPIKCwsALh2Z7idKQcSGvC+6Q==
X-Google-Smtp-Source: ABdhPJykMK4csnuyWBmuvaUcg8Wgc3DUSA1bXJaLLOKmVXiSoxFYwgcEBVc2awHnwzSYfw7ZQFLsFQ==
X-Received: by 2002:a63:c207:: with SMTP id b7mr3201495pgd.184.1611900859252;
        Thu, 28 Jan 2021 22:14:19 -0800 (PST)
Received: from bleung.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id 17sm7551013pfv.13.2021.01.28.22.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 22:14:18 -0800 (PST)
From:   Benson Leung <bleung@chromium.org>
To:     heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        pmalani@chromium.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@google.com, bleung@chromium.org
Subject: [PATCH 2/6] usb: typec: Provide PD Specification Revision for cable and partner
Date:   Thu, 28 Jan 2021 22:14:02 -0800
Message-Id: <20210129061406.2680146-3-bleung@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129061406.2680146-1-bleung@chromium.org>
References: <20210129061406.2680146-1-bleung@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB Power Delivery specification Section 6.2.1.1.5 outlines
revision backward compatibility requirements starting from Revision 3.0.

The Port, the Cable Plug, and the Port Partner may support either
revision 2 or revision 3 independently, and communication between ports,
partners, and cables of different revisions are allowed under rules
that the parties agree to communicate between each other using the
lowest common operating revision.

This may mean that Port-to-Partner operating revision comms may be
different than Port-to-CablePlug operating revision comms. For example,
it is possible for a R3.0 port to communicate with a R3.0 partner
using R3.0 messages, while the R3.0 port (in the same session) must
communicate with the R2.0 cable using R2.0 messages only.

Introduce individual revision number properties for cable
and port partner so that the port can track them independently.

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-typec | 13 +++++++++
 drivers/usb/typec/class.c                   | 30 ++++++++++++++++++---
 include/linux/usb/typec.h                   | 10 +++++++
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index b61480535fdc..40122d915ae1 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -112,6 +112,19 @@ Description:
 		- "3.0": USB Power Delivery Release 3.0
 		- "3.1": USB Power Delivery Release 3.1
 
+What:		/sys/class/typec/<port>-{partner|cable}/usb_power_delivery_revision
+Date:		January 2021
+Contact:	Benson Leung <bleung@chromium.org>
+Description:
+		Revision number of the supported USB Power Delivery
+		specification of the port partner or cable, or 0.0 when USB
+		Power Delivery is not supported.
+
+		Example values:
+		- "2.0": USB Power Delivery Release 2.0
+		- "3.0": USB Power Delivery Release 3.0
+		- "3.1": USB Power Delivery Release 3.1
+
 What:		/sys/class/typec/<port>/usb_typec_revision
 Date:		April 2017
 Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 4f60ee7ba76a..b5241f4756c2 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -27,6 +27,7 @@ struct typec_cable {
 	enum typec_plug_type		type;
 	struct usb_pd_identity		*identity;
 	unsigned int			active:1;
+	u16				pd_revision; /* 0300H = "3.0" */
 };
 
 struct typec_partner {
@@ -36,6 +37,7 @@ struct typec_partner {
 	enum typec_accessory		accessory;
 	struct ida			mode_ids;
 	int				num_altmodes;
+	u16				pd_revision; /* 0300H = "3.0" */
 };
 
 struct typec_port {
@@ -264,6 +266,11 @@ type_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(type);
 
+static ssize_t usb_power_delivery_revision_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf);
+static DEVICE_ATTR_RO(usb_power_delivery_revision);
+
 /* ------------------------------------------------------------------------- */
 /* Alternate Modes */
 
@@ -680,6 +687,7 @@ static struct attribute *typec_partner_attrs[] = {
 	&dev_attr_supports_usb_power_delivery.attr,
 	&dev_attr_number_of_alternate_modes.attr,
 	&dev_attr_type.attr,
+	&dev_attr_usb_power_delivery_revision.attr,
 	NULL
 };
 
@@ -815,6 +823,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 	partner->usb_pd = desc->usb_pd;
 	partner->accessory = desc->accessory;
 	partner->num_altmodes = -1;
+	partner->pd_revision = desc->pd_revision;
 
 	if (desc->identity) {
 		/*
@@ -1028,6 +1037,7 @@ static DEVICE_ATTR_RO(plug_type);
 static struct attribute *typec_cable_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_plug_type.attr,
+	&dev_attr_usb_power_delivery_revision.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(typec_cable);
@@ -1130,6 +1140,7 @@ struct typec_cable *typec_register_cable(struct typec_port *port,
 
 	cable->type = desc->type;
 	cable->active = desc->active;
+	cable->pd_revision = desc->pd_revision;
 
 	if (desc->identity) {
 		/*
@@ -1499,12 +1510,23 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
 {
-	struct typec_port *p = to_typec_port(dev);
-	u16 rev = p->cap->pd_revision;
+	u16 rev = 0;
 
-	return sprintf(buf, "%d.%d\n", (rev >> 8) & 0xff, (rev >> 4) & 0xf);
+	if (is_typec_partner(dev)) {
+		struct typec_partner *partner = to_typec_partner(dev);
+
+		rev = partner->pd_revision;
+	} else if (is_typec_cable(dev)) {
+		struct typec_cable *cable = to_typec_cable(dev);
+
+		rev = cable->pd_revision;
+	} else if (is_typec_port(dev)) {
+		struct typec_port *p = to_typec_port(dev);
+
+		rev = p->cap->pd_revision;
+	}
+	return sysfs_emit(buf, "%d.%d\n", (rev >> 8) & 0xff, (rev >> 4) & 0xf);
 }
-static DEVICE_ATTR_RO(usb_power_delivery_revision);
 
 static ssize_t orientation_show(struct device *dev,
 				   struct device_attribute *attr,
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 54475323f83b..42c6b7c07a99 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -164,6 +164,7 @@ struct typec_plug_desc {
  * @type: The plug type from USB PD Cable VDO
  * @active: Is the cable active or passive
  * @identity: Result of Discover Identity command
+ * @pd_revision: USB Power Delivery Specification revision if supported
  *
  * Represents USB Type-C Cable attached to USB Type-C port.
  */
@@ -171,6 +172,8 @@ struct typec_cable_desc {
 	enum typec_plug_type	type;
 	unsigned int		active:1;
 	struct usb_pd_identity	*identity;
+	u16			pd_revision; /* 0300H = "3.0" */
+
 };
 
 /*
@@ -178,15 +181,22 @@ struct typec_cable_desc {
  * @usb_pd: USB Power Delivery support
  * @accessory: Audio, Debug or none.
  * @identity: Discover Identity command data
+ * @pd_revision: USB Power Delivery Specification Revision if supported
  *
  * Details about a partner that is attached to USB Type-C port. If @identity
  * member exists when partner is registered, a directory named "identity" is
  * created to sysfs for the partner device.
+ *
+ * @pd_revision is based on the setting of the "Specification Revision" field
+ * in the message header on the initial "Source Capabilities" message received
+ * from the partner, or a "Request" message received from the partner, depending
+ * on whether our port is a Sink or a Source.
  */
 struct typec_partner_desc {
 	unsigned int		usb_pd:1;
 	enum typec_accessory	accessory;
 	struct usb_pd_identity	*identity;
+	u16			pd_revision; /* 0300H = "3.0" */
 };
 
 /**
-- 
2.30.0.365.g02bc693789-goog

