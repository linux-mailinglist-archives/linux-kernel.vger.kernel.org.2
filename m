Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5E4327F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhCANIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbhCANHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:07:10 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FABC0617AA;
        Mon,  1 Mar 2021 05:06:11 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u4so19291504ljh.6;
        Mon, 01 Mar 2021 05:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=krVoGXQx53nPN9aRstwB6uOUgnjFzTHelhlIFBzOZSo=;
        b=hfrl4Sy+fKFc+znTVpq71z+56HhYKcgnW0hAF+yIv8YO+ElyAbjLHYVr3poZ266Pt+
         K9LyDpcsD2gBIT6UkCHpFobhAxn1c9U8Y0oqsJ4a+/TncfB/GNKSkiQ/26rjqfT5EM75
         bV6VXpRpVMSWuvubfLBusbXbgACGKHSUrPB/iUjSIKT9C9yruuTVJIkL0YjyhCtBjzvX
         kU4+h55GwNgiBtZO44MrXTbSGDGkB37SWt9fDesbw2ap0d858tg/aUNQ9HlaJvu3LtXN
         1lZsNPyVK6JueuR+WKIGyFs5dP82FYjmlRZ5EN4YyXD9dYAoeRW5SOlJLKCfN5HsbGsh
         p/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=krVoGXQx53nPN9aRstwB6uOUgnjFzTHelhlIFBzOZSo=;
        b=IkxHDywiWgqMiTl3+S3v2aPtl235U6Dk2Gvt3G81nfJFObk7YZ16bHWfUijPLci8Dv
         MAKtuLdGiibfS530OYJOKDVyjr0sGGQxuxugfmKDy6y3n/Q3i1gpmUvgTMuJzEUTetdI
         NnZ659ZcZhaBYH9WzGUCT195LU3G9A9Sv8Agf8mmXM9e3ey8BdIHJ28QKiW+Ap89vCRP
         H28GNSvuNEmNYIjVMPzUwfguy8khkZjahJvl9npHAENMScvPXZUfYXZ+rkPIaVWt10bT
         tXnAQ3fSAatmTyn+cGMWgkZYn63/ddxBHJVHtl/9vvztqhGPuZ9UHj0dnoAhhDpe5ut9
         nhVw==
X-Gm-Message-State: AOAM533n7dntm82QeUoGQtf7hQ09pUlFGPmc8s8Y9tO8QA5jW7yq0kXV
        ofaPp95/FN6OkJN2fZr42WQ=
X-Google-Smtp-Source: ABdhPJyBwMJzygL/R8yClJKyQdDYShQUB6hwpQjuAOe4qVvGl5NR0OvJyePVqGtTEaCsHnKMtpMRxg==
X-Received: by 2002:a2e:3907:: with SMTP id g7mr9382953lja.159.1614603969560;
        Mon, 01 Mar 2021 05:06:09 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id r66sm2289961lff.93.2021.03.01.05.06.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 05:06:08 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     gschmottlach@gmail.com, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] usb: gadget: f_uac1: add volume and mute support
Date:   Mon,  1 Mar 2021 15:05:43 +0200
Message-Id: <1614603943-11668-9-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds bi-directional (host->device, device->host)
volume/mute support to the f_uac1 driver by adding
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
 Documentation/ABI/testing/configfs-usb-gadget-uac1 |  10 +
 Documentation/usb/gadget-testing.rst               |  26 +-
 drivers/usb/gadget/function/f_uac1.c               | 674 ++++++++++++++++++++-
 drivers/usb/gadget/function/u_uac1.h               |  20 +
 4 files changed, 700 insertions(+), 30 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac1 b/Documentation/ABI/testing/configfs-usb-gadget-uac1
index dc23fd7..dd647d4 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac1
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac1
@@ -8,9 +8,19 @@ Description:
 		c_chmask	capture channel mask
 		c_srate		capture sampling rate
 		c_ssize		capture sample size (bytes)
+		c_mute_present	capture mute control enable
+		c_volume_present	capture volume control enable
+		c_volume_min	capture volume control min value (in 1/256 dB)
+		c_volume_max	capture volume control max value (in 1/256 dB)
+		c_volume_res	capture volume control resolution (in 1/256 dB)
 		p_chmask	playback channel mask
 		p_srate		playback sampling rate
 		p_ssize		playback sample size (bytes)
+		p_mute_present	playback mute control enable
+		p_volume_present	playback volume control enable
+		p_volume_min	playback volume control min value (in 1/256 dB)
+		p_volume_max	playback volume control max value (in 1/256 dB)
+		p_volume_res	playback volume control resolution (in 1/256 dB)
 		req_number	the number of pre-allocated request
 				for both capture and playback
 		==========	===================================
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 26adb0b..f078fc9 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -914,14 +914,24 @@ The function name to use when creating the function directory is "uac1".
 The uac1 function provides these attributes in its function directory:
 
 	========== ====================================================
-	c_chmask   capture channel mask
-	c_srate    capture sampling rate
-	c_ssize    capture sample size (bytes)
-	p_chmask   playback channel mask
-	p_srate    playback sampling rate
-	p_ssize    playback sample size (bytes)
-	req_number the number of pre-allocated request for both capture
-		   and playback
+	c_chmask   	capture channel mask
+	c_srate    	capture sampling rate
+	c_ssize    	capture sample size (bytes)
+	c_mute_present	capture mute control enable
+	c_volume_present	capture volume control enable
+	c_volume_min	capture volume control min value (in 1/256 dB)
+	c_volume_max	capture volume control max value (in 1/256 dB)
+	c_volume_res	capture volume control resolution (in 1/256 dB)
+	p_chmask   	playback channel mask
+	p_srate    	playback sampling rate
+	p_ssize    	playback sample size (bytes)
+	p_mute_present	playback mute control enable
+	p_volume_present	playback volume control enable
+	p_volume_min	playback volume control min value (in 1/256 dB)
+	p_volume_max	playback volume control max value (in 1/256 dB)
+	p_volume_res	playback volume control resolution (in 1/256 dB)
+	req_number 	the number of pre-allocated request for both capture
+			and playback
 	========== ====================================================
 
 The attributes have sane default values.
diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index d047075..3b3db1a 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -22,13 +22,26 @@
 /* UAC1 spec: 3.7.2.3 Audio Channel Cluster Format */
 #define UAC1_CHANNEL_MASK 0x0FFF
 
+#define USB_OUT_FU_ID	(out_feature_unit_desc->bUnitID)
+#define USB_IN_FU_ID	(in_feature_unit_desc->bUnitID)
+
 #define EPIN_EN(_opts) ((_opts)->p_chmask != 0)
 #define EPOUT_EN(_opts) ((_opts)->c_chmask != 0)
+#define FUIN_EN(_opts) ((_opts)->p_mute_present \
+			|| (_opts)->p_volume_present)
+#define FUOUT_EN(_opts) ((_opts)->c_mute_present \
+			|| (_opts)->c_volume_present)
 
 struct f_uac1 {
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
 
 static inline struct f_uac1 *func_to_uac1(struct usb_function *f)
@@ -58,7 +71,7 @@ static inline struct f_uac1_opts *g_audio_to_uac1_opts(struct g_audio *audio)
 static struct usb_interface_descriptor ac_interface_desc = {
 	.bLength =		USB_DT_INTERFACE_SIZE,
 	.bDescriptorType =	USB_DT_INTERFACE,
-	.bNumEndpoints =	0,
+	/* .bNumEndpoints =	DYNAMIC */
 	.bInterfaceClass =	USB_CLASS_AUDIO,
 	.bInterfaceSubClass =	USB_SUBCLASS_AUDIOCONTROL,
 };
@@ -106,6 +119,19 @@ static inline struct f_uac1_opts *g_audio_to_uac1_opts(struct g_audio *audio)
 	/* .bSourceID =		DYNAMIC */
 };
 
