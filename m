Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0DA327DAD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhCALy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhCALvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:51:36 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02CDC061356;
        Mon,  1 Mar 2021 03:50:28 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id v9so7213075lfa.1;
        Mon, 01 Mar 2021 03:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QcE+g+g7mExT314EzRI5jC4aCY5l0a1ys6s5hUq2MwM=;
        b=Yp2JyZjYmI/daDo/mX5UOoQxVnnl2YixWYLv+a8V2Kzk60ROjp0ILUnJkLXbmk+thL
         3fVp6lam5ylo8Xb8ltWl9XAa1okftI2v59fei8b+9ybrS/mrFqzXPFJjhiE0IpCdZTrW
         y+69DnJuCSjvh5MbU70toE01zJCf0fM3mJquPv9Rh8NvhMZ4wDD/yOcZojVXK7zZxvmz
         gSXIGmyy0t7OZgppt4DinuXjUbHvCWJZN4LC59xr+O7zqiONtGkVLgsou6+7o3sL4aQJ
         h6aK8Y6n5mZOefHqt+QUFqlBmVwbIVDFDWhkq3U/nKv4jipK86uw87QNWHfD5okorqW6
         L58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QcE+g+g7mExT314EzRI5jC4aCY5l0a1ys6s5hUq2MwM=;
        b=i1GNuCmAHUmg5lZvYXqILjUtORRuDsAgNU/hV34UOOw9krsPUxog0N2whjfgEfcXMk
         s/uMdoxgRm53YoPWdCJ0JEz0nR7iSu8mkuNqxZHwaDd+6pSlXDInk0x6xPCXNAhO8Qn5
         CWvC84IqAjC9d9iLU2brUUSXOSIizQ9Tsc7nnNZXD8MjmrJPAtmNblBkt7qa5J25KEvE
         kFfpeHUj8FgLs7gxN2Kd49mX+fF8I6uH7LaysS9lgNIoAAlP1J7ZzylRcpn1Y2X4auwx
         46F7821fxTffJZjyMChHqn/KORryqJxDdiCC4FyMvyUHJFjDCyFxI8WFzud+I1ExLc2E
         yC9g==
X-Gm-Message-State: AOAM530j9+lVPYy6mQG5ZalyGGeMm0+QejQqmfmcWSj3gqTMzkVqCxRs
        Pa1GxP5Ko/gcoOJpwkg7Yno=
X-Google-Smtp-Source: ABdhPJw2Mb/eFZcxsY+8huTbGYWv916iF17UqBxLrcZs4cZqi1b0uQLVHgIRFLze956o6Qf94+Sl9g==
X-Received: by 2002:a05:6512:203a:: with SMTP id s26mr9572800lfs.535.1614599427398;
        Mon, 01 Mar 2021 03:50:27 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id m1sm2431356ljg.111.2021.03.01.03.50.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 03:50:26 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH v2 3/5] usb: gadget: f_uac2: validate input parameters
Date:   Mon,  1 Mar 2021 13:49:33 +0200
Message-Id: <1614599375-8803-4-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1614599375-8803-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1614599375-8803-1-git-send-email-ruslan.bilovol@gmail.com>
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
 drivers/usb/gadget/function/f_uac2.c | 39 ++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index c62cccb..f868e38 100644
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
@@ -604,6 +607,36 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 	hs_audio_desc[i] = NULL;
 }
 
+static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
+{
+	struct f_uac2_opts *opts = g_audio_to_uac2_opts(agdev);
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
@@ -612,11 +645,13 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 	struct usb_composite_dev *cdev = cfg->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct device *dev = &gadget->dev;
-	struct f_uac2_opts *uac2_opts;
+	struct f_uac2_opts *uac2_opts = g_audio_to_uac2_opts(agdev);
 	struct usb_string *us;
 	int ret;
 
-	uac2_opts = container_of(fn->fi, struct f_uac2_opts, func_inst);
+	ret = afunc_validate_opts(agdev, dev);
+	if (ret)
+		return ret;
 
 	us = usb_gstrings_attach(cdev, fn_strings, ARRAY_SIZE(strings_fn));
 	if (IS_ERR(us))
-- 
1.9.1

