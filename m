Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C06630DD6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhBCPAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233002AbhBCPAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:00:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9835464F60;
        Wed,  3 Feb 2021 14:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612364371;
        bh=eR80RgfFYxpw8uTlLQWDfNOedWdFdvjd+BmXvyBOF7M=;
        h=From:To:Cc:Subject:Date:From;
        b=dIO/cyRQO8SLlfVPsvnD/467jFQv7RlxdrxPip6hP9B2EGbwZO48DgLULPnv6cmXe
         nT7p1Zk2dJXyUposOF14X2tZJEDLEHyI/PFWGwBW1oyhXZ3oMn5b2hoaqWpfCjJAAd
         nPkXBKyzqv/cLnu874lHDm5uO1iSGkegmhuVHRySqpYHWe/8OkmkT6JWHDMi9tFu8b
         mHuVEUYGXtnOuC+fdLR+hoVFuAtTvlF91UGDGBUE4tugyCz9PGlcHFnjEwQKKZPhtc
         vW8yaE/XXtVXFIl+yDTN7oa2EdBSizSsemyoV4gS38x0mo7gCIyxauIpGT911KCdVv
         Rrd2aB8ZdK1+g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Cheng Jian <cj.chengjian@huawei.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: [PATCH] kprobes: Warn if the kprobe is reregistered
Date:   Wed,  3 Feb 2021 23:59:27 +0900
Message-Id: <161236436734.194052.4058506306336814476.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warn if the kprobe is reregistered, since there must be
a software bug (actively used resource must not be re-registered)
and caller must be fixed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d5a3eb74a657..dd1d027455c4 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1520,13 +1520,16 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
 	return ap;
 }
 
-/* Return error if the kprobe is being re-registered */
-static inline int check_kprobe_rereg(struct kprobe *p)
+/*
+ * Warn and return error if the kprobe is being re-registered since
+ * there must be a software bug.
+ */
+static inline int warn_kprobe_rereg(struct kprobe *p)
 {
 	int ret = 0;
 
 	mutex_lock(&kprobe_mutex);
-	if (__get_valid_kprobe(p))
+	if (WARN_ON_ONCE(__get_valid_kprobe(p)))
 		ret = -EINVAL;
 	mutex_unlock(&kprobe_mutex);
 
@@ -1614,7 +1617,7 @@ int register_kprobe(struct kprobe *p)
 		return PTR_ERR(addr);
 	p->addr = addr;
 
-	ret = check_kprobe_rereg(p);
+	ret = warn_kprobe_rereg(p);
 	if (ret)
 		return ret;
 
@@ -1995,7 +1998,7 @@ int register_kretprobe(struct kretprobe *rp)
 		return ret;
 
 	/* If only rp->kp.addr is specified, check reregistering kprobes */
-	if (rp->kp.addr && check_kprobe_rereg(&rp->kp))
+	if (rp->kp.addr && warn_kprobe_rereg(&rp->kp))
 		return -EINVAL;
 
 	if (kretprobe_blacklist_size) {

