Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5F33929CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhE0Iql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbhE0Iq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:46:28 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A10C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:44:54 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s5-20020aa78d450000b02902ace63a7e93so29812pfe.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hWuYlcm+G88I6W6ZPGMYy1rv3ZPflGwOGWbdhraiZfw=;
        b=BeEXzIMLWyyubqRMQSd15E1pcWUNkuTOPtLuKiYOTQgFdA0zfnGbboJL/8cmsIgi00
         19iffh0eS7gxKW4Nj3bu2L9aDkNTm6Y4+WGsYm9TYdXNBOcRGctBHLwCBvXFnz8kLLJW
         +J5V1oXppObeg+6CA4hfE5EulOxRaJEUt5faGVttw8cWT9a0AVPpMVu3pIuOZxN8OBNS
         3m++sFhZG1mofeTyrQ9OQAr1+75ZBvMK0TrkV4cS/Gz/nqty/cQ0Od6R5emnfhdws3Q3
         hnX3UT2z5WYw/0fl0uOpOvV/V7+/hML4xgr7Ofm1nJiie+vI3nMopwoq4kyxkrt5S8iL
         KCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hWuYlcm+G88I6W6ZPGMYy1rv3ZPflGwOGWbdhraiZfw=;
        b=lL4FT47Gyo8WwlUTABPmMFAh2r9mpja+5Lv7EnnIhIkVQxX5muU/0dMlMCUslrlOgG
         EEYEGMN/V4nOmX8bMQffJjhgBd+e4v8R4xvSe5YKZ/P3lnGHjGYbOyU3B4VWk0qk6cWT
         1de9SmUgQfWMjJtq/ydbW++Sbr1BaaQHehjEaqv/9N4s9cACP7sFVWujiqrvJu0FkSxY
         u7nAx3wOAJgQWCHJAnLPDvi+XTcv5n/F2EvR+xeuAVMoKSFXkQw5zNcT8CzHW/ZH95IJ
         Zd1B+SqKXeBoRP29PjaN6dUwmnUURii/atBDKJ9GUh0YfeqPRijzDoTdRHC2xA+ckyez
         vkzQ==
X-Gm-Message-State: AOAM531NjhpymEnie0V7Ked+DDG4NCjq02SGjVt5bTFSaklw3XBoS27V
        eS+MuBsjFS6/6qKgTPR4IZOdcDQN0i1K
X-Google-Smtp-Source: ABdhPJwWqd2c/SeCjB5kXo6UfnqbusgfeLv1co24ChSKQXJwh1dyMBtRueGKRsvEOW5usgRPbx/hAB9DXaiu
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:c563:7257:f641:cbcd])
 (user=kyletso job=sendgmr) by 2002:aa7:8c0b:0:b029:2e7:d663:f3e6 with SMTP id
 c11-20020aa78c0b0000b02902e7d663f3e6mr2667962pfd.79.1622105094041; Thu, 27
 May 2021 01:44:54 -0700 (PDT)
Date:   Thu, 27 May 2021 16:44:18 +0800
In-Reply-To: <20210527084419.4164369-1-kyletso@google.com>
Message-Id: <20210527084419.4164369-3-kyletso@google.com>
Mime-Version: 1.0
References: <20210527084419.4164369-1-kyletso@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 2/3] dt-bindings: connector: Add PD rev 2.0 VDO definition
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the VDO definition for USB PD rev 2.0 in the bindings and define a
new property snk-vdos-v1 containing legacy VDOs as the responses to the
port partner which only supports PD rev 2.0.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 .../bindings/connector/usb-connector.yaml     | 15 ++++
 include/dt-bindings/usb/pd.h                  | 69 ++++++++++++++++++-
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 32509b98142e..92b49bc37939 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -149,6 +149,17 @@ properties:
     maxItems: 6
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
+  sink-vdos-v1:
+    description: An array of u32 with each entry, a Vendor Defined Message Object (VDO),
+      providing additional information corresponding to the product, the detailed bit
+      definitions and the order of each VDO can be found in
+      "USB Power Delivery Specification Revision 2.0, Version 1.3" chapter 6.4.4.3.1 Discover
+      Identity. User can specify the VDO array via VDO_IDH/_CERT/_PRODUCT/_CABLE/_AMA defined in
+      dt-bindings/usb/pd.h.
+    minItems: 3
+    maxItems: 6
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
   op-sink-microwatt:
     description: Sink required operating power in microwatt, if source can't
       offer the power, Capability Mismatch is set. Required for power sink and
@@ -207,6 +218,10 @@ properties:
       SNK_READY for non-pd link.
     type: boolean
 
+dependencies:
+  sink-vdos-v1: [ 'sink-vdos' ]
+  sink-vdos: [ 'sink-vdos-v1' ]
+
 required:
   - compatible
 
diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
index fef3ef65967f..9e47f9673405 100644
--- a/include/dt-bindings/usb/pd.h
+++ b/include/dt-bindings/usb/pd.h
@@ -106,6 +106,10 @@
  * <20:16>  :: Reserved, Shall be set to zero
  * <15:0>   :: USB-IF assigned VID for this cable vendor
  */
+
+/* PD Rev2.0 definition */
+#define IDH_PTYPE_UNDEF		0
+
 /* SOP Product Type (UFP) */
 #define IDH_PTYPE_NOT_UFP       0
 #define IDH_PTYPE_HUB           1
