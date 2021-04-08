Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DA5357FA4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhDHJpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:45:23 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36578 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231341AbhDHJpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:45:16 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5FF00C09B1;
        Thu,  8 Apr 2021 09:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617875105; bh=E+igUESaPhpjVDVosLwHHiXN8svhMPcuxQoNubRH1OU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=dp7VQazFb1G5qk8dvpvKujIjq90JhZNaRG8t6/mnQRQWwd/Ki5ZpRRmh6CQH1Ed4t
         xIxOJjjpTh0qOM8cyCThQvoXqGcocxKnq8xxjAbOT67L7IPedyE7Kz7hpf3Dvzx2bA
         emyEOi5NSDsDNOaeMlaY/GesUYwuh5aLFcSKb+CLY4yta+0GBBCcH3UANDjl0qo7b1
         11IgA8iaWRWthUVtdHkYnCk+wqDmKew3ziT9F/Ixi3JqxmrhmxVHR+MiP6N+SoiKmI
         JYEaPqwT0xl+D6wICQMpr3SzaIDjIcr/f3UhhjVg6hkv3l9aBumglyYJ6u8s3VjCLZ
         /gzsZHqnrxZwA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 61D18A0232;
        Thu,  8 Apr 2021 09:45:02 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 08 Apr 2021 13:45:01 +0400
Date:   Thu, 08 Apr 2021 13:45:01 +0400
In-Reply-To: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v3 05/14] usb: dwc2: Update port suspend/resume function definitions.
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210408094502.61D18A0232@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier "dwc2_port_suspend()" and "dwc2_port_resume()" functions
were implemented without proper description and host or device mode
difference.

- Added "dwc2_port_suspend" and "dwc2_port_resume" functions to
  "core.h" header file.

- Updated function description in documentation.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v3:
 - None
 Changes in v2:
 - None

 drivers/usb/dwc2/core.h |  4 ++++
 drivers/usb/dwc2/hcd.c  | 25 +++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 39037709a2ad..b7d99cf9e84c 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1470,6 +1470,8 @@ void dwc2_hcd_connect(struct dwc2_hsotg *hsotg);
 void dwc2_hcd_disconnect(struct dwc2_hsotg *hsotg, bool force);
 void dwc2_hcd_start(struct dwc2_hsotg *hsotg);
 int dwc2_core_init(struct dwc2_hsotg *hsotg, bool initial_setup);
+void dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex);
+void dwc2_port_resume(struct dwc2_hsotg *hsotg);
 int dwc2_backup_host_registers(struct dwc2_hsotg *hsotg);
 int dwc2_restore_host_registers(struct dwc2_hsotg *hsotg);
 int dwc2_host_enter_hibernation(struct dwc2_hsotg *hsotg);
@@ -1493,6 +1495,8 @@ static inline void dwc2_hcd_start(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_hcd_remove(struct dwc2_hsotg *hsotg) {}
 static inline int dwc2_core_init(struct dwc2_hsotg *hsotg, bool initial_setup)
 { return 0; }
+static inline void dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex) {}
+static inline void dwc2_port_resume(struct dwc2_hsotg *hsotg) {}
 static inline int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 { return 0; }
 static inline int dwc2_backup_host_registers(struct dwc2_hsotg *hsotg)
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index dd0362e07444..f4247a66c2b2 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -56,8 +56,6 @@
 #include "core.h"
 #include "hcd.h"
 
-static void dwc2_port_resume(struct dwc2_hsotg *hsotg);
-
 /*
  * =========================================================================
  *  Host Core Layer Functions
@@ -3277,8 +3275,16 @@ static int dwc2_host_is_b_hnp_enabled(struct dwc2_hsotg *hsotg)
 	return hcd->self.b_hnp_enable;
 }
 
-/* Must NOT be called with interrupt disabled or spinlock held */
-static void dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
+/**
+ * dwc2_port_suspend() - Put controller in suspend mode for host.
+ *
+ * @hsotg: Programming view of the DWC_otg controller
+ * @windex: The control request wIndex field
+ *
+ * This function is for entering Host mode suspend.
+ * Must NOT be called with interrupt disabled or spinlock held.
+ */
+void dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
 {
 	unsigned long flags;
 	u32 hprt0;
@@ -3328,8 +3334,15 @@ static void dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
 	}
 }
 
-/* Must NOT be called with interrupt disabled or spinlock held */
-static void dwc2_port_resume(struct dwc2_hsotg *hsotg)
+/**
+ * dwc2_port_resume() - Exit controller from suspend mode for host.
+ *
+ * @hsotg: Programming view of the DWC_otg controller
+ *
+ * This function is for exiting Host mode suspend.
+ * Must NOT be called with interrupt disabled or spinlock held.
+ */
+void dwc2_port_resume(struct dwc2_hsotg *hsotg)
 {
 	unsigned long flags;
 	u32 hprt0;
-- 
2.25.1

