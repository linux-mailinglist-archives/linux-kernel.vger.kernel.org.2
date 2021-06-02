Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A89B398017
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 06:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhFBERt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 00:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhFBERp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 00:17:45 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B9DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 21:16:02 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id k6-20020a0cd6860000b029021936c6e8ffso865597qvi.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 21:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/z3sAxNyr4/XNOsFRohgOJPV/ZAL16y4mKhabq6Roac=;
        b=bqqkibubUcQfTOm+zRNWEg2yC3SutsWjbXs3cMSJa1NAVTjDGIqebv/pwYt2cN/CEJ
         RO3Bwh1SNpskpQxZ9KqzDSVXhRTOjVy/IT5ZE01NrxVSqhnEBaL5rrP34AOLT1seNC3B
         tZBz4jT8/ULpXWV5lAfk2wzvcbWowpX3/jE+W3Ey6kLhrmxxGTgCF0U4ly9DIDRN8CWE
         +EDRzgu/KgGN/6pBi2RSIdeG2lrxxhzdEvjDd80qe7waAx6bwQ+f0dly+DgKhMH9H32O
         t7rAx1WTZFl7DD7M4KZbUz8Dn/+E6IPgLyPbZbudoQQwgqKCl19FK4E9xrGoRpHZoCGQ
         tGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/z3sAxNyr4/XNOsFRohgOJPV/ZAL16y4mKhabq6Roac=;
        b=aw7TOc+vuyBWydDGZCXK7VWUbBB/kTR1mYl0BOGOD2hgW/CiraO+DPJnRzFUzpBGQy
         ZTlQV9qxHwzE05oiwbRooHFbwzfmg9t/AF1VmDkss3kpPmkek+WU580PE95mFeBXHTd/
         SlbhWEhLdg0sleVyk1XYKq23dY6mPnLjcvhhLUC3WpPYDMBpGDlGA9ww4AsCFINC/S+J
         hDjFfwU6UO8kg8+qoL+q6CyVHITBYXLA56UUclbZbHRyJ8Y269DzTAEJjJgomslDVaUU
         A33YBKCV5d+ryCRUjUErWqrLv3ca+SiFOtV6nayXzcjqOyze/A7q3/nbtLcOJGD9i+Jy
         rDbg==
X-Gm-Message-State: AOAM5338k/qAuXVjxOfbgBhk63QVpH0xgEdeWcMFrtOKEeQ1LdKqy6M5
        hXqT+xnBnRLopl/p88Je11Shy+tFs2s=
X-Google-Smtp-Source: ABdhPJw1whS3sfZfBJvLGe85ZRsMy1o1HJW6TKg0vRD67RWCraVTN++TRNC9zYh3oMg0RKdm0X+os7U3GRs=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:ad4:4e47:: with SMTP id eb7mr3473070qvb.40.1622607361346;
 Tue, 01 Jun 2021 21:16:01 -0700 (PDT)
Date:   Wed,  2 Jun 2021 04:15:39 +0000
In-Reply-To: <20210602041539.123097-1-drosen@google.com>
Message-Id: <20210602041539.123097-3-drosen@google.com>
Mime-Version: 1.0
References: <20210602041539.123097-1-drosen@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH 2/2] f2fs: Advertise encrypted casefolding in sysfs
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older kernels don't support encryption with casefolding. This adds
the sysfs entry encrypted_casefold to show support for those combined
features. Support for this feature was originally added by
commit 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/sysfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 09e3f258eb52..3c1095a76710 100644
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
@@ -704,6 +709,9 @@ F2FS_GENERAL_RO_ATTR(avg_vblocks);
 #ifdef CONFIG_FS_ENCRYPTION
 F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
 F2FS_FEATURE_RO_ATTR(test_dummy_encryption_v2, FEAT_TEST_DUMMY_ENCRYPTION_V2);
+#ifdef CONFIG_UNICODE
+F2FS_FEATURE_RO_ATTR(encrypted_casefold, FEAT_ENCRYPTED_CASEFOLD);
+#endif
 #endif
 #ifdef CONFIG_BLK_DEV_ZONED
 F2FS_FEATURE_RO_ATTR(block_zoned, FEAT_BLKZONED);
@@ -815,6 +823,9 @@ static struct attribute *f2fs_feat_attrs[] = {
 #ifdef CONFIG_FS_ENCRYPTION
 	ATTR_LIST(encryption),
 	ATTR_LIST(test_dummy_encryption_v2),
+#ifdef CONFIG_UNICODE
+	ATTR_LIST(encrypted_casefold),
+#endif
 #endif
 #ifdef CONFIG_BLK_DEV_ZONED
 	ATTR_LIST(block_zoned),
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

