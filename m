Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C414327DB4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhCALzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbhCALvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:51:36 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA3DC06121D;
        Mon,  1 Mar 2021 03:50:31 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id f1so25026036lfu.3;
        Mon, 01 Mar 2021 03:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FU3j+Yt9GOZUp/owCA8DjVj1xEHIaeTECTvQ0R9OrLU=;
        b=VALCemYR51ioQCbxWYoXkchKSMfpJwzMDT1RN7uSrtE7wPvD1D1lIM/1rvS75D+Uo1
         +e13w7+Pq0lB5CLuM4G28FFu2JtJre9i4T2z+Bjhk5eyDewZq+bJS9UH6FMO5pcFTZYT
         wO5eSTAjtZfbSigRwfkGBA8pDvCrPJctPoF6d8vpsO0kXpTB4GEToPrZYrI49X7tMBqP
         p/XvkVQCbsmvmISw5hbC+8jlWC/vHcYK+35OP5MKj/+8oLue8t2a4xqAjOOCbbG7oE43
         xORK5+izY+V5byp1BuuCs/Ws42dWOdG4xVu1lgANdnPajt+RSJagLFsPCaqxBe9HhoO9
         zbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FU3j+Yt9GOZUp/owCA8DjVj1xEHIaeTECTvQ0R9OrLU=;
        b=Y7mLVmz9zXr6odY9cNEonST+jyw+nOiaJYFelBVes7tbg+3CUgYqQ/P1iXkPG0Spqu
         yhPIurL5PIZgKVjYQIgpbQ8Ne0QqyCEBQ2hEokYBxVtqpe3Kg98eSPo/LsJUVzKHKP1W
         ZG2wXoTjYaDFp/Pxii1qKLf5kxa/7w0Cq7DxQbhwd66T59wTUTxbjRbDaJOFFicbn1qy
         QoDwZpxy6zCsUiBvL2GMy0CL4/KMtFRR6GHa3+qqByynp3/4VsfgylRsZ3aaZoc0rJ0M
         LsbarAjXWb/v3rOcSiMjGwz0jnVz3IPX4jqoc/uQGWBhOM1VUmc0n4kYNenBe/wjc3Qo
         QxVQ==
X-Gm-Message-State: AOAM530Gw+NwwGssO9M7S8/3zORrX4nP9wxRObR3F0mls3mpwtLTugHw
        WHW04iAdhSJSk75+/e+m8Xs=
X-Google-Smtp-Source: ABdhPJwosJC9Ij9odXOpLDCtX35Hr86P3DVu4j0ngN7hxJ61oc7BJm7CvH+xkLtRAnf8FqWUYOPhGg==
X-Received: by 2002:ac2:5617:: with SMTP id v23mr6071463lfd.123.1614599430449;
        Mon, 01 Mar 2021 03:50:30 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id x74sm2134485lff.137.2021.03.01.03.50.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 03:50:29 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH v2 4/5] usb: gadget: f_uac1: validate input parameters
Date:   Mon,  1 Mar 2021 13:49:34 +0200
Message-Id: <1614599375-8803-5-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1614599375-8803-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1614599375-8803-1-git-send-email-ruslan.bilovol@gmail.com>
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
index 560382e..e65f474 100644
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
@@ -505,11 +513,42 @@ static void f_audio_disable(struct usb_function *f)
 
 /*-------------------------------------------------------------------------*/
 
+static int f_audio_validate_opts(struct g_audio *audio, struct device *dev)
+{
+	struct f_uac1_opts *opts = g_audio_to_uac1_opts(audio);
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
 	struct usb_composite_dev	*cdev = c->cdev;
 	struct usb_gadget		*gadget = cdev->gadget;
+	struct device			*dev = &gadget->dev;
 	struct f_uac1			*uac1 = func_to_uac1(f);
 	struct g_audio			*audio = func_to_g_audio(f);
 	struct f_uac1_opts		*audio_opts;
@@ -519,6 +558,10 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	int				rate;
 	int				status;
 
+	status = f_audio_validate_opts(audio, dev);
+	if (status)
+		return status;
+
 	audio_opts = container_of(f->fi, struct f_uac1_opts, func_inst);
 
 	us = usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings_uac1));
-- 
1.9.1

