Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61D13ADA53
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 16:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhFSOMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 10:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhFSOMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 10:12:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15F1C061756
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 07:10:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e22so10554972wrc.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CUWJdjp8QRxQ/u+DTP4tjJp/xb4db7Dn4angKhvJAxI=;
        b=vrWLuh4KzKECdtkDHypvz5aUkJHB2FxS7IccXvXbvXhnwl7wr9nEmx7dapAGxWXyOq
         POFNHr2tl3dK9ORgnPTsymDwYi8iFXRhxL43cezdIhFvuJkE4dVkO+NNgAMMooWcHwST
         Cdyjkbwz2XyPFthDYvPr2C8xtTM8Gsz7BYPht8+2eMemoQz365pJMEgmvtz0NEneDtsT
         Wqa++GYLzRNIAGYXEiymcfiPZDQkU/QHqKWMESTvT9HeLzgw/HOzz79ynvRuDoskygUm
         PsTLzVkm785MAEsuVWWeTg/chW9vYY/rBy9CFFrEcYcp+eriKGvrgV1KkFFcV45CJVGg
         /+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUWJdjp8QRxQ/u+DTP4tjJp/xb4db7Dn4angKhvJAxI=;
        b=eGM24rie6Hoz6z6Ney8DsdD+vNg+Ma68Fl2KojQIZRUI5nY+k1sBQUkWwwFLV/YlWx
         Tkzun+2e+XV+V0TnrtTHZJdkYBvm9JDWF4BiWKyRFHyxfrGwBUJp7Km1vBQLb2EfLEPX
         1w6AcsRfFmJ0qtYb298HARhuYgW+hD8ZkudtMiYIp8VfUGlnpe8I5D8Ppud4WQo8zb7W
         cXwBr7IBubAsfeR8IKKyp9uXXm7UWcw6jo8xcblnM9g+1WYJDT5Bs24sumWxsCQQGQim
         au++iLnx3VyyKVpx1VZMiHj8MtfBg0lwrUPnWYAAw4okXs039vYy+H9zuPVfJsSNBaUj
         sqwA==
X-Gm-Message-State: AOAM530ZkbQRPd1aMkPmJ+g6DDfeHiR3AlsxuI30Sjjhlo5rFOc81NMi
        NtEjaCwJJYP45pmnaR+0J3B+jw==
X-Google-Smtp-Source: ABdhPJz9HbZuh3IYFmvsxSzG1M6ex6Z6ryX5xaHFq2NwNqNtB4gNcDxSr7WZAzp/jRDsKMAC2NSFhQ==
X-Received: by 2002:a5d:59a3:: with SMTP id p3mr18451225wrr.284.1624111808195;
        Sat, 19 Jun 2021 07:10:08 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id y16sm8379350wrp.51.2021.06.19.07.10.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jun 2021 07:10:07 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mariottiluca1@hotmail.it, holger@applied-asynchrony.com,
        pedroni.pietro.96@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH FIXES/IMPROVEMENTS 3/7] block, bfq: consider also creation time in delayed stable merge
Date:   Sat, 19 Jun 2021 16:09:44 +0200
Message-Id: <20210619140948.98712-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210619140948.98712-1-paolo.valente@linaro.org>
References: <20210619140948.98712-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 430a67f9d616 ("block, bfq: merge bursts of newly-created
queues"), BFQ may schedule a merge between a newly created sync
bfq_queue and the last sync bfq_queue created. Such a merging is not
performed immediately, because BFQ needs first to find out whether the
newly created queue actually reaches a higher throughput if not merged
at all (and in that case BFQ will not perform any stable merging). To
check that, a little time must be waited after the creation of the new
queue, so that some I/O can flow in the queue, and statistics on such
I/O can be computed.

Yet, to evaluate the above waiting time, the last split time is
considered as start time, instead of the creation time of the
queue. This is a mistake, because considering the split time is
correct only in the following scenario.

The queue undergoes a non-stable merges on the arrival of its very
first I/O request, due to close I/O with some other queue. While the
queue is merged for close I/O, stable merging is not considered. Yet
the queue may then happen to be split, if the close I/O finishes (or
happens to be a false positive). From this time on, the queue can
again be considered for stable merging. But, again, a little time must
elapse, to let some new I/O flow in the queue and to get updated
statistics. To wait for this time, the split time is to be taken into
account.

Yet, if the queue does not undergo a non-stable merge on the arrival
of its very first request, then BFQ immediately checks whether the
stable merge is to be performed. It happens because the split time for
a queue is initialized to minus infinity when the queue is created.

This commit fixes this mistake by adding the missing condition. Now
the check for delayed stable-merge is performed after a little time is
elapsed not only from the last queue split time, but also from the
creation time of the queue.

Fixes: 430a67f9d616 ("block, bfq: merge bursts of newly-created queues")
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c5c0e74977d4..2a5c1a660f3b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2711,7 +2711,9 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		if (bic->stable_merge_bfqq &&
 		    !bfq_bfqq_just_created(bfqq) &&
 		    time_is_before_jiffies(bfqq->split_time +
-					  msecs_to_jiffies(200))) {
+					  msecs_to_jiffies(200)) &&
+		    time_is_before_jiffies(bfqq->creation_time +
+					   msecs_to_jiffies(200))) {
 			struct bfq_queue *stable_merge_bfqq =
 				bic->stable_merge_bfqq;
 			int proc_ref = min(bfqq_process_refs(bfqq),
-- 
2.20.1

