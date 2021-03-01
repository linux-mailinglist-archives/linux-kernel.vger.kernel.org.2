Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93224327DB3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhCALzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbhCALvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:51:36 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56123C06121E;
        Mon,  1 Mar 2021 03:50:35 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b1so14217753lfb.7;
        Mon, 01 Mar 2021 03:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uaGW7tC2JjBnOktvFMM63m8EOA/LiWD+e5WC31mYaBk=;
        b=qTxPtxpNonuWNMhbqKjbXTWw6Kwjym6JSJZmZKt+AMHHwgKROtKj494u89JcM3a2/7
         mGLOpjM69EbF5zvFXyo6ceJOwJqwet4f36DXf3udVGdOmzJWMKRUVwRnE5wzAFTkk2lq
         4aSvAtEUAegBsVpfvETYCW9K7I9a00Rxqr5Li+Xq7oulP++wK/yt87qOYVx93W+Ue0AL
         baUND4wuJqizwlfbYCwgirh1du/jErOGsxJ+S03PNc3imtcJ6WYYZwBEwwu+zB/AqUXk
         IaUWp9JfHsIDQ1jWBwqdh9p5XRmerjqHqhets6+xxZP/Uqwi6KbqynijlMWumYQw941x
         XVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uaGW7tC2JjBnOktvFMM63m8EOA/LiWD+e5WC31mYaBk=;
        b=lLu1BAkCBHtf2gfLGMrRt6islTOP6J1LSeiQl0lnCYUudsmb9BMC9jrgH9EP5e+gAP
         gVLdC1rAlS4Ft6yqOfw37mguAqefTECpkPFtGC7LIuUPYv50E3r7WcHJHCFCZRSS3rsd
         4IZNBl6beEevYxy8q2qMGzt9Ve6L1Rwe5BqVHMWo/nchnmxLAE9kYwOGM62XYI+QzllR
         /FCC4kPorzktIRspUcThw8EwofuE6hZI+xoM64wSct6xOFRZzIUm+t6pfFMOukdt22UX
         JEbNDaBCRFqO1Ub3tpoJj0wXUb6O0zuyK4eUKhrHpz0udrpzhdxVcPpgtlMTQVTfZO3e
         Qr1A==
X-Gm-Message-State: AOAM5302OE8Gn21udt6xewF+BSrc9BBQsjw5Pt2OiNcipd+va90+wCIU
        srSc9GxzC3PdNF1JWdENiDw=
X-Google-Smtp-Source: ABdhPJz1oJ1zKO66YIImBxNlFXxSqVoUta3F8d7Ag/YG4Hwpx365myKQ4z24TANQYAIprnm7efX13Q==
X-Received: by 2002:a19:5d56:: with SMTP id p22mr3648808lfj.265.1614599433838;
        Mon, 01 Mar 2021 03:50:33 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id o27sm2272176lfi.183.2021.03.01.03.50.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 03:50:33 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH v2 5/5] usb: gadget: f_uac1: disable IN/OUT ep if unused
Date:   Mon,  1 Mar 2021 13:49:35 +0200
Message-Id: <1614599375-8803-6-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1614599375-8803-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1614599375-8803-1-git-send-email-ruslan.bilovol@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User can configure f_uac1 function via p_chmask/c_chmask
whether uac1 shall support playback and/or capture,
but it has only effect on the created ALSA device,
but not on the USB descriptor.

This patch adds playback/capture descriptors
dependent on that parameter. It is similar to
the same conversion done earlier for f_uac2

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 drivers/usb/gadget/function/f_uac1.c | 229 +++++++++++++++++++++++++----------
 1 file changed, 163 insertions(+), 66 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index e65f474..d047075 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -22,6 +22,9 @@
 /* UAC1 spec: 3.7.2.3 Audio Channel Cluster Format */
 #define UAC1_CHANNEL_MASK 0x0FFF
 
