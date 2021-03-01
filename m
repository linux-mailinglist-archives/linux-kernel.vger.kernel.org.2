Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1DD327EF4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhCANHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhCANGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:06:40 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA31C061794;
        Mon,  1 Mar 2021 05:05:56 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id q14so19297635ljp.4;
        Mon, 01 Mar 2021 05:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ryEccYgqySmmYI7kQFNzWUTlmbI+Pk/hMWhsMgtrU7k=;
        b=GEnBp6cbBvrtdSXy7OCqDCkPGXwqBY8Oh8q7OC5lkeIq4bFOryu3MFWWxv49uUPJvg
         plpLH/IHFqBnnKo5/S8GXpfAWm3j7sdo43zlWH8GR3QgIX2h0zb9Y/OTD2v23wIU/hDV
         4SLolnnaEW3jOgPRbkKK79EG4xdMgrR1NOySTUpL9XgyFUn6yYJTYsw69zMYPDdSD92V
         ntCwTbnIt9t93s+w1NNP1x8A3RQgVtRWDhgtXNUW9lGgls4K83sb6qJFDE0VdBaTjFH5
         pB+YTKKUVX+vDi7RDKvlhCAzMYoWgm/RULZa/49tAx+/pJpL9nlAplTcgVn+ZgWi9H9O
         NgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ryEccYgqySmmYI7kQFNzWUTlmbI+Pk/hMWhsMgtrU7k=;
        b=V/+ioq2qdZkQMSEdhgZs3nkFOxLRn1d8J610lSNy7i4kJYp/cm54OVc8KMTbzUfxtr
         oTciu1YSLLn2WbM0oavcgzVtNe5KwN0h0SiKMOHqwRmGtfOara3GtdCzVY2pI4wnNn1e
         BUMs4nbDlmVFfSuaZHPcyoFihuIljU8dUIrMl5b+2jRRqqVc7AxEBolcAAB7d7dxbppT
         uB6K1brvYSUa0bTok/0KC8GEbtcu6UeTI4XNwyNVr1BXUs5ew51PNnqgKy7W4YLYpg/a
         OtsfbcP7F0pW0Lgg5KBp5xEmzoTJ80Y6qzozTr63x41Rlpy8QC/8cHSyAsqAHU9n8yRy
         KySA==
X-Gm-Message-State: AOAM532Y0mBmgD4gnbXmvkOQRAsiPnG5GjqtcTmYgKMOncYYuefDrJZX
        mkI1HfGnMJscz2JfM8DlY143KNa1nwqXy9KJ
X-Google-Smtp-Source: ABdhPJx+tlSO7PUAjAw8mfM3vnzCJXe5xCmJpLs2GWUAMAiW32svqO3X1n/xtik7wvB1m3V5ncxWkw==
X-Received: by 2002:a05:651c:101:: with SMTP id a1mr9257605ljb.363.1614603954965;
        Mon, 01 Mar 2021 05:05:54 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id c19sm2031950ljk.60.2021.03.01.05.05.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 05:05:53 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     gschmottlach@gmail.com, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] usb: gadget: f_uac2: add adaptive sync support for capture
Date:   Mon,  1 Mar 2021 15:05:38 +0200
Message-Id: <1614603943-11668-4-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current f_uac2 USB OUT (aka 'capture') synchronization
implements 'ASYNC' scenario which means USB Gadget has
it's own freerunning clock and can update Host about
real clock frequency through feedback endpoint so Host
can align number of samples sent to the USB gadget to
prevent overruns/underruns

In case if Gadget can has no it's internal clock and
can consume audio samples at any rate (for example,
on the Gadget side someone records audio directly to
a file, or audio samples are played through an
external DAC as soon as they arrive), UAC2 spec
suggests 'ADAPTIVE' synchronization type.

Change UAC2 driver to make it configurable through
additional 'c_sync' configfs file.

Default remains 'asynchronous' with possibility to
switch it to 'adaptive'

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 Documentation/ABI/testing/configfs-usb-gadget-uac2 |   1 +
 Documentation/usb/gadget-testing.rst               |   1 +
 drivers/usb/gadget/function/f_uac2.c               | 102 ++++++++++++++++++---
 drivers/usb/gadget/function/u_uac2.h               |   2 +
 4 files changed, 95 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac2 b/Documentation/ABI/testing/configfs-usb-gadget-uac2
index d4356c8..e7e59d7 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac2
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac2
@@ -8,6 +8,7 @@ Description:
 		c_chmask   capture channel mask
 		c_srate    capture sampling rate
 		c_ssize    capture sample size (bytes)
+		c_sync     capture synchronization type (async/adaptive)
 		p_chmask   playback channel mask
 		p_srate    playback sampling rate
 		p_ssize    playback sample size (bytes)
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 2085e7b..f5a1266 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -728,6 +728,7 @@ The uac2 function provides these attributes in its function directory:
 	c_chmask	capture channel mask
 	c_srate		capture sampling rate
 	c_ssize		capture sample size (bytes)
