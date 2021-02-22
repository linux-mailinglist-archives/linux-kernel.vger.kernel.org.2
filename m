Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DC9322053
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhBVTmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhBVTmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:42:53 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8BCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 11:42:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z7so8374221plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 11:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vq/LjtkFh9pERziNSLl6ylHhs+PEljKyW7ISagnaboE=;
        b=XnlFPzGDm2iVBbnCctLYiQ0ZZVvR0bP9dNZwKJQG5BBdmWwo1WppTcH4qDHyV6SIlu
         vZbUPQkyhNZLNJee5cvHVsD6fAzt6mQFMW0RxPkDctKiWe9bxZTncWKlKbRNQBf6bTvS
         g2f6GWr6CU5cd5jM84+s7kWAcyZvDTznUyW6GGI/z51iiVutA3gI/Sn5p6TgmqBSgfIn
         NIh4mjgOxc9jQ/RbsFk+9tnMe8KATAaoDDJ2bve/k7/4+henrRIymoe6D20iu2unXXsx
         +E8DQbc/aysGY8o2nm2rhHFPw2OkmYlHC35xBa9VzYAgEhju5SIR4q1+cjiHK4aJ7zJc
         nfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vq/LjtkFh9pERziNSLl6ylHhs+PEljKyW7ISagnaboE=;
        b=gx7RXvYf9DgH0pSKpRRs5ijPHiCYkZuEf/m7aaJBvKowq7eHU7KO4gxo4eThr2+1ZU
         /0Gsq0lQ3EclcYSkTeKVmCBse8BmjYzmLmilXnhvttsWytfK4Kl0DcePbEQJHuwx5ccg
         tFIyFh3wK+IOouz7WDN76gjRyK3toClLkaWjle0AyXyeOi3rIeqpBrCVvpUqpifswaxI
         2H3tVhr8bxTKmkMTBV4eGZXgQptcoeZJSozSryyk24sMRGO+xjdqh1anxXZnPRBfrMlL
         77xfnvLfEfBdmHnQwsOCE2kAMrP9usbd0tlDYi0tvpn+Xl4v7NXvANFeZxX1g8y+z5Az
         4RVQ==
X-Gm-Message-State: AOAM531uvptyG/WIMK3g+p9OhNLlIY2jDiQwCWlPQ3TwBFkX1n+c2aQl
        Md1H5QGZ7eOIEHE63/+pnKo50vb6lMEvJQ==
X-Google-Smtp-Source: ABdhPJwYItbZQJc4+/MmJCXyy1YmB7Y8ohzyJLyZa08XcyTi4YjVuF8Iz8/umZ7XfJPtXaj4u/NhQg==
X-Received: by 2002:a17:90a:ad4a:: with SMTP id w10mr16495041pjv.112.1614022932721;
        Mon, 22 Feb 2021 11:42:12 -0800 (PST)
Received: from localhost ([103.106.200.56])
        by smtp.gmail.com with ESMTPSA id c23sm19578464pfi.47.2021.02.22.11.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 11:42:11 -0800 (PST)
From:   Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, sfr@canb.auug.org.au
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
Subject: [PATCH] sound: core: fixed coding style errors
Date:   Mon, 22 Feb 2021 11:41:56 -0800
Message-Id: <20210222194156.26758-1-sssraj.sssraj@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixing ERROR: "foo * bar" should be "foo *bar"
fixing WARNING: Missing a blank line after declarations

Signed-off-by: Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
---
 sound/core/hwdep_compat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/hwdep_compat.c b/sound/core/hwdep_compat.c
index a0b76706c..d8624a14a 100644
--- a/sound/core/hwdep_compat.c
+++ b/sound/core/hwdep_compat.c
@@ -36,11 +36,13 @@ enum {
 	SNDRV_HWDEP_IOCTL_DSP_LOAD32   = _IOW('H', 0x03, struct snd_hwdep_dsp_image32)
 };
 
-static long snd_hwdep_ioctl_compat(struct file * file, unsigned int cmd,
+static long snd_hwdep_ioctl_compat(struct file *file, unsigned int cmd,
 				   unsigned long arg)
 {
 	struct snd_hwdep *hw = file->private_data;
+
 	void __user *argp = compat_ptr(arg);
+
 	switch (cmd) {
 	case SNDRV_HWDEP_IOCTL_PVERSION:
 	case SNDRV_HWDEP_IOCTL_INFO:
-- 
2.25.1