+#define EPIN_EN(_opts) ((_opts)->p_chmask != 0)
+#define EPOUT_EN(_opts) ((_opts)->c_chmask != 0)
+
 struct f_uac1 {
 	struct g_audio g_audio;
 	u8 ac_intf, as_in_intf, as_out_intf;
@@ -50,11 +53,6 @@ static inline struct f_uac1_opts *g_audio_to_uac1_opts(struct g_audio *audio)
  * USB-OUT -> IT_1 -> OT_2 -> ALSA_Capture
  * ALSA_Playback -> IT_3 -> OT_4 -> USB-IN
  */
-#define F_AUDIO_AC_INTERFACE		0
-#define F_AUDIO_AS_OUT_INTERFACE	1
-#define F_AUDIO_AS_IN_INTERFACE		2
-/* Number of streaming interfaces */
-#define F_AUDIO_NUM_INTERFACES		2
 
 /* B.3.1  Standard AC Interface Descriptor */
 static struct usb_interface_descriptor ac_interface_desc = {
@@ -65,73 +63,47 @@ static inline struct f_uac1_opts *g_audio_to_uac1_opts(struct g_audio *audio)
 	.bInterfaceSubClass =	USB_SUBCLASS_AUDIOCONTROL,
 };
 
-/*
- * The number of AudioStreaming and MIDIStreaming interfaces
- * in the Audio Interface Collection
- */
-DECLARE_UAC_AC_HEADER_DESCRIPTOR(2);
-
-#define UAC_DT_AC_HEADER_LENGTH	UAC_DT_AC_HEADER_SIZE(F_AUDIO_NUM_INTERFACES)
-/* 2 input terminals and 2 output terminals */
-#define UAC_DT_TOTAL_LENGTH (UAC_DT_AC_HEADER_LENGTH \
-	+ 2*UAC_DT_INPUT_TERMINAL_SIZE + 2*UAC_DT_OUTPUT_TERMINAL_SIZE)
 /* B.3.2  Class-Specific AC Interface Descriptor */
-static struct uac1_ac_header_descriptor_2 ac_header_desc = {
-	.bLength =		UAC_DT_AC_HEADER_LENGTH,
-	.bDescriptorType =	USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype =	UAC_HEADER,
-	.bcdADC =		cpu_to_le16(0x0100),
-	.wTotalLength =		cpu_to_le16(UAC_DT_TOTAL_LENGTH),
-	.bInCollection =	F_AUDIO_NUM_INTERFACES,
-	.baInterfaceNr = {
-	/* Interface number of the AudioStream interfaces */
-		[0] =		1,
-		[1] =		2,
-	}
-};
+static struct uac1_ac_header_descriptor *ac_header_desc;
 
-#define USB_OUT_IT_ID	1
 static struct uac_input_terminal_descriptor usb_out_it_desc = {
 	.bLength =		UAC_DT_INPUT_TERMINAL_SIZE,
 	.bDescriptorType =	USB_DT_CS_INTERFACE,
 	.bDescriptorSubtype =	UAC_INPUT_TERMINAL,
-	.bTerminalID =		USB_OUT_IT_ID,
+	/* .bTerminalID =	DYNAMIC */
 	.wTerminalType =	cpu_to_le16(UAC_TERMINAL_STREAMING),
 	.bAssocTerminal =	0,
 	.wChannelConfig =	cpu_to_le16(0x3),
 };
 
-#define IO_OUT_OT_ID	2
 static struct uac1_output_terminal_descriptor io_out_ot_desc = {
 	.bLength		= UAC_DT_OUTPUT_TERMINAL_SIZE,
 	.bDescriptorType	= USB_DT_CS_INTERFACE,
 	.bDescriptorSubtype	= UAC_OUTPUT_TERMINAL,
-	.bTerminalID		= IO_OUT_OT_ID,
+	/* .bTerminalID =	DYNAMIC */
 	.wTerminalType		= cpu_to_le16(UAC_OUTPUT_TERMINAL_SPEAKER),
 	.bAssocTerminal		= 0,
-	.bSourceID		= USB_OUT_IT_ID,
+	/* .bSourceID =		DYNAMIC */
 };
 
