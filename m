Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8583EB58E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 14:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbhHMMa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 08:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbhHMMay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 08:30:54 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9D2C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 05:30:27 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a7so15380702ljq.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 05:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKyfNfiNqsHMlq1jao0L8607rl8WGkrJVnPkqazb7bQ=;
        b=GbGotzYF6T06vpY+OUEQIlPMEj5pd++OBg9ekYpLubofuJK/zKV+LxP9seGOUHi2ZN
         YbSmiMk5z16NuqeoOEBrg6B8FCl3RK6bjJOBdD0GDSIt1hHVUFCEJgTG+mpkwVSyg/8N
         zsbW1cqeFgrbh9AGeBtWdvRrfQ1rKeWYBSkPS7ZLVo1fDYNEQgUwuP8vlUWwsQ4UhdfI
         vdBZeEUGL1vPp+ioYUQHeabQOeaoa/5gsq5a0sLt1RtlNMirtsNmMsaLce0ZZaInx9Vq
         LwPVOJ2C/pG2MqgQq4Ogzk68frOc22xbcGIWl5MEElGBjgaoB7+kM7delLLKPBoJYh8W
         1wDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKyfNfiNqsHMlq1jao0L8607rl8WGkrJVnPkqazb7bQ=;
        b=hV8VOLu1bA93EBm9h52xlPv+ih7PvrghpfagiR5G1/VaorV6TewGFE7spSwVQs2qZW
         WkFzyttGYHtOAsW+vRl8zxxg9FfO4IPLgXuXnHninkFGsnOe+2i54ddj9ATor8VRKZ+X
         Om7nUh9vng8umSDEa96L28wD5JrpE+aUv7jabgqJO1utdsp4hbTWv0rDZ8675U6oMu0T
         F0R9VKGxCYH1gFdi8RwmKQxii33Yih47kaI1v57i5/5g47HCSJJPOgn9EwkRYX7xLviP
         p6kEbMxOKWPuLw2AhG85l70iYmbA4/VK4OJcprzt3GYGOPFTUQtR+YxZ6ZPHnfCdBbws
         2eDQ==
X-Gm-Message-State: AOAM531uSFGQgPP0WZfMUqPk0kDhIG0UCWPLY204VbRrUInTRZr7MPqX
        50CPGWttakUiyaDlMnO8wnVY6VEmzd5ARA==
X-Google-Smtp-Source: ABdhPJxUFyr7g2Jo75fLHEeiGOVb53ZTMRRDjcVopWtyR5+UnWgv4N2N6Z2x5vPLNzm7L6w9oAs/ew==
X-Received: by 2002:a05:651c:1506:: with SMTP id e6mr1686085ljf.487.1628857825412;
        Fri, 13 Aug 2021 05:30:25 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.232])
        by smtp.gmail.com with ESMTPSA id a7sm145009lfu.275.2021.08.13.05.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 05:30:24 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH] sysv: use BUILD_BUG_ON instead of runtime check
Date:   Fri, 13 Aug 2021 15:30:20 +0300
Message-Id: <20210813123020.22971-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was runtime checks about sizes of struct v7_super_block
and struct sysv_inode. If one of these checks fail kernel will panic.
Since these values are known on complite time let's use BUILD_BUG_ON(),
because it's standard mechanism for validation checking at build time

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 fs/sysv/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/sysv/super.c b/fs/sysv/super.c
index cc8e2ed155c8..d1def0771a40 100644
--- a/fs/sysv/super.c
+++ b/fs/sysv/super.c
@@ -474,10 +474,8 @@ static int v7_fill_super(struct super_block *sb, void *data, int silent)
 	struct sysv_sb_info *sbi;
 	struct buffer_head *bh;
 
-	if (440 != sizeof (struct v7_super_block))
-		panic("V7 FS: bad super-block size");
-	if (64 != sizeof (struct sysv_inode))
-		panic("sysv fs: bad i-node size");
+	BUILD_BUG_ON(sizeof(struct v7_super_block) != 440);
+	BUILD_BUG_ON(sizeof(struct sysv_inode) != 64);
 
 	sbi = kzalloc(sizeof(struct sysv_sb_info), GFP_KERNEL);
 	if (!sbi)
-- 
2.32.0

