Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4216230C55E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhBBQUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbhBBQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:18:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A21C061794
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:17:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c12so24186186ybf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S4Mhk39bbXlkNrotr3DgqM+vlFOU2lM4Arg9L7yykNE=;
        b=MdjNFlBpnRQD1U/YV6ESIFIchVkD5rPmhMIofaoOi5+huV/qTsy5E7SXZHOT1rANrW
         kN+/1HGNuYYvmmqgwMo7olII5+xi+ggpmPP/n/GMmEALaVUNVUXqUoYox1ON834UOv/z
         nD4nPtspYPAnSYYsjK22ncRg7xipzSudRYWXz53nCCptaW0zvoPayDCZvYqruMSYac2r
         V3ALeMVv0giNLvTbz2r2Tu5yNCDXpQMnkovM2nQFNO8wf2dXo2m/xsCdEAnyDPvZ6GtO
         EGx2bHisKApkYvbcMvZ4pi9kc0bDW1x137WhpzSVgBtwdwhjLvpu2op4qYwAR04B6vlo
         xvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S4Mhk39bbXlkNrotr3DgqM+vlFOU2lM4Arg9L7yykNE=;
        b=AssYB1R0xiaLNrDon3jJnRp5mimFpjxegUyxR4Ey2bvO0gKOPAx79ZgKDqMtj8rEXW
         S2MfjXDiV/CxImb3uH6yO7jI48gvfLfHAJVJqvCL8bfTcAAAhx8E3sU6jCkyhPZblOwV
         Y2dsZFub7fU05XTVUql9VJu3XOSPvyAjpyF/6NXzByILDvxSd1x2Kg2EKRz+iMnuSKq1
         nIdcU9dgRh6qXBz80ve4dpHmi8GjaaKjjDHeRwJIOLXmDHaspygk8vIxAShBB6uSIZ9e
         wXCQTEBghgg5hA64xXMSDwOR3EXR02Am64jSvOCFnfQjWDWABvPG/+dOLgcI6jSju5TC
         dmHQ==
X-Gm-Message-State: AOAM532UUldP15/Ty56IhrCjTzOOxh9hgs6MOubwe5xM1tpp+3bFNryM
        KSCs1WzvnfrFZg6yqixkiZSIfClRj6BG
X-Google-Smtp-Source: ABdhPJySUTp/AYpimem/8wlX7Y4EFKZExyC9hGKThuY55CBaukTnTY3EJM9qfrhdaaJYCE68LF9dY/9i598X
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:dd94:c753:a81d:c855])
 (user=kyletso job=sendgmr) by 2002:a5b:98a:: with SMTP id c10mr33340953ybq.406.1612282662556;
 Tue, 02 Feb 2021 08:17:42 -0800 (PST)
Date:   Wed,  3 Feb 2021 00:17:26 +0800
In-Reply-To: <20210202161733.932215-1-kyletso@google.com>
Message-Id: <20210202161733.932215-2-kyletso@google.com>
Mime-Version: 1.0
References: <20210202161733.932215-1-kyletso@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v5 1/8] usb: typec: Manage SVDM version
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
supported by the port and another variable in typec_port to cache the
negotiated SVDM version between the port partners.

Also add setter/getter functions for the negotiated SVDM version.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/class.c | 13 +++++++++++++
 include/linux/usb/typec.h | 10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index b6ceab3dc16b..42d1be1eece9 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -51,6 +51,7 @@ struct typec_port {
 	enum typec_role			vconn_role;
 	enum typec_pwr_opmode		pwr_opmode;
 	enum typec_port_type		port_type;
+	enum usb_pd_svdm_ver		svdm_version;
 	struct mutex			port_type_lock;
 
 	enum typec_orientation		orientation;
@@ -1841,6 +1842,18 @@ int typec_find_port_data_role(const char *name)
 }
 EXPORT_SYMBOL_GPL(typec_find_port_data_role);
 
+void typec_set_svdm_version(struct typec_port *port, enum usb_pd_svdm_ver ver)
+{
+	port->svdm_version = ver;
+}
+EXPORT_SYMBOL_GPL(typec_set_svdm_version);
+
+enum usb_pd_svdm_ver typec_get_svdm_version(struct typec_port *port)
+{
+	return port->svdm_version;
+}
+EXPORT_SYMBOL_GPL(typec_get_svdm_version);
+
 /* ------------------------------------------ */
 /* API for Multiplexer/DeMultiplexer Switches */
 
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 4946eca742d5..f692d9ee0f13 100644
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
@@ -286,4 +294,6 @@ int typec_find_orientation(const char *name);
 int typec_find_port_power_role(const char *name);
 int typec_find_power_role(const char *name);
 int typec_find_port_data_role(const char *name);
+void typec_set_svdm_version(struct typec_port *port, enum usb_pd_svdm_ver);
+enum usb_pd_svdm_ver typec_get_svdm_version(struct typec_port *port);
 #endif /* __LINUX_USB_TYPEC_H */
-- 
2.30.0.365.g02bc693789-goog