-#define IO_IN_IT_ID	3
 static struct uac_input_terminal_descriptor io_in_it_desc = {
 	.bLength		= UAC_DT_INPUT_TERMINAL_SIZE,
 	.bDescriptorType	= USB_DT_CS_INTERFACE,
 	.bDescriptorSubtype	= UAC_INPUT_TERMINAL,
-	.bTerminalID		= IO_IN_IT_ID,
+	/* .bTerminalID		= DYNAMIC */
 	.wTerminalType		= cpu_to_le16(UAC_INPUT_TERMINAL_MICROPHONE),
 	.bAssocTerminal		= 0,
 	.wChannelConfig		= cpu_to_le16(0x3),
 };
 
-#define USB_IN_OT_ID	4
 static struct uac1_output_terminal_descriptor usb_in_ot_desc = {
 	.bLength =		UAC_DT_OUTPUT_TERMINAL_SIZE,
 	.bDescriptorType =	USB_DT_CS_INTERFACE,
 	.bDescriptorSubtype =	UAC_OUTPUT_TERMINAL,
-	.bTerminalID =		USB_IN_OT_ID,
+	/* .bTerminalID =	DYNAMIC */
 	.wTerminalType =	cpu_to_le16(UAC_TERMINAL_STREAMING),
 	.bAssocTerminal =	0,
-	.bSourceID =		IO_IN_IT_ID,
+	/* .bSourceID =		DYNAMIC */
 };
 
 /* B.4.1  Standard AS Interface Descriptor */
@@ -176,7 +148,7 @@ static inline struct f_uac1_opts *g_audio_to_uac1_opts(struct g_audio *audio)
 	.bLength =		UAC_DT_AS_HEADER_SIZE,
 	.bDescriptorType =	USB_DT_CS_INTERFACE,
 	.bDescriptorSubtype =	UAC_AS_GENERAL,
-	.bTerminalLink =	USB_OUT_IT_ID,
+	/* .bTerminalLink =	DYNAMIC */
 	.bDelay =		1,
 	.wFormatTag =		cpu_to_le16(UAC_FORMAT_TYPE_I_PCM),
 };
@@ -185,7 +157,7 @@ static inline struct f_uac1_opts *g_audio_to_uac1_opts(struct g_audio *audio)
 	.bLength =		UAC_DT_AS_HEADER_SIZE,
 	.bDescriptorType =	USB_DT_CS_INTERFACE,
 	.bDescriptorSubtype =	UAC_AS_GENERAL,
-	.bTerminalLink =	USB_IN_OT_ID,
+	/* .bTerminalLink =	DYNAMIC */
 	.bDelay =		1,
 	.wFormatTag =		cpu_to_le16(UAC_FORMAT_TYPE_I_PCM),
 };
@@ -513,6 +485,108 @@ static void f_audio_disable(struct usb_function *f)
 
 /*-------------------------------------------------------------------------*/
 
