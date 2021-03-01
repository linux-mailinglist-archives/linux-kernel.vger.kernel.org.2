Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83AA327EFD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhCANHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbhCANGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:06:40 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73557C061793;
        Mon,  1 Mar 2021 05:05:53 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m22so25390141lfg.5;
        Mon, 01 Mar 2021 05:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gU83WGpEZp2h24/51Icfdjweds3oyy6j2+c/S4xga+o=;
        b=u97RxWBj2v/gg1vElCSfYOSaL311Nk/1SMhtfwi9UXCzYj/jqNtYYOxWQtBje9YRgl
         HkYtNhSu41umzslVyyqhR4PblZs9zbibwxViTnFAuCFmFxI9Rn18CXcDeox1zppvy9M3
         RTwmlE7zuByUCr/NKPhlXmK/epAoJbV/dobJmqdWq7a5jK06uuG1ErsGhXChqlEYZ23i
         EG/mua3DxzmQSDrFxf5fSlia7S5a0dr6LpxhC/0sBaGW2mwCXOc2gwqepvWzfB7sNoxs
         YPVOf8aUFwliO6EewE4sEWyJgQfLoTarSO915zDU0TTeMRTOHHjc0SwXqBmffs3mrpCt
         mWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gU83WGpEZp2h24/51Icfdjweds3oyy6j2+c/S4xga+o=;
        b=D7uBhvunl1/IQFJuiUDiQH0YLP8m80jihiTfnvQH7Hm+20ph8yqXOZWrYsU1XzjRT1
         IQVuFhZQMIDI9+yXqp7/18cOrnmfLP45kbFydFcXZQmtE/WFVj8UjC3CezHsEroxuOt6
         qVEMYUFhxn/u925Mu8ogFvIW68L+Uy2uyd/TSF+a3CN1rXL3ool74xb2cpshUgLPhHzK
         2QVYNaRR36h/k/dFWnVkjKQTCzyiosCJlSaBIS49mXSyIo5UoHuzQQqMhr9Y7J6lIV3d
         0a6j+5IaxmYHFcNZuCDZsWRI3rRJu3tvRWLtv1E52a+Igb5dRnHj1niZo0zFxHvOaQiL
         lbFQ==
X-Gm-Message-State: AOAM530sUmrqtZVElvkZgHNg5PC6xQwxc1TXO+UTw7Rt56li4YO3kjap
        gc/FYcjba9idZy5mD3x14AhMk+89XL9AGYF0
X-Google-Smtp-Source: ABdhPJw1VcabbfjWUsjI2x/08y42iNcYh6qhajwj/O+dTeZ1xeIbvogvXGn6sSoDScWQYnBebfCKUg==
X-Received: by 2002:ac2:5977:: with SMTP id h23mr9621350lfp.156.1614603951973;
        Mon, 01 Mar 2021 05:05:51 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id l12sm215980lfc.248.2021.03.01.05.05.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 05:05:50 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     gschmottlach@gmail.com, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] usb: gadget: f_uac2/u_audio: add feedback endpoint support
Date:   Mon,  1 Mar 2021 15:05:37 +0200
Message-Id: <1614603943-11668-3-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per USB and UAC2 specs, asynchronous audio sink endpoint
requires explicit synchronization mechanism (Isochronous
Feedback Endpoint)

Implement feedback companion endpoint for ISO OUT endpoint

This patch adds all required infrastructure and USB requests
handling for feedback endpoint. Syncrhonization itself is
still dummy (feedback ep always reports 'nomimal frequency'
 e.g. no adjustement is needed). This satisfies hosts that
require feedback endpoint (like Win10) and poll it periodically

