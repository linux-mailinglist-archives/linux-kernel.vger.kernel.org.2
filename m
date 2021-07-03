Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729533BA701
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 06:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhGCEH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 00:07:27 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:46981 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhGCEH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 00:07:26 -0400
Received: by mail-io1-f54.google.com with SMTP id f21so14030129ioh.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 21:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CVoiGwg8bDCGqfxgKgsIzljf6zxgJKc8KUJPsMXiyQA=;
        b=imF9uv0/0BHKi/5BSY75Dpb75j+yG57m4CwXBVxKCOVvezukJMYQ5r3F8yPpdFrpiY
         ofM8r25lZkqstlNGqEREnwA8wXahch3oB5WYAOvYWjan78Egtu0V/N4duKZhvtSOJfIe
         GxA828pL9thMFhgFDJ076PYSbZ5xAzsPMMxA/I1/9JHlKKKHTDm6Dj1LGqbkLh0plnNf
         YQJUs7e3+OuelR3Hk3eLcab2lMsNL6ZUlu0m77vuvcgYKnqvSkDoeXvheMzQoWkWaBC/
         lILX5wrxMy74XJX/yVJEBg67lY/IkngfVsATumvqyJTaA0SqokieLNn521+EB4Lwh0/f
         MUrA==
X-Gm-Message-State: AOAM5320WfwM+RYZh0yKHJOZbOJGTPBm0RJFtdzYOE/09gkuZ8sogoih
        yg0Eis4QEO4CPpwL6S2i238=
X-Google-Smtp-Source: ABdhPJzd5aKJFzyezOczroeaBohpXe0o+RjufI1q6AU0IOwT1bkykFGnPgvnbDLF21W7EETdx+xL7Q==
X-Received: by 2002:a6b:e403:: with SMTP id u3mr2563815iog.22.1625285092276;
        Fri, 02 Jul 2021 21:04:52 -0700 (PDT)
Received: from abasin.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id a11sm2996675ioq.12.2021.07.02.21.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 21:04:51 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] percpu: flush tlb after pcpu_depopulate_chunk()
Date:   Sat,  3 Jul 2021 04:04:49 +0000
Message-Id: <20210703040449.3213210-1-dennis@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to "percpu: implement partial chunk depopulation",
pcpu_depopulate_chunk() was called only on the destruction path. This
meant the virtual address range was on its way back to vmalloc which
will handle flushing the tlbs for us.

However, now that we call pcpu_depopulate_chunk() during the active
lifecycle of a chunk, we need to flush the tlb as well otherwise we can
end up accessing the wrong page through an invalid tlb mapping.

This was reported in [1].

[1] https://lore.kernel.org/lkml/20210702191140.GA3166599@roeck-us.net/

Fixes: f183324133ea ("percpu: implement partial chunk depopulation")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu-km.c |  3 ++-
 mm/percpu-vm.c | 11 +++++++++--
 mm/percpu.c    |  7 ++++---
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index c9d529dc7651..6875fc3b2ed7 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -39,7 +39,8 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
 }
 
 static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
-				  int page_start, int page_end)
+				  int page_start, int page_end,
+				  bool flush_tlb)
 {
 	/* nada */
 }
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index ee5d89fcd66f..6353cda1718e 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -299,6 +299,7 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
  * @chunk: chunk to depopulate
  * @page_start: the start page
  * @page_end: the end page
+ * @flush_tlb: if should we flush the tlb
  *
  * For each cpu, depopulate and unmap pages [@page_start,@page_end)
  * from @chunk.
@@ -307,7 +308,8 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
  * pcpu_alloc_mutex.
  */
 static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
-				  int page_start, int page_end)
+				  int page_start, int page_end,
+				  bool flush_tlb)
 {
 	struct page **pages;
 
@@ -324,7 +326,12 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
 
 	pcpu_unmap_pages(chunk, pages, page_start, page_end);
 
-	/* no need to flush tlb, vmalloc will handle it lazily */
+	/*
+	 * We need to flush the tlb unless the caller will pass it to vmalloc,
+	 * which will handle flushing for us.
+	 */
+	if (flush_tlb)
+		pcpu_post_unmap_tlb_flush(chunk, page_start, page_end);
 
 	pcpu_free_pages(chunk, pages, page_start, page_end);
 }
diff --git a/mm/percpu.c b/mm/percpu.c
index b4cebeca4c0c..e23ba0d22220 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1580,7 +1580,8 @@ static void pcpu_chunk_depopulated(struct pcpu_chunk *chunk,
 static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
 			       int page_start, int page_end, gfp_t gfp);
 static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
-				  int page_start, int page_end);
+				  int page_start, int page_end,
+				  bool flush_tlb);
 static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp);
 static void pcpu_destroy_chunk(struct pcpu_chunk *chunk);
 static struct page *pcpu_addr_to_page(void *addr);
@@ -2016,7 +2017,7 @@ static void pcpu_balance_free(bool empty_only)
 
 		bitmap_for_each_set_region(chunk->populated, rs, re, 0,
 					   chunk->nr_pages) {
-			pcpu_depopulate_chunk(chunk, rs, re);
+			pcpu_depopulate_chunk(chunk, rs, re, false);
 			spin_lock_irq(&pcpu_lock);
 			pcpu_chunk_depopulated(chunk, rs, re);
 			spin_unlock_irq(&pcpu_lock);
@@ -2189,7 +2190,7 @@ static void pcpu_reclaim_populated(void)
 				continue;
 
 			spin_unlock_irq(&pcpu_lock);
-			pcpu_depopulate_chunk(chunk, i + 1, end + 1);
+			pcpu_depopulate_chunk(chunk, i + 1, end + 1, true);
 			cond_resched();
 			spin_lock_irq(&pcpu_lock);
 
-- 
2.32.0.93.g670b81a890-goog

