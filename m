Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEF2405CA9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244448AbhIISLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243713AbhIISLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:11:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64BCC061760
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:10:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k13so5408421lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lhs6ZtbTTAfte7OqmrSzspYuz4kpC1fa8cnVSBpcH/M=;
        b=AQJ+s9r1af+JC0IN3YS5W6YhO2dCwaRN0razykgXiqJf6YxvVa9mK3NPVSYcKKbKem
         lVbtc+Gtt7WwzBZ3435xnM1aB56KE7oSEdz8pLD+fpHB7atrjWKgWFv9lVqTbPIfiqyg
         TlGC6brqCFfAXypk4RNGg01lzoFeZwDL4W+vy8nslcbjtpjr1nUOam/zfTpwS+eE1TPc
         nx/OHRsmkOkxbeDvNhrIHWl1rir0MYmu53z411xgxGjumfB5Nm2e8ZhXP1NWjkbEFaPO
         DYdRID+k4V7ITcW7rpaq/Ur19MGdHfpO4XAPcxXLlhtPzbm5ADPQnCnYywQ9+oDWM2gP
         xDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lhs6ZtbTTAfte7OqmrSzspYuz4kpC1fa8cnVSBpcH/M=;
        b=rFeBx7eX7X3T2UGN1X2dzGnOlkQqcVlnn/1wmkoKN2HejDok/HZ/0ltfQc1z4cikG8
         p/nimKESnjTKOyoh3an0KbjTlZVWZDkHyfCdUnzshuVWP2SJVQ0KVHtPXaw6FYVLeyUC
         L7oBbp1+PDOi/AGtpUHXw4P5LnJjnWrjpv6Tq5ZJTRDjS1uKX3t5c/G1DokF9qRSyd15
         BUoZy7sRHYLVpJUGYocPGfAPq1cfkZ5Rkt91t6RnMr5jlwNJXYUTp/visZXyfPKaXf7n
         lwIHlO5AGROWbtmvP80N84pFul/cXSOQs4pWCtTfMRG7PK7+eXzMO+HwQMhrHB6gieyj
         owRA==
X-Gm-Message-State: AOAM533r2/RD5JUJyA9dPuzXt4VXiPfHCuWO2wPiSZmC1eoKWv89PBUF
        MuzfJPPEebsctbwvbfV97/4zlNgCQBk=
X-Google-Smtp-Source: ABdhPJwCudenO2kZniUnDmTBlPMPCIvy/dLpSGzFJ+HlwmF72/1L4inYVvqux81HWpnLCmQ+wfjeWA==
X-Received: by 2002:ac2:5dc9:: with SMTP id x9mr873081lfq.394.1631211004221;
        Thu, 09 Sep 2021 11:10:04 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id u2sm270276lff.238.2021.09.09.11.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:10:03 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 09/11] fs/ntfs3: Remove tmp pointer upcase in fill_super
Date:   Thu,  9 Sep 2021 21:09:40 +0300
Message-Id: <20210909180942.8634-10-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210909180942.8634-1-kari.argillander@gmail.com>
References: <20210909180942.8634-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can survive without this tmp point upcase. So remove it we don't have
so many tmp pointer in this function.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 14cb90a4c133..9a096be32fb2 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -886,7 +886,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	const struct VOLUME_INFO *info;
 	u32 idx, done, bytes;
 	struct ATTR_DEF_ENTRY *t;
-	u16 *upcase;
 	u16 *shared;
 	struct MFT_REF ref;
 
@@ -1186,11 +1185,9 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto out;
 	}
 
-	upcase = sbi->upcase;
-
 	for (idx = 0; idx < (0x10000 * sizeof(short) >> PAGE_SHIFT); idx++) {
 		const __le16 *src;
-		u16 *dst = Add2Ptr(upcase, idx << PAGE_SHIFT);
+		u16 *dst = Add2Ptr(sbi->upcase, idx << PAGE_SHIFT);
 		struct page *page = ntfs_map_page(inode->i_mapping, idx);
 
 		if (IS_ERR(page)) {
@@ -1209,10 +1206,10 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		ntfs_unmap_page(page);
 	}
 
-	shared = ntfs_set_shared(upcase, 0x10000 * sizeof(short));
-	if (shared && upcase != shared) {
+	shared = ntfs_set_shared(sbi->upcase, 0x10000 * sizeof(short));
+	if (shared && sbi->upcase != shared) {
+		kvfree(sbi->upcase);
 		sbi->upcase = shared;
-		kvfree(upcase);
 	}
 
 	iput(inode);
-- 
2.25.1

