Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D2C318379
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBKCLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:11:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhBKCLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:11:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63C6F64ED7;
        Thu, 11 Feb 2021 02:09:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lA1QT-00BAW9-DS; Wed, 10 Feb 2021 21:09:49 -0500
Message-ID: <20210211020949.299616762@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Feb 2021 21:09:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 06/12] kprobes: Warn if the kprobe is reregistered
References: <20210211020927.829775774@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Warn if the kprobe is reregistered, since there must be
a software bug (actively used resource must not be re-registered)
and caller must be fixed.

Link: https://lkml.kernel.org/r/161236436734.194052.4058506306336814476.stgit@devnote2

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/kprobes.c | 13 ++++++++-----
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
-- 
2.29.2


