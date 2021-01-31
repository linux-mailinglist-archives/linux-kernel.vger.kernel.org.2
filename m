Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA24309D70
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhAaPVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 10:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbhAaPU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 10:20:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F5CC061788
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 07:19:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k141so9695330ybf.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 07:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qX9TFL5pIpPoWo/HGV4oNiHmIMjUwG4ZE2jdefwiMwM=;
        b=Vx1zY9P0dVrqyzqgZihiLszelAOkrHjyxfxQb0oc+/C3oXuBNnj/SEuql3owDFdtbZ
         QALJqJoKeyHOp2A4ROFmXNTpIDa4L8jBczSeu9ansiAi848wFbNghIeP1mkJqLwe/Tg3
         vfk7UQAGGcZtYgmHgt8QYcyM78RHgHFuUtMgQFmfnyquWl28C+XX8zfx+RZg3hkRibbe
         tIJVg2MUJEZd3EED3emkXVUNks1k20lWB2sVg45RiSnHcE6oKF+kDQlPgHZbbUPzgoa2
         jMltXiwRuHlUGm+2xtxzrTnmPqEzPKdfYFYYHEdNrI3o2th1USzC4JFPA3DD6x3Se5g3
         lARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qX9TFL5pIpPoWo/HGV4oNiHmIMjUwG4ZE2jdefwiMwM=;
        b=hFRmbGuLws/4eXu4+RDAvSjiTTKNJsFgihaB2+sKEhYBGCu/9+0q9DDut3mJVZNKGG
         M+kTdsQ2jlk3vVLqMgIQpRSHnBBCb0wCvEqaEK/8XakSInNT2gg6qHNvwau58jCsrF2a
         iObN7JEylIWB/1h8Mp1JSUAnMc8j1/PRJLhgNWxXP+5ydI5UJIum6Sq18FQZnvmygen8
         W3su1b/CSKlcX5mWGaNSzB8R7Z0Dis3UT0BnJxflp6R7FGJUbBms+UlAqIZI5EkRcOLM
         +88rypS0OEO5ii7JHfj+M0qVnUqMRV/Zc2ThnC495JJsLFkLF3zlu01LEJjmZv3tvkCY
         38qg==
X-Gm-Message-State: AOAM530tdaN5QpAHZtl2YywdBxoTrG+RvfVLlVBiHtOPc04MhNJQuggU
        fZbEq/vEB9Z+g2l5OpiEtTIo+r+yrcqM
X-Google-Smtp-Source: ABdhPJxy5+HgOWndan89vJ1/6VTZBdccj8htulz6Yz9Qm18KBAi3QE2sCrryEzFAML+IDrauQtSS1ijoHOLI
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:5d70:9e45:7deb:72a7])
 (user=kyletso job=sendgmr) by 2002:a25:ce8e:: with SMTP id
 x136mr19337619ybe.173.1612106342886; Sun, 31 Jan 2021 07:19:02 -0800 (PST)
Date:   Sun, 31 Jan 2021 23:18:31 +0800
In-Reply-To: <20210131151832.215931-1-kyletso@google.com>
Message-Id: <20210131151832.215931-3-kyletso@google.com>
Mime-Version: 1.0
References: <20210131151832.215931-1-kyletso@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 2/3] dt-bindings: connector: Add SVDM VDO properties
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

Add bindings of VDO properties of USB PD SVDM so that they can be
used in device tree.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changes since v1:
dt-bindings: connector: Add SVDM VDO properties
- updated the dt-bindings documentations
- added more definitions of Product Type VDOs

 .../bindings/connector/usb-connector.yaml     |  11 +
 include/dt-bindings/usb/pd.h                  | 311 +++++++++++++++++-
 2 files changed, 321 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 4286ed767a0a..d385026944ec 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -137,6 +137,17 @@ properties:
     maxItems: 7
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
+  sink-vdos:
+    description: An array of u32 with each entry (VDM Objects) providing additional information
+      corresponding to the product, the detailed bit definitions and the order of each VDO can be
+      found in "USB Power Delivery Specification Revision 3.0, Version 2.0 + ECNs 2020-12-10"
+      chapter 6.4.4.3.1 Discover Identity. User can specify the VDO array via
+      VDO_IDH/_CERT/_PRODUCT/_UFP/_DFP/_PCABLE/_ACABLE(1/2)/_VPD() defined in
+      dt-bindings/usb/pd.h.
+    minItems: 3
+    maxItems: 6
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
   op-sink-microwatt:
     description: Sink required operating power in microwatt, if source can't
       offer the power, Capability Mismatch is set. Required for power sink and
diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
index 0352893697f0..fef3ef65967f 100644
--- a/include/dt-bindings/usb/pd.h
+++ b/include/dt-bindings/usb/pd.h
@@ -93,4 +93,313 @@
 #define FRS_DEFAULT_POWER      1
 #define FRS_5V_1P5A            2
 #define FRS_5V_3A              3
- #endif /* __DT_POWER_DELIVERY_H */
+
+/*
+ * SVDM Identity Header
+ * --------------------
+ * <31>     :: data capable as a USB host
+ * <30>     :: data capable as a USB device
+ * <29:27>  :: product type (UFP / Cable / VPD)
+ * <26>     :: modal operation supported (1b == yes)
+ * <25:23>  :: product type (DFP) (SVDM version 2.0+ only; set to zero in version 1.0)
+ * <22:21>  :: connector type (SVDM version 2.0+ only; set to zero in version 1.0)
+ * <20:16>  :: Reserved, Shall be set to zero
+ * <15:0>   :: USB-IF assigned VID for this cable vendor
+ */
+/* SOP Product Type (UFP) */
+#define IDH_PTYPE_NOT_UFP       0
+#define IDH_PTYPE_HUB           1
+#define IDH_PTYPE_PERIPH        2
+#define IDH_PTYPE_PSD           3
+#define IDH_PTYPE_AMA           5
+
+/* SOP' Product Type (Cable Plug / VPD) */
+#define IDH_PTYPE_NOT_CABLE     0
+#define IDH_PTYPE_PCABLE        3
+#define IDH_PTYPE_ACABLE        4
+#define IDH_PTYPE_VPD           6
+
+/* SOP Product Type (DFP) */
+#define IDH_PTYPE_NOT_DFP       0
+#define IDH_PTYPE_DFP_HUB       1
+#define IDH_PTYPE_DFP_HOST      2
+#define IDH_PTYPE_DFP_PB        3
+
+#define VDO_IDH(usbh, usbd, ufp_cable, is_modal, dfp, conn, vid)                \
+	((usbh) << 31 | (usbd) << 30 | ((ufp_cable) & 0x7) << 27                \
+	 | (is_modal) << 26 | ((dfp) & 0x7) << 23 | ((conn) & 0x3) << 21        \
+	 | ((vid) & 0xffff))
+
+/*
+ * Cert Stat VDO
+ * -------------
+ * <31:0>  : USB-IF assigned XID for this cable
+ */
+#define VDO_CERT(xid)		((xid) & 0xffffffff)
+
+/*
+ * Product VDO
+ * -----------
+ * <31:16> : USB Product ID
+ * <15:0>  : USB bcdDevice
+ */
+#define VDO_PRODUCT(pid, bcd)   (((pid) & 0xffff) << 16 | ((bcd) & 0xffff))
+
+/*
+ * UFP VDO (PD Revision 3.0+ only)
+ * --------
+ * <31:29> :: UFP VDO version
+ * <28>    :: Reserved
+ * <27:24> :: Device capability
+ * <23:22> :: Connector type (10b == receptacle, 11b == captive plug)
+ * <21:11> :: Reserved
+ * <10:8>  :: Vconn power (AMA only)
+ * <7>     :: Vconn required (AMA only, 0b == no, 1b == yes)
+ * <6>     :: Vbus required (AMA only, 0b == yes, 1b == no)
+ * <5:3>   :: Alternate modes
+ * <2:0>   :: USB highest speed
+ */
+/* UFP VDO Version */
+#define UFP_VDO_VER1_2		2
+
+/* Device Capability */
+#define DEV_USB2_CAPABLE	BIT(0)
+#define DEV_USB2_BILLBOARD	BIT(1)
+#define DEV_USB3_CAPABLE	BIT(2)
+#define DEV_USB4_CAPABLE	BIT(3)
+
+/* Connector Type */
+#define UFP_RECEPTACLE		2
+#define UFP_CAPTIVE		3
+
+/* Vconn Power (AMA only, set to AMA_VCONN_NOT_REQ if Vconn is not required) */
+#define AMA_VCONN_PWR_1W	0
+#define AMA_VCONN_PWR_1W5	1
+#define AMA_VCONN_PWR_2W	2
+#define AMA_VCONN_PWR_3W	3
+#define AMA_VCONN_PWR_4W	4
+#define AMA_VCONN_PWR_5W	5
+#define AMA_VCONN_PWR_6W	6
+
+/* Vconn Required (AMA only) */
+#define AMA_VCONN_NOT_REQ	0
+#define AMA_VCONN_REQ		1
+
+/* Vbus Required (AMA only) */
+#define AMA_VBUS_REQ		0
+#define AMA_VBUS_NOT_REQ	1
+
+/* Alternate Modes */
+#define UFP_ALTMODE_NOT_SUPP	0
+#define UFP_ALTMODE_TBT3	BIT(0)
+#define UFP_ALTMODE_RECFG	BIT(1)
+#define UFP_ALTMODE_NO_RECFG	BIT(2)
+
+/* USB Highest Speed */
+#define UFP_USB2_ONLY		0
+#define UFP_USB32_GEN1		1
+#define UFP_USB32_4_GEN2	2
+#define UFP_USB4_GEN3		3
+
+#define VDO_UFP(ver, cap, conn, vcpwr, vcr, vbr, alt, spd)			\
+	(((ver) & 0x7) << 29 | ((cap) & 0xf) << 24 | ((conn) & 0x3) << 22	\
+	 | ((vcpwr) & 0x7) << 8 | (vcr) << 7 | (vbr) << 6 | ((alt) & 0x7) << 3	\
+	 | ((spd) & 0x7))
+
+/*
+ * DFP VDO (PD Revision 3.0+ only)
+ * --------
+ * <31:29> :: DFP VDO version
+ * <28:27> :: Reserved
+ * <26:24> :: Host capability
+ * <23:22> :: Connector type (10b == receptacle, 11b == captive plug)
+ * <21:5>  :: Reserved
+ * <4:0>   :: Port number
+ */
+#define DFP_VDO_VER1_1		1
+#define HOST_USB2_CAPABLE	BIT(0)
+#define HOST_USB3_CAPABLE	BIT(1)
+#define HOST_USB4_CAPABLE	BIT(2)
+#define DFP_RECEPTACLE		2
+#define DFP_CAPTIVE		3
+
+#define VDO_DFP(ver, cap, conn, pnum)						\
+	(((ver) & 0x7) << 29 | ((cap) & 0x7) << 24 | ((conn) & 0x3) << 22	\
+	 | ((pnum) & 0x1f))
+
+/*
+ * Passive Cable VDO
+ * ---------
+ * <31:28> :: Cable HW version
+ * <27:24> :: Cable FW version
+ * <23:21> :: VDO version
+ * <20>    :: Reserved, Shall be set to zero
+ * <19:18> :: Type-C to Type-C/Captive (10b == C, 11b == Captive)
+ * <17>    :: Reserved, Shall be set to zero
+ * <16:13> :: cable latency (0001 == <10ns(~1m length))
+ * <12:11> :: cable termination type (10b == Vconn not req, 01b == Vconn req)
+ * <10:9>  :: Maximum Vbus voltage (00b == 20V, 01b == 30V, 10b == 40V, 11b == 50V)
+ * <8:7>   :: Reserved, Shall be set to zero
+ * <6:5>   :: Vbus current handling capability (01b == 3A, 10b == 5A)
+ * <4:3>   :: Reserved, Shall be set to zero
+ * <2:0>   :: USB highest speed
+ *
+ * Active Cable VDO 1
+ * ---------
+ * <31:28> :: Cable HW version
+ * <27:24> :: Cable FW version
+ * <23:21> :: VDO version
+ * <20>    :: Reserved, Shall be set to zero
+ * <19:18> :: Connector type (10b == C, 11b == Captive)
+ * <17>    :: Reserved, Shall be set to zero
+ * <16:13> :: cable latency (0001 == <10ns(~1m length))
+ * <12:11> :: cable termination type (10b == one end active, 11b == both ends active VCONN req)
+ * <10:9>  :: Maximum Vbus voltage (00b == 20V, 01b == 30V, 10b == 40V, 11b == 50V)
+ * <8>     :: SBU supported (0b == supported, 1b == not supported)
+ * <7>     :: SBU type (0b == passive, 1b == active)
+ * <6:5>   :: Vbus current handling capability (01b == 3A, 10b == 5A)
+ * <4>     :: Vbus through cable (0b == no, 1b == yes)
+ * <3>     :: SOP" controller present? (0b == no, 1b == yes)
+ * <2:0>   :: USB highest speed
+ */
+/* Cable VDO Version */
+#define CABLE_VDO_VER1_0	0
+#define CABLE_VDO_VER1_3	3
+
+/* Connector Type */
+#define CABLE_CTYPE		2
+#define CABLE_CAPTIVE		3
+
+/* Cable Latency */
+#define CABLE_LATENCY_1M	1
+#define CABLE_LATENCY_2M	2
+#define CABLE_LATENCY_3M	3
+#define CABLE_LATENCY_4M	4
+#define CABLE_LATENCY_5M	5
+#define CABLE_LATENCY_6M	6
+#define CABLE_LATENCY_7M	7
+#define CABLE_LATENCY_7M_PLUS	8
+
+/* Cable Termination Type */
+#define PCABLE_VCONN_NOT_REQ	0
+#define PCABLE_VCONN_REQ	1
+#define ACABLE_ONE_END		2
+#define ACABLE_BOTH_END		3
+
+/* Maximum Vbus Voltage */
+#define CABLE_MAX_VBUS_20V	0
+#define CABLE_MAX_VBUS_30V	1
+#define CABLE_MAX_VBUS_40V	2
+#define CABLE_MAX_VBUS_50V	3
+
+/* Active Cable SBU Supported/Type */
+#define ACABLE_SBU_SUPP		0
+#define ACABLE_SBU_NOT_SUPP	1
+#define ACABLE_SBU_PASSIVE	0
+#define ACABLE_SBU_ACTIVE	1
+
+/* Vbus Current Handling Capability */
+#define CABLE_CURR_DEF		0
+#define CABLE_CURR_3A		1
+#define CABLE_CURR_5A		2
+
+/* USB Highest Speed */
+#define CABLE_USB2_ONLY		0
+#define CABLE_USB32_GEN1	1
+#define CABLE_USB32_4_GEN2	2
+#define CABLE_USB4_GEN3		3
+
+#define VDO_PCABLE(hw, fw, ver, conn, lat, term, vbm, cur, spd)			\
+	(((hw) & 0xf) << 28 | ((fw) & 0xf) << 24 | ((ver) & 0x7) << 21		\
+	 | ((conn) & 0x3) << 18 | ((lat) & 0xf) << 13 | ((term) & 0x3) << 11	\
+	 | ((vbm) & 0x3) << 9 | ((cur) & 0x3) << 5 | ((spd) & 0x7))
+#define VDO_ACABLE1(hw, fw, ver, conn, lat, term, vbm, sbu, sbut, cur, vbt, sopp, spd) \
+	(((hw) & 0xf) << 28 | ((fw) & 0xf) << 24 | ((ver) & 0x7) << 21		\
+	 | ((conn) & 0x3) << 18	| ((lat) & 0xf) << 13 | ((term) & 0x3) << 11	\
+	 | ((vbm) & 0x3) << 9 | (sbu) << 8 | (sbut) << 7 | ((cur) & 0x3) << 5	\
+	 | (vbt) << 4 | (sopp) << 3 | ((spd) & 0x7))
+
+/*
+ * Active Cable VDO 2
+ * ---------
+ * <31:24> :: Maximum operating temperature
+ * <23:16> :: Shutdown temperature
+ * <15>    :: Reserved, Shall be set to zero
+ * <14:12> :: U3/CLd power
+ * <11>    :: U3 to U0 transition mode (0b == direct, 1b == through U3S)
+ * <10>    :: Physical connection (0b == copper, 1b == optical)
+ * <9>     :: Active element (0b == redriver, 1b == retimer)
+ * <8>     :: USB4 supported (0b == yes, 1b == no)
+ * <7:6>   :: USB2 hub hops consumed
+ * <5>     :: USB2 supported (0b == yes, 1b == no)
+ * <4>     :: USB3.2 supported (0b == yes, 1b == no)
+ * <3>     :: USB lanes supported (0b == one lane, 1b == two lanes)
+ * <2>     :: Optically isolated active cable (0b == no, 1b == yes)
+ * <1>     :: Reserved, Shall be set to zero
+ * <0>     :: USB gen (0b == gen1, 1b == gen2+)
+ */
+/* U3/CLd Power*/
+#define ACAB2_U3_CLD_10MW_PLUS	0
+#define ACAB2_U3_CLD_10MW	1
+#define ACAB2_U3_CLD_5MW	2
+#define ACAB2_U3_CLD_1MW	3
+#define ACAB2_U3_CLD_500UW	4
+#define ACAB2_U3_CLD_200UW	5
+#define ACAB2_U3_CLD_50UW	6
+
+/* Other Active Cable VDO 2 Fields */
+#define ACAB2_U3U0_DIRECT	0
+#define ACAB2_U3U0_U3S		1
+#define ACAB2_PHY_COPPER	0
+#define ACAB2_PHY_OPTICAL	1
+#define ACAB2_REDRIVER		0
+#define ACAB2_RETIMER		1
+#define ACAB2_USB4_SUPP		0
+#define ACAB2_USB4_NOT_SUPP	1
+#define ACAB2_USB2_SUPP		0
+#define ACAB2_USB2_NOT_SUPP	1
+#define ACAB2_USB32_SUPP	0
+#define ACAB2_USB32_NOT_SUPP	1
+#define ACAB2_LANES_ONE		0
+#define ACAB2_LANES_TWO		1
+#define ACAB2_OPT_ISO_NO	0
+#define ACAB2_OPT_ISO_YES	1
+#define ACAB2_GEN_1		0
+#define ACAB2_GEN_2_PLUS	1
+
+#define VDO_ACABLE2(mtemp, stemp, u3p, trans, phy, ele, u4, hops, u2, u32, lane, iso, gen)	\
+	(((mtemp) & 0xff) << 24 | ((stemp) & 0xff) << 16 | ((u3p) & 0x7) << 12	\
+	 | (trans) << 11 | (phy) << 10 | (ele) << 9 | (u4) << 8			\
+	 | ((hops) & 0x3) << 6 | (u2) << 5 | (u32) << 4 | (lane) << 3		\
+	 | (iso) << 2 | (gen))
+
+/*
+ * VPD VDO
+ * ---------
+ * <31:28> :: HW version
+ * <27:24> :: FW version
+ * <23:21> :: VDO version
+ * <20:17> :: Reserved, Shall be set to zero
+ * <16:15> :: Maximum Vbus voltage (00b == 20V, 01b == 30V, 10b == 40V, 11b == 50V)
+ * <14>    :: Charge through current support (0b == 3A, 1b == 5A)
+ * <13>    :: Reserved, Shall be set to zero
+ * <12:7>  :: Vbus impedance
+ * <6:1>   :: Ground impedance
+ * <0>     :: Charge through support (0b == no, 1b == yes)
+ */
+#define VPD_VDO_VER1_0		0
+#define VPD_MAX_VBUS_20V	0
+#define VPD_MAX_VBUS_30V	1
+#define VPD_MAX_VBUS_40V	2
+#define VPD_MAX_VBUS_50V	3
+#define VPDCT_CURR_3A		0
+#define VPDCT_CURR_5A		1
+#define VPDCT_NOT_SUPP		0
+#define VPDCT_SUPP		1
+
+#define VDO_VPD(hw, fw, ver, vbm, curr, vbi, gi, ct)			\
+	(((hw) & 0xf) << 28 | ((fw) & 0xf) << 24 | ((ver) & 0x7) << 21	\
+	 | ((vbm) & 0x3) << 15 | (curr) << 14 | ((vbi) & 0x3f) << 7	\
+	 | ((gi) & 0x3f) << 1 | (ct))
+
+#endif /* __DT_POWER_DELIVERY_H */
-- 
2.30.0.365.g02bc693789-goog

