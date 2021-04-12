Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BBA35D3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 01:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344158AbhDLX2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 19:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344144AbhDLX2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618270082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qk6kQznMv60g5JnSrTctErm3V3ADaN3762t2H988t2A=;
        b=BYyVziZF1u5gLfPG1nyMZfCZhbk7D3iRCyQVGvVv74r/xvlHmJT2IY4SW4MzqMJIz0zkBW
        /9U3n1PAQW0KnZUAwqpqORjmocMxjpLrH/xSR3cyBVKwPerFf5vM9H3D5gGuAmARS+qMVH
        buC3KjI6MaWg76My4en+egkq72Qwh8s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-S0vwh9HMP-eMZsiHqZDQgQ-1; Mon, 12 Apr 2021 19:28:01 -0400
X-MC-Unique: S0vwh9HMP-eMZsiHqZDQgQ-1
Received: by mail-qk1-f197.google.com with SMTP id h19so10031441qkk.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qk6kQznMv60g5JnSrTctErm3V3ADaN3762t2H988t2A=;
        b=qk1quY72MCHedQUN8eye3KQFwpHpkalsIzBZaYuoyfN7Eda6EDIwLbXHK3x/TtEbAL
         pNgu1HWB9cgso8vDJ/wyr99qqzf1/CDlj/zzJawTt/6avF8wQyG4+I4bqFXepqzAkGA9
         uuE2ySXjSSUF8maekhUjw0fyeCGYkmi/lHJyI6deJaLEYGSZGc32a8FvyMxkMN5JRVYn
         8wJpTja/Uw/2k0hESOv7E0tczd2oM+hUWPOl9L7k8SoIQYf72rCwGdYsbUy98185bN14
         YVUn5sih41XpcHt5b8C56la5yQtRZrx34SkPOQL63FL2cn+EobvmTTG2b1oI2j0/KV7F
         dFWQ==
X-Gm-Message-State: AOAM530GynUWV1T3tEJhw8p4RRSSFAIe9Tb//BowVxneWjozhYLTQNP2
        GVHDPUnIORQzmRi1+IRnbenTteFkbVF0zm5Pi9xD/kwnx5u35+NxM1+e1LVvsNEUGmGIPJB4575
        zBJP7d/8ujc7h6yxbffyWfYxQ
X-Received: by 2002:ac8:5244:: with SMTP id y4mr3412660qtn.175.1618270080305;
        Mon, 12 Apr 2021 16:28:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylMZ4q6vaw/BA+In5/xrgFfhle5RcKCcC0k84sArZg1TaCw816VTI+r8JyxhmY4Q2GrOr/jg==
X-Received: by 2002:ac8:5244:: with SMTP id y4mr3412647qtn.175.1618270080076;
        Mon, 12 Apr 2021 16:28:00 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id y29sm8958925qtm.13.2021.04.12.16.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 16:27:59 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v2 3/5] userfaultfd/selftests: Dropping VERIFY check in locking_thread
Date:   Mon, 12 Apr 2021 19:27:51 -0400
Message-Id: <20210412232753.1012412-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412232753.1012412-1-peterx@redhat.com>
References: <20210412232753.1012412-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It tries to check against all zeros and looped for quite a few times.  However
after that we'll verify the same page with count_verify, while count_verify can
never be zero.  So it means if it's a zero page we'll detect it anyways with
below code.

There's yet another place we conditionally check the fault flag - just do it
unconditionally.

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 55 +-----------------------
 1 file changed, 1 insertion(+), 54 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 5cae66e27171..387b9360ae64 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -430,58 +430,6 @@ static void *locking_thread(void *arg)
 		} else
 			page_nr += 1;
 		page_nr %= nr_pages;
-
-		if (bounces & BOUNCE_VERIFY) {
-			count = *area_count(area_dst, page_nr);
-			if (!count) {
-				fprintf(stderr,
-					"page_nr %lu wrong count %Lu %Lu\n",
-					page_nr, count,
-					count_verify[page_nr]);
-				exit(1);
-			}
-
-
-			/*
-			 * We can't use bcmp (or memcmp) because that
-			 * returns 0 erroneously if the memory is
-			 * changing under it (even if the end of the
-			 * page is never changing and always
-			 * different).
-			 */
-#if 1
-			if (!my_bcmp(area_dst + page_nr * page_size, zeropage,
-				     page_size)) {
-				fprintf(stderr,
-					"my_bcmp page_nr %lu wrong count %Lu %Lu\n",
-					page_nr, count, count_verify[page_nr]);
-				exit(1);
-			}
-#else
-			unsigned long loops;
-
-			loops = 0;
-			/* uncomment the below line to test with mutex */
-			/* pthread_mutex_lock(area_mutex(area_dst, page_nr)); */
-			while (!bcmp(area_dst + page_nr * page_size, zeropage,
-				     page_size)) {
-				loops += 1;
-				if (loops > 10)
-					break;
-			}
-			/* uncomment below line to test with mutex */
-			/* pthread_mutex_unlock(area_mutex(area_dst, page_nr)); */
-			if (loops) {
-				fprintf(stderr,
-					"page_nr %lu all zero thread %lu %p %lu\n",
-					page_nr, cpu, area_dst + page_nr * page_size,
-					loops);
-				if (loops > 10)
-					exit(1);
-			}
-#endif
-		}
-
 		pthread_mutex_lock(area_mutex(area_dst, page_nr));
 		count = *area_count(area_dst, page_nr);
 		if (count != count_verify[page_nr]) {
@@ -613,8 +561,7 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 		stats->minor_faults++;
 	} else {
 		/* Missing page faults */
-		if (bounces & BOUNCE_VERIFY &&
-		    msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE) {
+		if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE) {
 			fprintf(stderr, "unexpected write fault\n");
 			exit(1);
 		}
-- 
2.26.2

