Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D692631B2FE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 23:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBNWOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 17:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhBNWOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 17:14:33 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70042C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 14:13:53 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z11so7427885lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 14:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdLNJb3inSse6CSVYJiB22jHj3yvabyJ9VxlXaI7xTQ=;
        b=guPjJGqIqAsDmLr2n3cSflzbvX445lMiq+X/IMg/6mKjAbKsI/nKAYs2FkyT+px5tH
         Jwwgls8hS2qcCa4Znb0cgs8msdI4QDpZsUqgtKpCcPCm4OlZ2A+BvpKDSOr1ESRle20E
         vQrUcWdRddGx+FpCGMibLLGtrKa4UUZAMkayDTw56mcAQYiunZQjuiYl4vdAoRZP1qTb
         D56fJudTDwcke05ClTpG+l2vmeSYDshTNrRjqhHHttV3YO24OJNV0yio5h7QPyZ3gqt5
         ia47sBlxwkNqwQ6b4XNt2RLM+eeTz3GgVKfhuGPhNd243Gsj8PC3zL11MEjYqVuLVXlU
         onOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdLNJb3inSse6CSVYJiB22jHj3yvabyJ9VxlXaI7xTQ=;
        b=etw4QNtxi3kRwOuN6RTUrD/ipQIBJ+6AO8mrX3EPrnad0peluS2Zdwd/MO3wNlM1NG
         FbQbUMXjY+NB0lMf1Aroc9SVUQHMKcelic/QO3s5xMIMIWl90DRrpLgb4X+t0DPMnfP4
         cCE8dip7s2Gmj+P+BbxHQIrHP/Dx+7fopwiJtQtRGXuBUltaoHI98aWg9ss8KgEfY9g9
         qxfudewohSBPL4LN7wmO6zo8N17c1oQHG+XSYbACNa1fR+ifAFLAIL5r4AoI28ZENhMk
         fzavYDT5o0dEtq+T/DRM+IHqWfMAF2Gheggr4FlqYY03+ozYegbVrYhJqr/b4dkmsRfN
         rJVQ==
X-Gm-Message-State: AOAM531DrB4VDX2BHPdVyAkJomeE7+QyMuzovJed1SZA7Ephf7Ikf6qp
        joM66ZWYNor1+lAEqhl+XWZVUz34E/mchbRBMoY=
X-Google-Smtp-Source: ABdhPJwdRArS1ts3Fc05DPVMr6e61YKjUo5X3R1ZH3kmkjNYYTkKX0Rtgsmlhv8BF1cIzqqE+98LcQ==
X-Received: by 2002:a05:6512:234d:: with SMTP id p13mr6933065lfu.87.1613340831866;
        Sun, 14 Feb 2021 14:13:51 -0800 (PST)
Received: from localhost.localdomain (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id i18sm2539271lfe.177.2021.02.14.14.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 14:13:51 -0800 (PST)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [PATCH] ntfs: move check for valid resident attribute offset and length
Date:   Sun, 14 Feb 2021 14:12:47 -0800
Message-Id: <20210214221247.621431-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we should check for valid resident atribute offset and length before
loading STANDARD_INFORMATION attribute in ntfs_read_locked_inode()
let's make that check a bit earlier in the same function to avoid
use-after-free bug

Reported-and-tested-by: syzbot+c584225dabdea2f71969@syzkaller.appspotmail.com
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
Link: https://syzkaller.appspot.com/bug?extid=c584225dabdea2f71969
---
 fs/ntfs/inode.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index f7e4cbc26eaf..70745aea5106 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -629,6 +629,13 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	}
 	a = ctx->attr;
 	/* Get the standard information attribute value. */
+	if ((u8 *)a + le16_to_cpu(a->data.resident.value_offset)
+			+ le32_to_cpu(
+			a->data.resident.value_length) >
+			(u8 *)ctx->mrec + vol->mft_record_size) {
+		ntfs_error(vi->i_sb, "Corrupt attribute list in inode.");
+		goto unm_err_out;
+	}
 	si = (STANDARD_INFORMATION*)((u8*)a +
 			le16_to_cpu(a->data.resident.value_offset));
 
@@ -731,14 +738,6 @@ static int ntfs_read_locked_inode(struct inode *vi)
 				goto unm_err_out;
 			}
 		} else /* if (!a->non_resident) */ {
-			if ((u8*)a + le16_to_cpu(a->data.resident.value_offset)
-					+ le32_to_cpu(
-					a->data.resident.value_length) >
-					(u8*)ctx->mrec + vol->mft_record_size) {
-				ntfs_error(vi->i_sb, "Corrupt attribute list "
-						"in inode.");
-				goto unm_err_out;
-			}
 			/* Now copy the attribute list. */
 			memcpy(ni->attr_list, (u8*)a + le16_to_cpu(
 					a->data.resident.value_offset),
-- 
2.30.0

