Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2965319089
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhBKRB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:01:58 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:40064 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhBKPw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:52:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 3EB15FB02;
        Thu, 11 Feb 2021 16:51:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HmW5bFdKC6fV; Thu, 11 Feb 2021 16:51:06 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 38CC54188B; Thu, 11 Feb 2021 16:51:05 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v1 2/4] usb: typec: tps6598x: Add trace event for status register
Date:   Thu, 11 Feb 2021 16:51:03 +0100
Message-Id: <c9a7ddc23cbf5a5315c011dcfda85eca00a7cbe8.1613058605.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613058605.git.agx@sigxcpu.org>
References: <cover.1613058605.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to trace status information which helps to debug problems
with role switching, etc.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/usb/typec/tps6598x.c       | 26 ++++-----
 drivers/usb/typec/tps6598x.h       | 66 +++++++++++++++++++++
 drivers/usb/typec/tps6598x_trace.h | 94 ++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
index bc34b35e909f..559aa175f948 100644
--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -37,13 +37,6 @@
 #define TPS_REG_POWER_STATUS		0x3f
 #define TPS_REG_RX_IDENTITY_SOP		0x48
 
-/* TPS_REG_STATUS bits */
-#define TPS_STATUS_PLUG_PRESENT		BIT(0)
-#define TPS_STATUS_ORIENTATION		BIT(4)
-#define TPS_STATUS_PORTROLE(s)		(!!((s) & BIT(5)))
-#define TPS_STATUS_DATAROLE(s)		(!!((s) & BIT(6)))
-#define TPS_STATUS_VCONN(s)		(!!((s) & BIT(7)))
-
 /* TPS_REG_SYSTEM_CONF bits */
 #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
 
@@ -258,9 +251,9 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
 	}
 
 	typec_set_pwr_opmode(tps->port, mode);
-	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
-	typec_set_vconn_role(tps->port, TPS_STATUS_VCONN(status));
-	tps6598x_set_data_role(tps, TPS_STATUS_DATAROLE(status), true);
+	typec_set_pwr_role(tps->port, TPS_STATUS_TO_TYPEC_PORTROLE(status));
+	typec_set_vconn_role(tps->port, TPS_STATUS_TO_TYPEC_VCONN(status));
+	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status), true);
 
 	tps->partner = typec_register_partner(tps->port, &desc);
 	if (IS_ERR(tps->partner))
@@ -280,9 +273,10 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
 		typec_unregister_partner(tps->partner);
 	tps->partner = NULL;
 	typec_set_pwr_opmode(tps->port, TYPEC_PWR_MODE_USB);
-	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
-	typec_set_vconn_role(tps->port, TPS_STATUS_VCONN(status));
-	tps6598x_set_data_role(tps, TPS_STATUS_DATAROLE(status), false);
+	typec_set_pwr_role(tps->port, TPS_STATUS_TO_TYPEC_PORTROLE(status));
+	typec_set_vconn_role(tps->port, TPS_STATUS_TO_TYPEC_VCONN(status));
+	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status), false);
+
 	power_supply_changed(tps->psy);
 }
 
@@ -366,7 +360,7 @@ static int tps6598x_dr_set(struct typec_port *port, enum typec_data_role role)
 	if (ret)
 		goto out_unlock;
 
