Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140F7339F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 18:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhCMR1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 12:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhCMR1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 12:27:05 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBFCC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 09:27:04 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id r16so2656884pfh.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 09:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2UjTidDibtpUmAW25zxdO42ZDabIYODzi8saO4ttS0=;
        b=RlPvNo/raOQbOCrqW+Yu4ng2lYPp1/uBixEtqmwzER+pOM0zDhOgiCwyGemwn4lD7q
         d0Odbi8V7a+/RZ+YaNqzn22fA2evzx2udn8CQ5+dn+i/0JX5SPbEvqJilfqGbwaqHX9a
         qrNb29Yem0JkI7Jxhb7tOVCeBEsgxlljxqTa5aONCTuoawo2xkd1nOYBLz5Jah8fHCZX
         XQVxJqwt7XM7mtx2EOc9AF7hS3PWpbtWlY7L/9qiqGwXoXDgyfKGiCQRLK5AWOvahvqI
         6a7mFib8Pfgrzf8L//qMJ3LPLI/NeDyNxP0kOMMA1hcJBBSvoVEq+zOqV49yc7rTRcj7
         vxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2UjTidDibtpUmAW25zxdO42ZDabIYODzi8saO4ttS0=;
        b=rfJTyX9i5YObaxqDXmvRNbNfJZGSlitXuMCDf4vJr8LR9403ITUD6fosVfxzyitjPD
         I2SCZi0RjVZntChu1/FT7PQ2wUwD27slmtDSbapOK2mOKx3Ich+04BgCFJKkrAiAJmRs
         hx3EPJL7aa7N1RGCKbpC0+X0SZWC1L2zxn9Ul7YZflIke84tHDbhp8cjC01dXBdlFt50
         AYgrghcAFPdhVMZ+dELFJylFn4vBNSUftRHsedpoD5kJ63HTZ735D9Iz5/ElmFy62I2X
         41bQJa0ix11gOlkwFjLAihBayonxjEj0+30d1Uou9546yHMOfGcA1FYqfiQrRgI7p2rg
         uXzQ==
X-Gm-Message-State: AOAM530wQDiFMDQwJP8jLL+C8kdtavMqnYu+677M7H71hEICdd+IT5Hq
        +8dTgMNLZOefX3LyjxdQRpA=
X-Google-Smtp-Source: ABdhPJzuU24ZELmQPlrzPCNwzwWywJM2eygZK18L7DwIP1N5/p0kh48oUqKVPRuaF00VZ0NshNflMA==
X-Received: by 2002:a65:47cc:: with SMTP id f12mr16434317pgs.305.1615656424276;
        Sat, 13 Mar 2021 09:27:04 -0800 (PST)
Received: from ubuntu.localdomain ([182.156.244.6])
        by smtp.gmail.com with ESMTPSA id r1sm5560450pjo.26.2021.03.13.09.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 09:27:03 -0800 (PST)
From:   namratajanawade <namrata.janawade@gmail.com>
Cc:     namrata.janawade@gmail.com, anupamakpatil123@gmail.com,
        bkkarthik@pesu.pes.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: andriod: ashmem: Declared file operation with const keyword
Date:   Sat, 13 Mar 2021 09:26:35 -0800
Message-Id: <20210313172636.18234-1-namrata.janawade@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script.

Signed-off-by: namratajanawade <namrata.janawade@gmail.com>
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
2.25.1

