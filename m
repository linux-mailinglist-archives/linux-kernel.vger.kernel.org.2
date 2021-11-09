Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7344ACCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhKILqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhKILqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:46:35 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D97C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:43:49 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n85so14713287pfd.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5eMXmJwKC8GGRlh+nYxceho5NCyU5grVmBhZ8vwkJHo=;
        b=PGXbW/eMSRNNFJ4kg5o2exkrpfmsER3wRrCgRu/Xa3g/idErzDC8zCE8rEum4uyxwQ
         MmYXcO2lJcZvG9C9GDBhRxpaj+t102I799V6poUg4X8QTHne6BOLpCYnUrZARVfz4pcB
         IyftOvEnJnNKnEOFqjrTczJoxrOx7LzE3ZlIa+3/p5FgbsrkCdQPbW2+OGEAQn9hoXWz
         yc+yxj4stLNc12zp/lsyMOd6k/C1gxL0UTfYhSuoGJVkvAsGoAGe+4F008A4+xMHV0EM
         a8+cBEMReYbsEw/jj5CPMTVbut13AZLKnJxiXJw2NCQ2Nw8cm2ZOOGuU3rG0if3nSivr
         Iadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5eMXmJwKC8GGRlh+nYxceho5NCyU5grVmBhZ8vwkJHo=;
        b=gUfj0DbxkyXcF4+VcEwu+CAAAXSd6cOcFfvuA2/vbLzCMN0pVoqAxThgmW46CHjlWs
         vhi/kHgxHkk+sqAWPCEc3mpEht5EFN0k9FEHhdkqLuRJ2S7M2/SysaBiEugn6AHLUe5R
         yRA8l2zvpJoITuC5rLdpbCCncWr9kAxIdob/zCu0JSG1DS/3Q+HA2PEg/FE2vIoUY2dc
         s0JuKz+5QQgborrkDdhfooi9QYn4uSWXe95vlX0Mw4MbMZTz63K1OLXPl2CIlvVhgyjt
         xXJmMpWvSClF6q6gtbm+moUhDHy7mhp7aFpc6MGB6EkjDUzo2FAZWS31+WNVlTf4FyWA
         PI2w==
X-Gm-Message-State: AOAM532dAo13o69N5Hg+5mWIbtC6AUi+Q1K41VinCyIlZtEAPvzUcn4E
        wNU1ozvbyvtR5c9og+mkoQ0=
X-Google-Smtp-Source: ABdhPJyiaxxXWFuJS+G5fVve9a9dlOfh6j2Wdq9/TvB43si/ffQixKswoCHttKtd4zCXUYZzC0sM+A==
X-Received: by 2002:a62:e514:0:b0:47c:12f6:3aae with SMTP id n20-20020a62e514000000b0047c12f63aaemr7489484pff.26.1636458229011;
        Tue, 09 Nov 2021 03:43:49 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i19sm6743549pfu.119.2021.11.09.03.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 03:43:48 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     ericvh@gmail.com
Cc:     lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fs: 9p: remove unneeded variable
Date:   Tue,  9 Nov 2021 11:43:43 +0000
Message-Id: <20211109114343.132844-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck review:
./fs/9p/vfs_file.c: 117: 5-8: Unneeded variable

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 fs/9p/vfs_file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index aac46c5e5bba..eec8cf646a52 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -116,7 +116,6 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 
 static int v9fs_file_lock(struct file *filp, int cmd, struct file_lock *fl)
 {
-	int res = 0;
 	struct inode *inode = file_inode(filp);
 
 	p9_debug(P9_DEBUG_VFS, "filp: %p lock: %p\n", filp, fl);
@@ -126,7 +125,7 @@ static int v9fs_file_lock(struct file *filp, int cmd, struct file_lock *fl)
 		invalidate_mapping_pages(&inode->i_data, 0, -1);
 	}
 
-	return res;
+	return 0;
 }
 
 static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
-- 
2.25.1

