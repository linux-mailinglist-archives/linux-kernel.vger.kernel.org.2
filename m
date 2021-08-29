Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0683FAC4B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 16:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhH2On5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 10:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhH2On4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 10:43:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26953C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 07:43:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p38so25767586lfa.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vi12hNY0vhgn8mLCqZgcRjNvZYn/ptAUd78nem7zDq4=;
        b=cTQuN78djINDAQssTLQIH/74drUr9Hb0HB8nJyPEd4+B1hbL8eWMDDQwJ7dMMUyaZj
         U499KSS2J+AR7bQDpgVK3XxR62dw/7gq1apwvIyqLJrMrk4JNeTOjZjLlhKIFN+eaMTv
         7hhuibxe/4Stkmi6UUt47lm5zsiX2TL1EXw8AJIYTCQFUoel32qsTaPeQIAfp8HJ5jtb
         S8ZUT6g4omL96B+lsAMr7zdpPcXxi1F1TR7DiZIQYqCumD+hijjkC63Hs2HhbnCzwrhg
         cjGFuqRt25efc+/lxuJJ0mRNkTBkj7JNRBg7ldt9aoG0UFogbLrR10O/vmvfV8bXHZYh
         OLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vi12hNY0vhgn8mLCqZgcRjNvZYn/ptAUd78nem7zDq4=;
        b=UyI6kTANtB0erGH6uyaBzstg8BMkG7qKnFLr8jDzHpL3S64MiqksDWYpCR3TG9Eu1o
         5KFSVHHiErHPAxP4ysn5nmHpDM7IDy+3PFaySB/Q8BqcExt74S3ltNsHhP+YRxKwI5j8
         WU7JnLZw8/YUB3eq7pZ2xUDaHLGT6P0DyHCjhTkHvGvaRAG1IVGMfdn/S0fqmdGS7Mfv
         BOamIYj4kYOZc0Liv0cCio1r8y10O5086wGlEVdCvDPpOEi7FI4MK2Sh6hibNK0vMzyi
         xlGQD33EKr1YGFLQ0UhYBQ2jPgISZqCb/p2snhdf0i1WxLMb90VFcReJuglKjsVs8H+o
         pRFw==
X-Gm-Message-State: AOAM533Pi0SXOoAnVz6que82qv4H4c077CN63RSoTdXr+Xy9IlPczLnG
        ECbxbp+28JkR3vzVM/kTfR4V8i8mOCDXlg==
X-Google-Smtp-Source: ABdhPJw/4PUswN4lra3ZqGZzoe9lPY2QQLqYXBn22OYOKWmGo4+MWq8Fzrvo9ygtCXLex8We+z/a6A==
X-Received: by 2002:a05:6512:3407:: with SMTP id i7mr2831754lfr.254.1630248182388;
        Sun, 29 Aug 2021 07:43:02 -0700 (PDT)
Received: from localhost.localdomain (37-33-245-172.bb.dnainternet.fi. [37.33.245.172])
        by smtp.gmail.com with ESMTPSA id q9sm1243403lfn.170.2021.08.29.07.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 07:43:01 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ntfs3: Change how module init/info messages are displayed
Date:   Sun, 29 Aug 2021 17:42:39 +0300
Message-Id: <20210829144239.58213-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually in file system init() messages are only displayed in info level.
Change level from notice to info, but keep CONFIG_NTFS3_64BIT_CLUSTER in
notice level. Also this need even more attention so let's put big
warning here so that nobody will not try accidentally use it.

There is also no good reason to display internal stuff like binary tree
search. This is always on option which can only disabled for debugging
purposes by developer. Also this message does not even check if
developer has disabled it or not so it is useless info.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 17ee715ab539..7895039cf673 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1430,21 +1430,14 @@ static int __init init_ntfs_fs(void)
 {
 	int err;
 
-	pr_notice("ntfs3: Index binary search\n");
-	pr_notice("ntfs3: Hot fix free clusters\n");
-	pr_notice("ntfs3: Max link count %u\n", NTFS_LINK_MAX);
+	pr_info("ntfs3: Max link count %u\n", NTFS_LINK_MAX);
 
-#ifdef CONFIG_NTFS3_FS_POSIX_ACL
-	pr_notice("ntfs3: Enabled Linux POSIX ACLs support\n");
-#endif
-#ifdef CONFIG_NTFS3_64BIT_CLUSTER
-	pr_notice("ntfs3: Activated 64 bits per cluster\n");
-#else
-	pr_notice("ntfs3: Activated 32 bits per cluster\n");
-#endif
-#ifdef CONFIG_NTFS3_LZX_XPRESS
-	pr_notice("ntfs3: Read-only lzx/xpress compression included\n");
-#endif
+	if (IS_ENABLED(CONFIG_NTFS3_FS_POSIX_ACL))
+		pr_info("ntfs3: Enabled Linux POSIX ACLs support\n");
+	if (IS_ENABLED(CONFIG_NTFS3_64BIT_CLUSTER))
+		pr_notice("ntfs3: Warning: Activated 64 bits per cluster. Windows does not support this\n");
+	if (IS_ENABLED(CONFIG_NTFS3_LZX_XPRESS))
+		pr_info("ntfs3: Read-only LZX/Xpress compression included\n");
 
 	err = ntfs3_init_bitmap();
 	if (err)
@@ -1484,15 +1477,11 @@ static void __exit exit_ntfs_fs(void)
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ntfs3 read/write filesystem");
-MODULE_INFO(behaviour, "Index binary search");
-MODULE_INFO(behaviour, "Hot fix free clusters");
 #ifdef CONFIG_NTFS3_FS_POSIX_ACL
 MODULE_INFO(behaviour, "Enabled Linux POSIX ACLs support");
 #endif
 #ifdef CONFIG_NTFS3_64BIT_CLUSTER
-MODULE_INFO(cluster, "Activated 64 bits per cluster");
-#else
-MODULE_INFO(cluster, "Activated 32 bits per cluster");
+MODULE_INFO(cluster, "Warning: Activated 64 bits per cluster. Windows does not support this");
 #endif
 #ifdef CONFIG_NTFS3_LZX_XPRESS
 MODULE_INFO(compression, "Read-only lzx/xpress compression included");
-- 
2.30.2

