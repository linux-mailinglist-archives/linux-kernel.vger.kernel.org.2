Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D17241B894
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbhI1Uss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbhI1Usp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:48:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEB4C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:47:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id r7so15255233pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+43Onh4HLkZnURtDWg0isjVCwVeiEe/QdPT72teF59c=;
        b=HEbBZj/V0ZB5lae5qYF2tkTybTiTwP3ivQzeDmRMWPH6F9XPE0VhLYAHR9r8vNt2ei
         vBgsQns0l1TsumStQKiQ2LX7GlM/E4QiTKPFgwiLkQ6psBedgZOVUh78sGLMsgD9oBIk
         bMI0T1XbPAVt4kU2ZgDrfqWUnNeuIizUpDp/O8LIAYScBvBe9SH3rUdHsdqWRtiKNL7+
         QaM08y0bCXyEbkfRIyRfpEVQLIjbHQU3mE9NPlK5KQqyye6SfjGHZETWpb7oYWrgPC5N
         SyFW3O4IxUvzf19JMPfXx/0ao+wBtbCbyhCBfAc85Sk9gpmHK+2bglNpDoF/vJaIK5Xh
         gP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+43Onh4HLkZnURtDWg0isjVCwVeiEe/QdPT72teF59c=;
        b=lexNqMXISGIH2SIK8LMf1+h9ecV2RKq7d9A0NBCYM+Sk+QIc2cyVpXHCgU+yMGyB6l
         AXQVGubqhZi6R69m7cWf6fdngQNaBApTvhniIwHlzdGjDxDbxn0qyupXuKcRdxTdSvWI
         6nCgTeX3iavVnElS2M/UoSMvHZGBlJBssOJTJ6fehZPQuRW4E/6M0BGSXFxiLK3EYkGs
         4gthw5t0Xi0h9xJmlcB0GHCiQJRO9CEIaqdaWRA+LQRZgh4OEVfoVUccXR/eThrzxFCO
         +UfDiAuMC2cYSDyQzVMhkAey27Krqk0X5rr6lhJpYVchSmW04jaYPD1TeJPIBs8XIgwV
         GVHw==
X-Gm-Message-State: AOAM532ldJnocGwG7HhGXMHzhwY5XUBQ/OmNaJT/kroAXrc/fkEF2PUA
        naDNfjaBYQ/qKKxLH9jPfahy3MUQK44=
X-Google-Smtp-Source: ABdhPJx4cpsJn/joYMU866++cYAR7WQpe0hFwXByL6PnF3QWe1w8pxddYU9WSucKXHRAaDdfjMOYGA==
X-Received: by 2002:a17:90b:1096:: with SMTP id gj22mr2120509pjb.124.1632862024942;
        Tue, 28 Sep 2021 13:47:04 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:ad75:d50c:938b:6212])
        by smtp.gmail.com with ESMTPSA id s2sm32071pjo.24.2021.09.28.13.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 13:47:04 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: fall back to the original version check when clock_gettime is not supported
Date:   Tue, 28 Sep 2021 13:46:58 -0700
Message-Id: <20210928204658.2230524-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

In lower versions than macOS 10.12, they don't support clock_gettime
function. It breaks the build, so we need to fall back to the original
kernel version check algorithm, in that case.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/mount.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 7c4c681..c928a15 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -975,6 +975,16 @@ int validate_super_block(struct f2fs_sb_info *sbi, enum SB_ADDR sb_addr)
 		MSG(0, "Info: MKFS version\n  \"%s\"\n", c.init_version);
 		MSG(0, "Info: FSCK version\n  from \"%s\"\n    to \"%s\"\n",
 					c.sb_version, c.version);
+#if defined(__APPLE__)
+		if (!c.no_kernel_check &&
+			memcmp(c.sb_version, c.version,	VERSION_NAME_LEN)) {
+			c.auto_fix = 0;
+			c.fix_on = 1;
+			memcpy(sbi->raw_super->version,
+					c.version, VERSION_NAME_LEN);
+			update_superblock(sbi->raw_super, SB_MASK(sb_addr));
+		}
+#else
 		if (!c.no_kernel_check) {
 			struct timespec t;
 			u32 prev_time, cur_time, time_diff;
@@ -1007,6 +1017,7 @@ int validate_super_block(struct f2fs_sb_info *sbi, enum SB_ADDR sb_addr)
 			update_superblock(sbi->raw_super, SB_MASK(sb_addr));
 		}
 out:
+#endif
 		print_sb_state(sbi->raw_super);
 		return 0;
 	}
-- 
2.33.0.685.g46640cef36-goog

