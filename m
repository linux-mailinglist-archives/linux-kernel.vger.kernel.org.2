Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A512405CA6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbhIISLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbhIISLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:11:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308F8C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:10:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id l11so5420735lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IudACyYdUqJ7gnt0VBJlepLQi1HYDs/W9JfdNcI6Qbw=;
        b=NEGi3nHWsfQg+1RLKfc0kywSDw4++RzTTs2UlUBBrdQ3VPzSjxiKHQ0j8p9JIjAydy
         iqFUV7kdLN7h2dYd+DI5Pv/uprCzhNmTayfGGNs8RXuCw8sN0uh2KYyqkjSnibLmCr09
         RgeWYLzfh3O+DB63OcsQ2ZTUQNiBXZiYx5T6sq7FlCpRjM4o6pYztOkFYGqru1EdDlvY
         76yafJ7u/yTPdNVc9g7RkBRbzAU+UAKbgpyfEwZjoC4K73YFExpxQrL0ZajdZaRiQ+xu
         dVhpXshnSR9xOg3gBQhvDTHFvic/5mIeN9GrPtUHL5KR9oquTNlAUILp2QB/LsXfPBYi
         odIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IudACyYdUqJ7gnt0VBJlepLQi1HYDs/W9JfdNcI6Qbw=;
        b=mWDpMo7C0Qk/8cjbDFGPly23dp7R/JeNC8jWi/Uo+KTmrt564l6hNGtSYCn3HZ92e9
         FhiVURIgu3XxxGhfmwy82XzBw38bobOyhrTJ7CslFMSmaHfo/PhZEkz2CKrQV2MmTzhO
         00pX6iFHowWtUVLvL01v/AkGAhRd1PvOQhoh911MIEjgIxrul2ykCLmuCwudXMnZiwpZ
         5OUS0Oq8ncI0RuLYcLOxfxW+gaLBAvFZVQPZSzZFn496d9FsFbm3hwvN87QHkw4fz+jm
         zxyaF/yh5D22Xb2LgLbScKHpuXnLvgxxrdd+5J3U6ZNO8zggFjOVf8bPJ+xQvCRb66Cx
         aVzw==
X-Gm-Message-State: AOAM5337YIUMCu8ZEuW+Bhi8YsAfLzEXQM9SOhunDAPcx9NqwabWhJGr
        vhHMwqCxU8K/VnHBwlQkzVU=
X-Google-Smtp-Source: ABdhPJx8eDqX1tvtW/eN6WUxAqVJouZ5RSQZPsB2dAsBOIfznfCiN8DNeyZyOZL+ubLnLajOgtZrAw==
X-Received: by 2002:a05:6512:39c9:: with SMTP id k9mr819851lfu.351.1631211000536;
        Thu, 09 Sep 2021 11:10:00 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id u2sm270276lff.238.2021.09.09.11.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:10:00 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 06/11] fs/ntfs3: Use sb instead of sbi->sb in fill_super
Date:   Thu,  9 Sep 2021 21:09:37 +0300
Message-Id: <20210909180942.8634-7-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210909180942.8634-1-kari.argillander@gmail.com>
References: <20210909180942.8634-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sb instead of sbi->sb in fill_super. We have sb so why not use
it. Also makes code more readable.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 2eb1227bbf5a..efe12c45e421 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1012,7 +1012,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	iput(inode);
 
-	is_ro = sb_rdonly(sbi->sb);
+	is_ro = sb_rdonly(sb);
 
 	if (sbi->flags & NTFS_FLAGS_NEED_REPLAY) {
 		if (!is_ro) {
@@ -1103,7 +1103,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Not necessary. */
 	sbi->used.bitmap.set_tail = true;
-	err = wnd_init(&sbi->used.bitmap, sbi->sb, tt);
+	err = wnd_init(&sbi->used.bitmap, sb, tt);
 	if (err)
 		goto out;
 
@@ -1117,7 +1117,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* Load $AttrDef. */
 	ref.low = cpu_to_le32(MFT_REC_ATTR);
 	ref.seq = cpu_to_le16(MFT_REC_ATTR);
-	inode = ntfs_iget5(sbi->sb, &ref, &NAME_ATTRDEF);
+	inode = ntfs_iget5(sb, &ref, &NAME_ATTRDEF);
 	if (IS_ERR(inode)) {
 		ntfs_err(sb, "Failed to load $AttrDef -> %d", err);
 		return PTR_ERR(inode);
-- 
2.25.1