-	if (role != TPS_STATUS_DATAROLE(status)) {
+	if (role != TPS_STATUS_TO_TYPEC_DATAROLE(status)) {
 		ret = -EPROTO;
 		goto out_unlock;
 	}
@@ -396,7 +390,7 @@ static int tps6598x_pr_set(struct typec_port *port, enum typec_role role)
 	if (ret)
 		goto out_unlock;
 
-	if (role != TPS_STATUS_PORTROLE(status)) {
+	if (role != TPS_STATUS_TO_TYPEC_PORTROLE(status)) {
 		ret = -EPROTO;
 		goto out_unlock;
 	}
@@ -437,6 +431,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 		dev_err(tps->dev, "%s: failed to read status\n", __func__);
 		goto err_clear_ints;
 	}
+	trace_tps6598x_status(status);
 
 	/* Handle plug insert or removal */
 	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT) {
@@ -612,6 +607,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
 	if (ret < 0)
 		return ret;
+	trace_tps6598x_status(status);
 
 	ret = tps6598x_read32(tps, TPS_REG_SYSTEM_CONF, &conf);
 	if (ret < 0)
diff --git a/drivers/usb/typec/tps6598x.h b/drivers/usb/typec/tps6598x.h
index 3040cfdd2b8f..ceea4de51021 100644
--- a/drivers/usb/typec/tps6598x.h
+++ b/drivers/usb/typec/tps6598x.h
@@ -9,6 +9,72 @@
 #ifndef __TPS6598X_H__
 #define __TPS6598X_H__
 
+/* TPS_REG_STATUS bits */
+#define TPS_STATUS_PLUG_PRESENT		BIT(0)
+#define TPS_STATUS_PLUG_UPSIDE_DOWN	BIT(4)
+#define TPS_STATUS_PORTROLE		BIT(5)
+#define TPS_STATUS_TO_TYPEC_PORTROLE(s) (!!((s) & TPS_STATUS_PORTROLE))
+#define TPS_STATUS_DATAROLE		BIT(6)
+#define TPS_STATUS_TO_TYPEC_DATAROLE(s)	(!!((s) & TPS_STATUS_DATAROLE))
+#define TPS_STATUS_VCONN		BIT(7)
+#define TPS_STATUS_TO_TYPEC_VCONN(s)	(!!((s) & TPS_STATUS_VCONN))
+#define TPS_STATUS_OVERCURRENT		BIT(16)
+#define TPS_STATUS_GOTO_MIN_ACTIVE	BIT(26)
+#define TPS_STATUS_BIST			BIT(27)
+#define TPS_STATUS_HIGH_VOLAGE_WARNING	BIT(28)
+#define TPS_STATUS_HIGH_LOW_VOLTAGE_WARNING BIT(29)
+
+#define TPS_STATUS_CONN_STATE_MASK		GENMASK(3, 1)
+#define TPS_STATUS_CONN_STATE(x)		FIELD_GET(TPS_STATUS_CONN_STATE_MASK, (x))
+#define TPS_STATUS_PP_5V0_SWITCH_MASK		GENMASK(9, 8)
+#define TPS_STATUS_PP_5V0_SWITCH(x)		FIELD_GET(TPS_STATUS_PP_5V0_SWITCH_MASK, (x))
+#define TPS_STATUS_PP_HV_SWITCH_MASK		GENMASK(11, 10)
+#define TPS_STATUS_PP_HV_SWITCH(x)		FIELD_GET(TPS_STATUS_PP_HV_SWITCH_MASK, (x))
+#define TPS_STATUS_PP_EXT_SWITCH_MASK		GENMASK(13, 12)
+#define TPS_STATUS_PP_EXT_SWITCH(x)		FIELD_GET(TPS_STATUS_PP_EXT_SWITCH_MASK, (x))
+#define TPS_STATUS_PP_CABLE_SWITCH_MASK		GENMASK(15, 14)
+#define TPS_STATUS_PP_CABLE_SWITCH(x)		FIELD_GET(TPS_STATUS_PP_CABLE_SWITCH_MASK, (x))
+#define TPS_STATUS_POWER_SOURCE_MASK		GENMASK(19, 18)
+#define TPS_STATUS_POWER_SOURCE(x)		FIELD_GET(TPS_STATUS_POWER_SOURCE_MASK, (x))
+#define TPS_STATUS_VBUS_STATUS_MASK		GENMASK(21, 20)
+#define TPS_STATUS_VBUS_STATUS(x)		FIELD_GET(TPS_STATUS_VBUS_STATUS_MASK, (x))
+#define TPS_STATUS_USB_HOST_PRESENT_MASK	GENMASK(23, 22)
+#define TPS_STATUS_USB_HOST_PRESENT(x)		FIELD_GET(TPS_STATUS_USB_HOST_PRESENT_MASK, (x))
+#define TPS_STATUS_LEGACY_MASK			GENMASK(25, 24)
+#define TPS_STATUS_LEGACY(x)			FIELD_GET(TPS_STATUS_LEGACY_MASK, (x))
+
+#define TPS_STATUS_CONN_STATE_NO_CONN		0
+#define TPS_STATUS_CONN_STATE_DISABLED		1
+#define TPS_STATUS_CONN_STATE_AUDIO_CONN	2
+#define TPS_STATUS_CONN_STATE_DEBUG_CONN	3
+#define TPS_STATUS_CONN_STATE_NO_CONN_R_A	4
+#define TPS_STATUS_CONN_STATE_RESERVED		5
+#define TPS_STATUS_CONN_STATE_CONN_NO_R_A	6
+#define TPS_STATUS_CONN_STATE_CONN_WITH_R_A	7
+
+#define TPS_STATUS_PP_SWITCH_STATE_DISABLED	0
+#define TPS_STATUS_PP_SWITCH_STATE_FAULT	1
+#define TPS_STATUS_PP_SWITCH_STATE_OUT		2
+#define TPS_STATUS_PP_SWITCH_STATE_IN		3
+
+#define TPS_STATUS_POWER_SOURCE_UNKNOWN		0
+#define TPS_STATUS_POWER_SOURCE_VIN_3P3		1
+#define TPS_STATUS_POWER_SOURCE_DEAD_BAT	2
+#define TPS_STATUS_POWER_SOURCE_VBUS		3
+
+#define TPS_STATUS_VBUS_STATUS_VSAFE0V		0
+#define TPS_STATUS_VBUS_STATUS_VSAFE5V		1
+#define TPS_STATUS_VBUS_STATUS_PD		2
+#define TPS_STATUS_VBUS_STATUS_FAULT		3
+
+#define TPS_STATUS_USB_HOST_PRESENT_NO		0
+#define TPS_STATUS_USB_HOST_PRESENT_PD_NO_USB	1
+#define TPS_STATUS_USB_HOST_PRESENT_NO_PD	2
+#define TPS_STATUS_USB_HOST_PRESENT_PD_USB	3
+
+#define TPS_STATUS_LEGACY_NO			0
+#define TPS_STATUS_LEGACY_SINK			1
+#define TPS_STATUS_LEGACY_SOURCE		2
 
 /* TPS_REG_INT_* bits */
 #define TPS_REG_INT_USER_VID_ALT_MODE_OTHER_VDM		BIT(27+32)
diff --git a/drivers/usb/typec/tps6598x_trace.h b/drivers/usb/typec/tps6598x_trace.h
index 1467f5180a50..5aa0aa4d5209 100644
--- a/drivers/usb/typec/tps6598x_trace.h
+++ b/drivers/usb/typec/tps6598x_trace.h
@@ -67,6 +67,73 @@
 		{ TPS_REG_INT_USER_VID_ALT_MODE_ATTN_VDM,	"USER_VID_ALT_MODE_ATTN_VDM" }, \
 		{ TPS_REG_INT_USER_VID_ALT_MODE_OTHER_VDM,	"USER_VID_ALT_MODE_OTHER_VDM" })
 
