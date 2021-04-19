Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F53C364DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhDSWvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:51:31 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:46820 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhDSWv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:51:29 -0400
Received: by mail-io1-f41.google.com with SMTP id b9so6806303iod.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7dN1cR8yp1Y0dQfx7nVvl1zLTK95ZK5ZgHF63GsR4I=;
        b=Ag87MD5T1AlXpSxdEjZMac7e5O0twrl4ks0PW67SMkhJTG03bVtkHhV0QBvh47OCMj
         jpN5EkT1a3QW7zxBjO/HgqKgqh3rvxF9j8KMQQ6F+/bjFoc8XmspQXwhPDpTYxzt75DQ
         4xjexM8ftKuAcyZ6mrtKv0G9j/d6mEKe+ZT5dCKLpH3QrOQGisyOvHyD1eA0tYP4WvFB
         nV2hFYwSql51IQIeqVAfSAdR882tSTuIUD4/K/MVBHZpR8Sb6VB9fKABNM/N0Eo3PUFg
         CX30tWr1vOJbX1/JUwNbw+mOPP3H/Y5daN26k0dtOLxCmD2RS8UypMvse4QBL3kDaQu+
         2s1g==
X-Gm-Message-State: AOAM531qz2jfi199Iklwb2cOvQjUjvU2fkRgegY5wc9c7E8LXy/Oj7D4
        j0tAoLqTKKlfaVfeqHuDpYHzadHW0+4=
X-Google-Smtp-Source: ABdhPJxIhJh7EN6HqpS59th3ME8ohUoJNzIxmuknJmCAl850EvjwOREFqhJwTVrTJz1zzXLyEaF3vw==
X-Received: by 2002:a02:6c0e:: with SMTP id w14mr9072162jab.4.1618872659021;
        Mon, 19 Apr 2021 15:50:59 -0700 (PDT)
Received: from abasin.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id d7sm7566967ion.39.2021.04.19.15.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 15:50:58 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 1/4] percpu: factor out pcpu_check_block_hint()
Date:   Mon, 19 Apr 2021 22:50:44 +0000
Message-Id: <20210419225047.3415425-2-dennis@kernel.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210419225047.3415425-1-dennis@kernel.org>
References: <20210419225047.3415425-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guro@fb.com>

Factor out the pcpu_check_block_hint() helper, which will be useful
in the future. The new function checks if the allocation can likely
fit within the contig hint.

Signed-off-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 61339b3d9337..5edc7bd88133 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -306,6 +306,25 @@ static unsigned long pcpu_block_off_to_off(int index, int off)
 	return index * PCPU_BITMAP_BLOCK_BITS + off;
 }
 
+/**
+ * pcpu_check_block_hint - check against the contig hint
+ * @block: block of interest
+ * @bits: size of allocation
+ * @align: alignment of area (max PAGE_SIZE)
+ *
+ * Check to see if the allocation can fit in the block's contig hint.
+ * Note, a chunk uses the same hints as a block so this can also check against
+ * the chunk's contig hint.
+ */
+static bool pcpu_check_block_hint(struct pcpu_block_md *block, int bits,
+				  size_t align)
+{
+	int bit_off = ALIGN(block->contig_hint_start, align) -
+		block->contig_hint_start;
+
+	return bit_off + bits <= block->contig_hint;
+}
+
 /*
  * pcpu_next_hint - determine which hint to use
  * @block: block of interest
@@ -1066,14 +1085,11 @@ static int pcpu_find_block_fit(struct pcpu_chunk *chunk, int alloc_bits,
 	int bit_off, bits, next_off;
 
 	/*
-	 * Check to see if the allocation can fit in the chunk's contig hint.
-	 * This is an optimization to prevent scanning by assuming if it
-	 * cannot fit in the global hint, there is memory pressure and creating
-	 * a new chunk would happen soon.
+	 * This is an optimization to prevent scanning by assuming if the
+	 * allocation cannot fit in the global hint, there is memory pressure
+	 * and creating a new chunk would happen soon.
 	 */
-	bit_off = ALIGN(chunk_md->contig_hint_start, align) -
-		  chunk_md->contig_hint_start;
-	if (bit_off + alloc_bits > chunk_md->contig_hint)
+	if (!pcpu_check_block_hint(chunk_md, alloc_bits, align))
 		return -1;
 
 	bit_off = pcpu_next_hint(chunk_md, alloc_bits);
-- 
2.31.1.368.gbe11c130af-goog

