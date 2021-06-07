Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543DA39DD6F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFGNQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:16:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:17618 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230387AbhFGNQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:16:24 -0400
IronPort-SDR: dCwrKBJ0c0PCZ4pvMPHC1GzeYYB3pL718ybTaNqlJ4VpjCXGgZ1XykMELYgPAp6GFgXyQT1uF6
 L+KIzV3J3Nfg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265774005"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="265774005"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 06:14:32 -0700
IronPort-SDR: pHPpuAua0PGlmofypaEQtqRyUBiLx9Bh2yT/VCqntBYmkGlo/BWPzwOb0LFE8y/rkZ8ESLV2xM
 pSF7H+dmzS+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="551881939"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2021 06:14:31 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/7] usb: typec: ucsi: Read the PDOs in separate work
Date:   Mon,  7 Jun 2021 16:14:42 +0300
Message-Id: <20210607131442.20121-8-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Polling also the PDOs, just like the alt modes.

After this ucsi_handle_connector_change() doesn't execute
any commands.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index ce80a433ef9db..bd39fe2cb1d0b 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -575,7 +575,7 @@ static int ucsi_get_pdos(struct ucsi_connector *con, int is_partner,
 	command |= UCSI_GET_PDOS_SRC_PDOS;
 	ret = ucsi_send_command(ucsi, command, pdos + offset,
 				num_pdos * sizeof(u32));
-	if (ret < 0)
+	if (ret < 0 && ret != -ETIMEDOUT)
 		dev_err(ucsi->dev, "UCSI_GET_PDOS failed (%d)\n", ret);
 	if (ret == 0 && offset == 0)
 		dev_warn(ucsi->dev, "UCSI_GET_PDOS returned 0 bytes\n");
@@ -583,26 +583,30 @@ static int ucsi_get_pdos(struct ucsi_connector *con, int is_partner,
 	return ret;
 }
 
-static void ucsi_get_src_pdos(struct ucsi_connector *con, int is_partner)
+static int ucsi_get_src_pdos(struct ucsi_connector *con)
 {
 	int ret;
 
 	/* UCSI max payload means only getting at most 4 PDOs at a time */
 	ret = ucsi_get_pdos(con, 1, con->src_pdos, 0, UCSI_MAX_PDOS);
 	if (ret < 0)
-		return;
+		return ret;
 
 	con->num_pdos = ret / sizeof(u32); /* number of bytes to 32-bit PDOs */
 	if (con->num_pdos < UCSI_MAX_PDOS)
-		return;
+		return 0;
 
 	/* get the remaining PDOs, if any */
 	ret = ucsi_get_pdos(con, 1, con->src_pdos, UCSI_MAX_PDOS,
 			    PDO_MAX_OBJECTS - UCSI_MAX_PDOS);
 	if (ret < 0)
-		return;
+		return ret;
 
 	con->num_pdos += ret / sizeof(u32);
+
+	ucsi_port_psy_changed(con);
+
+	return 0;
 }
 
 static int ucsi_check_altmodes(struct ucsi_connector *con)
@@ -630,7 +634,7 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 	case UCSI_CONSTAT_PWR_OPMODE_PD:
 		con->rdo = con->status.request_data_obj;
 		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_PD);
-		ucsi_get_src_pdos(con, 1);
+		ucsi_partner_task(con, ucsi_get_src_pdos, 20);
 		break;
 	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
 		con->rdo = 0;
@@ -758,10 +762,8 @@ static void ucsi_connector_work(struct work_struct *work)
 	role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
 
 	if (con->status.change & UCSI_CONSTAT_POWER_OPMODE_CHANGE ||
-	    con->status.change & UCSI_CONSTAT_POWER_LEVEL_CHANGE) {
+	    con->status.change & UCSI_CONSTAT_POWER_LEVEL_CHANGE)
 		ucsi_pwr_opmode_change(con);
-		ucsi_port_psy_changed(con);
-	}
 
 	if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
 		typec_set_pwr_role(con->port, role);
@@ -1170,9 +1172,9 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 	if (con->status.flags & UCSI_CONSTAT_CONNECTED) {
 		typec_set_pwr_role(con->port,
 				  !!(con->status.flags & UCSI_CONSTAT_PWR_DIR));
-		ucsi_pwr_opmode_change(con);
 		ucsi_register_partner(con);
 		ucsi_port_psy_changed(con);
+		ucsi_pwr_opmode_change(con);
 	}
 
 	con->usb_role_sw = fwnode_usb_role_switch_get(cap->fwnode);
-- 
2.30.2

