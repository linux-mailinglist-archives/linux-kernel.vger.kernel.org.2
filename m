Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DEF42C1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhJMN7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:59:44 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:39242 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235458AbhJMN7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:59:39 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DCZZcK013612;
        Wed, 13 Oct 2021 15:57:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=dr/i1XAfrxsgVONmhqG29P0gsS4pwZNeT4kXejTO6Go=;
 b=eoDFPr9RlLiuHl9Wvfhf3fbR6AYKnbEqTmISBDg4pNDjIKfjnk6UAXnMU/9FoUWKa11K
 ZXd6+TzEZzs9Jd+vPOkwxN36C23O1GzbiS2YlcH6TTsK7Aol9tB3S2DSrLI2WdQ3Kt9n
 uNFNiDVGCfT37GTq07v8W1xZbPhOA/Tl5ozPoaFsIAiDMFa6rNhRcNGXO71SgbFNnf8y
 +6ymXQKDdT7edW+HOHJ/5BfIDqbvkm40JsLxFS5Y7NCSH88qJY3mnxKmLjqXEebPlEu4
 R3E4PQy2cugkuQAO7qj0u5Vqp6fOpe1Mwk/kp3iw4gM8bPV10x/R3atigXFxyundAKCg KA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bnumjace4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 15:57:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 58D5310002A;
        Wed, 13 Oct 2021 15:57:27 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4FC6B22F7CA;
        Wed, 13 Oct 2021 15:57:27 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 13 Oct 2021 15:57:26
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <alexandre.torgue@foss.st.com>
Subject: [PATCH v3 3/4] usb: dwc2: add otg_rev and otg_caps information for gadget driver
Date:   Wed, 13 Oct 2021 15:57:04 +0200
Message-ID: <1634133425-25670-4-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634133425-25670-1-git-send-email-fabrice.gasnier@foss.st.com>
References: <1634133425-25670-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the dwc2 doesn't fill in the 'otg_caps' of usb_gadget structure.
When registering a gadget device (e.g. via configfs), the
usb_otg_descriptor_init() checks the 'otg_caps' and 'otg_rev'. It defaults
to HNP and SRP bmAttributes if unspecified. There may be a mismatch with
what's being set in dwc2 params structure. This result in the descriptors
to be miss-configured in this case.

So replace 'otg_cap' bit field by 'otg_caps' structure, so hnp, srp and
otg_rev' can be configured directly in the params.
It's then provided to the gadget struct. These parameters can be tuned
for each platform. In case it's not set, it will default to current
behavior.

