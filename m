Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA6243D7B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhJ0Xsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJ0Xsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:48:45 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82494C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:46:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id l186so4536906pge.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yk1HXF7J33uzPhunZD36y8oU6oQ1XrEctAld/JR4uvY=;
        b=L12aulqnozTFkk9ipyX7hwKm+OwTRe6uvWDur/VrVtQeo3/Z7xFMEos+c7J5k9+b5G
         q4c7DayuFhReg+dHITmNzUOODsfT9DOgsbgaCah46bmrjOEu97TI8NVJ9+dOKpFgRXt+
         KndX11kL+2qSwW1WT2pT3zkgB8f0XWW3Hk/tZ8WGQLAnFys1L2QyVVELLGXmKkCM4i3C
         iKxum/blEvABIlFnkBFkwdwvqjuMgf0MWnhdCHilg3EKAQlvCqowp34nLyHpUsr5D8tf
         DgFxXGndE7vzJC5WmijYCxBKHA6HaTnO1QxTZ5eAfzf/ILxkuLYspXfrZa+RilDWA+tw
         lbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yk1HXF7J33uzPhunZD36y8oU6oQ1XrEctAld/JR4uvY=;
        b=sDMAmNIqU4zqb77YeqmxCbYtdT0JqGvLUxROTwyB6xHnlHiWwskffvF4nOtjUtRRRI
         voB2L7gHSmLSz1fscvh+6ZpifLsIH7OvLsPWMk2uBcwT4CbhqjywiQSIvBntbaIK9+9g
         pPFmFPg7cBa6xMu3LFHecK+foa7gsV85UnAGWWRhv9Qj8zYu6BZL0OTw6btZ8p8lRTGP
         4/8uius1Wo0Y1BhsoRrAlaXFaG/XUGB1D1qIIq6McFxAMZdkmUyc0yKPM5fvkv5lS7Aw
         pj1F9CtwsIvX3VPezId9JVGWu+zG7POyDNHf/yHW800+Gye4Zo1Lc2jjj/KtrpqsfiW9
         bazg==
X-Gm-Message-State: AOAM533ZH7Bkw1Od3SBL/rJf8TX0zA/+aHUgwSawRASdwbHzeQjm2jSY
        JQqFCEpjl0yV0sN2NA72nWNnrrhUUIc=
X-Google-Smtp-Source: ABdhPJwO9EVBH9A8169jDk3/VM8L2G+Q9Dg7Zaa5k+YFrZrHIGy5hmCxHJEyAmreZosm+TsEa3NLMA==
X-Received: by 2002:a63:7f0f:: with SMTP id a15mr644221pgd.9.1635378378755;
        Wed, 27 Oct 2021 16:46:18 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:b75c:b351:dcb7:11d8])
        by smtp.gmail.com with ESMTPSA id b9sm1048168pfv.158.2021.10.27.16.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:46:18 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 2/2] f2fs-tools: separate other bugs in fsck_verify
Date:   Wed, 27 Oct 2021 16:46:11 -0700
Message-Id: <20211027234611.1958146-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211027234611.1958146-1-daeho43@gmail.com>
References: <20211027234611.1958146-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

When we check other corrupted bugs in fsck, we use bug_on. So, if major
bugs are already detected in fsck_verify(), fsck will false alarm that
there are other bugs, even if there are no other bugs. So, let's fix this.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index bc11e07..0619519 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -3162,6 +3162,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	u32 nr_unref_nid = 0;
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct hard_link_node *node = NULL;
+	bool verify_failed = false;
 
 	if (c.show_file_map)
 		return 0;
@@ -3175,7 +3176,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		} else {
 			printf(" [Fail] [0x%x]\n",
 			       fsck->chk.wp_inconsistent_zones);
-			c.bug_on = 1;
+			verify_failed = true;
 		}
 
 		if (fsck->chk.wp_fixed && c.fix_on)
@@ -3221,8 +3222,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		printf(" [Ok..] [0x%x]\n", nr_unref_nid);
 	} else {
 		printf(" [Fail] [0x%x]\n", nr_unref_nid);
-		ret = EXIT_ERR_CODE;
-		c.bug_on = 1;
+		verify_failed = true;
 	}
 
 	printf("[FSCK] SIT valid block bitmap checking                ");
@@ -3231,8 +3231,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		printf("[Ok..]\n");
 	} else {
 		printf("[Fail]\n");
-		ret = EXIT_ERR_CODE;
-		c.bug_on = 1;
+		verify_failed = true;
 	}
 
 	printf("[FSCK] Hard link checking for regular file           ");
@@ -3240,8 +3239,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		printf(" [Ok..] [0x%x]\n", fsck->chk.multi_hard_link_files);
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.multi_hard_link_files);
-		ret = EXIT_ERR_CODE;
-		c.bug_on = 1;
+		verify_failed = true;
 	}
 
 	printf("[FSCK] valid_block_count matching with CP            ");
@@ -3249,8 +3247,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		printf(" [Ok..] [0x%x]\n", (u32)fsck->chk.valid_blk_cnt);
 	} else {
 		printf(" [Fail] [0x%x]\n", (u32)fsck->chk.valid_blk_cnt);
-		ret = EXIT_ERR_CODE;
-		c.bug_on = 1;
+		verify_failed = true;
 	}
 
 	printf("[FSCK] valid_node_count matching with CP (de lookup) ");
@@ -3258,8 +3255,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		printf(" [Ok..] [0x%x]\n", fsck->chk.valid_node_cnt);
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.valid_node_cnt);
-		ret = EXIT_ERR_CODE;
-		c.bug_on = 1;
+		verify_failed = true;
 	}
 
 	printf("[FSCK] valid_node_count matching with CP (nat lookup)");
@@ -3267,8 +3263,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		printf(" [Ok..] [0x%x]\n", fsck->chk.valid_nat_entry_cnt);
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.valid_nat_entry_cnt);
-		ret = EXIT_ERR_CODE;
-		c.bug_on = 1;
+		verify_failed = true;
 	}
 
 	printf("[FSCK] valid_inode_count matched with CP             ");
@@ -3276,8 +3271,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		printf(" [Ok..] [0x%x]\n", fsck->chk.valid_inode_cnt);
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.valid_inode_cnt);
-		ret = EXIT_ERR_CODE;
-		c.bug_on = 1;
+		verify_failed = true;
 	}
 
 	printf("[FSCK] free segment_count matched with CP            ");
@@ -3286,8 +3280,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		printf(" [Ok..] [0x%x]\n", fsck->chk.sit_free_segs);
 	} else {
 		printf(" [Fail] [0x%x]\n", fsck->chk.sit_free_segs);
-		ret = EXIT_ERR_CODE;
-		c.bug_on = 1;
+		verify_failed = true;
 	}
 
 	printf("[FSCK] next block offset is free                     ");
@@ -3295,8 +3288,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		printf(" [Ok..]\n");
 	} else {
 		printf(" [Fail]\n");
-		ret = EXIT_ERR_CODE;
-		c.bug_on = 1;
+		verify_failed = true;
 	}
 
 	printf("[FSCK] fixing SIT types\n");
@@ -3311,6 +3303,11 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		ret = EXIT_ERR_CODE;
 	}
 
+	if (verify_failed) {
+		ret = EXIT_ERR_CODE;
+		c.bug_on = 1;
+	}
+
 #ifndef WITH_ANDROID
 	if (nr_unref_nid && !c.ro) {
 		char ans[255] = {0};
-- 
2.33.0.1079.g6e70778dc9-goog

