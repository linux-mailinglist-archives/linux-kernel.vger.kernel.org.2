Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2AD3FF062
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345905AbhIBPmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbhIBPmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:42:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A93C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 08:41:18 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q21so4377368ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWOCfRNG4fQxLJ+Kx3A/4ZxyhuIqTzTqHfmxkowqQ50=;
        b=QiABlvpngTc2hmqTZwFxfMqoXdBZmSExZY2nD9oSQiunGlkWWNqH6PD99EZbwBWBR5
         Zw7UDZnL30TzcsU9nQiTva7yAQH/5wQaUmkcQUN+N4ykHA7nr3yEgqFJC/3sfIAwAtEn
         Is8cykLiA+mi5dj30RHJ8Vrgxt30eHIqXY7RFGG1S67snsD463Ke7txMFFMuyQOs1pTf
         G8gs+EHwsupBz56p54H4v91MkTwF6mo/uR39G3cuKg6d82b3zaBySROeUnovBWfWzTnk
         60z5OTEIGd+twjKeAa329BBGwcXy8L38gDKWO4rjr7RoZ/v6IvmrEyolG5UuydE+2oOU
         srdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWOCfRNG4fQxLJ+Kx3A/4ZxyhuIqTzTqHfmxkowqQ50=;
        b=On6YegxAc9Se520T/Ful4w+CA8S4AHoGjlBQHXa6OKgKJdvqkpUBwtYmP47pziuUAq
         F58iuD0CCmNnstv/uK/aY4fRlKSwyw5V6oWZFC99IVJpd5/cL31ZToPc8YhkQpaG3YXK
         xLy9Fbv8JqpqmNh21UzOgJjteUhWsw5KmbaO+FfO9hcsl0ip/rEoiGX6p9xalC6sx5xV
         m1jRNhEvbiNly2fLfU2mCbs0uTi/teuYL9mgoOVt7aj/mxOeGIoAnnjuqnGkpI/23zvd
         ZCq+wCIJydv5HY1iX3tARslqqQKTewX9ivJFX3/2AAsqQj3wM+xvlleWirtXOqEAxArs
         RDNA==
X-Gm-Message-State: AOAM533l40vVunQW2JXkicciPdS+5pfqNB5e/pvDEj6vEuui7WSbvfwH
        wWOFRAoEfhrWGdqy3s0awQo=
X-Google-Smtp-Source: ABdhPJwu/E5UHn4JyscXGjtZbMUB43RYv3rVpsyBX5OCA//v2x8IKsvJ2nKiVk36RGKF8DFXZVQD5w==
X-Received: by 2002:a2e:9055:: with SMTP id n21mr3037707ljg.451.1630597276737;
        Thu, 02 Sep 2021 08:41:16 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id 25sm258630ljw.31.2021.09.02.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 08:41:16 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH 3/3] fs/ntfs3: Always use binary search with entry search
Date:   Thu,  2 Sep 2021 18:40:50 +0300
Message-Id: <20210902154050.5075-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902154050.5075-1-kari.argillander@gmail.com>
References: <20210902154050.5075-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not have any reason to keep old linear search in. Before this was
used for error path or if table was so big that it cannot be allocated.
Current binary search implementation won't need error path. Remove old
references to linear entry search.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/index.c | 50 ++++++------------------------------------------
 fs/ntfs3/ntfs.h  |  3 ---
 2 files changed, 6 insertions(+), 47 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index e336d5645628..9f79cff7d09e 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -672,22 +672,16 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 				  const struct INDEX_HDR *hdr, const void *key,
 				  size_t key_len, const void *ctx, int *diff)
 {
-	struct NTFS_DE *e;
+	struct NTFS_DE *e, *found = NULL;
 	NTFS_CMP_FUNC cmp = indx->cmp;
+	int min_idx = 0, mid_idx, max_idx = 0;
+	int diff2;
+	int table_size = 8;
 	u32 e_size, e_key_len;
 	u32 end = le32_to_cpu(hdr->used);
 	u32 off = le32_to_cpu(hdr->de_off);
-
-#ifdef NTFS3_INDEX_BINARY_SEARCH
-	struct NTFS_DE *found = NULL;
-	int min_idx = 0, mid_idx, max_idx = 0;
-	int table_size = 8;
-	int diff2;
 	u16 offs[128];
 
-	if (end > 0x10000)
-		goto next;
-
 fill_table:
 	if (off + sizeof(struct NTFS_DE) > end)
 		return NULL;
@@ -721,7 +715,8 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 				return NULL;
 
 			max_idx = 0;
-			table_size = min(table_size * 2, 128);
+			table_size = min(table_size * 2,
+					 (int)ARRAY_SIZE(offs));
 			goto fill_table;
 		}
 	} else if (diff2 < 0) {
@@ -745,39 +740,6 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 	e = Add2Ptr(hdr, offs[mid_idx]);
 
 	goto binary_search;
-#endif
-
-next:
-	/*
-	 * Entries index are sorted.
-	 * Enumerate all entries until we find entry
-	 * that is <= to the search value.
-	 */
-	if (off + sizeof(struct NTFS_DE) > end)
-		return NULL;
-
-	e = Add2Ptr(hdr, off);
-	e_size = le16_to_cpu(e->size);
-
-	if (e_size < sizeof(struct NTFS_DE) || off + e_size > end)
-		return NULL;
-
-	off += e_size;
-
-	e_key_len = le16_to_cpu(e->key_size);
-
-	*diff = (*cmp)(key, key_len, e + 1, e_key_len, ctx);
-	if (!*diff)
-		return e;
-
-	if (*diff <= 0)
-		return e;
-
-	if (de_is_last(e)) {
-		*diff = 1;
-		return e;
-	}
-	goto next;
 }
 
 /*
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 6bb3e595263b..a7e1b7cc7a14 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -12,9 +12,6 @@
 
 /* TODO: Check 4K MFT record and 512 bytes cluster. */
 
-/* Activate this define to use binary search in indexes. */
-#define NTFS3_INDEX_BINARY_SEARCH
-
 /* Check each run for marked clusters. */
 #define NTFS3_CHECK_FREE_CLST
 
-- 
2.25.1

