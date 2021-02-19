Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEC431F8BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhBSL67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBSL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:58:56 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19225C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 03:58:16 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id z68so3978095pgz.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 03:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HM61s4xJEITX1260Yi2S3Cw2Oex7u+VUt8mimJABho8=;
        b=pnRaU3E2PHxoiMxlyffsa+ZxUXZtUX8m/QNpQTkkPLvgFy7mQvF9b5zAbCDm+gMSwb
         s0UB4+g+qSWmYOwQ3PJ4R+Tt/LM3k1SYqOdkvGWNF0YUfIlhBX7ovhxzttA6AFzC1suY
         dv7FLPesy3DRq0u2XE+Ah7tdKyx6R0FmBIQettaEPUh52bb0VCho5F68qmnQ/bZTqCJM
         pZg4K6o1H3e3hWbjU9j9QEK0RgTnRMFBNlt6OOoZQkN4R43TvlE804vyNLpma5rBWC75
         qTM222c0KENjjpNxS6+ySaNM006tCtQr80pJqCnMudkfp3DJpAy/FY2fHv3xGmbjXhfi
         PC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HM61s4xJEITX1260Yi2S3Cw2Oex7u+VUt8mimJABho8=;
        b=Pn1NL7B/w+vV6y05Nz+sjjidHEIswXBDleYNQc/WKTjd07v9peHPMOzhrx+Lqw2T3d
         uymVCoZFOjeZqbLP6Nd0F3onjziktzRYeSF4p2k17m/S9P+ApKR3g/3NGn8CmrzW55Q0
         yKM+jTOgTWXYSUSn5wTsrJ7AVM/teqQV+HqGLvFP9/gUPxw7WmTn8j8KvpbD6mqH/lZB
         B/pi8QPHQubpqX24rLH3BczS5DmOt95g5Uj4ymaEntMKEO7vf6QfG+0R2p81vXOFBHsw
         r9q0VR8VV/R5t8lfxhVaBS00h+JyUFO5/Fwy8tPafsHZzjz13dmVRggPpRft9IUItfeL
         eEwg==
X-Gm-Message-State: AOAM531Rp5TToO4jtuYGks/0OsreJyVJPRE8BqnQL8DdbKhOJRn7XKbI
        TlbdTkBSUSjVzKkxU2KqEUo=
X-Google-Smtp-Source: ABdhPJxDLwDvdQaxXrrR3rxOQ+oLiF9QVUwHtlkTAYZENKwKwpkTbYB4E0R7wDFhC5o3p8jakeBHVg==
X-Received: by 2002:a62:5344:0:b029:1df:c7d:3c3e with SMTP id h65-20020a6253440000b02901df0c7d3c3emr9056482pfb.11.1613735895529;
        Fri, 19 Feb 2021 03:58:15 -0800 (PST)
Received: from amrit.domain.name ([122.181.96.92])
        by smtp.gmail.com with ESMTPSA id 14sm9652648pfo.141.2021.02.19.03.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 03:58:15 -0800 (PST)
From:   Amrit Khera <amritkhera98@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Amrit Khera <amritkhera98@gmail.com>
Subject: [PATCH v2] staging: android: Fix const keyword style issue in ashmem.c
Date:   Fri, 19 Feb 2021 17:12:38 +0530
Message-Id: <20210219114237.5720-1-amritkhera98@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a checkpatch warning for "struct file_operations
should normally be const".

Signed-off-by: Amrit Khera <amritkhera98@gmail.com>
---
Changes in v2:
 - Wrapped the commit description
 - Build tested
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index d66a64e42273..7854fd410efa 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -376,7 +376,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static const struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
-- 
2.20.1

