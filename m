Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C533AB602
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhFQObd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:31:33 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42]:53856 "EHLO
        pv50p00im-zteg10011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232588AbhFQOb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1623940159; bh=48jYlHHtDDHkWHfxggM04atL+5HJ384LjyBoX+V1N5Q=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=AJmZG2ZZXS8/uQlbAJRQe5jEyct5Z4juXnWrX0RAO3H2OOfC3nE4w9ATtrRfIyNs9
         CsLt/rBGs8BDqoEycHpzVSjAunJvLiKlQX3yPDM7OLec6ATocy75UXOUIhFDfEV5Z2
         VJmRgbfY+4+DGthaAWj6r9J5DwUm47mfRPkQ+8H+9Ix46UEGP7wHX09xDThf7/Kh5H
         qFd1FF1U6mWWkALff8r1QVFzr6NYg50mA4fUZkVOoaKlLaTt33HRuKl+Eo9Id0XevJ
         LdNQA5cMx9LmynFgQ8xKxC6zY5iIieOJUi3plM8tZBref7G9noyDfIiD1Qy/kXTXRe
         /U3A2sqS8/PdA==
Received: from xiongwei.. (unknown [120.245.2.120])
        by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 7D4F6B00487;
        Thu, 17 Jun 2021 14:29:16 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH 3/3] locking/lockdep: print possible warning after counting deps
Date:   Thu, 17 Jun 2021 22:28:28 +0800
Message-Id: <20210617142828.346111-4-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617142828.346111-1-sxwjean@me.com>
References: <20210617142828.346111-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_13:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=822 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106170092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

The graph walk might hit error when counting dependencies. Once the
return value is negative, print a warning to reminder users.

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 kernel/locking/lockdep.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index cb94097014d8..cfe0f4374594 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2028,8 +2028,12 @@ static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
 {
 	unsigned long  count = 0;
 	struct lock_list *target_entry;
+	enum bfs_result ret;
+
+	ret = __bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
 
-	__bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
+	if (bfs_error(ret))
+		print_bfs_bug(ret);
 
 	return count;
 }
@@ -2053,8 +2057,12 @@ static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
 {
 	unsigned long  count = 0;
 	struct lock_list *target_entry;
+	enum bfs_result ret;
+
+	ret = __bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
 
-	__bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
+	if (bfs_error(ret))
+		print_bfs_bug(ret);
 
 	return count;
 }
-- 
2.30.2

