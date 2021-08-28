Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4B73FA2B1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 03:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhH1BFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 21:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhH1BFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 21:05:35 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22570C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 18:04:45 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id eh1so5016941qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 18:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ycC5EjOXPlt4T7OSVhH11w0K9nPLV+pEuuLBP1af7qg=;
        b=X3UY66mu5D5Oa20nbjKyka61OUbcBHu+0Dn+JOelzZCzj45w1vm7IZruetW3O0Utvm
         wphy/DmOkplxve8ZP0Bf6JcliiO70OF3hk7tIeqTKcZGXOO6vMRATEo6yvc5pq0E6lRi
         po6R4b1DECzkyvCjjuRUn4rZv5HrrbLP2TEKFhTNBHvJpnTpZD+xuxUh98zUWvY3QxIZ
         E4xszaIXsDQI4Wuw7Q19OZw0q5J8c0ufjkcZt0VYmdCAATUvlvyNyVlNSwWmG2eWMBr3
         ipPPo1R5bZt7X4m8ssQlGBmt+L+LzarNIe3onimTOihVFyb2Jg3CYsgCWmb1aH53/7jA
         buww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ycC5EjOXPlt4T7OSVhH11w0K9nPLV+pEuuLBP1af7qg=;
        b=AvR44pjnZ9yDbFj1CiQQg/aN6YB8aXPExP1HlgSN7HLA360TkDrOfXnUV6wqYpx76D
         RoShAd1OrMRLPFs6UGddY2oQjUudUTsB//frHL2mboRsIWA3uN4Fg8J/3BkZt98s6Lz2
         8/F7ZKPGJAAHqCWdx6IbB2rFqw22dbtkmuvRFdm6W63rxh/g/o8qGVTA5QNlalp3ufI6
         e7Bl4oXelia5N18RS0/Q8efirsFI2UgB9Q+xqjMfehOqvHVx6YrNB2xM0gmZlhVrtUFP
         fwolPlgA4IOe0yDI4ZlVI8O/TQfFjJz72ydXQBVTVwtsyQk/o8jUxsp6JAt188UCeCrJ
         4oRQ==
X-Gm-Message-State: AOAM5300hhXZ+MQBS0mDTOnEj8xAbU0ZjYTIGorluvkRvCVkeT1BYf4P
        iS2ElFqnng3KNOnHj3T0pTY=
X-Google-Smtp-Source: ABdhPJyv++bIWK/0r2Oc18SBIuOViJS3qdiBlzi1SOLF2tjvrUUe0Vi+k6jsaRKexrbeR3ia/zzHqA==
X-Received: by 2002:a0c:9043:: with SMTP id o61mr978572qvo.54.1630112684366;
        Fri, 27 Aug 2021 18:04:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n18sm5963946qkn.63.2021.08.27.18.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 18:04:44 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Mark Fasheh <mark@fasheh.com>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ocfs2: fix bugon.cocci warnings
Date:   Fri, 27 Aug 2021 18:04:32 -0700
Message-Id: <20210828010432.11100-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use BUG_ON instead of if condition followed by BUG.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 fs/ocfs2/journal.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 4f15750..2305aa5 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -974,8 +974,7 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 		goto done;
 
 	/* need to inc inode use count - jbd2_journal_destroy will iput. */
-	if (!igrab(inode))
-		BUG();
+	BUG_ON(!igrab(inode));
 
 	num_running_trans = atomic_read(&(osb->journal->j_num_trans));
 	trace_ocfs2_journal_shutdown(num_running_trans);
@@ -1656,8 +1655,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
 	status = jbd2_journal_load(journal);
 	if (status < 0) {
 		mlog_errno(status);
-		if (!igrab(inode))
-			BUG();
+		BUG_ON(!igrab(inode));
 		jbd2_journal_destroy(journal);
 		goto done;
 	}
@@ -1686,8 +1684,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
 	if (status < 0)
 		mlog_errno(status);
 
-	if (!igrab(inode))
-		BUG();
+	BUG_ON(!igrab(inode));
 
 	jbd2_journal_destroy(journal);
 
-- 
1.8.3.1


