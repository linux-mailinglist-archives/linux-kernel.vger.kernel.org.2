Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABE845E086
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 19:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243869AbhKYS2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhKYS0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:26:42 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE49C06179F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 10:15:35 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i5so13463240wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=inO6jIjK3rQRPwBL9Ici1X1qJ/cy0Yk98kVCPaWsp68=;
        b=t4uXEuxkOHoTbV8nya1plg8cmPANA1SoyzQ9cmhu2Cxu8Qihi9L49TSaQh8aohv0K3
         bLWyMLebDLdm67LZXQOPcWJEgsGBB9dKD6WiOLelTNC4y/dE1U2Obdg8px67W17NRBSA
         +a4k6b1/oNJ4XQdp+kdtRjRtbQtLNjoWmwY/3qnZkLsHCQwMikOjnhRPVctPoXxYPgt3
         2us9jtwi9KrQY6hH7oG6sHLJHxOyZNvC7UR0fMeXfneb19fbqPnrXexgfSePQA+4HlhB
         VSV/I98ggzQnPqs2UuZjMpiBxrq3M9bNSagy5rAMkV3ihoJHfAE4btx0l6fD7c2w/W4p
         bVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=inO6jIjK3rQRPwBL9Ici1X1qJ/cy0Yk98kVCPaWsp68=;
        b=VTD01OFUNcRWcYqWW8g7p7MDpA/OYLbb6ybN21Q1hZutnzSZ39pjQ3SqtPAZCMmQPo
         /4jsQZ2re6V56RMLuiZV6vhlzy5vls/UuJCN7W6rkv1wlDq3r5qz7HnwOOt/eyGFYxRT
         vbRRe9GPGf8fszzVoICOXktuZL+FQikHBQT4qj9nYqounQpt6upqznC84Cjl5tBuxXf9
         KIZwPvBYroW10g1KpVPDkUKqKCWLw2ekhmUlfbyScnHB5NpxAmVGwhz4+YUl0FmCgJM0
         KO9r6FewvHagKdwzzsd9LuuC7rySNgs/L4SFIL9M7j1ZXAWSlxgFysFSnrU5QaB6bLYI
         q2gw==
X-Gm-Message-State: AOAM530z5wlbU1+AfCqNUrDTvAEUYnDuC9nRSFtFi4IvcqfvUA4Vh4us
        YH1w6+gqWivJ6/GxR0cjPeMEc84xseB75Q==
X-Google-Smtp-Source: ABdhPJyVMsE/f3rEOdnViheMFj+P0EevMOc16K7bRxokSMF3sfwfoZ6HIERgeSblQcMqXjD1g6AfRQ==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr8483692wrq.71.1637864133738;
        Thu, 25 Nov 2021 10:15:33 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id s8sm3529496wro.19.2021.11.25.10.15.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Nov 2021 10:15:33 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        =?UTF-8?q?Holger=20Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>
Subject: [PATCH] Revert "Revert "block, bfq: honor already-setup queue merges""
Date:   Thu, 25 Nov 2021 19:15:10 +0100
Message-Id: <20211125181510.15004-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A crash [1] happened to be triggered in conjunction with commit
2d52c58b9c9b ("block, bfq: honor already-setup queue merges"). The
latter was then reverted by commit ebc69e897e17 ("Revert "block, bfq:
honor already-setup queue merges""). Yet, the reverted commit was not
the one introducing the bug. In fact, it actually triggered a UAF
introduced by a different commit, and now fixed by commit d29bd41428cf
("block, bfq: reset last_bfqq_created on group change").

So, there is no point in keeping commit 2d52c58b9c9b ("block, bfq:
honor already-setup queue merges") out. This commit restores it.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=214503

Reported-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fec18118dc30..7cde7a11c42b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2662,6 +2662,15 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
 	 * are likely to increase the throughput.
 	 */
 	bfqq->new_bfqq = new_bfqq;
+	/*
+	 * The above assignment schedules the following redirections:
+	 * each time some I/O for bfqq arrives, the process that
+	 * generated that I/O is disassociated from bfqq and
+	 * associated with new_bfqq. Here we increases new_bfqq->ref
+	 * in advance, adding the number of processes that are
+	 * expected to be associated with new_bfqq as they happen to
+	 * issue I/O.
+	 */
 	new_bfqq->ref += process_refs;
 	return new_bfqq;
 }
@@ -2724,6 +2733,10 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	struct bfq_queue *in_service_bfqq, *new_bfqq;
 
+	/* if a merge has already been setup, then proceed with that first */
+	if (bfqq->new_bfqq)
+		return bfqq->new_bfqq;
+
 	/*
 	 * Check delayed stable merge for rotational or non-queueing
 	 * devs. For this branch to be executed, bfqq must not be
@@ -2825,9 +2838,6 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (bfq_too_late_for_merging(bfqq))
 		return NULL;
 
-	if (bfqq->new_bfqq)
-		return bfqq->new_bfqq;
-
 	if (!io_struct || unlikely(bfqq == &bfqd->oom_bfqq))
 		return NULL;
 
-- 
2.20.1

