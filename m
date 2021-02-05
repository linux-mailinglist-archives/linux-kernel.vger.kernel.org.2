Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F91131119F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhBESPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:15:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:26179 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhBESLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:11:54 -0500
IronPort-SDR: Rt4NGCn8Si2K1FNEiGluATf2s0fJMC3mubnRs1RstOe1oMKtvyU6d614PrKowTA2/cJiUAqz5z
 LDbc/fNhJumw==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="200493377"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="200493377"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 11:52:06 -0800
IronPort-SDR: XEJrU5nLrdYY6CBx7Ht8qEi2CeTAA8ghWxDMsHr4g8h4WW/0y4O+Ua9nWTYXNkYnc163aHyVVg
 HLSQxNrCublg==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="434580884"
Received: from glacier.sc.intel.com ([10.3.62.63])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 05 Feb 2021 11:52:05 -0800
From:   Rajmohan Mani <rajmohan.mani@intel.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH 2/2] platform/chrome: cros_ec_types: Support disconnect events without partners
Date:   Fri,  5 Feb 2021 11:51:13 -0800
Message-Id: <20210205195113.20277-3-rajmohan.mani@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210205195113.20277-1-rajmohan.mani@intel.com>
References: <20210205195113.20277-1-rajmohan.mani@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are certain scenarios, where a disconnect event might
occur on a Type-C port with no port partners. This is required
to enable communication to Burnside Bridge USB4 retimers.

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 26 ++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 3d8ff3f8a514..d89fe51b74b1 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -203,20 +203,26 @@ static void cros_typec_unregister_altmodes(struct cros_typec_data *typec, int po
 	}
 }
 
-static void cros_typec_remove_partner(struct cros_typec_data *typec,
-				     int port_num)
+static int cros_typec_usb_disconnect_state(struct cros_typec_port *port)
 {
-	struct cros_typec_port *port = typec->ports[port_num];
-
-	cros_typec_unregister_altmodes(typec, port_num, true);
-
 	port->state.alt = NULL;
 	port->state.mode = TYPEC_STATE_USB;
 	port->state.data = NULL;
 
 	usb_role_switch_set_role(port->role_sw, USB_ROLE_NONE);
 	typec_switch_set(port->ori_sw, TYPEC_ORIENTATION_NONE);
-	typec_mux_set(port->mux, &port->state);
+
+	return typec_mux_set(port->mux, &port->state);
+}
+
+static void cros_typec_remove_partner(struct cros_typec_data *typec,
+				      int port_num)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+
+	cros_typec_unregister_altmodes(typec, port_num, true);
+
+	cros_typec_usb_disconnect_state(port);
 
 	typec_unregister_partner(port->partner);
 	port->partner = NULL;
@@ -536,6 +542,11 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	enum typec_orientation orientation;
 	int ret;
 
+	if (mux_flags == USB_PD_MUX_NONE) {
+		ret = cros_typec_usb_disconnect_state(port);
+		goto mux_ack;
+	}
+
 	if (mux_flags & USB_PD_MUX_POLARITY_INVERTED)
 		orientation = TYPEC_ORIENTATION_REVERSE;
 	else
@@ -569,6 +580,7 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 			mux_flags);
 	}
 
+mux_ack:
 	if (!typec->needs_mux_ack)
 		return ret;
 
-- 
2.30.0

