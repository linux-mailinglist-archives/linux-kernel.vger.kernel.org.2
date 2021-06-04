Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6745739BF27
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFDR5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDR5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:57:09 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6703C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 10:55:16 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id u13so5371114qvt.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqTDYULOdmRO9QMOi5MUNNSuuP+YM4KULlFjGRM4XO0=;
        b=k66xbR2Ts+amfEA9q0i1ECkO/Z69P8wiBWeObBl33PS/v0JtAcV6tI8rSOg56r2Scl
         7LfvKYcKcsbkxsXL6n4+ljKo+QOhfajWKdY6PcQdYSkOW3bLR+RvL3JJIXPHl7zLuwtW
         qPDr4XZfSNMCcJiExClWXWNJaa8EdQKOUr3WpbyZ/r/BumVVoNfEuhZeDhV38k5grkYC
         L0lkGIJbCF63915JdQBLYXy7HSWmWeQWiQSOtw4RKOyPP4AmnjMrLCFP2SklRyiGn6wZ
         5h1M8OopM6Qad5aMIk73CcNKPfWoxd9NYDyTvosKgz5NP4rmVNgIlNdZgKDkoXeiH6FI
         UCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqTDYULOdmRO9QMOi5MUNNSuuP+YM4KULlFjGRM4XO0=;
        b=SHxAGSee6E6UE/0Cnz6qErxt226IlFj1+d48AYHAKJU9UISz/R/yu8OzjzBU8zHA1c
         MwbBTfZ8XN6hvDeSNN3MpmytJ4RkZKA6mos8oZlZz8sKRXnmlsOe6IQPMNc8nVs5hH0U
         LfpowZagRZANXEKkcxBkSoKmq2c3FJ3zEN2E1f0BaR2h7153h9KvkYigN8TlP2E1Si0V
         o6KhiIjiIsylTMB1j19OcIbvLU6hIJWn8QN1XoZespbeb9KjnbsYdJ6ZZf/TZU74J8jl
         iIXRhm5smiXLmpYJGQTADVXhXnpbrIIceRQISbsvvelwgMI/J7OjW/TkWGCZf1K1bIR+
         fPQQ==
X-Gm-Message-State: AOAM533viMegVd1h/h26UHZV1iRVbohtq36bIeNn2ui1YU8NPmDlhW3v
        Pb80INH9LqlrGYMRodUSbpo=
X-Google-Smtp-Source: ABdhPJxTw8Q2g4gJqdQ5VjeVcUsumg5m4xlJCqLwsEiMFIRljGLUCf9uZk2to7cRVIUw+zBccv3Zcg==
X-Received: by 2002:a0c:ec10:: with SMTP id y16mr5743627qvo.49.1622829316048;
        Fri, 04 Jun 2021 10:55:16 -0700 (PDT)
Received: from hemlock.fiveisland.rocks ([2001:470:1d:225:af22:9bab:b26c:cac1])
        by smtp.gmail.com with ESMTPSA id u2sm4301525qkk.75.2021.06.04.10.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 10:55:15 -0700 (PDT)
From:   Marc Dionne <marc.c.dionne@gmail.com>
To:     Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix partial writeback of large files on fsync and close
Date:   Fri,  4 Jun 2021 14:55:04 -0300
Message-Id: <20210604175504.4055-1-marc.c.dionne@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

In commit e87b03f5830e ("afs: Prepare for use of THPs"), the return
value for afs_write_back_from_locked_page was changed from a number
of pages to a length in bytes.  The loop in afs_writepages_region uses
the return value to compute the index that will be used to find dirty
pages in the next iteration, but treats it as a number of pages and
wrongly multiplies it by PAGE_SIZE.  This gives a very large index value,
potentially skipping any dirty data that was not covered in the first
pass, which is limited to 256M.

This causes fsync(), and indirectly close(), to only do a partial
writeback of a large file's dirty data.  The rest is eventually written
back by background threads after dirty_expire_centisecs.

Fixes: e87b03f5830e ("afs: Prepare for use of THPs")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
---
 fs/afs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 3edb6204b937..a523bb86915d 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -730,7 +730,7 @@ static int afs_writepages_region(struct address_space *mapping,
 			return ret;
 		}
 
-		start += ret * PAGE_SIZE;
+		start += ret;
 
 		cond_resched();
 	} while (wbc->nr_to_write > 0);
-- 
2.31.1