+static struct
+uac1_ac_header_descriptor *build_ac_header_desc(struct f_uac1_opts *opts)
+{
+	struct uac1_ac_header_descriptor *ac_desc;
+	int ac_header_desc_size;
+	int num_ifaces = 0;
+
+	if (EPOUT_EN(opts))
+		num_ifaces++;
+	if (EPIN_EN(opts))
+		num_ifaces++;
+
+	ac_header_desc_size = UAC_DT_AC_HEADER_SIZE(num_ifaces);
+
+	ac_desc = kzalloc(ac_header_desc_size, GFP_KERNEL);
+	if (!ac_desc)
+		return NULL;
+
+	ac_desc->bLength = ac_header_desc_size;
+	ac_desc->bDescriptorType = USB_DT_CS_INTERFACE;
+	ac_desc->bDescriptorSubtype = UAC_HEADER;
+	ac_desc->bcdADC = cpu_to_le16(0x0100);
+	ac_desc->bInCollection = num_ifaces;
+
+	/* wTotalLength and baInterfaceNr will be defined later */
+
+	return ac_desc;
+}
+
+/* Use macro to overcome line length limitation */
+#define USBDHDR(p) (struct usb_descriptor_header *)(p)
+
+static void setup_descriptor(struct f_uac1_opts *opts)
+{
+	/* patch descriptors */
+	int i = 1; /* ID's start with 1 */
+
+	if (EPOUT_EN(opts))
+		usb_out_it_desc.bTerminalID = i++;
+	if (EPIN_EN(opts))
+		io_in_it_desc.bTerminalID = i++;
+	if (EPOUT_EN(opts))
+		io_out_ot_desc.bTerminalID = i++;
+	if (EPIN_EN(opts))
+		usb_in_ot_desc.bTerminalID = i++;
+
+	usb_in_ot_desc.bSourceID = io_in_it_desc.bTerminalID;
+	io_out_ot_desc.bSourceID = usb_out_it_desc.bTerminalID;
+
+	as_out_header_desc.bTerminalLink = usb_out_it_desc.bTerminalID;
+	as_in_header_desc.bTerminalLink = usb_in_ot_desc.bTerminalID;
+
+	ac_header_desc->wTotalLength = cpu_to_le16(ac_header_desc->bLength);
+
+	if (EPIN_EN(opts)) {
+		u16 len = le16_to_cpu(ac_header_desc->wTotalLength);
+
+		len += sizeof(usb_in_ot_desc);
+		len += sizeof(io_in_it_desc);
+		ac_header_desc->wTotalLength = cpu_to_le16(len);
+	}
+	if (EPOUT_EN(opts)) {
+		u16 len = le16_to_cpu(ac_header_desc->wTotalLength);
+
+		len += sizeof(usb_out_it_desc);
+		len += sizeof(io_out_ot_desc);
+		ac_header_desc->wTotalLength = cpu_to_le16(len);
+	}
+
+	i = 0;
+	f_audio_desc[i++] = USBDHDR(&ac_interface_desc);
+	f_audio_desc[i++] = USBDHDR(ac_header_desc);
+
+	if (EPOUT_EN(opts)) {
+		f_audio_desc[i++] = USBDHDR(&usb_out_it_desc);
+		f_audio_desc[i++] = USBDHDR(&io_out_ot_desc);
+	}
+
+	if (EPIN_EN(opts)) {
+		f_audio_desc[i++] = USBDHDR(&io_in_it_desc);
+		f_audio_desc[i++] = USBDHDR(&usb_in_ot_desc);
+	}
+
+	if (EPOUT_EN(opts)) {
+		f_audio_desc[i++] = USBDHDR(&as_out_interface_alt_0_desc);
+		f_audio_desc[i++] = USBDHDR(&as_out_interface_alt_1_desc);
+		f_audio_desc[i++] = USBDHDR(&as_out_header_desc);
+		f_audio_desc[i++] = USBDHDR(&as_out_type_i_desc);
+		f_audio_desc[i++] = USBDHDR(&as_out_ep_desc);
+		f_audio_desc[i++] = USBDHDR(&as_iso_out_desc);
+	}
+	if (EPIN_EN(opts)) {
+		f_audio_desc[i++] = USBDHDR(&as_in_interface_alt_0_desc);
+		f_audio_desc[i++] = USBDHDR(&as_in_interface_alt_1_desc);
+		f_audio_desc[i++] = USBDHDR(&as_in_header_desc);
+		f_audio_desc[i++] = USBDHDR(&as_in_type_i_desc);
+		f_audio_desc[i++] = USBDHDR(&as_in_ep_desc);
+		f_audio_desc[i++] = USBDHDR(&as_iso_in_desc);
+	}
+	f_audio_desc[i] = NULL;
+}
+
 static int f_audio_validate_opts(struct g_audio *audio, struct device *dev)
 {
 	struct f_uac1_opts *opts = g_audio_to_uac1_opts(audio);
@@ -556,6 +630,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_string		*us;
 	u8				*sam_freq;
 	int				rate;
+	int				ba_iface_id;
 	int				status;
 
 	status = f_audio_validate_opts(audio, dev);
@@ -567,6 +642,11 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	us = usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings_uac1));
 	if (IS_ERR(us))
 		return PTR_ERR(us);
