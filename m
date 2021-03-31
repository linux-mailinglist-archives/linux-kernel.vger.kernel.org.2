Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADF2349B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhCYV1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhCYV1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F852C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:14 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id j4so4917703pgs.18
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QKM/4VqqpmQG/v1vBmAPZ1ISyc7q5p1Ut3IkXJNTNn8=;
        b=HnZP67MIz1eIz5tJHXkYxrlB8XA9q1/hNkdl64gZMD8f1fs8z86c1elcZMmZdB/nuX
         6P9jm3LlxYD5GOYi1ujnffTpXxivasaXLyKswn65Ol5OPrEAi4wI+/A+FnJp6E0f8D5X
         3pyybitU+IYLhnjIw91JgrNv00utQRdL1aJ2lqJk0Oq1pQ/DH9vwu2ndEp9NpmewwOm5
         rYqa+yhnRYdPlvSaHasT2eg0tUjqw7DT+LVWuIja4ZNs7XWUzSFNovoUHtL76JTah/x5
         LEudfg6bZ1EC6cESObW51z9UUaOazOTGb56yvMbwSYZtgrDGBpxLWOJWOLP9huNS/pv6
         Ud3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QKM/4VqqpmQG/v1vBmAPZ1ISyc7q5p1Ut3IkXJNTNn8=;
        b=Gt1g3vnQJB6ab544OdHCMVmKjxkq3ax6JNIDIipY4dFmBD4BXq0jD3p9RqiL0xqB07
         Ucw7YSR51k+qcqeCOcx59mkdNZLvxTskLIUMidzttDRyDPWHWVR81il2XFQZvsJ0s3Pr
         oyirfrRn87i/ENDMVb8IxvKMPHuX2mFvaiE0WVnqI4Sws/rtD5S2cqQBTzf+6VEhXENE
         EyCIbkAO247gZWkZbvvkVZE9NzNO+O/Imcgbb2ATDss810U7tOUviv8QeFVg40iSk5r6
         6txq/bSxdqsEmZ2QidvnHg3IQ36IvvZ9DrlD4eyicUNSLUUMjVZVf5gsqtMkbzC3mrcu
         OK+A==
X-Gm-Message-State: AOAM531wrx8NPS28VM9uHGnUhqN32rBksnRz7+F9swxTL0fhq1yfu479
        wYN5AF7mlBSybRpuvGKR/h6NIrk3pSY=
X-Google-Smtp-Source: ABdhPJzjoTfGpe0TgBdqASEdyBajTp1H9OebPba0STb+/HWBLKkUrFjrqDgv+AdBd422n4nIJ88hy9WUxEg=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:902:56c:b029:e7:1052:a7c6 with SMTP id
 99-20020a170902056cb02900e71052a7c6mr11045345plf.75.1616707633890; Thu, 25
 Mar 2021 14:27:13 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:04 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-4-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 3/8] block: blk-crypto: introduce blk_crypto_bio_sectors_alignment()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of any bio must be aligned to the data unit size of the bio crypt
context (if it exists) of that bio. This must also be ensured whenever a
bio is split. Introduce blk_crypto_bio_sectors_alignment() that returns
the required alignment in sectors. The number of sectors passed to
any call of bio_split() should be aligned to
blk_crypto_bio_sectors_alignment().

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto-internal.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 0d36aae538d7..304e90ed99f5 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -60,6 +60,19 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return rq->crypt_ctx;
 }
 
+/*
+ * Returns the alignment requirement for the number of sectors in this bio based
+ * on its bi_crypt_context. Any bios split from this bio must follow this
+ * alignment requirement as well.
+ */
+static inline unsigned int blk_crypto_bio_sectors_alignment(struct bio *bio)
+{
+	if (!bio_has_crypt_ctx(bio))
+		return 1;
+	return bio->bi_crypt_context->bc_key->crypto_cfg.data_unit_size >>
+								SECTOR_SHIFT;
+}
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline bool bio_crypt_rq_ctx_compatible(struct request *rq,
@@ -93,6 +106,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return false;
 }
 
+static inline unsigned int blk_crypto_bio_sectors_alignment(struct bio *bio)
+{
+	return 1;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes);
-- 
2.31.0.291.g576ba9dcdaf-goog