Also add option to setup these from the device tree by calling
of_usb_update_otg_caps(). This provides support for standard properties
such as "otg-rev", "hnp-disable" and "srp-disable" (see usb-drd.yaml).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- replace otg_cap bit field by otg_caps structure.
- Fix build issue when HOST only configuration
  error: 'struct dwc2_hsotg' has no member named 'dw_otg_caps'
  (e.g. CONFIG_USB_DWC2_PERIPHERAL / CONFIG_USB_DWC2_DUAL_ROLE aren't set)
  otg_caps is now a member of dwc2_core_params
---
 drivers/usb/dwc2/core.h    | 19 ++++++------
 drivers/usb/dwc2/debugfs.c |  4 ++-
 drivers/usb/dwc2/gadget.c  |  1 +
 drivers/usb/dwc2/hcd.c     | 12 +++-----
 drivers/usb/dwc2/params.c  | 73 +++++++++++++++++++++++++---------------------
 5 files changed, 57 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index cb9059a..37185eb 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -238,11 +238,14 @@ enum dwc2_ep0_state {
 /**
  * struct dwc2_core_params - Parameters for configuring the core
  *
- * @otg_cap:            Specifies the OTG capabilities.
- *                       0 - HNP and SRP capable
- *                       1 - SRP Only capable
- *                       2 - No HNP/SRP capable (always available)
- *                      Defaults to best available option (0, 1, then 2)
+ * @otg_caps:           Specifies the OTG capabilities. OTG caps from the platform parameters,
+ *                      used to setup the:
+ *                       - HNP and SRP capable
+ *                       - SRP Only capable
+ *                       - No HNP/SRP capable (always available)
+ *                       Defaults to best available option
+ *                       - OTG revision number the device is compliant with, in binary-coded
+ *                         decimal (i.e. 2.0 is 0200H). (see struct usb_otg_caps)
  * @host_dma:           Specifies whether to use slave or DMA mode for accessing
  *                      the data FIFOs. The driver will automatically detect the
  *                      value for this parameter if none is specified.
@@ -453,11 +456,7 @@ enum dwc2_ep0_state {
  * default described above.
  */
 struct dwc2_core_params {
-	u8 otg_cap;
-#define DWC2_CAP_PARAM_HNP_SRP_CAPABLE		0
-#define DWC2_CAP_PARAM_SRP_ONLY_CAPABLE		1
-#define DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE	2
-
+	struct usb_otg_caps otg_caps;
 	u8 phy_type;
 #define DWC2_PHY_TYPE_PARAM_FS		0
 #define DWC2_PHY_TYPE_PARAM_UTMI	1
diff --git a/drivers/usb/dwc2/debugfs.c b/drivers/usb/dwc2/debugfs.c
index f13eed4..1d72ece 100644
--- a/drivers/usb/dwc2/debugfs.c
+++ b/drivers/usb/dwc2/debugfs.c
@@ -670,7 +670,9 @@ static int params_show(struct seq_file *seq, void *v)
 	struct dwc2_core_params *p = &hsotg->params;
 	int i;
 
-	print_param(seq, p, otg_cap);
+	print_param(seq, p, otg_caps.hnp_support);
+	print_param(seq, p, otg_caps.srp_support);
+	print_param(seq, p, otg_caps.otg_rev);
 	print_param(seq, p, dma_desc_enable);
 	print_param(seq, p, dma_desc_fs_enable);
 	print_param(seq, p, speed);
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 7cd95bc..8623ddd 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4967,6 +4967,7 @@ int dwc2_gadget_init(struct dwc2_hsotg *hsotg)
 	hsotg->gadget.max_speed = USB_SPEED_HIGH;
 	hsotg->gadget.ops = &dwc2_hsotg_gadget_ops;
 	hsotg->gadget.name = dev_name(dev);
+	hsotg->gadget.otg_caps = &hsotg->params.otg_caps;
 	hsotg->remote_wakeup_allowed = 0;
 
 	if (hsotg->params.lpm)
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index a215ec9..13c779a 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -138,19 +138,15 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
 
 	switch (hsotg->hw_params.op_mode) {
 	case GHWCFG2_OP_MODE_HNP_SRP_CAPABLE:
-		if (hsotg->params.otg_cap ==
-				DWC2_CAP_PARAM_HNP_SRP_CAPABLE)
+		if (hsotg->params.otg_caps.hnp_support &&
+		    hsotg->params.otg_caps.srp_support)
 			usbcfg |= GUSBCFG_HNPCAP;
-		if (hsotg->params.otg_cap !=
-				DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE)
-			usbcfg |= GUSBCFG_SRPCAP;
-		break;
+		fallthrough;
 
 	case GHWCFG2_OP_MODE_SRP_ONLY_CAPABLE:
 	case GHWCFG2_OP_MODE_SRP_CAPABLE_DEVICE:
 	case GHWCFG2_OP_MODE_SRP_CAPABLE_HOST:
-		if (hsotg->params.otg_cap !=
-				DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE)
+		if (hsotg->params.otg_caps.srp_support)
 			usbcfg |= GUSBCFG_SRPCAP;
 		break;
 
diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 59e1193..99d3b62 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -36,6 +36,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/usb/of.h>
 
 #include "core.h"
 
@@ -53,7 +54,8 @@ static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
 
-	p->otg_cap = DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE;
+	p->otg_caps.hnp_support = false;
+	p->otg_caps.srp_support = false;
 	p->speed = DWC2_SPEED_PARAM_HIGH;
 	p->host_rx_fifo_size = 512;
 	p->host_nperio_tx_fifo_size = 512;
@@ -84,7 +86,8 @@ static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
 
-	p->otg_cap = DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE;
+	p->otg_caps.hnp_support = false;
+	p->otg_caps.srp_support = false;
 	p->host_rx_fifo_size = 525;
 	p->host_nperio_tx_fifo_size = 128;
 	p->host_perio_tx_fifo_size = 256;
@@ -97,7 +100,8 @@ static void dwc2_set_ltq_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
 
-	p->otg_cap = 2;
+	p->otg_caps.hnp_support = false;
+	p->otg_caps.srp_support = false;
 	p->host_rx_fifo_size = 288;
 	p->host_nperio_tx_fifo_size = 128;
 	p->host_perio_tx_fifo_size = 96;
@@ -111,7 +115,8 @@ static void dwc2_set_amlogic_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
 
-	p->otg_cap = DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE;
+	p->otg_caps.hnp_support = false;
+	p->otg_caps.srp_support = false;
 	p->speed = DWC2_SPEED_PARAM_HIGH;
 	p->host_rx_fifo_size = 512;
 	p->host_nperio_tx_fifo_size = 500;
@@ -144,7 +149,8 @@ static void dwc2_set_stm32f4x9_fsotg_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
 
-	p->otg_cap = DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE;
+	p->otg_caps.hnp_support = false;
+	p->otg_caps.srp_support = false;
 	p->speed = DWC2_SPEED_PARAM_FULL;
 	p->host_rx_fifo_size = 128;
 	p->host_nperio_tx_fifo_size = 96;
@@ -168,7 +174,8 @@ static void dwc2_set_stm32mp15_fsotg_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
 
-	p->otg_cap = DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE;
+	p->otg_caps.hnp_support = false;
+	p->otg_caps.srp_support = false;
 	p->speed = DWC2_SPEED_PARAM_FULL;
 	p->host_rx_fifo_size = 128;
 	p->host_nperio_tx_fifo_size = 96;
@@ -188,7 +195,8 @@ static void dwc2_set_stm32mp15_hsotg_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
 
-	p->otg_cap = DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE;
+	p->otg_caps.hnp_support = false;
+	p->otg_caps.srp_support = false;
 	p->activate_stm_id_vb_detection = !device_property_read_bool(hsotg->dev, "usb-role-switch");
 	p->host_rx_fifo_size = 440;
 	p->host_nperio_tx_fifo_size = 256;
@@ -241,23 +249,22 @@ MODULE_DEVICE_TABLE(acpi, dwc2_acpi_match);
 
 static void dwc2_set_param_otg_cap(struct dwc2_hsotg *hsotg)
 {
-	u8 val;
-
 	switch (hsotg->hw_params.op_mode) {
 	case GHWCFG2_OP_MODE_HNP_SRP_CAPABLE:
-		val = DWC2_CAP_PARAM_HNP_SRP_CAPABLE;
+		hsotg->params.otg_caps.hnp_support = true;
+		hsotg->params.otg_caps.srp_support = true;
 		break;
 	case GHWCFG2_OP_MODE_SRP_ONLY_CAPABLE:
 	case GHWCFG2_OP_MODE_SRP_CAPABLE_DEVICE:
 	case GHWCFG2_OP_MODE_SRP_CAPABLE_HOST:
-		val = DWC2_CAP_PARAM_SRP_ONLY_CAPABLE;
+		hsotg->params.otg_caps.hnp_support = false;
+		hsotg->params.otg_caps.srp_support = true;
 		break;
 	default:
-		val = DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE;
+		hsotg->params.otg_caps.hnp_support = false;
+		hsotg->params.otg_caps.srp_support = false;
 		break;
 	}
-
-	hsotg->params.otg_cap = val;
 }
 
 static void dwc2_set_param_phy_type(struct dwc2_hsotg *hsotg)
@@ -463,6 +470,8 @@ static void dwc2_get_device_properties(struct dwc2_hsotg *hsotg)
 						       &p->g_tx_fifo_size[1],
 						       num);
 		}
+
+		of_usb_update_otg_caps(hsotg->dev->of_node, &p->otg_caps);
 	}
 
 	if (of_find_property(hsotg->dev->of_node, "disable-over-current", NULL))
@@ -473,29 +482,27 @@ static void dwc2_check_param_otg_cap(struct dwc2_hsotg *hsotg)
 {
 	int valid = 1;
 
-	switch (hsotg->params.otg_cap) {
-	case DWC2_CAP_PARAM_HNP_SRP_CAPABLE:
+	if (hsotg->params.otg_caps.hnp_support && hsotg->params.otg_caps.srp_support) {
+		/* check HNP && SRP capable */
 		if (hsotg->hw_params.op_mode != GHWCFG2_OP_MODE_HNP_SRP_CAPABLE)
 			valid = 0;
-		break;
-	case DWC2_CAP_PARAM_SRP_ONLY_CAPABLE:
-		switch (hsotg->hw_params.op_mode) {
-		case GHWCFG2_OP_MODE_HNP_SRP_CAPABLE:
-		case GHWCFG2_OP_MODE_SRP_ONLY_CAPABLE:
-		case GHWCFG2_OP_MODE_SRP_CAPABLE_DEVICE:
-		case GHWCFG2_OP_MODE_SRP_CAPABLE_HOST:
-			break;
-		default:
-			valid = 0;
-			break;
+	} else if (!hsotg->params.otg_caps.hnp_support) {
+		/* check SRP only capable */
+		if (hsotg->params.otg_caps.srp_support) {
+			switch (hsotg->hw_params.op_mode) {
+			case GHWCFG2_OP_MODE_HNP_SRP_CAPABLE:
+			case GHWCFG2_OP_MODE_SRP_ONLY_CAPABLE:
+			case GHWCFG2_OP_MODE_SRP_CAPABLE_DEVICE:
+			case GHWCFG2_OP_MODE_SRP_CAPABLE_HOST:
+				break;
+			default:
+				valid = 0;
+				break;
+			}
 		}
-		break;
-	case DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE:
-		/* always valid */
-		break;
-	default:
+		/* else: NO HNP && NO SRP capable: always valid */
+	} else {
 		valid = 0;
-		break;
 	}
 
 	if (!valid)
-- 
2.7.4

