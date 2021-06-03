Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DECB399E1E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhFCJwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhFCJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:52:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926E1C061756
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 02:50:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n129-20020a2527870000b02904ed02e1aab5so7006187ybn.21
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 02:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kcHV5gWpfes4THP3FELWNQNHxoWa/shR0B9tGbdkBnA=;
        b=PuudTZ14PqkkF7RO4Rf+mCRnc/o6LmDJEuNGL3MfafamdxhETKEpKnJAFo+MPejrn9
         73YPmOjxQRlZ/K4bVoxTVtCk5ZeCr3wRNMEZBBXrBjS228q5P3pYjyp1ywX0+XrjXR20
         rpjOUP0z24bcUAqTt4lv5vFxXVbBmU7l2cyeE1jxDXUajHV2b7KGg1ajO2rIZs5QfwSj
         +BK9T05nB4G2UUzcO9BZ9CaJvyG909kWWoKLRFHHHPsHZwvjg0Eyl+QkjBUGhKxbdprO
         3QpyCk+hH+Q3tp3Zku8kCucmsS2kgdLf0wXnstnKuvd9MCNZOtl/fkxTm7cNZw5nNy7F
         VX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kcHV5gWpfes4THP3FELWNQNHxoWa/shR0B9tGbdkBnA=;
        b=oRofImUoHYplWHWfrOmCZosArg74Glgsj4aVpwn0VS4v3cSVqkTkOgBfPfab9Lwg1n
         0nGf4ef3gLNqdZE26ORCoMyYAZAnhFbZvLiQR9YygwerLlKeVj+Cy9zxlnmlhtpgbDno
         OXoCQpnz5Niu6+OW+k/CU+9qtl7cn+n8lkoYhAd4QDDB9FsYMDZ6uWkAQ/tUsU59gXa/
         FE8+rcE1l3+NP2Fgo33ZKWDk96cWvs0o9vw6q9SHDv5DTTvDX1PCN44Hu56I8RnRLolG
         j0Ipuo3VaC6f5H5hgwKdo/EKTe7UhQJxQEldYgTzh/hezv0JNOzbrbIFwk5ixSCGxvDz
         ZZ+A==
X-Gm-Message-State: AOAM53229NVPRi3le/feju+vk7nQMnMF5EDcsG9fX1wEEzRe/yG0DjLO
        jmVs2QHszj4EcKfa8Wixr7+2IMIPTj0=
X-Google-Smtp-Source: ABdhPJy8xiO/ttoSoyFhrkeb1Vy0GuuYttk2gPq2x6PFXSdfcbUYCWy3cBM864we5xBQhIGpxomGoEWRTRQ=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a25:a1e2:: with SMTP id a89mr51767520ybi.439.1622713845802;
 Thu, 03 Jun 2021 02:50:45 -0700 (PDT)
Date:   Thu,  3 Jun 2021 09:50:38 +0000
In-Reply-To: <20210603095038.314949-1-drosen@google.com>
Message-Id: <20210603095038.314949-3-drosen@google.com>
Mime-Version: 1.0
References: <20210603095038.314949-1-drosen@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 2/2] f2fs: Advertise encrypted casefolding in sysfs
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older kernels don't support encryption with casefolding. This adds
the sysfs entry encrypted_casefold to show support for those combined
features. Support for this feature was originally added by
commit 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")

Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
Cc: stable@vger.kernel.org # v5.11+
Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/sysfs.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 09e3f258eb52..6604291a3cdf 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -161,6 +161,9 @@ static ssize_t features_show(struct f2fs_attr *a,
 	if (f2fs_sb_has_compression(sbi))
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "compression");
+	if (f2fs_sb_has_casefold(sbi) && f2fs_sb_has_encrypt(sbi))
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+				len ? ", " : "", "encrypted_casefold");
 	len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "pin_file");
 	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
@@ -579,6 +582,7 @@ enum feat_id {
 	FEAT_CASEFOLD,
 	FEAT_COMPRESSION,
 	FEAT_TEST_DUMMY_ENCRYPTION_V2,
+	FEAT_ENCRYPTED_CASEFOLD,
 };
 
 static ssize_t f2fs_feature_show(struct f2fs_attr *a,
@@ -600,6 +604,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	case FEAT_CASEFOLD:
 	case FEAT_COMPRESSION:
 	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
+	case FEAT_ENCRYPTED_CASEFOLD:
 		return sprintf(buf, "supported\n");
 	}
 	return 0;
@@ -704,7 +709,10 @@ F2FS_GENERAL_RO_ATTR(avg_vblocks);
 #ifdef CONFIG_FS_ENCRYPTION
 F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
 F2FS_FEATURE_RO_ATTR(test_dummy_encryption_v2, FEAT_TEST_DUMMY_ENCRYPTION_V2);
-#endif
+#ifdef CONFIG_UNICODE
+F2FS_FEATURE_RO_ATTR(encrypted_casefold, FEAT_ENCRYPTED_CASEFOLD);
+#endif /* CONFIG_UNICODE */
+#endif /* CONFIG_FS_ENCRYPTION */
 #ifdef CONFIG_BLK_DEV_ZONED
 F2FS_FEATURE_RO_ATTR(block_zoned, FEAT_BLKZONED);
 #endif
@@ -815,7 +823,10 @@ static struct attribute *f2fs_feat_attrs[] = {
 #ifdef CONFIG_FS_ENCRYPTION
 	ATTR_LIST(encryption),
 	ATTR_LIST(test_dummy_encryption_v2),
-#endif
+#ifdef CONFIG_UNICODE
+	ATTR_LIST(encrypted_casefold),
+#endif /* CONFIG_UNICODE */
+#endif /* CONFIG_FS_ENCRYPTION */
 #ifdef CONFIG_BLK_DEV_ZONED
 	ATTR_LIST(block_zoned),
 #endif
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

