Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D54327F07
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhCANIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbhCANHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:07:04 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33D1C0617A9;
        Mon,  1 Mar 2021 05:06:09 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id p15so10371893ljc.13;
        Mon, 01 Mar 2021 05:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VujvNU5gkGh8Pljx9TCvrSDzDk91YAsVGtOYN6l9ETU=;
        b=p0fhgrvKk+7Z5ed+CZqSfsvHdEoVYfZkcS0lddSeHytytR+UHxRPRFjOOOnF2FvqSK
         7TatC3kyWOx9dkWWP22y9MUQeHgWNnWeLuaiEXNXo8HBF292aKOE5KcwK6SdGRQFGeuQ
         Lp7ZNqd34pNcC3nq9cpy9cSD2pjag4Ph6nPXAK0ayQao5oWyLZ6oxbm0DvS/I27pYh19
         NfKc4qxY4HFtBPsGSKUvhNw12fvb70u4k8juZw8DjCPHDZZ9qRsbkLP/HmbslhSmvfFR
         RA793tTuQjsy+ueEdJyl5g32CFisbAUl1IWJvYCtutHytcmuH1xiM3yhCN1drs0BoqZg
         IVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VujvNU5gkGh8Pljx9TCvrSDzDk91YAsVGtOYN6l9ETU=;
        b=RfhEu+UXM6Np9Rt9WWIrQpmfAWBOt9AeYKMd0q05bWqM+XqN11IpiRrsyt7N9/Djyc
         N0HZYdvG1njnA9nAJjwe/YQ1by3bp8b0UAa0GfUn3AYDvecZ9Th77WakulKSo8v0UuOs
         tC+FgOLcQ15pUFFrdQ9m+iknm16zkaThQ5D/Em/zJW7RkLkj/JsNxYwdyjkvejqMuejE
         /7WXnNp8qC3DTQRnPqzl3XKq0pTylW3qo3HB2A+svFiKlT9QPjmXdremAOOzcNNiFelU
         Jf4l3dObuHXcnhlrRMqkKXsekGLuVdpHx7r+UVBW9SxKQDpaYE27kQQWbMer9OXkC4Dn
         ptHQ==
X-Gm-Message-State: AOAM530px+Gu6L/w7+6vI7dTFjdAz0xxZPdFgfjkqHmthgORD5VuWu8L
        Dc4ML/lpqQL21mEo+KqtU4BmYMIQsM5ktiVH
X-Google-Smtp-Source: ABdhPJwT2wUF1IGLJJNt9JMPF/8shK0jlua2kPyVav5n7FBYm2nIg3H6jgoZ7QjKvDifUZPHym2YNA==
X-Received: by 2002:a2e:7f1e:: with SMTP id a30mr8869716ljd.260.1614603967150;
        Mon, 01 Mar 2021 05:06:07 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id j18sm2294289lfe.145.2021.03.01.05.06.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 05:06:05 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     gschmottlach@gmail.com, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] usb: gadget: f_uac2: add volume and mute support
Date:   Mon,  1 Mar 2021 15:05:42 +0200
Message-Id: <1614603943-11668-8-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds bi-directional (host->device, device->host)
volume/mute support to the f_uac2 driver by adding
Feature Units and interrupt endpoint.

Currently only master channel is supported.

Volume and mute are configurable through configfs,
by default volume has -100..0 dB range with 1 dB step.

Similar to existing flexible endpoints configuration,
Feature Unit won't be added to the topology if both
mute and volume are not enabled, also interrupt endpoint
isn't added to the device if no feature unit is present

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 Documentation/ABI/testing/configfs-usb-gadget-uac2 |  10 +
 Documentation/usb/gadget-testing.rst               |  10 +
 drivers/usb/gadget/function/f_uac2.c               | 640 +++++++++++++++++++--
 drivers/usb/gadget/function/u_uac2.h               |  21 +
 4 files changed, 623 insertions(+), 58 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac2 b/Documentation/ABI/testing/configfs-usb-gadget-uac2
index e7e59d7..9242234 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac2
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac2
@@ -9,7 +9,17 @@ Description:
 		c_srate    capture sampling rate
 		c_ssize    capture sample size (bytes)
 		c_sync     capture synchronization type (async/adaptive)
+		c_mute_present	capture mute control enable
+		c_volume_present	capture volume control enable
+		c_volume_min	capture volume control min value (in 1/256 dB)
+		c_volume_max	capture volume control max value (in 1/256 dB)
+		c_volume_res	capture volume control resolution (in 1/256 dB)
 		p_chmask   playback channel mask
 		p_srate    playback sampling rate
 		p_ssize    playback sample size (bytes)
+		p_mute_present	playback mute control enable
+		p_volume_present	playback volume control enable
+		p_volume_min	playback volume control min value (in 1/256 dB)
+		p_volume_max	playback volume control max value (in 1/256 dB)
+		p_volume_res	playback volume control resolution (in 1/256 dB)
 		=========  ============================
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index f5a1266..26adb0b 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -729,9 +729,19 @@ The uac2 function provides these attributes in its function directory:
 	c_srate		capture sampling rate
 	c_ssize		capture sample size (bytes)
 	c_sync		capture synchronization type (async/adaptive)
+	c_mute_present	capture mute control enable
+	c_volume_present	capture volume control enable
+	c_volume_min	capture volume control min value (in 1/256 dB)
+	c_volume_max	capture volume control max value (in 1/256 dB)
+	c_volume_res	capture volume control resolution (in 1/256 dB)
 	p_chmask	playback channel mask
 	p_srate		playback sampling rate
 	p_ssize		playback sample size (bytes)
+	p_mute_present	playback mute control enable
+	p_volume_present	playback volume control enable
+	p_volume_min	playback volume control min value (in 1/256 dB)
+	p_volume_max	playback volume control max value (in 1/256 dB)
+	p_volume_res	playback volume control resolution (in 1/256 dB)
 	req_number	the number of pre-allocated request for both capture
 			and playback
 	=============== ====================================================
diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 91b22fb..57f6bcb6 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -5,6 +5,9 @@
  * Copyright (C) 2011
  *    Yadwinder Singh (yadi.brar01@gmail.com)
  *    Jaswinder Singh (jaswinder.singh@linaro.org)
+ *
+ * Copyright (C) 2020
+ *    Ruslan Bilovol (ruslan.bilovol@gmail.com)
  */
 
 #include <linux/usb/audio.h>
