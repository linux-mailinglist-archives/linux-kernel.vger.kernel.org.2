Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223AC31994C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhBLErO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhBLEqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:46:06 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0459FC061794
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:57 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t2so4681072pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gf/FNE2g9dFP9p3d4PnxWCRqpKSooOmCgY06BBUWQtQ=;
        b=D1dJ9Pxbb6GQULURKHNuG77hzlfdpyFwDfIJR/kdcgaKOm7QeDaVsVh7BxWEKBMFBQ
         TUh8hYE6LSrIJiTUxYE1NFvVpRrVqU65AVZVLxKlVm/Jyec+M8CIhJ/j354uZZVbTf34
         E4dy5KCHzyiapdvYwXs32ylZGzOeG5skr/tNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gf/FNE2g9dFP9p3d4PnxWCRqpKSooOmCgY06BBUWQtQ=;
        b=Cw592wsI+mwC2/diEcax+XaceN26KBPmvSoFDe5qRDkg6loaCMSRzyytNm/SUd4vq/
         uZ8EbmUfeOPC+iqPZ55Njr+hJbuQVeOXSTMG8xxIuWvf7OIvTMk97/aciuw8FyOWZfZY
         7mCo3dnzFOE9o+xU8ZQQB7ApjYtrXHTQZirO0NIRbaPpIJB1BTDw2UaZ5H49CS4tidAF
         W604Bim3v5uFNIAnluqqz2GB9nqx5kK06bNhg/A4ksWp5jrWvjoVZcEnZx3L8U3NWjn4
         dKJkkfdfGzFuaV3yu02nvf/T4inEEJFti8JVntJ0ap2MAMmA1un93ZVV7q8QYtqCQf6g
         fa/A==
X-Gm-Message-State: AOAM530UXUSB8QZECfMSWP8F1MDaRrzFQiLcuIwPQOjxuKyZpZ6wPb1l
        NVXdZ6t6cJEYBUCOFgpTJiHXaw==
X-Google-Smtp-Source: ABdhPJytZbcYqZrhtmpGfcJw/baVcFRWjDI0lVpoG2xuV81ph0vrPS4VW5luUG9QLhZoW8KGx2d7Lw==
X-Received: by 2002:a17:90a:9310:: with SMTP id p16mr1102823pjo.211.1613105096610;
        Thu, 11 Feb 2021 20:44:56 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:a453:d6cd:41b9:5925])
        by smtp.gmail.com with ESMTPSA id 25sm7298904pfh.199.2021.02.11.20.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 20:44:56 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] vfs: Disallow copy_file_range on generated file systems
Date:   Fri, 12 Feb 2021 12:44:05 +0800
Message-Id: <20210212124354.6.Idc9c3110d708aa0df9d8fe5a6246524dc8469dae@changeid>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210212044405.4120619-1-drinkcat@chromium.org>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_file_range (which calls generic_copy_file_checks) uses the
inode file size to adjust the copy count parameter. This breaks
with special filesystems like procfs/sysfs/debugfs/tracefs, where
the file size appears to be zero, but content is actually returned
when a read operation is performed. Other issues would also
happen on partial writes, as the function would attempt to seek
in the input file.

Use the newly introduced FS_GENERATED_CONTENT filesystem flag
to return -EOPNOTSUPP: applications can then retry with a more
usual read/write based file copy (the fallback code is usually
already present to handle older kernels).

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

 fs/read_write.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 0029ff2b0ca8..80322e89fb0a 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1485,6 +1485,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (flags != 0)
 		return -EINVAL;
 
+	if (file_inode(file_in)->i_sb->s_type->fs_flags & FS_GENERATED_CONTENT)
+		return -EOPNOTSUPP;
+
 	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
 				       flags);
 	if (unlikely(ret))
-- 
2.30.0.478.g8a0d178c01-goog

