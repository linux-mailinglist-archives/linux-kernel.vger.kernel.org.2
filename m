Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46FD44E3CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhKLJ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 04:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhKLJ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 04:28:44 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96594C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:25:54 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso6776101pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ml/1R4nA5zLg0kuXFUTENyZXx71DFoOiO5mfslbZ6No=;
        b=XBEslYoFxMA/EIFIzxgwx6TBbCIOuTyG1BkLBgX5lK2MOm2Vqa3p+Hve3XF2jHoIQu
         REnpRU+HJbnOkT6jtfZRcfWvXn8VQo/A6T9p60xMZvZigXZF+xPWre7GhDkEGvJ7gcNm
         p9xgHOk40drLogMdBVsSjj2fIAEwifW443Z4cx0z8aGFyLnKYNyCItbza4Pd8bFnQOZ8
         0LAU4Iz/DJxq0Ou35NGTI+tAT3R3vgbKgB1VvLYfpF84F7kkbktisn68WSOafdFpzd6h
         MZnMRstq3tU1rIVHgt3XZ6IwFh5jLpRqB65/WdLyYSJcDznkKT0HOd73YLzfBAUlR05U
         Z60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ml/1R4nA5zLg0kuXFUTENyZXx71DFoOiO5mfslbZ6No=;
        b=AIcOM/+eMtGPz694JHWQEGnWlEjUVmy//p4egjbFbTd45bb1XBeSxkCnR3TuJfpb8x
         e7B/ZZPBWwS9z3Ep45oecPGQQySihfnU09cKUQdLbY63246HtFKpfYqSCFpZor0sH79I
         2jjhPggdD6fAadEvn6H7Bh51ylPWNvVxQlQ84wWl0gLf6s5nHBYEPhC4LAU8KTBrLx21
         s6AD7UKhXCYMvw4f5W7vlCS+fQCyRIQfILBNlGmjdnfgJMeehm5yokR7C7Fr7FBC8PCU
         tdBr32ZSdN90KPBjkr5vPM+gh3q5LdWp0mh1iF+En1txICLpE4//1I/fEIFT+vnguNIN
         U2Qw==
X-Gm-Message-State: AOAM533UcXOhGd+DQfGAmLamriGIKS1GahfRVyMOD92++2c099wmBU7q
        6XRSQ3owoajnvxSPNOPMGMV8LgqY7G0=
X-Google-Smtp-Source: ABdhPJwe+uEfynU1N44AtBtCzD3jKMRbcLX/eCqdNuu/C/Eo0RU3JQKBX9YYUH8oRJ0P8bK3hWHKnA==
X-Received: by 2002:a17:90b:4f83:: with SMTP id qe3mr34667828pjb.56.1636709154210;
        Fri, 12 Nov 2021 01:25:54 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u13sm4252646pga.92.2021.11.12.01.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 01:25:53 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     ericvh@gmail.com
Cc:     lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] 9p: Use BUG_ON instead of if condition followed by BUG.
Date:   Fri, 12 Nov 2021 09:25:47 +0000
Message-Id: <20211112092547.9153-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 fs/9p/vfs_file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 4244d48398ef..f2375448cafc 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -139,8 +139,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	fid = filp->private_data;
 	BUG_ON(fid == NULL);
 
-	if ((fl->fl_flags & FL_POSIX) != FL_POSIX)
-		BUG();
+	BUG_ON((fl->fl_flags & FL_POSIX) != FL_POSIX);
 
 	res = locks_lock_file_wait(filp, fl);
 	if (res < 0)
-- 
2.25.1