Actual synchronization mechanism should be implemented
separately

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 drivers/usb/gadget/function/f_uac2.c  |  34 +++++++-
 drivers/usb/gadget/function/u_audio.c | 141 +++++++++++++++++++++++++++++++++-
 drivers/usb/gadget/function/u_audio.h |   3 +
 3 files changed, 175 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index f868e38..6f7b7c1 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -240,7 +240,7 @@ enum {
 	.bDescriptorType = USB_DT_INTERFACE,
 
 	.bAlternateSetting = 1,
-	.bNumEndpoints = 1,
+	.bNumEndpoints = 2,
 	.bInterfaceClass = USB_CLASS_AUDIO,
 	.bInterfaceSubClass = USB_SUBCLASS_AUDIOSTREAMING,
 	.bInterfaceProtocol = UAC_VERSION_2,
@@ -299,6 +299,27 @@ enum {
 	.wLockDelay = 0,
 };
 
+/* STD AS ISO IN Feedback Endpoint */
+static struct usb_endpoint_descriptor fs_epin_fback_desc = {
+	.bLength = USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+
+	.bEndpointAddress = USB_DIR_IN,
+	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_USAGE_FEEDBACK,
+	.wMaxPacketSize = cpu_to_le16(3),
+	.bInterval = 1,
+};
+
+static struct usb_endpoint_descriptor hs_epin_fback_desc = {
+	.bLength = USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+
+	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_USAGE_FEEDBACK,
+	.wMaxPacketSize = cpu_to_le16(4),
+	.bInterval = 4,
+};
+
+
 /* Audio Streaming IN Interface - Alt0 */
 static struct usb_interface_descriptor std_as_in_if0_desc = {
 	.bLength = sizeof std_as_in_if0_desc,
@@ -395,6 +416,7 @@ enum {
 	(struct usb_descriptor_header *)&as_out_fmt1_desc,
 	(struct usb_descriptor_header *)&fs_epout_desc,
 	(struct usb_descriptor_header *)&as_iso_out_desc,
+	(struct usb_descriptor_header *)&fs_epin_fback_desc,
 
 	(struct usb_descriptor_header *)&std_as_in_if0_desc,
 	(struct usb_descriptor_header *)&std_as_in_if1_desc,
@@ -425,6 +447,7 @@ enum {
 	(struct usb_descriptor_header *)&as_out_fmt1_desc,
 	(struct usb_descriptor_header *)&hs_epout_desc,
 	(struct usb_descriptor_header *)&as_iso_out_desc,
+	(struct usb_descriptor_header *)&hs_epin_fback_desc,
 
 	(struct usb_descriptor_header *)&std_as_in_if0_desc,
 	(struct usb_descriptor_header *)&std_as_in_if1_desc,
@@ -562,6 +585,7 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 		fs_audio_desc[i++] = USBDHDR(&as_out_fmt1_desc);
 		fs_audio_desc[i++] = USBDHDR(&fs_epout_desc);
 		fs_audio_desc[i++] = USBDHDR(&as_iso_out_desc);
+		fs_audio_desc[i++] = USBDHDR(&fs_epin_fback_desc);
 	}
 	if (EPIN_EN(opts)) {
 		fs_audio_desc[i++] = USBDHDR(&std_as_in_if0_desc);
@@ -595,6 +619,7 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 		hs_audio_desc[i++] = USBDHDR(&as_out_fmt1_desc);
 		hs_audio_desc[i++] = USBDHDR(&hs_epout_desc);
 		hs_audio_desc[i++] = USBDHDR(&as_iso_out_desc);
+		hs_audio_desc[i++] = USBDHDR(&hs_epin_fback_desc);
 	}
 	if (EPIN_EN(opts)) {
 		hs_audio_desc[i++] = USBDHDR(&std_as_in_if0_desc);
@@ -757,6 +782,12 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 			return -ENODEV;
 		}
+		agdev->in_ep_fback = usb_ep_autoconfig(gadget,
+						       &fs_epin_fback_desc);
+		if (!agdev->in_ep_fback) {
+			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+			return -ENODEV;
+		}
 	}
 
 	if (EPIN_EN(uac2_opts)) {
@@ -775,6 +806,7 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 				le16_to_cpu(hs_epout_desc.wMaxPacketSize));
 
 	hs_epout_desc.bEndpointAddress = fs_epout_desc.bEndpointAddress;
+	hs_epin_fback_desc.bEndpointAddress = fs_epin_fback_desc.bEndpointAddress;
 	hs_epin_desc.bEndpointAddress = fs_epin_desc.bEndpointAddress;
 
 	setup_descriptor(uac2_opts);
diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 5fbceee..8e74b54 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -38,6 +38,12 @@ struct uac_rtd_params {
 	unsigned int max_psize;	/* MaxPacketSize of endpoint */
 
 	struct usb_request **reqs;
+
+	struct usb_request *req_fback; /* Feedback endpoint request */
+	unsigned int ffback; /* Real frequency reported by feedback endpoint */
+	bool fb_ep_enabled; /* if the ep is enabled */
+
+	spinlock_t lock; /* lock for feedback and control transfers */
 };
 
 struct snd_uac_chip {
@@ -70,6 +76,35 @@ struct snd_uac_chip {
 	.periods_min = MIN_PERIODS,
 };
 
+static void u_audio_set_fback_frequency(enum usb_device_speed speed,
+					unsigned int freq, void *buf)
+{
+	u32 ff = 0;
+
+	if (speed == USB_SPEED_FULL) {
+		/*
+		 * Full-speed feedback endpoints report frequency
+		 * in samples/microframe
+		 * Format is encoded in Q10.10 left-justified in the 24 bits,
+		 * so that it has a Q10.14 format.
+		 */
+		ff = DIV_ROUND_UP((freq << 14), 1000);
+	} else {
+		/*
+		 * High-speed feedback endpoints report frequency
+		 * in samples/microframe.
+		 * Format is encoded in Q12.13 fitted into four bytes so that
+		 * the binary point is located between the second and the third
+		 * byte format (that is Q16.16)
+		 *
+		 * Prevent integer overflow by calculating in Q12.13 format and
+		 * then shifting to Q16.16
+		 */
+		ff = DIV_ROUND_UP((freq << 13), (8*1000)) << 3;
+	}
+	*(__le32 *)buf = cpu_to_le32(ff);
+}
+
 static void u_audio_iso_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	unsigned int pending;
@@ -173,6 +208,42 @@ static void u_audio_iso_complete(struct usb_ep *ep, struct usb_request *req)
 		dev_err(uac->card->dev, "%d Error!\n", __LINE__);
 }
 
+static void u_audio_iso_fback_complete(struct usb_ep *ep,
+				       struct usb_request *req)
+{
+	struct uac_rtd_params *prm = req->context;
+	struct snd_uac_chip *uac = prm->uac;
+	struct g_audio *audio_dev = uac->audio_dev;
+	int status = req->status;
+	unsigned long flags;
+
+	/* i/f shutting down */
+	if (!prm->ep_enabled) {
+		kfree(req->buf);
+		usb_ep_free_request(ep, req);
+		return;
+	}
+
+	if (req->status == -ESHUTDOWN)
+		return;
+
+	/*
+	 * We can't really do much about bad xfers.
+	 * Afterall, the ISOCH xfers could fail legitimately.
+	 */
+	if (status)
+		pr_debug("%s: iso_complete status(%d) %d/%d\n",
+			__func__, status, req->actual, req->length);
+
+	spin_lock_irqsave(&prm->lock, flags);
+	u_audio_set_fback_frequency(audio_dev->gadget->speed,
+				    prm->ffback, req->buf);
+	spin_unlock_irqrestore(&prm->lock, flags);
+
+	if (usb_ep_queue(ep, req, GFP_ATOMIC))
+		dev_err(uac->card->dev, "%d Error!\n", __LINE__);
+}
+
 static int uac_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_uac_chip *uac = snd_pcm_substream_chip(substream);
@@ -335,14 +406,40 @@ static inline void free_ep(struct uac_rtd_params *prm, struct usb_ep *ep)
 		dev_err(uac->card->dev, "%s:%d Error!\n", __func__, __LINE__);
 }
 
+static inline void free_ep_fback(struct uac_rtd_params *prm, struct usb_ep *ep)
+{
+	struct snd_uac_chip *uac = prm->uac;
+
+	if (!prm->fb_ep_enabled)
+		return;
+
+	prm->fb_ep_enabled = false;
+
+	if (prm->req_fback) {
+		if (usb_ep_dequeue(ep, prm->req_fback)) {
+			kfree(prm->req_fback->buf);
+			usb_ep_free_request(ep, prm->req_fback);
+		}
+		/*
+		 * If usb_ep_dequeue() cannot successfully dequeue the
+		 * request, the request will be freed by the completion
+		 * callback.
+		 */
+
+		prm->req_fback = NULL;
+	}
+
+	if (usb_ep_disable(ep))
+		dev_err(uac->card->dev, "%s:%d Error!\n", __func__, __LINE__);
+}
 
 int u_audio_start_capture(struct g_audio *audio_dev)
 {
 	struct snd_uac_chip *uac = audio_dev->uac;
 	struct usb_gadget *gadget = audio_dev->gadget;
 	struct device *dev = &gadget->dev;
-	struct usb_request *req;
-	struct usb_ep *ep;
+	struct usb_request *req, *req_fback;
+	struct usb_ep *ep, *ep_fback;
 	struct uac_rtd_params *prm;
 	struct uac_params *params = &audio_dev->params;
 	int req_len, i;
@@ -374,6 +471,42 @@ int u_audio_start_capture(struct g_audio *audio_dev)
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 	}
 
+	ep_fback = audio_dev->in_ep_fback;
+	if (!ep_fback)
+		return 0;
+
+	/* Setup feedback endpoint */
+	config_ep_by_speed(gadget, &audio_dev->func, ep_fback);
+	prm->fb_ep_enabled = true;
+	usb_ep_enable(ep_fback);
+	req_len = ep_fback->maxpacket;
+
+	req_fback = usb_ep_alloc_request(ep_fback, GFP_ATOMIC);
+	if (req_fback == NULL)
+		return -ENOMEM;
+
+	prm->req_fback = req_fback;
+	req_fback->zero = 0;
+	req_fback->context = prm;
+	req_fback->length = req_len;
+	req_fback->complete = u_audio_iso_fback_complete;
+
+	req_fback->buf = kzalloc(req_len, GFP_ATOMIC);
+	if (!req_fback->buf)
+		return -ENOMEM;
+
+	/*
+	 * Configure the feedback endpoint's reported frequency.
+	 * Always start with original frequency since its deviation can't
+	 * be measured at start of playback
+	 */
+	prm->ffback = params->c_srate;
+	u_audio_set_fback_frequency(audio_dev->gadget->speed,
+				    prm->ffback, req_fback->buf);
+
+	if (usb_ep_queue(ep_fback, req_fback, GFP_ATOMIC))
+		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(u_audio_start_capture);
@@ -382,6 +515,8 @@ void u_audio_stop_capture(struct g_audio *audio_dev)
 {
 	struct snd_uac_chip *uac = audio_dev->uac;
 
+	if (audio_dev->in_ep_fback)
+		free_ep_fback(&uac->c_prm, audio_dev->in_ep_fback);
 	free_ep(&uac->c_prm, audio_dev->out_ep);
 }
 EXPORT_SYMBOL_GPL(u_audio_stop_capture);
@@ -489,6 +624,7 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 	if (c_chmask) {
 		struct uac_rtd_params *prm = &uac->c_prm;
 
+		spin_lock_init(&prm->lock);
 		uac->c_prm.uac = uac;
 		prm->max_psize = g_audio->out_ep_maxpsize;
 
@@ -512,6 +648,7 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 	if (p_chmask) {
 		struct uac_rtd_params *prm = &uac->p_prm;
 
+		spin_lock_init(&prm->lock);
 		uac->p_prm.uac = uac;
 		prm->max_psize = g_audio->in_ep_maxpsize;
 
diff --git a/drivers/usb/gadget/function/u_audio.h b/drivers/usb/gadget/function/u_audio.h
index 5ea6b86..53e6baf 100644
--- a/drivers/usb/gadget/function/u_audio.h
+++ b/drivers/usb/gadget/function/u_audio.h
@@ -30,7 +30,10 @@ struct g_audio {
 	struct usb_gadget *gadget;
 
 	struct usb_ep *in_ep;
+
 	struct usb_ep *out_ep;
+	/* feedback IN endpoint corresponding to out_ep */
+	struct usb_ep *in_ep_fback;
 
 	/* Max packet size for all in_ep possible speeds */
 	unsigned int in_ep_maxpsize;
-- 
1.9.1