@@ -19,14 +22,16 @@
 
 /*
  * The driver implements a simple UAC_2 topology.
- * USB-OUT -> IT_1 -> OT_3 -> ALSA_Capture
- * ALSA_Playback -> IT_2 -> OT_4 -> USB-IN
+ * USB-OUT -> IT_1 -> FU -> OT_3 -> ALSA_Capture
+ * ALSA_Playback -> IT_2 -> FU -> OT_4 -> USB-IN
  * Capture and Playback sampling rates are independently
  *  controlled by two clock sources :
  *    CLK_5 := c_srate, and CLK_6 := p_srate
  */
 #define USB_OUT_CLK_ID	(out_clk_src_desc.bClockID)
 #define USB_IN_CLK_ID	(in_clk_src_desc.bClockID)
+#define USB_OUT_FU_ID	(out_feature_unit_desc->bUnitID)
+#define USB_IN_FU_ID	(in_feature_unit_desc->bUnitID)
 
 #define CONTROL_ABSENT	0
 #define CONTROL_RDONLY	1
@@ -34,6 +39,8 @@
 
 #define CLK_FREQ_CTRL	0
 #define CLK_VLD_CTRL	2
+#define FU_MUTE_CTRL	0
+#define FU_VOL_CTRL	2
 
 #define COPY_CTRL	0
 #define CONN_CTRL	2
@@ -44,12 +51,24 @@
 
 #define EPIN_EN(_opts) ((_opts)->p_chmask != 0)
 #define EPOUT_EN(_opts) ((_opts)->c_chmask != 0)
+#define FUIN_EN(_opts) (EPIN_EN(_opts) \
+				&& ((_opts)->p_mute_present \
+				|| (_opts)->p_volume_present))
+#define FUOUT_EN(_opts) (EPOUT_EN(_opts) \
+				&& ((_opts)->c_mute_present \
+				|| (_opts)->c_volume_present))
 #define EPOUT_FBACK_IN_EN(_opts) ((_opts)->c_sync == USB_ENDPOINT_SYNC_ASYNC)
 
 struct f_uac2 {
 	struct g_audio g_audio;
 	u8 ac_intf, as_in_intf, as_out_intf;
 	u8 ac_alt, as_in_alt, as_out_alt;	/* needed for get_alt() */
+
+	struct usb_ctrlrequest setup_cr;	/* will be used in data stage */
+
+	/* Interrupt IN endpoint of AC interface */
+	struct usb_ep	*int_ep;
+	atomic_t	int_count;
 };
 
 static inline struct f_uac2 *func_to_uac2(struct usb_function *f)
@@ -63,6 +82,8 @@ struct f_uac2_opts *g_audio_to_uac2_opts(struct g_audio *agdev)
 	return container_of(agdev->func.fi, struct f_uac2_opts, func_inst);
 }
 
