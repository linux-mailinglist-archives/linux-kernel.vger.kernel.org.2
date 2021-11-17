Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23049454E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 21:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhKQULb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 15:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhKQULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 15:11:30 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241E5C061570;
        Wed, 17 Nov 2021 12:08:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 28so3224962pgq.8;
        Wed, 17 Nov 2021 12:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GuvZ+/5l3VJBNbmV09LhQ5oeDNCPaizJNAWc37b2H8=;
        b=cYdsQubanS/IiExq+eRSmm0WQ8TRkxUoF/o9zXQzMEP1Fc15w3Y9Wb2DXEwKIkDe71
         s5sV+kY5vSBJROp/fJl9iBgPmJEWMrTLpymwtnxiJG6gyA6fpRAzrBgZ5rTtb0146VIj
         aidnJTSfesX64akyXwdla8N+9IakL/OG3HG/uN1Fld3zYb73evjmFdiSzl2hY/F2ZJMJ
         eyZIWmLl4TmvWGHlA6uOSRYtAn3vq92eFsnbQfJkh/kEnDK3L6yjzYlBZnOitdWRT/HQ
         ZHdxkPqhdiTx+++FP6KbJDUt2NudDiQj+T8gnWYYSHzgm05lC340djzbQbgDJJ6Lsshk
         RqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GuvZ+/5l3VJBNbmV09LhQ5oeDNCPaizJNAWc37b2H8=;
        b=6i3h0pTM0WMF0ugAcMY0i+scyJT9D/VK6+1rMh3n0NXYbIU1Uh6Hh01ey2NkRjElGp
         Y1HsQdVL2NG8zNv8gheArEKnQuG7WhL7jRa42aU8LHNxsv5SZy7e8J7eNPg2v3UpCGnM
         q4c6cfN1CtOID0bw/CrTQOnRNF9gkP8NI7suTcSpoTYUL5yhFlNKPJ69ktm+6n00hPD+
         nYBsxAnD1bfqjcORKbGPgFwjmXTLfdY0IzSfIQuoPodG56RnSWvOT5kwGjkWMUir4diS
         2boRF3N7OZ0fVA24YNJuulkb2wuweCQDDAU32fFgoLNqSUih9cSylGCfuteOjfetLb75
         1T4g==
X-Gm-Message-State: AOAM531HeEzKb8pg+8yEAJPRAEnIdl2vd6OShEzwdGgIa0DBQN0KvJKs
        HJP8EyTfFHxyzsy9AEJTu2c=
X-Google-Smtp-Source: ABdhPJwXIjI722DqhISpgR/HES79leb7TJn8tU65FQeA8OBrIvYgWAK6TuWNF9Vn/MWcEc7RfIV0tw==
X-Received: by 2002:a05:6a00:a8b:b0:44d:ef7c:94b9 with SMTP id b11-20020a056a000a8b00b0044def7c94b9mr9578061pfl.36.1637179710502;
        Wed, 17 Nov 2021 12:08:30 -0800 (PST)
Received: from nickserv.localdomain (c-98-35-167-56.hsd1.ca.comcast.net. [98.35.167.56])
        by smtp.gmail.com with ESMTPSA id rm1sm6511050pjb.3.2021.11.17.12.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:08:30 -0800 (PST)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/3] lib: zstd: Fix unused variable warning
Date:   Wed, 17 Nov 2021 12:14:57 -0800
Message-Id: <20211117201459.1194876-2-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117201459.1194876-1-nickrterrell@gmail.com>
References: <20211117201459.1194876-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

The variable `litLengthSum` is only used by an `assert()`, so when
asserts are disabled the compiler doesn't see any usage and warns.

This issue is already fixed upstream by PR #2838 [0]. It was reported
by the Kernel test robot in [1].

Another approach would be to change zstd's disabled `assert()`
definition to use the argument in a disabled branch, instead of
ignoring the argument. I've avoided this approach because there are
some small changes necessary to get zstd to build, and I would
want to thoroughly re-test for performance, since that is slightly
changing the code in every function in zstd. It seems like a
trivial change, but some functions are pretty sensitive to small
changes. However, I think it is a valid approach that I would
like to see upstream take, so I've opened Issue #2868 to attempt
this upstream.

[0] https://github.com/facebook/zstd/pull/2838
[1] https://lore.kernel.org/linux-mm/202111120312.833wII4i-lkp@intel.com/T/
[2] https://github.com/facebook/zstd/issues/2868

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 lib/zstd/compress/zstd_compress_superblock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/zstd/compress/zstd_compress_superblock.c b/lib/zstd/compress/zstd_compress_superblock.c
index ee03e0aedb03..b0610b255653 100644
--- a/lib/zstd/compress/zstd_compress_superblock.c
+++ b/lib/zstd/compress/zstd_compress_superblock.c
@@ -411,6 +411,8 @@ static size_t ZSTD_seqDecompressedSize(seqStore_t const* seqStore, const seqDef*
     const seqDef* sp = sstart;
     size_t matchLengthSum = 0;
     size_t litLengthSum = 0;
+    /* Only used by assert(), suppress unused variable warnings in production. */
+    (void)litLengthSum;
     while (send-sp > 0) {
         ZSTD_sequenceLength const seqLen = ZSTD_getSequenceLength(seqStore, sp);
         litLengthSum += seqLen.litLength;
-- 
2.33.1