+static struct uac_feature_unit_descriptor *in_feature_unit_desc;
+static struct uac_feature_unit_descriptor *out_feature_unit_desc;
+
+/* AC IN Interrupt Endpoint */
+static struct usb_endpoint_descriptor ac_int_ep_desc = {
+	.bLength = USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+	.bEndpointAddress = USB_DIR_IN,
+	.bmAttributes = USB_ENDPOINT_XFER_INT,
+	.wMaxPacketSize = cpu_to_le16(2),
+	.bInterval = 4,
+};
+
 /* B.4.1  Standard AS Interface Descriptor */
 static struct usb_interface_descriptor as_out_interface_alt_0_desc = {
 	.bLength =		USB_DT_INTERFACE_SIZE,
@@ -232,8 +258,13 @@ static inline struct f_uac1_opts *g_audio_to_uac1_opts(struct g_audio *audio)
 
 	(struct usb_descriptor_header *)&usb_out_it_desc,
 	(struct usb_descriptor_header *)&io_out_ot_desc,
+	(struct usb_descriptor_header *)&out_feature_unit_desc,
+
 	(struct usb_descriptor_header *)&io_in_it_desc,
 	(struct usb_descriptor_header *)&usb_in_ot_desc,
+	(struct usb_descriptor_header *)&in_feature_unit_desc,
+
+	(struct usb_descriptor_header *)&ac_int_ep_desc,
 
 	(struct usb_descriptor_header *)&as_out_interface_alt_0_desc,
 	(struct usb_descriptor_header *)&as_out_interface_alt_1_desc,
@@ -263,6 +294,8 @@ enum {
 	STR_IO_IN_IT,
 	STR_IO_IN_IT_CH_NAMES,
 	STR_USB_IN_OT,
+	STR_FU_IN,
+	STR_FU_OUT,
 	STR_AS_OUT_IF_ALT0,
 	STR_AS_OUT_IF_ALT1,
 	STR_AS_IN_IF_ALT0,
@@ -277,6 +310,8 @@ enum {
 	[STR_IO_IN_IT].s = "Capture Input terminal",
 	[STR_IO_IN_IT_CH_NAMES].s = "Capture Channels",
 	[STR_USB_IN_OT].s = "Capture Output terminal",
+	[STR_FU_IN].s = "Capture Volume",
+	[STR_FU_OUT].s = "Playback Volume",
 	[STR_AS_OUT_IF_ALT0].s = "Playback Inactive",
 	[STR_AS_OUT_IF_ALT1].s = "Playback Active",
 	[STR_AS_IN_IF_ALT0].s = "Capture Inactive",
@@ -298,6 +333,376 @@ enum {
  * This function is an ALSA sound card following USB Audio Class Spec 1.0.
  */
 
+static void audio_notify_complete(struct usb_ep *_ep, struct usb_request *req)
+{
+	struct g_audio *audio = req->context;
+	struct f_uac1 *uac1 = func_to_uac1(&audio->func);
+
+	atomic_dec(&uac1->int_count);
+	kfree(req->buf);
+	usb_ep_free_request(_ep, req);
+}
+
+static int audio_notify(struct g_audio *audio, int unit_id, int cs)
+{
+	struct f_uac1 *uac1 = func_to_uac1(&audio->func);
+	struct usb_request *req;
+	struct uac1_status_word *msg;
+	int ret;
+
+	if (!uac1->int_ep->enabled)
+		return 0;
+
+	if (atomic_inc_return(&uac1->int_count) > UAC1_DEF_INT_REQ_NUM) {
+		atomic_dec(&uac1->int_count);
+		return 0;
+	}
+
+	req = usb_ep_alloc_request(uac1->int_ep, GFP_ATOMIC);
+	if (req == NULL) {
+		ret = -ENOMEM;
+		goto err_dec_int_count;
+	}
+
+	msg = kmalloc(sizeof(*msg), GFP_ATOMIC);
+	if (msg == NULL) {
+		ret = -ENOMEM;
+		goto err_free_request;
+	}
+
+	msg->bStatusType = UAC1_STATUS_TYPE_IRQ_PENDING
+				| UAC1_STATUS_TYPE_ORIG_AUDIO_CONTROL_IF;
+	msg->bOriginator = unit_id;
+
+	req->length = sizeof(*msg);
+	req->buf = msg;
+	req->context = audio;
+	req->complete = audio_notify_complete;
+
+	ret = usb_ep_queue(uac1->int_ep, req, GFP_ATOMIC);
+
+	if (ret)
+		goto err_free_msg;
+
+	return 0;
+
+err_free_msg:
+	kfree(msg);
+err_free_request:
+	usb_ep_free_request(uac1->int_ep, req);
+err_dec_int_count:
+	atomic_dec(&uac1->int_count);
+
+	return ret;
+}
+
+static int
+in_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
+{
+	struct usb_request *req = fn->config->cdev->req;
+	struct g_audio *audio = func_to_g_audio(fn);
+	struct f_uac1_opts *opts = g_audio_to_uac1_opts(audio);
+	u16 w_length = le16_to_cpu(cr->wLength);
+	u16 w_index = le16_to_cpu(cr->wIndex);
+	u16 w_value = le16_to_cpu(cr->wValue);
+	u8 entity_id = (w_index >> 8) & 0xff;
+	u8 control_selector = w_value >> 8;
+	int value = -EOPNOTSUPP;
+
+	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+		unsigned int is_playback = 0;
+
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+			is_playback = 1;
+
+		if (control_selector == UAC_FU_MUTE) {
+			unsigned int mute;
+
+			u_audio_get_mute(audio, is_playback, &mute);
+
+			*(u8 *)req->buf = mute;
+			value = min_t(unsigned int, w_length, 1);
+		} else if (control_selector == UAC_FU_VOLUME) {
+			__le16 c;
+			s16 volume;
+
+			u_audio_get_volume(audio, is_playback, &volume);
+
+			c = cpu_to_le16(volume);
+
+			value = min_t(unsigned int, w_length, sizeof(c));
+			memcpy(req->buf, &c, value);
+		} else {
+			dev_err(&audio->gadget->dev,
+				"%s:%d control_selector=%d TODO!\n",
+				__func__, __LINE__, control_selector);
+		}
+	} else {
+		dev_err(&audio->gadget->dev,
+			"%s:%d entity_id=%d control_selector=%d TODO!\n",
+			__func__, __LINE__, entity_id, control_selector);
+	}
+
+	return value;
+}
+
+static int
+in_rq_min(struct usb_function *fn, const struct usb_ctrlrequest *cr)
+{
+	struct usb_request *req = fn->config->cdev->req;
+	struct g_audio *audio = func_to_g_audio(fn);
+	struct f_uac1_opts *opts = g_audio_to_uac1_opts(audio);
+	u16 w_length = le16_to_cpu(cr->wLength);
+	u16 w_index = le16_to_cpu(cr->wIndex);
+	u16 w_value = le16_to_cpu(cr->wValue);
+	u8 entity_id = (w_index >> 8) & 0xff;
+	u8 control_selector = w_value >> 8;
+	int value = -EOPNOTSUPP;
+
+	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+		unsigned int is_playback = 0;
+
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+			is_playback = 1;
+
+		if (control_selector == UAC_FU_VOLUME) {
+			__le16 r;
+			s16 min_db;
+
+			if (is_playback)
+				min_db = opts->p_volume_min;
+			else
+				min_db = opts->c_volume_min;
+
+			r = cpu_to_le16(min_db);
+
+			value = min_t(unsigned int, w_length, sizeof(r));
+			memcpy(req->buf, &r, value);
+		} else {
+			dev_err(&audio->gadget->dev,
+				"%s:%d control_selector=%d TODO!\n",
+				__func__, __LINE__, control_selector);
+		}
+	} else {
+		dev_err(&audio->gadget->dev,
+			"%s:%d entity_id=%d control_selector=%d TODO!\n",
+			__func__, __LINE__, entity_id, control_selector);
+	}
+
+	return value;
+}
+
+static int
+in_rq_max(struct usb_function *fn, const struct usb_ctrlrequest *cr)
+{
+	struct usb_request *req = fn->config->cdev->req;
+	struct g_audio *audio = func_to_g_audio(fn);
+	struct f_uac1_opts *opts = g_audio_to_uac1_opts(audio);
+	u16 w_length = le16_to_cpu(cr->wLength);
+	u16 w_index = le16_to_cpu(cr->wIndex);
+	u16 w_value = le16_to_cpu(cr->wValue);
+	u8 entity_id = (w_index >> 8) & 0xff;
+	u8 control_selector = w_value >> 8;
+	int value = -EOPNOTSUPP;
+
+	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+		unsigned int is_playback = 0;
+
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+			is_playback = 1;
+
+		if (control_selector == UAC_FU_VOLUME) {
+			__le16 r;
+			s16 max_db;
+
+			if (is_playback)
+				max_db = opts->p_volume_max;
+			else
+				max_db = opts->c_volume_max;
+
+			r = cpu_to_le16(max_db);
+
+			value = min_t(unsigned int, w_length, sizeof(r));
+			memcpy(req->buf, &r, value);
+		} else {
+			dev_err(&audio->gadget->dev,
+				"%s:%d control_selector=%d TODO!\n",
+				__func__, __LINE__, control_selector);
+		}
+	} else {
+		dev_err(&audio->gadget->dev,
+			"%s:%d entity_id=%d control_selector=%d TODO!\n",
+			__func__, __LINE__, entity_id, control_selector);
+	}
+
+	return value;
+}
+
+static int
+in_rq_res(struct usb_function *fn, const struct usb_ctrlrequest *cr)
+{
+	struct usb_request *req = fn->config->cdev->req;
+	struct g_audio *audio = func_to_g_audio(fn);
+	struct f_uac1_opts *opts = g_audio_to_uac1_opts(audio);
+	u16 w_length = le16_to_cpu(cr->wLength);
+	u16 w_index = le16_to_cpu(cr->wIndex);
+	u16 w_value = le16_to_cpu(cr->wValue);
+	u8 entity_id = (w_index >> 8) & 0xff;
+	u8 control_selector = w_value >> 8;
+	int value = -EOPNOTSUPP;
+
+	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+		unsigned int is_playback = 0;
+
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+			is_playback = 1;
+
+		if (control_selector == UAC_FU_VOLUME) {
+			__le16 r;
+			s16 res_db;
+
+			if (is_playback)
+				res_db = opts->p_volume_res;
+			else
+				res_db = opts->c_volume_res;
+
+			r = cpu_to_le16(res_db);
+
+			value = min_t(unsigned int, w_length, sizeof(r));
+			memcpy(req->buf, &r, value);
+		} else {
+			dev_err(&audio->gadget->dev,
+				"%s:%d control_selector=%d TODO!\n",
+				__func__, __LINE__, control_selector);
+		}
+	} else {
+		dev_err(&audio->gadget->dev,
+			"%s:%d entity_id=%d control_selector=%d TODO!\n",
+			__func__, __LINE__, entity_id, control_selector);
+	}
+
+	return value;
+}
+
+static void
+out_rq_cur_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	struct g_audio *audio = req->context;
+	struct usb_composite_dev *cdev = audio->func.config->cdev;
+	struct f_uac1_opts *opts = g_audio_to_uac1_opts(audio);
+	struct f_uac1 *uac1 = func_to_uac1(&audio->func);
+	struct usb_ctrlrequest *cr = &uac1->setup_cr;
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
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+		unsigned int is_playback = 0;
+
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+			is_playback = 1;
+
+		if (control_selector == UAC_FU_MUTE) {
+			u8 mute = *(u8 *)req->buf;
+
+			u_audio_set_mute(audio, is_playback, mute);
+
+			return;
+		} else if (control_selector == UAC_FU_VOLUME) {
+			__le16 *c = req->buf;
+			s16 volume;
+
+			volume = le16_to_cpu(*c);
+			u_audio_set_volume(audio, is_playback, volume);
+
+			return;
+		} else {
+			dev_err(&audio->gadget->dev,
+				"%s:%d control_selector=%d TODO!\n",
+				__func__, __LINE__, control_selector);
+			usb_ep_set_halt(ep);
+		}
+	} else {
+		dev_err(&audio->gadget->dev,
+			"%s:%d entity_id=%d control_selector=%d TODO!\n",
+			__func__, __LINE__, entity_id, control_selector);
+		usb_ep_set_halt(ep);
+
+	}
+}
+
+static int
+out_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
+{
+	struct usb_request *req = fn->config->cdev->req;
+	struct g_audio *audio = func_to_g_audio(fn);
+	struct f_uac1_opts *opts = g_audio_to_uac1_opts(audio);
+	struct f_uac1 *uac1 = func_to_uac1(&audio->func);
+	u16 w_length = le16_to_cpu(cr->wLength);
+	u16 w_index = le16_to_cpu(cr->wIndex);
+	u16 w_value = le16_to_cpu(cr->wValue);
+	u8 entity_id = (w_index >> 8) & 0xff;
+	u8 control_selector = w_value >> 8;
+
+	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+		memcpy(&uac1->setup_cr, cr, sizeof(*cr));
+		req->context = audio;
+		req->complete = out_rq_cur_complete;
+
+		return w_length;
+	} else {
+		dev_err(&audio->gadget->dev,
+			"%s:%d entity_id=%d control_selector=%d TODO!\n",
+			__func__, __LINE__, entity_id, control_selector);
+	}
+	return -EOPNOTSUPP;
+}
+
+static int ac_rq_in(struct usb_function *f,
+		const struct usb_ctrlrequest *ctrl)
+{
+	struct usb_composite_dev *cdev = f->config->cdev;
+	int value = -EOPNOTSUPP;
+	u8 ep = ((le16_to_cpu(ctrl->wIndex) >> 8) & 0xFF);
+	u16 len = le16_to_cpu(ctrl->wLength);
+	u16 w_value = le16_to_cpu(ctrl->wValue);
+
+	DBG(cdev, "bRequest 0x%x, w_value 0x%04x, len %d, endpoint %d\n",
+			ctrl->bRequest, w_value, len, ep);
+
+	switch (ctrl->bRequest) {
+	case UAC_GET_CUR:
+		return in_rq_cur(f, ctrl);
+	case UAC_GET_MIN:
+		return in_rq_min(f, ctrl);
+	case UAC_GET_MAX:
+		return in_rq_max(f, ctrl);
+	case UAC_GET_RES:
+		return in_rq_res(f, ctrl);
+	case UAC_GET_MEM:
+		break;
+	case UAC_GET_STAT:
+		value = len;
+		break;
+	default:
+		break;
+	}
+
+	return value;
+}
+
 static int audio_set_endpoint_req(struct usb_function *f,
 		const struct usb_ctrlrequest *ctrl)
 {
@@ -383,7 +788,13 @@ static int audio_get_endpoint_req(struct usb_function *f,
 	case USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_ENDPOINT:
 		value = audio_get_endpoint_req(f, ctrl);
 		break;
-
+	case USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE:
+		if (ctrl->bRequest == UAC_SET_CUR)
+			value = out_rq_cur(f, ctrl);
+		break;
+	case USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE:
+		value = ac_rq_in(f, ctrl);
+		break;
 	default:
 		ERROR(cdev, "invalid control req%02x.%02x v%04x i%04x l%d\n",
 			ctrl->bRequestType, ctrl->bRequest,
@@ -411,6 +822,7 @@ static int f_audio_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct device *dev = &gadget->dev;
+	struct g_audio *audio = func_to_g_audio(f);
 	struct f_uac1 *uac1 = func_to_uac1(f);
 	int ret = 0;
 
@@ -426,6 +838,14 @@ static int f_audio_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 			return -EINVAL;
 		}
+
+		/* restart interrupt endpoint */
+		if (uac1->int_ep) {
+			usb_ep_disable(uac1->int_ep);
+			config_ep_by_speed(gadget, &audio->func, uac1->int_ep);
+			usb_ep_enable(uac1->int_ep);
+		}
+
 		return 0;
 	}
 
@@ -481,10 +901,33 @@ static void f_audio_disable(struct usb_function *f)
 
 	u_audio_stop_playback(&uac1->g_audio);
 	u_audio_stop_capture(&uac1->g_audio);
+	if (uac1->int_ep)
+		usb_ep_disable(uac1->int_ep);
 }
 
 /*-------------------------------------------------------------------------*/
