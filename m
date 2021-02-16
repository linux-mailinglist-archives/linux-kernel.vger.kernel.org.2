Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C675931D2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 23:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhBPW0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 17:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhBPW0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:26:18 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF71C06174A;
        Tue, 16 Feb 2021 14:25:38 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id k22so13139168ljg.3;
        Tue, 16 Feb 2021 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N4o9VGOBWFA758XVAHeyCXnCwkuwkBvdGPfVojRuDf4=;
        b=lo7wNep8PSSvtzIJHYo0Fcpqgc8lww4iyzOFamqEMZ4fwcl5KadKkJrJq+F5sxMaY3
         x3fS+85wd/GAmArt/kL55Dghkzr1ja28x80buIMyJOzmqzv7F0QjcTQ8cEJ0fsJn8aK7
         jKXf0CeYaEokvSWXstfZCJkt/iSIWmHRCTCZ1ImPp816NfrUpLqFwHtLeDoU8fLgfZ+k
         QvIIOXjhqYiKTdMGAlvTe2wCeo/W5PisG1WacCAzUBsYlupnCyH4mUAU7HcvR3AV2zJT
         dkTIbeAOPGhbIiU+Y+bz634j5ms+EYPBmTXhxqx+GYqYAlRIKZgUyknHEasSL+8wFDgr
         EZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N4o9VGOBWFA758XVAHeyCXnCwkuwkBvdGPfVojRuDf4=;
        b=QmzAf//lvd9sa3fP8F1zWUuTaSez0CrJR/kTjv1C4DZ+8gjvo8s7wMVH3eLTe3gb5k
         WM+FKiAb7NdJ5vm2dGD5wzXpH22dJwpG546KshIZGLmV45ogXs87RqAuPLd4v2S0msoe
         0HJR/M8x8mc77WVocFw54V0vIfH01UIWZubAzOfBMbTqb50FW+W9ar4ESDvF8Kc3udH/
         G79rBqWjsQtrcbTc4lrbaeO9pW/P+Z2osgNXlybIIyf0xI6dp5qKroxe7ixUWp9YEit8
         IFLO1POiTkqR30YRdlE/1c0/l7frwWU3cCxyYqBUesQlbsPkX5ujqWRZFScXPL6Ee+X8
         wL1Q==
X-Gm-Message-State: AOAM53184YQ8BRSmDLYKt1uZAHZJW8+7lIvh3VTHapvRcnoH/mOLCHAO
        CkFD5tcWxtRajbdsMpRiiVo=
X-Google-Smtp-Source: ABdhPJzPteoeNpzGpmRaYqH29fxrI8vRh7u7OkfwDt7HNocuHro6bqsaqaHlKLb9do4HaycQWtLFyQ==
X-Received: by 2002:a05:651c:2c5:: with SMTP id f5mr13193149ljo.357.1613514336497;
        Tue, 16 Feb 2021 14:25:36 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id u1sm22628lff.58.2021.02.16.14.25.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 Feb 2021 14:25:35 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Chen <peter.chen@freescale.com>,
        Daniel Mack <zonque@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH 3/5] usb: gadget: f_uac2: validate input parameters
Date:   Wed, 17 Feb 2021 00:24:57 +0200
Message-Id: <1613514299-20668-4-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1613514299-20668-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1613514299-20668-1-git-send-email-ruslan.bilovol@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently user can configure UAC2 function with
parameters that violate UAC2 spec or are not supported
by UAC2 gadget implementation.

This can lead to incorrect behavior if such gadget
is connected to the host - like enumeration failure
or other issues depending on host's UAC2 driver
implementation, bringing user to a long hours
of debugging the issue.

Instead of silently accept these parameters, throw
an error if they are not valid.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 drivers/usb/gadget/function/f_uac2.c | 40 ++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index c62cccb..d0e50fc 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -14,6 +14,9 @@
 #include "u_audio.h"
 #include "u_uac2.h"
 
+/* UAC2 spec: 4.1 Audio Channel Cluster Descriptor */
+#define UAC2_CHANNEL_MASK 0x07FFFFFF
+
 /*
  * The driver implements a simple UAC_2 topology.
  * USB-OUT -> IT_1 -> OT_3 -> ALSA_Capture
@@ -604,6 +607,37 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 	hs_audio_desc[i] = NULL;
 }
 
+static int afunc_validate_opts(struct g_audio *agdev)
+{
+	struct f_uac2_opts *opts = g_audio_to_uac2_opts(agdev);
+	struct device *dev = &agdev->gadget->dev;
+
+	if (!opts->p_chmask && !opts->c_chmask) {
+		dev_err(dev, "Error: no playback and capture channels\n");
+		return -EINVAL;
+	} else if (opts->p_chmask & ~UAC2_CHANNEL_MASK) {
+		dev_err(dev, "Error: unsupported playback channels mask\n");
+		return -EINVAL;
+	} else if (opts->c_chmask & ~UAC2_CHANNEL_MASK) {
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
 static int
 afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 {
@@ -612,11 +646,13 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 	struct usb_composite_dev *cdev = cfg->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct device *dev = &gadget->dev;
-	struct f_uac2_opts *uac2_opts;
+	struct f_uac2_opts *uac2_opts = g_audio_to_uac2_opts(agdev);
 	struct usb_string *us;
 	int ret;
 
-	uac2_opts = container_of(fn->fi, struct f_uac2_opts, func_inst);
+	ret = afunc_validate_opts(agdev);
+	if (ret)
+		return ret;
 
 	us = usb_gstrings_attach(cdev, fn_strings, ARRAY_SIZE(strings_fn));
 	if (IS_ERR(us))
-- 
1.9.1

