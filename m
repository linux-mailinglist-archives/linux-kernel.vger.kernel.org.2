Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B8532D8ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbhCDRrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbhCDRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:46:36 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC73C0613E4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:45:31 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n22so8841768wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 09:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZifMIAy4GGWpMtKfD5bvrDinqLUVzewXwC0UEUTmlwY=;
        b=PjYZ1GpCiBD4K0H0z8sr3//ABAf+ulr3tGusEeh/C3izrUkvaloOjyfQ51rrogquga
         oec8/6rWVQytHyJkUvjAGG19+tBG0Ad06w/eHjy27k0uAgQz1EImxVuoHri2/H5eIMmD
         pxA3q41/6l3VlgRlHp8grI2tIX68AVyokEPXVmjsb0SSunZwNdCT0WUGxqpufHvZTyFt
         alRqne7tAZ/ZNOKDrGRYslmEXLDGiwreqLy7nuInIBl9F2+3+K/GkGU/zZJwGlehre+y
         Kqa+vQaSnmxtfUJt+bVk3SOV8T4WOfLZAaROCswwZkOx4pMHBd/KiInH3c8ITBjsUuqc
         c9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZifMIAy4GGWpMtKfD5bvrDinqLUVzewXwC0UEUTmlwY=;
        b=QrIoAn7Bg7f4vHfG3bu3DH2wIOdQUCpj0PKuZvjsCzOsj88tSaQyMvsoOmcsx7j5JH
         wic3lD5M5SlniT4XxexEutrvnPzSejWX1MRD0ks5941QRR7TFyzVoPpvy2L734d804W9
         ICOeq03tEx/SyO+qVHwtutrm7ga73q91Iy7aOYev9LDxz6U1jHwP6BD4X725b5JVHv45
         byoM1IS4UxuNUOtGcTcyBM+4I5OjGHxCGVftMJeFQWdS4wqukreic1+lX7ncaUfUnC1T
         rrutrWGtOAgP4um6/SxnH1oovYsrMRALoMdTjY6NLt5YtcHE3qqQ/2dIYhdAvZ1Q3nND
         yFqg==
X-Gm-Message-State: AOAM5332AQp1IlevoGqUL1Yt3kDjy0oJqiCDSBEGWfCmhBTx42a+GHbk
        8mzf/ZtoS739BVYSpVYmzaarPFW3zkD/dA==
X-Google-Smtp-Source: ABdhPJwSrAkfUofaXmnIahdY/3otBrfJ8ZpCF9gnb8mBk0i69W/Y3UzlbotwhW3L0SirKLRbithIEg==
X-Received: by 2002:a1c:1d14:: with SMTP id d20mr5146554wmd.36.1614879930430;
        Thu, 04 Mar 2021 09:45:30 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id a21sm271023wmb.5.2021.03.04.09.45.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Mar 2021 09:45:30 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT V2 4/6] block, bfq: fix weight-raising resume with !low_latency
Date:   Thu,  4 Mar 2021 18:46:25 +0100
Message-Id: <20210304174627.161-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210304174627.161-1-paolo.valente@linaro.org>
References: <20210304174627.161-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the io_latency heuristic is off, bfq_queues must not start to be
weight-raised. Unfortunately, by mistake, this may happen when the
state of a previously weight-raised bfq_queue is resumed after a queue
split. This commit fixes this error.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4b3d4849f3f5..8497d0803d74 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1010,7 +1010,7 @@ static void
 bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 		      struct bfq_io_cq *bic, bool bfq_already_existing)
 {
-	unsigned int old_wr_coeff = bfqq->wr_coeff;
+	unsigned int old_wr_coeff = 1;
 	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
 
 	if (bic->saved_has_short_ttime)
@@ -1031,7 +1031,13 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 	bfqq->ttime = bic->saved_ttime;
 	bfqq->io_start_time = bic->saved_io_start_time;
 	bfqq->tot_idle_time = bic->saved_tot_idle_time;
-	bfqq->wr_coeff = bic->saved_wr_coeff;
+	/*
+	 * Restore weight coefficient only if low_latency is on
+	 */
+	if (bfqd->low_latency) {
+		old_wr_coeff = bfqq->wr_coeff;
+		bfqq->wr_coeff = bic->saved_wr_coeff;
+	}
 	bfqq->service_from_wr = bic->saved_service_from_wr;
 	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
 	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish;
-- 
2.20.1

