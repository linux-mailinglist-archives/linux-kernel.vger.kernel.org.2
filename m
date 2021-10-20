Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5715B434999
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhJTLD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJTLDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:03:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767BFC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8kDZVERolORkFGbEFI3gQAAb9SpVjedaRkguUav/LRc=; b=qj1LDCI12zwk5FZPZhMGnRWtsh
        GqYfvX2nXGxE7j8aOV+q0T46rBdpwpqsG5gqlTtsy/a+uy0GAAlj85dfNGU7zD7grWf36Eeo68rYC
        eiEhnU5eo8Wso7nnlfgZ4sQBZpzQDLV9m5RO17vmcQiP6t6wFAg7A5LKcnwpqQzyVpl0yUysC+sX0
        678svjqijx6NXUSlsUZj/YjtjqYb2ddPDk8RP6jX0O+HXOYkm7IOermjI6RdHY87o8v+LcesO8H94
        F14Qiq/4p+hCiIDsTU6WQStXBPVLNrfgVduK1vlQw4L/6Jz0YC1tpu76jQda+1+Gk8LNzQh8+6oiM
        z1EYCu8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9L0-00Aw0y-RS; Wed, 20 Oct 2021 11:00:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 07B8B3004E7;
        Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E2616201BB3C7; Wed, 20 Oct 2021 13:00:49 +0200 (CEST)
Message-ID: <20211020105842.678003790@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 20 Oct 2021 12:44:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH v2 03/14] objtool: Shrink struct instruction
References: <20211020104442.021802560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any one instruction can only ever call a single function, therefore
insn->mcount_loc_node is superfluous and can use insn->call_node.

This shrinks struct instruction, which is by far the most numerous
structure objtool creates.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c                 |    6 +++---
 tools/objtool/include/objtool/check.h |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -701,7 +701,7 @@ static int create_mcount_loc_sections(st
 		return 0;
 
 	idx = 0;
-	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node)
+	list_for_each_entry(insn, &file->mcount_loc_list, call_node)
 		idx++;
 
 	sec = elf_create_section(file->elf, "__mcount_loc", 0, sizeof(unsigned long), idx);
@@ -709,7 +709,7 @@ static int create_mcount_loc_sections(st
 		return -1;
 
 	idx = 0;
-	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node) {
+	list_for_each_entry(insn, &file->mcount_loc_list, call_node) {
 
 		loc = (unsigned long *)sec->data->d_buf + idx;
 		memset(loc, 0, sizeof(unsigned long));
@@ -1049,7 +1049,7 @@ static void annotate_call_site(struct ob
 
 		insn->type = INSN_NOP;
 
-		list_add_tail(&insn->mcount_loc_node, &file->mcount_loc_list);
+		list_add_tail(&insn->call_node, &file->mcount_loc_list);
 		return;
 	}
 }
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -40,7 +40,6 @@ struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
 	struct list_head call_node;
-	struct list_head mcount_loc_node;
 	struct section *sec;
 	unsigned long offset;
 	unsigned int len;


