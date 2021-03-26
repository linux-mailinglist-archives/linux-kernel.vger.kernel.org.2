Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C3734ABFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhCZPw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhCZPwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:52:14 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF26C0613B9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:52:12 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id c17so5407151ilj.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+6iLfraAukd5qWxrNJ/xAJfYelrvhrIxjGSLD09SOtQ=;
        b=H3ITNbkEfXi4nc2sLaibx3OIOpm8AKArOMAQYThU/5VjUpYdQXacQ5xC2mJfMTmGeF
         fcxezLDTMNBAyf7EAb68NJkOUhfwZZmQ7a30/8YjndEtELfI50bgIy8l8GmF/8dO6PfR
         NZkhBpbf0HEqZmmZtoygi0iun5A3xPoQdY6Gv98xi+OWEFpTPqsv/TYyK5chxqZzf5dw
         5AcYMkE+HTA1nF7tuQ+t/3mP/rh26TRioyP03kvzzN3BB79+SPdTpkSqCa+cz8V4Osg8
         tZHNzoXAU8P+VZZCXZI5r82NpbHb9JlFuENYbSvHqr4p+9KKd5/5ptkzf1iMBK5QnD75
         KGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+6iLfraAukd5qWxrNJ/xAJfYelrvhrIxjGSLD09SOtQ=;
        b=Palf+gfbjBYGfXAIFQa7BBoAHVQIprTk6ubS8geMG+Huidbz3w3d8+bvBcxleSVHNP
         gA8AdgmUmYOW7IE/15KdixzuUEfAw2vmRBadEJ4A1fyHLkWuv46UcnGnt6VuMdlMM4go
         WAutcLVbbq9iXQjBWXQz1+laCqoNaLp6dY3A9lVzngGHV2AEZes78FzVBx9fUCIap5E2
         TlawOpqcgYkgPmN/M1xh6B67KdO6J8MQm1mGQUIduICdWPWPwGdG3pzZO8ft9PCO1s4o
         oYOj31D+Wtl8LUxSJZbr2eZPl5XHNhUSbytOpvDteYZc840kGPX23VbZ8ShA1eAq468Y
         xEgA==
X-Gm-Message-State: AOAM530UFO284Rsub/oJ07MU1Hyc5CS0bolFRX4m8Rrhjf5q2XArWnfS
        eEeSOkv6rQ/iJY2Y8hfneCgheQ==
X-Google-Smtp-Source: ABdhPJywJJ2sTTKe4i/jNzJlMhlnzJ5zi0tqxxZeETZ3m6xQ56t3cRnC6npLnkJ3omZz1PG0L+UyAw==
X-Received: by 2002:a05:6e02:c09:: with SMTP id d9mr1678660ile.62.1616773932148;
        Fri, 26 Mar 2021 08:52:12 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a7sm4456337ilj.64.2021.03.26.08.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:52:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/7] Revert "signal: don't allow STOP on PF_IO_WORKER threads"
Date:   Fri, 26 Mar 2021 09:51:24 -0600
Message-Id: <20210326155128.1057078-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326155128.1057078-1-axboe@kernel.dk>
References: <20210326155128.1057078-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 4db4b1a0d1779dc159f7b87feb97030ec0b12597.

The IO threads allow and handle SIGSTOP now, so don't special case them
anymore in task_set_jobctl_pending().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/signal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 76d85830d4fa..5b75fbe3d2d6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -288,8 +288,7 @@ bool task_set_jobctl_pending(struct task_struct *task, unsigned long mask)
 			JOBCTL_STOP_SIGMASK | JOBCTL_TRAPPING));
 	BUG_ON((mask & JOBCTL_TRAPPING) && !(mask & JOBCTL_PENDING_MASK));
 
-	if (unlikely(fatal_signal_pending(task) ||
-		     (task->flags & (PF_EXITING | PF_IO_WORKER))))
+	if (unlikely(fatal_signal_pending(task) || (task->flags & PF_EXITING)))
 		return false;
 
 	if (mask & JOBCTL_STOP_SIGMASK)
-- 
2.31.0

