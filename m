Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11544214D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbhJDRKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233329AbhJDRKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633367298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A/QyaM5fvv8aT6A0eU2VrGN90IZzg0QK4hBAP9okwtQ=;
        b=SxqJCurFjtzOrZnGZzZwSwZtzUFglcT1tFNnaCQ7o7w5a2cwGNX0lElA8QfXFxI9WYUW0u
        Go3Z1IuNGkiENw+owXogxUre7+E7UMwI58Ac7sAq5joMQd60IZwPEGJs3+rNHzUjGyoP41
        bjtwKRFuatsfyqQn1TssCu3Z8oGV06Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-ycjfyLgXO7G9fnSA7oVn-Q-1; Mon, 04 Oct 2021 13:08:17 -0400
X-MC-Unique: ycjfyLgXO7G9fnSA7oVn-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8550D8464CE;
        Mon,  4 Oct 2021 17:08:16 +0000 (UTC)
Received: from treble.attlocal.net (unknown [10.22.19.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F8B8608BA;
        Mon,  4 Oct 2021 17:08:15 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] objtool: Remove reloc symbol type checks in get_alt_entry()
Date:   Mon,  4 Oct 2021 10:07:50 -0700
Message-Id: <feadbc3dfb3440d973580fad8d3db873cbfe1694.1633367242.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting a special section's relocation reference to a symbol is
straightforward.  No need for objtool to complain that it doesn't know
how to handle it.  Just handle it.

This fixes the following warning:

  arch/x86/kvm/emulate.o: warning: objtool: __ex_table+0x4: don't know how to handle reloc symbol type: kvm_fastop_exception

Fixes: 24ff65257375 ("objtool: Teach get_alt_entry() about more relocation types")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/special.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index f58ecc50fb10..83d5f969bcb0 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -58,22 +58,11 @@ void __weak arch_handle_alternative(unsigned short feature, struct special_alt *
 {
 }
 
-static bool reloc2sec_off(struct reloc *reloc, struct section **sec, unsigned long *off)
+static void reloc_to_sec_off(struct reloc *reloc, struct section **sec,
+			     unsigned long *off)
 {
-	switch (reloc->sym->type) {
-	case STT_FUNC:
-		*sec = reloc->sym->sec;
-		*off = reloc->sym->offset + reloc->addend;
-		return true;
-
-	case STT_SECTION:
-		*sec = reloc->sym->sec;
-		*off = reloc->addend;
-		return true;
-
-	default:
-		return false;
-	}
+	*sec = reloc->sym->sec;
+	*off = reloc->sym->offset + reloc->addend;
 }
 
 static int get_alt_entry(struct elf *elf, struct special_entry *entry,
@@ -109,11 +98,8 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		WARN_FUNC("can't find orig reloc", sec, offset + entry->orig);
 		return -1;
 	}
-	if (!reloc2sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off)) {
-		WARN_FUNC("don't know how to handle reloc symbol type: %s",
-			   sec, offset + entry->orig, orig_reloc->sym->name);
-		return -1;
-	}
+
+	reloc_to_sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off);
 
 	if (!entry->group || alt->new_len) {
 		new_reloc = find_reloc_by_dest(elf, sec, offset + entry->new);
@@ -131,11 +117,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		if (arch_is_retpoline(new_reloc->sym))
 			return 1;
 
-		if (!reloc2sec_off(new_reloc, &alt->new_sec, &alt->new_off)) {
-			WARN_FUNC("don't know how to handle reloc symbol type: %s",
-				  sec, offset + entry->new, new_reloc->sym->name);
-			return -1;
-		}
+		reloc_to_sec_off(new_reloc, &alt->new_sec, &alt->new_off);
 
 		/* _ASM_EXTABLE_EX hack */
 		if (alt->new_off >= 0x7ffffff0)
-- 
2.31.1

