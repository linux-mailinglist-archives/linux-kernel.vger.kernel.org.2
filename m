Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CF5375BE9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhEFTpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbhEFTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8796C061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/dwqWT5ro5xWiJacMRwu0+Up2iMK1i0GsK3TysLBUoE=; b=piq8PoEnijMN0wfARNYBRRBNra
        bNrrL0lHTS2wkmdMuuqP1PDGOu3NZkjH4p5/Aifc1LaiIU91pm4MdbrDOED3PwE7hyu0sV1a7XE9w
        mu0DUqcVd2Y/iXfxVIGTHkHcjxMJlD47RNgM6QX6sHL69Izoan2gO6kt0LrNFBf0FCP/4pQvxcshZ
        SjYThiUrUNeP2w4MoRSp9cNG5UOUwWeHNMDH7j1h9TowzKFqZP7GNEKcQph8H5+QNM1MaMp9ndXxD
        pzYbkqTbyNK3g03bQq3JtHjUF8B4iv98r8z5QOQP115watoUOWJ9G9uOqQJMSQ3o7h2/fE5l5+leX
        qaYt5e1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtT-002ADH-66; Thu, 06 May 2021 19:42:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FA1A30035F;
        Thu,  6 May 2021 21:42:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C40B620B96F90; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506194158.028024143@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:34:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 10/13] objtool: Decode jump_entry::key addend
References: <20210506193352.719596001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach objtool about the the low bits in the struct static_key pointer.

That is, the low two bits of @key in:

  struct jump_entry {
	s32 code;
	s32 target;
	long key;
  }

as found in the __jump_table section. Since @key has a relocation to
the variable (to be resolved by the linker), the low two bits will be
reflected in the relocation's addend.

As such, find the reloc and store the addend, such that we can access
these bits.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/include/arch/special.h |    1 +
 tools/objtool/include/objtool/special.h       |    1 +
 tools/objtool/special.c                       |   14 ++++++++++++++
 3 files changed, 16 insertions(+)

--- a/tools/objtool/arch/x86/include/arch/special.h
+++ b/tools/objtool/arch/x86/include/arch/special.h
@@ -9,6 +9,7 @@
 #define JUMP_ENTRY_SIZE		16
 #define JUMP_ORIG_OFFSET	0
 #define JUMP_NEW_OFFSET		4
+#define JUMP_KEY_OFFSET		8
 
 #define ALT_ENTRY_SIZE		12
 #define ALT_ORIG_OFFSET		0
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -27,6 +27,7 @@ struct special_alt {
 	unsigned long new_off;
 
 	unsigned int orig_len, new_len; /* group only */
+	u8 key_addend;
 };
 
 int special_get_alts(struct elf *elf, struct list_head *alts);
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -23,6 +23,7 @@ struct special_entry {
 	unsigned char size, orig, new;
 	unsigned char orig_len, new_len; /* group only */
 	unsigned char feature; /* ALTERNATIVE macro CPU feature */
+	unsigned char key; /* jump_label key */
 };
 
 struct special_entry entries[] = {
@@ -42,6 +43,7 @@ struct special_entry entries[] = {
 		.size = JUMP_ENTRY_SIZE,
 		.orig = JUMP_ORIG_OFFSET,
 		.new = JUMP_NEW_OFFSET,
+		.key = JUMP_KEY_OFFSET,
 	},
 	{
 		.sec = "__ex_table",
@@ -122,6 +124,18 @@ static int get_alt_entry(struct elf *elf
 			alt->new_off -= 0x7ffffff0;
 	}
 
+	if (entry->key) {
+		struct reloc *key_reloc;
+
+		key_reloc = find_reloc_by_dest(elf, sec, offset + entry->key);
+		if (!key_reloc) {
+			WARN_FUNC("can't find key reloc",
+				  sec, offset + entry->key);
+			return -1;
+		}
+		alt->key_addend = key_reloc->addend;
+	}
+
 	return 0;
 }
 


