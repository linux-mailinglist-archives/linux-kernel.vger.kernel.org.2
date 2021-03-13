Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64EF339F13
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 17:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhCMQR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 11:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbhCMQRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 11:17:05 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0A1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 08:17:04 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so12589352pjv.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 08:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ULnk6/AujffEHtqaXUB+Sqx1kV7oADwaFIlwS/jfgBE=;
        b=iAtatBJ28o/OGcXOP4uyEaVQuUmWu4Xwnm1x+WCdvf82kU73a73wHIarCVvw256MGR
         puzeNqJv/gUPslInZOCmBemSEyU04eVxJWI8t/BpKkGjNZQ2sf47FdRAehJOIDC2VzOV
         4UlvhIWRF40sIcoJpRUqs5RdFviAU/DLnsMhcCjt70p/RYI+D1QmESnsvpX2K41+ula7
         fSTTd4Lh0RzhV02zb4QzouKLp5wO17vnuDV2AhBCTbVtmTpt+eOYnkPsCQ03YBLVmi36
         Pp21kv+0rDFojUW5T7zPMbmgXpdw7SPyTGXYI3ApvoW6I8RVAC0yLeRd6aZvESrQjvon
         0nLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ULnk6/AujffEHtqaXUB+Sqx1kV7oADwaFIlwS/jfgBE=;
        b=t8kpmmKB2djyewNwME90q1whnHWKGC/jM2VuMcCkH3HRxXR0qVDyoDDnfS6Uh/1quI
         YJEUWLroQtMNFS7FRY4b1maN5sb9eGIrhFq1eacZybHLb25/ApdFY67bPqOM3eDZXW2F
         CtcA8fnLwW58oFZT1kz4z6jNhSyyzlshhV66T2VFbu1G73v7AE2X51IFfR5VGp8P6vJs
         e+7qj2br0v7+yHENa7xAXyFdm4WnDB1gs0gxy8GqkGR2VUhYoUvR4+H5RqAmU2N50C2V
         H5tVgwhs1n1wsWCW9tf/T72L0ornx0TmSqTU2hKf4jEkhMAPwuuT8I8QCfAiAZbIo10D
         mSJg==
X-Gm-Message-State: AOAM530BSQseV97ROWSfuS4NC5Zmg6C+a4NVyLHHA2DtYeq0i82FZ8Fn
        19h0nndlzapQE/ZLs1Qk5yc=
X-Google-Smtp-Source: ABdhPJwKVyYU+jP6gXOXHOeHUG1pzfSGZ4Lqk8xm/nk0yFAyUByJbcHs+PelkKs7IxCjKEfA9bIx7g==
X-Received: by 2002:a17:902:8a91:b029:e6:3e11:b252 with SMTP id p17-20020a1709028a91b02900e63e11b252mr3818216plo.7.1615652224355;
        Sat, 13 Mar 2021 08:17:04 -0800 (PST)
Received: from localhost ([49.206.1.181])
        by smtp.gmail.com with ESMTPSA id l10sm2790396pfc.125.2021.03.13.08.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 08:17:03 -0800 (PST)
Date:   Sat, 13 Mar 2021 21:46:55 +0530
From:   Abhishek C <astro.abhishek02@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, bkkarthik@pesu.pes.edu
Subject: [PATCH] drivers: android: binder.c: Fix indentation of multi-line
 comment
Message-ID: <20210313161655.mu64qezxog4ghibq@astroabhi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed alignment of multi-line comment.
Added a * for each line of the comment.

Signed-off-by: Abhishek C <astro.abhishek02@gmail.com>
---
 drivers/android/binder.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c119736ca56a..700719c58147 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4617,8 +4617,9 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	unsigned int size = _IOC_SIZE(cmd);
 	void __user *ubuf = (void __user *)arg;
 
-	/*pr_info("binder_ioctl: %d:%d %x %lx\n",
-			proc->pid, current->pid, cmd, arg);*/
+	/* pr_info("binder_ioctl: %d:%d %x %lx\n",
+	 * proc->pid, current->pid, cmd, arg);
+	 */
 
 	binder_selftest_alloc(&proc->alloc);
 
@@ -5750,8 +5751,8 @@ static int __init binder_init(void)
 	if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
 	    strcmp(binder_devices_param, "") != 0) {
 		/*
-		* Copy the module_parameter string, because we don't want to
-		* tokenize it in-place.
+		 * Copy the module_parameter string, because we don't want to
+		 * tokenize it in-place.
 		 */
 		device_names = kstrdup(binder_devices_param, GFP_KERNEL);
 		if (!device_names) {
-- 
2.25.1