+static struct uac_feature_unit_descriptor *build_fu_desc(int chmask)
+{
+	struct uac_feature_unit_descriptor *fu_desc;
+	int channels = num_channels(chmask);
+	int fu_desc_size = UAC_DT_FEATURE_UNIT_SIZE(channels);
+
+	fu_desc = kzalloc(fu_desc_size, GFP_KERNEL);
+	if (!fu_desc)
+		return NULL;
+
+	fu_desc->bLength = fu_desc_size;
+	fu_desc->bDescriptorType = USB_DT_CS_INTERFACE;
+
+	fu_desc->bDescriptorSubtype = UAC_FEATURE_UNIT;
+	fu_desc->bControlSize  = 2;
 
+	/* bUnitID, bSourceID and bmaControls will be defined later */
+
+	return fu_desc;
+}
+
+/* B.3.2  Class-Specific AC Interface Descriptor */
 static struct
 uac1_ac_header_descriptor *build_ac_header_desc(struct f_uac1_opts *opts)
 {
@@ -530,9 +973,23 @@ static void setup_descriptor(struct f_uac1_opts *opts)
 		io_out_ot_desc.bTerminalID = i++;
 	if (EPIN_EN(opts))
 		usb_in_ot_desc.bTerminalID = i++;
-
-	usb_in_ot_desc.bSourceID = io_in_it_desc.bTerminalID;
-	io_out_ot_desc.bSourceID = usb_out_it_desc.bTerminalID;
+	if (FUOUT_EN(opts))
+		out_feature_unit_desc->bUnitID = i++;
+	if (FUIN_EN(opts))
+		in_feature_unit_desc->bUnitID = i++;
+
+	if (FUIN_EN(opts)) {
+		usb_in_ot_desc.bSourceID = in_feature_unit_desc->bUnitID;
+		in_feature_unit_desc->bSourceID = io_in_it_desc.bTerminalID;
+	} else {
+		usb_in_ot_desc.bSourceID = io_in_it_desc.bTerminalID;
+	}
+	if (FUOUT_EN(opts)) {
+		io_out_ot_desc.bSourceID = out_feature_unit_desc->bUnitID;
+		out_feature_unit_desc->bSourceID = usb_out_it_desc.bTerminalID;
+	} else {
+		io_out_ot_desc.bSourceID = usb_out_it_desc.bTerminalID;
+	}
 
 	as_out_header_desc.bTerminalLink = usb_out_it_desc.bTerminalID;
 	as_in_header_desc.bTerminalLink = usb_in_ot_desc.bTerminalID;
@@ -544,6 +1001,8 @@ static void setup_descriptor(struct f_uac1_opts *opts)
 
 		len += sizeof(usb_in_ot_desc);
 		len += sizeof(io_in_it_desc);
+		if (FUIN_EN(opts))
+			len += in_feature_unit_desc->bLength;
 		ac_header_desc->wTotalLength = cpu_to_le16(len);
 	}
 	if (EPOUT_EN(opts)) {
@@ -551,6 +1010,8 @@ static void setup_descriptor(struct f_uac1_opts *opts)
 
 		len += sizeof(usb_out_it_desc);
 		len += sizeof(io_out_ot_desc);
+		if (FUOUT_EN(opts))
+			len += out_feature_unit_desc->bLength;
 		ac_header_desc->wTotalLength = cpu_to_le16(len);
 	}
 
