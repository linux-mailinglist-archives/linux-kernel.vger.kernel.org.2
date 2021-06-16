Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E3A3A9DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhFPOou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:44:50 -0400
Received: from pv50p00im-zteg10011401.me.com ([17.58.6.41]:60763 "EHLO
        pv50p00im-zteg10011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233919AbhFPOot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1623854562; bh=GfaSmL1QsKEY/ERc3OVL+uPlFioWiHdEBrWy0bXGwiU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=kbBE+9kVOTPhOo+47S9ODDd1/MPo1/7r0eEPnJIWqHP1C5kVidP+GNq0eQFIDWOkJ
         N9BI83mtjoMqDvuxCZbQURZAz+qnZrkRMBfEgpp3kQg9yfAMMpEu/hlXHuSYceWWpp
         7AONLJ1sFjSuOSs6AQhwuXH3KKAJfBjsO2SXlcuEDL6hLzFIwOk6eY7uvQ+eng6f8L
         D/c5GpapXKChcWzZyH9SL4OCkDjaXShD3fu+3ECA6y8SWofMbu82vNAsblH7AnuMdE
         4SxkJvW/BWeJ4hlmWreTuhjZLlYnR5wNCqc5W178n52bZj+Mvpcl+6yXO98MD/eaim
         pulzAtJ9g207Q==
Received: from xiongwei.. (unknown [120.245.2.120])
        by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id E3AE090057A;
        Wed, 16 Jun 2021 14:42:39 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH] locking/lockdep: print possible warning after counting deps
Date:   Wed, 16 Jun 2021 22:42:10 +0800
Message-Id: <20210616144210.278662-2-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616144210.278662-1-sxwjean@me.com>
References: <20210616144210.278662-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-16_07:2021-06-15,2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=778 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106160085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

The graph walk might hit error when counting dependencies. Once the
return value is negative, print a warning to reminder users.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 kernel/locking/lockdep.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7641bd407239..074fd6418c20 100644
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
+	if (unlikely(bfs_error(ret)))
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
+	if (unlikely(bfs_error(ret)))
+		print_bfs_bug(ret);
 
 	return count;
 }
-- 
2.30.2

