Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7A333292
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 01:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhCJAph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 19:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231341AbhCJApU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 19:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615337119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JFLVZpqIxshqGVHv9ZZ+a47BjDat3dahvnPbwqiCdNA=;
        b=BZZt4TRr+dA+X2FnrOq2fg/s+ix8JhdNLNiYKnU3b3WgeENwFto0BC/Eko44E0c56l9m7Y
        cVsN3z7cGK9RIW2MHqAERFsRH8NuYNcOQ/Q2Qq6qbkSlSPRD5ZhYonyJhIf22pQyqIwSQS
        cmbjMOri31N91ZkGTse7oxppoUt7o24=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-gniZXdfyM7i9skjeQaCZ1A-1; Tue, 09 Mar 2021 19:45:18 -0500
X-MC-Unique: gniZXdfyM7i9skjeQaCZ1A-1
Received: by mail-qt1-f197.google.com with SMTP id l63so8316037qtd.23
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 16:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFLVZpqIxshqGVHv9ZZ+a47BjDat3dahvnPbwqiCdNA=;
        b=BxNhlwMnqrzbkMHJRdj7dI3IJEsJbphJlnEpzWaRehLZVc4i+OkwzcgzQ0h2Q4bfC9
         mOLbRVG+wy006h3e1W4kdJ26gbQf1R91Vr594GILd0l/yt0dyGb/ZA9vCBbuWXM0sHTp
         CZCDgth4sNLGg80wwVRPhf/2fhpN2Az+pAZiFVekGIAl26Ds/xil19z3GgpGX+w4ap6G
         09VtxIwEtT7REs87PJi17ITkD2aUqW8HCQvGW7cMsqzcX8EuFIPzWoxA9lqvJRiSk7/2
         Fq3MxMwOY/6a+orlgG1Op2Sas4N2CltGpDgfCyAcss6Da6+Vryf2VyNoGTeKgvDAP139
         dctQ==
X-Gm-Message-State: AOAM533mPsQBohw8DIygfu/8bu8GyDVflgVP7Qs6tefnE7uzMxxZ51QU
        /Xp4Li9hUzj9ZIPp1IdujxHgDKWi7sa13CiW7zwnOhOUSxAs0lPATiJhtQRy56FWuIHYW0hEuSD
        IiYfKZKcKCftN+zpSv+pLedr3
X-Received: by 2002:a05:6214:10e7:: with SMTP id q7mr791953qvt.16.1615337117801;
        Tue, 09 Mar 2021 16:45:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw69PXyQlAxcv3DEZcnxIe9QzVj/xgqSFlWClb3XudYfugJ8Jk+oygEdtYP4Lr4LywifoLsEw==
X-Received: by 2002:a05:6214:10e7:: with SMTP id q7mr791941qvt.16.1615337117618;
        Tue, 09 Mar 2021 16:45:17 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id b27sm11418173qkl.102.2021.03.09.16.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 16:45:17 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 4/5] userfaultfd/selftests: Only dump counts if mode enabled
Date:   Tue,  9 Mar 2021 19:45:10 -0500
Message-Id: <20210310004511.51996-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310004511.51996-1-peterx@redhat.com>
References: <20210310004511.51996-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WP and MINOR modes are conditionally enabled on specific memory types.  This
patch avoids dumping tons of zeros for those cases when the modes are not
supported at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 30 ++++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index cf0cd4cb327d..5f89d258024a 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -173,16 +173,26 @@ static void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
 		minor_total += stats[i].minor_faults;
 	}
 
-	printf("userfaults: %llu missing (", miss_total);
-	for (i = 0; i < n_cpus; i++)
-		printf("%lu+", stats[i].missing_faults);
-	printf("\b), %llu wp (", wp_total);
-	for (i = 0; i < n_cpus; i++)
-		printf("%lu+", stats[i].wp_faults);
-	printf("\b), %llu minor (", minor_total);
-	for (i = 0; i < n_cpus; i++)
-		printf("%lu+", stats[i].minor_faults);
-	printf("\b)\n");
+	printf("userfaults: ");
+	if (miss_total) {
+		printf("%llu missing (", miss_total);
+		for (i = 0; i < n_cpus; i++)
+			printf("%lu+", stats[i].missing_faults);
+		printf("\b) ");
+	}
+	if (wp_total) {
+		printf("%llu wp (", wp_total);
+		for (i = 0; i < n_cpus; i++)
+			printf("%lu+", stats[i].wp_faults);
+		printf("\b) ");
+	}
+	if (minor_total) {
+		printf("%llu minor (", minor_total);
+		for (i = 0; i < n_cpus; i++)
+			printf("%lu+", stats[i].minor_faults);
+		printf("\b)");
+	}
+	printf("\n");
 }
 
 static int anon_release_pages(char *rel_area)
-- 
2.26.2