@@ -561,13 +1022,20 @@ static void setup_descriptor(struct f_uac1_opts *opts)
 	if (EPOUT_EN(opts)) {
 		f_audio_desc[i++] = USBDHDR(&usb_out_it_desc);
 		f_audio_desc[i++] = USBDHDR(&io_out_ot_desc);
+		if (FUOUT_EN(opts))
+			f_audio_desc[i++] = USBDHDR(out_feature_unit_desc);
 	}
 
 	if (EPIN_EN(opts)) {
 		f_audio_desc[i++] = USBDHDR(&io_in_it_desc);
 		f_audio_desc[i++] = USBDHDR(&usb_in_ot_desc);
+		if (FUIN_EN(opts))
+			f_audio_desc[i++] = USBDHDR(in_feature_unit_desc);
 	}
 
+	if (FUOUT_EN(opts) || FUIN_EN(opts))
+		f_audio_desc[i++] = USBDHDR(&ac_int_ep_desc);
+
 	if (EPOUT_EN(opts)) {
 		f_audio_desc[i++] = USBDHDR(&as_out_interface_alt_0_desc);
 		f_audio_desc[i++] = USBDHDR(&as_out_interface_alt_1_desc);
@@ -614,6 +1082,28 @@ static int f_audio_validate_opts(struct g_audio *audio, struct device *dev)
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
 
@@ -647,6 +1137,21 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	if (!ac_header_desc)
 		return -ENOMEM;
 
+	if (FUOUT_EN(audio_opts)) {
+		out_feature_unit_desc = build_fu_desc(audio_opts->c_chmask);
+		if (!out_feature_unit_desc) {
+			status = -ENOMEM;
+			goto fail;
+		}
+	}
+	if (FUIN_EN(audio_opts)) {
+		in_feature_unit_desc = build_fu_desc(audio_opts->p_chmask);
+		if (!in_feature_unit_desc) {
+			status = -ENOMEM;
+			goto err_free_fu;
+		}
+	}
+
 	ac_interface_desc.iInterface = us[STR_AC_IF].id;
 	usb_out_it_desc.iTerminal = us[STR_USB_OUT_IT].id;
 	usb_out_it_desc.iChannelNames = us[STR_USB_OUT_IT_CH_NAMES].id;
@@ -659,6 +1164,21 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	as_in_interface_alt_0_desc.iInterface = us[STR_AS_IN_IF_ALT0].id;
 	as_in_interface_alt_1_desc.iInterface = us[STR_AS_IN_IF_ALT1].id;
 
+	if (FUOUT_EN(audio_opts)) {
+		u8 *i_feature;
+
+		i_feature = (u8 *)out_feature_unit_desc +
+					out_feature_unit_desc->bLength - 1;
+		*i_feature = us[STR_FU_OUT].id;
+	}
+	if (FUIN_EN(audio_opts)) {
+		u8 *i_feature;
+
+		i_feature = (u8 *)in_feature_unit_desc +
+					in_feature_unit_desc->bLength - 1;
+		*i_feature = us[STR_FU_IN].id;
+	}
+
 	/* Set channel numbers */
 	usb_out_it_desc.bNrChannels = num_channels(audio_opts->c_chmask);
 	usb_out_it_desc.wChannelConfig = cpu_to_le16(audio_opts->c_chmask);
@@ -671,6 +1191,27 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	as_in_type_i_desc.bSubframeSize = audio_opts->p_ssize;
 	as_in_type_i_desc.bBitResolution = audio_opts->p_ssize * 8;
 
+	if (FUOUT_EN(audio_opts)) {
+		__le16 *bma = (__le16 *)&out_feature_unit_desc->bmaControls[0];
+		u32 control = 0;
+
+		if (audio_opts->c_mute_present)
+			control |= UAC_FU_MUTE;
+		if (audio_opts->c_volume_present)
+			control |= UAC_FU_VOLUME;
+		*bma = cpu_to_le16(control);
+	}
+	if (FUIN_EN(audio_opts)) {
+		__le16 *bma = (__le16 *)&in_feature_unit_desc->bmaControls[0];
+		u32 control = 0;
+
+		if (audio_opts->p_mute_present)
+			control |= UAC_FU_MUTE;
+		if (audio_opts->p_volume_present)
+			control |= UAC_FU_VOLUME;
+		*bma = cpu_to_le16(control);
+	}
+
 	/* Set sample rates */
 	rate = audio_opts->c_srate;
 	sam_freq = as_out_type_i_desc.tSamFreq[0];
@@ -682,7 +1223,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs, and patch descriptors */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		goto err_free_fu;
 	ac_interface_desc.bInterfaceNumber = status;
 	uac1->ac_intf = status;
 	uac1->ac_alt = 0;
@@ -692,7 +1233,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	if (EPOUT_EN(audio_opts)) {
 		status = usb_interface_id(c, f);
 		if (status < 0)
-			goto fail;
+			goto err_free_fu;
 		as_out_interface_alt_0_desc.bInterfaceNumber = status;
 		as_out_interface_alt_1_desc.bInterfaceNumber = status;
 		ac_header_desc->baInterfaceNr[ba_iface_id++] = status;
@@ -703,7 +1244,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	if (EPIN_EN(audio_opts)) {
 		status = usb_interface_id(c, f);
 		if (status < 0)
-			goto fail;
+			goto err_free_fu;
 		as_in_interface_alt_0_desc.bInterfaceNumber = status;
 		as_in_interface_alt_1_desc.bInterfaceNumber = status;
 		ac_header_desc->baInterfaceNr[ba_iface_id++] = status;
@@ -715,11 +1256,24 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = -ENODEV;
 
+	ac_interface_desc.bNumEndpoints = 0;
+
+	/* allocate AC interrupt endpoint */
+	if (FUOUT_EN(audio_opts) || FUIN_EN(audio_opts)) {
+		ep = usb_ep_autoconfig(cdev->gadget, &ac_int_ep_desc);
+		if (!ep)
+			goto err_free_fu;
+		uac1->int_ep = ep;
+		uac1->int_ep->desc = &ac_int_ep_desc;
+
+		ac_interface_desc.bNumEndpoints = 1;
+	}
+
 	/* allocate instance-specific endpoints */
 	if (EPOUT_EN(audio_opts)) {
 		ep = usb_ep_autoconfig(cdev->gadget, &as_out_ep_desc);
 		if (!ep)
-			goto fail;
+			goto err_free_fu;
 		audio->out_ep = ep;
 		audio->out_ep->desc = &as_out_ep_desc;
 	}
@@ -727,7 +1281,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	if (EPIN_EN(audio_opts)) {
 		ep = usb_ep_autoconfig(cdev->gadget, &as_in_ep_desc);
 		if (!ep)
-			goto fail;
+			goto err_free_fu;
 		audio->in_ep = ep;
 		audio->in_ep->desc = &as_in_ep_desc;
 	}
@@ -738,17 +1292,37 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, f_audio_desc, f_audio_desc, NULL,
 					NULL);
 	if (status)
-		goto fail;
+		goto err_free_fu;
 
 	audio->out_ep_maxpsize = le16_to_cpu(as_out_ep_desc.wMaxPacketSize);
 	audio->in_ep_maxpsize = le16_to_cpu(as_in_ep_desc.wMaxPacketSize);
 	audio->params.c_chmask = audio_opts->c_chmask;
 	audio->params.c_srate = audio_opts->c_srate;
 	audio->params.c_ssize = audio_opts->c_ssize;
+	if (FUIN_EN(audio_opts)) {
+		audio->params.p_fu.id = USB_IN_FU_ID;
+		audio->params.p_fu.mute_present = audio_opts->p_mute_present;
+		audio->params.p_fu.volume_present =
+				audio_opts->p_volume_present;
+		audio->params.p_fu.volume_min = audio_opts->p_volume_min;
+		audio->params.p_fu.volume_max = audio_opts->p_volume_max;
+		audio->params.p_fu.volume_res = audio_opts->p_volume_res;
+	}
 	audio->params.p_chmask = audio_opts->p_chmask;
 	audio->params.p_srate = audio_opts->p_srate;
 	audio->params.p_ssize = audio_opts->p_ssize;
+	if (FUOUT_EN(audio_opts)) {
+		audio->params.c_fu.id = USB_OUT_FU_ID;
+		audio->params.c_fu.mute_present = audio_opts->c_mute_present;
+		audio->params.c_fu.volume_present =
+				audio_opts->c_volume_present;
+		audio->params.c_fu.volume_min = audio_opts->c_volume_min;
+		audio->params.c_fu.volume_max = audio_opts->c_volume_max;
+		audio->params.c_fu.volume_res = audio_opts->c_volume_res;
+	}
 	audio->params.req_number = audio_opts->req_number;
+	if (FUOUT_EN(audio_opts) || FUIN_EN(audio_opts))
+		audio->notify = audio_notify;
 
 	status = g_audio_setup(audio, "UAC1_PCM", "UAC1_Gadget");
 	if (status)
@@ -758,6 +1332,11 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 
 err_card_register:
 	usb_free_all_descriptors(f);
+err_free_fu:
+	kfree(out_feature_unit_desc);
+	out_feature_unit_desc = NULL;
+	kfree(in_feature_unit_desc);
+	in_feature_unit_desc = NULL;
 fail:
 	kfree(ac_header_desc);
 	ac_header_desc = NULL;
@@ -783,7 +1362,15 @@ static void f_uac1_attr_release(struct config_item *item)
 	.release	= f_uac1_attr_release,
 };
 
-#define UAC1_ATTRIBUTE(name)						\
+#define uac1_kstrtou32			kstrtou32
+#define uac1_kstrtos16			kstrtos16
+#define uac1_kstrtobool(s, base, res)	kstrtobool((s), (res))
+
+static const char *u32_fmt = "%u\n";
+static const char *s16_fmt = "%hd\n";
+static const char *bool_fmt = "%u\n";
+
+#define UAC1_ATTRIBUTE(type, name)					\
 static ssize_t f_uac1_opts_##name##_show(				\
 					  struct config_item *item,	\
 					  char *page)			\
