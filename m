Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B530E8F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhBDAvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhBDAvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:51:23 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47062C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 16:50:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i2so1654809ybl.16
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 16:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=rxB42Ll+u8IgbwodhtThD2OaoS5PPazXcX+y5B+EoiQ=;
        b=ifzmRU0f1Nd+vOKukp9VSrwPFqL+wGIoJ/H4nOfMeM8ZlLJSbWPAlKUgIEzqv9zboD
         WAuFxGt19RGWZgUrwT5DlT+fMoR5vTqxRnElPXWs3DkM9l6fyIbwQneTxPUrxTZ2q4gn
         fwD/mj2Rv3nTr0QKSmS44fplqcPgQF6QueHT8wLoN1778aGnDv/dkmRW2erlPZ9pm/aW
         h2pTgXuYkO/FfC6gN6ihFnGEVGCz4s7wWzp3M/4rY9Vl8wqsxgeMlkz/wyyIh/UzYpB4
         fzMgdHC0sK4pj/Ajp2dGVKKgQ8wJ5o9oSuwjgyNuS487o/xQKk6gizcbd9rXfkOQggHU
         vvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=rxB42Ll+u8IgbwodhtThD2OaoS5PPazXcX+y5B+EoiQ=;
        b=bV+DMRf9BaxvAQdAhuHvbgtENn5XHHEzJZId6nyz1/rqeLm35c4QkHXAWMrHBrwIG3
         AlqWvdKsJ97xrxdikTKrYP7h0udVqrixjbB2frTgrTOW6L39iw4mbwFPg7zuRE/JFozE
         1Y8zwqnrSo4M0PxBtmJW8GSc0WTeKmr/xds75ksUqpYvdGTwFO8aU3v97bRTDHnk4LFw
         KaEq3W6ZRDIy50EsY4dfCYy4JcZ2G9O8rqyhZgQiJFicp9vbemv6CqtWxaSMOzSVl83E
         FQedJ7He6OXvP0qgECuCegMM/XOa4TpDRHFA6Ims/TuLKNvWT1I1wCAWrKjTT7zbyLP5
         2hzg==
X-Gm-Message-State: AOAM533DTau9VX3ph50bD+bVuE/VOK+J7+LwWk7rjifKublrfILE/Evd
        XxzfqpEx/GMlMNkBnVDYVVGOKVDotcci
X-Google-Smtp-Source: ABdhPJxwXuGI/oGuMILLqqUcY2JXWJumpxnif48T/UVzHP5N3STT/9kP1/FzcpsxKewLlRXkPJc/6h9RIbai
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:dd94:c753:a81d:c855])
 (user=kyletso job=sendgmr) by 2002:a25:bcb:: with SMTP id 194mr8134302ybl.241.1612399842519;
 Wed, 03 Feb 2021 16:50:42 -0800 (PST)
Date:   Thu,  4 Feb 2021 08:50:36 +0800
Message-Id: <20210204005036.1555294-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH] usb: pd: Reland VDO definitions of PD2.0
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, pmalani@chromium.org,
        bleung@chromium.org
Cc:     bleung@google.com, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reland VDO definitions of PD Revision 2.0 as they are still used in
PD2.0 products.

Fixes: 0e1d6f55a12e ("usb: pd: Update VDO definitions")
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 include/linux/usb/pd_vdo.h | 69 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
index e9b6822c54c2..5de7f550f93e 100644
--- a/include/linux/usb/pd_vdo.h
+++ b/include/linux/usb/pd_vdo.h
@@ -110,6 +110,10 @@
  * <20:16>  :: Reserved, Shall be set to zero
  * <15:0>   :: USB-IF assigned VID for this cable vendor
  */
+
+/* PD Rev2.0 definition */
+#define IDH_PTYPE_UNDEF		0
+
 /* SOP Product Type (UFP) */
 #define IDH_PTYPE_NOT_UFP	0
 #define IDH_PTYPE_HUB		1
@@ -248,7 +252,25 @@
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
@@ -264,7 +286,7 @@
  * <4:3>   :: Reserved, Shall be set to zero
  * <2:0>   :: USB highest speed
  *
- * Active Cable VDO 1
+ * Active Cable VDO 1 (PD Rev3.0+)
  * ---------
  * <31:28> :: Cable HW version
  * <27:24> :: Cable FW version
@@ -286,7 +308,9 @@
 #define CABLE_VDO_VER1_0	0
 #define CABLE_VDO_VER1_3	3
 
-/* Connector Type */
+/* Connector Type (_ATYPE and _BTYPE are for PD Rev2.0 only) */
+#define CABLE_ATYPE		0
+#define CABLE_BTYPE		1
 #define CABLE_CTYPE		2
 #define CABLE_CAPTIVE		3
 
@@ -323,12 +347,22 @@
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
@@ -395,6 +429,35 @@
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
2.30.0.365.g02bc693789-goog