+static int afunc_notify(struct g_audio *agdev, int unit_id, int cs);
+
 /* --------- USB Function Interface ------------- */
 
 enum {
@@ -74,6 +95,8 @@ enum {
 	STR_IO_IT,
 	STR_USB_OT,
 	STR_IO_OT,
+	STR_FU_IN,
+	STR_FU_OUT,
 	STR_AS_OUT_ALT0,
 	STR_AS_OUT_ALT1,
 	STR_AS_IN_ALT0,
@@ -92,6 +115,8 @@ enum {
 	[STR_IO_IT].s = "USBD Out",
 	[STR_USB_OT].s = "USBH In",
 	[STR_IO_OT].s = "USBD In",
+	[STR_FU_IN].s = "Capture Volume",
+	[STR_FU_OUT].s = "Playback Volume",
 	[STR_AS_OUT_ALT0].s = "Playback Inactive",
 	[STR_AS_OUT_ALT1].s = "Playback Active",
 	[STR_AS_IN_ALT0].s = "Capture Inactive",
@@ -126,7 +151,7 @@ enum {
 	.bDescriptorType = USB_DT_INTERFACE,
 
 	.bAlternateSetting = 0,
-	.bNumEndpoints = 0,
+	/* .bNumEndpoints = DYNAMIC */
 	.bInterfaceClass = USB_CLASS_AUDIO,
 	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
 	.bInterfaceProtocol = UAC_VERSION_2,
@@ -212,6 +237,9 @@ enum {
 	.bmControls = cpu_to_le16(CONTROL_RDWR << COPY_CTRL),
 };
 
+static struct uac2_feature_unit_descriptor *in_feature_unit_desc;
+static struct uac2_feature_unit_descriptor *out_feature_unit_desc;
+
 static struct uac2_ac_header_descriptor ac_hdr_desc = {
 	.bLength = sizeof ac_hdr_desc,
 	.bDescriptorType = USB_DT_CS_INTERFACE,
@@ -223,6 +251,26 @@ enum {
 	.bmControls = 0,
 };
 
+/* AC IN Interrupt Endpoint */
+static struct usb_endpoint_descriptor fs_ep_int_desc = {
+	.bLength = USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+
+	.bEndpointAddress = USB_DIR_IN,
+	.bmAttributes = USB_ENDPOINT_XFER_INT,
+	.wMaxPacketSize = cpu_to_le16(6),
+	.bInterval = 1,
+};
+
+static struct usb_endpoint_descriptor hs_ep_int_desc = {
+	.bLength = USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+
+	.bmAttributes = USB_ENDPOINT_XFER_INT,
+	.wMaxPacketSize = cpu_to_le16(6),
+	.bInterval = 4,
+};
+
 /* Audio Streaming OUT Interface - Alt0 */
 static struct usb_interface_descriptor std_as_out_if0_desc = {
 	.bLength = sizeof std_as_out_if0_desc,
@@ -406,10 +454,14 @@ enum {
 	(struct usb_descriptor_header *)&in_clk_src_desc,
 	(struct usb_descriptor_header *)&out_clk_src_desc,
 	(struct usb_descriptor_header *)&usb_out_it_desc,
+	(struct usb_descriptor_header *)&out_feature_unit_desc,
 	(struct usb_descriptor_header *)&io_in_it_desc,
 	(struct usb_descriptor_header *)&usb_in_ot_desc,
+	(struct usb_descriptor_header *)&in_feature_unit_desc,
 	(struct usb_descriptor_header *)&io_out_ot_desc,
 
+	(struct usb_descriptor_header *)&fs_ep_int_desc,
+
 	(struct usb_descriptor_header *)&std_as_out_if0_desc,
 	(struct usb_descriptor_header *)&std_as_out_if1_desc,
 
@@ -437,10 +489,14 @@ enum {
 	(struct usb_descriptor_header *)&in_clk_src_desc,
 	(struct usb_descriptor_header *)&out_clk_src_desc,
 	(struct usb_descriptor_header *)&usb_out_it_desc,
+	(struct usb_descriptor_header *)&out_feature_unit_desc,
 	(struct usb_descriptor_header *)&io_in_it_desc,
 	(struct usb_descriptor_header *)&usb_in_ot_desc,
+	(struct usb_descriptor_header *)&in_feature_unit_desc,
 	(struct usb_descriptor_header *)&io_out_ot_desc,
 
+	(struct usb_descriptor_header *)&hs_ep_int_desc,
+
 	(struct usb_descriptor_header *)&std_as_out_if0_desc,
 	(struct usb_descriptor_header *)&std_as_out_if1_desc,
 
@@ -460,6 +516,17 @@ enum {
 	NULL,
 };
 
+struct cntrl_cur_lay2 {
+	__le16	wCUR;
+};
+
+struct cntrl_range_lay2 {
+	__le16	wNumSubRanges;
+	__le16	wMIN;
+	__le16	wMAX;
+	__le16	wRES;
+} __packed;
+
 struct cntrl_cur_lay3 {
 	__le32	dCUR;
 };
@@ -516,6 +583,26 @@ static int set_ep_max_packet_size(const struct f_uac2_opts *uac2_opts,
 	return 0;
 }
 
+static struct uac2_feature_unit_descriptor *build_fu_desc(int chmask)
+{
+	struct uac2_feature_unit_descriptor *fu_desc;
+	int channels = num_channels(chmask);
+	int fu_desc_size = UAC2_DT_FEATURE_UNIT_SIZE(channels);
+
+	fu_desc = kzalloc(fu_desc_size, GFP_KERNEL);
+	if (!fu_desc)
+		return NULL;
+
+	fu_desc->bLength = fu_desc_size;
+	fu_desc->bDescriptorType = USB_DT_CS_INTERFACE;
+
+	fu_desc->bDescriptorSubtype = UAC_FEATURE_UNIT;
+
+	/* bUnitID, bSourceID and bmaControls will be defined later */
+
+	return fu_desc;
+}
+
 /* Use macro to overcome line length limitation */
 #define USBDHDR(p) (struct usb_descriptor_header *)(p)
 
@@ -532,17 +619,35 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 		io_out_ot_desc.bTerminalID = i++;
 	if (EPIN_EN(opts))
 		usb_in_ot_desc.bTerminalID = i++;
+	if (FUOUT_EN(opts))
+		out_feature_unit_desc->bUnitID = i++;
+	if (FUIN_EN(opts))
+		in_feature_unit_desc->bUnitID = i++;
 	if (EPOUT_EN(opts))
 		out_clk_src_desc.bClockID = i++;
 	if (EPIN_EN(opts))
 		in_clk_src_desc.bClockID = i++;
 
 	usb_out_it_desc.bCSourceID = out_clk_src_desc.bClockID;
-	usb_in_ot_desc.bSourceID = io_in_it_desc.bTerminalID;
+
+	if (FUIN_EN(opts)) {
+		usb_in_ot_desc.bSourceID = in_feature_unit_desc->bUnitID;
+		in_feature_unit_desc->bSourceID = io_in_it_desc.bTerminalID;
+	} else {
+		usb_in_ot_desc.bSourceID = io_in_it_desc.bTerminalID;
+	}
+
 	usb_in_ot_desc.bCSourceID = in_clk_src_desc.bClockID;
 	io_in_it_desc.bCSourceID = in_clk_src_desc.bClockID;
 	io_out_ot_desc.bCSourceID = out_clk_src_desc.bClockID;
-	io_out_ot_desc.bSourceID = usb_out_it_desc.bTerminalID;
+
+	if (FUOUT_EN(opts)) {
+		io_out_ot_desc.bSourceID = out_feature_unit_desc->bUnitID;
+		out_feature_unit_desc->bSourceID = usb_out_it_desc.bTerminalID;
+	} else {
+		io_out_ot_desc.bSourceID = usb_out_it_desc.bTerminalID;
+	}
+
 	as_out_hdr_desc.bTerminalLink = usb_out_it_desc.bTerminalID;
 	as_in_hdr_desc.bTerminalLink = usb_in_ot_desc.bTerminalID;
 
@@ -556,6 +661,10 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 
 		len += sizeof(in_clk_src_desc);
 		len += sizeof(usb_in_ot_desc);
+
+		if (FUIN_EN(opts))
+			len += in_feature_unit_desc->bLength;
+
 		len += sizeof(io_in_it_desc);
 		ac_hdr_desc.wTotalLength = cpu_to_le16(len);
 		iad_desc.bInterfaceCount++;
@@ -565,6 +674,10 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 
 		len += sizeof(out_clk_src_desc);
 		len += sizeof(usb_out_it_desc);
+
+		if (FUOUT_EN(opts))
+			len += out_feature_unit_desc->bLength;
+
 		len += sizeof(io_out_ot_desc);
 		ac_hdr_desc.wTotalLength = cpu_to_le16(len);
 		iad_desc.bInterfaceCount++;
@@ -592,13 +705,25 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 	if (EPOUT_EN(opts)) {
 		fs_audio_desc[i++] = USBDHDR(&out_clk_src_desc);
 		fs_audio_desc[i++] = USBDHDR(&usb_out_it_desc);
+
+		if (FUOUT_EN(opts))
+			fs_audio_desc[i++] = USBDHDR(out_feature_unit_desc);
 	}
 	if (EPIN_EN(opts)) {
 		fs_audio_desc[i++] = USBDHDR(&io_in_it_desc);
+
+		if (FUIN_EN(opts))
+			fs_audio_desc[i++] = USBDHDR(in_feature_unit_desc);
+
 		fs_audio_desc[i++] = USBDHDR(&usb_in_ot_desc);
 	}
-	if (EPOUT_EN(opts)) {
+	if (EPOUT_EN(opts))
 		fs_audio_desc[i++] = USBDHDR(&io_out_ot_desc);
+
+	if (FUOUT_EN(opts) || FUIN_EN(opts))
+		fs_audio_desc[i++] = USBDHDR(&fs_ep_int_desc);
+
+	if (EPOUT_EN(opts)) {
 		fs_audio_desc[i++] = USBDHDR(&std_as_out_if0_desc);
 		fs_audio_desc[i++] = USBDHDR(&std_as_out_if1_desc);
 		fs_audio_desc[i++] = USBDHDR(&as_out_hdr_desc);
@@ -627,13 +752,25 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 	if (EPOUT_EN(opts)) {
 		hs_audio_desc[i++] = USBDHDR(&out_clk_src_desc);
 		hs_audio_desc[i++] = USBDHDR(&usb_out_it_desc);
+
+		if (FUOUT_EN(opts))
+			hs_audio_desc[i++] = USBDHDR(out_feature_unit_desc);
 	}
 	if (EPIN_EN(opts)) {
 		hs_audio_desc[i++] = USBDHDR(&io_in_it_desc);
+
+		if (FUIN_EN(opts))
+			hs_audio_desc[i++] = USBDHDR(in_feature_unit_desc);
+
 		hs_audio_desc[i++] = USBDHDR(&usb_in_ot_desc);
 	}
-	if (EPOUT_EN(opts)) {
+	if (EPOUT_EN(opts))
 		hs_audio_desc[i++] = USBDHDR(&io_out_ot_desc);
+
+	if (FUOUT_EN(opts) || FUIN_EN(opts))
+		hs_audio_desc[i++] = USBDHDR(&hs_ep_int_desc);
+
+	if (EPOUT_EN(opts)) {
 		hs_audio_desc[i++] = USBDHDR(&std_as_out_if0_desc);
 		hs_audio_desc[i++] = USBDHDR(&std_as_out_if1_desc);
 		hs_audio_desc[i++] = USBDHDR(&as_out_hdr_desc);
@@ -681,6 +818,28 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 		return -EINVAL;
 	}
 
+	if (opts->p_volume_max <= opts->p_volume_min) {
+		dev_err(dev, "Error: incorrect playback volume max/min\n");
+			return -EINVAL;
+	} else if (opts->c_volume_max <= opts->c_volume_min) {
+		dev_err(dev, "Error: incorrect capture volume max/min\n");
+			return -EINVAL;
+	} else if (opts->p_volume_res <= 0) {
+		dev_err(dev, "Error: negative/zero playback volume resolution\n");
+			return -EINVAL;
+	} else if (opts->c_volume_res <= 0) {
+		dev_err(dev, "Error: negative/zero capture volume resolution\n");
+			return -EINVAL;
+	}
+
+	if ((opts->p_volume_max - opts->p_volume_min) % opts->p_volume_res) {
+		dev_err(dev, "Error: incorrect playback volume resolution\n");
+			return -EINVAL;
+	} else if ((opts->c_volume_max - opts->c_volume_min) % opts->c_volume_res) {
+		dev_err(dev, "Error: incorrect capture volume resolution\n");
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -703,6 +862,20 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 	us = usb_gstrings_attach(cdev, fn_strings, ARRAY_SIZE(strings_fn));
 	if (IS_ERR(us))
 		return PTR_ERR(us);
+
+	if (FUOUT_EN(uac2_opts)) {
+		out_feature_unit_desc = build_fu_desc(uac2_opts->c_chmask);
+		if (!out_feature_unit_desc)
+			return -ENOMEM;
+	}
+	if (FUIN_EN(uac2_opts)) {
+		in_feature_unit_desc = build_fu_desc(uac2_opts->p_chmask);
+		if (!in_feature_unit_desc) {
+			ret = -ENOMEM;
+			goto err_free_fu;
+		}
+	}
+
 	iad_desc.iFunction = us[STR_ASSOC].id;
 	std_ac_if_desc.iInterface = us[STR_IF_CTRL].id;
 	in_clk_src_desc.iClockSource = us[STR_CLKSRC_IN].id;
@@ -716,6 +889,21 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 	std_as_in_if0_desc.iInterface = us[STR_AS_IN_ALT0].id;
 	std_as_in_if1_desc.iInterface = us[STR_AS_IN_ALT1].id;
 
+	if (FUOUT_EN(uac2_opts)) {
+		u8 *i_feature = (u8 *)out_feature_unit_desc;
+
+		i_feature = (u8 *)out_feature_unit_desc +
+					out_feature_unit_desc->bLength - 1;
+		*i_feature = us[STR_FU_OUT].id;
+	}
+	if (FUIN_EN(uac2_opts)) {
+		u8 *i_feature = (u8 *)in_feature_unit_desc;
+
+		i_feature = (u8 *)in_feature_unit_desc +
+					in_feature_unit_desc->bLength - 1;
+		*i_feature = us[STR_FU_IN].id;
+	}
+
 
 	/* Initialize the configurable parameters */
 	usb_out_it_desc.bNrChannels = num_channels(uac2_opts->c_chmask);
@@ -730,6 +918,26 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 	as_out_fmt1_desc.bBitResolution = uac2_opts->c_ssize * 8;
 	as_in_fmt1_desc.bSubslotSize = uac2_opts->p_ssize;
 	as_in_fmt1_desc.bBitResolution = uac2_opts->p_ssize * 8;
+	if (FUOUT_EN(uac2_opts)) {
+		__le32 *bma = (__le32 *)&out_feature_unit_desc->bmaControls[0];
+		u32 control = 0;
+
+		if (uac2_opts->c_mute_present)
+			control |= CONTROL_RDWR << FU_MUTE_CTRL;
+		if (uac2_opts->c_volume_present)
+			control |= CONTROL_RDWR << FU_VOL_CTRL;
+		*bma = cpu_to_le32(control);
+	}
+	if (FUIN_EN(uac2_opts)) {
+		__le32 *bma = (__le32 *)&in_feature_unit_desc->bmaControls[0];
+		u32 control = 0;
+
+		if (uac2_opts->p_mute_present)
+			control |= CONTROL_RDWR << FU_MUTE_CTRL;
+		if (uac2_opts->p_volume_present)
+			control |= CONTROL_RDWR << FU_VOL_CTRL;
+		*bma = cpu_to_le32(control);
+	}
 
 	snprintf(clksrc_in, sizeof(clksrc_in), "%uHz", uac2_opts->p_srate);
 	snprintf(clksrc_out, sizeof(clksrc_out), "%uHz", uac2_opts->c_srate);
@@ -737,7 +945,7 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 	ret = usb_interface_id(cfg, fn);
 	if (ret < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		return ret;
+		goto err_free_fu;
 	}
 	iad_desc.bFirstInterface = ret;
 
@@ -749,7 +957,7 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 		ret = usb_interface_id(cfg, fn);
 		if (ret < 0) {
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-			return ret;
+			goto err_free_fu;
 		}
 		std_as_out_if0_desc.bInterfaceNumber = ret;
 		std_as_out_if1_desc.bInterfaceNumber = ret;
@@ -761,7 +969,7 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 		ret = usb_interface_id(cfg, fn);
 		if (ret < 0) {
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-			return ret;
+			goto err_free_fu;
 		}
 		std_as_in_if0_desc.bInterfaceNumber = ret;
 		std_as_in_if1_desc.bInterfaceNumber = ret;
@@ -769,6 +977,17 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 		uac2->as_in_alt = 0;
 	}
 
+	if (FUOUT_EN(uac2_opts) || FUIN_EN(uac2_opts)) {
+		uac2->int_ep = usb_ep_autoconfig(gadget, &fs_ep_int_desc);
+		if (!uac2->int_ep) {
+			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+			ret = -ENODEV;
+			goto err_free_fu;
+		}
+
+		std_ac_if_desc.bNumEndpoints = 1;
+	}
+
 	/* Calculate wMaxPacketSize according to audio bandwidth */
 	ret = set_ep_max_packet_size(uac2_opts, &fs_epin_desc, USB_SPEED_FULL,
 				     true);
@@ -804,7 +1023,8 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 		agdev->out_ep = usb_ep_autoconfig(gadget, &fs_epout_desc);
 		if (!agdev->out_ep) {
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_free_fu;
 		}
 		if (EPOUT_FBACK_IN_EN(uac2_opts)) {
 			agdev->in_ep_fback = usb_ep_autoconfig(gadget,
@@ -812,7 +1032,8 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 			if (!agdev->in_ep_fback) {
 				dev_err(dev, "%s:%d Error!\n",
 					__func__, __LINE__);
-				return -ENODEV;
+				ret = -ENODEV;
+				goto err_free_fu;
 			}
 		}
 	}
@@ -821,7 +1042,8 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 		agdev->in_ep = usb_ep_autoconfig(gadget, &fs_epin_desc);
 		if (!agdev->in_ep) {
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_free_fu;
 		}
 	}
 
@@ -832,6 +1054,7 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 				le16_to_cpu(fs_epout_desc.wMaxPacketSize),
 				le16_to_cpu(hs_epout_desc.wMaxPacketSize));
 
+	hs_ep_int_desc.bEndpointAddress = fs_ep_int_desc.bEndpointAddress;
 	hs_epout_desc.bEndpointAddress = fs_epout_desc.bEndpointAddress;
 	hs_epin_fback_desc.bEndpointAddress = fs_epin_fback_desc.bEndpointAddress;
 	hs_epin_desc.bEndpointAddress = fs_epin_desc.bEndpointAddress;
@@ -839,25 +1062,121 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 	ret = usb_assign_descriptors(fn, fs_audio_desc, hs_audio_desc, NULL,
 				     NULL);
 	if (ret)
-		return ret;
+		goto err_free_fu;
 
 	agdev->gadget = gadget;
 
 	agdev->params.p_chmask = uac2_opts->p_chmask;
 	agdev->params.p_srate = uac2_opts->p_srate;
 	agdev->params.p_ssize = uac2_opts->p_ssize;
+	if (FUIN_EN(uac2_opts)) {
+		agdev->params.p_fu.id = USB_IN_FU_ID;
+		agdev->params.p_fu.mute_present = uac2_opts->p_mute_present;
+		agdev->params.p_fu.volume_present = uac2_opts->p_volume_present;
+		agdev->params.p_fu.volume_min = uac2_opts->p_volume_min;
+		agdev->params.p_fu.volume_max = uac2_opts->p_volume_max;
+		agdev->params.p_fu.volume_res = uac2_opts->p_volume_res;
+	}
 	agdev->params.c_chmask = uac2_opts->c_chmask;
 	agdev->params.c_srate = uac2_opts->c_srate;
 	agdev->params.c_ssize = uac2_opts->c_ssize;
+	if (FUOUT_EN(uac2_opts)) {
+		agdev->params.c_fu.id = USB_OUT_FU_ID;
+		agdev->params.c_fu.mute_present = uac2_opts->c_mute_present;
+		agdev->params.c_fu.volume_present = uac2_opts->c_volume_present;
+		agdev->params.c_fu.volume_min = uac2_opts->c_volume_min;
+		agdev->params.c_fu.volume_max = uac2_opts->c_volume_max;
+		agdev->params.c_fu.volume_res = uac2_opts->c_volume_res;
+	}
 	agdev->params.req_number = uac2_opts->req_number;
+
+	if (FUOUT_EN(uac2_opts) || FUIN_EN(uac2_opts))
+		agdev->notify = afunc_notify;
+
 	ret = g_audio_setup(agdev, "UAC2 PCM", "UAC2_Gadget");
 	if (ret)
 		goto err_free_descs;
+
 	return 0;
 
 err_free_descs:
 	usb_free_all_descriptors(fn);
 	agdev->gadget = NULL;
+err_free_fu:
+	kfree(out_feature_unit_desc);
+	out_feature_unit_desc = NULL;
+	kfree(in_feature_unit_desc);
+	in_feature_unit_desc = NULL;
+	return ret;
+}
+
+static void
+afunc_notify_complete(struct usb_ep *_ep, struct usb_request *req)
+{
+	struct g_audio *agdev = req->context;
+	struct f_uac2 *uac2 = func_to_uac2(&agdev->func);
+
+	atomic_dec(&uac2->int_count);
+	kfree(req->buf);
+	usb_ep_free_request(_ep, req);
+}
+
+static int
+afunc_notify(struct g_audio *agdev, int unit_id, int cs)
+{
+	struct f_uac2 *uac2 = func_to_uac2(&agdev->func);
+	struct usb_request *req;
+	struct uac2_interrupt_data_msg *msg;
+	u16 w_index, w_value;
+	int ret;
+
+	if (!uac2->int_ep->enabled)
+		return 0;
+
+	if (atomic_inc_return(&uac2->int_count) > UAC2_DEF_INT_REQ_NUM) {
+		atomic_dec(&uac2->int_count);
+		return 0;
+	}
+
+	req = usb_ep_alloc_request(uac2->int_ep, GFP_ATOMIC);
+	if (req == NULL) {
+		ret = -ENOMEM;
+		goto err_dec_int_count;
+	}
+
+	msg = kzalloc(sizeof(*msg), GFP_ATOMIC);
+	if (msg == NULL) {
+		ret = -ENOMEM;
+		goto err_free_request;
+	}
+
+	w_index = unit_id << 8 | uac2->ac_intf;
+	w_value = cs << 8;
+
+	msg->bInfo = 0; /* Non-vendor, interface interrupt */
+	msg->bAttribute = UAC2_CS_CUR;
+	msg->wIndex = cpu_to_le16(w_index);
+	msg->wValue = cpu_to_le16(w_value);
+
+	req->length = sizeof(*msg);
+	req->buf = msg;
+	req->context = agdev;
+	req->complete = afunc_notify_complete;
+
+	ret = usb_ep_queue(uac2->int_ep, req, GFP_ATOMIC);
+
+	if (ret)
+		goto err_free_msg;
+
+	return 0;
+
+err_free_msg:
+	kfree(msg);
+err_free_request:
+	usb_ep_free_request(uac2->int_ep, req);
+err_dec_int_count:
+	atomic_dec(&uac2->int_count);
+
 	return ret;
 }
 
@@ -866,6 +1185,7 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 {
 	struct usb_composite_dev *cdev = fn->config->cdev;
 	struct f_uac2 *uac2 = func_to_uac2(fn);
+	struct g_audio *agdev = func_to_g_audio(fn);
 	struct usb_gadget *gadget = cdev->gadget;
 	struct device *dev = &gadget->dev;
 	int ret = 0;
@@ -882,6 +1202,14 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 			return -EINVAL;
 		}
+
+		/* restart interrupt endpoint */
+		if (uac2->int_ep) {
+			usb_ep_disable(uac2->int_ep);
+			config_ep_by_speed(gadget, &agdev->func, uac2->int_ep);
+			usb_ep_enable(uac2->int_ep);
+		}
+
 		return 0;
 	}
 
@@ -936,6 +1264,8 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 	uac2->as_out_alt = 0;
 	u_audio_stop_capture(&uac2->g_audio);
 	u_audio_stop_playback(&uac2->g_audio);
+	if (uac2->int_ep)
+		usb_ep_disable(uac2->int_ep);
 }
 
 static int
@@ -956,24 +1286,61 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 	p_srate = opts->p_srate;
 	c_srate = opts->c_srate;
 
-	if (control_selector == UAC2_CS_CONTROL_SAM_FREQ) {
-		struct cntrl_cur_lay3 c;
-		memset(&c, 0, sizeof(struct cntrl_cur_lay3));
+	if ((entity_id == USB_IN_CLK_ID) || (entity_id == USB_OUT_CLK_ID)) {
+		if (control_selector == UAC2_CS_CONTROL_SAM_FREQ) {
+			struct cntrl_cur_lay3 c;
+
+			memset(&c, 0, sizeof(struct cntrl_cur_lay3));
+
+			if (entity_id == USB_IN_CLK_ID)
+				c.dCUR = cpu_to_le32(p_srate);
+			else if (entity_id == USB_OUT_CLK_ID)
+				c.dCUR = cpu_to_le32(c_srate);
+
+			value = min_t(unsigned int, w_length, sizeof(c));
+			memcpy(req->buf, &c, value);
+		} else if (control_selector == UAC2_CS_CONTROL_CLOCK_VALID) {
+			*(u8 *)req->buf = 1;
+			value = min_t(unsigned int, w_length, 1);
+		} else {
+			dev_err(&agdev->gadget->dev,
+				"%s:%d control_selector=%d TODO!\n",
+				__func__, __LINE__, control_selector);
+		}
+	} else if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+		unsigned int is_playback = 0;
+
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+			is_playback = 1;
+
+		if (control_selector == UAC_FU_MUTE) {
+			unsigned int mute;
+
+			u_audio_get_mute(agdev, is_playback, &mute);
+
+			*(u8 *)req->buf = mute;
+			value = min_t(unsigned int, w_length, 1);
+		} else if (control_selector == UAC_FU_VOLUME) {
+			struct cntrl_cur_lay2 c;
+			s16 volume;
 
-		if (entity_id == USB_IN_CLK_ID)
-			c.dCUR = cpu_to_le32(p_srate);
-		else if (entity_id == USB_OUT_CLK_ID)
-			c.dCUR = cpu_to_le32(c_srate);
+			memset(&c, 0, sizeof(struct cntrl_cur_lay2));
 
-		value = min_t(unsigned, w_length, sizeof c);
-		memcpy(req->buf, &c, value);
-	} else if (control_selector == UAC2_CS_CONTROL_CLOCK_VALID) {
-		*(u8 *)req->buf = 1;
-		value = min_t(unsigned, w_length, 1);
+			u_audio_get_volume(agdev, is_playback, &volume);
+			c.wCUR = cpu_to_le16(volume);
+
+			value = min_t(unsigned int, w_length, sizeof(c));
+			memcpy(req->buf, &c, value);
+		} else {
+			dev_err(&agdev->gadget->dev,
+				"%s:%d control_selector=%d TODO!\n",
+				__func__, __LINE__, control_selector);
+		}
 	} else {
 		dev_err(&agdev->gadget->dev,
-			"%s:%d control_selector=%d TODO!\n",
-			__func__, __LINE__, control_selector);
+			"%s:%d entity_id=%d control_selector=%d TODO!\n",
+			__func__, __LINE__, entity_id, control_selector);
 	}
 
 	return value;
@@ -984,38 +1351,77 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 {
 	struct usb_request *req = fn->config->cdev->req;
 	struct g_audio *agdev = func_to_g_audio(fn);
-	struct f_uac2_opts *opts;
+	struct f_uac2_opts *opts = g_audio_to_uac2_opts(agdev);
 	u16 w_length = le16_to_cpu(cr->wLength);
 	u16 w_index = le16_to_cpu(cr->wIndex);
 	u16 w_value = le16_to_cpu(cr->wValue);
 	u8 entity_id = (w_index >> 8) & 0xff;
 	u8 control_selector = w_value >> 8;
-	struct cntrl_range_lay3 r;
 	int value = -EOPNOTSUPP;
 	int p_srate, c_srate;
 
-	opts = g_audio_to_uac2_opts(agdev);
 	p_srate = opts->p_srate;
 	c_srate = opts->c_srate;
 
-	if (control_selector == UAC2_CS_CONTROL_SAM_FREQ) {
-		if (entity_id == USB_IN_CLK_ID)
-			r.dMIN = cpu_to_le32(p_srate);
-		else if (entity_id == USB_OUT_CLK_ID)
-			r.dMIN = cpu_to_le32(c_srate);
-		else
-			return -EOPNOTSUPP;
+	if ((entity_id == USB_IN_CLK_ID) || (entity_id == USB_OUT_CLK_ID)) {
+		if (control_selector == UAC2_CS_CONTROL_SAM_FREQ) {
+			struct cntrl_range_lay3 r;
+
+			if (entity_id == USB_IN_CLK_ID)
+				r.dMIN = cpu_to_le32(p_srate);
+			else if (entity_id == USB_OUT_CLK_ID)
+				r.dMIN = cpu_to_le32(c_srate);
+			else
+				return -EOPNOTSUPP;
 
-		r.dMAX = r.dMIN;
-		r.dRES = 0;
-		r.wNumSubRanges = cpu_to_le16(1);
+			r.dMAX = r.dMIN;
+			r.dRES = 0;
+			r.wNumSubRanges = cpu_to_le16(1);
 
-		value = min_t(unsigned, w_length, sizeof r);
-		memcpy(req->buf, &r, value);
+			value = min_t(unsigned int, w_length, sizeof(r));
+			memcpy(req->buf, &r, value);
+		} else {
+			dev_err(&agdev->gadget->dev,
+				"%s:%d control_selector=%d TODO!\n",
+				__func__, __LINE__, control_selector);
+		}
+	} else if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+		unsigned int is_playback = 0;
+
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+			is_playback = 1;
+
+		if (control_selector == UAC_FU_VOLUME) {
+			struct cntrl_range_lay2 r;
+			s16 max_db, min_db, res_db;
+
+			if (is_playback) {
+				max_db = opts->p_volume_max;
+				min_db = opts->p_volume_min;
+				res_db = opts->p_volume_res;
+			} else {
+				max_db = opts->c_volume_max;
+				min_db = opts->c_volume_min;
+				res_db = opts->c_volume_res;
+			}
+
+			r.wMAX = cpu_to_le16(max_db);
+			r.wMIN = cpu_to_le16(min_db);
+			r.wRES = cpu_to_le16(res_db);
+			r.wNumSubRanges = cpu_to_le16(1);
+
+			value = min_t(unsigned int, w_length, sizeof(r));
+			memcpy(req->buf, &r, value);
+		} else {
+			dev_err(&agdev->gadget->dev,
+				"%s:%d control_selector=%d TODO!\n",
+				__func__, __LINE__, control_selector);
+		}
 	} else {
 		dev_err(&agdev->gadget->dev,
-			"%s:%d control_selector=%d TODO!\n",
-			__func__, __LINE__, control_selector);
+			"%s:%d entity_id=%d control_selector=%d TODO!\n",
+			__func__, __LINE__, entity_id, control_selector);
 	}
 
 	return value;
@@ -1032,16 +1438,82 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 		return -EOPNOTSUPP;
 }
 
+static void
+out_rq_cur_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	struct g_audio *agdev = req->context;
+	struct usb_composite_dev *cdev = agdev->func.config->cdev;
+	struct f_uac2_opts *opts = g_audio_to_uac2_opts(agdev);
+	struct f_uac2 *uac2 = func_to_uac2(&agdev->func);
+	struct usb_ctrlrequest *cr = &uac2->setup_cr;
+	u16 w_index = le16_to_cpu(cr->wIndex);
+	u16 w_value = le16_to_cpu(cr->wValue);
+	u8 entity_id = (w_index >> 8) & 0xff;
+	u8 control_selector = w_value >> 8;
+
+	if (req->status != 0) {
+		dev_dbg(&cdev->gadget->dev, "completion err %d\n", req->status);
+		return;
+	}
+
+	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
+		(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+		unsigned int is_playback = 0;
+
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+			is_playback = 1;
+
+		if (control_selector == UAC_FU_MUTE) {
+			u8 mute = *(u8 *)req->buf;
+
+			u_audio_set_mute(agdev, is_playback, mute);
+
+			return;
+		} else if (control_selector == UAC_FU_VOLUME) {
+			struct cntrl_cur_lay2 *c = req->buf;
+			s16 volume;
+
+			volume = le16_to_cpu(c->wCUR);
+			u_audio_set_volume(agdev, is_playback, volume);
+
+			return;
+		} else {
+			dev_err(&agdev->gadget->dev,
+				"%s:%d control_selector=%d TODO!\n",
+				__func__, __LINE__, control_selector);
+			usb_ep_set_halt(ep);
+		}
+	}
+}
+
 static int
 out_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 {
+	struct usb_request *req = fn->config->cdev->req;
+	struct g_audio *agdev = func_to_g_audio(fn);
+	struct f_uac2_opts *opts = g_audio_to_uac2_opts(agdev);
+	struct f_uac2 *uac2 = func_to_uac2(fn);
 	u16 w_length = le16_to_cpu(cr->wLength);
+	u16 w_index = le16_to_cpu(cr->wIndex);
 	u16 w_value = le16_to_cpu(cr->wValue);
+	u8 entity_id = (w_index >> 8) & 0xff;
 	u8 control_selector = w_value >> 8;
 
-	if (control_selector == UAC2_CS_CONTROL_SAM_FREQ)
-		return w_length;
+	if ((entity_id == USB_IN_CLK_ID) || (entity_id == USB_OUT_CLK_ID)) {
+		if (control_selector == UAC2_CS_CONTROL_SAM_FREQ)
+			return w_length;
+	} else if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+		memcpy(&uac2->setup_cr, cr, sizeof(*cr));
+		req->context = agdev;
+		req->complete = out_rq_cur_complete;
 
+		return w_length;
+	} else {
+		dev_err(&agdev->gadget->dev,
+			"%s:%d entity_id=%d control_selector=%d TODO!\n",
+			__func__, __LINE__, entity_id, control_selector);
+	}
 	return -EOPNOTSUPP;
 }
 
@@ -1117,7 +1589,15 @@ static void f_uac2_attr_release(struct config_item *item)
 	.release	= f_uac2_attr_release,
 };
 
-#define UAC2_ATTRIBUTE(name)						\
+#define uac2_kstrtou32 kstrtou32
+#define uac2_kstrtos16 kstrtos16
+#define uac2_kstrtobool(s, base, res) kstrtobool((s), (res))
+
+static const char *u32_fmt = "%u\n";
+static const char *s16_fmt = "%hd\n";
+static const char *bool_fmt = "%u\n";
+
+#define UAC2_ATTRIBUTE(type, name)					\
 static ssize_t f_uac2_opts_##name##_show(struct config_item *item,	\
 					 char *page)			\
 {									\
@@ -1125,7 +1605,7 @@ static void f_uac2_attr_release(struct config_item *item)
 	int result;							\
 									\
 	mutex_lock(&opts->lock);					\
-	result = sprintf(page, "%u\n", opts->name);			\
+	result = sprintf(page, type##_fmt, opts->name);			\
 	mutex_unlock(&opts->lock);					\
 									\
 	return result;							\
@@ -1136,7 +1616,7 @@ static void f_uac2_attr_release(struct config_item *item)
 {									\
 	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
 	int ret;							\
-	u32 num;							\
+	type num;							\
 									\
 	mutex_lock(&opts->lock);					\
 	if (opts->refcnt) {						\
@@ -1144,7 +1624,7 @@ static void f_uac2_attr_release(struct config_item *item)
 		goto end;						\
 	}								\
 									\
-	ret = kstrtou32(page, 0, &num);					\
+	ret = uac2_kstrto##type(page, 0, &num);				\
 	if (ret)							\
 		goto end;						\
 									\
@@ -1214,14 +1694,26 @@ static void f_uac2_attr_release(struct config_item *item)
 									\
 CONFIGFS_ATTR(f_uac2_opts_, name)
 
-UAC2_ATTRIBUTE(p_chmask);
-UAC2_ATTRIBUTE(p_srate);
-UAC2_ATTRIBUTE(p_ssize);
-UAC2_ATTRIBUTE(c_chmask);
-UAC2_ATTRIBUTE(c_srate);
+UAC2_ATTRIBUTE(u32, p_chmask);
+UAC2_ATTRIBUTE(u32, p_srate);
+UAC2_ATTRIBUTE(u32, p_ssize);
+UAC2_ATTRIBUTE(u32, c_chmask);
+UAC2_ATTRIBUTE(u32, c_srate);
 UAC2_ATTRIBUTE_SYNC(c_sync);
-UAC2_ATTRIBUTE(c_ssize);
-UAC2_ATTRIBUTE(req_number);
+UAC2_ATTRIBUTE(u32, c_ssize);
+UAC2_ATTRIBUTE(u32, req_number);
+
+UAC2_ATTRIBUTE(bool, p_mute_present);
+UAC2_ATTRIBUTE(bool, p_volume_present);
+UAC2_ATTRIBUTE(s16, p_volume_min);
+UAC2_ATTRIBUTE(s16, p_volume_max);
+UAC2_ATTRIBUTE(s16, p_volume_res);
+
+UAC2_ATTRIBUTE(bool, c_mute_present);
+UAC2_ATTRIBUTE(bool, c_volume_present);
+UAC2_ATTRIBUTE(s16, c_volume_min);
+UAC2_ATTRIBUTE(s16, c_volume_max);
+UAC2_ATTRIBUTE(s16, c_volume_res);
 
 static struct configfs_attribute *f_uac2_attrs[] = {
 	&f_uac2_opts_attr_p_chmask,
@@ -1232,6 +1724,19 @@ static void f_uac2_attr_release(struct config_item *item)
 	&f_uac2_opts_attr_c_ssize,
 	&f_uac2_opts_attr_c_sync,
 	&f_uac2_opts_attr_req_number,
+
+	&f_uac2_opts_attr_p_mute_present,
+	&f_uac2_opts_attr_p_volume_present,
+	&f_uac2_opts_attr_p_volume_min,
+	&f_uac2_opts_attr_p_volume_max,
+	&f_uac2_opts_attr_p_volume_res,
+
+	&f_uac2_opts_attr_c_mute_present,
+	&f_uac2_opts_attr_c_volume_present,
+	&f_uac2_opts_attr_c_volume_min,
+	&f_uac2_opts_attr_c_volume_max,
+	&f_uac2_opts_attr_c_volume_res,
+
 	NULL,
 };
 
@@ -1270,6 +1775,19 @@ static struct usb_function_instance *afunc_alloc_inst(void)
 	opts->c_srate = UAC2_DEF_CSRATE;
 	opts->c_ssize = UAC2_DEF_CSSIZE;
 	opts->c_sync = UAC2_DEF_CSYNC;
+
+	opts->p_mute_present = UAC2_DEF_MUTE_PRESENT;
+	opts->p_volume_present = UAC2_DEF_VOLUME_PRESENT;
+	opts->p_volume_min = UAC2_DEF_MIN_DB;
+	opts->p_volume_max = UAC2_DEF_MAX_DB;
+	opts->p_volume_res = UAC2_DEF_RES_DB;
+
+	opts->c_mute_present = UAC2_DEF_MUTE_PRESENT;
+	opts->c_volume_present = UAC2_DEF_VOLUME_PRESENT;
+	opts->c_volume_min = UAC2_DEF_MIN_DB;
+	opts->c_volume_max = UAC2_DEF_MAX_DB;
+	opts->c_volume_res = UAC2_DEF_RES_DB;
+
 	opts->req_number = UAC2_DEF_REQ_NUM;
 	return &opts->func_inst;
 }
@@ -1295,6 +1813,11 @@ static void afunc_unbind(struct usb_configuration *c, struct usb_function *f)
 	usb_free_all_descriptors(f);
 
 	agdev->gadget = NULL;
+
+	kfree(out_feature_unit_desc);
+	out_feature_unit_desc = NULL;
+	kfree(in_feature_unit_desc);
+	in_feature_unit_desc = NULL;
 }
 
 static struct usb_function *afunc_alloc(struct usb_function_instance *fi)
@@ -1327,3 +1850,4 @@ static struct usb_function *afunc_alloc(struct usb_function_instance *fi)
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Yadwinder Singh");
 MODULE_AUTHOR("Jaswinder Singh");
+MODULE_AUTHOR("Ruslan Bilovol");
diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
index 13589c3..e2c584c 100644
--- a/drivers/usb/gadget/function/u_uac2.h
+++ b/drivers/usb/gadget/function/u_uac2.h
@@ -22,7 +22,15 @@
 #define UAC2_DEF_CSRATE 64000
 #define UAC2_DEF_CSSIZE 2
 #define UAC2_DEF_CSYNC		USB_ENDPOINT_SYNC_ASYNC
+
+#define UAC2_DEF_MUTE_PRESENT	1
+#define UAC2_DEF_VOLUME_PRESENT 1
+#define UAC2_DEF_MIN_DB		(-100*256)	/* -100 dB */
+#define UAC2_DEF_MAX_DB		0		/* 0 dB */
+#define UAC2_DEF_RES_DB		(1*256)		/* 1 dB */
+
 #define UAC2_DEF_REQ_NUM 2
+#define UAC2_DEF_INT_REQ_NUM	10
 
 struct f_uac2_opts {
 	struct usb_function_instance	func_inst;
@@ -33,6 +41,19 @@ struct f_uac2_opts {
 	int				c_srate;
 	int				c_ssize;
 	int				c_sync;
+
+	bool				p_mute_present;
+	bool				p_volume_present;
+	s16				p_volume_min;
+	s16				p_volume_max;
+	s16				p_volume_res;
+
+	bool				c_mute_present;
+	bool				c_volume_present;
+	s16				c_volume_min;
+	s16				c_volume_max;
+	s16				c_volume_res;
+
 	int				req_number;
 	bool				bound;
 
-- 
1.9.1

