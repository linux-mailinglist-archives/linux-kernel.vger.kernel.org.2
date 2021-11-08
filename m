Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8BA449C13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhKHTBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 14:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbhKHTBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 14:01:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D64C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 10:58:21 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b13so16486970plg.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 10:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=PNOIYs6KgLMM0EEMx1Z2xzj1ItxB04IJBuYUpminw00=;
        b=cj5TurBU7tOrHqEkgpjynEEHqQ/SQljvgWhHrmHEEWUzZ1kAPv63h5y9Iv05Pl8Gjv
         hLZSQjPngB4jMSO1Xq3kwfPuvbi+uxGn2c/7sZSMPWuhtIrKI5UbJA2D56cSwDjPmI0P
         uZ4z8ZnIH/JY1KxJsNW4fpgUSInbPQSUR26lml9DcHe5ZBF4+um5lUa+wK6zBZf5l52B
         7Vh3pUkb0FI6EN5lYzj6qJpgukcZO4+CJ4SY0E1+MW8F3N80dXalZ683XNIYIcwIBdkb
         bXnValvq/v/nPuxCVQhs99aGzFBnHb66Z+XbkkUqQ05FcKjG0AtHggj4xCr9mag+vcW2
         YvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PNOIYs6KgLMM0EEMx1Z2xzj1ItxB04IJBuYUpminw00=;
        b=BJ7eSnBzOXlETPh/wc4QGibVrBhy16E5xt3HhxG2E/iInJZVU1MADsyp91mv6qfExY
         k1PhRGLwftlSY0k0Kdag3gfXs9hROv+nR/+xzmvnQkJGKW+PDjkRIcdchKvnh3c0jtEu
         vjTQ9OuA8K5AOJ7RYEHmCw6jlP9mUqe6kLyXR+01ZoQUptQcBqGb3fmXrJjJP9GAa1NQ
         g7ksUFFC3VTrrKwXsm7cpL+ieL+8iKWeCmWR2PlGuJU96uR3c/eDY/zgYJeY7dde2Ikt
         qVohjASCuamJMRQ4kcikKDZVZJTJxPMxaQTCyKHMCfWDqPrZguiJhyb0UQ8Cq4xo0vMO
         H09A==
X-Gm-Message-State: AOAM533oF4wuqHDLN0UVccOHg5DJA72ZC9KpyinBH9eL+HuuEoK5hvNW
        WC1I2BT8w8F+WQMjsAfQaadpMaTNI7OiE77c
X-Google-Smtp-Source: ABdhPJzfN8+64w0dkPwU+mwlfLv3lOzWCGiX4gRjOdB+8Ui6Jn9IstClnxCh4ILAJfmzuI+3HMh4RA==
X-Received: by 2002:a17:902:cec4:b0:141:cfa1:f7e with SMTP id d4-20020a170902cec400b00141cfa10f7emr1183625plg.13.1636397901313;
        Mon, 08 Nov 2021 10:58:21 -0800 (PST)
Received: from makvihas ([150.129.206.103])
        by smtp.gmail.com with ESMTPSA id s21sm1622942pfk.3.2021.11.08.10.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:58:20 -0800 (PST)
Date:   Tue, 9 Nov 2021 00:28:18 +0530
From:   Vihas Mak <makvihas@gmail.com>
To:     sudipm.mukherjee@gmail.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] char: ppdev: fixed a validation issue
Message-ID: <20211108185818.GA73382@makvihas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the mode is a valid IEEE1284 mode.

Signed-off-by: Vihas Mak <makvihas@gmail.com>
---
 drivers/char/ppdev.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 38b46c7d1737..3b290cbf6c66 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -333,6 +333,28 @@ static enum ieee1284_phase init_phase(int mode)
 	return IEEE1284_PH_FWD_IDLE;
 }
 
+/*
+ * Validate the mode and make sure the mode is power of two.
+ *
+ * IEEE1284_MODE_ECPRLE and IEEE1284_MODE_NIBBLE are exception
+ * to this so handle them accordingly.
+ */
+
+static int pp_validate_mode(int mode)
+{
+	if (mode == IEEE1284_MODE_ECPRLE || mode == IEEE1284_MODE_NIBBLE) {
+		return 1;
+	} else if (!(mode & (mode - 1)) &&
+		   (mode & (IEEE1284_MODE_BYTE | IEEE1284_MODE_COMPAT |
+			    IEEE1284_MODE_BECP | IEEE1284_MODE_ECP |
+			    IEEE1284_MODE_ECPSWE | IEEE1284_MODE_EPP |
+			    IEEE1284_MODE_EPPSL | IEEE1284_MODE_COMPAT |
+			    IEEE1284_MODE_EPPSWE))) {
+		return 1;
+	}
+	return 0;
+}
+
 static int pp_set_timeout(struct pardevice *pdev, long tv_sec, int tv_usec)
 {
 	long to_jiffies;
@@ -423,7 +445,11 @@ static int pp_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 		if (copy_from_user(&mode, argp, sizeof(mode)))
 			return -EFAULT;
-		/* FIXME: validate mode */
+
+		/* Validate mode */
+		if (!pp_validate_mode(mode))
+			return -EINVAL;
+
 		pp->state.mode = mode;
 		pp->state.phase = init_phase(mode);
 
-- 
2.25.1

