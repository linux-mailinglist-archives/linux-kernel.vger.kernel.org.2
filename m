Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D01D31B856
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 12:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBOLsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 06:48:38 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:51180 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhBOLrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:47:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 91B34FB05;
        Mon, 15 Feb 2021 12:46:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5DGgijRnQq7q; Mon, 15 Feb 2021 12:46:52 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 940A74188B; Mon, 15 Feb 2021 12:46:45 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v3 3/4] usb: typec: tps6598x: Add trace event for power status register
Date:   Mon, 15 Feb 2021 12:46:44 +0100
Message-Id: <3c92da489fa03d6fe67ac18443c48dccb1bf048a.1613389531.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613389531.git.agx@sigxcpu.org>
References: <cover.1613389531.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Together with the PD status register this is vital for debugging power
negotiations at runtime.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/usb/typec/tps6598x.c       | 19 +++++++++------
 drivers/usb/typec/tps6598x.h       | 19 +++++++++++++++
 drivers/usb/typec/tps6598x_trace.h | 38 ++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
index 559aa175f948..3e6ad3ba7fc8 100644
--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -50,11 +50,6 @@ enum {
 	TPS_PORTINFO_SOURCE,
 };
 
-/* TPS_REG_POWER_STATUS bits */
-#define TPS_POWER_STATUS_CONNECTION	BIT(0)
-#define TPS_POWER_STATUS_SOURCESINK	BIT(1)
-#define TPS_POWER_STATUS_PWROPMODE(p)	(((p) & GENMASK(3, 2)) >> 2)
-
 /* TPS_REG_RX_IDENTITY_SOP */
 struct tps6598x_rx_identity_reg {
 	u8 status;
@@ -414,6 +409,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	u64 event1;
 	u64 event2;
 	u32 status;
+	u16 pwr_status;
 	int ret;
 
 	mutex_lock(&tps->lock);
@@ -433,6 +429,15 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	}
 	trace_tps6598x_status(status);
 
