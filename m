Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA193FF060
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345887AbhIBPmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbhIBPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:42:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D48C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 08:41:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f18so5211857lfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XgijCMskJCudI7TkVSpuxsd8r1TstWnscrMUPwKfNPs=;
        b=TwnK0M6enZJhf6vbeFDvzMNtUP1ZY/y41L1KRui7iSoipB6QWPldyRLIpqlElinvy+
         PSrMdLatHvBSOzopsofanLtrTjrWxgy3esY4kjA/GlwyFhGPGvI0WirCq853F+fPbaPK
         R7o8h8iNcXZExWXX9kVhulZxrZO+6WQf7eAWY3ZWdtyQfnTobBRa7/h5sngCZfEjtz2v
         EqTwibScbH3/yuRRpTuiNKuU+J5ezUbUA2gGiw2puHo5c50VvEoqM/mCud5F8PHmnxo/
         FwK6iu1pxl+0oCh5vFU3Xsy/FieT7z9zDv945FMtHp9UpxklkViho+nJP8TITI7nsCwh
         4xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XgijCMskJCudI7TkVSpuxsd8r1TstWnscrMUPwKfNPs=;
        b=D67Ra0+LENNhbmQiXlOj4rLWvpwJ/vFY6P6BBr89iqrB561hOIL2SNp26trLqnVHvo
         9peJY03FtaKsUXd8UDFAFtXYJKzR2I6XZ5B2xeSxQi3KiB91u6fCGVLuQktH9MnxfoyQ
         CC0YE717YUdpEcDzgH3tKmLme+FIIulon2lJddmw5zjcdcpvzI6p9pin6IDa4ve/ga5/
         2rhtq8UMFlcHzTNY8gttrjjVq80GPQoFrLj+AY8uI7DwYTSP4IJZsubotY/Vd8B3QbTZ
         oSdwv8DH52E5VlNRswXway9UvFaAirO6R85fx6O+3cKp3XeGpgq9ASXImmkHbNdIzFFj
         974g==
X-Gm-Message-State: AOAM530Rsdl4cv2twg1x9xio5fSlBWo64jFY3FBR7E+1x1NuSgUNnx+S
        iz/Lyj73ICjA9SCiNBFe/vI=
X-Google-Smtp-Source: ABdhPJwd8XTj24Ih9FVnFHeCUJnlSlWVHL2uQQs4QgZaIj8Yl/Bqy6xZDaxOG4hEI+CROHGNlBch0Q==
X-Received: by 2002:a05:6512:1695:: with SMTP id bu21mr3143133lfb.506.1630597264862;
        Thu, 02 Sep 2021 08:41:04 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id 25sm258630ljw.31.2021.09.02.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 08:41:04 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH 1/3] fs/ntfs3: Limit binary search table size
Date:   Thu,  2 Sep 2021 18:40:48 +0300
Message-Id: <20210902154050.5075-2-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902154050.5075-1-kari.argillander@gmail.com>
References: <20210902154050.5075-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current binary search allocates memory for table and fill whole table
before we start actual binary search. This is quite inefficient because
table fill will always be O(n). Also if table is huge we need to
reallocate memory which is costly.

This implementation use just stack memory and always when table is full
we will check if last element is <= and if not start table fill again.
The idea was that it would be same cost as table reallocation.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/index.c | 110 ++++++++++++++++++-----------------------------
 1 file changed, 41 insertions(+), 69 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 0daca9adc54c..8bac9d20e7e3 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -678,98 +678,70 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 	u32 off = le32_to_cpu(hdr->de_off);
 
 #ifdef NTFS3_INDEX_BINARY_SEARCH
-	int max_idx = 0, fnd, min_idx;
-	int nslots = 64;
-	u16 *offs;
+	struct NTFS_DE *found = NULL;
+	int min_idx = 0, mid_idx, max_idx = 0;
+	int diff2;
+	u16 offs[64];
 
 	if (end > 0x10000)
 		goto next;
 
-	offs = kmalloc(sizeof(u16) * nslots, GFP_NOFS);
-	if (!offs)
-		goto next;
+fill_table:
+	if (off + sizeof(struct NTFS_DE) > end)
+		return NULL;
 
-	/* Use binary search algorithm. */
-next1:
-	if (off + sizeof(struct NTFS_DE) > end) {
-		e = NULL;
-		goto out1;
-	}
 	e = Add2Ptr(hdr, off);
 	e_size = le16_to_cpu(e->size);
 
-	if (e_size < sizeof(struct NTFS_DE) || off + e_size > end) {
-		e = NULL;
-		goto out1;
-	}
-
-	if (max_idx >= nslots) {
-		u16 *ptr;
-		int new_slots = ALIGN(2 * nslots, 8);
-
-		ptr = kmalloc(sizeof(u16) * new_slots, GFP_NOFS);
-		if (ptr)
-			memcpy(ptr, offs, sizeof(u16) * max_idx);
-		kfree(offs);
-		offs = ptr;
-		nslots = new_slots;
-		if (!ptr)
-			goto next;
-	}
-
-	/* Store entry table. */
-	offs[max_idx] = off;
+	if (e_size < sizeof(struct NTFS_DE) || off + e_size > end)
+		return NULL;
 
 	if (!de_is_last(e)) {
+		offs[max_idx] = off;
 		off += e_size;
-		max_idx += 1;
-		goto next1;
-	}
 
-	/*
-	 * Table of pointers is created.
-	 * Use binary search to find entry that is <= to the search value.
-	 */
-	fnd = -1;
-	min_idx = 0;
+		max_idx++;
+		if (max_idx < ARRAY_SIZE(offs))
+			goto fill_table;
 
-	while (min_idx <= max_idx) {
-		int mid_idx = min_idx + ((max_idx - min_idx) >> 1);
-		int diff2;
-
-		e = Add2Ptr(hdr, offs[mid_idx]);
+		max_idx--;
+	}
 
-		e_key_len = le16_to_cpu(e->key_size);
+binary_search:
+	e_key_len = le16_to_cpu(e->key_size);
 
-		diff2 = (*cmp)(key, key_len, e + 1, e_key_len, ctx);
+	diff2 = (*cmp)(key, key_len, e + 1, e_key_len, ctx);
+	if (diff2 > 0) {
+		if (found) {
+			min_idx = mid_idx + 1;
+		} else {
+			if (de_is_last(e))
+				return NULL;
 
-		if (!diff2) {
-			*diff = 0;
-			goto out1;
+			max_idx = 0;
+			goto fill_table;
 		}
-
-		if (diff2 < 0) {
+	} else if (diff2 < 0) {
+		if (found)
 			max_idx = mid_idx - 1;
-			fnd = mid_idx;
-			if (!fnd)
-				break;
-		} else {
-			min_idx = mid_idx + 1;
-		}
-	}
+		else
+			max_idx--;
 
-	if (fnd == -1) {
-		e = NULL;
-		goto out1;
+		found = e;
+	} else {
+		*diff = 0;
+		return e;
 	}
 
-	*diff = -1;
-	e = Add2Ptr(hdr, offs[fnd]);
+	if (min_idx > max_idx) {
+		*diff = -1;
+		return found;
+	}
 
-out1:
-	kfree(offs);
+	mid_idx = (min_idx + max_idx) >> 1;
+	e = Add2Ptr(hdr, offs[mid_idx]);
 
-	return e;
+	goto binary_search;
 #endif
 
 next:
-- 
2.25.1

