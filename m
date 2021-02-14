Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F8431AEC3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 03:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhBNCc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 21:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhBNCcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 21:32:55 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527F6C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 18:32:15 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b14so3546849qkk.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 18:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5nauxxSDPnHhem4yrY0quLuUuFJ464qNAf4sHAAntik=;
        b=HMoWZ9abbHnuLDOT9j0RNWwTCGEaBBlgemSa3Pa11PU9rHpK9Ai9sXT+9sOQoZ3PDO
         LNLNXENeDRYOks4rd1WHPYxzBjjcaKmcm+pyf4yScoFHlJqe64hRpmEx1Om17XiO84Nu
         D5p/jnHEBgCuMsx6Q0sjwO2fVwtKeFIUH7AiK+SA3B18lB9fiQNPUx0n2oCnzECi6soo
         20sMbAvOyHlvKWZUSVGJG1IYbxqOkVYOyuGPH7zAbA4m+4oyMpvPvIimwtCQj2h/wJFl
         X6Yygl0gHkmfYYgdBEPbPB6wNLdjSz+Xw+0sFWPojjVWbCrGP81ZIZJ4HAkSZB4l+9li
         iGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5nauxxSDPnHhem4yrY0quLuUuFJ464qNAf4sHAAntik=;
        b=jAnLBoCXVVbV4dx5nUaZbRvw/e0PQlZrQJ//6wZvhr2Gpba/BPKC1l8nSnwhFZsIR6
         4JypZ37wXSnUSAIr47vV+c+jeB5bQj7twY2SHC/T6lbSQICdSS2SSmr+3YpyYX629mhD
         aQwte37vrhy1rp/4AlAcgB5nLdDLKsO5mtiJZPOQmGklntu7IlYafYH9ACbp6UsVFvXx
         1cslIeLx02YbtIemDJAXwkxfp+dIXMtT4nu0mDc5gw6Vq4jrJG5bTpgJYPzWDN/wSaWZ
         R55BV/QK8NlGEct6n6xMTkmTGFro3osa/zewov3o7S/srdu1dIw+UZEsoxXI2MpqS+xw
         VUEw==
X-Gm-Message-State: AOAM533F+IZLN0c6xtG7YU7zrPZvn81q8NzLCLFjkVQkDD39YmofxLpN
        DJzN8g/rcRBeCNDkHGjvOdU=
X-Google-Smtp-Source: ABdhPJzNPSa4QgnRqT7WPMFO0sltX5eMmi84ovRgaxh/CjvWR+U8WRqSoZoYmWAzMUU5qtzVsb4fsA==
X-Received: by 2002:a37:e4d:: with SMTP id 74mr9549037qko.109.1613269934578;
        Sat, 13 Feb 2021 18:32:14 -0800 (PST)
Received: from localhost.localdomain ([186.225.140.135])
        by smtp.gmail.com with ESMTPSA id k4sm6371491qth.40.2021.02.13.18.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 18:32:14 -0800 (PST)
From:   Thais Camacho <thaiscamachoo@gmail.com>
Cc:     thaiscamachoo@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: android: ashmem: Declared file operation with const keyword
Date:   Sat, 13 Feb 2021 23:31:36 -0300
Message-Id: <20210214023136.8916-1-thaiscamachoo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script

Signed-off-by: Thais Camacho <thaiscamachoo@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 4789d36ddfd3..2cb665e0228c 100644
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