+#define TPS6598X_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_STATUS_CONN_STATE_MASK | \
+						      TPS_STATUS_PP_5V0_SWITCH_MASK | \
+						      TPS_STATUS_PP_HV_SWITCH_MASK | \
+						      TPS_STATUS_PP_EXT_SWITCH_MASK | \
+						      TPS_STATUS_PP_CABLE_SWITCH_MASK | \
+						      TPS_STATUS_POWER_SOURCE_MASK | \
+						      TPS_STATUS_VBUS_STATUS_MASK | \
+						      TPS_STATUS_USB_HOST_PRESENT_MASK | \
+						      TPS_STATUS_LEGACY_MASK))
+
+#define show_status_conn_state(status) \
+	__print_symbolic(TPS_STATUS_CONN_STATE((status)), \
+		{ TPS_STATUS_CONN_STATE_CONN_WITH_R_A,	"conn-Ra"  }, \
+		{ TPS_STATUS_CONN_STATE_CONN_NO_R_A,	"conn-no-Ra" }, \
+		{ TPS_STATUS_CONN_STATE_NO_CONN_R_A,	"no-conn-Ra" },	\
+		{ TPS_STATUS_CONN_STATE_DEBUG_CONN,	"debug"	 }, \
+		{ TPS_STATUS_CONN_STATE_AUDIO_CONN,	"audio"	 }, \
+		{ TPS_STATUS_CONN_STATE_DISABLED,	"disabled" }, \
+		{ TPS_STATUS_CONN_STATE_NO_CONN,	"no-conn" })
+
+#define show_status_pp_switch_state(status) \
+	__print_symbolic(status, \
+		{ TPS_STATUS_PP_SWITCH_STATE_IN,	"in" }, \
+		{ TPS_STATUS_PP_SWITCH_STATE_OUT,	"out" }, \
+		{ TPS_STATUS_PP_SWITCH_STATE_FAULT,	"fault" }, \
+		{ TPS_STATUS_PP_SWITCH_STATE_DISABLED,	"off" })
+
+#define show_status_power_sources(status) \
+	__print_symbolic(TPS_STATUS_POWER_SOURCE(status), \
+		{ TPS_STATUS_POWER_SOURCE_VBUS,		"vbus" }, \
+		{ TPS_STATUS_POWER_SOURCE_VIN_3P3,	"vin-3p3" }, \
+		{ TPS_STATUS_POWER_SOURCE_DEAD_BAT,	"dead-battery" }, \
+		{ TPS_STATUS_POWER_SOURCE_UNKNOWN,	"unknown" })
+
+#define show_status_vbus_status(status) \
+	__print_symbolic(TPS_STATUS_VBUS_STATUS(status), \
+		{ TPS_STATUS_VBUS_STATUS_VSAFE0V,	"vSafe0V" }, \
+		{ TPS_STATUS_VBUS_STATUS_VSAFE5V,	"vSafe5V" }, \
+		{ TPS_STATUS_VBUS_STATUS_PD,		"pd" }, \
+		{ TPS_STATUS_VBUS_STATUS_FAULT,		"fault" })
+
+#define show_status_usb_host_present(status) \
+	__print_symbolic(TPS_STATUS_USB_HOST_PRESENT(status), \
+		{ TPS_STATUS_USB_HOST_PRESENT_PD_USB,	 "pd-usb" }, \
+		{ TPS_STATUS_USB_HOST_PRESENT_NO_PD,	 "no-pd" }, \
+		{ TPS_STATUS_USB_HOST_PRESENT_PD_NO_USB, "pd-no-usb" }, \
+		{ TPS_STATUS_USB_HOST_PRESENT_NO,	 "no" })
+
+#define show_status_legacy(status) \
+	__print_symbolic(TPS_STATUS_LEGACY(status),	     \
+		{ TPS_STATUS_LEGACY_SOURCE,		 "source" }, \
+		{ TPS_STATUS_LEGACY_SINK,		 "sink" }, \
+		{ TPS_STATUS_LEGACY_NO,			 "no" })
+
+#define show_status_flags(flags) \
+	__print_flags((flags & TPS6598X_STATUS_FLAGS_MASK), "|", \
+		      { TPS_STATUS_PLUG_PRESENT,	"PLUG_PRESENT" }, \
+		      { TPS_STATUS_PLUG_UPSIDE_DOWN,	"UPSIDE_DOWN" }, \
+		      { TPS_STATUS_PORTROLE,		"PORTROLE" }, \
+		      { TPS_STATUS_DATAROLE,		"DATAROLE" }, \
+		      { TPS_STATUS_VCONN,		"VCONN" }, \
+		      { TPS_STATUS_OVERCURRENT,		"OVERCURRENT" }, \
+		      { TPS_STATUS_GOTO_MIN_ACTIVE,	"GOTO_MIN_ACTIVE" }, \
+		      { TPS_STATUS_BIST,		"BIST" }, \
+		      { TPS_STATUS_HIGH_VOLAGE_WARNING,	"HIGH_VOLAGE_WARNING" }, \
+		      { TPS_STATUS_HIGH_LOW_VOLTAGE_WARNING, "HIGH_LOW_VOLTAGE_WARNING" })
+
 TRACE_EVENT(tps6598x_irq,
 	    TP_PROTO(u64 event1,
 		     u64 event2),
@@ -87,6 +154,33 @@ TRACE_EVENT(tps6598x_irq,
 		      show_irq_flags(__entry->event2))
 );
 
