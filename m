Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91227430931
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbhJQNBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 09:01:32 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37813 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343588AbhJQNBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 09:01:30 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 10EBA5C00E2;
        Sun, 17 Oct 2021 08:59:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 17 Oct 2021 08:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=LJblaVYUkTeH0
        MmRDFNp1xity1LQsYJVL4syXm9P04M=; b=XFMJk086YUIMt+lsbbcwqt79XOmJf
        hp5jabGkiRU9O+GJ2RVopEUv0CCGXu5MhouTWRPv29r9V2dQnqyIXbtFiXZBjBdW
        mLY/E4Pd2V6NbtL94PINnJtX3dq+bhdKZoEZXfrMFBLPlI9gHRFjwHvG56uTqZju
        VzKnYTQDNI4ZJ1zMrawkGBVSRTHBcSSr1GVdBl2B3iNH9U11vHlXqJZTROTAnWEq
        c1OtM+MJbRPQYH9HUYfDrgm3ls+BdKveqhGbDmjAN3jU4EVH5yQq2jiXHi7lT92W
        maaLMkLwH1ef0MJb4JkpzNLeaMPxx8IBiZ4F9yfJxPj/VR1L6C5ULpWMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=LJblaVYUkTeH0MmRDFNp1xity1LQsYJVL4syXm9P04M=; b=LifgrM8R
        nwnzrLewEnaZyMIhkkEjjfQEfoOWmBzf8mIRsngVHC2Yp2YJRtixiiRpZb1JoWcg
        D+0u7KnvZPzMb64Dbe3KOGAyMxW5AEHuq3Pv8DWEHaoTumAY5hRGLUPlifm0l/dA
        cLrcm5f+c/WnX8oqEH/jH5Xp3KcgvKtFDp+XlPc+28fk8IQIOt4P25qQpFI5feTt
        vOIV54ZJYxyEOq5xFKia/1yzWzY/x0zwNg5Mqdfwtt9fL574pWx5nQZLIwzVfr6+
        jYI5v3jpY4Y1MegJEhamOjyvFdgP54eomYB/79Y23hZG12XSFIF3kfZbUDN3gfbL
        3A3wkGma8YLQrw==
X-ME-Sender: <xms:KB5sYUDIci1-Dbc7L1GkbYqWBt5AWyCFB8izsLGu1Lp03k2fyhl0KA>
    <xme:KB5sYWjfvtyIgGKfv0_GBAQPTP5ztyXVW0JTneVsmf3__hmiJqa2r3G8ZbdCn-KJd
    WMc7vSWBtQiiqIRa3A>
X-ME-Received: <xmr:KB5sYXnnPJX4x3-y_UoRuzk9Ae0SJwwzAhTzMzT3hDqPBSzpLc4C0xkNYPyp6kqJk_-InUhM6pI1UbyWAK-GnpRbjKcnAUKWKkU2InnJt_kTupU2SSwUas4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddukedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:KB5sYaywVNkeW1IORqyK0f2eo2VvF86W1lNIHO4gp8bU0hqNdNqfLA>
    <xmx:KB5sYZSFneKxbuRXXENkwcEYxCjf3ZIoxaGavBOvDBcfXJbAVjg4tA>
    <xmx:KB5sYVZ0awDrKfcL1SVXMhSZtvSo3VcfZXl31uoxAxfrYvAo-eo9Rg>
    <xmx:KR5sYYG9Itir9Sca-kf6rK_E1rZicDrejZT6xl3jyWS3HS4hMLpo5Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Oct 2021 08:59:19 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: dwc3: Add role-switch-reset-quirk logic
Date:   Sun, 17 Oct 2021 14:59:04 +0200
Message-Id: <20211017125904.69076-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211017125904.69076-1-sven@svenpeter.dev>
References: <20211017125904.69076-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mad as it sounds, the dwc3 controller present on the Apple M1 must be
reset and reinitialized whenever a device is unplugged from the root port
and triggers a role switch notification from the USB PD controller.

