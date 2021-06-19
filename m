Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043473ADA55
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhFSOMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 10:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbhFSOM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 10:12:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4722C0617A8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 07:10:13 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so80719wms.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1+zxMsyMPSpH6r8mTDKIRiZovSCCqL71anJFuwMZ+iY=;
        b=oh/2TLAlejpV4LagMn+tCDQUivZCaMX6ouGYYCbwM64s4OHfAjHgMLwDq7E41Mgasr
         N5YY076yGSO9yRwim8Qvt0ctOcGLox0xZ0Zwkgus7eWPlvOu0yFLane8G/KZzP6fATz1
         QPxFTMvnyLPhCg/rhmVnGJydUQ0lBP39ezf70n4m+4VN6z4FyDb6Nxk5c8LvNEpl60iy
         eWEiOrBMBPj5e1y+2OK7+uPFR8chQmJdekqhw8qCQSOFoMzbGCpEPySvv1w8iEySZXd+
         ldu74XvzoVyebfCwpuOG97ob97xkbiYwOdWmmUhh++SP3/vjsc7jM6+ZjGynBy+MyP4E
         5GKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+zxMsyMPSpH6r8mTDKIRiZovSCCqL71anJFuwMZ+iY=;
        b=sI3nJ772ppXQzrCWFFt3og0qK39dezBg+rgVXmzE79nmnvkgfQ/fFVZ3ULsr/7Wvce
         YUhtzQ0T24dQghQieXTMCDFNknNniAEVdLriEy1H/iORB4hCDwKVfG9cq4pDKvTgjRSz
         2Cq+qM/9yz6LGZ3pxqXZOHFq6keoqT/NMtFdGI4KGPxjsAI2uYwktCYAzsbmJm5PJo39
         lKxlEgnWEjYMfbpDJnG/daW7iqwjyVFhzZ/H6ryG3A9CV8PRXiRofoa//CExUNiFIAcG
         O69J2tyqMLm48+jv3FOQj5W9jDGqRJgp0cxgVbtHBkw+Wsyz9KQpwCImqTDwuRKp73dS
         gOoA==
X-Gm-Message-State: AOAM532J6Z+UznrUBCPzYW7uU8jdVuXOqXfSsgQHbJ+dNLiP6PadO19F
        OfZPifMRdD5v9rKtQPuHN0EsaQ==
X-Google-Smtp-Source: ABdhPJyS9F4ENGYjmIXEjls6BZ92TAXa5wPq1KIzlddlnkDZRmM4fxUhzr20ifQ/PO2ulFMHRsKJlg==
X-Received: by 2002:a05:600c:3594:: with SMTP id p20mr16548904wmq.52.1624111811778;
        Sat, 19 Jun 2021 07:10:11 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id y16sm8379350wrp.51.2021.06.19.07.10.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jun 2021 07:10:11 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mariottiluca1@hotmail.it, holger@applied-asynchrony.com,
        pedroni.pietro.96@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH FIXES/IMPROVEMENTS 6/7] block, bfq: check waker only for queues with no in-flight I/O
Date:   Sat, 19 Jun 2021 16:09:47 +0200
Message-Id: <20210619140948.98712-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210619140948.98712-1-paolo.valente@linaro.org>
References: <20210619140948.98712-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider two bfq_queues, say Q1 and Q2, with Q2 empty. If a request of
Q1 gets completed shortly before a new request arrives for Q2, then
BFQ flags Q1 as a candidate waker for Q2. Yet, the arrival of this new
request may have a different cause, in the following case. If also Q2
has requests in flight while waiting for the arrival of a new request,
then the completion of its own requests may be the actual cause of the
awakening of the process that sends I/O to Q2. So Q1 may be flagged
wrongly as a candidate waker.

This commit avoids this deceptive flagging, by disabling
candidate-waker flagging for Q2, if Q2 has in-flight I/O.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7bf073ef9443..a273b2bcea2a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1985,14 +1985,18 @@ static void bfq_update_io_intensity(struct bfq_queue *bfqq, u64 now_ns)
  * Turning back to the detection of a waker queue, a queue Q is deemed
  * as a waker queue for bfqq if, for three consecutive times, bfqq
  * happens to become non empty right after a request of Q has been
- * completed. In particular, on the first time, Q is tentatively set
- * as a candidate waker queue, while on the third consecutive time
- * that Q is detected, the field waker_bfqq is set to Q, to confirm
- * that Q is a waker queue for bfqq. These detection steps are
- * performed only if bfqq has a long think time, so as to make it more
- * likely that bfqq's I/O is actually being blocked by a
- * synchronization. This last filter, plus the above three-times
- * requirement, make false positives less likely.
+ * completed. In this respect, even if bfqq is empty, we do not check
+ * for a waker if it still has some in-flight I/O. In fact, in this
+ * case bfqq is actually still being served by the drive, and may
+ * receive new I/O on the completion of some of the in-flight
+ * requests. In particular, on the first time, Q is tentatively set as
+ * a candidate waker queue, while on the third consecutive time that Q
+ * is detected, the field waker_bfqq is set to Q, to confirm that Q is
+ * a waker queue for bfqq. These detection steps are performed only if
+ * bfqq has a long think time, so as to make it more likely that
+ * bfqq's I/O is actually being blocked by a synchronization. This
+ * last filter, plus the above three-times requirement, make false
+ * positives less likely.
  *
  * NOTE
  *
@@ -2018,6 +2022,7 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (!bfqd->last_completed_rq_bfqq ||
 	    bfqd->last_completed_rq_bfqq == bfqq ||
 	    bfq_bfqq_has_short_ttime(bfqq) ||
+	    bfqq->dispatched > 0 ||
 	    now_ns - bfqd->last_completion >= 4 * NSEC_PER_MSEC ||
 	    bfqd->last_completed_rq_bfqq == bfqq->waker_bfqq)
 		return;
-- 
2.20.1

