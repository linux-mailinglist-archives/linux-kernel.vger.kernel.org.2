Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBD344501C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 09:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhKDIY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 04:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDIY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:24:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009AAC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 01:22:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u11so6014372plf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CyUgf+E27izz8eZXu5EdO3onvde6cXVaxrtlTel0Gjk=;
        b=T4HeVGgFFrZdkuI85Bv3La9ebDCcKARia1U8w6+C7sAJH4G3+09PgbpTXs/lka+buB
         OF5J3MhrtOZsgBA2oihZSiHfOBA6gqBVW2+ANchQrjtPDzICz0bnwT0GoYxXn2S3Eei7
         eUlrhQCzE34Dm7ZJJ1b00zu4NLxaYmYoV3t49stkPfwhxvUbcqNBY311qyOYNOFv+Yud
         ljH38voo6ORAJ9v5mZmC+qVhPd5p+wiy4A4THXrZ7Whnm6w8iHMrzPzESRpbhnHxAULb
         ab19THiXMDgDbFks9w4XGqOlum4stt5ChV09IIOL2ZuGJnMWdPPoE9Vnv4XxixfwEsPv
         oG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CyUgf+E27izz8eZXu5EdO3onvde6cXVaxrtlTel0Gjk=;
        b=2VINZOyO9RziDtfO7PodLazwlRrNNmUx5VsljNX5cueH0JJmJS045Ev9gD1MhTDFt8
         gZlb2Jbg9mN5oB7dOBQRAZYnvO79+0f0yr1VXtLr4ZbBkxX63zUNV7LrpDsaKRVFGzf3
         zj/ItUpUYpkzXCec2JYlO6iLU3V9GXZ8ruMAlqXePJUAnCM7Q93U+s2CJCFMy7UE4KRJ
         ZlWckILa0fXaIoMjGYS2WDOJklrHmCxYe29BamdnSlI5ZAHXSch287GimJ1XBwzz90sj
         hDp64VMV8TGmcMhQkOfAXTApp7JMopCUmbK7qZNuf/LDxHnCgzfIlZWKgM5Ye+thiyiw
         BPjQ==
X-Gm-Message-State: AOAM530fevRjG8SkJpKAIpIoO9+mt6G28DNKVjcetrK/DJyd302lLR3E
        OMIHqvGqOZxD3C/6jTsNJoU=
X-Google-Smtp-Source: ABdhPJzIGhrUoaVah+gozgNMaDDVh94KHE4PVsAecpIA5T1RBgEXLmZSdPSO6V1LraPH7O2zGbWk4w==
X-Received: by 2002:a17:90b:155:: with SMTP id em21mr20866570pjb.12.1636014138415;
        Thu, 04 Nov 2021 01:22:18 -0700 (PDT)
Received: from localhost.localdomain ([94.177.118.123])
        by smtp.gmail.com with ESMTPSA id m3sm4826985pfk.190.2021.11.04.01.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 01:22:17 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Sahitya Tummala <stummala@codeaurora.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs: f2fs: fix UAF in f2fs_available_free_memory
Date:   Thu,  4 Nov 2021 16:22:01 +0800
Message-Id: <20211104082202.1286551-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if2fs_fill_super
-> f2fs_build_segment_manager
   -> create_discard_cmd_control
      -> f2fs_start_discard_thread

It invokes kthread_run to create a thread and run issue_discard_thread.

However, if f2fs_build_node_manager fails, the control flow goes to
free_nm and calls f2fs_destroy_node_manager. This function will free
sbi->nm_info. However, if issue_discard_thread accesses sbi->nm_info
after the deallocation, but before the f2fs_stop_discard_thread, it will
cause UAF(Use-after-free).

-> f2fs_destroy_segment_manager
   -> destroy_discard_cmd_control
      -> f2fs_stop_discard_thread

Fix this by stopping discard thread before f2fs_destroy_node_manager.

Note that, the commit d6d2b491a82e1 introduces the call of
f2fs_available_free_memory into issue_discard_thread.

Fixes: d6d2b491a82e ("f2fs: allow to change discard policy based on cached discard cmds")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 78ebc306ee2b..dbe040b66802 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4352,6 +4352,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_stats:
 	f2fs_destroy_stats(sbi);
 free_nm:
+	/* stop discard thread before destroying node manager */
+	f2fs_stop_discard_thread(sbi);
 	f2fs_destroy_node_manager(sbi);
 free_sm:
 	f2fs_destroy_segment_manager(sbi);
-- 
2.25.1

