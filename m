Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8CE31D2A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 23:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhBPW1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 17:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhBPW0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:26:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCB7C061788;
        Tue, 16 Feb 2021 14:25:41 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id v24so18435039lfr.7;
        Tue, 16 Feb 2021 14:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0hv1vhtBNEC/VvoxA9ZstUBo9bWgHWvQ34dUYSl1J1w=;
        b=oHF4ywGln27m1vS1PqleNjrNrE/wr3Gc0ljAZmkKRlSGN4JFhhrG/MjmKBWaX0VBQ2
         iE4LxdG3cxlNSTKHXVesfr0dWVuxDEcfHblVDhjQzcyvHaugtmUOW2qPxwQX9I/9wSoW
         JrfyeQKSXKiX6oZkPE1KQ3UU7YOWytwDQUIPsBWnYbC8Yc4r8M4tESlrvQvNokCWsQPa
         7QLQCqibEA/mz4O73LAG3xAaB10NoaWNG8c+UxuhdYAJ9a3EJTTZJEBxKqCknlS4POr9
         ChuSDAkIy5C+5JmVSXx0x67Y5Tfz97UgPRHYcJLPAffKMeaT4a73e19rSC5L1yPg1n/+
         datg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0hv1vhtBNEC/VvoxA9ZstUBo9bWgHWvQ34dUYSl1J1w=;
        b=W+6TlGmzWaEm3Vd2+AZgjdbW10q+zSSCtzQEEnuDcMsHTpYEpwbKgi6mHnBJyhIiTl
         zh+fEHd/wIQ3rwPCbrHVmqsYiUaoZ+tPhJcqFXGRA3eyBa4itUdDshArhpJ3sx/gq30a
         FxaTRjs9dr7RiYYcGZiXCWYTEdn7ArIUzkBNsND5hVSvk9z3IPR06iQ5W+BwDjVTzUsQ
         lCXfrFfvXku6oJwbMHr2JSZOAKL36btqwmLjaoIu8f4q9+HgYpvCqC27fHGlP2UlaMW2
         YuuOF8ljaQ/bJlzBJdNqz5Z564gX9BOu9H7JCE34AF/jOAerhP4aSofcDgDRwCbOPiwY
         XkjA==
X-Gm-Message-State: AOAM5335st+tMa8OpwOgOVXVhBHaVG2CdIw/afRNtjUNA/E4U09MjSm3
        bFx+NFkzWdvZbG7mCmhxkPo=
X-Google-Smtp-Source: ABdhPJxXXUMJgA0rF0ljoL5OtOjuh1W0mpQZYElrQig/3sWocVIMvHcPWEs/gLP0Li430oEmjtHM/A==
X-Received: by 2002:a19:c48:: with SMTP id 69mr10513773lfm.573.1613514339626;
        Tue, 16 Feb 2021 14:25:39 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id w9sm18437lfn.308.2021.02.16.14.25.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 Feb 2021 14:25:38 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Chen <peter.chen@freescale.com>,
        Daniel Mack <zonque@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH 4/5] usb: gadget: f_uac1: validate input parameters
Date:   Wed, 17 Feb 2021 00:24:58 +0200
Message-Id: <1613514299-20668-5-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1613514299-20668-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1613514299-20668-1-git-send-email-ruslan.bilovol@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently user can configure UAC1 function with
parameters that violate UAC1 spec or are not supported
by UAC1 gadget implementation.

This can lead to incorrect behavior if such gadget
is connected to the host - like enumeration failure
or other issues depending on host's UAC1 driver
implementation, bringing user to a long hours
of debugging the issue.

Instead of silently accept these parameters, throw
an error if they are not valid.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 drivers/usb/gadget/function/f_uac1.c | 43 ++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 560382e..cce9478f 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -19,6 +19,9 @@
 #include "u_audio.h"
 #include "u_uac1.h"
 
+/* UAC1 spec: 3.7.2.3 Audio Channel Cluster Format */
+#define UAC1_CHANNEL_MASK 0x0FFF
+
 struct f_uac1 {
 	struct g_audio g_audio;
 	u8 ac_intf, as_in_intf, as_out_intf;
@@ -30,6 +33,11 @@ static inline struct f_uac1 *func_to_uac1(struct usb_function *f)
 	return container_of(f, struct f_uac1, g_audio.func);
 }
 
+static inline struct f_uac1_opts *g_audio_to_uac1_opts(struct g_audio *audio)
+{
+	return container_of(audio->func.fi, struct f_uac1_opts, func_inst);
+}
+
 /*
  * DESCRIPTORS ... most are static, but strings and full
  * configuration descriptors are built on demand.
@@ -505,6 +513,37 @@ static void f_audio_disable(struct usb_function *f)
 
 /*-------------------------------------------------------------------------*/
 
+static int f_audio_validate_opts(struct g_audio *audio)
+{
+	struct f_uac1_opts *opts = g_audio_to_uac1_opts(audio);
+	struct device *dev = &audio->gadget->dev;
+
+	if (!opts->p_chmask && !opts->c_chmask) {
+		dev_err(dev, "Error: no playback and capture channels\n");
+		return -EINVAL;
+	} else if (opts->p_chmask & ~UAC1_CHANNEL_MASK) {
+		dev_err(dev, "Error: unsupported playback channels mask\n");
+		return -EINVAL;
+	} else if (opts->c_chmask & ~UAC1_CHANNEL_MASK) {
+		dev_err(dev, "Error: unsupported capture channels mask\n");
+		return -EINVAL;
+	} else if ((opts->p_ssize < 1) || (opts->p_ssize > 4)) {
+		dev_err(dev, "Error: incorrect playback sample size\n");
+		return -EINVAL;
+	} else if ((opts->c_ssize < 1) || (opts->c_ssize > 4)) {
+		dev_err(dev, "Error: incorrect capture sample size\n");
+		return -EINVAL;
+	} else if (!opts->p_srate) {
+		dev_err(dev, "Error: incorrect playback sampling rate\n");
+		return -EINVAL;
+	} else if (!opts->c_srate) {
+		dev_err(dev, "Error: incorrect capture sampling rate\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* audio function driver setup/binding */
 static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 {
@@ -519,6 +558,10 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	int				rate;
 	int				status;
 
+	status = f_audio_validate_opts(audio);
+	if (status)
+		return status;
+
 	audio_opts = container_of(f->fi, struct f_uac1_opts, func_inst);
 
 	us = usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings_uac1));
-- 
1.9.1

