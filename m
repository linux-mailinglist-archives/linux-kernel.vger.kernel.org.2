Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B60357580
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355935AbhDGUHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349005AbhDGUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:07:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426FAC061762
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 13:07:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w7so25195806ybq.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F5lSKpfqBw4113tpCYKNPPPxEqSl+K7hf9S8zFY8ZXs=;
        b=lCW701kZ+JEJ/QW2JJ7dmnwWvYHYvYq3p293fsSpznlbDFxn+g9T42AqV5Uc52RFq7
         eoc096c1LrCMubBKdjr1HdE0QtPRZ0bDBqekh0sguvcOfi+ZQlrQ/dv1vpJyx87ePSYa
         HrdO8MhB6zvfbVvFOMzRf1bp7qsEIiXwah6TdtyMiy2N/eJQYzqS6waLSp9Xd+0wEzpV
         8FCEAdf6S2av/x7/CiekNRmGMMXpjO3lYYxUXb1Q2IciwIqT4bWFymH1XjrxpEf/XdI2
         6H6HezOZzaa6vvDTAAQ0kCgo+pod4+tPC73kaadi3qbS8TDLgsGHNq7y/EZThjQPk+Rn
         uNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F5lSKpfqBw4113tpCYKNPPPxEqSl+K7hf9S8zFY8ZXs=;
        b=QSHzd9Bd1lgixkNhIR86MjLXvg8UFZNzaGDE05nzWHwib1XtPLgP4we05pfURMIoUr
         C+FHIsFR/l3wLuh/Qduq4r5QDYqbT3L/bSEOX7P4xZ/7Jp4pl/MMwJRvL/h0ec05lVHs
         LpPIMxVy0vYThIXZqlffy9vV8aZH4gSUyvfHHYkxcw+kDE+Fx36v9kFd44YhX8E8ojkc
         y7Is9U9JEgDR+7LuyQR+2bF9nw+gnFGw9bzzwBcZx5UpJXuJzw7MuTlRugAVTSWKAbX9
         lr5tn8zD72jo04RmpS9bDMxi36T8idTwbl7gPbWx69V/S3RTsKs39TgY6ykDPJo6g3zD
         kTLA==
X-Gm-Message-State: AOAM530bOwRmshSR2gze+qoGa0F+QYNvNGz21A2AMQxsXzsfkTCvs1S3
        YFapkdPJTDRom8HUOai1xkqeCw51wJk=
X-Google-Smtp-Source: ABdhPJw7Z+2udZLoChZX3ovPF/SW6IygaBHAVtC5C86xTQc7ltYKC3rUFS9ATxJNIKreRNpTo3CdgqPi9d8=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:991:6d08:9e6d:683d])
 (user=badhri job=sendgmr) by 2002:a25:cad6:: with SMTP id a205mr3383973ybg.373.1617826053217;
 Wed, 07 Apr 2021 13:07:33 -0700 (PDT)
Date:   Wed,  7 Apr 2021 13:07:21 -0700
In-Reply-To: <20210407200723.1914388-1-badhri@google.com>
Message-Id: <20210407200723.1914388-4-badhri@google.com>
Mime-Version: 1.0
References: <20210407200723.1914388-1-badhri@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 4/6] usb: typec: tcpm: Honour pSnkStdby requirement during negotiation
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From PD Spec:
The Sink Shall transition to Sink Standby before a positive or
negative voltage transition of VBUS. During Sink Standby
the Sink Shall reduce its power draw to pSnkStdby. This allows
the Source to manage the voltage transition as well as
supply sufficient operating current to the Sink to maintain PD
operation during the transition. The Sink Shall
complete this transition to Sink Standby within tSnkStdby
after evaluating the Accept Message from the Source. The
transition when returning to Sink operation from Sink Standby
Shall be completed within tSnkNewPower. The
pSnkStdby requirement Shall only apply if the Sink power draw
is higher than this level.

The above requirement needs to be met to prevent hard resets
from port partner.

