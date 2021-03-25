Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC755349B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhCYV1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhCYV1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:16 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0F8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:16 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id s14so4076647qtw.20
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jcwCmvL2zf0lF3Ank04XNaFIuqNE6u2MJVhR/WWQGZc=;
        b=fUGJmbUcJs9LLuwYxYrtUvHLhM1TcSpAOUXmXU9i7ZnDvC+dagbI2nRWiKwSzhKIn6
         J2TpCtBOE35vXBCihxWEoeINPTXBVETVHLvpHO2733KVglleDWVzIJryyi32kWjj+nP6
         YWdKtTHMviMBZFfEpcz7H+m/aZzW2qRD0u6jIUMv9IZAR8iixPQJaqco0CUSkUewAmHs
         X9UEZpJes0lwNIZdwASUbOtV7WpZVWPE2WLSwgNbEhr97VbdgNEr/YGq6BOOoDSZHi7e
         GeRiDIF/hZPeQo4HSjSsd7RD21QbbVFei8tLUMSo4UI6bfEa9gryrW23GJeBK4/nos4P
         yC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jcwCmvL2zf0lF3Ank04XNaFIuqNE6u2MJVhR/WWQGZc=;
        b=KR34s+lIE5Ecuzq1pmy1E7Hpff/gbbc5ghICkvKQS4c+wp0gA5OPfBiOUP4ffKMAT4
         /5mfxzZlwu4wq19stGnQbGhi6a5yqLp6d+Kxn59Zs3+K/zxiBlZytakzE5EV8CLRzNUQ
         vc/PWL6iR47Gl0tZBjN6W8VSQ1/179jhyic8tpW/D7cLy5qJ5Log5Kcn/ZZHCG4ui7rH
         tXa+BnOrBZ2HvKNjyEbu/bx69x319QOXeKIBz3skesBJNLA/CAlxzO6dfdF0WRyc3VD2
         9r2QMy6lljsUASEjT05KOF7NV+2SXDWOoWRxhYiNx2mkrQEiFZaMXWnixR2o8qMFga9t
         kW0Q==
X-Gm-Message-State: AOAM530vBTR7AMHV5l7cxjQngaYpu3V2ODGV5LU4jFXXgjjHhNPwflWy
        BQY3mJ/9Zz6wrt/bDxPNsEF6nMHNaXE=
X-Google-Smtp-Source: ABdhPJxIQ06W5lmnWE4BuGBz9AJvw51tzkMUBqKwdv/PcZO7ZgbD/Nw38wjPFr6N5rLFbrNgkw8F4v3Hn4I=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a0c:c345:: with SMTP id j5mr10335420qvi.52.1616707635674;
 Thu, 25 Mar 2021 14:27:15 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:05 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-5-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 4/8] block: introduce bio_required_sector_alignment()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function returns the required alignment for the number of sectors in
a bio. In particular, the number of sectors passed to bio_split() must be
aligned to this value.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 3b53e44b967e..5ef207a6d34c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -261,6 +261,18 @@ static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
 	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
 }
 
+/*
+ * The required sector alignment for a bio. The number of sectors in any bio
+ * that's constructed/split must be aligned to this value.
+ */
+static inline unsigned int bio_required_sector_alignment(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+
+	return max(queue_logical_block_size(q) >> SECTOR_SHIFT,
+		   blk_crypto_bio_sectors_alignment(bio));
+}
+
 /*
  * The max bio size which is aligned to q->limits.discard_granularity. This
  * is a hint to split large discard bio in generic block layer, then if device
-- 
2.31.0.291.g576ba9dcdaf-goog