+
+	ac_header_desc = build_ac_header_desc(audio_opts);
+	if (!ac_header_desc)
+		return -ENOMEM;
+
 	ac_interface_desc.iInterface = us[STR_AC_IF].id;
 	usb_out_it_desc.iTerminal = us[STR_USB_OUT_IT].id;
 	usb_out_it_desc.iChannelNames = us[STR_USB_OUT_IT_CH_NAMES].id;
@@ -607,40 +687,52 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	uac1->ac_intf = status;
 	uac1->ac_alt = 0;
 
-	status = usb_interface_id(c, f);
-	if (status < 0)
-		goto fail;
-	as_out_interface_alt_0_desc.bInterfaceNumber = status;
-	as_out_interface_alt_1_desc.bInterfaceNumber = status;
-	ac_header_desc.baInterfaceNr[0] = status;
-	uac1->as_out_intf = status;
-	uac1->as_out_alt = 0;
+	ba_iface_id = 0;
+
+	if (EPOUT_EN(audio_opts)) {
+		status = usb_interface_id(c, f);
+		if (status < 0)
+			goto fail;
+		as_out_interface_alt_0_desc.bInterfaceNumber = status;
+		as_out_interface_alt_1_desc.bInterfaceNumber = status;
+		ac_header_desc->baInterfaceNr[ba_iface_id++] = status;
+		uac1->as_out_intf = status;
+		uac1->as_out_alt = 0;
+	}
 
-	status = usb_interface_id(c, f);
-	if (status < 0)
-		goto fail;
-	as_in_interface_alt_0_desc.bInterfaceNumber = status;
-	as_in_interface_alt_1_desc.bInterfaceNumber = status;
-	ac_header_desc.baInterfaceNr[1] = status;
-	uac1->as_in_intf = status;
-	uac1->as_in_alt = 0;
+	if (EPIN_EN(audio_opts)) {
+		status = usb_interface_id(c, f);
+		if (status < 0)
+			goto fail;
+		as_in_interface_alt_0_desc.bInterfaceNumber = status;
+		as_in_interface_alt_1_desc.bInterfaceNumber = status;
+		ac_header_desc->baInterfaceNr[ba_iface_id++] = status;
+		uac1->as_in_intf = status;
+		uac1->as_in_alt = 0;
+	}
 
 	audio->gadget = gadget;
 
 	status = -ENODEV;
 
 	/* allocate instance-specific endpoints */
-	ep = usb_ep_autoconfig(cdev->gadget, &as_out_ep_desc);
-	if (!ep)
-		goto fail;
-	audio->out_ep = ep;
-	audio->out_ep->desc = &as_out_ep_desc;
+	if (EPOUT_EN(audio_opts)) {
+		ep = usb_ep_autoconfig(cdev->gadget, &as_out_ep_desc);
+		if (!ep)
+			goto fail;
+		audio->out_ep = ep;
+		audio->out_ep->desc = &as_out_ep_desc;
+	}
 
-	ep = usb_ep_autoconfig(cdev->gadget, &as_in_ep_desc);
-	if (!ep)
-		goto fail;
-	audio->in_ep = ep;
-	audio->in_ep->desc = &as_in_ep_desc;
+	if (EPIN_EN(audio_opts)) {
+		ep = usb_ep_autoconfig(cdev->gadget, &as_in_ep_desc);
+		if (!ep)
+			goto fail;
+		audio->in_ep = ep;
+		audio->in_ep->desc = &as_in_ep_desc;
+	}
+
+	setup_descriptor(audio_opts);
 
 	/* copy descriptors, and track endpoint copies */
 	status = usb_assign_descriptors(f, f_audio_desc, f_audio_desc, NULL,
@@ -667,6 +759,8 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 err_card_register:
 	usb_free_all_descriptors(f);
 fail:
+	kfree(ac_header_desc);
+	ac_header_desc = NULL;
 	return status;
 }
 
@@ -809,6 +903,9 @@ static void f_audio_unbind(struct usb_configuration *c, struct usb_function *f)
 	g_audio_cleanup(audio);
 	usb_free_all_descriptors(f);
 
+	kfree(ac_header_desc);
+	ac_header_desc = NULL;
+
 	audio->gadget = NULL;
 }
 
-- 
1.9.1

