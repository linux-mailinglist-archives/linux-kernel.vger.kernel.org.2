Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269A4453DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 02:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhKQBqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhKQBqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:46:10 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8542C061746;
        Tue, 16 Nov 2021 17:43:12 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id np3so953624pjb.4;
        Tue, 16 Nov 2021 17:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9zhM9rh30ohjlwji3Bv7yQWbgMzk/jVT8524khlEl4=;
        b=PgWcSqIy7Kcw8187ChPQDE2JmQv9/6YI4vMnjrkJHQcT3yUFFeg4uxFL15mySA9EkR
         PmN2dQH73hv8H5WWDi60WroefR5cRpeTYex2M0Sjprgn62YqtxrZkpaFSypsF/81DSWs
         UXf4xJRR2NlkijG9h2IAlpjxVcmHlW5YeoRf2oeNMlHIyw6mwREWLtDkZO14JZ/8nikR
         +toN3vx5ewrcAtXp0fzfYV/kXvvcihbCVZaRk8GHUVQ6Y9GGTiKlNMX5O02BDvdCMCG2
         iy/xavTgu6bEkybKanhrxQL92urp+Ew3e05NgxNtXrLDC8QouLOUim5JO051jOeRqFMU
         j3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9zhM9rh30ohjlwji3Bv7yQWbgMzk/jVT8524khlEl4=;
        b=KxlxkYU3B4M21UPCTQUFIE+95vST5fY+rfHvYw4DTKUTJtDP8G/P/VC71fsuUWiAHz
         W3fJuD1Hv5VibR8w4envVKfk5qb31NUTMP8JiXhveBZdpK+mmXoQAMfHebbHwL0xuNuE
         83N19mFTa60LtdQyjPQ4pEZyTmEfViECvWf/BTw+hwRnt3UMmWat5jk9rij7pbBE3pG+
         /LZqr7l9+h+2z6Iu9t562OhQyhyejDznr83AWBKZShinjySC4mtSzby0Jy5MUNDzCYYS
         6NUVRiBUiOlL2Yh6xviHmO29FVjkDioMthtmUiMPg68vYBUZxLjfStk1u+kUmm9lD0RZ
         g64A==
X-Gm-Message-State: AOAM531UWy9mJ3GiH9ce3gShm8wvJeLd7Ami+xd+iBP75wnBF2RJbapR
        6qUiNgd6C3pviIy/5ouNWOmT7a6t3hU=
X-Google-Smtp-Source: ABdhPJxCl0UYEXqUrOhGHfQImR9e3R/eGO+CXhzRUVODQiKEuEtGt8fmah7zuyP4+1f4CjkoI+qQfA==
X-Received: by 2002:a17:902:a60b:b0:142:7621:be0b with SMTP id u11-20020a170902a60b00b001427621be0bmr49876239plq.58.1637113392214;
        Tue, 16 Nov 2021 17:43:12 -0800 (PST)
Received: from nickserv.localdomain (c-98-35-167-56.hsd1.ca.comcast.net. [98.35.167.56])
        by smtp.gmail.com with ESMTPSA id np16sm3783411pjb.6.2021.11.16.17.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 17:43:11 -0800 (PST)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/3] lib: zstd: Fix unused variable warning
Date:   Tue, 16 Nov 2021 17:49:47 -0800
Message-Id: <20211117014949.1169186-2-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117014949.1169186-1-nickrterrell@gmail.com>
References: <20211117014949.1169186-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

Backport the fix from upstream PR #2838 [0]. Found by the Kernel test
robot in [1].

[0] https://github.com/facebook/zstd/pull/2838
[1] https://lore.kernel.org/linux-mm/202111120312.833wII4i-lkp@intel.com/T/

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 lib/zstd/compress/zstd_compress_superblock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/zstd/compress/zstd_compress_superblock.c b/lib/zstd/compress/zstd_compress_superblock.c
index ee03e0aedb03..a6a8e9a2aa0e 100644
--- a/lib/zstd/compress/zstd_compress_superblock.c
+++ b/lib/zstd/compress/zstd_compress_superblock.c
@@ -411,6 +411,7 @@ static size_t ZSTD_seqDecompressedSize(seqStore_t const* seqStore, const seqDef*
     const seqDef* sp = sstart;
     size_t matchLengthSum = 0;
     size_t litLengthSum = 0;
+    (void)litLengthSum;
     while (send-sp > 0) {
         ZSTD_sequenceLength const seqLen = ZSTD_getSequenceLength(seqStore, sp);
         litLengthSum += seqLen.litLength;
-- 
2.33.1