+	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE) {
+		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
+		if (ret < 0) {
+			dev_err(tps->dev, "failed to read power status: %d\n", ret);
+			goto err_clear_ints;
+		}
+		trace_tps6598x_power_status(pwr_status);
+	}
+
 	/* Handle plug insert or removal */
 	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT) {
 		if (status & TPS_STATUS_PLUG_PRESENT) {
@@ -497,8 +502,8 @@ static int tps6598x_psy_get_online(struct tps6598x *tps,
 	if (ret < 0)
 		return ret;
 
-	if ((pwr_status & TPS_POWER_STATUS_CONNECTION) &&
-	    (pwr_status & TPS_POWER_STATUS_SOURCESINK)) {
+	if (TPS_POWER_STATUS_CONNECTION(pwr_status) &&
+	    TPS_POWER_STATUS_SOURCESINK(pwr_status)) {
 		val->intval = 1;
 	} else {
 		val->intval = 0;
diff --git a/drivers/usb/typec/tps6598x.h b/drivers/usb/typec/tps6598x.h
index 621fb336c15d..9a34c020f3e5 100644
--- a/drivers/usb/typec/tps6598x.h
+++ b/drivers/usb/typec/tps6598x.h
@@ -129,4 +129,23 @@
 #define TPS_REG_INT_HARD_RESET				BIT(1)
 #define TPS_REG_INT_PD_SOFT_RESET			BIT(0)
 
+/* TPS_REG_POWER_STATUS bits */
+#define TPS_POWER_STATUS_CONNECTION(x)  TPS_FIELD_GET(BIT(0), (x))
+#define TPS_POWER_STATUS_SOURCESINK(x)	TPS_FIELD_GET(BIT(1), (x))
+#define TPS_POWER_STATUS_BC12_DET(x)	TPS_FIELD_GET(BIT(2), (x))
+
+#define TPS_POWER_STATUS_TYPEC_CURRENT_MASK GENMASK(3, 2)
+#define TPS_POWER_STATUS_PWROPMODE(p)	    TPS_FIELD_GET(TPS_POWER_STATUS_TYPEC_CURRENT_MASK, (p))
+#define TPS_POWER_STATUS_BC12_STATUS_MASK   GENMASK(6, 5)
+#define TPS_POWER_STATUS_BC12_STATUS(p)	    TPS_FIELD_GET(TPS_POWER_STATUS_BC12_STATUS_MASK, (p))
+
+#define TPS_POWER_STATUS_TYPEC_CURRENT_USB     0
+#define TPS_POWER_STATUS_TYPEC_CURRENT_1A5     1
+#define TPS_POWER_STATUS_TYPEC_CURRENT_3A0     2
+#define TPS_POWER_STATUS_TYPEC_CURRENT_PD      3
+
+#define TPS_POWER_STATUS_BC12_STATUS_SDP 0
+#define TPS_POWER_STATUS_BC12_STATUS_CDP 2
+#define TPS_POWER_STATUS_BC12_STATUS_DCP 3
+
 #endif /* __TPS6598X_H__ */
diff --git a/drivers/usb/typec/tps6598x_trace.h b/drivers/usb/typec/tps6598x_trace.h
index e0677b9c5c53..78a5a6ca337b 100644
--- a/drivers/usb/typec/tps6598x_trace.h
+++ b/drivers/usb/typec/tps6598x_trace.h
@@ -134,6 +134,24 @@
 		      { TPS_STATUS_HIGH_VOLAGE_WARNING,	"HIGH_VOLAGE_WARNING" }, \
 		      { TPS_STATUS_HIGH_LOW_VOLTAGE_WARNING, "HIGH_LOW_VOLTAGE_WARNING" })
 
+#define show_power_status_source_sink(power_status) \
+	__print_symbolic(TPS_POWER_STATUS_SOURCESINK(power_status), \
+		{ 1, "sink" }, \
+		{ 0, "source" })
+
+#define show_power_status_typec_status(power_status) \
+	__print_symbolic(TPS_POWER_STATUS_PWROPMODE(power_status), \
+		{ TPS_POWER_STATUS_TYPEC_CURRENT_PD,  "pd" }, \
+		{ TPS_POWER_STATUS_TYPEC_CURRENT_3A0, "3.0A" }, \
+		{ TPS_POWER_STATUS_TYPEC_CURRENT_1A5, "1.5A" }, \
+		{ TPS_POWER_STATUS_TYPEC_CURRENT_USB, "usb" })
+
+#define show_power_status_bc12_status(power_status) \
+	__print_symbolic(TPS_POWER_STATUS_BC12_STATUS(power_status), \
+		{ TPS_POWER_STATUS_BC12_STATUS_DCP, "dcp" }, \
+		{ TPS_POWER_STATUS_BC12_STATUS_CDP, "cdp" }, \
+		{ TPS_POWER_STATUS_BC12_STATUS_SDP, "sdp" })
+
 TRACE_EVENT(tps6598x_irq,
 	    TP_PROTO(u64 event1,
 		     u64 event2),
@@ -181,6 +199,26 @@ TRACE_EVENT(tps6598x_status,
 		    )
 );
 
+TRACE_EVENT(tps6598x_power_status,
+	    TP_PROTO(u16 power_status),
+	    TP_ARGS(power_status),
+
+	    TP_STRUCT__entry(
+			     __field(u16, power_status)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->power_status = power_status;
+			   ),
+
+	    TP_printk("conn: %d, pwr-role: %s, typec: %s, bc: %s",
+		      !!TPS_POWER_STATUS_CONNECTION(__entry->power_status),
+		      show_power_status_source_sink(__entry->power_status),
+		      show_power_status_typec_status(__entry->power_status),
+		      show_power_status_bc12_status(__entry->power_status)
+		    )
+);
+
 #endif /* _TPS6598X_TRACE_H_ */
 
 /* This part must be outside protection */
-- 
2.30.0

