Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A43401AF7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241958AbhIFMJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:09:46 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:55808 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241704AbhIFMJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:09:44 -0400
Received: by mail-wm1-f47.google.com with SMTP id g135so4424903wme.5;
        Mon, 06 Sep 2021 05:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RWUT2zm9qK9IIjRNDnSP6e3OmZYR6tRm7i7pzxaGXMA=;
        b=g0f9lCGYMqHiuLza7Hs7T+Z6C4FD78Xm2LyFLTJ85cuTA3Wqy4ItQ57MRRdBgtteu4
         RSEpYi0+W9sY/QiVsxuNhA3/uqO+PNdxDE1zCkL0m2fINtITfv/nb4dUouEIOSvQW7Mw
         Et5e6eTO7rx1L83G4qf/0kACo/uBrNMGL3OC7sfjUaSNg1Y6IfRWE99j9yHd5LVkn8Ew
         WU+xMbZ8aUcQ4A5GwOSO/qpBPKSf3H7o4vqU90Eu1Woebxan9wAjBpA34kdeJaVO7/Vi
         Mhcs2S2mKXaeR4T7zYchbAH0FAulhDu5fqUAXoVFeydooORyZKolVFlBdHgy50Gm0Ken
         hZ1Q==
X-Gm-Message-State: AOAM530tho5/6MnW+AoJjF7TTMLprWursuF5jTENyFFvdzMfeRnr/Fxe
        XCrwP/GjmOIXlNU2U+u3G6sKazzgroMSyARs
X-Google-Smtp-Source: ABdhPJxLcw5UmEhntgt3yH3YSWfuX3oTy4wCbL65l5DshA4xYAQ7EQRY2/eCyNlLER9VdBeGkhd9gw==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr11168853wma.117.1630930119054;
        Mon, 06 Sep 2021 05:08:39 -0700 (PDT)
Received: from rockpro.mgmt (host-212-159-138-247.static.as13285.net. [212.159.138.247])
        by smtp.gmail.com with ESMTPSA id t14sm7772626wrw.59.2021.09.06.05.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 05:08:38 -0700 (PDT)
From:   Shantur Rathore <i@shantur.com>
Cc:     i@shantur.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: fix endpoint direction when inputs are more than outputs
Date:   Mon,  6 Sep 2021 13:08:34 +0100
Message-Id: <20210906120836.4596-1-i@shantur.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RK3399 as per documentation (
https://usermanual.wiki/Document/RockchipDeveloperGuidelinux44USB.31610806
), there are 7 Input Endpoints and 6 Output endpoints, in total 13
endpoints.

Currently dwc3/gadget.c driver uses the number of endpoints
available and starts setting them up with even endpoints as output
endpoints and odd numbered as even endpoints. This leads to 7 Output
endpoints and 6 input endpoints for RK3399.

If you try to create a composite gadget which uses all the input
endpoints, one can see the issue. You just need to create functions to
use up the last input ep and it would fail to create. No need to
connect it to the host.
This was confirmed when running a rockchip-linux bsp image.

[root@rockpro rock]# ls /sys/kernel/debug/usb/fe800000.usb/
ep0in  ep0out  ep1in  ep1out  ep2in  ep2out  ep3in  ep3out  ep4in
ep4out  ep5in  ep5out  ep6in  link_state  lsp_dump  mode  regdump
testmode

Currently in linux mainline it is

[root@rockpro rock]# ls /sys/kernel/debug/usb/fe800000.usb/
ep0in  ep0out  ep1in  ep1out  ep2in  ep2out  ep3in  ep3out  ep4in
ep4out  ep5in  ep5out  ep6out  link_state  lsp_dump  mode  regdump
testmode

ep6 being out instead of in as per the hardware spec.

Upon investigation of rockchip bsp kernel,
https://github.com/rockchip-linux/kernel/

The issue was clear, currently, dwc3/gadget driver doesn't take
DWC3_NUM_IN_EPS into consideration while enumerating them.

The patch below fixes the issue and ep6 is correctly enumerated as input.
---
 drivers/usb/dwc3/core.c   |  1 +
 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/gadget.c | 40 ++++++++++++++++++++++++---------------
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 01866dcb953b..279c9a97cb8c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -555,6 +555,7 @@ static void dwc3_core_num_eps(struct dwc3 *dwc)
 	struct dwc3_hwparams	*parms = &dwc->hwparams;
 
 	dwc->num_eps = DWC3_NUM_EPS(parms);
+	dwc->num_in_eps = DWC3_NUM_IN_EPS(parms);
 }
 
 static void dwc3_cache_hwparams(struct dwc3 *dwc)
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5612bfdf37da..89a0998c618c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1227,6 +1227,7 @@ struct dwc3 {
 	u8			speed;
 
 	u8			num_eps;
+	u8			num_in_eps;
 
 	struct dwc3_hwparams	hwparams;
 	struct debugfs_regset32	*regset;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 804b50548163..d9d19dc0a29f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -693,9 +693,11 @@ void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
 
 	dwc->last_fifo_depth = fifo_depth;
 	/* Clear existing TXFIFO for all IN eps except ep0 */
-	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM);
-	     num += 2) {
+	for (num = 3; num < DWC3_ENDPOINTS_NUM; num += 2) {
 		dep = dwc->eps[num];
+
+		if(!dep)
+			continue;
 		/* Don't change TXFRAMNUM on usb31 version */
 		size = DWC3_IP_IS(DWC3) ? 0 :
 			dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1)) &
@@ -2257,7 +2259,7 @@ static void dwc3_stop_active_transfers(struct dwc3 *dwc)
 {
 	u32 epnum;
 
-	for (epnum = 2; epnum < dwc->num_eps; epnum++) {
+	for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
 		struct dwc3_ep *dep;
 
 		dep = dwc->eps[epnum];
@@ -2960,10 +2962,9 @@ static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 	return dwc3_alloc_trb_pool(dep);
 }
 
-static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
+static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum, bool direction)
 {
 	struct dwc3_ep			*dep;
-	bool				direction = epnum & 1;
 	int				ret;
 	u8				num = epnum >> 1;
 
@@ -3011,21 +3012,30 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	return 0;
 }
 
-static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total)
+static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total, u8 num_in_eps)
 {
-	u8				epnum;
+	u8				num;
+	int				ret;
 
 	INIT_LIST_HEAD(&dwc->gadget->ep_list);
 
-	for (epnum = 0; epnum < total; epnum++) {
-		int			ret;
+	/* init input endpoints as reported by hw */
+        for (num = 0; num < num_in_eps; num++) {
 
-		ret = dwc3_gadget_init_endpoint(dwc, epnum);
-		if (ret)
-			return ret;
-	}
+                ret = dwc3_gadget_init_endpoint(dwc, (num << 1) + 1, 1);
+                if (ret)
+                        return ret;
+        }
 
-	return 0;
+        /* init rest endpoints as output endpoints */
+        for (num = 0; num < total - num_in_eps; num++) {
+
+                ret = dwc3_gadget_init_endpoint(dwc, num << 1, 0);
+                if (ret)
+                        return ret;
+        }
+
+	return ret;
 }
 
 static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
@@ -4282,7 +4292,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	 * sure we're starting from a well known location.
 	 */
 
-	ret = dwc3_gadget_init_endpoints(dwc, dwc->num_eps);
+	ret = dwc3_gadget_init_endpoints(dwc, dwc->num_eps, dwc->num_in_eps);
 	if (ret)
 		goto err4;
 
-- 
2.33.0

