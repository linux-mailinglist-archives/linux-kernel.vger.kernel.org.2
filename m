Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67CC445D72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhKEBrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhKEBrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:47:11 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5619C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:44:32 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id k29so6518682qve.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxv1bZDHr15atfwYJHUOJ87e76juxg0gWxkHi+2jlUQ=;
        b=p/RuWKtlLSEPCvIEjxZlaTKI4vQNqWXFCN7NCyEv8elHZhQpTsojFHAYaZExo7R7Ex
         yslP2Dy4raIJcPQVQDzSGAl7PoOVxD9SMbwAcFBEEA5SukdLx1omdn6HFf7qtuguyog1
         cW4xdHcG380ZmD37pt8YWsLkBL3l2pwJJrqG8ESjP6CPxOZPmscvB8QU6xnGxDwsGIC7
         aIzI2vL2oWuiIpA94KU57yRsTMYbJGVXs4aUfAVT7aMm7YcsArvBQOhKksg+YMn2Pv5N
         EWQWll49ysCQHR8OwDmvDhy/271p/cIp+u82XPFP/o6VhK3r6wG9iJwA+piSWA9I611k
         MxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxv1bZDHr15atfwYJHUOJ87e76juxg0gWxkHi+2jlUQ=;
        b=TaEfrLDSmeWlhVIFmhijG7MOA82KUtY7HxPmW6h20wGw9hU+kBdawKKnweKA9T1NVt
         EZqZuqJlfxvI9sLnO/37RuwWglKzSNU5qfQR1o745AjsmycEr9MgbPT/3bBbmlh6dHPx
         mdnRUGzuJz9E0rHTHZ1Y38lQwCpOn6cLpoE44IIkIN8Bd6eCO9zRrq1I5iigJknzb8YK
         ZKJgwnBd4oQZ78/tERh5F1aT5x4bOywnHRR8kE0E77xsZaB3+0/Q8+ZeoWwn9D7vyb7f
         0wOgrJnlL4qaP5YUj7Ew8CgKcov9xRXCPX7CqFDON4tIf2KPZYWG9gEQDRjCc/Rk95rE
         3+8w==
X-Gm-Message-State: AOAM530jqJ57kTvpr0gY50GaXW2d3tbqioFN7RQbMwd24qYP39srcmN0
        Ub+/hEofFxiSFv7Vwe7Yn7E=
X-Google-Smtp-Source: ABdhPJxfnFqZnuS3BPSnz9PdPKsMSKblgkWPn4nAF9hidcWkzPqFCfdB7DczRszqu3iUmxeo2Kzg5w==
X-Received: by 2002:a05:6214:5195:: with SMTP id kl21mr27580947qvb.42.1636076671960;
        Thu, 04 Nov 2021 18:44:31 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s11sm4974889qki.95.2021.11.04.18.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:44:31 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     mark@fasheh.com
Cc:     jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ocfs2:Use BUG_ON instead of if condition followed by BUG.
Date:   Fri,  5 Nov 2021 01:44:24 +0000
Message-Id: <20211105014424.75372-1-zhang.mingyu@zte.com.cn>
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
 fs/ocfs2/journal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index dbf9b9e97d74..1887a2708709 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1669,8 +1669,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
 	status = jbd2_journal_load(journal);
 	if (status < 0) {
 		mlog_errno(status);
-		if (!igrab(inode))
-			BUG();
+		BUG_ON(!igrab(inode));
 		jbd2_journal_destroy(journal);
 		goto done;
 	}
@@ -1699,8 +1698,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
 	if (status < 0)
 		mlog_errno(status);
 
-	if (!igrab(inode))
-		BUG();
+	BUG_ON(!igrab(inode));
 
 	jbd2_journal_destroy(journal);
 
-- 
2.25.1

