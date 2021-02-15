Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750FE31C3C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 22:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBOVpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 16:45:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhBOVp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 16:45:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C01D64DEB;
        Mon, 15 Feb 2021 21:44:48 +0000 (UTC)
Date:   Mon, 15 Feb 2021 16:44:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] ftrace: Do not reference symbols in sections without size
Message-ID: <20210215164446.530f6311@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Starting with binutils 2.36, sections were being removed if they had weak
functions that were optimized out. Unfortunately, these weak functions would
leave references to mcount/fentry calls, that would make recordmcount fail
to find the symbol that matched the call to fentry.

Before returning the symbol of the section to create the mcount location,
check if that section size is greater than zero. If it has no size, skip
referencing that mcount call location.

Link: https://lore.kernel.org/lkml/YCafKVSTX9MxDBMd@kroah.com/

Cc: stable@vger.kernel.org
[ Backport as far as it can go ]
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/recordmcount.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index f9b19524da11..1a29f290092d 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -562,7 +562,8 @@ static char const * __has_rel_mcount(Elf_Shdr const *const relhdr, /* reltype */
 	if (w(txthdr->sh_type) != SHT_PROGBITS ||
 	    !(_w(txthdr->sh_flags) & SHF_EXECINSTR))
 		return NULL;
-	return txtname;
+	/* If the section has no size, then it wont be available for reference */
+	return shdr0->sh_size ? txtname : NULL;
 }
 
 static char const *has_rel_mcount(Elf_Shdr const *const relhdr,
-- 
2.25.4

