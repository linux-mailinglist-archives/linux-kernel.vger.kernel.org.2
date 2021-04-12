Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7768D35D3F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 01:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344146AbhDLX2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 19:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36903 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344128AbhDLX2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618270080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/U3KIKw69dWx5abbn2bssM3+MYf5zUQ82LjGJH8Cvss=;
        b=M/Ftzpob6Zj4rHj4NMoPeIVML/vbkEaWYdT3DH6wDRYE0QQTrHtyGfxqj8x+CDP3xV/n2I
        Jpy3FTg1mCRVJ+48u55y+ldx+qgrYE51NsvBAMap1mTp9cZsVyEhd4FYcIQI1ExaycBH+E
        Ik9H+3GP6lLEj5couqxTYywG7QtbO6M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-NC55F2U5OiujmWhJSsBSNg-1; Mon, 12 Apr 2021 19:27:59 -0400
X-MC-Unique: NC55F2U5OiujmWhJSsBSNg-1
Received: by mail-qt1-f199.google.com with SMTP id f20so188776qtq.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/U3KIKw69dWx5abbn2bssM3+MYf5zUQ82LjGJH8Cvss=;
        b=TEyYjv10gjiZUdCbIG/wfpvDesDm26EfpYnLPPNloyfDK2aKXRCJHMvpgd9D8E/lK4
         tAzAH+D1ALJCHvhj004G17b9bbkQ1aIYqD+n1rOkaxOQNmGeapBvAAbqOGLrim6xJtHU
         TpqChn2rFbGtKuOt7BaChpGi0qd1WFPAJ17ez2xlpTrUTcuLsCv5MP2gPf6/LYzeAzVZ
         KXNIoGq1bMwp5MDU6kZNZJ1qbOQUPZ3eLy+LUBUzwAB4QgQKYOraqtlPm7+rZH8E42aC
         3kxwe+glUNmVAPAFs8/SouN4Th89oiRiJm6YSbFLrwdEw4ZKd2JLIB4owXeNSGz83L3t
         PmUw==
X-Gm-Message-State: AOAM533b8/Z4NTEcw+BdKy2t5IUQL7qTGdxD1K1UD8D7Z1YiIIxI/7es
        RcqG+fxoUh3kLbM3hvidSe85fotQ7RmK5L4047M4lXYw7a9ZcqeStpGtzajCYrJsjvvA5E6s4KS
        emYPMkMfDUci67QNdh2LPMYdS
X-Received: by 2002:ac8:7dce:: with SMTP id c14mr27594273qte.82.1618270078765;
        Mon, 12 Apr 2021 16:27:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW3JV/rb4lJVHgeg6Eo9vZH/0PbLS1F9Y9b6CV/zRlVvru2TFZeK7O+USZqeM2MwlYDhjkDQ==
X-Received: by 2002:ac8:7dce:: with SMTP id c14mr27594254qte.82.1618270078541;
        Mon, 12 Apr 2021 16:27:58 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id y29sm8958925qtm.13.2021.04.12.16.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 16:27:57 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v2 2/5] userfaultfd/selftests: Remove the time() check on delayed uffd
Date:   Mon, 12 Apr 2021 19:27:50 -0400
Message-Id: <20210412232753.1012412-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412232753.1012412-1-peterx@redhat.com>
References: <20210412232753.1012412-1-peterx@redhat.com>
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

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index ce23db8eec26..5cae66e27171 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -395,7 +395,6 @@ static void *locking_thread(void *arg)
 	unsigned long long count;
 	char randstate[64];
 	unsigned int seed;
-	time_t start;
 
 	if (bounces & BOUNCE_RANDOM) {
 		seed = (unsigned int) time(NULL) - bounces;
@@ -432,7 +431,6 @@ static void *locking_thread(void *arg)
 			page_nr += 1;
 		page_nr %= nr_pages;
 
-		start = time(NULL);
 		if (bounces & BOUNCE_VERIFY) {
 			count = *area_count(area_dst, page_nr);
 			if (!count) {
@@ -495,12 +493,6 @@ static void *locking_thread(void *arg)
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

