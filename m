Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97972333290
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 01:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhCJApe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 19:45:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231308AbhCJApS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 19:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615337117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8nfZJKhv+r2vlPxmKndFS7iJCcyevUUZHWcDdBpSWU=;
        b=If03z/DMmIFuFbLTpN0GzwUYdpbwJBwcJmcgy/zS+IrHyJpgCbnt+35ur/SPZd2ZPZ3KMc
        Qk+SBGrNksPfiZYlT1MuxBr86OPXxYIK30IfnOAmnMx9or7Y76DdT6Z+Sz8+FMjx9ge91L
        2+z9CxDEhyJ8hVMhw/5t+S7ZstjFq7I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-A8GVK0rjOJSAKt5Bj5WO7g-1; Tue, 09 Mar 2021 19:45:16 -0500
X-MC-Unique: A8GVK0rjOJSAKt5Bj5WO7g-1
Received: by mail-qk1-f200.google.com with SMTP id h21so11540780qkl.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 16:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8nfZJKhv+r2vlPxmKndFS7iJCcyevUUZHWcDdBpSWU=;
        b=hYh5dhaI1yw+Z62mQPdWCwH3baADWX+o+ajIYjVaRrYsgxEiZp8+d229tkNwa5elmI
         62biFgow2P3Z09HwScbCP4rCMVFgmMbZcJu6cHKkq6eZKH9UuyYS97FxQxvW0aa9asbT
         rUNDgYi8Si2oewv2HPwO4WvkZ0I7S8Dvjceu4dEXCrA+SkZfF6JoQDvt5YzRvUp/6pWA
         Qr98W1HzwXWgdNLJ9OyOgC0FXH5Lympb13W6/RzIkDCCjB6QN9Ivz8af6CuVJ11pbFfW
         LHrBfg82074BaTzjQrjrwYQcn9eIZs2g+eSFTaqDPzfKivOOyhQvGjd381kzV3fR9Bz6
         FZ4Q==
X-Gm-Message-State: AOAM530vhulZDC4OZNMFXYPjpxCJZVc2MhFLd4vAP9UCwYWNug8k2XtK
        vTmz0XyY/+k2OHu45W920sft5RayulmzHUjnk/gyJXexUbJhVHhsHZV8fD8fwFaS6yz0lxIIreE
        tScUPRbL5AfF4GUTnYR4qMoLJ
X-Received: by 2002:ac8:4b6d:: with SMTP id g13mr628861qts.369.1615337115757;
        Tue, 09 Mar 2021 16:45:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9J0zcGuXi54OqQD2AFWa8MzixYYXJTZo09HsFe6Yfl7ExISUIhiuuss3NULI5dWVcc5p3jg==
X-Received: by 2002:ac8:4b6d:: with SMTP id g13mr628846qts.369.1615337115510;
        Tue, 09 Mar 2021 16:45:15 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id b27sm11418173qkl.102.2021.03.09.16.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 16:45:15 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 2/5] userfaultfd/selftests: Remove the time() check on delayed uffd
Date:   Tue,  9 Mar 2021 19:45:08 -0500
Message-Id: <20210310004511.51996-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310004511.51996-1-peterx@redhat.com>
References: <20210310004511.51996-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to have no guarantee that time() will return the same for the two
calls even if there's no delay, e.g. when a fault is accidentally crossing the
changing of a second.  Meanwhile, this message is also not helping that much
since delay could happen with a lot of reasons, e.g., schedule latency of
resolving thread.  It may not mean an issue with uffd.

Neither do I saw this error triggered either in the past runs.  Even if it
triggers, it'll be drown in all the rest of test logs.  Remove it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 6dab8ef034a0..5cde062f07bc 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -568,7 +568,6 @@ static void *locking_thread(void *arg)
 	unsigned long long count;
 	char randstate[64];
 	unsigned int seed;
-	time_t start;
 
 	if (bounces & BOUNCE_RANDOM) {
 		seed = (unsigned int) time(NULL) - bounces;
@@ -605,7 +604,6 @@ static void *locking_thread(void *arg)
 			page_nr += 1;
 		page_nr %= nr_pages;
 
-		start = time(NULL);
 		if (bounces & BOUNCE_VERIFY) {
 			count = *area_count(area_dst, page_nr);
 			if (!count) {
@@ -668,12 +666,6 @@ static void *locking_thread(void *arg)
 		count++;
 		*area_count(area_dst, page_nr) = count_verify[page_nr] = count;
 		pthread_mutex_unlock(area_mutex(area_dst, page_nr));
-
-		if (time(NULL) - start > 1)
-			fprintf(stderr,
-				"userfault too slow %ld "
-				"possible false positive with overcommit\n",
-				time(NULL) - start);
 	}
 
 	return NULL;
-- 
2.26.2

