Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044AF3ADA54
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 16:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhFSOMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 10:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbhFSOMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 10:12:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CD2C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 07:10:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso10565144wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7Yg6vvsf1aIcxdCOdZYfNc6DhT8YLAwUuHHaXJpVvk=;
        b=QoKb8ncn4vyQjGUUA7s5y8TaDHX5t21rOTW2XELQh2bxIwf0w16+o2YPHNnKUnIb4u
         FKj3ktR1dWpzY69xSQ/ZTZYUsdq7M+/HlWhn8kLm7Pwd1q0kZ96Yn11xpr+CkDbqmg0d
         wQQRxy8S7EAX5UQPaQANNQZZ5cSEDnnRXljUN8mn0PPf7GHhRl/wUzXh0ynR4XvG3gkG
         q3tReu9Ivs4yKH6So++SERRU8+QSvRBQNMgqXB2stAReg4FNA/W9jkJUApJww9E5QaVF
         p4ppNbIiYRv91tPXLa2Lk0hamkaN2zzsZ2SUPbqgnNmXF/GgUMM4XN/WF2mIrD7Y1CBA
         16Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7Yg6vvsf1aIcxdCOdZYfNc6DhT8YLAwUuHHaXJpVvk=;
        b=s5H0J5yCINPb9V558oL07dUHR4x1dm+ZtehsYY0Cb9boiBkNzWAkd06XEJTzWgyxhI
         yI1jSDqeIgRnDwY0fE5Phuj6tWke36QxJKwW4v54SHggSsof3ajTIGW5sOmi2RNzrvVZ
         UZ74rnueogZYmSbVTNo999qDkvBxZia42E9GPE5IZVM1ZHziubbu0j2Af4eDLhgqwu4X
         BsNE6HNvn/uU1kBVYrCzVJu0fWhR8+UA59heyrU8DVT65XcL+TLrpZnaEAH7M0W/kku3
         8Igs+YTr3scwF+wexIoy5ahMAQpR0YVMMWyP4VhjG7ILorbX1pIkoeqwsR0g57sdzWI+
         ShhQ==
X-Gm-Message-State: AOAM533AoWtJnoncHamEzYOOw/X23JTwMcyXfCPo+1akhcMCK95t4PqD
        zaQf12bbf2rovZYZV9CcpT6TOwikXun40g==
X-Google-Smtp-Source: ABdhPJzzFiN0cGpugRqiSLVtrSj3RfAxbZ4ef7Y0A1/owXURJbvFWD3IIkIgAIJoThtOY8onAyhUtA==
X-Received: by 2002:a05:600c:a01:: with SMTP id z1mr16703219wmp.77.1624111809427;
        Sat, 19 Jun 2021 07:10:09 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id y16sm8379350wrp.51.2021.06.19.07.10.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jun 2021 07:10:08 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mariottiluca1@hotmail.it, holger@applied-asynchrony.com,
        pedroni.pietro.96@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH FIXES/IMPROVEMENTS 4/7] block, bfq: boost throughput by extending queue-merging times
Date:   Sat, 19 Jun 2021 16:09:45 +0200
Message-Id: <20210619140948.98712-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210619140948.98712-1-paolo.valente@linaro.org>
References: <20210619140948.98712-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pietro Pedroni <pedroni.pietro.96@gmail.com>

One of the methods with which bfq boosts throughput is by merging queues.
One of the merging variants in bfq is the stable merge.
This mechanism is activated between two queues only if they are created
within a certain maximum time T1 from each other.
Merging can happen soon or be delayed. In the second case, before
merging, bfq needs to evaluate a throughput-boost parameter that
indicates whether the queue generates a high throughput is served alone.
Merging occurs when this throughput-boost is not high enough.
In particular, this parameter is evaluated and late merging may occur
only after at least a time T2 from the creation of the queue.

Currently T1 and T2 are set to 180ms and 200ms, respectively.
In this way the merging mechanism rarely occurs because time is not
enough. This results in a noticeable lowering of the overall throughput
with some workloads (see the example below).

This commit introduces two constants bfq_activation_stable_merging and
bfq_late_stable_merging in order to increase the duration of T1 and T2.
Both the stable merging activation time and the late merging
time are set to 600ms. This value has been experimentally evaluated
using sqlite benchmark in the Phoronix Test Suite on a HDD.
The duration of the benchmark before this fix was 111.02s, while now
it has reached 97.02s, a better result than that of all the other
schedulers.

Signed-off-by: Pietro Pedroni <pedroni.pietro.96@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 2a5c1a660f3b..98a42ddb1760 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -364,6 +364,16 @@ static int ref_wr_duration[2];
  */
 static const unsigned long max_service_from_wr = 120000;
 
+/*
+ * Maximum time between the creation of two queues, for stable merge
+ * to be activated (in ms)
+ */
+static const unsigned long bfq_activation_stable_merging = 600;
+/*
+ * Minimum time to be waited before evaluating delayed stable merge (in ms)
+ */
+static const unsigned long bfq_late_stable_merging = 600;
+
 #define RQ_BIC(rq)		icq_to_bic((rq)->elv.priv[0])
 #define RQ_BFQQ(rq)		((rq)->elv.priv[1])
 
@@ -2711,9 +2721,9 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		if (bic->stable_merge_bfqq &&
 		    !bfq_bfqq_just_created(bfqq) &&
 		    time_is_before_jiffies(bfqq->split_time +
-					  msecs_to_jiffies(200)) &&
+					  msecs_to_jiffies(bfq_late_stable_merging)) &&
 		    time_is_before_jiffies(bfqq->creation_time +
-					   msecs_to_jiffies(200))) {
+					   msecs_to_jiffies(bfq_late_stable_merging))) {
 			struct bfq_queue *stable_merge_bfqq =
 				bic->stable_merge_bfqq;
 			int proc_ref = min(bfqq_process_refs(bfqq),
@@ -5494,7 +5504,7 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 	 */
 	if (!last_bfqq_created ||
 	    time_before(last_bfqq_created->creation_time +
-			bfqd->bfq_burst_interval,
+			msecs_to_jiffies(bfq_activation_stable_merging),
 			bfqq->creation_time) ||
 		bfqq->entity.parent != last_bfqq_created->entity.parent ||
 		bfqq->ioprio != last_bfqq_created->ioprio ||
-- 
2.20.1

