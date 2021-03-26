Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F394349E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCZAlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCZAkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:40:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3521FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 17:40:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q5so3714776pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 17:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5VFZ5F0P95MRNgw+SRJmF8MhV5XYlr1esTCnEdLFx4o=;
        b=qVdGD1kJFYnAUL/8agkIHKHlk1DUiRz/niBuNGe2UQqFQxOaqLAmr4dB+ZfmgViGhj
         6BdzWJQvFrBv0zBVncmzEtVO6+ntgLQNq/e6opxduxqeOV3F/BkYCCu3UY0JnIgNdXm/
         003pMD1vav2qydRplabfZtOyW27RspJXnw0e9Jahwhaw0DxUmz9YSk06kdr+IWYolcfi
         Sph+LTQAm/wa5UXt+EbeCdh+SEhIBmlsASSBe8c5pocCfQUfYxuHjQGtHGZpTRtvPnIc
         WHFOXTk3pHhxJUGI+1rHlBvH4BD5aHn2nojKPVT9p2mTaZkl4SYJlWhxyybf34Jte5xv
         i+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5VFZ5F0P95MRNgw+SRJmF8MhV5XYlr1esTCnEdLFx4o=;
        b=lmuqVcvawLy44kcUCyHdBdQZp0CL9IgDUVYBzjjvZWOcNoTLDvFYffP/+QVfl9mt3l
         17cihyWh0N7U1aG0igmvnwy7Ua9jpIBHCdVSfGGwKuE9jTHqZuzeS5yBczpjICEp9ScZ
         zcoAemgQfuN1tNbjF63zkqN4t4Wgw3eoM9dLgdutzxZG3uml9IZFZl6pmCt2M83Lr9as
         5d7KCRH/RskYQe1oqI81SHs0i7SmI0hpGoZoO/h2vGqtjXqHHn/FwwDb4XAyptC9FPQt
         WB81WrZin0tLi2DIkEWv1BDD7Q0AtmTqULRBIjgYH15kWumFzwq0YaEbeHcWKxQ+uNyT
         FQkw==
X-Gm-Message-State: AOAM530y1l3HJE12I1rEy4ckikLC4CNakn2bvi2rFPuF0HF6qO5jF3Jg
        3cgLjzL2r1nsXDRAu/DsQ4l5MYuPcmYAfg==
X-Google-Smtp-Source: ABdhPJxFVacuwBUxGD4VWOgd1yUZQMHk67UTiQd7TPnQ2Ns3/JLb81YEYG2HgwV/He+GCLmRfaOJ2Q==
X-Received: by 2002:a63:e511:: with SMTP id r17mr9835094pgh.163.1616719252790;
        Thu, 25 Mar 2021 17:40:52 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id c128sm6899448pfc.76.2021.03.25.17.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 17:40:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/8] Revert "signal: don't allow STOP on PF_IO_WORKER threads"
Date:   Thu, 25 Mar 2021 18:39:29 -0600
Message-Id: <20210326003928.978750-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326003928.978750-1-axboe@kernel.dk>
References: <20210326003928.978750-1-axboe@kernel.dk>
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
index 8ce96078cb76..5ad8566534e7 100644
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