@@ -228,7 +232,25 @@
 	 | ((pnum) & 0x1f))
 
 /*
- * Passive Cable VDO
+ * Cable VDO (for both Passive and Active Cable VDO in PD Rev2.0)
+ * ---------
+ * <31:28> :: Cable HW version
+ * <27:24> :: Cable FW version
+ * <23:20> :: Reserved, Shall be set to zero
+ * <19:18> :: type-C to Type-A/B/C/Captive (00b == A, 01 == B, 10 == C, 11 == Captive)
+ * <17>    :: Reserved, Shall be set to zero
+ * <16:13> :: cable latency (0001 == <10ns(~1m length))
+ * <12:11> :: cable termination type (11b == both ends active VCONN req)
+ * <10>    :: SSTX1 Directionality support (0b == fixed, 1b == cfgable)
+ * <9>     :: SSTX2 Directionality support
+ * <8>     :: SSRX1 Directionality support
+ * <7>     :: SSRX2 Directionality support
+ * <6:5>   :: Vbus current handling capability (01b == 3A, 10b == 5A)
+ * <4>     :: Vbus through cable (0b == no, 1b == yes)
+ * <3>     :: SOP" controller present? (0b == no, 1b == yes)
+ * <2:0>   :: USB SS Signaling support
+ *
+ * Passive Cable VDO (PD Rev3.0+)
  * ---------
  * <31:28> :: Cable HW version
  * <27:24> :: Cable FW version
@@ -244,7 +266,7 @@
  * <4:3>   :: Reserved, Shall be set to zero
  * <2:0>   :: USB highest speed
  *
- * Active Cable VDO 1
+ * Active Cable VDO 1 (PD Rev3.0+)
  * ---------
  * <31:28> :: Cable HW version
  * <27:24> :: Cable FW version
@@ -266,7 +288,9 @@
 #define CABLE_VDO_VER1_0	0
 #define CABLE_VDO_VER1_3	3
 
-/* Connector Type */
+/* Connector Type (_ATYPE and _BTYPE are for PD Rev2.0 only) */
+#define CABLE_ATYPE		0
+#define CABLE_BTYPE		1
 #define CABLE_CTYPE		2
 #define CABLE_CAPTIVE		3
 
@@ -303,12 +327,22 @@
 #define CABLE_CURR_3A		1
 #define CABLE_CURR_5A		2
 
+/* USB SuperSpeed Signaling Support (PD Rev2.0) */
+#define CABLE_USBSS_U2_ONLY	0
+#define CABLE_USBSS_U31_GEN1	1
+#define CABLE_USBSS_U31_GEN2	2
+
 /* USB Highest Speed */
 #define CABLE_USB2_ONLY		0
 #define CABLE_USB32_GEN1	1
 #define CABLE_USB32_4_GEN2	2
 #define CABLE_USB4_GEN3		3
 
+#define VDO_CABLE(hw, fw, cbl, lat, term, tx1d, tx2d, rx1d, rx2d, cur, vps, sopp, usbss) \
+	(((hw) & 0x7) << 28 | ((fw) & 0x7) << 24 | ((cbl) & 0x3) << 18		\
+	 | ((lat) & 0x7) << 13 | ((term) & 0x3) << 11 | (tx1d) << 10		\
+	 | (tx2d) << 9 | (rx1d) << 8 | (rx2d) << 7 | ((cur) & 0x3) << 5		\
+	 | (vps) << 4 | (sopp) << 3 | ((usbss) & 0x7))
 #define VDO_PCABLE(hw, fw, ver, conn, lat, term, vbm, cur, spd)			\
 	(((hw) & 0xf) << 28 | ((fw) & 0xf) << 24 | ((ver) & 0x7) << 21		\
 	 | ((conn) & 0x3) << 18 | ((lat) & 0xf) << 13 | ((term) & 0x3) << 11	\
@@ -373,6 +407,35 @@
 	 | ((hops) & 0x3) << 6 | (u2) << 5 | (u32) << 4 | (lane) << 3		\
 	 | (iso) << 2 | (gen))
 
+/*
+ * AMA VDO (PD Rev2.0)
+ * ---------
+ * <31:28> :: Cable HW version
+ * <27:24> :: Cable FW version
+ * <23:12> :: Reserved, Shall be set to zero
+ * <11>    :: SSTX1 Directionality support (0b == fixed, 1b == cfgable)
+ * <10>    :: SSTX2 Directionality support
+ * <9>     :: SSRX1 Directionality support
+ * <8>     :: SSRX2 Directionality support
+ * <7:5>   :: Vconn power
+ * <4>     :: Vconn power required
+ * <3>     :: Vbus power required
+ * <2:0>   :: USB SS Signaling support
+ */
+#define VDO_AMA(hw, fw, tx1d, tx2d, rx1d, rx2d, vcpwr, vcr, vbr, usbss) \
+	(((hw) & 0x7) << 28 | ((fw) & 0x7) << 24			\
+	 | (tx1d) << 11 | (tx2d) << 10 | (rx1d) << 9 | (rx2d) << 8	\
+	 | ((vcpwr) & 0x7) << 5 | (vcr) << 4 | (vbr) << 3		\
+	 | ((usbss) & 0x7))
+
+#define PD_VDO_AMA_VCONN_REQ(vdo)	(((vdo) >> 4) & 1)
+#define PD_VDO_AMA_VBUS_REQ(vdo)	(((vdo) >> 3) & 1)
+
+#define AMA_USBSS_U2_ONLY	0
+#define AMA_USBSS_U31_GEN1	1
+#define AMA_USBSS_U31_GEN2	2
+#define AMA_USBSS_BBONLY	3
+
 /*
  * VPD VDO
  * ---------
-- 
2.31.1.818.g46aad6cb9e-goog