@@ -792,7 +1379,7 @@ static void f_uac1_attr_release(struct config_item *item)
 	int result;							\
 									\
 	mutex_lock(&opts->lock);					\
-	result = sprintf(page, "%u\n", opts->name);			\
+	result = sprintf(page, type##_fmt, opts->name);			\
 	mutex_unlock(&opts->lock);					\
 									\
 	return result;							\
@@ -804,7 +1391,7 @@ static void f_uac1_attr_release(struct config_item *item)
 {									\
 	struct f_uac1_opts *opts = to_f_uac1_opts(item);		\
 	int ret;							\
-	u32 num;							\
+	type num;							\
 									\
 	mutex_lock(&opts->lock);					\
 	if (opts->refcnt) {						\
@@ -812,7 +1399,7 @@ static void f_uac1_attr_release(struct config_item *item)
 		goto end;						\
 	}								\
 									\
-	ret = kstrtou32(page, 0, &num);					\
+	ret = uac1_kstrto##type(page, 0, &num);				\
 	if (ret)							\
 		goto end;						\
 									\
@@ -826,13 +1413,25 @@ static void f_uac1_attr_release(struct config_item *item)
 									\
 CONFIGFS_ATTR(f_uac1_opts_, name)
 
-UAC1_ATTRIBUTE(c_chmask);
-UAC1_ATTRIBUTE(c_srate);
-UAC1_ATTRIBUTE(c_ssize);
-UAC1_ATTRIBUTE(p_chmask);
-UAC1_ATTRIBUTE(p_srate);
-UAC1_ATTRIBUTE(p_ssize);
-UAC1_ATTRIBUTE(req_number);
+UAC1_ATTRIBUTE(u32, c_chmask);
+UAC1_ATTRIBUTE(u32, c_srate);
+UAC1_ATTRIBUTE(u32, c_ssize);
+UAC1_ATTRIBUTE(u32, p_chmask);
+UAC1_ATTRIBUTE(u32, p_srate);
+UAC1_ATTRIBUTE(u32, p_ssize);
+UAC1_ATTRIBUTE(u32, req_number);
+
+UAC1_ATTRIBUTE(bool, p_mute_present);
+UAC1_ATTRIBUTE(bool, p_volume_present);
+UAC1_ATTRIBUTE(s16, p_volume_min);
+UAC1_ATTRIBUTE(s16, p_volume_max);
+UAC1_ATTRIBUTE(s16, p_volume_res);
+
+UAC1_ATTRIBUTE(bool, c_mute_present);
+UAC1_ATTRIBUTE(bool, c_volume_present);
+UAC1_ATTRIBUTE(s16, c_volume_min);
+UAC1_ATTRIBUTE(s16, c_volume_max);
+UAC1_ATTRIBUTE(s16, c_volume_res);
 
 static struct configfs_attribute *f_uac1_attrs[] = {
 	&f_uac1_opts_attr_c_chmask,
@@ -842,6 +1441,19 @@ static void f_uac1_attr_release(struct config_item *item)
 	&f_uac1_opts_attr_p_srate,
 	&f_uac1_opts_attr_p_ssize,
 	&f_uac1_opts_attr_req_number,
+
+	&f_uac1_opts_attr_p_mute_present,
+	&f_uac1_opts_attr_p_volume_present,
+	&f_uac1_opts_attr_p_volume_min,
+	&f_uac1_opts_attr_p_volume_max,
+	&f_uac1_opts_attr_p_volume_res,
+
+	&f_uac1_opts_attr_c_mute_present,
+	&f_uac1_opts_attr_c_volume_present,
+	&f_uac1_opts_attr_c_volume_min,
+	&f_uac1_opts_attr_c_volume_max,
+	&f_uac1_opts_attr_c_volume_res,
+
 	NULL,
 };
 
@@ -879,6 +1491,19 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
 	opts->p_chmask = UAC1_DEF_PCHMASK;
 	opts->p_srate = UAC1_DEF_PSRATE;
 	opts->p_ssize = UAC1_DEF_PSSIZE;
+
+	opts->p_mute_present = UAC1_DEF_MUTE_PRESENT;
+	opts->p_volume_present = UAC1_DEF_VOLUME_PRESENT;
+	opts->p_volume_min = UAC1_DEF_MIN_DB;
+	opts->p_volume_max = UAC1_DEF_MAX_DB;
+	opts->p_volume_res = UAC1_DEF_RES_DB;
+
+	opts->c_mute_present = UAC1_DEF_MUTE_PRESENT;
+	opts->c_volume_present = UAC1_DEF_VOLUME_PRESENT;
+	opts->c_volume_min = UAC1_DEF_MIN_DB;
+	opts->c_volume_max = UAC1_DEF_MAX_DB;
+	opts->c_volume_res = UAC1_DEF_RES_DB;
+
 	opts->req_number = UAC1_DEF_REQ_NUM;
 	return &opts->func_inst;
 }
@@ -903,6 +1528,11 @@ static void f_audio_unbind(struct usb_configuration *c, struct usb_function *f)
 	g_audio_cleanup(audio);
 	usb_free_all_descriptors(f);
 
+	kfree(out_feature_unit_desc);
+	out_feature_unit_desc = NULL;
+	kfree(in_feature_unit_desc);
+	in_feature_unit_desc = NULL;
+
 	kfree(ac_header_desc);
 	ac_header_desc = NULL;
 
diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/function/u_uac1.h
index 39c0e29..6a06594 100644
--- a/drivers/usb/gadget/function/u_uac1.h
+++ b/drivers/usb/gadget/function/u_uac1.h
@@ -18,6 +18,13 @@
 #define UAC1_DEF_PSRATE		48000
 #define UAC1_DEF_PSSIZE		2
 #define UAC1_DEF_REQ_NUM	2
+#define UAC1_DEF_INT_REQ_NUM	10
+
+#define UAC1_DEF_MUTE_PRESENT	1
+#define UAC1_DEF_VOLUME_PRESENT 1
+#define UAC1_DEF_MIN_DB		(-100*256)	/* -100 dB */
+#define UAC1_DEF_MAX_DB		0		/* 0 dB */
+#define UAC1_DEF_RES_DB		(1*256)	/* 1 dB */
 
 
 struct f_uac1_opts {
@@ -28,6 +35,19 @@ struct f_uac1_opts {
 	int				p_chmask;
 	int				p_srate;
 	int				p_ssize;
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
 	unsigned			bound:1;
 
-- 
1.9.1

