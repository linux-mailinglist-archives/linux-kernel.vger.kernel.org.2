Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB83101D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhBEArl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:47:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:38074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232132AbhBEArf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:47:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0509CB03B;
        Fri,  5 Feb 2021 00:46:54 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 05 Feb 2021 11:36:30 +1100
Subject: [PATCH 2/3] x86: fix seq_file iteration for pat/memtype.c
Cc:     Xin Long <lucien.xin@gmail.com>, linux-kernel@vger.kernel.org
Message-ID: <161248539022.21478.13874455485854739066.stgit@noble1>
In-Reply-To: <161248518659.21478.2484341937387294998.stgit@noble1>
References: <161248518659.21478.2484341937387294998.stgit@noble1>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memtype seq_file iterator allocates a buffer in the ->start and
->next functions and frees it in the ->show function.
The preferred handling for such resources is to free them in the
subsequent ->next or ->stop function call.

Since Commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration
code and interface") there is no guarantee that ->show will be called
after ->next, so this function can now leak memory.

So move the freeing of the buffer to ->next and ->stop.

Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
Cc: Xin Long <lucien.xin@gmail.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 arch/x86/mm/pat/memtype.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 8f665c352bf0..ca311aaa67b8 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -1164,12 +1164,14 @@ static void *memtype_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *memtype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
+	kfree(v);
 	++*pos;
 	return memtype_get_idx(*pos);
 }
 
 static void memtype_seq_stop(struct seq_file *seq, void *v)
 {
+	kfree(v);
 }
 
 static int memtype_seq_show(struct seq_file *seq, void *v)
@@ -1181,8 +1183,6 @@ static int memtype_seq_show(struct seq_file *seq, void *v)
 			entry_print->end,
 			cattr_name(entry_print->type));
 
-	kfree(entry_print);
-
 	return 0;
 }
 


