Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF1745F009
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377868AbhKZOmz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Nov 2021 09:42:55 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:24031 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354012AbhKZOkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:40:52 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-0Zn4drRhNQSllGQS78exeg-1; Fri, 26 Nov 2021 09:37:36 -0500
X-MC-Unique: 0Zn4drRhNQSllGQS78exeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D67CA1006AA2;
        Fri, 26 Nov 2021 14:37:34 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85C6C60C04;
        Fri, 26 Nov 2021 14:37:33 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Subject: [PATCH v1 1/2] ucounts: Fix rlimit max values check
Date:   Fri, 26 Nov 2021 15:37:26 +0100
Message-Id: <024ec805f6e16896f0b23e094773790d171d2c1c.1637934917.git.legion@kernel.org>
In-Reply-To: <cover.1637934917.git.legion@kernel.org>
References: <cover.1637934917.git.legion@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=legion@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semantics of the rlimit max values differs from ucounts itself. When
creating a new userns, we store the current rlimit of the process in
ucount_max. Thus, the value of the limit in the parent userns is saved
in the created one.

The problem is that now we are taking the maximum value for counter from
the same userns. So for init_user_ns it will always be RLIM_INFINITY.

To fix the problem we need to check the counter value with the max value
stored in userns.

Reproducer:

su - test -c "ulimit -u 3; sleep 5 & sleep 6 & unshare -U --map-root-user sh -c 'sleep 7 & sleep 8 & date; wait'"

Before:

[1] 175
[2] 176
Fri Nov 26 13:48:20 UTC 2021
[1]-  Done                    sleep 5
[2]+  Done                    sleep 6

After:

[1] 167
[2] 168
sh: fork: retry: Resource temporarily unavailable
sh: fork: retry: Resource temporarily unavailable
sh: fork: retry: Resource temporarily unavailable
sh: fork: retry: Resource temporarily unavailable
sh: fork: retry: Resource temporarily unavailable
sh: fork: retry: Resource temporarily unavailable
sh: fork: retry: Resource temporarily unavailable
sh: fork: Interrupted system call
[1]-  Done                    sleep 5
[2]+  Done                    sleep 6

Fixes: c54b245d0118 ("Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace")
Reported-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 kernel/ucount.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 4f5613dac227..7b32c356ebc5 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -264,15 +264,16 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
 long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
 {
 	struct ucounts *iter;
+	long max = LONG_MAX;
 	long ret = 0;
 
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		long max = READ_ONCE(iter->ns->ucount_max[type]);
 		long new = atomic_long_add_return(v, &iter->ucount[type]);
 		if (new < 0 || new > max)
 			ret = LONG_MAX;
 		else if (iter == ucounts)
 			ret = new;
+		max = READ_ONCE(iter->ns->ucount_max[type]);
 	}
 	return ret;
 }
@@ -312,15 +313,16 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
 {
 	/* Caller must hold a reference to ucounts */
 	struct ucounts *iter;
+	long max = LONG_MAX;
 	long dec, ret = 0;
 
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		long max = READ_ONCE(iter->ns->ucount_max[type]);
 		long new = atomic_long_add_return(1, &iter->ucount[type]);
 		if (new < 0 || new > max)
 			goto unwind;
 		if (iter == ucounts)
 			ret = new;
+		max = READ_ONCE(iter->ns->ucount_max[type]);
 		/*
 		 * Grab an extra ucount reference for the caller when
 		 * the rlimit count was previously 0.
@@ -339,15 +341,16 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
 	return 0;
 }
 
-bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max)
+bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long rlimit)
 {
 	struct ucounts *iter;
-	if (get_ucounts_value(ucounts, type) > max)
-		return true;
+	long max = rlimit;
+	if (rlimit > LONG_MAX)
+		max = LONG_MAX;
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		max = READ_ONCE(iter->ns->ucount_max[type]);
 		if (get_ucounts_value(iter, type) > max)
 			return true;
+		max = READ_ONCE(iter->ns->ucount_max[type]);
 	}
 	return false;
 }
-- 
2.33.0

