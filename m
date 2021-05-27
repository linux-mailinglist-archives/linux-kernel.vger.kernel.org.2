Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423E1392B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbhE0KPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbhE0KPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:15:53 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A149C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:14:20 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r11-20020a0cb28b0000b02901c87a178503so3525634qve.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BsGWspNEUxu3B3RdgzIWcTj9kh7wBDE9VB/bQzM3kTQ=;
        b=H0rgb7Cme0IYN3JoewcDg3GuLSqj3o1Xr20l6I61OXvWuySxbC7W9VQR4lgBTmIevM
         DiXwJiGPeeivF0DitcQRP0Eq8wzliD6gCHubCAL2qLDxgd9GoggeKMtXxCgFXObrJ/KV
         U/WCBQ+eBKyIx4oJBlNEc3xRbN4S464p+6sr85zN5E6h0t5jyMDe4EsMp4hWljbxdnjD
         bBJiNFLZuafS8b5nS515Tox/KkPlYOu00RYTIxkcuqNIKZVi60V6ZtOR9LttUDvQ7nWW
         yh6it8VwuE3qmokAFVqOXgCv0fkNCydx+JZd+rgN7sIlb8pJf0uQyfkoKnYhf7Vw5SDf
         oviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BsGWspNEUxu3B3RdgzIWcTj9kh7wBDE9VB/bQzM3kTQ=;
        b=dt3yvdsrYAWPe14Nb/FOZVEmeUYA/dqCB7A+zsdj/exzOoWb6YEEG5yz6AZQVoundD
         H0OfVD1KATTfpgVaGYBfKq37csKhOZDL3gWVnekclBcb6YEghrdYLnl/pWg8o0oaj9iv
         jGTQXjkvhwgcIqE3vb+7ozGY5y7kYV0YfY/qlXe/DtDPqguXjYZuO+uRN0gSsHSIMyse
         C/w4jMY+X/YEjB37COXeVzr2N8hGKTGncU/qEBU12rlA7PfuqHuHqkZEC/sLhvsTDpGi
         l6zCNW02xoAWU8D1xp+HQ6qyIUVGr4kTVq3mDPxV2D4JXWbvM1Bi1SccHdPCfsfj9LQM
         WyWQ==
X-Gm-Message-State: AOAM530royzwZzscfMDhhi2DSYZeQdLXVX12x/jHS90up6zPu1oWTWni
        tO2RGREDWMcgJORMPdujSElXPalU3LxP
X-Google-Smtp-Source: ABdhPJxVX3hFFxBR8xNoVDuP7ffjfB11H1FH+E3k8anz8731TIlNXPPBbk0k2mOFzqqz52M5iXhbjiu+gGji
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:c563:7257:f641:cbcd])
 (user=kyletso job=sendgmr) by 2002:a0c:99db:: with SMTP id
 y27mr2501029qve.19.1622110459265; Thu, 27 May 2021 03:14:19 -0700 (PDT)
Date:   Thu, 27 May 2021 18:13:45 +0800
Message-Id: <20210527101345.569725-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH] dt-bindings: connector: Replace BIT macro with generic bit ops
From:   Kyle Tso <kyletso@google.com>
To:     heikki.krogerus@linux.intel.com, robh+dt@kernel.org,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIT macro is not supported in dt-bindings. Replace it with generic bit
operations.

Fixes: 630dce2810b9 ("dt-bindings: connector: Add SVDM VDO properties")
Signed-off-by: Kyle Tso <kyletso@google.com>
---
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

