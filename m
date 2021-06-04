Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3CF39C0F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhFDUCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:02:06 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:48705 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhFDUB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:01:59 -0400
Received: by mail-yb1-f201.google.com with SMTP id v63-20020a2561420000b029053606377441so13294362ybb.15
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 13:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=08ngW/6ouUjDi/wpMdVaPAEKWapsl3xNTLfVKkU+m5Y=;
        b=JDRTNf9J3ToOzwgDWEPGtKVPxO+kW3G7lO/Ja39i6iJVtmjdTC6z7d4SG0Nk34X17w
         Uw6MyFloGKyph4f73tQ88uuoVLDriLqHxKZJFNgWvRoLVOe7pkFv0xbugv+Y54ulivvF
         oZ2LTT+KwbktGUmNj8H3DGivs/PFnvronFpDpFHPCKdD94HrBZB63hP3V1YUeuqrlxw5
         VYGnxk+HH1++nT9zCh06Epc8xwbafe+8z5LV+5IKPfxX4XgOwUw9mdneMs/OPiMOqh2f
         mp/X0H0zkSjdfyWIfyFpV71FW39Rx0gLE1lzDE3RLp8AoDURCdiK3ZLZqLzNC8HLOJxE
         NF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=08ngW/6ouUjDi/wpMdVaPAEKWapsl3xNTLfVKkU+m5Y=;
        b=rEojNN4MkzwmH8+yDWX20t1rNPXMeL0TRCmTUwk9Qgv/zlTnsrbqwKTTpqwkQslmre
         trzVYLMQ4Fo5AMcFdlA16MTEzgJyA3qLLcjjP13nVGSo/hWaG0aBJGrVG93QXMfseDpB
         cyrWV59zdJlruju8lhRkrYoRHjA6gJI0BgG8zKNDXV4TSEqyoNrd+3tAtnhcBHkvI7nx
         Up4PmCY7oWnfsHhrZkv74m+ABngavI4zYtUbEpF4IF6iE/2X55OBW8aAMxsy+k/F0CeO
         8OE4BVVe7YZ54GFTkjYSyTEG0ufXVQ0lMVNR5Na/bXf1DN8MDNwyXN3g8fWWC6jP+d6L
         MZFg==
X-Gm-Message-State: AOAM530oaTT/un5ynSKa75rnybMOkiUWVcE0A9cjy5A20IEIOw/lPsSf
        UowWDWiVSWSDhzUjYwWe86FKJUi+95A=
X-Google-Smtp-Source: ABdhPJySrTkm2ZZQhHIET6BVacdS/IIJwe+EXCFPY8X8aCXyuEC7h3HWa6Hi7G41FKirusQld9i5BZkyqos=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:6b42:: with SMTP id o2mr7686789ybm.244.1622836752705;
 Fri, 04 Jun 2021 12:59:12 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:52 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-3-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 02/10] block: blk-crypto: introduce blk_crypto_bio_sectors_alignment()
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
bio is split. Introduce blk_crypto_bio_sectors_alignment() that returns the
required alignment in sectors. The number of sectors passed to any call of
bio_split() must be aligned to blk_crypto_bio_sectors_alignment().

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto-internal.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 0d36aae538d7..7f1535cc7e7c 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -60,6 +60,21 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return rq->crypt_ctx;
 }
 
+/*
+ * Returns the alignment requirement for the number of sectors in this bio based
+ * on its bi_crypt_context. Any bios split from this bio must follow this
+ * alignment requirement as well. Note that a bio must contain a whole number of
+ * crypto data units (which is selected by the submitter of bio), since
+ * encryption/decryption can only be performed on a complete crypto data unit.
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
@@ -93,6 +108,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
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
2.32.0.rc1.229.g3e70b5a671-goog

