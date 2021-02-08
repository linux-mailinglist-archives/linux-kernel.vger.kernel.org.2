Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669F431318D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhBHL4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhBHLfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:35:48 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A266C06174A;
        Mon,  8 Feb 2021 03:35:06 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t11so6339292pgu.8;
        Mon, 08 Feb 2021 03:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3Ph8qsKmXSqFKVv7QVwyNev8raeZwIr8Rm9tqiLL8AY=;
        b=TG/s4IiQ6uTzTy6DW5yj2V2Pesqv+sw6iXbp4YQ8u8xFKYjsyjz2HG5KdO5Sn5+Omi
         BMRSf6BaaJ93P706w/iDvr1RZd7WtcadR49k+ST7NgNQxiu0DHvZi0ATO6YzztkkV3T2
         JPn0Dyaqp5w2UlutPpp59wI+9WZpcw2uhuJSXsmzucQyO1StFZbQs6vCBjevyePMOpID
         zfwzwcJ6RAVBZTNa4tCZ74b+Dg7w3z/t4t77DtgQmY8QQNwkdfRdU8RBhg0UbXbXgJ4r
         TEZEgOi0tOQjZBMqMkzvo6ywJ4xVrqvaINd8KsaITNa5+hUxIh6Qpn1RdVMNrhfe70LE
         Bxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Ph8qsKmXSqFKVv7QVwyNev8raeZwIr8Rm9tqiLL8AY=;
        b=EewGZytW3o/HU/v/oLuAOY5dbllorXe33KHDdKwHcfAWnMzO+1GqPZDBqqXAe+Mg79
         UDzm3Po3q+AlaWn6RG+xLQL1bUj5JPBui5LQlePLPpIb03Ak70Sg3VC3RwIYRFvGjk/o
         HvKwkShepnP/88j4qKICx0Vas1TwPvz6cficJp3J3DqEtfSGnaPMYmqdQeW0sGfHwMYg
         /TKZUQ0mWk2GoR5YTLtiOoHagC+I80At5IRIJ/MLTOvzZAGoUAdFaK9ZZ8KtG/mPhp0F
         WjlMDGuuTFRENUb9QEc66FELKpgsEHIsGr1LnbHiY1pmimZ83gQJbpR+PpN9iwtIT5o8
         BNbw==
X-Gm-Message-State: AOAM531drN9wHZpJcM/gtWg3dX9kCem4QdhQ2qmjefdgyQFn7Beb+1pn
        hKc6MWSsOj3CcBSl4aLPRo/35bwRgqlHBQ==
X-Google-Smtp-Source: ABdhPJwW15qeHMwaldoFUpXF83MdyNgUfwsQWFGcDf6X/Kxe/hYqH6lLSOuSghbl9OMh0Y9SKO2ZJw==
X-Received: by 2002:a63:e10b:: with SMTP id z11mr16504368pgh.40.1612784105660;
        Mon, 08 Feb 2021 03:35:05 -0800 (PST)
Received: from carrot.localdomain (i121-118-80-41.s42.a014.ap.plala.or.jp. [121.118.80.41])
        by smtp.gmail.com with ESMTPSA id c77sm4816103pfb.138.2021.02.08.03.35.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 03:35:04 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: make splice write available again
Date:   Mon,  8 Feb 2021 20:35:01 +0900
Message-Id: <1612784101-14353-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joachim Henke <joachim.henke@t-systems.com>

Since 5.10, splice() or sendfile() to NILFS2 return EINVAL. This was
caused by commit 36e2c7421f02 ("fs: don't allow splice read/write
without explicit ops").

This patch initializes the splice_write field in file_operations, like
most file systems do, to restore the functionality.

Signed-off-by: Joachim Henke <joachim.henke@t-systems.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org # 5.10+
---
 fs/nilfs2/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index 64bc81363c6c..e1bd592ce700 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -141,6 +141,7 @@ static int nilfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	/* .release	= nilfs_release_file, */
 	.fsync		= nilfs_sync_file,
 	.splice_read	= generic_file_splice_read,
+	.splice_write   = iter_file_splice_write,
 };
 
 const struct inode_operations nilfs_file_inode_operations = {
-- 
1.8.3.1

