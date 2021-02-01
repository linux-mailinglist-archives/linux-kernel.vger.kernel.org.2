Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CDA309FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 01:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhBAA6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 19:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBAA6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 19:58:37 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7E4C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 16:57:57 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t25so10913206pga.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 16:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0gRcVEeV6nGqliN47YBX62tljuHs3/rhZ5XnTs5IdQ=;
        b=vPtgppTigwEDjlMnvlfXOBT+rhGArs6+qUQ1QklRcYLpqr+chl/rod3Fgbx6LBmOiF
         kTyNnXkOHSPPt4aLOww4SNI9Rff59x8Jy9Cba0rqBvstfl2kIoqg70RjmHVLRSol7dMY
         hjIOGQ8noN02/j7L6HtWvdDArrKvVFWpzkDsHD9CqpAwF/fdVxrqXA0UIEdBTRHPrJOJ
         0xR145ZXXfgcQLS5gFLJK7Go6D/bnxx0vwXyXF/7+aKusuigOcvW8N1Xtep7oCz2ooIS
         HpHmlDJEQBzU02azajmbeWsG4+O2XFkra8t2tjKDLT3b5TOsYzfiCVBsR2qzAy94yNRr
         PVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0gRcVEeV6nGqliN47YBX62tljuHs3/rhZ5XnTs5IdQ=;
        b=NIocsPkEHgX4EOB5QqG4ybQQ/SWOKMo16zJHwmbo1u5R2iNoOeIiEhxI4gHlWfL4JS
         ZYPOMss9NQbJFoU+hqfivGBtlmKOHo38GvafwnAKCCeOcKeAy9YeKMd1D6xJ68cSrBD+
         yRE7bvzmY5red54u/aV6suFyRBrBHWftSjjTHdTE6zT7li5POEHi80MZdZQZQvFA0cI8
         rJYvGJf/xsPeYligO9oKdAdvTLhAwk3it0voNNT54JyP87fnXkv+yVPVTGiq20mao9ZJ
         nUHOOvI8lZck7UqR73si36xefiRrARxaVMM6S3gleC9cxc6mQ2NzxFf4/qQOv5DsMAc6
         PkBw==
X-Gm-Message-State: AOAM532O6+OkzSfEMp33OqdsES84nWGn4/6AYL8DP/cYZbQHAXqkcvBP
        /0U6c47s+p3JSfwbMva0hfI0nKY9Li4=
X-Google-Smtp-Source: ABdhPJw1vc98IBtozranx8UMm4Jlgj9NVX2pMJ6l6aKMDQ+grZlBV1Y5kdLyrLAlNrRKw2Pce2ITwQ==
X-Received: by 2002:a65:6547:: with SMTP id a7mr14384815pgw.50.1612141076531;
        Sun, 31 Jan 2021 16:57:56 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:3d90:5212:5281:e85d])
        by smtp.gmail.com with ESMTPSA id 24sm12719797pgs.90.2021.01.31.16.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 16:57:55 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: prevent setting ioprio of thread not in merge mode
Date:   Mon,  1 Feb 2021 09:57:49 +0900
Message-Id: <20210201005749.2980575-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

It causes a crash to change the ioprio of checkpoint thread not in
checkpoint=merge. I fixed that to prevent setting the ioprio of the
thread when checkpoint=merge is not enabled.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/sysfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 100608bcd517..e38a7f6921dd 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -357,8 +357,12 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 
 		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, data);
-		ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
-				cprc->ckpt_thread_ioprio);
+		if (test_opt(sbi, MERGE_CHECKPOINT)) {
+			ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
+					cprc->ckpt_thread_ioprio);
+			if (ret)
+				return ret;
+		}
 
 		return count;
 	}
-- 
2.30.0.365.g02bc693789-goog

