Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4274392DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhE0MMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbhE0MMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:12:09 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D794C061763
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:10:36 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a8-20020a62d4080000b029028db7db58adso310588pfh.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iqIBI9XStvdUfyRfeYE0WncKiX+A9ECL2BS9Q2VVAXk=;
        b=PArDcqPZfuuiN12JsR2xB6EirNwGgYJWbDfP5lgcIPFIeDhqMH/wNmSVOHVweoZeNk
         f3sV5DmGKU0/ewkJNoXyEKlv/nCaFiCOT9wICSUbA/U9OkJaC/svciz7SLMA26FpE54s
         klcC63OOcnVBt4y0geb2uD6pJVz+O1CAXZUaF14x8eYs2aV7n0wazobYxzWC3FO09g67
         wRuy8q/FS8nPRxNEby+RRmUGpgYI4EtyxvGPwkcSicCIV9qt32fL/hLKyoGBmZX9bX0Z
         zEzroG4ewtCoZTIXPXbqy9r1BGcJXCU0T2mGIKfrWK55LLEIbSUqVZTnsMy3WOXqmLi/
         nQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iqIBI9XStvdUfyRfeYE0WncKiX+A9ECL2BS9Q2VVAXk=;
        b=nLT+P+aRzR6L77Xg7IaCJnVsFQNKrS1lv4yweOh4qLqQZOWQDBrnJpbBky920aPX0k
         JLecFRYE6RxSreCWZJ2LzhIqz+/g0YQOqIyZLNuEN+hCF3eZkWSQEe1DNOGRvlOPm2r7
         8hSSVATyYpPAajmZVpnbsU/cBHozr3r+xIFC8gZcfFSILTlX6ceFM1Pbugq9eAfY5ELp
         xUjJPKGS7Vt2J3N8Kq8nyO+1YoUAr3ihup6q0JQto+PghAnd7C6cTXnvga/5Nu7mLFBx
         GEfbM5VC7RyT6rSeGLCPT0SqzTmdYolUkCCjg4JuVRm2TKCOc9hGg558VbaaYvqqg3Cj
         Azow==
X-Gm-Message-State: AOAM531P+FEBWUhI27+NI5Nq0g9D5Q9/uPM9bosFOlqJw7dXsFsqaPsv
        nQ5YimCOVPka7GMNVJY3lWBwJaHMQ4zs
X-Google-Smtp-Source: ABdhPJzQx0mkKyKy509zGxvF3O4kLLBMvsliBnvQibEk/5wxoseMmTXHX18oAgAf+d/mUzF8phl62QJALX/o
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:c563:7257:f641:cbcd])
 (user=kyletso job=sendgmr) by 2002:a17:902:7fc1:b029:f9:2580:8183 with SMTP
 id t1-20020a1709027fc1b02900f925808183mr2845341plb.63.1622117435978; Thu, 27
 May 2021 05:10:35 -0700 (PDT)
Date:   Thu, 27 May 2021 20:10:29 +0800
Message-Id: <20210527121029.583611-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2] dt-bindings: connector: Replace BIT macro with generic bit ops
From:   Kyle Tso <kyletso@google.com>
To:     heikki.krogerus@linux.intel.com, robh+dt@kernel.org,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIT macro is not defined. Replace it with generic bit operations.

Fixes: 630dce2810b9 ("dt-bindings: connector: Add SVDM VDO properties")
Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changes since v1:
- re-word the commit message

 include/dt-bindings/usb/pd.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
index fef3ef65967f..cb70b4ceedde 100644
--- a/include/dt-bindings/usb/pd.h
+++ b/include/dt-bindings/usb/pd.h
@@ -163,10 +163,10 @@
 #define UFP_VDO_VER1_2		2
 
 /* Device Capability */
-#define DEV_USB2_CAPABLE	BIT(0)
-#define DEV_USB2_BILLBOARD	BIT(1)
-#define DEV_USB3_CAPABLE	BIT(2)
-#define DEV_USB4_CAPABLE	BIT(3)
+#define DEV_USB2_CAPABLE	(1 << 0)
+#define DEV_USB2_BILLBOARD	(1 << 1)
+#define DEV_USB3_CAPABLE	(1 << 2)
+#define DEV_USB4_CAPABLE	(1 << 3)
 
 /* Connector Type */
 #define UFP_RECEPTACLE		2
@@ -191,9 +191,9 @@
 
 /* Alternate Modes */
 #define UFP_ALTMODE_NOT_SUPP	0
-#define UFP_ALTMODE_TBT3	BIT(0)
-#define UFP_ALTMODE_RECFG	BIT(1)
-#define UFP_ALTMODE_NO_RECFG	BIT(2)
+#define UFP_ALTMODE_TBT3	(1 << 0)
+#define UFP_ALTMODE_RECFG	(1 << 1)
+#define UFP_ALTMODE_NO_RECFG	(1 << 2)
 
 /* USB Highest Speed */
 #define UFP_USB2_ONLY		0
@@ -217,9 +217,9 @@
  * <4:0>   :: Port number
  */
 #define DFP_VDO_VER1_1		1
-#define HOST_USB2_CAPABLE	BIT(0)
-#define HOST_USB3_CAPABLE	BIT(1)
-#define HOST_USB4_CAPABLE	BIT(2)
+#define HOST_USB2_CAPABLE	(1 << 0)
+#define HOST_USB3_CAPABLE	(1 << 1)
+#define HOST_USB4_CAPABLE	(1 << 2)
 #define DFP_RECEPTACLE		2
 #define DFP_CAPTIVE		3
 
-- 
2.31.1.818.g46aad6cb9e-goog