Without the patch: (5V/3A during SNK_DISCOVERY all the way through
explicit contract)
[   95.711984] CC1: 0 -> 0, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
[   95.712007] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[   95.712017] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
[   95.837190] VBUS on
[   95.882075] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170 ms]
[   95.882082] state change SNK_DEBOUNCED -> SNK_ATTACHED [rev3 NONE_AMS]
[   95.882086] polarity 1
[   95.883151] set_auto_vbus_discharge_threshold mode:0 pps_active:n vbus:5000 ret:0
[   95.883441] enable vbus discharge ret:0
[   95.883445] Requesting mux state 1, usb-role 2, orientation 2
[   95.883776] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
[   95.883879] pending state change SNK_STARTUP -> SNK_DISCOVERY @ 500 ms [rev3 NONE_AMS]
[   96.038960] VBUS on
[   96.383939] state change SNK_STARTUP -> SNK_DISCOVERY [delayed 500 ms]
[   96.383946] Setting voltage/current limit 5000 mV 3000 mA
[   96.383961] vbus=0 charge:=1
[   96.386044] state change SNK_DISCOVERY -> SNK_WAIT_CAPABILITIES [rev3 NONE_AMS]
[   96.386309] pending state change SNK_WAIT_CAPABILITIES -> HARD_RESET_SEND @ 450 ms [rev3 NONE_AMS]
[   96.394404] PD RX, header: 0x2161 [1]
[   96.394408]  PDO 0: type 0, 5000 mV, 3000 mA [E]
[   96.394410]  PDO 1: type 0, 9000 mV, 2000 mA []
[   96.394412] state change SNK_WAIT_CAPABILITIES -> SNK_NEGOTIATE_CAPABILITIES [rev2 POWER_NEGOTIATION]
[   96.394416] Setting usb_comm capable false
[   96.395083] cc=0 cc1=0 cc2=5 vbus=0 vconn=sink polarity=1
[   96.395089] Requesting PDO 1: 9000 mV, 2000 mA
[   96.395093] PD TX, header: 0x1042
[   96.397404] PD TX complete, status: 0
[   96.397424] pending state change SNK_NEGOTIATE_CAPABILITIES -> HARD_RESET_SEND @ 60 ms [rev2 POWER_NEGOTIATION]
[   96.400826] PD RX, header: 0x363 [1]
[   96.400829] state change SNK_NEGOTIATE_CAPABILITIES -> SNK_TRANSITION_SINK [rev2 POWER_NEGOTIATION]
[   96.400832] pending state change SNK_TRANSITION_SINK -> HARD_RESET_SEND @ 500 ms [rev2 POWER_NEGOTIATION]
[   96.577315] PD RX, header: 0x566 [1]
[   96.577321] Setting voltage/current limit 9000 mV 2000 mA
[   96.578363] set_auto_vbus_discharge_threshold mode:3 pps_active:n vbus:9000 ret:0
[   96.578370] state change SNK_TRANSITION_SINK -> SNK_READY [rev2 POWER_NEGOTIATION]