This is required for at least two reasons:

  - The USB2 D+/D- lines are connected through a stateful eUSB2 repeater
    which in turn is controlled by a variant of the TI TPS6598x USB PD
    chip. When the USB PD controller detects a hotplug event it resets
    the eUSB2 repeater. Afterwards, no new device is recognized before
    the DWC3 core and PHY are reset as well.

  - It's possible to completely break the dwc3 controller by switching
    it to device mode and unplugging the cable at just the wrong time.
    Even a CORESOFTRESET is not enough to allow new devices again.
    The only workaround is to trigger a hard reset of the entire
    dwc3 core. This also happens when running macOS on these
    machines.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/dwc3/core.c | 40 +++++++++++++++++++++++++++++++++++++---
 drivers/usb/dwc3/core.h |  6 ++++++
 drivers/usb/dwc3/drd.c  |  7 +++++++
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 643239d7d370..444b45e9cb92 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -116,6 +116,8 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 }
 
 static int dwc3_core_soft_reset(struct dwc3 *dwc);
+static void dwc3_core_exit(struct dwc3 *dwc);
+static int dwc3_core_init_for_resume(struct dwc3 *dwc);
 
 static void __dwc3_set_mode(struct work_struct *work)
 {
@@ -131,10 +133,11 @@ static void __dwc3_set_mode(struct work_struct *work)
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
 		dwc3_otg_update(dwc, 0);
 
-	if (!dwc->desired_dr_role)
+	if (!dwc->desired_dr_role && !dwc->role_switch_reset_quirk)
 		goto out;
 
-	if (dwc->desired_dr_role == dwc->current_dr_role)
+	if (dwc->desired_dr_role == dwc->current_dr_role &&
+			!dwc->role_switch_reset_quirk)
 		goto out;
 
 	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
@@ -159,6 +162,34 @@ static void __dwc3_set_mode(struct work_struct *work)
 		break;
 	}
 
+	if (dwc->role_switch_reset_quirk) {
+		if (dwc->current_dr_role) {
+			dwc->current_dr_role = 0;
+			dwc3_core_exit(dwc);
+		}
+
+		if (dwc->desired_dr_role) {
+			/*
+			 * the first call to __dwc3_set_mode comes from
+			 * dwc3_drd_init. In that case dwc3_core_init has been
+			 * called but dwc->current_dr_role is zero such that
+			 * we must not reinitialize the core again here.
+			 */
+			if (dwc->role_switch_reset_quirk_initialized) {
+				ret = dwc3_core_init_for_resume(dwc);
+				if (ret) {
+					dev_err(dwc->dev,
+					    "failed to reinitialize core\n");
+					goto out;
+				}
+			}
+
+			dwc->role_switch_reset_quirk_initialized = 1;
+		} else {
+			goto out;
+		}
+	}
+
 	/* For DRD host or device mode only */
 	if (dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG) {
 		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
@@ -1425,6 +1456,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
 
+	dwc->role_switch_reset_quirk = device_property_read_bool(dev,
+				"snps,role-switch-reset-quirk");
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
@@ -1744,7 +1778,6 @@ static int dwc3_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 {
 	int ret;
@@ -1771,6 +1804,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	return ret;
 }
 
+#ifdef CONFIG_PM
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index ee854697c300..04b1b9c2bbed 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1086,6 +1086,9 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @role_switch_reset_quirk: set to force reinitialization after any role switch
+ * @role_switch_reset_quirk_initialized: set to true after the first role switch
+ *			which is triggered from dwc3_drd_init directly
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1299,6 +1302,9 @@ struct dwc3 {
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
 
+	unsigned		role_switch_reset_quirk:1;
+	unsigned		role_switch_reset_quirk_initialized:1;
+
 	u16			imod_interval;
 
 	int			max_cfg_eps;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index d7f76835137f..403e88a72f0e 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -506,6 +506,9 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
 		break;
 	}
 
+	if (dwc->role_switch_reset_quirk && role == USB_ROLE_NONE)
+		mode = 0;
+
 	dwc3_set_mode(dwc, mode);
 	return 0;
 }
@@ -534,6 +537,10 @@ static enum usb_role dwc3_usb_role_switch_get(struct usb_role_switch *sw)
 			role = USB_ROLE_DEVICE;
 		break;
 	}
+
+	if (dwc->role_switch_reset_quirk && !dwc->current_dr_role)
+		role = USB_ROLE_NONE;
+
 	spin_unlock_irqrestore(&dwc->lock, flags);
 	return role;
 }
-- 
2.25.1

