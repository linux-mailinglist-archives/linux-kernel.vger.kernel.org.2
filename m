Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745E731908A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhBKRCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:02:42 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:40088 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231261AbhBKPx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:53:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 9ECF1FB05;
        Thu, 11 Feb 2021 16:51:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RS5yTBkyuB6t; Thu, 11 Feb 2021 16:51:12 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4D6AC4188E; Thu, 11 Feb 2021 16:51:05 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v1 4/4] usb: typec: tps6598x: Add trace event for data status
Date:   Thu, 11 Feb 2021 16:51:05 +0100
Message-Id: <38b2be2f7bcfc025d6870391e19130dd488a8035.1613058605.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613058605.git.agx@sigxcpu.org>
References: <cover.1613058605.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is useful to debug DP negotiation and pin assignment even
when the firmware does all the work.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/usb/typec/tps6598x.c       | 12 ++++++-
 drivers/usb/typec/tps6598x.h       | 36 ++++++++++++++++++++
 drivers/usb/typec/tps6598x_trace.h | 54 ++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
index 3e6ad3ba7fc8..a4ec8e56c2b9 100644
--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -36,6 +36,7 @@
 #define TPS_REG_CTRL_CONF		0x29
 #define TPS_REG_POWER_STATUS		0x3f
 #define TPS_REG_RX_IDENTITY_SOP		0x48
+#define TPS_REG_DATA_STATUS		0x5f
 
 /* TPS_REG_SYSTEM_CONF bits */
 #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
@@ -408,7 +409,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	struct tps6598x *tps = data;
 	u64 event1;
 	u64 event2;
-	u32 status;
+	u32 status, data_status;
 	u16 pwr_status;
 	int ret;
 
@@ -438,6 +439,15 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 		trace_tps6598x_power_status(pwr_status);
 	}
 