+	c_sync		capture synchronization type (async/adaptive)
 	p_chmask	playback channel mask
 	p_srate		playback sampling rate
 	p_ssize		playback sample size (bytes)
diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 6f7b7c1..72b42f8 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -44,6 +44,7 @@
 
 #define EPIN_EN(_opts) ((_opts)->p_chmask != 0)
 #define EPOUT_EN(_opts) ((_opts)->c_chmask != 0)
+#define EPOUT_FBACK_IN_EN(_opts) ((_opts)->c_sync == USB_ENDPOINT_SYNC_ASYNC)
 
 struct f_uac2 {
 	struct g_audio g_audio;
@@ -240,7 +241,7 @@ enum {
 	.bDescriptorType = USB_DT_INTERFACE,
 
 	.bAlternateSetting = 1,
-	.bNumEndpoints = 2,
+	/* .bNumEndpoints = DYNAMIC */
 	.bInterfaceClass = USB_CLASS_AUDIO,
 	.bInterfaceSubClass = USB_SUBCLASS_AUDIOSTREAMING,
 	.bInterfaceProtocol = UAC_VERSION_2,
@@ -273,7 +274,7 @@ enum {
 	.bDescriptorType = USB_DT_ENDPOINT,
 
 	.bEndpointAddress = USB_DIR_OUT,
-	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC,
+	/* .bmAttributes = = DYNAMIC */
 	/* .wMaxPacketSize = DYNAMIC */
 	.bInterval = 1,
 };
@@ -282,7 +283,7 @@ enum {
 	.bLength = USB_DT_ENDPOINT_SIZE,
 	.bDescriptorType = USB_DT_ENDPOINT,
 
-	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC,
+	/* .bmAttributes = = DYNAMIC */
 	/* .wMaxPacketSize = DYNAMIC */
 	.bInterval = 1,
 };
@@ -544,6 +545,8 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 	iad_desc.bInterfaceCount = 1;
 	ac_hdr_desc.wTotalLength = cpu_to_le16(sizeof(ac_hdr_desc));
 
+	std_as_out_if1_desc.bNumEndpoints = 1;
+
 	if (EPIN_EN(opts)) {
 		u16 len = le16_to_cpu(ac_hdr_desc.wTotalLength);
 
@@ -561,6 +564,19 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 		len += sizeof(io_out_ot_desc);
 		ac_hdr_desc.wTotalLength = cpu_to_le16(len);
 		iad_desc.bInterfaceCount++;
+
+		fs_epout_desc.bmAttributes = USB_ENDPOINT_XFER_ISOC;
+		hs_epout_desc.bmAttributes = USB_ENDPOINT_XFER_ISOC;
+		if (EPOUT_FBACK_IN_EN(opts)) {
+			fs_epout_desc.bmAttributes |= USB_ENDPOINT_SYNC_ASYNC;
+			hs_epout_desc.bmAttributes |= USB_ENDPOINT_SYNC_ASYNC;
+			std_as_out_if1_desc.bNumEndpoints++;
+		} else {
+			fs_epout_desc.bmAttributes |=
+						USB_ENDPOINT_SYNC_ADAPTIVE;
+			hs_epout_desc.bmAttributes |=
+						USB_ENDPOINT_SYNC_ADAPTIVE;
+		}
 	}
 
 	i = 0;
@@ -585,7 +601,8 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 		fs_audio_desc[i++] = USBDHDR(&as_out_fmt1_desc);
 		fs_audio_desc[i++] = USBDHDR(&fs_epout_desc);
 		fs_audio_desc[i++] = USBDHDR(&as_iso_out_desc);
-		fs_audio_desc[i++] = USBDHDR(&fs_epin_fback_desc);
+		if (EPOUT_FBACK_IN_EN(opts))
+			fs_audio_desc[i++] = USBDHDR(&fs_epin_fback_desc);
 	}
 	if (EPIN_EN(opts)) {
 		fs_audio_desc[i++] = USBDHDR(&std_as_in_if0_desc);
@@ -619,7 +636,8 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 		hs_audio_desc[i++] = USBDHDR(&as_out_fmt1_desc);
 		hs_audio_desc[i++] = USBDHDR(&hs_epout_desc);
 		hs_audio_desc[i++] = USBDHDR(&as_iso_out_desc);
-		hs_audio_desc[i++] = USBDHDR(&hs_epin_fback_desc);
+		if (EPOUT_FBACK_IN_EN(opts))
+			hs_audio_desc[i++] = USBDHDR(&hs_epin_fback_desc);
 	}
 	if (EPIN_EN(opts)) {
 		hs_audio_desc[i++] = USBDHDR(&std_as_in_if0_desc);
@@ -776,17 +794,22 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 		return ret;
 	}
 
+	setup_descriptor(uac2_opts);
+
 	if (EPOUT_EN(uac2_opts)) {
 		agdev->out_ep = usb_ep_autoconfig(gadget, &fs_epout_desc);
 		if (!agdev->out_ep) {
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 			return -ENODEV;
 		}
-		agdev->in_ep_fback = usb_ep_autoconfig(gadget,
+		if (EPOUT_FBACK_IN_EN(uac2_opts)) {
+			agdev->in_ep_fback = usb_ep_autoconfig(gadget,
 						       &fs_epin_fback_desc);
-		if (!agdev->in_ep_fback) {
-			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-			return -ENODEV;
+			if (!agdev->in_ep_fback) {
+				dev_err(dev, "%s:%d Error!\n",
+					__func__, __LINE__);
+				return -ENODEV;
+			}
 		}
 	}
 
@@ -809,8 +832,6 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 	hs_epin_fback_desc.bEndpointAddress = fs_epin_fback_desc.bEndpointAddress;
 	hs_epin_desc.bEndpointAddress = fs_epin_desc.bEndpointAddress;
 
-	setup_descriptor(uac2_opts);
-
 	ret = usb_assign_descriptors(fn, fs_audio_desc, hs_audio_desc, NULL,
 				     NULL);
 	if (ret)
@@ -1133,11 +1154,68 @@ static void f_uac2_attr_release(struct config_item *item)
 									\
 CONFIGFS_ATTR(f_uac2_opts_, name)
 
+#define UAC2_ATTRIBUTE_SYNC(name)					\
+static ssize_t f_uac2_opts_##name##_show(struct config_item *item,	\
+					 char *page)			\
+{									\
+	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
+	int result;							\
+	char *str;							\
+									\
+	mutex_lock(&opts->lock);					\
+	switch (opts->name) {						\
+	case USB_ENDPOINT_SYNC_ASYNC:					\
+		str = "async";						\
+		break;							\
+	case USB_ENDPOINT_SYNC_ADAPTIVE:				\
+		str = "adaptive";					\
+		break;							\
+	default:							\
+		str = "unknown";					\
+		break;							\
+	}								\
+	result = sprintf(page, "%s\n", str);				\
+	mutex_unlock(&opts->lock);					\
+									\
+	return result;							\
+}									\
+									\
+static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
+					  const char *page, size_t len)	\
+{									\
+	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
+	int ret = 0;							\
+									\
+	mutex_lock(&opts->lock);					\
+	if (opts->refcnt) {						\
+		ret = -EBUSY;						\
+		goto end;						\
+	}								\
+									\
+	if (!strncmp(page, "async", 5))					\
+		opts->name = USB_ENDPOINT_SYNC_ASYNC;			\
+	else if (!strncmp(page, "adaptive", 8))				\
+		opts->name = USB_ENDPOINT_SYNC_ADAPTIVE;		\
+	else {								\
+		ret = -EINVAL;						\
+		goto end;						\
+	}								\
+									\
+	ret = len;							\
+									\
+end:									\
+	mutex_unlock(&opts->lock);					\
+	return ret;							\
+}									\
+									\
+CONFIGFS_ATTR(f_uac2_opts_, name)
+
 UAC2_ATTRIBUTE(p_chmask);
 UAC2_ATTRIBUTE(p_srate);
 UAC2_ATTRIBUTE(p_ssize);
 UAC2_ATTRIBUTE(c_chmask);
 UAC2_ATTRIBUTE(c_srate);
+UAC2_ATTRIBUTE_SYNC(c_sync);
 UAC2_ATTRIBUTE(c_ssize);
 UAC2_ATTRIBUTE(req_number);
 
@@ -1148,6 +1226,7 @@ static void f_uac2_attr_release(struct config_item *item)
 	&f_uac2_opts_attr_c_chmask,
 	&f_uac2_opts_attr_c_srate,
 	&f_uac2_opts_attr_c_ssize,
+	&f_uac2_opts_attr_c_sync,
 	&f_uac2_opts_attr_req_number,
 	NULL,
 };