With the patch:
[  168.398573] CC1: 0 -> 0, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
[  168.398605] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[  168.398619] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
[  168.522348] VBUS on
[  168.568676] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170 ms]
[  168.568684] state change SNK_DEBOUNCED -> SNK_ATTACHED [rev3 NONE_AMS]
[  168.568688] polarity 1
[  168.569867] set_auto_vbus_discharge_threshold mode:0 pps_active:n vbus:5000 ret:0
[  168.570158] enable vbus discharge ret:0
[  168.570161] Requesting mux state 1, usb-role 2, orientation 2
[  168.570504] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
[  168.570634] pending state change SNK_STARTUP -> SNK_DISCOVERY @ 500 ms [rev3 NONE_AMS]
[  169.070689] state change SNK_STARTUP -> SNK_DISCOVERY [delayed 500 ms]
[  169.070695] Setting voltage/current limit 5000 mV 3000 mA
[  169.070702] vbus=0 charge:=1
[  169.072719] state change SNK_DISCOVERY -> SNK_WAIT_CAPABILITIES [rev3 NONE_AMS]
[  169.073145] pending state change SNK_WAIT_CAPABILITIES -> HARD_RESET_SEND @ 450 ms [rev3 NONE_AMS]
[  169.077162] PD RX, header: 0x2161 [1]
[  169.077172]  PDO 0: type 0, 5000 mV, 3000 mA [E]
[  169.077178]  PDO 1: type 0, 9000 mV, 2000 mA []
[  169.077183] state change SNK_WAIT_CAPABILITIES -> SNK_NEGOTIATE_CAPABILITIES [rev2 POWER_NEGOTIATION]
[  169.077191] Setting usb_comm capable false
[  169.077753] cc=0 cc1=0 cc2=5 vbus=0 vconn=sink polarity=1
[  169.077759] Requesting PDO 1: 9000 mV, 2000 mA
[  169.077762] PD TX, header: 0x1042
[  169.079990] PD TX complete, status: 0
[  169.080013] pending state change SNK_NEGOTIATE_CAPABILITIES -> HARD_RESET_SEND @ 60 ms [rev2 POWER_NEGOTIATION]
[  169.083183] VBUS on
[  169.084195] PD RX, header: 0x363 [1]
[  169.084200] state change SNK_NEGOTIATE_CAPABILITIES -> SNK_TRANSITION_SINK [rev2 POWER_NEGOTIATION]
[  169.084206] Setting standby current 5000 mV @ 500 mA
[  169.084209] Setting voltage/current limit 5000 mV 500 mA
[  169.084220] pending state change SNK_TRANSITION_SINK -> HARD_RESET_SEND @ 500 ms [rev2 POWER_NEGOTIATION]
[  169.260222] PD RX, header: 0x566 [1]
[  169.260227] Setting voltage/current limit 9000 mV 2000 mA
[  169.261315] set_auto_vbus_discharge_threshold mode:3 pps_active:n vbus:9000 ret:0
[  169.261321] state change SNK_TRANSITION_SINK -> SNK_READY [rev2 POWER_NEGOTIATION]
[  169.261570] AMS POWER_NEGOTIATION finished

Fixes: f0690a25a140b ("staging: typec: USB Type-C Port Manager (tcpm)")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 17 +++++++++++++++++
 include/linux/usb/pd.h        |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d1d03ee90d8f..770b2edd9a04 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4131,6 +4131,23 @@ static void run_state_machine(struct tcpm_port *port)
 		}
 		break;
 	case SNK_TRANSITION_SINK:
+		/* From the USB PD spec:
+		 * "The Sink Shall transition to Sink Standby before a positive or
+		 * negative voltage transition of VBUS. During Sink Standby
+		 * the Sink Shall reduce its power draw to pSnkStdby."
+		 *
+		 * This is not applicable to PPS though as the port can continue
+		 * to draw negotiated power without switching to standby.
+		 */
+		if (port->supply_voltage != port->req_supply_voltage && !port->pps_data.active &&
+		    port->current_limit * port->supply_voltage / 1000 > PD_P_SNK_STDBY_MW) {
+			u32 stdby_ma = port->supply_voltage ? PD_P_SNK_STDBY_MW * 1000 /
+				port->supply_voltage : 0;
+			tcpm_log(port, "Setting standby current %u mV @ %u mA",
+				 port->supply_voltage, stdby_ma);
+			tcpm_set_current_limit(port, stdby_ma, port->supply_voltage);
+		}
+		fallthrough;
 	case SNK_TRANSITION_SINK_VBUS:
 		tcpm_set_state(port, hard_reset_state(port),
 			       PD_T_PS_TRANSITION);
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 70d681918d01..bf00259493e0 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -493,4 +493,6 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
 #define PD_N_HARD_RESET_COUNT	2
 
+#define PD_P_SNK_STDBY_MW	2500	/* 2500 mW */
+
 #endif /* __LINUX_USB_PD_H */
-- 
2.31.1.295.g9ea45b61b8-goog