+TRACE_EVENT(tps6598x_status,
+	    TP_PROTO(u32 status),
+	    TP_ARGS(status),
+
+	    TP_STRUCT__entry(
+			     __field(u32, status)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->status = status;
+			   ),
+
+	    TP_printk("conn: %s, pp_5v0: %s, pp_hv: %s, pp_ext: %s, pp_cable: %s, "
+		      "pwr-src: %s, vbus: %s, usb-host: %s, legacy: %s, flags: %s",
+		      show_status_conn_state(__entry->status),
+		      show_status_pp_switch_state(TPS_STATUS_PP_5V0_SWITCH(__entry->status)),
+		      show_status_pp_switch_state(TPS_STATUS_PP_HV_SWITCH(__entry->status)),
+		      show_status_pp_switch_state(TPS_STATUS_PP_EXT_SWITCH(__entry->status)),
+		      show_status_pp_switch_state(TPS_STATUS_PP_CABLE_SWITCH(__entry->status)),
+		      show_status_power_sources(__entry->status),
+		      show_status_vbus_status(__entry->status),
+		      show_status_usb_host_present(__entry->status),
+		      show_status_legacy(__entry->status),
+		      show_status_flags(__entry->status)
+		    )
+);
+
 #endif /* _TPS6598X_TRACE_H_ */
 
 /* This part must be outside protection */
-- 
2.30.0