@@ -1186,6 +1265,7 @@ static struct usb_function_instance *afunc_alloc_inst(void)
 	opts->c_chmask = UAC2_DEF_CCHMASK;
 	opts->c_srate = UAC2_DEF_CSRATE;
 	opts->c_ssize = UAC2_DEF_CSSIZE;
+	opts->c_sync = UAC2_DEF_CSYNC;
 	opts->req_number = UAC2_DEF_REQ_NUM;
 	return &opts->func_inst;
 }
diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
index b503571..13589c3 100644
--- a/drivers/usb/gadget/function/u_uac2.h
+++ b/drivers/usb/gadget/function/u_uac2.h
@@ -21,6 +21,7 @@
 #define UAC2_DEF_CCHMASK 0x3
 #define UAC2_DEF_CSRATE 64000
 #define UAC2_DEF_CSSIZE 2
+#define UAC2_DEF_CSYNC		USB_ENDPOINT_SYNC_ASYNC
 #define UAC2_DEF_REQ_NUM 2
 
 struct f_uac2_opts {
@@ -31,6 +32,7 @@ struct f_uac2_opts {
 	int				c_chmask;
 	int				c_srate;
 	int				c_ssize;
+	int				c_sync;
 	int				req_number;
 	bool				bound;
 
-- 
1.9.1

