Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB917309FA0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 01:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhBAAHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 19:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBAAG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 19:06:56 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E4C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 16:06:16 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m12so92754pjs.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 16:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GyMrZIJMYa4hWkLXbLjixtU8s2LOA6drIR1e6+hZdE=;
        b=vZ2dyIKBpxc5iexyZO9GvuWFrZfEra0Govh3FQGQxYfnWoi5k7ySTtxd9BGs1/B1OO
         sXgV4IeVQmGe9mHdchY6x7pyoearfug7tLMU7SCtMgSU6JjXyEISXs1x5G2iqz1/2Et5
         yIzoDU1QAxvYXuzL6pHh/bnJHr1mmyYeF0DjwimSU/eGoZdQbkRx511W1xCYr3Vpknqj
         ywf33fNx8NpjWk/1flBwj0mgJ/e+snOGz+hIxOB/+VqL/5BcKEkqleBAT1WHfUYI6k5M
         j2tBLlz5NuDiCdZMVSbVuEnwFmOwpzgCvf8Gkc6lyiwauuHwax3ZVOmM1DScHHFJwCwT
         tNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GyMrZIJMYa4hWkLXbLjixtU8s2LOA6drIR1e6+hZdE=;
        b=s+291mS3pAbJ2I+dJHqTE3qRYK/m0qfvJDmEA6SqY6PJVuQKZbXM/wvlh8NmYcAidG
         xpN4yjX/IYs28XaQwugN8DMo4JWZJ8AGXZxS1G+mvGZMCpdQTPpoX2I7JpiJcol9Dh83
         Px04+xuv8R1Io+91um+mwQvPfktHOKUVFsLm3xwAkfjBxlx4vNcwLaBALO3E+y7ZsjLE
         NL0u/E4nopIF+04TQxTmFHcjLDs4JROCqRR0vIUdAHJgg+Y/Nzgqu7SU2W+ocU2erdYY
         FtTdVOqyrg0JhMhYUUBZJ6bh5/FsUpHjXFr3p97nF8jcWEKwdlVYBlMqgOUrXQ3CPJ9K
         aiXw==
X-Gm-Message-State: AOAM533S8s0XFm1eOgc+S4hKkdxlWXYfaGhU1I41v1I5zEaeMreCas4A
        cJ1bvuvy9octwRYrfbgimNA66X7BSMI=
X-Google-Smtp-Source: ABdhPJz5XtjkCjTVC1c7AaZfb3CpLURfPrzg1hkc9gWukuIjOmchtvE/UPY0ZLsnaFGZaFHLjuNcZQ==
X-Received: by 2002:a17:90b:3104:: with SMTP id gc4mr4419257pjb.151.1612137975635;
        Sun, 31 Jan 2021 16:06:15 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:3d90:5212:5281:e85d])
        by smtp.gmail.com with ESMTPSA id 16sm13317903pjc.28.2021.01.31.16.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 16:06:15 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: fix checkpoint mount option wrong combination
Date:   Mon,  1 Feb 2021 09:06:06 +0900
Message-Id: <20210201000606.2206740-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

As checkpoint=merge comes in, mount option setting related to
checkpoint had been mixed up. Fixed it.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/super.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 56696f6cfa86..8231c888c772 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -930,20 +930,25 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				return -EINVAL;
 			F2FS_OPTION(sbi).unusable_cap_perc = arg;
 			set_opt(sbi, DISABLE_CHECKPOINT);
+			clear_opt(sbi, MERGE_CHECKPOINT);
 			break;
 		case Opt_checkpoint_disable_cap:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
 			F2FS_OPTION(sbi).unusable_cap = arg;
 			set_opt(sbi, DISABLE_CHECKPOINT);
+			clear_opt(sbi, MERGE_CHECKPOINT);
 			break;
 		case Opt_checkpoint_disable:
 			set_opt(sbi, DISABLE_CHECKPOINT);
+			clear_opt(sbi, MERGE_CHECKPOINT);
 			break;
 		case Opt_checkpoint_enable:
 			clear_opt(sbi, DISABLE_CHECKPOINT);
+			clear_opt(sbi, MERGE_CHECKPOINT);
 			break;
 		case Opt_checkpoint_merge:
+			clear_opt(sbi, DISABLE_CHECKPOINT);
 			set_opt(sbi, MERGE_CHECKPOINT);
 			break;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -1142,12 +1147,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
-	if (test_opt(sbi, DISABLE_CHECKPOINT) &&
-			test_opt(sbi, MERGE_CHECKPOINT)) {
-		f2fs_err(sbi, "checkpoint=merge cannot be used with checkpoint=disable\n");
-		return -EINVAL;
-	}
-
 	/* Not pass down write hints if the number of active logs is lesser
 	 * than NR_CURSEG_PERSIST_TYPE.
 	 */
-- 
2.30.0.365.g02bc693789-goog

