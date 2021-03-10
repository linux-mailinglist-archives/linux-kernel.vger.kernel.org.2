Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139E2333291
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 01:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhCJApg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 19:45:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231332AbhCJApT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 19:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615337118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XTxMrWeKH8O2DThEeOu5l9V9OGI2aOJZxvfxAe4SMMo=;
        b=LDb8bwl+6OVskMo9buwVnLd/xwkGZmvvjs52T/S3Jc8s6He6iU19OXgWsp9LOgXXyaFjLp
        IsJQIJds3Bnolu1ny0bMFuOHodzkZRYtfLlYteXomhknPA5wInpwEqkBIN5UySTUSwCN9k
        YsxmXkGWI5moCi4pune93ydxE2wQ0YA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-XQNBlzNJN5-IWeC6NWmYrA-1; Tue, 09 Mar 2021 19:45:17 -0500
X-MC-Unique: XQNBlzNJN5-IWeC6NWmYrA-1
Received: by mail-qt1-f197.google.com with SMTP id y1so3037760qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 16:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTxMrWeKH8O2DThEeOu5l9V9OGI2aOJZxvfxAe4SMMo=;
        b=abCQVwRc8kt0BUZa7B/ROpzGmC0utIfONE6NJoj8xxOLiALVzo5d9tPwWpCID3U3w4
         iuQ3M3p6kCaXJ0wMUxytkh8vgnAyThhKspHFYGk7vg2SymRlys7OxG/KlTNN2R8VNrE5
         cgZkDajwW2E+qX7UFSudNmV+6v0tB7KIoCajre4afEJPrKNHv+CnriWnLt7HnhPAVoAk
         /uDv8xtJAOedPib2ZSypriNRM8dwiNgmIXLBNg5k78AJM5sl4/NYZeNcGr6R14hQTlY1
         WkIXOnLdAVPM/nGFf1J4qyeyhAsmiO5mlVrPpQP+Ms3/STvuztnoWa3bcXxy1VUWc0tA
         Xqxw==
X-Gm-Message-State: AOAM530qQNWaY7EW6VSIvcz+xTYlUzf7dIu416ZLvriFRW3B3u+AwE1D
        CQyUnNvddw5FEk3gho89HHJyArAPMNVfSyEwJ/hWKXhDPLMmTVNdXosRfhRowpuYrQbDP184icR
        5VPH/6tLXmI3XHgZaJIemx3vv
X-Received: by 2002:a37:6f87:: with SMTP id k129mr374399qkc.470.1615337116809;
        Tue, 09 Mar 2021 16:45:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxa0LO98xbT0z77N8oNJ9fVqTLpx95rd6U3cRryCrA2lKn1tkBps+lK8jr+X/gNz4ENVt3L0A==
X-Received: by 2002:a37:6f87:: with SMTP id k129mr374386qkc.470.1615337116594;
        Tue, 09 Mar 2021 16:45:16 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id b27sm11418173qkl.102.2021.03.09.16.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 16:45:16 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 3/5] userfaultfd/selftests: Dropping VERIFY check in locking_thread
Date:   Tue,  9 Mar 2021 19:45:09 -0500
Message-Id: <20210310004511.51996-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310004511.51996-1-peterx@redhat.com>
References: <20210310004511.51996-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 55 +-----------------------
 1 file changed, 1 insertion(+), 54 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 5cde062f07bc..cf0cd4cb327d 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -603,58 +603,6 @@ static void *locking_thread(void *arg)
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
@@ -786,8 +734,7 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
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

