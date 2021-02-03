Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE79130DB71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhBCNhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:37:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:53857 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232078AbhBCNgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:36:07 -0500
IronPort-SDR: m+0DYk33G3PA7AxzQNJtvKjsWkYheUFWDbgunej4W4zIKNBup27SVVg9OhsJFc7cSIjMRO/5RW
 VTYeU2k7U28g==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160205448"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="diff'?scan'208";a="160205448"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 05:34:12 -0800
IronPort-SDR: ebZ4EKkbByu9zyt371NkzmzjxNMJcy6cR2nDbKa+Oj1ilrgll0Rn9FR5xeBc7xilx74s60AuYW
 WilY1Q93q46w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="diff'?scan'208";a="480351688"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 03 Feb 2021 05:34:09 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 03 Feb 2021 15:34:08 +0200
Date:   Wed, 3 Feb 2021 15:34:08 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, robh+dt@kernel.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/8] usb: typec: Manage SVDM version
Message-ID: <20210203133408.GF1687065@kuha.fi.intel.com>
References: <20210202161733.932215-1-kyletso@google.com>
 <20210202161733.932215-2-kyletso@google.com>
 <20210203124724.GD1687065@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20210203124724.GD1687065@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kyle,

On Wed, Feb 03, 2021 at 02:47:28PM +0200, Heikki Krogerus wrote:
> You need to document those exported functions! You need to do that in
> any case, but in this case it's very important, because the purpose of
> these functions is not clear from the ctx.
> 
> I'm sorry for noticing that so late. Since you do need to fix that,
> please see if you can also store that detail in the partner device
> object instead of the port object.

I'm attaching here my (quite crude) proposal how to do this. It should
give you an idea what I'm after here.

Br,

-- 
heikki

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="svdm_version_proposal.diff"

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 8f77669f9cf4f..04238b0a5d47f 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -36,6 +36,8 @@ struct typec_partner {
 	enum typec_accessory		accessory;
 	struct ida			mode_ids;
 	int				num_altmodes;
+
+	enum usb_pd_svdm_ver            svdm_version;
 };
 
 struct typec_port {
@@ -792,6 +794,18 @@ typec_partner_register_altmode(struct typec_partner *partner,
 }
 EXPORT_SYMBOL_GPL(typec_partner_register_altmode);
 
+/**
+ * typec_partner_set_svdm_version - Set negotiated SVDM version
+ * @partner: The partner.
+ * ...
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
@@ -1847,6 +1861,27 @@ EXPORT_SYMBOL_GPL(typec_set_mode);
 
 /* --------------------------------------- */
 
+/**
+ * typec_get_negotiated_svdm_version - Get negotiated SVDM version
+ * @port: The port.
+ * ...
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
+	return svdm_version
+}
+EXPORT_SYMBOL_GPL(typec_partner_set_svdm_version);
+
 /**
  * typec_get_drvdata - Return private driver data pointer
  * @port: USB Type-C port
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index 5e0a7b7647c3b..91e119e37ba70 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -132,6 +132,16 @@ typec_altmode_get_orientation(struct typec_altmode *altmode)
 	return typec_get_orientation(typec_altmode2port(altmode));
 }
 
+/**
+ * typec_get_negotiated_svdm_version - Get negotiated SVDM version
+ * ...
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

--CE+1k2dSO48ffgeK--