+	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE) {
+		ret = tps6598x_read32(tps, TPS_REG_DATA_STATUS, &data_status);
+		if (ret < 0) {
+			dev_err(tps->dev, "failed to read data status: %d\n", ret);
+			goto err_clear_ints;
+		}
+		trace_tps6598x_data_status(data_status);
+	}
+
 	/* Handle plug insert or removal */
 	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT) {
 		if (status & TPS_STATUS_PLUG_PRESENT) {
diff --git a/drivers/usb/typec/tps6598x.h b/drivers/usb/typec/tps6598x.h
index a2b76ee26f53..3794d75ffada 100644
--- a/drivers/usb/typec/tps6598x.h
+++ b/drivers/usb/typec/tps6598x.h
@@ -143,4 +143,40 @@
 #define TPS_POWER_STATUS_BC12_STATUS_CDP 2
 #define TPS_POWER_STATUS_BC12_STATUS_DCP 3
 
+/* TPS_REG_DATA_STATUS bits */
+#define TPS_DATA_STATUS_DATA_CONNECTION	     BIT(0)
+#define TPS_DATA_STATUS_UPSIDE_DOWN	     BIT(1)
+#define TPS_DATA_STATUS_ACTIVE_CABLE	     BIT(2)
+#define TPS_DATA_STATUS_USB2_CONNECTION	     BIT(4)
+#define TPS_DATA_STATUS_USB3_CONNECTION	     BIT(5)
+#define TPS_DATA_STATUS_USB3_GEN2	     BIT(6)
+#define TPS_DATA_STATUS_USB_DATA_ROLE	     BIT(7)
+#define TPS_DATA_STATUS_DP_CONNECTION	     BIT(8)
+#define TPS_DATA_STATUS_DP_SINK		     BIT(9)
+#define TPS_DATA_STATUS_TBT_CONNECTION	     BIT(16)
+#define TPS_DATA_STATUS_TBT_TYPE	     BIT(17)
+#define TPS_DATA_STATUS_OPTICAL_CABLE	     BIT(18)
+#define TPS_DATA_STATUS_ACTIVE_LINK_TRAIN    BIT(20)
+#define TPS_DATA_STATUS_FORCE_LSX	     BIT(23)
+#define TPS_DATA_STATUS_POWER_MISMATCH	     BIT(24)
+
+#define TPS_DATA_STATUS_DP_PIN_ASSIGNMENT_MASK GENMASK(11, 10)
+#define TPS_DATA_STATUS_DP_PIN_ASSIGNMENT(x) \
+	FIELD_GET(TPS_DATA_STATUS_DP_PIN_ASSIGNMENT_MASK, (x))
+#define TPS_DATA_STATUS_TBT_CABLE_SPEED_MASK   GENMASK(27, 25)
+#define TPS_DATA_STATUS_TBT_CABLE_SPEED	       FIELD_GET(TPS_DATA_STATUS_TBT_CABLE_SPEED_MASK, (x))
+#define TPS_DATA_STATUS_TBT_CABLE_GEN_MASK     GENMASK(29, 28)
+#define TPS_DATA_STATUS_TBT_CABLE_GEN	       FIELD_GET(TPS_DATA_STATUS_TBT_CABLE_GEN_MASK, (x))
+
+/* Map data status to DP spec assignments */
+#define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT(x) \
+	((TPS_DATA_STATUS_DP_PIN_ASSIGNMENT(x) << 1) | \
+		FIELD_GET(TPS_DATA_STATUS_USB3_CONNECTION, (x)))
+#define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_E    0
+#define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_F    BIT(0)
+#define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_C    BIT(1)
+#define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_D    (BIT(1) | BIT(0))
+#define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_A    BIT(2)
+#define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B    (BIT(2) | BIT(1))
+
 #endif /* __TPS6598X_H__ */
diff --git a/drivers/usb/typec/tps6598x_trace.h b/drivers/usb/typec/tps6598x_trace.h
index c15327bb7bf1..0ec264bb2042 100644
--- a/drivers/usb/typec/tps6598x_trace.h
+++ b/drivers/usb/typec/tps6598x_trace.h
@@ -152,6 +152,41 @@
 		{ TPS_POWER_STATUS_BC12_STATUS_CDP, "cdp" }, \
 		{ TPS_POWER_STATUS_BC12_STATUS_SDP, "sdp" })
 
+#define TPS_DATA_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_DATA_STATUS_DP_PIN_ASSIGNMENT_MASK | \
+						      TPS_DATA_STATUS_TBT_CABLE_SPEED_MASK | \
+						      TPS_DATA_STATUS_TBT_CABLE_GEN_MASK))
+
+#define show_data_status_flags(data_status) \
+	__print_flags(data_status & TPS_DATA_STATUS_FLAGS_MASK, "|", \
+		{ TPS_DATA_STATUS_DATA_CONNECTION,	"DATA_CONNECTION" }, \
+		{ TPS_DATA_STATUS_UPSIDE_DOWN,		"DATA_UPSIDE_DOWN" }, \
+		{ TPS_DATA_STATUS_ACTIVE_CABLE,		"ACTIVE_CABLE" }, \
+		{ TPS_DATA_STATUS_USB2_CONNECTION,	"USB2_CONNECTION" }, \
+		{ TPS_DATA_STATUS_USB3_CONNECTION,	"USB3_CONNECTION" }, \
+		{ TPS_DATA_STATUS_USB3_GEN2,		"USB3_GEN2" }, \
+		{ TPS_DATA_STATUS_USB_DATA_ROLE,	"USB_DATA_ROLE" }, \
+		{ TPS_DATA_STATUS_DP_CONNECTION,	"DP_CONNECTION" }, \
+		{ TPS_DATA_STATUS_DP_SINK,		"DP_SINK" }, \
+		{ TPS_DATA_STATUS_TBT_CONNECTION,	"TBT_CONNECTION" }, \
+		{ TPS_DATA_STATUS_TBT_TYPE,		"TBT_TYPE" }, \
+		{ TPS_DATA_STATUS_OPTICAL_CABLE,	"OPTICAL_CABLE" }, \
+		{ TPS_DATA_STATUS_ACTIVE_LINK_TRAIN,	"ACTIVE_LINK_TRAIN" }, \
+		{ TPS_DATA_STATUS_FORCE_LSX,		"FORCE_LSX" }, \
+		{ TPS_DATA_STATUS_POWER_MISMATCH,	"POWER_MISMATCH" })
+
+#define show_data_status_dp_pin_assignment(data_status) \
+	__print_symbolic(TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT(data_status), \
+		{ TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_E, "E" }, \
+		{ TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_F, "F" }, \
+		{ TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_C, "C" }, \
+		{ TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_D, "D" }, \
+		{ TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_A, "A" }, \
+		{ TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B, "B" })
+
+#define maybe_show_data_status_dp_pin_assignment(data_status) \
+	(data_status & TPS_DATA_STATUS_DP_CONNECTION ? \
+	 show_data_status_dp_pin_assignment(data_status) : "")
+
 TRACE_EVENT(tps6598x_irq,
 	    TP_PROTO(u64 event1,
 		     u64 event2),
@@ -219,6 +254,25 @@ TRACE_EVENT(tps6598x_power_status,
 		    )
 );
 
+TRACE_EVENT(tps6598x_data_status,
+	    TP_PROTO(u32 data_status),
+	    TP_ARGS(data_status),
+
+	    TP_STRUCT__entry(
+			     __field(u32, data_status)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->data_status = data_status;
+			   ),
+
+	    TP_printk("%s%s%s",
+		      show_data_status_flags(__entry->data_status),
+		      __entry->data_status & TPS_DATA_STATUS_DP_CONNECTION ? ", DP pinout " : "",
+		      maybe_show_data_status_dp_pin_assignment(__entry->data_status)
+		    )
+);
+
 #endif /* _TPS6598X_TRACE_H_ */
 
 /* This part must be outside protection */
-- 
2.30.0

