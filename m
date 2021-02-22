Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3DB321B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhBVPXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhBVPPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:15:23 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A47CC061A31;
        Mon, 22 Feb 2021 07:13:06 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b3so19449630wrj.5;
        Mon, 22 Feb 2021 07:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsehZqvcvtb4tCCQoqeDviKqU/Y1YzBUUFjUVz3pAZk=;
        b=rncFZJGMNdZtNXBSacAVdgQBb0oGFNyf4Hdrl4WXvGfYPpXc/Yp5sNVXRPxebcNuHS
         7IwEN7oQqyGVvRqs7xITRH9BrQFVeMl9spTlXJbuc9zRHDrvQyCLU3I7tFJ1PyS/4HNJ
         fzRC7nyB+goax8BUDRiSpHvvPl5rliAh3rGz2sJefngJxqQ91KSDr12SCvrRitANW/hI
         0ZEPXb2d75NN21G4Mk1zMcEiEFxGfPE1x4YqmFFkLRQzfM4WHTL3WWIWjUQbfKTCBMaK
         sivFSnlzPOUjk7O8xk+5jDWF/7ksajmmcO15qtMvYQi3A8BDvi2F/SkrsWH3iGHIEm/5
         DhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsehZqvcvtb4tCCQoqeDviKqU/Y1YzBUUFjUVz3pAZk=;
        b=IH6RySdRHvgOxuNtgtYPGTaJNrSBByIg+uwQNjs/TI51syOaXzvhOS+2H3k3I/6jaa
         DOvdY1XkxlO3lMSQIB7sugWTf5YD7h3Rxi+IMCpRLN7c+peZs104KMr4uT0vlNlDYsqv
         VDeHPj8DNCT9kMA021f4SSzTtXnutorxGzXETaSFN/b2b9+uz2/NIt6KeuQXoWinaPyP
         bShDUMRHgWi0/NvPQ0ol6wnYoHTN0OOcIu2xyqo74AMShZuNmKwS5KdUib/CXAHR9luk
         FL4xXW78JesCqbkaWb3PpSqDI1zVb4kQyPqCnmf/q3yxxolwHGWSuPJlIQ9QV6ihI2RS
         hVmQ==
X-Gm-Message-State: AOAM532HoYEiFyFAGLYgG+UHONFZnAAiuwOJ39Y5Xd4fb0oS/TSPHxEh
        bjoG7EL0x4yE0nOCJByQH2VbbH6A2cpUdqe0pfE=
X-Google-Smtp-Source: ABdhPJxRYTjEd7nsbxeIKUmEpWw/94Nm1leoqbaxX1B5ddNqok4WzlYQVzm9GVfAfVRtD+2oslhAOw==
X-Received: by 2002:a5d:55d2:: with SMTP id i18mr5005134wrw.221.1614006784971;
        Mon, 22 Feb 2021 07:13:04 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id h13sm29117488wrv.20.2021.02.22.07.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:13:04 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Romain Perier <romain.perier@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/20] usbip: usbip_host: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:30 +0100
Message-Id: <20210222151231.22572-20-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/usb/usbip/stub_main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index 77a5b3f8736a..5bc2c09c0d10 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -167,15 +167,15 @@ static ssize_t match_busid_show(struct device_driver *drv, char *buf)
 static ssize_t match_busid_store(struct device_driver *dev, const char *buf,
 				 size_t count)
 {
-	int len;
+	ssize_t len;
 	char busid[BUSID_SIZE];
 
 	if (count < 5)
 		return -EINVAL;
 
 	/* busid needs to include \0 termination */
-	len = strlcpy(busid, buf + 4, BUSID_SIZE);
-	if (sizeof(busid) <= len)
+	len = strscpy(busid, buf + 4, BUSID_SIZE);
+	if (len == -E2BIG)
 		return -EINVAL;
 
 	if (!strncmp(buf, "add ", 4)) {

